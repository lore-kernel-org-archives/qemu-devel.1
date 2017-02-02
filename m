Received: from eggs.gnu.org ([2001:4830:134:3::10]:52077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k2-0007f8-WB
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jx-00042K-Ef
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:30 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:05 +1100
Message-Id: <20170202051445.5735-68-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 067/107] ppc: Fix a warning in bcdcfz code and
 improve BCD_DIG_BYTE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

This commit fixes a warning in the code "(i * 2) ? .. : ..", which
should be better as "i ? .. : ..", and improves the BCD_DIG_BYTE
macro by placing parentheses around its argument to avoid possible
expansion issues like: BCD_DIG_BYTE(i + j).

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/int_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 81f134b..8cf4ee3 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2551,9 +2551,9 @@ void helper_vsubecuq(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 #define NATIONAL_NEG    0x2D
 
 #if defined(HOST_WORDS_BIGENDIAN)
-#define BCD_DIG_BYTE(n) (15 - (n/2))
+#define BCD_DIG_BYTE(n) (15 - ((n) / 2))
 #else
-#define BCD_DIG_BYTE(n) (n/2)
+#define BCD_DIG_BYTE(n) ((n) / 2)
 #endif
 
 static int bcd_get_sgn(ppc_avr_t *bcd)
@@ -2876,7 +2876,7 @@ uint32_t helper_bcdcfz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     }
 
     for (i = 0; i < 16; i++) {
-        zone_digit = (i * 2) ? b->u8[BCD_DIG_BYTE(i * 2)] >> 4 : zone_lead;
+        zone_digit = i ? b->u8[BCD_DIG_BYTE(i * 2)] >> 4 : zone_lead;
         digit = b->u8[BCD_DIG_BYTE(i * 2)] & 0xF;
         if (unlikely(zone_digit != zone_lead || digit > 0x9)) {
             invalid = 1;
-- 
2.9.3
