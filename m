Received: from eggs.gnu.org ([209.51.188.92]:39688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtvbu-00007L-W7
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gtvbr-0002MT-7v
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:34:02 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 13 Feb 2019 15:33:19 +0100
Message-Id: <20190213143322.31371-13-david@redhat.com>
In-Reply-To: <20190213143322.31371-1-david@redhat.com>
References: <20190213143322.31371-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/15] s390x/tcg: Implement XxC and checks
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

Check for valid rounding modes and forward also the XxC (via m4). To avoid
a lot of boilerplate code and changes to the helpers, combine both, the
m3 and m4 field in a combined 32 bit TCG variable. Perform checks at
a central place, taking in account if the m3 or m4 field was ignore
before the floating-point extension facility was introduced.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/fpu_helper.c | 138 ++++++++++++----------
 target/s390x/translate.c  | 235 ++++++++++++++++++++++++++++----------
 2 files changed, 247 insertions(+), 126 deletions(-)

diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index f6f010ae35..a9fad6b3cd 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -170,6 +170,17 @@ uint32_t set_cc_nz_f128(float128 v)
     }
 }
 
+static inline uint8_t round_from_m34(uint32_t m34)
+{
+    return extract32(m34, 0, 4);
+}
+
+static inline bool xxc_from_m34(uint32_t m34)
+{
+    /* XxC is bit 1 of m4 */
+    return (extract32(m34, 4, 4) & 0x4) != 0;
+}
+
 /* 32-bit FP addition */
 uint64_t HELPER(aeb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
@@ -407,238 +418,239 @@ void s390_restore_bfp_rounding_mode(CPUS390XState *env, int old_mode)
 }
 
 /* convert 64-bit int to 32-bit float */
-uint64_t HELPER(cegb)(CPUS390XState *env, int64_t v2, uint32_t m3)
+uint64_t HELPER(cegb)(CPUS390XState *env, int64_t v2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     float32 ret = int64_to_float32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 64-bit int to 64-bit float */
-uint64_t HELPER(cdgb)(CPUS390XState *env, int64_t v2, uint32_t m3)
+uint64_t HELPER(cdgb)(CPUS390XState *env, int64_t v2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     float64 ret = int64_to_float64(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 64-bit int to 128-bit float */
-uint64_t HELPER(cxgb)(CPUS390XState *env, int64_t v2, uint32_t m3)
+uint64_t HELPER(cxgb)(CPUS390XState *env, int64_t v2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     float128 ret = int64_to_float128(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return RET128(ret);
 }
 
 /* convert 64-bit uint to 32-bit float */
-uint64_t HELPER(celgb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(celgb)(CPUS390XState *env, uint64_t v2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     float32 ret = uint64_to_float32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 64-bit uint to 64-bit float */
-uint64_t HELPER(cdlgb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(cdlgb)(CPUS390XState *env, uint64_t v2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     float64 ret = uint64_to_float64(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 64-bit uint to 128-bit float */
-uint64_t HELPER(cxlgb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(cxlgb)(CPUS390XState *env, uint64_t v2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     float128 ret = uint64_to_float128(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return RET128(ret);
 }
 
 /* convert 32-bit float to 64-bit int */
-uint64_t HELPER(cgeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(cgeb)(CPUS390XState *env, uint64_t v2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     int64_t ret = float32_to_int64(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 64-bit float to 64-bit int */
-uint64_t HELPER(cgdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(cgdb)(CPUS390XState *env, uint64_t v2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     int64_t ret = float64_to_int64(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 128-bit float to 64-bit int */
-uint64_t HELPER(cgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
+uint64_t HELPER(cgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     float128 v2 = make_float128(h, l);
     int64_t ret = float128_to_int64(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 32-bit float to 32-bit int */
-uint64_t HELPER(cfeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(cfeb)(CPUS390XState *env, uint64_t v2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     int32_t ret = float32_to_int32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 64-bit float to 32-bit int */
-uint64_t HELPER(cfdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(cfdb)(CPUS390XState *env, uint64_t v2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     int32_t ret = float64_to_int32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 128-bit float to 32-bit int */
-uint64_t HELPER(cfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
+uint64_t HELPER(cfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     float128 v2 = make_float128(h, l);
     int32_t ret = float128_to_int32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 32-bit float to 64-bit uint */
-uint64_t HELPER(clgeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(clgeb)(CPUS390XState *env, uint64_t v2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     uint64_t ret;
 
     v2 = float32_to_float64(v2, &env->fpu_status);
     ret = float64_to_uint64(v2, &env->fpu_status);
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 64-bit float to 64-bit uint */
-uint64_t HELPER(clgdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(clgdb)(CPUS390XState *env, uint64_t v2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     uint64_t ret = float64_to_uint64(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 128-bit float to 64-bit uint */
-uint64_t HELPER(clgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
+uint64_t HELPER(clgxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     uint64_t ret = float128_to_uint64(make_float128(h, l), &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 32-bit float to 32-bit uint */
-uint64_t HELPER(clfeb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(clfeb)(CPUS390XState *env, uint64_t v2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     uint32_t ret = float32_to_uint32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 64-bit float to 32-bit uint */
-uint64_t HELPER(clfdb)(CPUS390XState *env, uint64_t v2, uint32_t m3)
+uint64_t HELPER(clfdb)(CPUS390XState *env, uint64_t v2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     uint32_t ret = float64_to_uint32(v2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* convert 128-bit float to 32-bit uint */
-uint64_t HELPER(clfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m3)
+uint64_t HELPER(clfxb)(CPUS390XState *env, uint64_t h, uint64_t l, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     uint32_t ret = float128_to_uint32(make_float128(h, l), &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* round to integer 32-bit */
-uint64_t HELPER(fieb)(CPUS390XState *env, uint64_t f2, uint32_t m3)
+uint64_t HELPER(fieb)(CPUS390XState *env, uint64_t f2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     float32 ret = float32_round_to_int(f2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* round to integer 64-bit */
-uint64_t HELPER(fidb)(CPUS390XState *env, uint64_t f2, uint32_t m3)
+uint64_t HELPER(fidb)(CPUS390XState *env, uint64_t f2, uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     float64 ret = float64_round_to_int(f2, &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return ret;
 }
 
 /* round to integer 128-bit */
-uint64_t HELPER(fixb)(CPUS390XState *env, uint64_t ah, uint64_t al, uint32_t m3)
+uint64_t HELPER(fixb)(CPUS390XState *env, uint64_t ah, uint64_t al,
+                      uint32_t m34)
 {
-    int old_mode = s390_swap_bfp_rounding_mode(env, m3);
+    int old_mode = s390_swap_bfp_rounding_mode(env, round_from_m34(m34));
     float128 ret = float128_round_to_int(make_float128(ah, al),
                                          &env->fpu_status);
 
     s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_exceptions(env, false, GETPC());
+    handle_exceptions(env, xxc_from_m34(m34), GETPC());
     return RET128(ret);
 }
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index c2645891e8..e252ba375c 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1758,160 +1758,257 @@ static DisasJumpType op_cxb(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+static TCGv_i32 fpinst_extract_m34(DisasContext *s, bool m3_with_fpe,
+                                   bool m4_with_fpe)
+{
+    const bool fpe = s390_has_feat(S390_FEAT_FLOATING_POINT_EXT);
+    uint8_t m3 = get_field(s->fields, m3);
+    uint8_t m4 = get_field(s->fields, m4);
+
+    /* m3 field was introduced with FPE */
+    if (!fpe && m3_with_fpe) {
+        m3 = 0;
+    }
+    /* m4 field was introduced with FPE */
+    if (!fpe && m4_with_fpe) {
+        m4 = 0;
+    }
+
+    /* Check for valid rounding modes. Mode 3 was introduced later. */
+    if (m3 == 2 || m3 > 7 || (!fpe && m3 == 3)) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return NULL;
+    }
+
+    return tcg_const_i32(deposit32(m3, 4, 4, m4));
+}
+
 static DisasJumpType op_cfeb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cfeb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, true);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_cfeb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     gen_set_cc_nz_f32(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cfdb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cfdb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, true);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_cfdb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     gen_set_cc_nz_f64(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cfxb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cfxb(o->out, cpu_env, o->in1, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, true);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_cfxb(o->out, cpu_env, o->in1, o->in2, m34);
+    tcg_temp_free_i32(m34);
     gen_set_cc_nz_f128(s, o->in1, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cgeb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cgeb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, true);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_cgeb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     gen_set_cc_nz_f32(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cgdb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cgdb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, true);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_cgdb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     gen_set_cc_nz_f64(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cgxb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cgxb(o->out, cpu_env, o->in1, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, true);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_cgxb(o->out, cpu_env, o->in1, o->in2, m34);
+    tcg_temp_free_i32(m34);
     gen_set_cc_nz_f128(s, o->in1, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_clfeb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_clfeb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, false);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_clfeb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     gen_set_cc_nz_f32(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_clfdb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_clfdb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, false);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_clfdb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     gen_set_cc_nz_f64(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_clfxb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_clfxb(o->out, cpu_env, o->in1, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, false);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_clfxb(o->out, cpu_env, o->in1, o->in2, m34);
+    tcg_temp_free_i32(m34);
     gen_set_cc_nz_f128(s, o->in1, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_clgeb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_clgeb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, false);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_clgeb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     gen_set_cc_nz_f32(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_clgdb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_clgdb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, false);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_clgdb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     gen_set_cc_nz_f64(s, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_clgxb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_clgxb(o->out, cpu_env, o->in1, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, false);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_clgxb(o->out, cpu_env, o->in1, o->in2, m34);
+    tcg_temp_free_i32(m34);
     gen_set_cc_nz_f128(s, o->in1, o->in2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cegb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cegb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, true, true);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_cegb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cdgb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cdgb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, true, true);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_cdgb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cxgb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cxgb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, true, true);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_cxgb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     return_low128(o->out2);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_celgb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_celgb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, false);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_celgb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cdlgb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cdlgb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, false);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_cdlgb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_cxlgb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_cxlgb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, false);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_cxlgb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     return_low128(o->out2);
     return DISAS_NEXT;
 }
@@ -2390,26 +2487,38 @@ static DisasJumpType op_ex(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_fieb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_fieb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, true);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_fieb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_fidb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_fidb(o->out, cpu_env, o->in2, m3);
-    tcg_temp_free_i32(m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, true);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_fidb(o->out, cpu_env, o->in2, m34);
+    tcg_temp_free_i32(m34);
     return DISAS_NEXT;
 }
 
 static DisasJumpType op_fixb(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 m3 = tcg_const_i32(get_field(s->fields, m3));
-    gen_helper_fixb(o->out, cpu_env, o->in1, o->in2, m3);
+    TCGv_i32 m34 = fpinst_extract_m34(s, false, true);
+
+    if (!m34) {
+        return DISAS_NORETURN;
+    }
+    gen_helper_fixb(o->out, cpu_env, o->in1, o->in2, m34);
     return_low128(o->out2);
-    tcg_temp_free_i32(m3);
+    tcg_temp_free_i32(m34);
     return DISAS_NEXT;
 }
 
-- 
2.17.2
