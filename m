Received: from eggs.gnu.org ([2001:4830:134:3::10]:56352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMk-00044p-TN
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMh-0000G0-Sd
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:02 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:27 +1000
Message-Id: <20180821043343.7514-11-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/26] target/ppc: bcdsub fix sign when result
 is zero
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

When the result of bcdsub is equal to zero, the result sign may be
set to negative in some cases, and this does not follow the Power ISA
specifications as to decimal integer arithmetic instructions.

Signed-off-by: Yasmin Beatriz <yasmins@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/int_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index d52338ed71..ac7f92d7ae 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2747,6 +2747,9 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, uint32_t ps)
             result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgna, ps);
             zero = bcd_sub_mag(&result, a, b, &invalid, &overflow);
             cr = (sgna > 0) ? CRF_GT : CRF_LT;
+        } else if (bcd_cmp_mag(a, b) == 0) {
+            result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(0, ps);
+            zero = bcd_sub_mag(&result, b, a, &invalid, &overflow);
         } else {
             result.u8[BCD_DIG_BYTE(0)] = bcd_preferred_sgn(sgnb, ps);
             zero = bcd_sub_mag(&result, b, a, &invalid, &overflow);
-- 
2.17.1
