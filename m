Received: from eggs.gnu.org ([2001:4830:134:3::10]:57278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbm4T-0002IK-7Q
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbm4Q-0001ua-Lo
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cbm4Q-0001t9-DA
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:22 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v19AXtOq004215
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 05:35:21 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28gj2ucpaf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 05:35:20 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 9 Feb 2017 20:35:18 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  9 Feb 2017 16:04:00 +0530
In-Reply-To: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1486636445-24109-2-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/6] target-ppc: generate exception for
 copy/paste
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
 target/ppc/translate.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 255735a..80f9f15 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6132,6 +6132,19 @@ static inline void gen_cp_abort(DisasContext *ctx)
     // Do Nothing
 }
 
+#define GEN_CP_PASTE_NOOP(name)                           \
+static inline void gen_##name(DisasContext *ctx)          \
+{                                                         \
+    /* Generate invalid exception until                   \
+     * we have an implementation of the copy              \
+     * paste facility                                     \
+     */                                                   \
+    gen_invalid(ctx);                                     \
+}
+
+GEN_CP_PASTE_NOOP(copy)
+GEN_CP_PASTE_NOOP(paste)
+
 static void gen_tcheck(DisasContext *ctx)
 {
     if (unlikely(!ctx->tm_enabled)) {
@@ -6281,7 +6294,9 @@ GEN_HANDLER2(andi_, "andi.", 0x1C, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER2(andis_, "andis.", 0x1D, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(cntlzw, 0x1F, 0x1A, 0x00, 0x00000000, PPC_INTEGER),
 GEN_HANDLER_E(cnttzw, 0x1F, 0x1A, 0x10, 0x00000000, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(copy, 0x1F, 0x06, 0x18, 0x03C00001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(cp_abort, 0x1F, 0x06, 0x1A, 0x03FFF801, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(or, 0x1F, 0x1C, 0x0D, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(xor, 0x1F, 0x1C, 0x09, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(ori, 0x18, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-- 
2.7.4
