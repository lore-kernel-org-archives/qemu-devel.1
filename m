Received: from eggs.gnu.org ([2001:4830:134:3::10]:41385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVo-0005XJ-F1
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgzVm-0001pJ-W1
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgzVm-0001oR-NS
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:57:10 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NJtDA5061201
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:09 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28sp4jssq1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 14:57:09 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 01:27:06 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:26:40 +0530
In-Reply-To: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487879800-12352-16-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 15/15] target/ppc: add mcrxrx instruction
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

mcrxrx: Move to CR from XER Extended

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5af9667..f4e41e5 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3886,6 +3886,32 @@ static void gen_mcrxr(DisasContext *ctx)
     tcg_temp_free(t0);
 }
 
+#ifdef TARGET_PPC64
+/* mcrxrx */
+static void gen_mcrxrx(DisasContext *ctx)
+{
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv_i32 dst = cpu_crf[crfD(ctx->opcode)];
+
+    /* copy OV and OV32 */
+    tcg_gen_extract_tl(t0, cpu_xer, XER_OV_BIT, 1);
+    tcg_gen_extract_tl(t1, cpu_xer, XER_OV32_BIT, 1);
+    tcg_gen_shli_tl(t0, t0, 1);
+    tcg_gen_or_tl(t0, t0, t1);
+    tcg_gen_shli_tl(t0, t0, 1);
+    /* copy CA and CA32 */
+    tcg_gen_extract_tl(t1, cpu_xer, XER_CA_BIT, 1);
+    tcg_gen_or_tl(t0, t0, t1);
+    tcg_gen_shli_tl(t0, t0, 1);
+    tcg_gen_extract_tl(t1, cpu_xer, XER_CA32_BIT, 1);
+    tcg_gen_or_tl(t0, t0, t1);
+    tcg_gen_trunc_tl_i32(dst, t0);
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+#endif
+
 /* mfcr mfocrf */
 static void gen_mfcr(DisasContext *ctx)
 {
@@ -6584,6 +6610,7 @@ GEN_HANDLER(mtcrf, 0x1F, 0x10, 0x04, 0x00000801, PPC_MISC),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(mtmsrd, 0x1F, 0x12, 0x05, 0x001EF801, PPC_64B),
 GEN_HANDLER_E(setb, 0x1F, 0x00, 0x04, 0x0003F801, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(mcrxrx, 0x1F, 0x00, 0x12, 0x007FF801, PPC_NONE, PPC2_ISA300),
 #endif
 GEN_HANDLER(mtmsr, 0x1F, 0x12, 0x04, 0x001EF801, PPC_MISC),
 GEN_HANDLER(mtspr, 0x1F, 0x13, 0x0E, 0x00000000, PPC_MISC),
-- 
2.7.4
