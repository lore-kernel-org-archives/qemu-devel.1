Received: from eggs.gnu.org ([2001:4830:134:3::10]:57440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbm4b-0002Mi-Ry
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbm4Y-00026M-QJ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cbm4Y-00024X-HS
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:30 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v19AXh6v053877
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 05:35:29 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28g3w96eqv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 05:35:29 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 9 Feb 2017 20:35:27 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  9 Feb 2017 16:04:05 +0530
In-Reply-To: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1486636445-24109-7-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 6/6] target-ppc: add mcrxrx instruction
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
 target/ppc/translate.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 724ad17..72c8a46 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3761,6 +3761,29 @@ static void gen_mcrxr(DisasContext *ctx)
     tcg_gen_movi_tl(cpu_ca, 0);
 }
 
+#ifdef TARGET_PPC64
+/* mcrxrx */
+static void gen_mcrxrx(DisasContext *ctx)
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 dst = cpu_crf[crfD(ctx->opcode)];
+
+    /* copy OV and OV32 */
+    tcg_gen_trunc_tl_i32(t0, cpu_so);
+    tcg_gen_shli_i32(dst, t0, 1);
+    tcg_gen_or_i32(dst, dst, t0);
+    tcg_gen_shli_i32(dst, dst, 2);
+    /* copy CA and CA32 */
+    tcg_gen_trunc_tl_i32(t0, cpu_ca);
+    tcg_gen_shli_i32(t1, t0, 1);
+    tcg_gen_or_i32(t1, t1, t0);
+    tcg_gen_or_i32(dst, dst, t1);
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(t1);
+}
+#endif
+
 /* mfcr mfocrf */
 static void gen_mfcr(DisasContext *ctx)
 {
@@ -6430,6 +6453,7 @@ GEN_HANDLER(mtcrf, 0x1F, 0x10, 0x04, 0x00000801, PPC_MISC),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(mtmsrd, 0x1F, 0x12, 0x05, 0x001EF801, PPC_64B),
 GEN_HANDLER_E(setb, 0x1F, 0x00, 0x04, 0x0003F801, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(mcrxrx, 0x1F, 0x00, 0x12, 0x007FF801, PPC_NONE, PPC2_ISA300),
 #endif
 GEN_HANDLER(mtmsr, 0x1F, 0x12, 0x04, 0x001EF801, PPC_MISC),
 GEN_HANDLER(mtspr, 0x1F, 0x13, 0x0E, 0x00000000, PPC_MISC),
-- 
2.7.4
