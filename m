Received: from eggs.gnu.org ([2001:4830:134:3::10]:41347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cELbW-0000L0-MS
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cELbT-0004Qf-Dq
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:40:42 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:40239
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cELbT-0004Q6-13
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:40:39 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB6Je6HT055362
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 14:40:37 -0500
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2762h4cxpe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 14:40:37 -0500
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 6 Dec 2016 17:40:34 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Tue,  6 Dec 2016 17:40:04 -0200
In-Reply-To: <1481053210-26821-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1481053210-26821-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1481053210-26821-2-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/7] target-ppc: Implement bcd_is_valid
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com

A function to check if all digits of a given BCD number is valid is
here presented because more instructions will need to reuse the
same code.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 target-ppc/int_helper.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
index 7030f61..7989b1f 100644
--- a/target-ppc/int_helper.c
+++ b/target-ppc/int_helper.c
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
2.7.4
