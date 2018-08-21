Received: from eggs.gnu.org ([2001:4830:134:3::10]:56505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMt-0004Bj-P0
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMo-0000Mg-WD
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:09 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:30 +1000
Message-Id: <20180821043343.7514-14-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/26] target/ppc: simplify bcdadd/sub functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, lvivier@redhat.com, Yasmin Beatriz <yasmins@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Yasmin Beatriz <yasmins@linux.ibm.com>

After solving a corner case in bcdsub, this patch simplifies the logic
of both bcdadd/sub instructions by removing some unnecessary local flags.
This commit also rearranges some if-else conditions in bcdadd to make it
easier to read.

Signed-off-by: Yasmin Beatriz <yasmins@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/int_helper.c | 49 +++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index ac7f92d7ae..fcac90a4a9 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2671,16 +2671,14 @@ static int bcd_cmp_mag(ppc_avr_t *a, ppc_avr_t *b)
     return 0;
 }
 
-static int bcd_add_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *invalid,
+static void bcd_add_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *invalid,
                        int *overflow)
 {
     int carry = 0;
     int i;
-    int is_zero = 1;
     for (i = 1; i <= 31; i++) {
         uint8_t digit = bcd_get_digit(a, i, invalid) +
                         bcd_get_digit(b, i, invalid) + carry;
-        is_zero &= (digit == 0);
         if (digit > 9) {
             carry = 1;
             digit -= 10;
@@ -2689,26 +2687,20 @@ static int bcd_add_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *invalid,
         }
 
         bcd_put_digit(t, digit, i);
-
-        if (unlikely(*invalid)) {
-            return -1;
-        }
     }
 
     *overflow = carry;
-    return is_zero;
 }
 
-static int bcd_sub_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *invalid,
+static void bcd_sub_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *invalid,
                        int *overflow)
 {
     int carry = 0;
     int i;
-    int is_zero = 1;
+
     for (i = 1; i <= 31; i++) {
         uint8_t digit = bcd_get_digit(a, i, invalid) -
                         bcd_get_digit(b, i, invalid) + carry;
-        is_zero &= (digit == 0);
         if (digit & 0x80) {
             carry = -1;
             digit += 10;
@@ -2717,14 +2709,9 @@ static int bcd_sub_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int *invalid,
         }
 
         bcd_put_digit(t, digit, i);
-
-        if (unlikely(*invalid)) {
-            return -1;
-        }
     }
 
     *overflow = carry;
-    return is_zero;
 }
 
 uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
@@ -2734,26 +2721,28 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
     int sgnb = bcd_get_sgn(b);
     int invalid = (sgna == 0) || (sgnb == 0);
     int overflow = 0;
-    int zero = 0;
     uint32_t cr = 0;
     ppc_avr_t result = { .u64 = { 0, 0 } };
 
     if (!invalid) {
         if (sgna == sgnb) {
             result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgna, ps);
-            zero = bcd_add_mag(&result, a, b, &invalid, &overflow);
-            cr = (sgna > 0) ? CRF_GT : CRF_LT;
-        } else if (bcd_cmp_mag(a, b) > 0) {
-            result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgna, ps);
-            zero = bcd_sub_mag(&result, a, b, &invalid, &overflow);
-            cr = (sgna > 0) ? CRF_GT : CRF_LT;
-        } else if (bcd_cmp_mag(a, b) == 0) {
-            result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(0, ps);
-            zero = bcd_sub_mag(&result, b, a, &invalid, &overflow);
+            bcd_add_mag(&result, a, b, &invalid, &overflow);
+            cr = bcd_cmp_zero(&result);
         } else {
-            result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgnb, ps);
-            zero = bcd_sub_mag(&result, b, a, &invalid, &overflow);
-            cr = (sgnb > 0) ? CRF_GT : CRF_LT;
+            int magnitude = bcd_cmp_mag(a, b);
+            if (magnitude > 0) {
+                result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgna, ps);
+                bcd_sub_mag(&result, a, b, &invalid, &overflow);
+                cr = (sgna > 0) ? CRF_GT : CRF_LT;
+            } else if (magnitude < 0) {
+                result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgnb, ps);
+                bcd_sub_mag(&result, b, a, &invalid, &overflow);
+                cr = (sgnb > 0) ? CRF_GT : CRF_LT;
+            } else {
+                result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(0, ps);
+                cr = CRF_EQ;
+            }
         }
     }
 
@@ -2762,8 +2751,6 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
         cr = CRF_SO;
     } else if (overflow) {
         cr |= CRF_SO;
-    } else if (zero) {
-        cr = CRF_EQ;
     }
 
     *r = result;
-- 
2.17.1
