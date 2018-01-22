Received: from eggs.gnu.org ([2001:4830:134:3::10]:60341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0e-0005ls-RA
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0b-0006cx-9N
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:00 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edT0b-0006cd-3q
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:42:57 -0500
Received: by mail-pf0-x244.google.com with SMTP id t12so6084435pfg.2
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 19:42:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 21 Jan 2018 19:41:59 -0800
Message-Id: <20180122034217.19593-26-richard.henderson@linaro.org>
In-Reply-To: <20180122034217.19593-1-richard.henderson@linaro.org>
References: <20180122034217.19593-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 25/43] target/hppa: Implement LCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index bbef2f0d7f..b207ae192a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2451,6 +2451,25 @@ static DisasJumpType trans_lpa(DisasContext *ctx, uint32_t insn,
 
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
@@ -2479,6 +2498,7 @@ static const DisasInsn table_mem_mgmt[] = {
     { 0x04001200u, 0xfc001fdfu, trans_pxtlbx },       /* pdtlb */
     { 0x04001240u, 0xfc001fdfu, trans_pxtlbx },       /* pdtlbe */
     { 0x04001340u, 0xfc003fc0u, trans_lpa },
+    { 0x04001300u, 0xfc003fe0u, trans_lci },
 #endif
 };
 
-- 
2.14.3
