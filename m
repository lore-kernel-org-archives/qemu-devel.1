Received: from eggs.gnu.org ([2001:4830:134:3::10]:58678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3i-0002eE-9f
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3g-0001mq-Vc
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:38 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:35 +1000
Message-Id: <20180612064503.14282-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/33] target/ppc: Use proper logging function
 for possible guest errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

fprintf() and qemu_log_separate() are frowned upon these days for printin=
g
logging information in QEMU. Accessing the wrong SPRs indicates wrong gue=
st
behaviour in most cases, and we've got a proper way to log such situation=
s,
which is the qemu_log_mask(LOG_GUEST_ERROR, ...) function. So use this
function now for logging the bad SPR accesses instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b28e8b91d3..8ba8f67dc5 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3933,13 +3933,9 @@ static inline void gen_op_mfspr(DisasContext *ctx)
              * allowing userland application to read the PVR
              */
             if (sprn !=3D SPR_PVR) {
-                fprintf(stderr, "Trying to read privileged spr %d (0x%03=
x) at "
-                        TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_nex=
t - 4);
-                if (qemu_log_separate()) {
-                    qemu_log("Trying to read privileged spr %d (0x%03x) =
at "
-                             TARGET_FMT_lx "\n", sprn, sprn,
-                             ctx->base.pc_next - 4);
-                }
+                qemu_log_mask(LOG_GUEST_ERROR, "Trying to read privilege=
d spr "
+                              "%d (0x%03x) at " TARGET_FMT_lx "\n", sprn=
, sprn,
+                              ctx->base.pc_next - 4);
             }
             gen_priv_exception(ctx, POWERPC_EXCP_PRIV_REG);
         }
@@ -3951,12 +3947,9 @@ static inline void gen_op_mfspr(DisasContext *ctx)
             return;
         }
         /* Not defined */
-        fprintf(stderr, "Trying to read invalid spr %d (0x%03x) at "
-                TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
-        if (qemu_log_separate()) {
-            qemu_log("Trying to read invalid spr %d (0x%03x) at "
-                     TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next -=
 4);
-        }
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Trying to read invalid spr %d (0x%03x) at "
+                      TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next =
- 4);
=20
         /* The behaviour depends on MSR:PR and SPR# bit 0x10,
          * it can generate a priv, a hv emu or a no-op
@@ -4097,12 +4090,9 @@ static void gen_mtspr(DisasContext *ctx)
             (*write_cb)(ctx, sprn, rS(ctx->opcode));
         } else {
             /* Privilege exception */
-            fprintf(stderr, "Trying to write privileged spr %d (0x%03x) =
at "
-                    TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - =
4);
-            if (qemu_log_separate()) {
-                qemu_log("Trying to write privileged spr %d (0x%03x) at =
"
-                         TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_ne=
xt - 4);
-            }
+            qemu_log_mask(LOG_GUEST_ERROR, "Trying to write privileged s=
pr "
+                          "%d (0x%03x) at " TARGET_FMT_lx "\n", sprn, sp=
rn,
+                          ctx->base.pc_next - 4);
             gen_priv_exception(ctx, POWERPC_EXCP_PRIV_REG);
         }
     } else {
@@ -4114,12 +4104,9 @@ static void gen_mtspr(DisasContext *ctx)
         }
=20
         /* Not defined */
-        if (qemu_log_separate()) {
-            qemu_log("Trying to write invalid spr %d (0x%03x) at "
-                     TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next -=
 4);
-        }
-        fprintf(stderr, "Trying to write invalid spr %d (0x%03x) at "
-                TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Trying to write invalid spr %d (0x%03x) at "
+                      TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next =
- 4);
=20
=20
         /* The behaviour depends on MSR:PR and SPR# bit 0x10,
--=20
2.17.1
