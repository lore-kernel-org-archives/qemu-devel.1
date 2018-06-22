Received: from eggs.gnu.org ([2001:4830:134:3::10]:41873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMx0-0005yO-0t
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMwy-0003Zx-O6
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:09 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMwy-0003ZG-DJ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:08 -0400
Received: by mail-wm0-x235.google.com with SMTP id v131-v6so2837145wma.1
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:22:08 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:11:56 +0100
Message-Id: <20180622141205.16306-14-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 13/22] risu: move optional args to each
 architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The key variables here are: *arch_long_opts and *arch_extra_help. If
they are not NULL then we concatenate the extra options to appropriate
structure to enable the support. Adding architecture short options is
not supported.

This also includes moving the ARM specific test_fp_exc/test-fp-exc
into ARM specific code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2
  - better concatenation of default and extra opts
---
 risu.c                 | 29 +++++++++++++++++++++++++----
 risu.h                 |  6 ++++--
 risu_reginfo_aarch64.c |  3 +++
 risu_reginfo_arm.c     | 11 +++++++++++
 risu_reginfo_m68k.c    |  3 +++
 risu_reginfo_ppc64.c   |  3 +++
 6 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/risu.c b/risu.c
index c684c90..18de351 100644
--- a/risu.c
+++ b/risu.c
@@ -46,8 +46,7 @@ gzFile gz_trace_file;
 
 sigjmp_buf jmpbuf;
 
-/* Should we test for FP exception status bits? */
-int test_fp_exc;
+#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
 
 /* Master functions */
 
@@ -283,6 +282,9 @@ void usage(void)
     fprintf(stderr,
             "  -p, --port=PORT   Specify the port to connect to/listen on "
             "(default 9191)\n");
+    if (arch_extra_help) {
+        fprintf(stderr, "%s", arch_extra_help);
+    }
 }
 
 struct option * setup_options(char **short_opts)
@@ -293,12 +295,31 @@ struct option * setup_options(char **short_opts)
         {"host", required_argument, 0, 'h'},
         {"port", required_argument, 0, 'p'},
         {"trace", required_argument, 0, 't'},
-        {"test-fp-exc", no_argument, &test_fp_exc, 1},
         {0, 0, 0, 0}
     };
+    struct option *lopts = &default_longopts[0];
 
     *short_opts = "h:p:t:";
-    return default_longopts;
+
+    if (arch_long_opts) {
+        const size_t osize = sizeof(struct option);
+        const int default_count = ARRAY_SIZE(default_longopts);
+        struct option *dptr;
+        int extra_count = 0;
+
+        /* count additional opts */
+        dptr = arch_long_opts;
+        do {} while (dptr[extra_count++].name);
+
+        lopts = calloc(default_count + extra_count, osize);
+
+        /* Copy default opts + extra opts */
+        memcpy(lopts, default_longopts, default_count * osize);
+        dptr = &lopts[default_count - 1];
+        memcpy(dptr, arch_long_opts, extra_count * osize);
+    }
+
+    return lopts;
 }
 
 int main(int argc, char **argv)
diff --git a/risu.h b/risu.h
index 1c8ecee..89811f4 100644
--- a/risu.h
+++ b/risu.h
@@ -17,6 +17,10 @@
 #include <ucontext.h>
 #include <stdio.h>
 
+/* Extra option processing for architectures */
+extern void *arch_long_opts;
+extern char *arch_extra_help;
+
 /* GCC computed include to pull in the correct risu_reginfo_*.h for
  * the architecture.
  */
@@ -36,8 +40,6 @@ void send_response_byte(int sock, int resp);
 extern uintptr_t image_start_address;
 extern void *memblock;
 
-extern int test_fp_exc;
-
 /* Ops code under test can request from risu: */
 #define OP_COMPARE 0
 #define OP_TESTEND 1
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 3bb4339..ab12270 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -18,6 +18,9 @@
 #include "risu.h"
 #include "risu_reginfo_aarch64.h"
 
+void *arch_long_opts;
+char *arch_extra_help;
+
 /* reginfo_init: initialize with a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 {
diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
index 6b9ee7b..5acad02 100644
--- a/risu_reginfo_arm.c
+++ b/risu_reginfo_arm.c
@@ -13,12 +13,23 @@
 #include <stdio.h>
 #include <ucontext.h>
 #include <string.h>
+#include <getopt.h>
 
 #include "risu.h"
 #include "risu_reginfo_arm.h"
 
 extern int insnsize(ucontext_t *uc);
 
+/* Should we test for FP exception status bits? */
+static int test_fp_exc;
+static struct option extra_opts[] = {
+    {"test-fp-exc", no_argument, &test_fp_exc, 1},
+    {0, 0, 0, 0}
+};
+
+void *arch_long_opts = &extra_opts[0];
+char *arch_extra_help = "  --test-fp-exc     Check FP exception bits when comparing\n";
+
 static void reginfo_init_vfp(struct reginfo *ri, ucontext_t *uc)
 {
     /* Read VFP registers. These live in uc->uc_regspace, which is
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index 4ff0aa8..d429502 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -14,6 +14,9 @@
 #include "risu.h"
 #include "risu_reginfo_m68k.h"
 
+void *arch_long_opts;
+char *arch_extra_help;
+
 /* reginfo_init: initialize with a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 {
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index 5f33648..395111c 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -22,6 +22,9 @@
 #define XER 37
 #define CCR 38
 
+void *arch_long_opts;
+char *arch_extra_help;
+
 /* reginfo_init: initialize with a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 {
-- 
2.17.1
