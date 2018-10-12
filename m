Received: from eggs.gnu.org ([2001:4830:134:3::10]:39680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1HO-0001cz-WD
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1HM-0008Re-Oq
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:14 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:37102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gB1HM-0008Qv-Df
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:12 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 12 Oct 2018 19:30:25 +0200
Message-Id: <20181012173047.25420-7-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/28] target/riscv: Convert RVXI csr insns to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de
Cc: qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn32.decode              |  8 +++
 target/riscv/insn_trans/trans_rvi.inc.c | 79 +++++++++++++++++++++++++
 target/riscv/translate.c                | 43 +-------------
 3 files changed, 88 insertions(+), 42 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 695577b19b..dbb177395d 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -23,6 +23,7 @@
 
 %sh6    20:6
 %sh5    20:5
+%csr    20:12
 
 %pred   24:4
 %succ   20:4
@@ -51,6 +52,7 @@
 @sh6     ......  ...... .....  ... ..... ....... &shift  shamt=%sh6      %rs1 %rd
 @sh5     .......  ..... .....  ... ..... ....... &shift  shamt=%sh5      %rs1 %rd
 @fence   .... .... .... .....  ... ..... ....... %pred %succ
+@csr     ............   .....  ... ..... .......               %csr     %rs1 %rd
 
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
@@ -92,6 +94,12 @@ or       0000000 .....    ..... 110 ..... 0110011 @r
 and      0000000 .....    ..... 111 ..... 0110011 @r
 fence    0000 .... ....   00000 000 00000 0001111 @fence
 fence_i  000000000000     00000 001 00000 0001111 @noargs
+csrrw    ............     ..... 001 ..... 1110011 @csr
+csrrs    ............     ..... 010 ..... 1110011 @csr
+csrrc    ............     ..... 011 ..... 1110011 @csr
+csrrwi   ............     ..... 101 ..... 1110011 @csr
+csrrsi   ............     ..... 110 ..... 1110011 @csr
+csrrci   ............     ..... 111 ..... 1110011 @csr
 
 # *** RV64I Base Instruction Set (in addition to RV32I) ***
 lwu      ............   ..... 110 ..... 0000011 @i
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index f532ca48e8..f5abec9b55 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -397,3 +397,82 @@ static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a, uint32_t insn)
 #endif
     return true;
 }
+
+#define RISCV_OP_CSR_PRE do {\
+    source1 = tcg_temp_new(); \
+    csr_store = tcg_temp_new(); \
+    dest = tcg_temp_new(); \
+    rs1_pass = tcg_temp_new(); \
+    gen_get_gpr(source1, a->rs1); \
+    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next); \
+    tcg_gen_movi_tl(rs1_pass, a->rs1); \
+    tcg_gen_movi_tl(csr_store, a->csr); \
+    gen_io_start();\
+} while (0)
+
+#define RISCV_OP_CSR_POST do {\
+    gen_io_end(); \
+    gen_set_gpr(a->rd, dest); \
+    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn); \
+    tcg_gen_exit_tb(NULL, 0); \
+    ctx->base.is_jmp = DISAS_NORETURN; \
+    tcg_temp_free(source1); \
+    tcg_temp_free(csr_store); \
+    tcg_temp_free(dest); \
+    tcg_temp_free(rs1_pass); \
+} while (0)
+
+
+static bool trans_csrrw(DisasContext *ctx, arg_csrrw *a, uint32_t insn)
+{
+    TCGv source1, csr_store, dest, rs1_pass;
+    RISCV_OP_CSR_PRE;
+    gen_helper_csrrw(dest, cpu_env, source1, csr_store);
+    RISCV_OP_CSR_POST;
+    return true;
+}
+
+static bool trans_csrrs(DisasContext *ctx, arg_csrrs *a, uint32_t insn)
+{
+    TCGv source1, csr_store, dest, rs1_pass;
+    RISCV_OP_CSR_PRE;
+    gen_helper_csrrs(dest, cpu_env, source1, csr_store, rs1_pass);
+    RISCV_OP_CSR_POST;
+    return true;
+}
+
+static bool trans_csrrc(DisasContext *ctx, arg_csrrc *a, uint32_t insn)
+{
+    TCGv source1, csr_store, dest, rs1_pass;
+    RISCV_OP_CSR_PRE;
+    gen_helper_csrrc(dest, cpu_env, source1, csr_store, rs1_pass);
+    RISCV_OP_CSR_POST;
+    return true;
+}
+
+static bool trans_csrrwi(DisasContext *ctx, arg_csrrwi *a, uint32_t insn)
+{
+    TCGv source1, csr_store, dest, rs1_pass;
+    RISCV_OP_CSR_PRE;
+    gen_helper_csrrw(dest, cpu_env, rs1_pass, csr_store);
+    RISCV_OP_CSR_POST;
+    return true;
+}
+
+static bool trans_csrrsi(DisasContext *ctx, arg_csrrsi *a, uint32_t insn)
+{
+    TCGv source1, csr_store, dest, rs1_pass;
+    RISCV_OP_CSR_PRE;
+    gen_helper_csrrs(dest, cpu_env, rs1_pass, csr_store, rs1_pass);
+    RISCV_OP_CSR_POST;
+    return true;
+}
+
+static bool trans_csrrci(DisasContext *ctx, arg_csrrci *a, uint32_t insn)
+{
+    TCGv source1, csr_store, dest, rs1_pass;
+    RISCV_OP_CSR_PRE;
+    gen_helper_csrrc(dest, cpu_env, rs1_pass, csr_store, rs1_pass);
+    RISCV_OP_CSR_POST;
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 08c3b73c1a..7438205492 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1276,16 +1276,11 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
 static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
                       int rd, int rs1, int csr)
 {
-    TCGv source1, csr_store, dest, rs1_pass, imm_rs1;
+    TCGv source1, dest;
     source1 = tcg_temp_new();
-    csr_store = tcg_temp_new();
     dest = tcg_temp_new();
-    rs1_pass = tcg_temp_new();
-    imm_rs1 = tcg_temp_new();
     gen_get_gpr(source1, rs1);
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
-    tcg_gen_movi_tl(rs1_pass, rs1);
-    tcg_gen_movi_tl(csr_store, csr); /* copy into temp reg to feed to helper */
 
 #ifndef CONFIG_USER_ONLY
     /* Extract funct7 value and check whether it matches SFENCE.VMA */
@@ -1348,45 +1343,9 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
             break;
         }
         break;
-    default:
-        tcg_gen_movi_tl(imm_rs1, rs1);
-        gen_io_start();
-        switch (opc) {
-        case OPC_RISC_CSRRW:
-            gen_helper_csrrw(dest, cpu_env, source1, csr_store);
-            break;
-        case OPC_RISC_CSRRS:
-            gen_helper_csrrs(dest, cpu_env, source1, csr_store, rs1_pass);
-            break;
-        case OPC_RISC_CSRRC:
-            gen_helper_csrrc(dest, cpu_env, source1, csr_store, rs1_pass);
-            break;
-        case OPC_RISC_CSRRWI:
-            gen_helper_csrrw(dest, cpu_env, imm_rs1, csr_store);
-            break;
-        case OPC_RISC_CSRRSI:
-            gen_helper_csrrs(dest, cpu_env, imm_rs1, csr_store, rs1_pass);
-            break;
-        case OPC_RISC_CSRRCI:
-            gen_helper_csrrc(dest, cpu_env, imm_rs1, csr_store, rs1_pass);
-            break;
-        default:
-            gen_exception_illegal(ctx);
-            return;
-        }
-        gen_io_end();
-        gen_set_gpr(rd, dest);
-        /* end tb since we may be changing priv modes, to get mmu_index right */
-        tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
-        tcg_gen_exit_tb(NULL, 0); /* no chaining */
-        ctx->base.is_jmp = DISAS_NORETURN;
-        break;
     }
     tcg_temp_free(source1);
-    tcg_temp_free(csr_store);
     tcg_temp_free(dest);
-    tcg_temp_free(rs1_pass);
-    tcg_temp_free(imm_rs1);
 }
 
 static void decode_RV32_64C0(DisasContext *ctx)
-- 
2.19.1
