Received: from eggs.gnu.org ([2001:4830:134:3::10]:52190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gHQML-0006lH-Bi
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gHQMH-0001Pr-9u
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:30:49 -0400
Received: from mail.ispras.ru ([83.149.199.45]:34410)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gHQMH-00018k-02
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:30:45 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 30 Oct 2018 12:30:31 +0300
Message-ID: <20181030093031.10131.17221.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] target/ppc: fix mtmsr instruction for icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, agraf@suse.de, pavel.dovgaluk@ispras.ru, david@gibson.dropbear.id.au

This patch fixes processing of mtmsr instructions in icount mode.
In this mode writing to interrupt/peripheral state is controlled
by can_do_io flag. This flag must be set explicitly before helper
function invocation.

Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 target/ppc/translate.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4e59dd5..987ce6e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4257,11 +4257,17 @@ static void gen_mtmsrd(DisasContext *ctx)
          *      if we enter power saving mode, we will exit the loop
          *      directly from ppc_store_msr
          */
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
         gen_update_nip(ctx, ctx->base.pc_next);
         gen_helper_store_msr(cpu_env, cpu_gpr[rS(ctx->opcode)]);
         /* Must stop the translation as machine state (may have) changed */
         /* Note that mtmsr is not always defined as context-synchronizing */
         gen_stop_exception(ctx);
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+            gen_io_end();
+        }
     }
 #endif /* !defined(CONFIG_USER_ONLY) */
 }
@@ -4286,6 +4292,9 @@ static void gen_mtmsr(DisasContext *ctx)
          *      if we enter power saving mode, we will exit the loop
          *      directly from ppc_store_msr
          */
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
         gen_update_nip(ctx, ctx->base.pc_next);
 #if defined(TARGET_PPC64)
         tcg_gen_deposit_tl(msr, cpu_msr, cpu_gpr[rS(ctx->opcode)], 0, 32);
@@ -4293,6 +4302,9 @@ static void gen_mtmsr(DisasContext *ctx)
         tcg_gen_mov_tl(msr, cpu_gpr[rS(ctx->opcode)]);
 #endif
         gen_helper_store_msr(cpu_env, msr);
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+            gen_io_end();
+        }
         tcg_temp_free(msr);
         /* Must stop the translation as machine state (may have) changed */
         /* Note that mtmsr is not always defined as context-synchronizing */
