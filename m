Received: from eggs.gnu.org ([208.118.235.92]:45322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehgGc-0001g7-5S
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehgDR-0005fq-Nw
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:40:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehgDR-0005eA-Ei
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:37:37 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 19:37:31 +0100
Message-Id: <20180202183731.29990-16-armbru@redhat.com>
In-Reply-To: <20180202183731.29990-1-armbru@redhat.com>
References: <20180202183731.29990-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v7 15/15] target: Use qemu_log() instead of
 fprintf(stderr, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com

From: Alistair Francis <alistair.francis@xilinx.com>

Convert fprintf(stderr, ...) to use qemu_log(). Double prints in
target/ppc/translate.c were manually remove. A fprintf() in
target/sh4/translate.c was kept as it's inside a #if 0. The #if 0 and
fflush() was removed around the unimplemented log in
target/sh4/translate.c as well.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
[Trivial conflict with 6f1c2af641d resolved]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 dtc                          |  2 +-
 target/cris/translate.c      |  2 +-
 target/ppc/translate.c       | 36 ++++++++++--------------------------
 target/sh4/translate.c       |  7 ++-----
 target/unicore32/translate.c |  2 +-
 5 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/dtc b/dtc
index e54388015a..558cd81bdd 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
+Subproject commit 558cd81bdd432769b59bff01240c44f82cfb1a9d
diff --git a/target/cris/translate.c b/target/cris/translate.c
index f51a731db9..ff31311ed0 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -137,7 +137,7 @@ typedef struct DisasContext {
 
 static void gen_BUG(DisasContext *dc, const char *file, int line)
 {
-    fprintf(stderr, "BUG: pc=%x %s %d\n", dc->pc, file, line);
+    qemu_log("BUG: pc=%x %s %d\n", dc->pc, file, line);
     if (qemu_log_separate()) {
         qemu_log("BUG: pc=%x %s %d\n", dc->pc, file, line);
     }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4132f67bb1..172c9f2001 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3933,12 +3933,8 @@ static inline void gen_op_mfspr(DisasContext *ctx)
              * allowing userland application to read the PVR
              */
             if (sprn != SPR_PVR) {
-                fprintf(stderr, "Trying to read privileged spr %d (0x%03x) at "
-                        TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
-                if (qemu_log_separate()) {
-                    qemu_log("Trying to read privileged spr %d (0x%03x) at "
-                             TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
-                }
+                qemu_log("Trying to read privileged spr %d (0x%03x) at "
+                         TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
             }
             gen_priv_exception(ctx, POWERPC_EXCP_PRIV_REG);
         }
@@ -3950,12 +3946,8 @@ static inline void gen_op_mfspr(DisasContext *ctx)
             return;
         }
         /* Not defined */
-        fprintf(stderr, "Trying to read invalid spr %d (0x%03x) at "
-                TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
-        if (qemu_log_separate()) {
-            qemu_log("Trying to read invalid spr %d (0x%03x) at "
-                     TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
-        }
+        qemu_log("Trying to read invalid spr %d (0x%03x) at "
+                 TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
 
         /* The behaviour depends on MSR:PR and SPR# bit 0x10,
          * it can generate a priv, a hv emu or a no-op
@@ -4096,12 +4088,8 @@ static void gen_mtspr(DisasContext *ctx)
             (*write_cb)(ctx, sprn, rS(ctx->opcode));
         } else {
             /* Privilege exception */
-            fprintf(stderr, "Trying to write privileged spr %d (0x%03x) at "
-                    TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
-            if (qemu_log_separate()) {
-                qemu_log("Trying to write privileged spr %d (0x%03x) at "
-                         TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
-            }
+            qemu_log("Trying to write privileged spr %d (0x%03x) at "
+                     TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
             gen_priv_exception(ctx, POWERPC_EXCP_PRIV_REG);
         }
     } else {
@@ -4113,12 +4101,8 @@ static void gen_mtspr(DisasContext *ctx)
         }
 
         /* Not defined */
-        if (qemu_log_separate()) {
-            qemu_log("Trying to write invalid spr %d (0x%03x) at "
-                     TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
-        }
-        fprintf(stderr, "Trying to write invalid spr %d (0x%03x) at "
-                TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
+        qemu_log("Trying to write invalid spr %d (0x%03x) at "
+                 TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
 
 
         /* The behaviour depends on MSR:PR and SPR# bit 0x10,
@@ -7381,8 +7365,8 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             break;
         }
         if (tcg_check_temp_count()) {
-            fprintf(stderr, "Opcode %02x %02x %02x %02x (%08x) leaked "
-                    "temporaries\n", opc1(ctx.opcode), opc2(ctx.opcode),
+            qemu_log("Opcode %02x %02x %02x %02x (%08x) leaked "
+                     "temporaries\n", opc1(ctx.opcode), opc2(ctx.opcode),
                     opc3(ctx.opcode), opc4(ctx.opcode), ctx.opcode);
             exit(1);
         }
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 012156b97b..6c2dca5cf2 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1827,11 +1827,8 @@ static void _decode_opc(DisasContext * ctx)
         }
         break;
     }
-#if 0
-    fprintf(stderr, "unknown instruction 0x%04x at pc 0x%08x\n",
-            ctx->opcode, ctx->base.pc_next);
-    fflush(stderr);
-#endif
+    qemu_log_mask(LOG_UNIMP, "unknown instruction 0x%04x at pc 0x%08x\n",
+                  ctx->opcode, ctx->base.pc_next);
  do_illegal:
     if (ctx->envflags & DELAY_SLOT_MASK) {
  do_illegal_slot:
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 5b51f2166d..4b3c0463da 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1936,7 +1936,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         disas_uc32_insn(env, dc);
 
         if (num_temps) {
-            fprintf(stderr, "Internal resource leak before %08x\n", dc->pc);
+            qemu_log("Internal resource leak before %08x\n", dc->pc);
             num_temps = 0;
         }
 
-- 
2.13.6
