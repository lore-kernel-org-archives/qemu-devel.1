Received: from eggs.gnu.org ([209.51.188.92]:54189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVrC-0006CT-J0
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtVr6-0003Gr-4g
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:04:06 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 12 Feb 2019 12:03:05 +0100
Message-Id: <20190212110308.13707-14-david@redhat.com>
In-Reply-To: <20190212110308.13707-1-david@redhat.com>
References: <20190212110308.13707-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 12/15] s390x/tcg: Implement XxC and checks
 for most FP instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

With the floating-point extension facility
- CONVERT FROM LOGICAL
- CONVERT TO LOGICAL
- CONVERT TO FIXED
- CONVERT FROM FIXED
- LOAD FP INTEGER
have both, a rounding mode specification and the inexact-exception control
(XxC). Other instructions will be handled separatly.

Check for valid rounding modes and forward also the XxC. To avoid a lot
of boilerplate code and changes to the helpers, combine both, the m3 and
m4 field in a combined 32 bit TCG variable. Mangle/unmangle on a 8bit
basis, so this can be reused for other fields later on.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 126 +++++++++----------
 target/s390x/internal.h   |   6 +
 target/s390x/translate.c  | 254 ++++++++++++++++++++++++++++----------
 3 files changed, 260 insertions(+), 126 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 5136147da6..a0501b9ee5 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -407,239 +407,239 @@ void s390_restore_bfp_rounding_mode(CPUS390XState *env, int old_mode)
 }
 
 /* convert 64-bit int to 32-bit float */
-uint64_t HELPER(cegb)(CPUS390XState *env, int64_t v2, uint32_t m3)
+uint64_t HELPER(cegb)(CPUS390XState *env, int64_t v2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
 
     float32 ret = int64_to_float32(v2, &env->fpu_status);
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* convert 64-bit int to 64-bit float */
-uint64_t HELPER(cdgb)(CPUS390XState *env, int64_t v2, uint32_t m3)
+uint64_t HELPER(cdgb)(CPUS390XState *env, int64_t v2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
 
     float64 ret = int64_to_float64(v2, &env->fpu_status);
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* convert 64-bit int to 128-bit float */
-uint64_t HELPER(cxgb)(CPUS390XState *env, int64_t v2, uint32_t m3)
+uint64_t HELPER(cxgb)(CPUS390XState *env, int64_t v2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
 
     float128 ret = int64_to_float128(v2, &env->fpu_status);
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return RET128(ret);
 }
 
 /* convert 64-bit uint to 32-bit float */
-uint64_t HELPER(celgb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(celgb)(CPUS390XState *env, uint64_t v2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
 
     float32 ret = uint64_to_float32(v2, &env->fpu_status);
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* convert 64-bit uint to 64-bit float */
-uint64_t HELPER(cdlgb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(cdlgb)(CPUS390XState *env, uint64_t v2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
 
     float64 ret = uint64_to_float64(v2, &env->fpu_status);
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* convert 64-bit uint to 128-bit float */
-uint64_t HELPER(cxlgb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(cxlgb)(CPUS390XState *env, uint64_t v2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
 
     float128 ret = uint64_to_float128(v2, &env->fpu_status);
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return RET128(ret);
 }
 
 /* convert 32-bit float to 64-bit int */
-uint64_t HELPER(cgeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(cgeb)(CPUS390XState *env, uint64_t v2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
     int64_t ret = float32_to_int64(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* convert 64-bit float to 64-bit int */
-uint64_t HELPER(cgdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(cgdb)(CPUS390XState *env, uint64_t v2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
     int64_t ret = float64_to_int64(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* convert 128-bit float to 64-bit int */
-uint64_t HELPER(cgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
+uint64_t HELPER(cgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
     float128 v2 = make_float128(h, l);
     int64_t ret = float128_to_int64(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* convert 32-bit float to 32-bit int */
-uint64_t HELPER(cfeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(cfeb)(CPUS390XState *env, uint64_t v2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
     int32_t ret = float32_to_int32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* convert 64-bit float to 32-bit int */
-uint64_t HELPER(cfdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(cfdb)(CPUS390XState *env, uint64_t v2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
     int32_t ret = float64_to_int32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* convert 128-bit float to 32-bit int */
-uint64_t HELPER(cfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
+uint64_t HELPER(cfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
 
     float128 v2 = make_float128(h, l);
     int32_t ret = float128_to_int32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* convert 32-bit float to 64-bit uint */
-uint64_t HELPER(clgeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(clgeb)(CPUS390XState *env, uint64_t v2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
     uint64_t ret;
 
     v2 = float32_to_float64(v2, &env->fpu_status);
     ret = float64_to_uint64(v2, &env->fpu_status);
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* convert 64-bit float to 64-bit uint */
-uint64_t HELPER(clgdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(clgdb)(CPUS390XState *env, uint64_t v2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
 
     uint64_t ret = float64_to_uint64(v2, &env->fpu_status);
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* convert 128-bit float to 64-bit uint */
-uint64_t HELPER(clgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
+uint64_t HELPER(clgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
     uint64_t ret = float128_to_uint64(make_float128(h, l), &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* convert 32-bit float to 32-bit uint */
-uint64_t HELPER(clfeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(clfeb)(CPUS390XState *env, uint64_t v2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
     uint32_t ret = float32_to_uint32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* convert 64-bit float to 32-bit uint */
-uint64_t HELPER(clfdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(clfdb)(CPUS390XState *env, uint64_t v2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
     uint32_t ret = float64_to_uint32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* convert 128-bit float to 32-bit uint */
-uint64_t HELPER(clfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
+uint64_t HELPER(clfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
     uint32_t ret = float128_to_uint32(make_float128(h, l), &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* round to integer 32-bit */
-uint64_t HELPER(fieb)(CPUS390XState *env, uint64_t f2, uint32_t m3)
+uint64_t HELPER(fieb)(CPUS390XState *env, uint64_t f2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
 
     float32 ret = float32_round_to_int(f2, &env->fpu_status);
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* round to integer 64-bit */
-uint64_t HELPER(fidb)(CPUS390XState *env, uint64_t f2, uint32_t m3)
+uint64_t HELPER(fidb)(CPUS390XState *env, uint64_t f2, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
 
     float64 ret = float64_round_to_int(f2, &env->fpu_status);
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return ret;
 }
 
 /* round to integer 128-bit */
-uint64_t HELPER(fixb)(CPUS390XState *env, uint64_t ah, uint64_t al, uint32_t m3)
+uint64_t HELPER(fixb)(CPUS390XState *env, uint64_t ah, uint64_t al, uint32_t m)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, m & 0xf);
 
     float128 ret = float128_round_to_int(make_float128(ah, al),
                                          &env->fpu_status);
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, (m >> 8) & 1, GETPC());
     return RET128(ret);
 }
 
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 122fe037bc..b7bb46404f 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -176,6 +176,12 @@ static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
     return a;
 }
 
+/* verify a bfp rounding mode as specified e.g. via m3 field */
+static inline bool valid_bfp_rounding_mode(uint8_t mode)
+{
+    return mode != 2 && mode <= 7;
+}
+
 /* CC optimization */
 
 /* Instead of computing the condition codes after each x86 instruction,
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index f58155f20c..e7cfc80131 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1051,6 +1051,8 @@ struct DisasFields {
 /* This is the way fields are to be accessed out of DisasFields.  */
 #define have_field(S, F)  have_field1((S), FLD_O_##F)
 #define get_field(S, F)   get_field1((S), FLD_O_##F, FLD_C_##F)
+#define get_fields2(S, F1, F2) (get_field1((S), FLD_O_##F1, FLD_C_##F1) | \
+                                get_field1((S), FLD_O_##F2, FLD_C_##F2) << 8)
 
 static bool have_field1(const DisasFields *f, enum DisasFieldIndexO c)
 {
@@ -1760,158 +1762,266 @@ static DisasJumpType op_cxb(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_cfeb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cfeb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_cfeb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     gen_set_cc_nz_f32(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cfdb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cfdb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_cfdb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     gen_set_cc_nz_f64(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cfxb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cfxb(o->out, cpu_env, o->in1, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_cfxb(o->out, cpu_env, o->in1, o->in2, m);
+    tcg_temp_free_i32(m);
     gen_set_cc_nz_f128(s, o->in1, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cgeb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cgeb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_cgeb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     gen_set_cc_nz_f32(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cgdb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cgdb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_cgdb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     gen_set_cc_nz_f64(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cgxb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cgxb(o->out, cpu_env, o->in1, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_cgxb(o->out, cpu_env, o->in1, o->in2, m);
+    tcg_temp_free_i32(m);
     gen_set_cc_nz_f128(s, o->in1, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_clfeb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_clfeb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_clfeb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     gen_set_cc_nz_f32(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_clfdb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_clfdb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_clfdb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     gen_set_cc_nz_f64(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_clfxb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_clfxb(o->out, cpu_env, o->in1, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_clfxb(o->out, cpu_env, o->in1, o->in2, m);
+    tcg_temp_free_i32(m);
     gen_set_cc_nz_f128(s, o->in1, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_clgeb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_clgeb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_clgeb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     gen_set_cc_nz_f32(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_clgdb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_clgdb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_clgdb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     gen_set_cc_nz_f64(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_clgxb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_clgxb(o->out, cpu_env, o->in1, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_clgxb(o->out, cpu_env, o->in1, o->in2, m);
+    tcg_temp_free_i32(m);
     gen_set_cc_nz_f128(s, o->in1, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cegb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cegb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_cegb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cdgb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cdgb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_cdgb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cxgb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cxgb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_cxgb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     return_low128(o->out2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_celgb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_celgb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_celgb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cdlgb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cdlgb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_cdlgb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cxlgb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cxlgb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_cxlgb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     return_low128(o->out2);
     return DISAS_NEXT;
 }
@@ -2390,26 +2500,44 @@ static DisasJumpType op_ex(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_fieb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_fieb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_fieb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_fidb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_fidb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_fidb(o->out, cpu_env, o->in2, m);
+    tcg_temp_free_i32(m);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_fixb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_fixb(o->out, cpu_env, o->in1, o->in2, m3);
+    TCGv_i32 m;
+
+    if (!valid_bfp_rounding_mode(get_field(s->fields, m3))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    m = tcg_const_i32(get_fields2(s->fields, m3, m4));
+    gen_helper_fixb(o->out, cpu_env, o->in1, o->in2, m);
     return_low128(o->out2);
-    tcg_temp_free_i32(m3);
+    tcg_temp_free_i32(m);
     return DISAS_NEXT;
 }
 
-- 
2.17.2
