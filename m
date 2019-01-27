Received: from eggs.gnu.org ([209.51.188.92]:53759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gngLq-0004RI-V1
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 04:03:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gngLo-0008G2-VC
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 04:03:38 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 27 Jan 2019 09:03:06 +0000
Message-Id: <20190127090306.30826-9-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
References: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v3 8/8] target/ppc: remove various
 HOST_WORDS_BIGENDIAN hacks in int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org, david@gibson.dropbear.id.au

Following on from the previous work, there are numerous endian-related hacks
in int_helper.c that can now be replaced with Vsr* macros.

There are also a few places where the VECTOR_FOR_INORDER_I macro can be
replaced with a normal iterator since the processing order is irrelevant.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 155 ++++++++++++++----------------------------------
 1 file changed, 45 insertions(+), 110 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index c3eba9ed41..3b4cf248e9 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -443,8 +443,8 @@ void helper_lvsl(ppc_avr_t *r, target_ulong sh)
 {
     int i, j = (sh & 0xf);
 
-    VECTOR_FOR_INORDER_I(i, u8) {
-        r->u8[i] = j++;
+    for (i = 0; i < ARRAY_SIZE(r->u8); i++) {
+        r->VsrB(i) = j++;
     }
 }
 
@@ -452,18 +452,14 @@ void helper_lvsr(ppc_avr_t *r, target_ulong sh)
 {
     int i, j = 0x10 - (sh & 0xf);
 
-    VECTOR_FOR_INORDER_I(i, u8) {
-        r->u8[i] = j++;
+    for (i = 0; i < ARRAY_SIZE(r->u8); i++) {
+        r->VsrB(i) = j++;
     }
 }
 
 void helper_mtvscr(CPUPPCState *env, ppc_avr_t *r)
 {
-#if defined(HOST_WORDS_BIGENDIAN)
-    env->vscr = r->u32[3];
-#else
-    env->vscr = r->u32[0];
-#endif
+    env->vscr = r->VsrW(3);
     set_flush_to_zero(vscr_nj, &env->vec_status);
 }
 
@@ -870,8 +866,8 @@ target_ulong helper_vclzlsbb(ppc_avr_t *r)
 {
     target_ulong count = 0;
     int i;
-    VECTOR_FOR_INORDER_I(i, u8) {
-        if (r->u8[i] & 0x01) {
+    for (i = 0; i < ARRAY_SIZE(r->u8); i++) {
+        if (r->VsrB(i) & 0x01) {
             break;
         }
         count++;
@@ -883,12 +879,8 @@ target_ulong helper_vctzlsbb(ppc_avr_t *r)
 {
     target_ulong count = 0;
     int i;
-#if defined(HOST_WORDS_BIGENDIAN)
     for (i = ARRAY_SIZE(r->u8) - 1; i >= 0; i--) {
-#else
-    for (i = 0; i < ARRAY_SIZE(r->u8); i++) {
-#endif
-        if (r->u8[i] & 0x01) {
+        if (r->VsrB(i) & 0x01) {
             break;
         }
         count++;
@@ -1151,18 +1143,14 @@ void helper_vperm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b,
     ppc_avr_t result;
     int i;
 
-    VECTOR_FOR_INORDER_I(i, u8) {
-        int s = c->u8[i] & 0x1f;
-#if defined(HOST_WORDS_BIGENDIAN)
+    for (i = 0; i < ARRAY_SIZE(r->u8); i++) {
+        int s = c->VsrB(i) & 0x1f;
         int index = s & 0xf;
-#else
-        int index = 15 - (s & 0xf);
-#endif
 
         if (s & 0x10) {
-            result.u8[i] = b->u8[index];
+            result.VsrB(i) = b->VsrB(index);
         } else {
-            result.u8[i] = a->u8[index];
+            result.VsrB(i) = a->VsrB(index);
         }
     }
     *r = result;
@@ -1174,18 +1162,14 @@ void helper_vpermr(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b,
     ppc_avr_t result;
     int i;
 
-    VECTOR_FOR_INORDER_I(i, u8) {
-        int s = c->u8[i] & 0x1f;
-#if defined(HOST_WORDS_BIGENDIAN)
+    for (i = 0; i < ARRAY_SIZE(r->u8); i++) {
+        int s = c->VsrB(i) & 0x1f;
         int index = 15 - (s & 0xf);
-#else
-        int index = s & 0xf;
-#endif
 
         if (s & 0x10) {
-            result.u8[i] = a->u8[index];
+            result.VsrB(i) = a->VsrB(index);
         } else {
-            result.u8[i] = b->u8[index];
+            result.VsrB(i) = b->VsrB(index);
         }
     }
     *r = result;
@@ -1882,25 +1866,14 @@ void helper_vsldoi(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t shift)
     int i;
     ppc_avr_t result;
 
-#if defined(HOST_WORDS_BIGENDIAN)
     for (i = 0; i < ARRAY_SIZE(r->u8); i++) {
         int index = sh + i;
         if (index > 0xf) {
-            result.u8[i] = b->u8[index - 0x10];
-        } else {
-            result.u8[i] = a->u8[index];
-        }
-    }
-#else
-    for (i = 0; i < ARRAY_SIZE(r->u8); i++) {
-        int index = (16 - sh) + i;
-        if (index > 0xf) {
-            result.u8[i] = a->u8[index - 0x10];
+            result.VsrB(i) = b->VsrB(index - 0x10);
         } else {
-            result.u8[i] = b->u8[index];
+            result.VsrB(i) = a->VsrB(index);
         }
     }
-#endif
     *r = result;
 }
 
@@ -1919,25 +1892,20 @@ void helper_vslo(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
 /* Experimental testing shows that hardware masks the immediate.  */
 #define _SPLAT_MASKED(element) (splat & (ARRAY_SIZE(r->element) - 1))
-#if defined(HOST_WORDS_BIGENDIAN)
 #define SPLAT_ELEMENT(element) _SPLAT_MASKED(element)
-#else
-#define SPLAT_ELEMENT(element)                                  \
-    (ARRAY_SIZE(r->element) - 1 - _SPLAT_MASKED(element))
-#endif
-#define VSPLT(suffix, element)                                          \
+#define VSPLT(suffix, element, access)                                  \
     void helper_vsplt##suffix(ppc_avr_t *r, ppc_avr_t *b, uint32_t splat) \
     {                                                                   \
-        uint32_t s = b->element[SPLAT_ELEMENT(element)];                \
+        uint32_t s = b->access(SPLAT_ELEMENT(element));                 \
         int i;                                                          \
                                                                         \
         for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
-            r->element[i] = s;                                          \
+            r->access(i) = s;                                           \
         }                                                               \
     }
-VSPLT(b, u8)
-VSPLT(h, u16)
-VSPLT(w, u32)
+VSPLT(b, u8, VsrB)
+VSPLT(h, u16, VsrH)
+VSPLT(w, u32, VsrW)
 #undef VSPLT
 #undef SPLAT_ELEMENT
 #undef _SPLAT_MASKED
@@ -1998,17 +1966,10 @@ void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
     getVSR(xbn, &xb, env);
     memset(&xt, 0, sizeof(xt));
 
-#if defined(HOST_WORDS_BIGENDIAN)
     ext_index = index;
     for (i = 0; i < es; i++, ext_index++) {
-        xt.u8[8 - es + i] = xb.u8[ext_index % 16];
-    }
-#else
-    ext_index = 15 - index;
-    for (i = es - 1; i >= 0; i--, ext_index--) {
-        xt.u8[8 + i] = xb.u8[ext_index % 16];
+        xt.VsrB(8 - es + i) = xb.VsrB(ext_index % 16);
     }
-#endif
 
     putVSR(xtn, &xt, env);
 }
@@ -2023,17 +1984,10 @@ void helper_xxinsertw(CPUPPCState *env, target_ulong xtn,
     getVSR(xbn, &xb, env);
     getVSR(xtn, &xt, env);
 
-#if defined(HOST_WORDS_BIGENDIAN)
     ins_index = index;
     for (i = 0; i < es && ins_index < 16; i++, ins_index++) {
-        xt.u8[ins_index] = xb.u8[8 - es + i];
-    }
-#else
-    ins_index = 15 - index;
-    for (i = es - 1; i >= 0 && ins_index >= 0; i--, ins_index--) {
-        xt.u8[ins_index] = xb.u8[8 + i];
+        xt.VsrB(ins_index) = xb.VsrB(8 - es + i);
     }
-#endif
 
     putVSR(xtn, &xt, env);
 }
@@ -2042,7 +1996,7 @@ void helper_xxinsertw(CPUPPCState *env, target_ulong xtn,
 void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
 {                                                                   \
     int i;                                                          \
-    VECTOR_FOR_INORDER_I(i, element) {                              \
+    for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
         r->element[i] = (cast)b->element[i];                        \
     }                                                               \
 }
@@ -2057,7 +2011,7 @@ VEXT_SIGNED(vextsw2d, s64, int32_t)
 void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
 {                                                                   \
     int i;                                                          \
-    VECTOR_FOR_INORDER_I(i, element) {                              \
+    for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
         r->element[i] = -b->element[i];                             \
     }                                                               \
 }
@@ -2129,17 +2083,13 @@ void helper_vsumsws(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     ppc_avr_t result;
     int sat = 0;
 
-#if defined(HOST_WORDS_BIGENDIAN)
-    upper = ARRAY_SIZE(r->s32)-1;
-#else
-    upper = 0;
-#endif
-    t = (int64_t)b->s32[upper];
+    upper = ARRAY_SIZE(r->s32) - 1;
+    t = (int64_t)b->VsrSW(upper);
     for (i = 0; i < ARRAY_SIZE(r->s32); i++) {
-        t += a->s32[i];
-        result.s32[i] = 0;
+        t += a->VsrSW(i);
+        result.VsrSW(i) = 0;
     }
-    result.s32[upper] = cvtsdsw(t, &sat);
+    result.VsrSW(upper) = cvtsdsw(t, &sat);
     *r = result;
 
     if (sat) {
@@ -2153,19 +2103,15 @@ void helper_vsum2sws(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     ppc_avr_t result;
     int sat = 0;
 
-#if defined(HOST_WORDS_BIGENDIAN)
     upper = 1;
-#else
-    upper = 0;
-#endif
     for (i = 0; i < ARRAY_SIZE(r->u64); i++) {
-        int64_t t = (int64_t)b->s32[upper + i * 2];
+        int64_t t = (int64_t)b->VsrSW(upper + i * 2);
 
-        result.u64[i] = 0;
+        result.VsrW(i) = 0;
         for (j = 0; j < ARRAY_SIZE(r->u64); j++) {
-            t += a->s32[2 * i + j];
+            t += a->VsrSW(2 * i + j);
         }
-        result.s32[upper + i * 2] = cvtsdsw(t, &sat);
+        result.VsrSW(upper + i * 2) = cvtsdsw(t, &sat);
     }
 
     *r = result;
@@ -2290,7 +2236,7 @@ VUPK(lsw, s64, s32, UPKLO)
     {                                                                   \
         int i;                                                          \
                                                                         \
-        VECTOR_FOR_INORDER_I(i, element) {                              \
+        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
             r->element[i] = name(b->element[i]);                        \
         }                                                               \
     }
@@ -2630,20 +2576,12 @@ static int bcd_cmp_zero(ppc_avr_t *bcd)
 
 static uint16_t get_national_digit(ppc_avr_t *reg, int n)
 {
-#if defined(HOST_WORDS_BIGENDIAN)
-    return reg->u16[7 - n];
-#else
-    return reg->u16[n];
-#endif
+    return reg->VsrH(7 - n);
 }
 
 static void set_national_digit(ppc_avr_t *reg, uint8_t val, int n)
 {
-#if defined(HOST_WORDS_BIGENDIAN)
-    reg->u16[7 - n] = val;
-#else
-    reg->u16[n] = val;
-#endif
+    reg->VsrH(7 - n) = val;
 }
 
 static int bcd_cmp_mag(ppc_avr_t *a, ppc_avr_t *b)
@@ -3387,14 +3325,11 @@ void helper_vpermxor(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
     ppc_avr_t result;
     int i;
 
-    VECTOR_FOR_INORDER_I(i, u8) {
-        int indexA = c->u8[i] >> 4;
-        int indexB = c->u8[i] & 0xF;
-#if defined(HOST_WORDS_BIGENDIAN)
-        result.u8[i] = a->u8[indexA] ^ b->u8[indexB];
-#else
-        result.u8[i] = a->u8[15-indexA] ^ b->u8[15-indexB];
-#endif
+    for (i = 0; i < ARRAY_SIZE(r->u8); i++) {
+        int indexA = c->VsrB(i) >> 4;
+        int indexB = c->VsrB(i) & 0xF;
+
+        result.VsrB(i) = a->VsrB(indexA) ^ b->VsrB(indexB);
     }
     *r = result;
 }
-- 
2.11.0
