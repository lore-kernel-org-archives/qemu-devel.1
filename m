Received: from eggs.gnu.org ([2001:4830:134:3::10]:35954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3D-0000c4-Oy
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3B-0007SO-Ad
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:19 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj3A-0007Rj-Ua
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:17 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3A-0004nE-1J
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:16 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:19:45 +0100
Message-Id: <20180518172009.14416-9-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/32] target/arm: Introduce translate-a64.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Move some stuff that will be common to both translate-a64.c
and translate-sve.c.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180516223007.10256-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.h | 118 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 112 +++++------------------------------
 2 files changed, 133 insertions(+), 97 deletions(-)
 create mode 100644 target/arm/translate-a64.h

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
new file mode 100644
index 0000000000..dd9c09f89b
--- /dev/null
+++ b/target/arm/translate-a64.h
@@ -0,0 +1,118 @@
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
+    } while (0)
+
+TCGv_i64 new_tmp_a64(DisasContext *s);
+TCGv_i64 new_tmp_a64_zero(DisasContext *s);
+TCGv_i64 cpu_reg(DisasContext *s, int reg);
+TCGv_i64 cpu_reg_sp(DisasContext *s, int reg);
+TCGv_i64 read_cpu_reg(DisasContext *s, int reg, int sf);
+TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int sf);
+void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v);
+TCGv_ptr get_fpstatus_ptr(bool);
+bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
+                            unsigned int imms, unsigned int immr);
+uint64_t vfp_expand_imm(int size, uint8_t imm8);
+bool sve_access_check(DisasContext *s);
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
+/* Return a newly allocated pointer to the vector register.  */
+static inline TCGv_ptr vec_full_reg_ptr(DisasContext *s, int regno)
+{
+    TCGv_ptr ret = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(ret, cpu_env, vec_full_reg_offset(s, regno));
+    return ret;
+}
+
+/* Return the byte size of the "whole" vector register, VL / 8.  */
+static inline int vec_full_reg_size(DisasContext *s)
+{
+    return s->sve_len;
+}
+
+bool disas_sve(DisasContext *, uint32_t);
+
+/* Note that the gvec expanders operate on offsets + sizes.  */
+typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
+typedef void GVecGen2iFn(unsigned, uint32_t, uint32_t, int64_t,
+                         uint32_t, uint32_t);
+typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
+                        uint32_t, uint32_t, uint32_t);
+
+#endif /* TARGET_ARM_TRANSLATE_A64_H */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d8284678f7..74ef756ad5 100644
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
@@ -86,13 +86,6 @@ typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
 typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
 typedef void AtomicThreeOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGArg, TCGMemOp);
 
-/* Note that the gvec expanders operate on offsets + sizes.  */
-typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
-typedef void GVecGen2iFn(unsigned, uint32_t, uint32_t, int64_t,
-                         uint32_t, uint32_t);
-typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
-                        uint32_t, uint32_t, uint32_t);
-
 /* initialize TCG globals.  */
 void a64_translate_init(void)
 {
@@ -405,22 +398,13 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
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
-    } while (0)
-
 static void init_tmp_a64_array(DisasContext *s)
 {
 #ifdef CONFIG_DEBUG_TCG
@@ -438,13 +422,13 @@ static void free_tmp_a64(DisasContext *s)
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
@@ -466,7 +450,7 @@ static TCGv_i64 new_tmp_a64_zero(DisasContext *s)
  * to cpu_X[31] and ZR accesses to a temporary which can be discarded.
  * This is the point of the _sp forms.
  */
-static TCGv_i64 cpu_reg(DisasContext *s, int reg)
+TCGv_i64 cpu_reg(DisasContext *s, int reg)
 {
     if (reg == 31) {
         return new_tmp_a64_zero(s);
@@ -476,7 +460,7 @@ static TCGv_i64 cpu_reg(DisasContext *s, int reg)
 }
 
 /* register access for when 31 == SP */
-static TCGv_i64 cpu_reg_sp(DisasContext *s, int reg)
+TCGv_i64 cpu_reg_sp(DisasContext *s, int reg)
 {
     return cpu_X[reg];
 }
@@ -485,7 +469,7 @@ static TCGv_i64 cpu_reg_sp(DisasContext *s, int reg)
  * representing the register contents. This TCGv is an auto-freed
  * temporary so it need not be explicitly freed, and may be modified.
  */
-static TCGv_i64 read_cpu_reg(DisasContext *s, int reg, int sf)
+TCGv_i64 read_cpu_reg(DisasContext *s, int reg, int sf)
 {
     TCGv_i64 v = new_tmp_a64(s);
     if (reg != 31) {
@@ -500,7 +484,7 @@ static TCGv_i64 read_cpu_reg(DisasContext *s, int reg, int sf)
     return v;
 }
 
-static TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int sf)
+TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int sf)
 {
     TCGv_i64 v = new_tmp_a64(s);
     if (sf) {
@@ -511,72 +495,6 @@ static TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int sf)
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
-/* Return a newly allocated pointer to the vector register.  */
-static TCGv_ptr vec_full_reg_ptr(DisasContext *s, int regno)
-{
-    TCGv_ptr ret = tcg_temp_new_ptr();
-    tcg_gen_addi_ptr(ret, cpu_env, vec_full_reg_offset(s, regno));
-    return ret;
-}
-
-/* Return the byte size of the "whole" vector register, VL / 8.  */
-static inline int vec_full_reg_size(DisasContext *s)
-{
-    /* FIXME SVE: We should put the composite ZCR_EL* value into tb->flags.
-       In the meantime this is just the AdvSIMD length of 128.  */
-    return 128 / 8;
-}
-
 /* Return the offset into CPUARMState of a slice (from
  * the least significant end) of FP register Qn (ie
  * Dn, Sn, Hn or Bn).
@@ -641,7 +559,7 @@ static void clear_vec_high(DisasContext *s, bool is_q, int rd)
     }
 }
 
-static void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v)
+void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v)
 {
     unsigned ofs = fp_reg_offset(s, reg, MO_64);
 
@@ -658,7 +576,7 @@ static void write_fp_sreg(DisasContext *s, int reg, TCGv_i32 v)
     tcg_temp_free_i64(tmp);
 }
 
-static TCGv_ptr get_fpstatus_ptr(bool is_f16)
+TCGv_ptr get_fpstatus_ptr(bool is_f16)
 {
     TCGv_ptr statusptr = tcg_temp_new_ptr();
     int offset;
@@ -1246,14 +1164,14 @@ static inline bool fp_access_check(DisasContext *s)
 /* Check that SVE access is enabled.  If it is, return true.
  * If not, emit code to generate an appropriate exception and return false.
  */
-static inline bool sve_access_check(DisasContext *s)
+bool sve_access_check(DisasContext *s)
 {
     if (s->sve_excp_el) {
         gen_exception_insn(s, 4, EXCP_UDEF, syn_sve_access_trap(),
                            s->sve_excp_el);
         return false;
     }
-    return true;
+    return fp_access_check(s);
 }
 
 /*
@@ -3419,8 +3337,8 @@ static inline uint64_t bitmask64(unsigned int length)
  * value (ie should cause a guest UNDEF exception), and true if they are
  * valid, in which case the decoded bit pattern is written to result.
  */
-static bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
-                                   unsigned int imms, unsigned int immr)
+bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
+                            unsigned int imms, unsigned int immr)
 {
     uint64_t mask;
     unsigned e, levels, s, r;
@@ -5650,7 +5568,7 @@ static void disas_fp_3src(DisasContext *s, uint32_t insn)
  * the range 01....1xx to 10....0xx, and the most significant 4 bits of
  * the mantissa; see VFPExpandImm() in the v8 ARM ARM.
  */
-static uint64_t vfp_expand_imm(int size, uint8_t imm8)
+uint64_t vfp_expand_imm(int size, uint8_t imm8)
 {
     uint64_t imm;
 
-- 
2.17.0
