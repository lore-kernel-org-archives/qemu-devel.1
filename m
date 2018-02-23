Received: from eggs.gnu.org ([2001:4830:134:3::10]:44362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFOw-0002kk-5w
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFOt-000708-MP
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:46 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:44688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFOt-0006xn-7g
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:43 -0500
Received: by mail-wr0-x244.google.com with SMTP id v65so14490950wrc.11
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:36:43 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:36:09 +0000
Message-Id: <20180223153636.29809-5-alex.bennee@linaro.org>
In-Reply-To: <20180223153636.29809-1-alex.bennee@linaro.org>
References: <20180223153636.29809-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 04/31] target/arm/cpu.h: add additional
 float_status flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

Half-precision flush to zero behaviour is controlled by a separate
FZ16 bit in the FPCR. To handle this we pass a pointer to
fp_status_fp16 when working on half-precision operations. The value of
the presented FPCR is calculated from an amalgam of the two when read.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - add FPCR_[FZ/FZ16/DN] defines to cpu.h and use
  - only propagate flag status to fp_status as they are ored later
  - ensure dnan and round mode propagated to fp_status_fp16
---
 target/arm/cpu.h           | 32 ++++++++++++++++++++++------
 target/arm/helper.c        | 26 ++++++++++++++++++-----
 target/arm/translate-a64.c | 53 +++++++++++++++++++++++++---------------------
 3 files changed, 75 insertions(+), 36 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c2bce23fa5..ebbb21391c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -538,19 +538,29 @@ typedef struct CPUARMState {
         /* scratch space when Tn are not sufficient.  */
         uint32_t scratch[8];
 
-        /* fp_status is the "normal" fp status. standard_fp_status retains
-         * values corresponding to the ARM "Standard FPSCR Value", ie
-         * default-NaN, flush-to-zero, round-to-nearest and is used by
-         * any operations (generally Neon) which the architecture defines
-         * as controlled by the standard FPSCR value rather than the FPSCR.
+        /* There are a number of distinct float control structures:
+         *
+         *  fp_status: is the "normal" fp status.
+         *  fp_status_fp16: used for half-precision calculations
+         *  standard_fp_status : the ARM "Standard FPSCR Value"
+         *
+         * Half-precision operations are governed by a separate
+         * flush-to-zero control bit in FPSCR:FZ16. We pass a separate
+         * status structure to control this.
+         *
+         * The "Standard FPSCR", ie default-NaN, flush-to-zero,
+         * round-to-nearest and is used by any operations (generally
+         * Neon) which the architecture defines as controlled by the
+         * standard FPSCR value rather than the FPSCR.
          *
          * To avoid having to transfer exception bits around, we simply
          * say that the FPSCR cumulative exception flags are the logical
-         * OR of the flags in the two fp statuses. This relies on the
+         * OR of the flags in the three fp statuses. This relies on the
          * only thing which needs to read the exception flags being
          * an explicit FPSCR read.
          */
         float_status fp_status;
+        float_status fp_status_f16;
         float_status standard_fp_status;
 
         /* ZCR_EL[1-3] */
@@ -1190,12 +1200,20 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 uint32_t vfp_get_fpscr(CPUARMState *env);
 void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 
-/* For A64 the FPSCR is split into two logically distinct registers,
+/* FPCR, Floating Point Control Register
+ * FPSR, Floating Poiht Status Register
+ *
+ * For A64 the FPSCR is split into two logically distinct registers,
  * FPCR and FPSR. However since they still use non-overlapping bits
  * we store the underlying state in fpscr and just mask on read/write.
  */
 #define FPSR_MASK 0xf800009f
 #define FPCR_MASK 0x07f79f00
+
+#define FPCR_FZ16   (1 << 19)   /* ARMv8.2+, FP16 flush-to-zero */
+#define FPCR_FZ     (1 << 24)   /* Flush-to-zero enable bit */
+#define FPCR_DN     (1 << 25)   /* Default NaN enable bit */
+
 static inline uint32_t vfp_get_fpsr(CPUARMState *env)
 {
     return vfp_get_fpscr(env) & FPSR_MASK;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c5bc69b961..f450eb200f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11103,6 +11103,7 @@ uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
             | (env->vfp.vec_stride << 20);
     i = get_float_exception_flags(&env->vfp.fp_status);
     i |= get_float_exception_flags(&env->vfp.standard_fp_status);
+    i |= get_float_exception_flags(&env->vfp.fp_status_f16);
     fpscr |= vfp_exceptbits_from_host(i);
     return fpscr;
 }
@@ -11160,16 +11161,31 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
             break;
         }
         set_float_rounding_mode(i, &env->vfp.fp_status);
+        set_float_rounding_mode(i, &env->vfp.fp_status_f16);
     }
-    if (changed & (1 << 24)) {
-        set_flush_to_zero((val & (1 << 24)) != 0, &env->vfp.fp_status);
-        set_flush_inputs_to_zero((val & (1 << 24)) != 0, &env->vfp.fp_status);
+    if (changed & FPCR_FZ16) {
+        bool ftz_enabled = val & FPCR_FZ16;
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status_f16);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status_f16);
+    }
+    if (changed & FPCR_FZ) {
+        bool ftz_enabled = val & FPCR_FZ;
+        set_flush_to_zero(ftz_enabled, &env->vfp.fp_status);
+        set_flush_inputs_to_zero(ftz_enabled, &env->vfp.fp_status);
+    }
+    if (changed & FPCR_DN) {
+        bool dnan_enabled = val & FPCR_DN;
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status);
+        set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16);
     }
-    if (changed & (1 << 25))
-        set_default_nan_mode((val & (1 << 25)) != 0, &env->vfp.fp_status);
 
+    /* The exception flags are ORed together when we read fpscr so we
+     * only need to preserve the current state in one of our
+     * float_status values.
+     */
     i = vfp_exceptbits_to_host(val);
     set_float_exception_flags(i, &env->vfp.fp_status);
+    set_float_exception_flags(0, &env->vfp.fp_status_f16);
     set_float_exception_flags(0, &env->vfp.standard_fp_status);
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1c88539d62..2c64d2b3fe 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -637,16 +637,21 @@ static void write_fp_sreg(DisasContext *s, int reg, TCGv_i32 v)
     tcg_temp_free_i64(tmp);
 }
 
-static TCGv_ptr get_fpstatus_ptr(void)
+static TCGv_ptr get_fpstatus_ptr(bool is_f16)
 {
     TCGv_ptr statusptr = tcg_temp_new_ptr();
     int offset;
 
-    /* In A64 all instructions (both FP and Neon) use the FPCR;
-     * there is no equivalent of the A32 Neon "standard FPSCR value"
-     * and all operations use vfp.fp_status.
+    /* In A64 all instructions (both FP and Neon) use the FPCR; there
+     * is no equivalent of the A32 Neon "standard FPSCR value".
+     * However half-precision operations operate under a different
+     * FZ16 flag and use vfp.fp_status_f16 instead of vfp.fp_status.
      */
-    offset = offsetof(CPUARMState, vfp.fp_status);
+    if (is_f16) {
+        offset = offsetof(CPUARMState, vfp.fp_status_f16);
+    } else {
+        offset = offsetof(CPUARMState, vfp.fp_status);
+    }
     tcg_gen_addi_ptr(statusptr, cpu_env, offset);
     return statusptr;
 }
@@ -4423,7 +4428,7 @@ static void handle_fp_compare(DisasContext *s, bool is_double,
                               bool cmp_with_zero, bool signal_all_nans)
 {
     TCGv_i64 tcg_flags = tcg_temp_new_i64();
-    TCGv_ptr fpst = get_fpstatus_ptr();
+    TCGv_ptr fpst = get_fpstatus_ptr(false);
 
     if (is_double) {
         TCGv_i64 tcg_vn, tcg_vm;
@@ -4598,7 +4603,7 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     TCGv_i32 tcg_op;
     TCGv_i32 tcg_res;
 
-    fpst = get_fpstatus_ptr();
+    fpst = get_fpstatus_ptr(false);
     tcg_op = read_fp_sreg(s, rn);
     tcg_res = tcg_temp_new_i32();
 
@@ -4660,7 +4665,7 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
         return;
     }
 
-    fpst = get_fpstatus_ptr();
+    fpst = get_fpstatus_ptr(false);
     tcg_op = read_fp_dreg(s, rn);
     tcg_res = tcg_temp_new_i64();
 
@@ -4840,7 +4845,7 @@ static void handle_fp_2src_single(DisasContext *s, int opcode,
     TCGv_ptr fpst;
 
     tcg_res = tcg_temp_new_i32();
-    fpst = get_fpstatus_ptr();
+    fpst = get_fpstatus_ptr(false);
     tcg_op1 = read_fp_sreg(s, rn);
     tcg_op2 = read_fp_sreg(s, rm);
 
@@ -4893,7 +4898,7 @@ static void handle_fp_2src_double(DisasContext *s, int opcode,
     TCGv_ptr fpst;
 
     tcg_res = tcg_temp_new_i64();
-    fpst = get_fpstatus_ptr();
+    fpst = get_fpstatus_ptr(false);
     tcg_op1 = read_fp_dreg(s, rn);
     tcg_op2 = read_fp_dreg(s, rm);
 
@@ -4979,7 +4984,7 @@ static void handle_fp_3src_single(DisasContext *s, bool o0, bool o1,
 {
     TCGv_i32 tcg_op1, tcg_op2, tcg_op3;
     TCGv_i32 tcg_res = tcg_temp_new_i32();
-    TCGv_ptr fpst = get_fpstatus_ptr();
+    TCGv_ptr fpst = get_fpstatus_ptr(false);
 
     tcg_op1 = read_fp_sreg(s, rn);
     tcg_op2 = read_fp_sreg(s, rm);
@@ -5017,7 +5022,7 @@ static void handle_fp_3src_double(DisasContext *s, bool o0, bool o1,
 {
     TCGv_i64 tcg_op1, tcg_op2, tcg_op3;
     TCGv_i64 tcg_res = tcg_temp_new_i64();
-    TCGv_ptr fpst = get_fpstatus_ptr();
+    TCGv_ptr fpst = get_fpstatus_ptr(false);
 
     tcg_op1 = read_fp_dreg(s, rn);
     tcg_op2 = read_fp_dreg(s, rm);
@@ -5158,7 +5163,7 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
     TCGv_ptr tcg_fpstatus;
     TCGv_i32 tcg_shift;
 
-    tcg_fpstatus = get_fpstatus_ptr();
+    tcg_fpstatus = get_fpstatus_ptr(false);
 
     tcg_shift = tcg_const_i32(64 - scale);
 
@@ -5870,7 +5875,7 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
         TCGv_i32 tcg_elt1 = tcg_temp_new_i32();
         TCGv_i32 tcg_elt2 = tcg_temp_new_i32();
         TCGv_i32 tcg_elt3 = tcg_temp_new_i32();
-        TCGv_ptr fpst = get_fpstatus_ptr();
+        TCGv_ptr fpst = get_fpstatus_ptr(false);
 
         assert(esize == 32);
         assert(elements == 4);
@@ -6372,7 +6377,7 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
         }
 
         size = extract32(size, 0, 1) ? 3 : 2;
-        fpst = get_fpstatus_ptr();
+        fpst = get_fpstatus_ptr(false);
         break;
     default:
         unallocated_encoding(s);
@@ -6864,7 +6869,7 @@ static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int fracbits, int size)
 {
     bool is_double = size == 3 ? true : false;
-    TCGv_ptr tcg_fpst = get_fpstatus_ptr();
+    TCGv_ptr tcg_fpst = get_fpstatus_ptr(false);
     TCGv_i32 tcg_shift = tcg_const_i32(fracbits);
     TCGv_i64 tcg_int = tcg_temp_new_i64();
     TCGMemOp mop = size | (is_signed ? MO_SIGN : 0);
@@ -6980,7 +6985,7 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
 
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(FPROUNDING_ZERO));
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
-    tcg_fpstatus = get_fpstatus_ptr();
+    tcg_fpstatus = get_fpstatus_ptr(false);
     tcg_shift = tcg_const_i32(fracbits);
 
     if (is_double) {
@@ -7326,7 +7331,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                                int fpopcode, int rd, int rn, int rm)
 {
     int pass;
-    TCGv_ptr fpst = get_fpstatus_ptr();
+    TCGv_ptr fpst = get_fpstatus_ptr(false);
 
     for (pass = 0; pass < elements; pass++) {
         if (size) {
@@ -7790,7 +7795,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
         return;
     }
 
-    fpst = get_fpstatus_ptr();
+    fpst = get_fpstatus_ptr(false);
 
     if (is_double) {
         TCGv_i64 tcg_op = tcg_temp_new_i64();
@@ -7897,7 +7902,7 @@ static void handle_2misc_reciprocal(DisasContext *s, int opcode,
                                     int size, int rn, int rd)
 {
     bool is_double = (size == 3);
-    TCGv_ptr fpst = get_fpstatus_ptr();
+    TCGv_ptr fpst = get_fpstatus_ptr(false);
 
     if (is_double) {
         TCGv_i64 tcg_op = tcg_temp_new_i64();
@@ -8296,7 +8301,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     if (is_fcvt) {
         tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
         gen_helper_set_rmode(tcg_rmode, tcg_rmode, cpu_env);
-        tcg_fpstatus = get_fpstatus_ptr();
+        tcg_fpstatus = get_fpstatus_ptr(false);
     } else {
         tcg_rmode = NULL;
         tcg_fpstatus = NULL;
@@ -9516,7 +9521,7 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
 
     /* Floating point operations need fpst */
     if (opcode >= 0x58) {
-        fpst = get_fpstatus_ptr();
+        fpst = get_fpstatus_ptr(false);
     } else {
         fpst = NULL;
     }
@@ -10676,7 +10681,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 
     if (need_fpstatus) {
-        tcg_fpstatus = get_fpstatus_ptr();
+        tcg_fpstatus = get_fpstatus_ptr(false);
     } else {
         tcg_fpstatus = NULL;
     }
@@ -11056,7 +11061,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 
     if (is_fp) {
-        fpst = get_fpstatus_ptr();
+        fpst = get_fpstatus_ptr(false);
     } else {
         fpst = NULL;
     }
-- 
2.15.1
