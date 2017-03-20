Received: from eggs.gnu.org ([2001:4830:134:3::10]:45649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvV-0003uf-N1
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvS-00070z-Uc
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:45 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:46339)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvS-00070W-M3
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:42 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Mon, 20 Mar 2017 13:00:21 +0000
Message-ID: <1490014826-4472-6-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
References: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for v2.9 05/10] target-mips: replace few
 LOG_DISAS() with trace points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 Makefile.objs            |  1 +
 target/mips/trace-events |  5 +++++
 target/mips/translate.c  | 25 +++++++++++--------------
 3 files changed, 17 insertions(+), 14 deletions(-)
 create mode 100644 target/mips/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index e740500..6167e7b 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -157,6 +157,7 @@ trace-events-subdirs +=3D audio
 trace-events-subdirs +=3D net
 trace-events-subdirs +=3D target/arm
 trace-events-subdirs +=3D target/i386
+trace-events-subdirs +=3D target/mips
 trace-events-subdirs +=3D target/sparc
 trace-events-subdirs +=3D target/s390x
 trace-events-subdirs +=3D target/ppc
diff --git a/target/mips/trace-events b/target/mips/trace-events
new file mode 100644
index 0000000..4382408
--- /dev/null
+++ b/target/mips/trace-events
@@ -0,0 +1,5 @@
+# See docs/tracing.txt for syntax documentation.
+
+# target/mips/translate.c
+mips_translate_c0(const char *instr, const char *rn, int reg, int sel) "=
%s %s (reg %d sel %d)"
+mips_translate_tr(const char *instr, int rt, int u, int sel, int h) "%s =
(reg %d u %d sel %d h %d)"
diff --git a/target/mips/translate.c b/target/mips/translate.c
index fc11e15..78b7264 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -33,6 +33,7 @@
 #include "sysemu/kvm.h"
 #include "exec/semihost.h"
=20
+#include "target/mips/trace.h"
 #include "trace-tcg.h"
 #include "exec/log.h"
=20
@@ -4866,9 +4867,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
     default:
         goto cp0_unimplemented;
     }
-
-    (void)rn; /* avoid a compiler warning */
-    LOG_DISAS("mfhc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    trace_mips_translate_c0("mfhc0", rn, reg, sel);
     return;
=20
 cp0_unimplemented:
@@ -4941,8 +4940,8 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
     default:
         goto cp0_unimplemented;
     }
+    trace_mips_translate_c0("mthc0", rn, reg, sel);
=20
-    (void)rn; /* avoid a compiler warning */
 cp0_unimplemented:
     qemu_log_mask(LOG_UNIMP, "mthc0 %s (reg %d sel %d)\n", rn, reg, sel)=
;
 }
@@ -5622,8 +5621,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, i=
nt reg, int sel)
     default:
        goto cp0_unimplemented;
     }
-    (void)rn; /* avoid a compiler warning */
-    LOG_DISAS("mfc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    trace_mips_translate_c0("mfc0", rn, reg, sel);
     return;
=20
 cp0_unimplemented:
@@ -6284,8 +6282,8 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, i=
nt reg, int sel)
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
@@ -6923,8 +6921,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
     default:
         goto cp0_unimplemented;
     }
-    (void)rn; /* avoid a compiler warning */
-    LOG_DISAS("dmfc0 %s (reg %d sel %d)\n", rn, reg, sel);
+    trace_mips_translate_c0("dmfc0", rn, reg, sel);
     return;
=20
 cp0_unimplemented:
@@ -7583,8 +7580,8 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
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
@@ -7803,7 +7800,7 @@ static void gen_mftr(CPUMIPSState *env, DisasContex=
t *ctx, int rt, int rd,
     default:
         goto die;
     }
-    LOG_DISAS("mftr (reg %d u %d sel %d h %d)\n", rt, u, sel, h);
+    trace_mips_translate_tr("mftr", rt, u, sel, h);
     gen_store_gpr(t0, rd);
     tcg_temp_free(t0);
     return;
@@ -8008,7 +8005,7 @@ static void gen_mttr(CPUMIPSState *env, DisasContex=
t *ctx, int rd, int rt,
     default:
         goto die;
     }
-    LOG_DISAS("mttr (reg %d u %d sel %d h %d)\n", rd, u, sel, h);
+    trace_mips_translate_tr("mttr", rd, u, sel, h);
     tcg_temp_free(t0);
     return;
=20
--=20
2.7.4
