Received: from eggs.gnu.org ([2001:4830:134:3::10]:34193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cRNzc-0006P6-DC
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:51:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cRNzZ-0008Uh-BJ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:51:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cRNzZ-0008UF-2A
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:51:25 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0BIn0hM130734
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 13:51:23 -0500
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27wq12tade-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 13:51:23 -0500
Received: from localhost
	by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Wed, 11 Jan 2017 16:51:20 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Wed, 11 Jan 2017 16:50:58 -0200
Message-Id: <1484160658-15419-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] ppc: Fix a warning in bcdcfz code and improve
 BCD_DIG_BYTE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com, eblake@redhat.com, 655708@bugs.launchpad.net, thuth@redhat.com

This commit fixes a warning in the code "(i * 2) ? .. : ..", which
should be better as "(i) ? .. : ..", and improves the BCD_DIG_BYTE
macro by placing parentheses around its argument to avoid possible
expansion issues like: BCD_DIG_BYTE(i + j).

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 target/ppc/int_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 24e5964..d889084 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2583,9 +2583,9 @@ void helper_vsubecuq(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
 #define NATIONAL_NEG    0x2D
 
 #if defined(HOST_WORDS_BIGENDIAN)
-#define BCD_DIG_BYTE(n) (15 - (n/2))
+#define BCD_DIG_BYTE(n) (15 - ((n) / 2))
 #else
-#define BCD_DIG_BYTE(n) (n/2)
+#define BCD_DIG_BYTE(n) ((n) / 2)
 #endif
 
 static int bcd_get_sgn(ppc_avr_t *bcd)
@@ -2908,7 +2908,7 @@ uint32_t helper_bcdcfz(ppc_avr_t *r, ppc_avr_t *b, uint32_t ps)
     }
 
     for (i = 0; i < 16; i++) {
-        zone_digit = (i * 2) ? b->u8[BCD_DIG_BYTE(i * 2)] >> 4 : zone_lead;
+        zone_digit = (i) ? b->u8[BCD_DIG_BYTE(i * 2)] >> 4 : zone_lead;
         digit = b->u8[BCD_DIG_BYTE(i * 2)] & 0xF;
         if (unlikely(zone_digit != zone_lead || digit > 0x9)) {
             invalid = 1;
-- 
2.7.4
