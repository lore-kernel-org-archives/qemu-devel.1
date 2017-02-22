Received: from eggs.gnu.org ([2001:4830:134:3::10]:57110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgVMT-0000W0-K6
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgVMP-0003fz-J1
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:45:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgVMP-0003fQ-9I
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:45:29 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MBi73Z124599
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:45:28 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28s411x26h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:45:27 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 17:15:24 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 17:14:43 +0530
In-Reply-To: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487763883-4877-11-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 10/10] target/ppc: add mcrxrx instruction
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
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/ppc/translate.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 99dfcf7..90400fc 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3826,6 +3826,28 @@ static void gen_mcrxr(DisasContext *ctx)
     tcg_gen_movi_tl(cpu_ca, 0);
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
+    tcg_gen_shli_tl(t0, cpu_ov, 1);
+    tcg_gen_or_tl(t0, t0, cpu_ov32);
+    tcg_gen_shli_tl(t0, t0, 2);
+    /* copy CA and CA32 */
+    tcg_gen_shli_tl(t1, cpu_ca, 1);
+    tcg_gen_or_tl(t1, t1, cpu_ca32);
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
@@ -6495,6 +6517,7 @@ GEN_HANDLER(mtcrf, 0x1F, 0x10, 0x04, 0x00000801, PPC_MISC),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(mtmsrd, 0x1F, 0x12, 0x05, 0x001EF801, PPC_64B),
 GEN_HANDLER_E(setb, 0x1F, 0x00, 0x04, 0x0003F801, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(mcrxrx, 0x1F, 0x00, 0x12, 0x007FF801, PPC_NONE, PPC2_ISA300),
 #endif
 GEN_HANDLER(mtmsr, 0x1F, 0x12, 0x04, 0x001EF801, PPC_MISC),
 GEN_HANDLER(mtspr, 0x1F, 0x13, 0x0E, 0x00000000, PPC_MISC),
-- 
2.7.4
