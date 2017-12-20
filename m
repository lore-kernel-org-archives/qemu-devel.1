Received: from eggs.gnu.org ([2001:4830:134:3::10]:33241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRiBe-0008Rj-1v
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRiBc-0007fV-Pf
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:29:46 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 20 Dec 2017 09:25:07 -0800
Message-ID: <6203a3d4e7a51f1508819c4f8916aa5fa97fbc01.1513790495.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1513790494.git.alistair.francis@xilinx.com>
References: <cover.1513790494.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 29/29] target: Use qemu_log() instead of
 fprintf(stderr, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com

Convert fprintf(stderr, ...) to use qemu_log(). Double prints in
target/ppc/translate.c were manually remove. A fprintf() in
target/sh4/translate.c was kept as it's inside a #if 0. The #if 0 and
fflush() was removed around the unimplemented log in
target/sh4/translate.c as well.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 target/cris/translate.c      |  2 +-
 target/ppc/translate.c       | 36 ++++++++++--------------------------
 target/sh4/translate.c       |  7 ++-----
 target/unicore32/translate.c |  2 +-
 4 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index 2831419845..d2dba748cd 100644
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
index 4075fc8589..eb1fa9a0cf 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3938,12 +3938,8 @@ static inline void gen_op_mfspr(DisasContext *ctx)
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
@@ -3955,12 +3951,8 @@ static inline void gen_op_mfspr(DisasContext *ctx)
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
@@ -4101,12 +4093,8 @@ static void gen_mtspr(DisasContext *ctx)
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
@@ -4118,12 +4106,8 @@ static void gen_mtspr(DisasContext *ctx)
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
@@ -7365,8 +7349,8 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
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
index 8569179883..5de92b19e9 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1787,11 +1787,8 @@ static void _decode_opc(DisasContext * ctx)
         }
         break;
     }
-#if 0
-    fprintf(stderr, "unknown instruction 0x%04x at pc 0x%08x\n",
-	    ctx->opcode, ctx->pc);
-    fflush(stderr);
-#endif
+    qemu_log_mask(LOG_UNIMP, "unknown instruction 0x%04x at pc 0x%08x\n",
+                  ctx->opcode, ctx->pc);
  do_illegal:
     if (ctx->envflags & DELAY_SLOT_MASK) {
  do_illegal_slot:
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 384aa86027..1d4f3dd2ac 100644
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
2.14.1
