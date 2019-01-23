Received: from eggs.gnu.org ([209.51.188.92]:48491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gmF4R-0002S7-TA
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gmEoL-0007Wv-3P
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:27:10 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Wed, 23 Jan 2019 10:25:20 +0100
Message-Id: <20190123092538.8004-18-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190123092538.8004-1-kbastian@mail.uni-paderborn.de>
References: <20190123092538.8004-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 17/35] target/riscv: Convert quadrant 0 of
 RVXC insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sagark@eecs.berkeley.edu, palmer@sifive.com, kbastian@mail.uni-paderborn.de
Cc: qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, richard.henderson@linaro.org, qemu-devel@nongnu.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/Makefile.objs              |  9 ++-
 target/riscv/insn16.decode              | 55 ++++++++++++++++++
 target/riscv/insn_trans/trans_rvc.inc.c | 75 +++++++++++++++++++++++++
 target/riscv/translate.c                | 53 ++++++-----------
 4 files changed, 154 insertions(+), 38 deletions(-)
 create mode 100644 target/riscv/insn16.decode
 create mode 100644 target/riscv/insn_trans/trans_rvc.inc.c

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index 05087a91bb..9c6c109327 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -10,4 +10,11 @@ target/riscv/decode_insn32.inc.c: $(decode32-y) $(DECODETREE)
 	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn32 $(decode32-y), \
 	  "GEN", $(TARGET_DIR)$@)
 
-target/riscv/translate.o: target/riscv/decode_insn32.inc.c
+target/riscv/decode_insn16.inc.c: \
+  $(SRC_PATH)/target/riscv/insn16.decode $(DECODETREE)
+	$(call quiet-command, \
+	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn16 --insnwidth 16 $<, \
+	  "GEN", $(TARGET_DIR)$@)
+
+target/riscv/translate.o: target/riscv/decode_insn32.inc.c \
+	target/riscv/decode_insn16.inc.c
diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
new file mode 100644
index 0000000000..558c0c41f0
--- /dev/null
+++ b/target/riscv/insn16.decode
@@ -0,0 +1,55 @@
+#
+# RISC-V translation routines for the RVXI Base Integer Instruction Set.
+#
+# Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
+#                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms and conditions of the GNU General Public License,
+# version 2 or later, as published by the Free Software Foundation.
+#
+# This program is distributed in the hope it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+# more details.
+#
+# You should have received a copy of the GNU General Public License along with
+# this program.  If not, see <http://www.gnu.org/licenses/>.
+
+# Fields:
+%rd        7:5
+%rs1_3     7:3                !function=ex_rvc_register
+%rs2_3     2:3                !function=ex_rvc_register
+
+# Immediates:
+%nzuimm_ciw    7:4 11:2 5:1 6:1   !function=ex_shift_2
+%uimm_cl_d     5:2 10:3           !function=ex_shift_3
+%uimm_cl_w     5:1 10:3 6:1       !function=ex_shift_2
+
+
+# Argument sets:
+&cl               rs1 rd
+&cl_dw     uimm   rs1 rd
+&ciw       nzuimm     rd
+&cs               rs1 rs2
+&cs_dw     uimm   rs1 rs2
+
+
+# Formats 16:
+@ciw       ...   ........ ... .. &ciw    nzuimm=%nzuimm_ciw           rd=%rs2_3
+@cl_d      ... ... ... .. ... .. &cl_dw  uimm=%uimm_cl_d  rs1=%rs1_3  rd=%rs2_3
+@cl_w      ... ... ... .. ... .. &cl_dw  uimm=%uimm_cl_w  rs1=%rs1_3  rd=%rs2_3
+@cl        ... ... ... .. ... .. &cl                      rs1=%rs1_3  rd=%rs2_3
+@cs        ... ... ... .. ... .. &cs                      rs1=%rs1_3  rs2=%rs2_3
+@cs_d      ... ... ... .. ... .. &cs_dw  uimm=%uimm_cl_d  rs1=%rs1_3  rs2=%rs2_3
+@cs_w      ... ... ... .. ... .. &cs_dw  uimm=%uimm_cl_w  rs1=%rs1_3  rs2=%rs2_3
+
+
+# *** RV64C Standard Extension (Quadrant 0) ***
+c_addi4spn        000    ........ ... 00 @ciw
+c_fld             001  ... ... .. ... 00 @cl_d
+c_lw              010  ... ... .. ... 00 @cl_w
+c_flw_ld          011  --- ... -- ... 00 @cl    #Note: Must parse uimm manually
+c_fsd             101  ... ... .. ... 00 @cs_d
+c_sw              110  ... ... .. ... 00 @cs_w
+c_fsw_sd          111  --- ... -- ... 00 @cs    #Note: Must parse uimm manually
diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
new file mode 100644
index 0000000000..93ec8aa30b
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvc.inc.c
@@ -0,0 +1,75 @@
+/*
+ * RISC-V translation routines for the RVC Compressed Instruction Set.
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2018 Peer Adelt, peer.adelt@hni.uni-paderborn.de
+ *                    Bastian Koppelmann, kbastian@mail.uni-paderborn.de
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+static bool trans_c_addi4spn(DisasContext *ctx, arg_c_addi4spn *a)
+{
+    if (a->nzuimm == 0) {
+        /* Reserved in ISA */
+        return false;
+    }
+    arg_addi arg = { .rd = a->rd, .rs1 = 2, .imm = a->nzuimm };
+    return trans_addi(ctx, &arg);
+}
+
+static bool trans_c_fld(DisasContext *ctx, arg_c_fld *a)
+{
+    arg_fld arg = { .rd = a->rd, .rs1 = a->rs1, .imm = a->uimm };
+    return trans_fld(ctx, &arg);
+}
+
+static bool trans_c_lw(DisasContext *ctx, arg_c_lw *a)
+{
+    arg_lw arg = { .rd = a->rd, .rs1 = a->rs1, .imm = a->uimm };
+    return trans_lw(ctx, &arg);
+}
+
+static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a)
+{
+#ifdef TARGET_RISCV32
+    /* C.FLW ( RV32FC-only ) */
+    return false;
+#else
+    /* C.LD ( RV64C/RV128C-only ) */
+    return false;
+#endif
+}
+
+static bool trans_c_fsd(DisasContext *ctx, arg_c_fsd *a)
+{
+    arg_fsd arg = { .rs1 = a->rs1, .rs2 = a->rs2, .imm = a->uimm };
+    return trans_fsd(ctx, &arg);
+}
+
+static bool trans_c_sw(DisasContext *ctx, arg_c_sw *a)
+{
+    arg_sw arg = { .rs1 = a->rs1, .rs2 = a->rs2, .imm = a->uimm };
+    return trans_sw(ctx, &arg);
+}
+
+static bool trans_c_fsw_sd(DisasContext *ctx, arg_c_fsw_sd *a)
+{
+#ifdef TARGET_RISCV32
+    /* C.FSW ( RV32FC-only ) */
+    return false;
+#else
+    /* C.SD ( RV64C/RV128C-only ) */
+    return false;
+#endif
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ff15e0f7ed..1ee13c1907 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -720,27 +720,6 @@ static void decode_RV32_64C0(DisasContext *ctx)
     uint8_t rs1s = GET_C_RS1S(ctx->opcode);
 
     switch (funct3) {
-    case 0:
-        /* illegal */
-        if (ctx->opcode == 0) {
-            gen_exception_illegal(ctx);
-        } else {
-            /* C.ADDI4SPN -> addi rd', x2, zimm[9:2]*/
-            gen_arith_imm(ctx, OPC_RISC_ADDI, rd_rs2, 2,
-                          GET_C_ADDI4SPN_IMM(ctx->opcode));
-        }
-        break;
-    case 1:
-        /* C.FLD -> fld rd', offset[7:3](rs1')*/
-        gen_fp_load(ctx, OPC_RISC_FLD, rd_rs2, rs1s,
-                    GET_C_LD_IMM(ctx->opcode));
-        /* C.LQ(RV128) */
-        break;
-    case 2:
-        /* C.LW -> lw rd', offset[6:2](rs1') */
-        gen_load(ctx, OPC_RISC_LW, rd_rs2, rs1s,
-                 GET_C_LW_IMM(ctx->opcode));
-        break;
     case 3:
 #if defined(TARGET_RISCV64)
         /* C.LD(RV64/128) -> ld rd', offset[7:3](rs1')*/
@@ -752,21 +731,6 @@ static void decode_RV32_64C0(DisasContext *ctx)
                     GET_C_LW_IMM(ctx->opcode));
 #endif
         break;
-    case 4:
-        /* reserved */
-        gen_exception_illegal(ctx);
-        break;
-    case 5:
-        /* C.FSD(RV32/64) -> fsd rs2', offset[7:3](rs1') */
-        gen_fp_store(ctx, OPC_RISC_FSD, rs1s, rd_rs2,
-                     GET_C_LD_IMM(ctx->opcode));
-        /* C.SQ (RV128) */
-        break;
-    case 6:
-        /* C.SW -> sw rs2', offset[6:2](rs1')*/
-        gen_store(ctx, OPC_RISC_SW, rs1s, rd_rs2,
-                  GET_C_LW_IMM(ctx->opcode));
-        break;
     case 7:
 #if defined(TARGET_RISCV64)
         /* C.SD (RV64/128) -> sd rs2', offset[7:3](rs1')*/
@@ -996,8 +960,15 @@ static void decode_RV32_64C(CPURISCVState *env, DisasContext *ctx)
         return imm << amount;                 \
     }
 EX_SH(1)
+EX_SH(2)
+EX_SH(3)
 EX_SH(12)
 
+static int ex_rvc_register(int reg)
+{
+    return 8 + reg;
+}
+
 bool decode_insn32(DisasContext *ctx, uint32_t insn);
 /* Include the auto-generated decoder for 32 bit insn */
 #include "decode_insn32.inc.c"
@@ -1009,6 +980,11 @@ bool decode_insn32(DisasContext *ctx, uint32_t insn);
 #include "insn_trans/trans_rvd.inc.c"
 #include "insn_trans/trans_privileged.inc.c"
 
+bool decode_insn16(DisasContext *ctx, uint16_t insn);
+/* auto-generated decoder*/
+#include "decode_insn16.inc.c"
+#include "insn_trans/trans_rvc.inc.c"
+
 static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
 {
     int rs1, rd;
@@ -1042,7 +1018,10 @@ static void decode_opc(DisasContext *ctx)
             gen_exception_illegal(ctx);
         } else {
             ctx->pc_succ_insn = ctx->base.pc_next + 2;
-            decode_RV32_64C(ctx->env, ctx);
+            if (!decode_insn16(ctx, ctx->opcode)) {
+                /* fall back to old decoder */
+                decode_RV32_64C(ctx->env, ctx);
+            }
         }
     } else {
         ctx->pc_succ_insn = ctx->base.pc_next + 4;
-- 
2.20.1
