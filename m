Received: from eggs.gnu.org ([2001:4830:134:3::10]:57327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbm4W-0002Jl-0O
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbm4S-0001xU-UD
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cbm4S-0001w7-LX
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:24 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v19AXcWs072560
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 05:35:23 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28gm1prba3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 05:35:23 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 9 Feb 2017 20:35:21 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  9 Feb 2017 16:04:02 +0530
In-Reply-To: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1486636445-24109-4-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/6] target-ppc: add slbsync implementation
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

slbsync: SLB Synchoronize

The instruction provides an ordering function for the effects of all
slbieg instructions executed by the thread executing the slbsync
instruction.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b0f3c3b..b1a6aee 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4497,6 +4497,17 @@ static void gen_slbieg(DisasContext *ctx)
 #endif /* defined(CONFIG_USER_ONLY) */
 }
 
+/* slbsync */
+static void gen_slbsync(DisasContext *ctx)
+{
+#if defined(CONFIG_USER_ONLY)
+    GEN_PRIV;
+#else
+    CHK_SV;
+    gen_check_tlb_flush(ctx, true);
+#endif /* defined(CONFIG_USER_ONLY) */
+}
+
 #endif  /* defined(TARGET_PPC64) */
 
 /***                              External control                         ***/
@@ -6453,6 +6464,7 @@ GEN_HANDLER(tlbsync, 0x1F, 0x16, 0x11, 0x03FFF801, PPC_MEM_TLBSYNC),
 GEN_HANDLER(slbia, 0x1F, 0x12, 0x0F, 0x031FFC01, PPC_SLBI),
 GEN_HANDLER(slbie, 0x1F, 0x12, 0x0D, 0x03FF0001, PPC_SLBI),
 GEN_HANDLER_E(slbieg, 0x1F, 0x12, 0x0E, 0x001F0001, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(slbsync, 0x1F, 0x12, 0x0A, 0x03FFF801, PPC_NONE, PPC2_ISA300),
 #endif
 GEN_HANDLER(eciwx, 0x1F, 0x16, 0x0D, 0x00000001, PPC_EXTERN),
 GEN_HANDLER(ecowx, 0x1F, 0x16, 0x09, 0x00000001, PPC_EXTERN),
-- 
2.7.4
