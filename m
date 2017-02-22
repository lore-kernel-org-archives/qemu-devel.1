Received: from eggs.gnu.org ([2001:4830:134:3::10]:57243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgVMp-0000rM-KK
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgVMk-0003kt-OS
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:45:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgVMk-0003kg-Ei
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:45:50 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MBi4KL124429
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:45:49 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28s411x2nu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:45:49 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 17:15:16 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 17:14:35 +0530
In-Reply-To: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487763883-4877-3-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 02/10] target/ppc: optimize gen_write_xer()
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
Reviewed-by: Richard Henderson <rth@twiddle.net>
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
