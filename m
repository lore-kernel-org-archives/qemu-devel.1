Received: from eggs.gnu.org ([2001:4830:134:3::10]:43577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFQ-0005KB-Oq
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFM-0003zS-Qy
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:20 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:44 +1100
Message-Id: <20181108121646.26173-21-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/22] This patch fixes processing of rfi
 instructions in icount mode.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com, Maria Klimushenkova <maria.klimushenkova@ispras.ru>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, David Gibson <david@gibson.dropbear.id.au>

From: Maria Klimushenkova <maria.klimushenkova@ispras.ru>

In this mode writing to interrupt/peripheral state is controlled
by can_do_io flag. This flag must be set explicitly before helper
function invocation.

Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index fb18cedcf0..2b37910248 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3919,9 +3919,15 @@ static void gen_rfi(DisasContext *ctx)
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
=20
@@ -3933,9 +3939,15 @@ static void gen_rfid(DisasContext *ctx)
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
=20
--=20
2.19.1
