Received: from eggs.gnu.org ([2001:4830:134:3::10]:53630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yasmins@linux.ibm.com>) id 1ff8mJ-0002Ln-Eu
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 15:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yasmins@linux.ibm.com>) id 1ff8mG-0004xb-BU
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 15:03:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46356
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yasmins@linux.ibm.com>)
	id 1ff8mG-0004x0-6J
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 15:03:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6GIruua017442
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 15:03:18 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k8xemerbm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 15:03:18 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <yasmins@linux.ibm.com>;
	Mon, 16 Jul 2018 15:03:17 -0400
From: Yasmin Beatriz <yasmins@linux.ibm.com>
Date: Mon, 16 Jul 2018 19:03:12 +0000
Message-Id: <1531767792-17705-1-git-send-email-yasmins@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] target/ppc: bcdsub fix sign when result is zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net

When the result of bcdsub is equal to zero, the result sign may be
set to negative in some cases, and this does not follow the Power ISA
specifications as to decimal integer arithmetic instructions.

Signed-off-by: Yasmin Beatriz <yasmins@linux.ibm.com>
---
 target/ppc/int_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 03d37da..fa18e6e 100644
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
1.8.3.1
