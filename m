Received: from eggs.gnu.org ([2001:4830:134:3::10]:55851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dUwtk-0005j1-2Q
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dUwth-0005xu-4a
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:16:24 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:36075)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dUwtg-0005wv-Uv
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:16:21 -0400
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
	by Forcepoint Email with ESMTPS id B9BBAADA4F336
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 16:16:13 +0100 (IST)
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Tue, 11 Jul 2017 16:16:04 +0100
Message-ID: <1499786165-9404-2-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1499786165-9404-1-git-send-email-yongbok.kim@imgtec.com>
References: <1499786165-9404-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 1/2] target/mips: fix msa copy_[s|u]_df rd = 0
 corner case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Miodrag Dinic <miodrag.dinic@imgtec.com>

From: Miodrag Dinic <miodrag.dinic@imgtec.com>

This patch fixes the msa copy_[s|u]_df instruction emulation when
the destination register rd is zero. Without this patch the zero
register would get clobbered, which should never happen because it
is supposed to be hardwired to 0.

Fix this corner case by explicitly checking rd = 0 and effectively
making these instructions emulation no-op in that case.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Acked-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/translate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 559f8fe..befb87f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -18712,10 +18712,14 @@ static void gen_msa_elm_df(CPUMIPSState *env, DisasContext *ctx, uint32_t df,
 #endif
         switch (MASK_MSA_ELM(ctx->opcode)) {
         case OPC_COPY_S_df:
-            gen_helper_msa_copy_s_df(cpu_env, tdf, twd, tws, tn);
+            if (likely(wd != 0)) {
+                gen_helper_msa_copy_s_df(cpu_env, tdf, twd, tws, tn);
+            }
             break;
         case OPC_COPY_U_df:
-            gen_helper_msa_copy_u_df(cpu_env, tdf, twd, tws, tn);
+            if (likely(wd != 0)) {
+                gen_helper_msa_copy_u_df(cpu_env, tdf, twd, tws, tn);
+            }
             break;
         case OPC_INSERT_df:
             gen_helper_msa_insert_df(cpu_env, tdf, twd, tws, tn);
-- 
2.7.4
