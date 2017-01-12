Received: from eggs.gnu.org ([2001:4830:134:3::10]:46164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjy-0002tn-6K
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjw-0006Sc-9O
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:46 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:43 +1100
Message-Id: <20170112020327.24882-24-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 23/67] target-ppc: Implement bcd_is_valid
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

A function to check if all digits of a given BCD number is valid is
here presented because more instructions will need to reuse the
same code.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/int_helper.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 34dfe02..2bb628f 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2596,6 +2596,24 @@ static void bcd_put_digit(ppc_avr_t *bcd, uint8_t digit, int n)
     }
 }
 
+static bool bcd_is_valid(ppc_avr_t *bcd)
+{
+    int i;
+    int invalid = 0;
+
+    if (bcd_get_sgn(bcd) == 0) {
+        return false;
+    }
+
+    for (i = 1; i < 32; i++) {
+        bcd_get_digit(bcd, i, &invalid);
+        if (unlikely(invalid)) {
+            return false;
+        }
+    }
+    return true;
+}
+
 static int bcd_cmp_zero(ppc_avr_t *bcd)
 {
     if (bcd->u64[HI_IDX] == 0 && (bcd->u64[LO_IDX] >> 4) == 0) {
@@ -3013,18 +3031,13 @@ uint32_t helper_bcdcpsgn(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
 
 uint32_t helper_bcdsetsgn(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
 {
-    int i;
-    int invalid = 0;
     int sgnb = bcd_get_sgn(b);
 
     *r = *b;
     bcd_put_digit(r, bcd_preferred_sgn(sgnb, ps), 0);
 
-    for (i = 1; i < 32; i++) {
-        bcd_get_digit(b, i, &invalid);
-        if (unlikely(invalid)) {
-            return CRF_SO;
-        }
+    if (bcd_is_valid(b) == false) {
+        return CRF_SO;
     }
 
     return bcd_cmp_zero(r);
-- 
2.9.3
