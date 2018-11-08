Received: from eggs.gnu.org ([2001:4830:134:3::10]:43506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFN-0005Iq-RA
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFM-0003xn-D1
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:17 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:40 +1100
Message-Id: <20181108121646.26173-17-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/22] target/ppc: fix mtmsr instruction for
 icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Maria Klimushenkova <maria.klimushenkova@ispras.ru>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, David Gibson <david@gibson.dropbear.id.au>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch fixes processing of mtmsr instructions in icount mode.
In this mode writing to interrupt/peripheral state is controlled
by can_do_io flag. This flag must be set explicitly before helper
function invocation.

Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c999832426..fb18cedcf0 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4298,11 +4298,17 @@ static void gen_mtmsrd(DisasContext *ctx)
          *      if we enter power saving mode, we will exit the loop
          *      directly from ppc_store_msr
          */
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
         gen_update_nip(ctx, ctx->base.pc_next);
         gen_helper_store_msr(cpu_env, cpu_gpr[rS(ctx->opcode)]);
         /* Must stop the translation as machine state (may have) changed=
 */
         /* Note that mtmsr is not always defined as context-synchronizin=
g */
         gen_stop_exception(ctx);
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+            gen_io_end();
+        }
     }
 #endif /* !defined(CONFIG_USER_ONLY) */
 }
@@ -4327,6 +4333,9 @@ static void gen_mtmsr(DisasContext *ctx)
          *      if we enter power saving mode, we will exit the loop
          *      directly from ppc_store_msr
          */
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
         gen_update_nip(ctx, ctx->base.pc_next);
 #if defined(TARGET_PPC64)
         tcg_gen_deposit_tl(msr, cpu_msr, cpu_gpr[rS(ctx->opcode)], 0, 32=
);
@@ -4334,6 +4343,9 @@ static void gen_mtmsr(DisasContext *ctx)
         tcg_gen_mov_tl(msr, cpu_gpr[rS(ctx->opcode)]);
 #endif
         gen_helper_store_msr(cpu_env, msr);
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+            gen_io_end();
+        }
         tcg_temp_free(msr);
         /* Must stop the translation as machine state (may have) changed=
 */
         /* Note that mtmsr is not always defined as context-synchronizin=
g */
--=20
2.19.1
