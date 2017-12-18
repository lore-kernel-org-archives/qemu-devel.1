Received: from eggs.gnu.org ([2001:4830:134:3::10]:55479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUI-00081Z-42
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUF-0001ml-HU
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:02 -0500
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:34933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUF-0001m5-9i
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:45:59 -0500
Received: by mail-pf0-x235.google.com with SMTP id j124so9980013pfc.2
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:45:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:31 -0800
Message-Id: <20171218174552.18871-3-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 02/23] target/arm: Add SVE decode skeleton
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Including only 4, as-yet unimplemented, instruction patterns
so that the whole thing compiles.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.h | 111 +++++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c |  91 +++++++------------------------------
 target/arm/translate-sve.c |  48 ++++++++++++++++++++
 .gitignore                 |   1 +
 target/arm/Makefile.objs   |  11 +++++
 target/arm/sve.def         |  45 ++++++++++++++++++
 6 files changed, 233 insertions(+), 74 deletions(-)
 create mode 100644 target/arm/translate-a64.h
 create mode 100644 target/arm/translate-sve.c
 create mode 100644 target/arm/sve.def

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
new file mode 100644
index 0000000000..9014b5bf8b
--- /dev/null
+++ b/target/arm/translate-a64.h
@@ -0,0 +1,111 @@
+/*
+ *  AArch64 translation, common definitions.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARM_TRANSLATE_A64_H
+#define TARGET_ARM_TRANSLATE_A64_H
+
+void unallocated_encoding(DisasContext *s);
+
+#define unsupported_encoding(s, insn)                                    \
+    do {                                                                 \
+        qemu_log_mask(LOG_UNIMP,                                         \
+                      "%s:%d: unsupported instruction encoding 0x%08x "  \
+                      "at pc=%016" PRIx64 "\n",                          \
+                      __FILE__, __LINE__, insn, s->pc - 4);              \
+        unallocated_encoding(s);                                         \
+    } while (0);
+
+TCGv_i64 new_tmp_a64(DisasContext *s);
+TCGv_i64 new_tmp_a64_zero(DisasContext *s);
+TCGv_i64 cpu_reg(DisasContext *s, int reg);
+TCGv_i64 cpu_reg_sp(DisasContext *s, int reg);
+TCGv_i64 read_cpu_reg(DisasContext *s, int reg, int sf);
+TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int sf);
+
+/* We should have at some point before trying to access an FP register
+ * done the necessary access check, so assert that
+ * (a) we did the check and
+ * (b) we didn't then just plough ahead anyway if it failed.
+ * Print the instruction pattern in the abort message so we can figure
+ * out what we need to fix if a user encounters this problem in the wild.
+ */
+static inline void assert_fp_access_checked(DisasContext *s)
+{
+#ifdef CONFIG_DEBUG_TCG
+    if (unlikely(!s->fp_access_checked || s->fp_excp_el)) {
+        fprintf(stderr, "target-arm: FP access check missing for "
+                "instruction 0x%08x\n", s->insn);
+        abort();
+    }
+#endif
+}
+
+/* Return the offset into CPUARMState of an element of specified
+ * size, 'element' places in from the least significant end of
+ * the FP/vector register Qn.
+ */
+static inline int vec_reg_offset(DisasContext *s, int regno,
+                                 int element, TCGMemOp size)
+{
+    int offs = 0;
+#ifdef HOST_WORDS_BIGENDIAN
+    /* This is complicated slightly because vfp.zregs[n].d[0] is
+     * still the low half and vfp.zregs[n].d[1] the high half
+     * of the 128 bit vector, even on big endian systems.
+     * Calculate the offset assuming a fully bigendian 128 bits,
+     * then XOR to account for the order of the two 64 bit halves.
+     */
+    offs += (16 - ((element + 1) * (1 << size)));
+    offs ^= 8;
+#else
+    offs += element * (1 << size);
+#endif
+    offs += offsetof(CPUARMState, vfp.zregs[regno]);
+    assert_fp_access_checked(s);
+    return offs;
+}
+
+/* Return the offset info CPUARMState of the "whole" vector register Qn.  */
+static inline int vec_full_reg_offset(DisasContext *s, int regno)
+{
+    assert_fp_access_checked(s);
+    return offsetof(CPUARMState, vfp.zregs[regno]);
+}
+
+/* Return the offset info CPUARMState of the predicate vector register Pn.
+ * Note for this purpose, FFR is P16.  */
+static inline int pred_full_reg_offset(DisasContext *s, int regno)
+{
+    assert_fp_access_checked(s);
+    return offsetof(CPUARMState, vfp.pregs[regno]);
+}
+
+/* Return the byte size of the "whole" vector register, VL / 8.  */
+static inline int vec_full_reg_size(DisasContext *s)
+{
+    return s->sve_len;
+}
+
+/* Return the byte size of the whole predicate register, VL / 64.  */
+static inline int pred_full_reg_size(DisasContext *s)
+{
+    return s->sve_len >> 3;
+}
+
+bool disas_sve(DisasContext *, uint32_t);
+
+#endif /* TARGET_ARM_TRANSLATE_A64_H */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ecb72e4d9c..8be1660661 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -36,13 +36,13 @@
 #include "exec/log.h"
 
 #include "trace-tcg.h"
+#include "translate-a64.h"
 
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
 
 /* Load/store exclusive handling */
 static TCGv_i64 cpu_exclusive_high;
-static TCGv_i64 cpu_reg(DisasContext *s, int reg);
 
 static const char *regnames[] = {
     "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7",
@@ -390,22 +390,13 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
     }
 }
 
-static void unallocated_encoding(DisasContext *s)
+void unallocated_encoding(DisasContext *s)
 {
     /* Unallocated and reserved encodings are uncategorized */
     gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
                        default_exception_el(s));
 }
 
-#define unsupported_encoding(s, insn)                                    \
-    do {                                                                 \
-        qemu_log_mask(LOG_UNIMP,                                         \
-                      "%s:%d: unsupported instruction encoding 0x%08x "  \
-                      "at pc=%016" PRIx64 "\n",                          \
-                      __FILE__, __LINE__, insn, s->pc - 4);              \
-        unallocated_encoding(s);                                         \
-    } while (0);
-
 static void init_tmp_a64_array(DisasContext *s)
 {
 #ifdef CONFIG_DEBUG_TCG
@@ -423,13 +414,13 @@ static void free_tmp_a64(DisasContext *s)
     init_tmp_a64_array(s);
 }
 
-static TCGv_i64 new_tmp_a64(DisasContext *s)
+TCGv_i64 new_tmp_a64(DisasContext *s)
 {
     assert(s->tmp_a64_count < TMP_A64_MAX);
     return s->tmp_a64[s->tmp_a64_count++] = tcg_temp_new_i64();
 }
 
-static TCGv_i64 new_tmp_a64_zero(DisasContext *s)
+TCGv_i64 new_tmp_a64_zero(DisasContext *s)
 {
     TCGv_i64 t = new_tmp_a64(s);
     tcg_gen_movi_i64(t, 0);
@@ -451,7 +442,7 @@ static TCGv_i64 new_tmp_a64_zero(DisasContext *s)
  * to cpu_X[31] and ZR accesses to a temporary which can be discarded.
  * This is the point of the _sp forms.
  */
-static TCGv_i64 cpu_reg(DisasContext *s, int reg)
+TCGv_i64 cpu_reg(DisasContext *s, int reg)
 {
     if (reg == 31) {
         return new_tmp_a64_zero(s);
@@ -461,7 +452,7 @@ static TCGv_i64 cpu_reg(DisasContext *s, int reg)
 }
 
 /* register access for when 31 == SP */
-static TCGv_i64 cpu_reg_sp(DisasContext *s, int reg)
+TCGv_i64 cpu_reg_sp(DisasContext *s, int reg)
 {
     return cpu_X[reg];
 }
@@ -470,7 +461,7 @@ static TCGv_i64 cpu_reg_sp(DisasContext *s, int reg)
  * representing the register contents. This TCGv is an auto-freed
  * temporary so it need not be explicitly freed, and may be modified.
  */
-static TCGv_i64 read_cpu_reg(DisasContext *s, int reg, int sf)
+TCGv_i64 read_cpu_reg(DisasContext *s, int reg, int sf)
 {
     TCGv_i64 v = new_tmp_a64(s);
     if (reg != 31) {
@@ -485,7 +476,7 @@ static TCGv_i64 read_cpu_reg(DisasContext *s, int reg, int sf)
     return v;
 }
 
-static TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int sf)
+TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int sf)
 {
     TCGv_i64 v = new_tmp_a64(s);
     if (sf) {
@@ -496,62 +487,6 @@ static TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int sf)
     return v;
 }
 
-/* We should have at some point before trying to access an FP register
- * done the necessary access check, so assert that
- * (a) we did the check and
- * (b) we didn't then just plough ahead anyway if it failed.
- * Print the instruction pattern in the abort message so we can figure
- * out what we need to fix if a user encounters this problem in the wild.
- */
-static inline void assert_fp_access_checked(DisasContext *s)
-{
-#ifdef CONFIG_DEBUG_TCG
-    if (unlikely(!s->fp_access_checked || s->fp_excp_el)) {
-        fprintf(stderr, "target-arm: FP access check missing for "
-                "instruction 0x%08x\n", s->insn);
-        abort();
-    }
-#endif
-}
-
-/* Return the offset into CPUARMState of an element of specified
- * size, 'element' places in from the least significant end of
- * the FP/vector register Qn.
- */
-static inline int vec_reg_offset(DisasContext *s, int regno,
-                                 int element, TCGMemOp size)
-{
-    int offs = 0;
-#ifdef HOST_WORDS_BIGENDIAN
-    /* This is complicated slightly because vfp.zregs[n].d[0] is
-     * still the low half and vfp.zregs[n].d[1] the high half
-     * of the 128 bit vector, even on big endian systems.
-     * Calculate the offset assuming a fully bigendian 128 bits,
-     * then XOR to account for the order of the two 64 bit halves.
-     */
-    offs += (16 - ((element + 1) * (1 << size)));
-    offs ^= 8;
-#else
-    offs += element * (1 << size);
-#endif
-    offs += offsetof(CPUARMState, vfp.zregs[regno]);
-    assert_fp_access_checked(s);
-    return offs;
-}
-
-/* Return the offset info CPUARMState of the "whole" vector register Qn.  */
-static inline int vec_full_reg_offset(DisasContext *s, int regno)
-{
-    assert_fp_access_checked(s);
-    return offsetof(CPUARMState, vfp.zregs[regno]);
-}
-
-/* Return the byte size of the "whole" vector register, VL / 8.  */
-static inline int vec_full_reg_size(DisasContext *s)
-{
-    return s->sve_len;
-}
-
 /* Return a newly allocated pointer to the vector register.  */
 static TCGv_ptr vec_full_reg_ptr(DisasContext *s, int regno)
 {
@@ -12705,7 +12640,15 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
     s->fp_access_checked = false;
 
     switch (extract32(insn, 25, 4)) {
-    case 0x0: case 0x1: case 0x2: case 0x3: /* UNALLOCATED */
+    case 0x0: case 0x1: case 0x3: /* UNALLOCATED */
+        unallocated_encoding(s);
+        break;
+    case 0x2:
+        if (arm_dc_feature(s, ARM_FEATURE_SVE)) {
+            if (!fp_access_check(s) || disas_sve(s, insn)) {
+                break;
+            }
+        }
         unallocated_encoding(s);
         break;
     case 0x8: case 0x9: /* Data processing - immediate */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
new file mode 100644
index 0000000000..67ad94e310
--- /dev/null
+++ b/target/arm/translate-sve.c
@@ -0,0 +1,48 @@
+/*
+ *  AArch64 SVE translation
+ *
+ *  Copyright (c) 2017 Linaro, Ltd
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "tcg-op.h"
+#include "tcg-op-gvec.h"
+#include "qemu/log.h"
+#include "arm_ldst.h"
+#include "translate.h"
+#include "internals.h"
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+#include "exec/log.h"
+#include "trace-tcg.h"
+#include "translate-a64.h"
+
+/*
+ * Include the generated decoder.
+ */
+
+#include "decode-sve.inc.c"
+
+/*
+ * Implement all of the translator functions referenced by the decoder.
+ */
+
+void trans_AND_zzz(DisasContext *s, arg_AND_zzz *a, uint32_t insn) { unsupported_encoding(s, insn); }
+void trans_ORR_zzz(DisasContext *s, arg_ORR_zzz *a, uint32_t insn) { unsupported_encoding(s, insn); }
+void trans_EOR_zzz(DisasContext *s, arg_EOR_zzz *a, uint32_t insn) { unsupported_encoding(s, insn); }
+void trans_BIC_zzz(DisasContext *s, arg_BIC_zzz *a, uint32_t insn) { unsupported_encoding(s, insn); }
diff --git a/.gitignore b/.gitignore
index 588769b250..e5fc04de07 100644
--- a/.gitignore
+++ b/.gitignore
@@ -140,3 +140,4 @@ trace-dtrace-root.h
 trace-dtrace-root.dtrace
 trace-ust-all.h
 trace-ust-all.c
+/target/arm/decode-sve.inc.c
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index c2d32988f9..d1ca1f799b 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -10,3 +10,14 @@ obj-y += gdbstub.o
 obj-$(TARGET_AARCH64) += cpu64.o translate-a64.o helper-a64.o gdbstub64.o
 obj-y += crypto_helper.o
 obj-$(CONFIG_SOFTMMU) += arm-powerctl.o
+
+DECODETREE = $(SRC_PATH)/scripts/decodetree.py
+
+target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.def $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) -o $@ --decode disas_sve \
+		$(SRC_PATH)/target/arm/sve.def || rm -f $@, \
+		"GEN", $@)
+
+target/arm/translate-sve.o: target/arm/decode-sve.inc.c
+obj-$(TARGET_AARCH64) += translate-sve.o
diff --git a/target/arm/sve.def b/target/arm/sve.def
new file mode 100644
index 0000000000..0f47a21ef0
--- /dev/null
+++ b/target/arm/sve.def
@@ -0,0 +1,45 @@
+# AArch64 SVE instruction descriptions
+#
+#  Copyright (c) 2017 Linaro, Ltd
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licenses/>.
+
+#
+# This file is processed by scripts/decodetree.py
+#
+
+###########################################################################
+# Named attribute sets.  These are used to make nice(er) names
+# when creating helpers common to those for the individual
+# instruction patterns.
+
+&rrr_esz		rd rn rm esz
+
+###########################################################################
+# Named instruction formats.  These are generally used to
+# reduce the amount of duplication between instruction patterns.
+
+# Three operand with unused vector element size
+@rd_rn_rm		........ ... rm:5  ... ...  rn:5 rd:5		&rrr_esz esz=0
+
+###########################################################################
+# Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
+
+### SVE Logical - Unpredicated Group
+
+# SVE bitwise logical operations (unpredicated)
+AND_zzz			00000100 00 1 ..... 001 100 ..... .....		@rd_rn_rm
+ORR_zzz			00000100 01 1 ..... 001 100 ..... .....		@rd_rn_rm
+EOR_zzz			00000100 10 1 ..... 001 100 ..... .....		@rd_rn_rm
+BIC_zzz			00000100 11 1 ..... 001 100 ..... .....		@rd_rn_rm
-- 
2.14.3
