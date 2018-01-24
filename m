Received: from eggs.gnu.org ([2001:4830:134:3::10]:51209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURg-0004qv-Vi
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURg-0001yU-3X
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:08 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeURf-0001yB-V7
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:08 -0500
Received: by mail-pg0-x242.google.com with SMTP id o13so3818865pgs.2
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:27:07 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	z19sm9760028pfh.185.2018.01.24.15.27.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jan 2018 15:27:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:26:05 -0800
Message-Id: <20180124232625.30105-26-richard.henderson@linaro.org>
In-Reply-To: <20180124232625.30105-1-richard.henderson@linaro.org>
References: <20180124232625.30105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 25/45] target/hppa: Implement LCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 082221f450..41e28ff64c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2462,6 +2462,25 @@ static DisasJumpType trans_lpa(DisasContext *ctx, uint32_t insn,
 
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
@@ -2490,6 +2509,7 @@ static const DisasInsn table_mem_mgmt[] = {
     { 0x04001200u, 0xfc001fdfu, trans_pxtlbx },       /* pdtlb */
     { 0x04001240u, 0xfc001fdfu, trans_pxtlbx },       /* pdtlbe */
     { 0x04001340u, 0xfc003fc0u, trans_lpa },
+    { 0x04001300u, 0xfc003fe0u, trans_lci },
 #endif
 };
 
-- 
2.14.3
