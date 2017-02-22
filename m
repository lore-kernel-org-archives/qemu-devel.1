Received: from eggs.gnu.org ([2001:4830:134:3::10]:49955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgTGS-0000uO-Sq
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgTGM-0006ZW-MS
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:31:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55840
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgTGM-0006ZB-HL
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:31:06 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1M9Tdds028500
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 04:31:05 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28s2nxb6q5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 04:31:05 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 19:30:57 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 14:59:39 +0530
In-Reply-To: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487755788-16415-3-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 02/11] target/ppc: optimize gen_write_xer()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3ba2616..b09e16f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3724,12 +3724,9 @@ static void gen_write_xer(TCGv src)
 {
     tcg_gen_andi_tl(cpu_xer, src,
                     ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA)));
-    tcg_gen_shri_tl(cpu_so, src, XER_SO);
-    tcg_gen_shri_tl(cpu_ov, src, XER_OV);
-    tcg_gen_shri_tl(cpu_ca, src, XER_CA);
-    tcg_gen_andi_tl(cpu_so, cpu_so, 1);
-    tcg_gen_andi_tl(cpu_ov, cpu_ov, 1);
-    tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
+    tcg_gen_extract_tl(cpu_so, src, XER_SO, 1);
+    tcg_gen_extract_tl(cpu_ov, src, XER_OV, 1);
+    tcg_gen_extract_tl(cpu_ca, src, XER_CA, 1);
 }
 
 /* mcrxr */
-- 
2.7.4
