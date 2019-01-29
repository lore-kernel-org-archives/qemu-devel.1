Received: from eggs.gnu.org ([209.51.188.92]:55162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goYtk-0005z1-Sw
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1goYti-00086p-4M
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 14:18:16 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 29 Jan 2019 19:17:42 +0000
Message-Id: <20190129191746.14868-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190129191746.14868-1-mark.cave-ayland@ilande.co.uk>
References: <20190129191746.14868-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v4 4/8] target/ppc: eliminate use of HI_IDX and
 LO_IDX macros from int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org, david@gibson.dropbear.id.au

The original purpose of these macros was to correctly reference the high and low
parts of the VSRs regardless of the host endianness.

Replace these direct references to high and low parts with the relevant VsrD
macro instead, and completely remove the now-unused HI_IDX and LO_IDX macros.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 180 +++++++++++++++++++++++-------------------------
 1 file changed, 85 insertions(+), 95 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index ea1faa4761..a6f37c0e2e 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -389,14 +389,6 @@ target_ulong helper_602_mfrom(target_ulong arg)
 /*****************************************************************************/
 /* Altivec extension helpers */
 #if defined(HOST_WORDS_BIGENDIAN)
-#define HI_IDX 0
-#define LO_IDX 1
-#else
-#define HI_IDX 1
-#define LO_IDX 0
-#endif
-
-#if defined(HOST_WORDS_BIGENDIAN)
 #define VECTOR_FOR_INORDER_I(index, element)                    \
     for (index = 0; index < ARRAY_SIZE(r->element); index++)
 #else
@@ -514,8 +506,8 @@ void helper_vprtybq(ppc_avr_t *r, ppc_avr_t *b)
     res ^= res >> 32;
     res ^= res >> 16;
     res ^= res >> 8;
-    r->u64[LO_IDX] = res & 1;
-    r->u64[HI_IDX] = 0;
+    r->VsrD(1) = res & 1;
+    r->VsrD(0) = 0;
 }
 
 #define VARITH_DO(name, op, element)                                    \
@@ -1229,8 +1221,8 @@ void helper_vbpermq(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
         }
     }
 
-    r->u64[HI_IDX] = perm;
-    r->u64[LO_IDX] = 0;
+    r->VsrD(0) = perm;
+    r->VsrD(1) = 0;
 }
 
 #undef VBPERMQ_INDEX
@@ -1559,25 +1551,25 @@ void helper_vpmsumd(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     ppc_avr_t prod[2];
 
     VECTOR_FOR_INORDER_I(i, u64) {
-        prod[i].u64[LO_IDX] = prod[i].u64[HI_IDX] = 0;
+        prod[i].VsrD(1) = prod[i].VsrD(0) = 0;
         for (j = 0; j < 64; j++) {
             if (a->u64[i] & (1ull<<j)) {
                 ppc_avr_t bshift;
                 if (j == 0) {
-                    bshift.u64[HI_IDX] = 0;
-                    bshift.u64[LO_IDX] = b->u64[i];
+                    bshift.VsrD(0) = 0;
+                    bshift.VsrD(1) = b->u64[i];
                 } else {
-                    bshift.u64[HI_IDX] = b->u64[i] >> (64-j);
-                    bshift.u64[LO_IDX] = b->u64[i] << j;
+                    bshift.VsrD(0) = b->u64[i] >> (64 - j);
+                    bshift.VsrD(1) = b->u64[i] << j;
                 }
-                prod[i].u64[LO_IDX] ^= bshift.u64[LO_IDX];
-                prod[i].u64[HI_IDX] ^= bshift.u64[HI_IDX];
+                prod[i].VsrD(1) ^= bshift.VsrD(1);
+                prod[i].VsrD(0) ^= bshift.VsrD(0);
             }
         }
     }
 
-    r->u64[LO_IDX] = prod[0].u64[LO_IDX] ^ prod[1].u64[LO_IDX];
-    r->u64[HI_IDX] = prod[0].u64[HI_IDX] ^ prod[1].u64[HI_IDX];
+    r->VsrD(1) = prod[0].VsrD(1) ^ prod[1].VsrD(1);
+    r->VsrD(0) = prod[0].VsrD(0) ^ prod[1].VsrD(0);
 #endif
 }
 
@@ -1795,7 +1787,7 @@ VEXTU_X_DO(vextuwrx, 32, 0)
 #define VSHIFT(suffix, leftp)                                           \
     void helper_vs##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)    \
     {                                                                   \
-        int shift = b->u8[LO_IDX*15] & 0x7;                             \
+        int shift = b->VsrB(15) & 0x7;                                  \
         int doit = 1;                                                   \
         int i;                                                          \
                                                                         \
@@ -1806,15 +1798,15 @@ VEXTU_X_DO(vextuwrx, 32, 0)
             if (shift == 0) {                                           \
                 *r = *a;                                                \
             } else if (leftp) {                                         \
-                uint64_t carry = a->u64[LO_IDX] >> (64 - shift);        \
+                uint64_t carry = a->VsrD(1) >> (64 - shift);            \
                                                                         \
-                r->u64[HI_IDX] = (a->u64[HI_IDX] << shift) | carry;     \
-                r->u64[LO_IDX] = a->u64[LO_IDX] << shift;               \
+                r->VsrD(0) = (a->VsrD(0) << shift) | carry;             \
+                r->VsrD(1) = a->VsrD(1) << shift;                       \
             } else {                                                    \
-                uint64_t carry = a->u64[HI_IDX] << (64 - shift);        \
+                uint64_t carry = a->VsrD(0) << (64 - shift);            \
                                                                         \
-                r->u64[LO_IDX] = (a->u64[LO_IDX] >> shift) | carry;     \
-                r->u64[HI_IDX] = a->u64[HI_IDX] >> shift;               \
+                r->VsrD(1) = (a->VsrD(1) >> shift) | carry;             \
+                r->VsrD(0) = a->VsrD(0) >> shift;                       \
             }                                                           \
         }                                                               \
     }
@@ -1900,7 +1892,7 @@ void helper_vsldoi(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t shift)
 
 void helper_vslo(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    int sh = (b->u8[LO_IDX*0xf] >> 3) & 0xf;
+    int sh = (b->VsrB(0xf) >> 3) & 0xf;
 
 #if defined(HOST_WORDS_BIGENDIAN)
     memmove(&r->u8[0], &a->u8[sh], 16 - sh);
@@ -2096,7 +2088,7 @@ VSR(d, u64, 0x3F)
 
 void helper_vsro(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    int sh = (b->u8[LO_IDX * 0xf] >> 3) & 0xf;
+    int sh = (b->VsrB(0xf) >> 3) & 0xf;
 
 #if defined(HOST_WORDS_BIGENDIAN)
     memmove(&r->u8[sh], &a->u8[0], 16 - sh);
@@ -2352,13 +2344,13 @@ static inline void avr_qw_not(ppc_avr_t *t, ppc_avr_t a)
 
 static int avr_qw_cmpu(ppc_avr_t a, ppc_avr_t b)
 {
-    if (a.u64[HI_IDX] < b.u64[HI_IDX]) {
+    if (a.VsrD(0) < b.VsrD(0)) {
         return -1;
-    } else if (a.u64[HI_IDX] > b.u64[HI_IDX]) {
+    } else if (a.VsrD(0) > b.VsrD(0)) {
         return 1;
-    } else if (a.u64[LO_IDX] < b.u64[LO_IDX]) {
+    } else if (a.VsrD(1) < b.VsrD(1)) {
         return -1;
-    } else if (a.u64[LO_IDX] > b.u64[LO_IDX]) {
+    } else if (a.VsrD(1) > b.VsrD(1)) {
         return 1;
     } else {
         return 0;
@@ -2367,17 +2359,17 @@ static int avr_qw_cmpu(ppc_avr_t a, ppc_avr_t b)
 
 static void avr_qw_add(ppc_avr_t *t, ppc_avr_t a, ppc_avr_t b)
 {
-    t->u64[LO_IDX] = a.u64[LO_IDX] + b.u64[LO_IDX];
-    t->u64[HI_IDX] = a.u64[HI_IDX] + b.u64[HI_IDX] +
-                     (~a.u64[LO_IDX] < b.u64[LO_IDX]);
+    t->VsrD(1) = a.VsrD(1) + b.VsrD(1);
+    t->VsrD(0) = a.VsrD(0) + b.VsrD(0) +
+                     (~a.VsrD(1) < b.VsrD(1));
 }
 
 static int avr_qw_addc(ppc_avr_t *t, ppc_avr_t a, ppc_avr_t b)
 {
     ppc_avr_t not_a;
-    t->u64[LO_IDX] = a.u64[LO_IDX] + b.u64[LO_IDX];
-    t->u64[HI_IDX] = a.u64[HI_IDX] + b.u64[HI_IDX] +
-                     (~a.u64[LO_IDX] < b.u64[LO_IDX]);
+    t->VsrD(1) = a.VsrD(1) + b.VsrD(1);
+    t->VsrD(0) = a.VsrD(0) + b.VsrD(0) +
+                     (~a.VsrD(1) < b.VsrD(1));
     avr_qw_not(&not_a, a);
     return avr_qw_cmpu(not_a, b) < 0;
 }
@@ -2399,11 +2391,11 @@ void helper_vaddeuqm(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
     r->u128 = a->u128 + b->u128 + (c->u128 & 1);
 #else
 
-    if (c->u64[LO_IDX] & 1) {
+    if (c->VsrD(1) & 1) {
         ppc_avr_t tmp;
 
-        tmp.u64[HI_IDX] = 0;
-        tmp.u64[LO_IDX] = c->u64[LO_IDX] & 1;
+        tmp.VsrD(0) = 0;
+        tmp.VsrD(1) = c->VsrD(1) & 1;
         avr_qw_add(&tmp, *a, tmp);
         avr_qw_add(r, tmp, *b);
     } else {
@@ -2421,8 +2413,8 @@ void helper_vaddcuq(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
     avr_qw_not(&not_a, *a);
 
-    r->u64[HI_IDX] = 0;
-    r->u64[LO_IDX] = (avr_qw_cmpu(not_a, *b) < 0);
+    r->VsrD(0) = 0;
+    r->VsrD(1) = (avr_qw_cmpu(not_a, *b) < 0);
 #endif
 }
 
@@ -2437,7 +2429,7 @@ void helper_vaddecuq(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
     r->u128 = carry_out;
 #else
 
-    int carry_in = c->u64[LO_IDX] & 1;
+    int carry_in = c->VsrD(1) & 1;
     int carry_out = 0;
     ppc_avr_t tmp;
 
@@ -2447,8 +2439,8 @@ void helper_vaddecuq(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
         ppc_avr_t one = QW_ONE;
         carry_out = avr_qw_addc(&tmp, tmp, one);
     }
-    r->u64[HI_IDX] = 0;
-    r->u64[LO_IDX] = carry_out;
+    r->VsrD(0) = 0;
+    r->VsrD(1) = carry_out;
 #endif
 }
 
@@ -2476,8 +2468,8 @@ void helper_vsubeuqm(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
     avr_qw_not(&tmp, *b);
     avr_qw_add(&sum, *a, tmp);
 
-    tmp.u64[HI_IDX] = 0;
-    tmp.u64[LO_IDX] = c->u64[LO_IDX] & 1;
+    tmp.VsrD(0) = 0;
+    tmp.VsrD(1) = c->VsrD(1) & 1;
     avr_qw_add(r, sum, tmp);
 #endif
 }
@@ -2493,10 +2485,10 @@ void helper_vsubcuq(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
         ppc_avr_t tmp;
         avr_qw_not(&tmp, *b);
         avr_qw_add(&tmp, *a, tmp);
-        carry = ((tmp.s64[HI_IDX] == -1ull) && (tmp.s64[LO_IDX] == -1ull));
+        carry = ((tmp.VsrSD(0) == -1ull) && (tmp.VsrSD(1) == -1ull));
     }
-    r->u64[HI_IDX] = 0;
-    r->u64[LO_IDX] = carry;
+    r->VsrD(0) = 0;
+    r->VsrD(1) = carry;
 #endif
 }
 
@@ -2507,17 +2499,17 @@ void helper_vsubecuq(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
         (~a->u128 < ~b->u128) ||
         ((c->u128 & 1) && (a->u128 + ~b->u128 == (__uint128_t)-1));
 #else
-    int carry_in = c->u64[LO_IDX] & 1;
+    int carry_in = c->VsrD(1) & 1;
     int carry_out = (avr_qw_cmpu(*a, *b) > 0);
     if (!carry_out && carry_in) {
         ppc_avr_t tmp;
         avr_qw_not(&tmp, *b);
         avr_qw_add(&tmp, *a, tmp);
-        carry_out = ((tmp.u64[HI_IDX] == -1ull) && (tmp.u64[LO_IDX] == -1ull));
+        carry_out = ((tmp.VsrD(0) == -1ull) && (tmp.VsrD(1) == -1ull));
     }
 
-    r->u64[HI_IDX] = 0;
-    r->u64[LO_IDX] = carry_out;
+    r->VsrD(0) = 0;
+    r->VsrD(1) = carry_out;
 #endif
 }
 
@@ -2615,7 +2607,7 @@ static bool bcd_is_valid(ppc_avr_t *bcd)
 
 static int bcd_cmp_zero(ppc_avr_t *bcd)
 {
-    if (bcd->u64[HI_IDX] == 0 && (bcd->u64[LO_IDX] >> 4) == 0) {
+    if (bcd->VsrD(0) == 0 && (bcd->VsrD(1) >> 4) == 0) {
         return CRF_EQ;
     } else {
         return (bcd_get_sgn(bcd) == 1) ? CRF_GT : CRF_LT;
@@ -2735,7 +2727,7 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     }
 
     if (unlikely(invalid)) {
-        result.u64[HI_IDX] = result.u64[LO_IDX] = -1;
+        result.VsrD(0) = result.VsrD(1) = -1;
         cr = CRF_SO;
     } else if (overflow) {
         cr |= CRF_SO;
@@ -2804,7 +2796,7 @@ uint32_t helper_bcdctn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     int invalid = (sgnb == 0);
     ppc_avr_t ret = { .u64 = { 0, 0 } };
 
-    int ox_flag = (b->u64[HI_IDX] != 0) || ((b->u64[LO_IDX] >> 32) != 0);
+    int ox_flag = (b->VsrD(0) != 0) || ((b->VsrD(1) >> 32) != 0);
 
     for (i = 1; i < 8; i++) {
         set_national_digit(&ret, 0x30 + bcd_get_digit(b, i, &invalid), i);
@@ -2884,7 +2876,7 @@ uint32_t helper_bcdctz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     int invalid = (sgnb == 0);
     ppc_avr_t ret = { .u64 = { 0, 0 } };
 
-    int ox_flag = ((b->u64[HI_IDX] >> 4) != 0);
+    int ox_flag = ((b->VsrD(0) >> 4) != 0);
 
     for (i = 0; i < 16; i++) {
         digit = bcd_get_digit(b, i + 1, &invalid);
@@ -2925,13 +2917,13 @@ uint32_t helper_bcdcfsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     uint64_t hi_value;
     ppc_avr_t ret = { .u64 = { 0, 0 } };
 
-    if (b->s64[HI_IDX] < 0) {
-        lo_value = -b->s64[LO_IDX];
-        hi_value = ~b->u64[HI_IDX] + !lo_value;
+    if (b->VsrSD(0) < 0) {
+        lo_value = -b->VsrSD(1);
+        hi_value = ~b->VsrD(0) + !lo_value;
         bcd_put_digit(&ret, 0xD, 0);
     } else {
-        lo_value = b->u64[LO_IDX];
-        hi_value = b->u64[HI_IDX];
+        lo_value = b->VsrD(1);
+        hi_value = b->VsrD(0);
         bcd_put_digit(&ret, bcd_preferred_sgn(0, ps), 0);
     }
 
@@ -2979,11 +2971,11 @@ uint32_t helper_bcdctsq(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     }
 
     if (sgnb == -1) {
-        r->s64[LO_IDX] = -lo_value;
-        r->s64[HI_IDX] = ~hi_value + !r->s64[LO_IDX];
+        r->VsrSD(1) = -lo_value;
+        r->VsrSD(0) = ~hi_value + !r->VsrSD(1);
     } else {
-        r->s64[LO_IDX] = lo_value;
-        r->s64[HI_IDX] = hi_value;
+        r->VsrSD(1) = lo_value;
+        r->VsrSD(0) = hi_value;
     }
 
     cr = bcd_cmp_zero(b);
@@ -3043,7 +3035,7 @@ uint32_t helper_bcds(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     bool ox_flag = false;
     int sgnb = bcd_get_sgn(b);
     ppc_avr_t ret = *b;
-    ret.u64[LO_IDX] &= ~0xf;
+    ret.VsrD(1) &= ~0xf;
 
     if (bcd_is_valid(b) == false) {
         return CRF_SO;
@@ -3056,9 +3048,9 @@ uint32_t helper_bcds(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     }
 
     if (i > 0) {
-        ulshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], i * 4, &ox_flag);
+        ulshift(&ret.VsrD(1), &ret.VsrD(0), i * 4, &ox_flag);
     } else {
-        urshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], -i * 4);
+        urshift(&ret.VsrD(1), &ret.VsrD(0), -i * 4);
     }
     bcd_put_digit(&ret, bcd_preferred_sgn(sgnb, ps), 0);
 
@@ -3095,13 +3087,13 @@ uint32_t helper_bcdus(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 #endif
     if (i >= 32) {
         ox_flag = true;
-        ret.u64[LO_IDX] = ret.u64[HI_IDX] = 0;
+        ret.VsrD(1) = ret.VsrD(0) = 0;
     } else if (i <= -32) {
-        ret.u64[LO_IDX] = ret.u64[HI_IDX] = 0;
+        ret.VsrD(1) = ret.VsrD(0) = 0;
     } else if (i > 0) {
-        ulshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], i * 4, &ox_flag);
+        ulshift(&ret.VsrD(1), &ret.VsrD(0), i * 4, &ox_flag);
     } else {
-        urshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], -i * 4);
+        urshift(&ret.VsrD(1), &ret.VsrD(0), -i * 4);
     }
     *r = ret;
 
@@ -3121,7 +3113,7 @@ uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     bool ox_flag = false;
     int sgnb = bcd_get_sgn(b);
     ppc_avr_t ret = *b;
-    ret.u64[LO_IDX] &= ~0xf;
+    ret.VsrD(1) &= ~0xf;
 
 #if defined(HOST_WORDS_BIGENDIAN)
     int i = a->s8[7];
@@ -3142,9 +3134,9 @@ uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     }
 
     if (i > 0) {
-        ulshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], i * 4, &ox_flag);
+        ulshift(&ret.VsrD(1), &ret.VsrD(0), i * 4, &ox_flag);
     } else {
-        urshift(&ret.u64[LO_IDX], &ret.u64[HI_IDX], -i * 4);
+        urshift(&ret.VsrD(1), &ret.VsrD(0), -i * 4);
 
         if (bcd_get_digit(&ret, 0, &invalid) >= 5) {
             bcd_add_mag(&ret, &ret, &bcd_one, &invalid, &unused);
@@ -3178,19 +3170,19 @@ uint32_t helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 
     if (i > 16 && i < 32) {
         mask = (uint64_t)-1 >> (128 - i * 4);
-        if (ret.u64[HI_IDX] & ~mask) {
+        if (ret.VsrD(0) & ~mask) {
             ox_flag = CRF_SO;
         }
 
-        ret.u64[HI_IDX] &= mask;
+        ret.VsrD(0) &= mask;
     } else if (i >= 0 && i <= 16) {
         mask = (uint64_t)-1 >> (64 - i * 4);
-        if (ret.u64[HI_IDX] || (ret.u64[LO_IDX] & ~mask)) {
+        if (ret.VsrD(0) || (ret.VsrD(1) & ~mask)) {
             ox_flag = CRF_SO;
         }
 
-        ret.u64[LO_IDX] &= mask;
-        ret.u64[HI_IDX] = 0;
+        ret.VsrD(1) &= mask;
+        ret.VsrD(0) = 0;
     }
     bcd_put_digit(&ret, bcd_preferred_sgn(bcd_get_sgn(b), ps), 0);
     *r = ret;
@@ -3221,28 +3213,28 @@ uint32_t helper_bcdutrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 #endif
     if (i > 16 && i < 33) {
         mask = (uint64_t)-1 >> (128 - i * 4);
-        if (ret.u64[HI_IDX] & ~mask) {
+        if (ret.VsrD(0) & ~mask) {
             ox_flag = CRF_SO;
         }
 
-        ret.u64[HI_IDX] &= mask;
+        ret.VsrD(0) &= mask;
     } else if (i > 0 && i <= 16) {
         mask = (uint64_t)-1 >> (64 - i * 4);
-        if (ret.u64[HI_IDX] || (ret.u64[LO_IDX] & ~mask)) {
+        if (ret.VsrD(0) || (ret.VsrD(1) & ~mask)) {
             ox_flag = CRF_SO;
         }
 
-        ret.u64[LO_IDX] &= mask;
-        ret.u64[HI_IDX] = 0;
+        ret.VsrD(1) &= mask;
+        ret.VsrD(0) = 0;
     } else if (i == 0) {
-        if (ret.u64[HI_IDX] || ret.u64[LO_IDX]) {
+        if (ret.VsrD(0) || ret.VsrD(1)) {
             ox_flag = CRF_SO;
         }
-        ret.u64[HI_IDX] = ret.u64[LO_IDX] = 0;
+        ret.VsrD(0) = ret.VsrD(1) = 0;
     }
 
     *r = ret;
-    if (r->u64[HI_IDX] == 0 && r->u64[LO_IDX] == 0) {
+    if (r->VsrD(0) == 0 && r->VsrD(1) == 0) {
         return ox_flag | CRF_EQ;
     }
 
@@ -3414,8 +3406,6 @@ void helper_vpermxor(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 }
 
 #undef VECTOR_FOR_INORDER_I
-#undef HI_IDX
-#undef LO_IDX
 
 /*****************************************************************************/
 /* SPE extension helpers */
-- 
2.11.0
