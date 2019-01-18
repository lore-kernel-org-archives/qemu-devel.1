Received: from eggs.gnu.org ([209.51.188.92]:42476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gkU0i-0005XG-C7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gkU0c-0008Kx-Gc
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:16:34 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 18 Jan 2019 14:14:52 +0100
Message-Id: <20190118131456.32451-32-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
References: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 31/35] target/riscv: Convert @cs_2 insns to
 share translation functions<Paste>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com, kbastian@mail.uni-paderborn.de
Cc: qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, richard.henderson@linaro.org, qemu-devel@nongnu.org

These all expand simply to R format instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/riscv/Makefile.objs              | 10 +++---
 target/riscv/insn16-64.decode           | 24 ++++++++++++++
 target/riscv/insn16.decode              | 15 +++++----
 target/riscv/insn_trans/trans_rvc.inc.c | 44 -------------------------
 target/riscv/translate.c                | 20 ++++++++---
 5 files changed, 54 insertions(+), 59 deletions(-)
 create mode 100644 target/riscv/insn16-64.decode

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index 9c6c109327..990bd89016 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -5,16 +5,18 @@ DECODETREE = $(SRC_PATH)/scripts/decodetree.py
 decode32-y = $(SRC_PATH)/target/riscv/insn32.decode
 decode32-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn32-64.decode
 
+decode16-y = $(SRC_PATH)/target/riscv/insn16.decode
+decode16-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn16-64.decode
+
 target/riscv/decode_insn32.inc.c: $(decode32-y) $(DECODETREE)
 	$(call quiet-command, \
 	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn32 $(decode32-y), \
 	  "GEN", $(TARGET_DIR)$@)
 
-target/riscv/decode_insn16.inc.c: \
-  $(SRC_PATH)/target/riscv/insn16.decode $(DECODETREE)
+target/riscv/decode_insn16.inc.c: $(decode16-y) $(DECODETREE)
 	$(call quiet-command, \
-	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn16 --insnwidth 16 $<, \
-	  "GEN", $(TARGET_DIR)$@)
+	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn16 --insnwidth 16 \
+	  $(decode16-y), "GEN", $(TARGET_DIR)$@)
 
 target/riscv/translate.o: target/riscv/decode_insn32.inc.c \
 	target/riscv/decode_insn16.inc.c
diff --git a/target/riscv/insn16-64.decode b/target/riscv/insn16-64.decode
new file mode 100644
index 0000000000..5af2e2b072
--- /dev/null
+++ b/target/riscv/insn16-64.decode
@@ -0,0 +1,24 @@
+#
+# RISC-V translation routines for the RVC Instruction Set.
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
+# This is concatenated with insn16.decode for risc64 targets.
+# All of the fields and formats are there.
+
+# *** RV64C Standard Extension (Quadrant 1) ***
+subw              100 1 11 ... 00 ... 01 @cs_2
+addw              100 1 11 ... 01 ... 01 @cs_2
diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index 0829e3bc59..c7a58d80e5 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -41,6 +41,9 @@
 
 
 
+# Argument sets imported from insn32.decode:
+&r         rd rs1 rs2   !extern
+
 # Argument sets:
 &cl               rs1 rd
 &cl_dw     uimm   rs1 rd
@@ -68,7 +71,7 @@
 @cl_w      ... ... ... .. ... .. &cl_dw  uimm=%uimm_cl_w  rs1=%rs1_3  rd=%rs2_3
 @cl        ... ... ... .. ... .. &cl                      rs1=%rs1_3  rd=%rs2_3
 @cs        ... ... ... .. ... .. &cs                      rs1=%rs1_3  rs2=%rs2_3
-@cs_2      ... ... ... .. ... .. &cr                      rd=%rs1_3   rs2=%rs2_3
+@cs_2      ... ... ... .. ... .. &r      rd=%rs1_3 rs1=%rs1_3 rs2=%rs2_3
 @cs_d      ... ... ... .. ... .. &cs_dw  uimm=%uimm_cl_d  rs1=%rs1_3  rs2=%rs2_3
 @cs_w      ... ... ... .. ... .. &cs_dw  uimm=%uimm_cl_w  rs1=%rs1_3  rs2=%rs2_3
 @cb        ... ... ... .. ... .. &cb     imm=%imm_cb      rs1=%rs1_3
@@ -107,12 +110,10 @@ c_addi16sp_lui    011 .  .....  ..... 01 @c_addi16sp_lui # shares opc with C.LUI
 c_srli            100 . 00 ...  ..... 01 @c_shift
 c_srai            100 . 01 ...  ..... 01 @c_shift
 c_andi            100 . 10 ...  ..... 01 @c_andi
-c_sub             100 0 11 ... 00 ... 01 @cs_2
-c_xor             100 0 11 ... 01 ... 01 @cs_2
-c_or              100 0 11 ... 10 ... 01 @cs_2
-c_and             100 0 11 ... 11 ... 01 @cs_2
-c_subw            100 1 11 ... 00 ... 01 @cs_2
-c_addw            100 1 11 ... 01 ... 01 @cs_2
+sub               100 0 11 ... 00 ... 01 @cs_2
+xor               100 0 11 ... 01 ... 01 @cs_2
+or                100 0 11 ... 10 ... 01 @cs_2
+and               100 0 11 ... 11 ... 01 @cs_2
 c_j               101     ........... 01 @cj
 c_beqz            110  ... ...  ..... 01 @cb
 c_bnez            111  ... ...  ..... 01 @cb
diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
index bcdf64d3b7..639c381edf 100644
--- a/target/riscv/insn_trans/trans_rvc.inc.c
+++ b/target/riscv/insn_trans/trans_rvc.inc.c
@@ -163,50 +163,6 @@ static bool trans_c_andi(DisasContext *ctx, arg_c_andi *a)
     return trans_andi(ctx, &arg);
 }
 
-static bool trans_c_sub(DisasContext *ctx, arg_c_sub *a)
-{
-    arg_sub arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_sub(ctx, &arg);
-}
-
-static bool trans_c_xor(DisasContext *ctx, arg_c_xor *a)
-{
-    arg_xor arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_xor(ctx, &arg);
-}
-
-static bool trans_c_or(DisasContext *ctx, arg_c_or *a)
-{
-    arg_or arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_or(ctx, &arg);
-}
-
-static bool trans_c_and(DisasContext *ctx, arg_c_and *a)
-{
-    arg_and arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_and(ctx, &arg);
-}
-
-static bool trans_c_subw(DisasContext *ctx, arg_c_subw *a)
-{
-#ifdef TARGET_RISCV64
-    arg_subw arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_subw(ctx, &arg);
-#else
-    return false;
-#endif
-}
-
-static bool trans_c_addw(DisasContext *ctx, arg_c_addw *a)
-{
-#ifdef TARGET_RISCV64
-    arg_addw arg = { .rd = a->rd, .rs1 = a->rd, .rs2 = a->rs2 };
-    return trans_addw(ctx, &arg);
-#else
-    return false;
-#endif
-}
-
 static bool trans_c_j(DisasContext *ctx, arg_c_j *a)
 {
     arg_jal arg = { .rd = 0, .imm = a->imm };
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index b0251b3518..5079c68b18 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -487,10 +487,25 @@ static int ex_rvc_register(int reg)
     return 8 + reg;
 }
 
+/*
+ * Include the auto-generated decoders.
+ * Note that the 16-bit decoder reuses some of the trans_* functions
+ * from the 32-bit decoder, which results in duplicate declarations
+ * of the relevant helpers.  Suppress the warning.
+ */
 bool decode_insn32(DisasContext *ctx, uint32_t insn);
-/* Include the auto-generated decoder for 32 bit insn */
+bool decode_insn16(DisasContext *ctx, uint16_t insn);
+
 #include "decode_insn32.inc.c"
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wredundant-decls"
+
+#include "decode_insn16.inc.c"
+
+#pragma GCC diagnostic pop
+
+
 static bool gen_arith_imm(DisasContext *ctx, arg_i *a,
                           void(*func)(TCGv, TCGv, TCGv))
 {
@@ -595,9 +610,6 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 #include "insn_trans/trans_rvd.inc.c"
 #include "insn_trans/trans_privileged.inc.c"
 
-bool decode_insn16(DisasContext *ctx, uint16_t insn);
-/* auto-generated decoder*/
-#include "decode_insn16.inc.c"
 #include "insn_trans/trans_rvc.inc.c"
 
 static void decode_opc(DisasContext *ctx)
-- 
2.20.1
