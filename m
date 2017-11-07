Received: from eggs.gnu.org ([2001:4830:134:3::10]:34710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SD-0005nG-PP
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SC-0008V4-7O
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:17 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:51462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eC5SB-0008UB-Kd
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:16 -0500
Received: by mail-wr0-x241.google.com with SMTP id j15so12123142wre.8
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:06:15 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  7 Nov 2017 15:05:52 +0000
Message-Id: <20171107150558.22131-5-alex.bennee@linaro.org>
In-Reply-To: <20171107150558.22131-1-alex.bennee@linaro.org>
References: <20171107150558.22131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 04/10] risu: move optional args to each
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
Cc: Dave.Martin@arm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The key variables here are: *arch_long_opts and *arch_extra_help. If
they are not NULL then we concatenate the extra options to appropriate
structure to enable the support. Adding architecture short options is
not supported.

This also includes moving the ARM specific test_fp_exc/test-fp-exc
into ARM specific code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risu.c                 | 31 ++++++++++++++++++++++++++-----
 risu.h                 |  6 ++++--
 risu_reginfo_aarch64.c |  3 +++
 risu_reginfo_arm.c     | 11 +++++++++++
 risu_reginfo_m68k.c    |  3 +++
 risu_reginfo_ppc64.c   |  3 +++
 6 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/risu.c b/risu.c
index 616fc33..f063093 100644
--- a/risu.c
+++ b/risu.c
@@ -43,9 +43,6 @@ gzFile gz_trace_file;
 
 sigjmp_buf jmpbuf;
 
-/* Should we test for FP exception status bits? */
-int test_fp_exc;
-
 /* Master functions */
 
 int read_sock(void *ptr, size_t bytes)
@@ -280,6 +277,9 @@ void usage(void)
     fprintf(stderr,
             "  -p, --port=PORT   Specify the port to connect to/listen on "
             "(default 9191)\n");
+    if (arch_extra_help) {
+        fprintf(stderr, "%s", arch_extra_help);
+    }
 }
 
 struct option * setup_options(char **short_opts)
@@ -290,12 +290,33 @@ struct option * setup_options(char **short_opts)
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
+        struct option *dptr, *sptr;
+        size_t osize = sizeof(default_longopts);
+        lopts = malloc(osize);
+        /* Copy default opts */
+        memcpy(lopts, default_longopts, osize);
+        dptr = lopts;
+        while (dptr->name) {
+            dptr++;
+        }
+        /* Copy extra opts */
+        sptr = arch_long_opts;
+        while (sptr->name) {
+            osize += sizeof(struct option);
+            lopts = realloc(lopts, osize);
+            *dptr++ = *sptr++;
+        }
+        memset(dptr, 0, sizeof(struct option));
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
index e3fadde..38ad338 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -17,6 +17,9 @@
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
index eb9c12b..aa5d8c6 100644
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
2.14.2
