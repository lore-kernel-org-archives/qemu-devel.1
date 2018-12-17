Received: from eggs.gnu.org ([2001:4830:134:3::10]:37356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYrx5-0001st-JA
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYrx4-000569-8d
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:24:51 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 17 Dec 2018 12:24:02 +0000
Message-Id: <20181217122405.18732-7-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20181217122405.18732-1-mark.cave-ayland@ilande.co.uk>
References: <20181217122405.18732-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [RFC PATCH v2 6/9] target/ppc: merge ppc_vsr_t and
 ppc_avr_t union types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org, lvivier@redhat.com

Since the VSX registers are actually a superset of the VMX registers then they
can be represented by the same type. Merge ppc_avr_t into ppc_vsr_t and change
ppc_avr_t to be a simple typedef alias.

Note that due to a difference in the naming of the float32 member between
ppc_avr_t and ppc_vsr_t, references to the ppc_avr_t f member must be replaced
with f32 instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/cpu.h        | 17 ++++++++-------
 target/ppc/int_helper.c | 56 +++++++++++++++++++++++++------------------------
 target/ppc/internal.h   | 11 ----------
 3 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index ab68abe8a2..5445d4c3c1 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -230,7 +230,6 @@ typedef struct opc_handler_t opc_handler_t;
 /* Types used to describe some PowerPC registers etc. */
 typedef struct DisasContext DisasContext;
 typedef struct ppc_spr_t ppc_spr_t;
-typedef union ppc_avr_t ppc_avr_t;
 typedef union ppc_tlb_t ppc_tlb_t;
 typedef struct ppc_hash_pte64 ppc_hash_pte64_t;
 
@@ -254,22 +253,26 @@ struct ppc_spr_t {
 #endif
 };
 
-/* Altivec registers (128 bits) */
-union ppc_avr_t {
-    float32 f[4];
+/* VSX/Altivec registers (128 bits) */
+typedef union _ppc_vsr_t {
     uint8_t u8[16];
     uint16_t u16[8];
     uint32_t u32[4];
+    uint64_t u64[2];
     int8_t s8[16];
     int16_t s16[8];
     int32_t s32[4];
-    uint64_t u64[2];
     int64_t s64[2];
+    float32 f32[4];
+    float64 f64[2];
+    float128 f128;
 #ifdef CONFIG_INT128
     __uint128_t u128;
 #endif
-    Int128 s128;
-};
+    Int128  s128;
+} ppc_vsr_t;
+
+typedef ppc_vsr_t ppc_avr_t;
 
 #if !defined(CONFIG_USER_ONLY)
 /* Software TLB cache */
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index fcac90a4a9..9d715be25c 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -548,8 +548,8 @@ VARITH_DO(muluwm, *, u32)
     {                                                                   \
         int i;                                                          \
                                                                         \
-        for (i = 0; i < ARRAY_SIZE(r->f); i++) {                        \
-            r->f[i] = func(a->f[i], b->f[i], &env->vec_status);         \
+        for (i = 0; i < ARRAY_SIZE(r->f32); i++) {                      \
+            r->f32[i] = func(a->f32[i], b->f32[i], &env->vec_status);   \
         }                                                               \
     }
 VARITHFP(addfp, float32_add)
@@ -563,9 +563,9 @@ VARITHFP(maxfp, float32_max)
                            ppc_avr_t *b, ppc_avr_t *c)                  \
     {                                                                   \
         int i;                                                          \
-        for (i = 0; i < ARRAY_SIZE(r->f); i++) {                        \
-            r->f[i] = float32_muladd(a->f[i], c->f[i], b->f[i],         \
-                                     type, &env->vec_status);           \
+        for (i = 0; i < ARRAY_SIZE(r->f32); i++) {                      \
+            r->f32[i] = float32_muladd(a->f32[i], c->f32[i], b->f32[i], \
+                                       type, &env->vec_status);         \
         }                                                               \
     }
 VARITHFPFMA(maddfp, 0);
@@ -670,9 +670,9 @@ VABSDU(w, u32)
     {                                                                   \
         int i;                                                          \
                                                                         \
-        for (i = 0; i < ARRAY_SIZE(r->f); i++) {                        \
+        for (i = 0; i < ARRAY_SIZE(r->f32); i++) {                      \
             float32 t = cvt(b->element[i], &env->vec_status);           \
-            r->f[i] = float32_scalbn(t, -uim, &env->vec_status);        \
+            r->f32[i] = float32_scalbn(t, -uim, &env->vec_status);      \
         }                                                               \
     }
 VCF(ux, uint32_to_float32, u32)
@@ -782,9 +782,9 @@ VCMPNE(w, u32, uint32_t, 0)
         uint32_t none = 0;                                              \
         int i;                                                          \
                                                                         \
-        for (i = 0; i < ARRAY_SIZE(r->f); i++) {                        \
+        for (i = 0; i < ARRAY_SIZE(r->f32); i++) {                      \
             uint32_t result;                                            \
-            int rel = float32_compare_quiet(a->f[i], b->f[i],           \
+            int rel = float32_compare_quiet(a->f32[i], b->f32[i],       \
                                             &env->vec_status);          \
             if (rel == float_relation_unordered) {                      \
                 result = 0;                                             \
@@ -816,14 +816,16 @@ static inline void vcmpbfp_internal(CPUPPCState *env, ppc_avr_t *r,
     int i;
     int all_in = 0;
 
-    for (i = 0; i < ARRAY_SIZE(r->f); i++) {
-        int le_rel = float32_compare_quiet(a->f[i], b->f[i], &env->vec_status);
+    for (i = 0; i < ARRAY_SIZE(r->f32); i++) {
+        int le_rel = float32_compare_quiet(a->f32[i], b->f32[i],
+                                           &env->vec_status);
         if (le_rel == float_relation_unordered) {
             r->u32[i] = 0xc0000000;
             all_in = 1;
         } else {
-            float32 bneg = float32_chs(b->f[i]);
-            int ge_rel = float32_compare_quiet(a->f[i], bneg, &env->vec_status);
+            float32 bneg = float32_chs(b->f32[i]);
+            int ge_rel = float32_compare_quiet(a->f32[i], bneg,
+                                               &env->vec_status);
             int le = le_rel != float_relation_greater;
             int ge = ge_rel != float_relation_less;
 
@@ -856,11 +858,11 @@ void helper_vcmpbfp_dot(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
         float_status s = env->vec_status;                               \
                                                                         \
         set_float_rounding_mode(float_round_to_zero, &s);               \
-        for (i = 0; i < ARRAY_SIZE(r->f); i++) {                        \
-            if (float32_is_any_nan(b->f[i])) {                          \
+        for (i = 0; i < ARRAY_SIZE(r->f32); i++) {                      \
+            if (float32_is_any_nan(b->f32[i])) {                        \
                 r->element[i] = 0;                                      \
             } else {                                                    \
-                float64 t = float32_to_float64(b->f[i], &s);            \
+                float64 t = float32_to_float64(b->f32[i], &s);          \
                 int64_t j;                                              \
                                                                         \
                 t = float64_scalbn(t, uim, &s);                         \
@@ -1661,8 +1663,8 @@ void helper_vrefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
 {
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(r->f); i++) {
-        r->f[i] = float32_div(float32_one, b->f[i], &env->vec_status);
+    for (i = 0; i < ARRAY_SIZE(r->f32); i++) {
+        r->f32[i] = float32_div(float32_one, b->f32[i], &env->vec_status);
     }
 }
 
@@ -1674,8 +1676,8 @@ void helper_vrefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
         float_status s = env->vec_status;                       \
                                                                 \
         set_float_rounding_mode(rounding, &s);                  \
-        for (i = 0; i < ARRAY_SIZE(r->f); i++) {                \
-            r->f[i] = float32_round_to_int (b->f[i], &s);       \
+        for (i = 0; i < ARRAY_SIZE(r->f32); i++) {              \
+            r->f32[i] = float32_round_to_int (b->f32[i], &s);   \
         }                                                       \
     }
 VRFI(n, float_round_nearest_even)
@@ -1705,10 +1707,10 @@ void helper_vrsqrtefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
 {
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(r->f); i++) {
-        float32 t = float32_sqrt(b->f[i], &env->vec_status);
+    for (i = 0; i < ARRAY_SIZE(r->f32); i++) {
+        float32 t = float32_sqrt(b->f32[i], &env->vec_status);
 
-        r->f[i] = float32_div(float32_one, t, &env->vec_status);
+        r->f32[i] = float32_div(float32_one, t, &env->vec_status);
     }
 }
 
@@ -1751,8 +1753,8 @@ void helper_vexptefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
 {
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(r->f); i++) {
-        r->f[i] = float32_exp2(b->f[i], &env->vec_status);
+    for (i = 0; i < ARRAY_SIZE(r->f32); i++) {
+        r->f32[i] = float32_exp2(b->f32[i], &env->vec_status);
     }
 }
 
@@ -1760,8 +1762,8 @@ void helper_vlogefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
 {
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(r->f); i++) {
-        r->f[i] = float32_log2(b->f[i], &env->vec_status);
+    for (i = 0; i < ARRAY_SIZE(r->f32); i++) {
+        r->f32[i] = float32_log2(b->f32[i], &env->vec_status);
     }
 }
 
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index a9bcadff42..b4b1f7b3db 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -204,17 +204,6 @@ EXTRACT_HELPER(IMM8, 11, 8);
 EXTRACT_HELPER(DCMX, 16, 7);
 EXTRACT_HELPER_SPLIT_3(DCMX_XV, 5, 16, 0, 1, 2, 5, 1, 6, 6);
 
-typedef union _ppc_vsr_t {
-    uint8_t u8[16];
-    uint16_t u16[8];
-    uint32_t u32[4];
-    uint64_t u64[2];
-    float32 f32[4];
-    float64 f64[2];
-    float128 f128;
-    Int128  s128;
-} ppc_vsr_t;
-
 #if defined(HOST_WORDS_BIGENDIAN)
 #define VsrB(i) u8[i]
 #define VsrH(i) u16[i]
-- 
2.11.0
