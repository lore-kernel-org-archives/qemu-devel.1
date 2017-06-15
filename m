Received: from eggs.gnu.org ([2001:4830:134:3::10]:36673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <miodrag.dinic@rt-rk.com>) id 1dLVdz-00022a-TA
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <miodrag.dinic@rt-rk.com>) id 1dLVdv-00061Q-Ub
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:21:07 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50787 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <miodrag.dinic@rt-rk.com>)
	id 1dLVdv-0005mk-MC
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 10:21:03 -0400
From: Miodrag Dinic <miodrag.dinic@rt-rk.com>
Date: Thu, 15 Jun 2017 16:20:33 +0200
Message-Id: <1497536433-28009-1-git-send-email-miodrag.dinic@rt-rk.com>
Subject: [Qemu-devel] [PATCH] target/mips: fix msa copy_[s|u]_df rd = 0
 corner case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aurelien@aurel32.net, yongbok.kim@imgtec.com, qemu-devel@nongnu.org
Cc: aleksandar.markovic@imgtec.com, petar.jovanovic@imgtec.com, raghu.gandham@imgtec.com, miodrag.dinic@imgtec.com

From: Miodrag Dinic <miodrag.dinic@imgtec.com>

This patch fixes the msa copy_[s|u]_df instruction emulation when
the destination register rd is zero. Without this patch the zero
register would get clobbered, which should never happen because it
is supposed to be hardwired to 0.

Fix this corner case by explicitly checking rd = 0 and effectively
making these instructions emulation no-op in that case.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
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
1.9.1
