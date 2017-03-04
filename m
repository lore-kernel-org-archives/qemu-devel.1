Received: from eggs.gnu.org ([2001:4830:134:3::10]:58123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEs4-0006tD-Ov
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEs3-0008Fx-P6
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:36 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEs3-0008Fo-K3
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:35 -0500
Received: by mail-qk0-x244.google.com with SMTP id n141so11289041qke.3
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 10:57:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  4 Mar 2017 15:56:52 -0300
Message-Id: <20170304185652.10675-6-f4bug@amsat.org>
In-Reply-To: <20170304185652.10675-1-f4bug@amsat.org>
References: <20170304185652.10675-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/5] target-mips: replace few LOG_DISAS() with
 trace points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 Makefile.objs            |  1 +
 target/mips/trace-events |  5 +++++
 target/mips/translate.c  | 25 +++++++++++--------------
 3 files changed, 17 insertions(+), 14 deletions(-)
 create mode 100644 target/mips/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index e740500e2d..6167e7b17d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -157,6 +157,7 @@ trace-events-subdirs += audio
 trace-events-subdirs += net
 trace-events-subdirs += target/arm
 trace-events-subdirs += target/i386
+trace-events-subdirs += target/mips
 trace-events-subdirs += target/sparc
 trace-events-subdirs += target/s390x
 trace-events-subdirs += target/ppc
diff --git a/target/mips/trace-events b/target/mips/trace-events
new file mode 100644
index 0000000000..43824089b3
--- /dev/null
+++ b/target/mips/trace-events
@@ -0,0 +1,5 @@
+# See docs/tracing.txt for syntax documentation.
+
+# target/mips/translate.c
+mips_translate_c0(const char *instr, const char *rn, int reg, int sel) "%s %s (reg %d sel %d)"
+mips_translate_tr(const char *instr, int rt, int u, int sel, int h) "%s (reg %d u %d sel %d h %d)"
diff --git a/target/mips/translate.c b/target/mips/translate.c
index fc11e15a17..78b7264add 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -33,6 +33,7 @@
 #include "sysemu/kvm.h"
 #include "exec/semihost.h"
 
+#include "target/mips/trace.h"
 #include "trace-tcg.h"
 #include "exec/log.h"
 
@@ -4866,9 +4867,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     default:
         goto cp0_unimplemented;
     }
-
-    (void)rn; /* avoid a compiler warning */
-    LOG_DISAS("mfhc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    trace_mips_translate_c0("mfhc0", rn, reg, sel);
     return;
 
 cp0_unimplemented:
@@ -4941,8 +4940,8 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     default:
         goto cp0_unimplemented;
     }
+    trace_mips_translate_c0("mthc0", rn, reg, sel);
 
-    (void)rn; /* avoid a compiler warning */
 cp0_unimplemented:
     qemu_log_mask(LOG_UNIMP, "mthc0 %s (reg %d sel %d)\n", rn, reg, sel);
 }
@@ -5622,8 +5621,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     default:
        goto cp0_unimplemented;
     }
-    (void)rn; /* avoid a compiler warning */
-    LOG_DISAS("mfc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    trace_mips_translate_c0("mfc0", rn, reg, sel);
     return;
 
 cp0_unimplemented:
@@ -6284,8 +6282,8 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     default:
        goto cp0_unimplemented;
     }
-    (void)rn; /* avoid a compiler warning */
-    LOG_DISAS("mtc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    trace_mips_translate_c0("mtc0", rn, reg, sel);
+
     /* For simplicity assume that all writes can cause interrupts.  */
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
         gen_io_end();
@@ -6923,8 +6921,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     default:
         goto cp0_unimplemented;
     }
-    (void)rn; /* avoid a compiler warning */
-    LOG_DISAS("dmfc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    trace_mips_translate_c0("dmfc0", rn, reg, sel);
     return;
 
 cp0_unimplemented:
@@ -7583,8 +7580,8 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     default:
         goto cp0_unimplemented;
     }
-    (void)rn; /* avoid a compiler warning */
-    LOG_DISAS("dmtc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    trace_mips_translate_c0("dmtc0", rn, reg, sel);
+
     /* For simplicity assume that all writes can cause interrupts.  */
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
         gen_io_end();
@@ -7803,7 +7800,7 @@ static void gen_mftr(CPUMIPSState *env, DisasContext *ctx, int rt, int rd,
     default:
         goto die;
     }
-    LOG_DISAS("mftr (reg %d u %d sel %d h %d)\n", rt, u, sel, h);
+    trace_mips_translate_tr("mftr", rt, u, sel, h);
     gen_store_gpr(t0, rd);
     tcg_temp_free(t0);
     return;
@@ -8008,7 +8005,7 @@ static void gen_mttr(CPUMIPSState *env, DisasContext *ctx, int rd, int rt,
     default:
         goto die;
     }
-    LOG_DISAS("mttr (reg %d u %d sel %d h %d)\n", rd, u, sel, h);
+    trace_mips_translate_tr("mttr", rd, u, sel, h);
     tcg_temp_free(t0);
     return;
 
-- 
2.11.0
