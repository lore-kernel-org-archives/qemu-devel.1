Received: from eggs.gnu.org ([2001:4830:134:3::10]:50890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDR-0003G1-3e
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoDP-0004oq-PP
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:24 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:43808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoDP-0004oZ-KH
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:23 -0500
Received: by mail-pg0-x244.google.com with SMTP id f18so4054644pga.10
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:33 -0800
Message-Id: <20171229063145.29167-27-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 26/38] target/hppa: Implement LCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ec61c57e55..2e3edf8957 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2453,6 +2453,25 @@ static DisasJumpType trans_lpa(DisasContext *ctx, uint32_t insn,
 
     return nullify_end(ctx, DISAS_NEXT);
 }
+
+static DisasJumpType trans_lci(DisasContext *ctx, uint32_t insn,
+                               const DisasInsn *di)
+{
+    unsigned rt = extract32(insn, 0, 5);
+    TCGv_reg ci;
+
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+
+    /* The Coherence Index is an implementation-defined function of the
+       physical address.  Two addresses with the same CI have a coherent
+       view of the cache.  Our implementation is to return 0 for all,
+       since the entire address space is coherent.  */
+    ci = tcg_const_reg(0);
+    save_gpr(ctx, rt, ci);
+    tcg_temp_free(ci);
+
+    return DISAS_NEXT;
+}
 #endif /* !CONFIG_USER_ONLY */
 
 static const DisasInsn table_mem_mgmt[] = {
@@ -2481,6 +2500,7 @@ static const DisasInsn table_mem_mgmt[] = {
     { 0x04001200u, 0xfc001fdfu, trans_pxtlbx },       /* pdtlb */
     { 0x04001240u, 0xfc001fdfu, trans_pxtlbx },       /* pdtlbe */
     { 0x04001340u, 0xfc003fc0u, trans_lpa },
+    { 0x04001300u, 0xfc003fe0u, trans_lci },
 #endif
 };
 
-- 
2.14.3
