Received: from eggs.gnu.org ([2001:4830:134:3::10]:55431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gHT1l-00022F-4g
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gHT1g-00068F-2o
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:21:45 -0400
Received: from mail.ispras.ru ([83.149.199.45]:53500)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gHT1f-00063l-KF
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:21:39 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 30 Oct 2018 15:21:34 +0300
Message-ID: <20181030122134.11055.15711.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] This patch fixes processing of rfi
 instructions in icount mode.
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

From: Maria Klimushenkova <maria.klimushenkova@ispras.ru>

In this mode writing to interrupt/peripheral state is controlled
by can_do_io flag. This flag must be set explicitly before helper
function invocation.

Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 target/ppc/translate.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 987ce6e..980862c 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3878,9 +3878,15 @@ static void gen_rfi(DisasContext *ctx)
     }
     /* Restore CPU state */
     CHK_SV;
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_update_cfar(ctx, ctx->base.pc_next - 4);
     gen_helper_rfi(cpu_env);
     gen_sync_exception(ctx);
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_end();
+    }
 #endif
 }
 
@@ -3892,9 +3898,15 @@ static void gen_rfid(DisasContext *ctx)
 #else
     /* Restore CPU state */
     CHK_SV;
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
     gen_update_cfar(ctx, ctx->base.pc_next - 4);
     gen_helper_rfid(cpu_env);
     gen_sync_exception(ctx);
+    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+        gen_io_end();
+    }
 #endif
 }
 
