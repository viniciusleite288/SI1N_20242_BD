DROP SCHEMA EST_IV;

CREATE SCHEMA EST_IV;

USE EST_IV;


CREATE TABLE IF NOT EXISTS ALUNOS (
COD_ALUNO INT PRIMARY KEY,
NOME VARCHAR(100) NOT NULL,
CPF INT,
DATA_NASCIMENTO DATE NOT NULL,
INT_MODALIDADE TEXT,
ALUNO_TELEFONE VARCHAR(20),
CIDADE_ALN VARCHAR(50),
ESTADO_ALN VARCHAR(50),
PAIS_ALN VARCHAR(50),
NUMRUA_ALN VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS INSTRUTORES (
COD_INSTRUTOR INT PRIMARY KEY,
NOME VARCHAR(100) NOT NULL,
CPF INT,
INSTRUTOR_TELEFONE VARCHAR(15),
ESPECIALIZACAO VARCHAR(100),
INSTRUTOR_EMAIL VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS MODALIDADES (
COD_MODALIDADE INT PRIMARY KEY,
NOME VARCHAR(100) NOT NULL,
DESCRICAO TEXT,
CAPACIDADE INT NOT NULL
);

CREATE TABLE IF NOT EXISTS PLANOS_TREINAMENTO (
COD_PLANO INT PRIMARY KEY,
ID_ALUNO INT NOT NULL,
ID_INSTRUTOR INT NOT NULL,
DESCRICAO TEXT,
DATA_CRIACAO DATE NOT NULL,
PLANO_OBJETIVO VARCHAR(500),
CONSTRAINT FK_PLAN_ALUNOS FOREIGN KEY (ID_ALUNO) REFERENCES ALUNOS(COD_ALUNO),
CONSTRAINT FK_PLAN_INSTRUTOR FOREIGN KEY (ID_INSTRUTOR) REFERENCES INSTRUTORES(COD_INSTRUTOR)
);

CREATE TABLE IF NOT EXISTS AULAS (
COD_AULA INT PRIMARY KEY,
ID_MODALIDADE INT NOT NULL,
DATA_AULA DATE NOT NULL,
INSTRUTOR_ID INT NOT NULL,
AULA_CAPACIDADE INT,
CONSTRAINT FK_AUL_MODALIDADES FOREIGN KEY (ID_MODALIDADE) REFERENCES MODALIDADES(COD_MODALIDADE),
CONSTRAINT FK_AUL_INSTRUTOR FOREIGN KEY (INSTRUTOR_ID) REFERENCES INSTRUTORES(COD_INSTRUTOR)
);

CREATE TABLE IF NOT EXISTS MATRICULAS (
COD_MATRICULA INT PRIMARY KEY,
ID_ALUNO INT NOT NULL,
ID_MODALIDADE INT NOT NULL,
DATA_MATRICULA DATE NOT NULL,
STATUS VARCHAR(20) NOT NULL,
CONSTRAINT FK_MATRICULA_ALUNO FOREIGN KEY (ID_ALUNO) REFERENCES ALUNOS(COD_ALUNO),
CONSTRAINT FK_MATRICULA_MODALIDADE FOREIGN KEY (ID_MODALIDADE) REFERENCES MODALIDADES(COD_MODALIDADE)
);

CREATE TABLE IF NOT EXISTS PAGAMENTOS (
COD_PAGAMENTO INT PRIMARY KEY,
ID_MATRICULA INT NOT NULL,
PAGAMENTO_VALOR DECIMAL(12, 2) NOT NULL,
DATA_PAGAMENTO DATE NOT NULL,
STATUS_PAGAMENTO VARCHAR(20) NOT NULL,
CONSTRAINT FK_PAGAMENTO_MATRICULA FOREIGN KEY (ID_MATRICULA) REFERENCES MATRICULAS(COD_MATRICULA)
);

CREATE TABLE IF NOT EXISTS ALUNOS_AULAS (
COD_AULA_ALUNO INT PRIMARY KEY,
ID_ALUNO INT NOT NULL,
COD_AULA INT NOT NULL,
CONSTRAINT FK_AULA_ALUNO FOREIGN KEY (ID_ALUNO) REFERENCES ALUNOS(COD_ALUNO),
CONSTRAINT FK_ALUNO_AULA FOREIGN KEY (COD_AULA) REFERENCES AULAS(COD_AULA)
);

CREATE TABLE IF NOT EXISTS AULAS_MATRICULAS (
COD_AULA_MATRICULA INT PRIMARY KEY,
COD_AULA INT NOT NULL,
COD_MATRICULA INT NOT NULL,
CONSTRAINT FK_AULA_MATRICULA FOREIGN KEY (COD_AULA) REFERENCES AULAS(COD_AULA),
CONSTRAINT FK_MATRICULA_AULA FOREIGN KEY (COD_MATRICULA) REFERENCES MATRICULAS(COD_MATRICULA)
);


#INICIO DAS ALTER TABLES!
ALTER TABLE ALUNOS 
ADD COLUMN NOME_COMPLETO VARCHAR(150); 
ALTER TABLE ALUNOS 
DROP COLUMN NOME_COMPLETO; 
ALTER TABLE ALUNOS 
MODIFY COLUMN ALUNO_TELEFONE VARCHAR(20);
ALTER TABLE ALUNOS 
CHANGE COLUMN ALUNO_TELEFONE TELEFONE_CONTATO_ALUN VARCHAR(255); 


ALTER TABLE INSTRUTORES ADD SEXO_INSTRUTOR ENUM('M', 'F');
ALTER TABLE INSTRUTORES 
DROP COLUMN ESPECIALIZACAO;
ALTER TABLE INSTRUTORES 
MODIFY COLUMN INSTRUTOR_TELEFONE VARCHAR(20);
ALTER TABLE INSTRUTORES 
CHANGE COLUMN INSTRUTOR_EMAIL EMAIL_CONTATO_INTR VARCHAR(100);


ALTER TABLE MODALIDADES 
ADD COLUMN DIFICULDADE ENUM('iniciante', 'intermediário', 'avançado');
ALTER TABLE MODALIDADES 
DROP COLUMN DIFICULDADE;
ALTER TABLE MODALIDADES 
MODIFY COLUMN CAPACIDADE VARCHAR(500);
ALTER TABLE MODALIDADES 
CHANGE COLUMN NOME NOME_DA_MODALIDADE VARCHAR(50);


ALTER TABLE PLANOS_TREINAMENTO
ADD COLUMN PLANO_OBSERVACOES TEXT;
ALTER TABLE PLANOS_TREINAMENTO
DROP COLUMN PLANO_OBSERVACOES;
ALTER TABLE PLANOS_TREINAMENTO
MODIFY COLUMN PLANO_OBJETIVO VARCHAR(500);
ALTER TABLE PLANOS_TREINAMENTO
CHANGE COLUMN PLANO_OBJETIVO DESCRICAO_OBJETIVO VARCHAR(500);


ALTER TABLE AULAS
ADD COLUMN AULA_SALA INT; 
ALTER TABLE AULAS
DROP COLUMN AULA_SALA; 
ALTER TABLE AULAS
MODIFY COLUMN AULA_CAPACIDADE INT UNSIGNED; 
ALTER TABLE AULAS 
CHANGE COLUMN AULA_CAPACIDADE TOTAL_CAPACIDADE INT UNSIGNED; 


ALTER TABLE PAGAMENTOS
ADD COLUMN METODO_PAGAMENTO ENUM('cartao', 'boleto', 'dinheiro');
ALTER TABLE PAGAMENTOS
DROP COLUMN METODO_PAGAMENTO; 
ALTER TABLE PAGAMENTOS 
MODIFY COLUMN PAGAMENTO_VALOR DECIMAL(12, 2); 
ALTER TABLE PAGAMENTOS 
CHANGE COLUMN STATUS_PAGAMENTO SITUACAO_PAGAMENTO ENUM('pago', 'pendente');
ALTER TABLE MATRICULAS 


ADD COLUMN STATUS_MATRICULA ENUM('ativa', 'cancelada');
ALTER TABLE MATRICULAS 
DROP COLUMN STATUS_MATRICULA; 
ALTER TABLE MATRICULAS 
MODIFY COLUMN DATA_MATRICULA DATE NOT NULL; 
ALTER TABLE MATRICULAS 
CHANGE COLUMN DATA_MATRICULA DATA_DE_MATRICULA DATE NOT NULL; 