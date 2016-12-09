Received: from eggs.gnu.org ([2001:4830:134:3::10]:41852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgV-0007Uh-4B
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgO-0007rG-UF
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:51 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFJgO-0007qJ-MG
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:44 -0500
Received: by mail-wm0-f42.google.com with SMTP id f82so23298571wmf.1
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 03:49:44 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Dec 2016 11:48:24 +0000
Message-Id: <20161209114830.9158-5-alex.bennee@linaro.org>
In-Reply-To: <20161209114830.9158-1-alex.bennee@linaro.org>
References: <20161209114830.9158-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 04/10] risu: add simple trace and
 replay support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This adds a very dumb and easily breakable trace and replay support. In
--master mode the various risu ops trigger a write of register/memory
state into a binary file which can be played back to an apprentice.
Currently there is no validation of the image source so feeding the
wrong image will fail straight away.

The trace files will get very big for any appreciable sized test file
and this will be addressed in later patches.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---

v2
  - moved read/write functions into main risu.c
  - cleaned up formatting
  - report more in apprentice --trace mode
v3
  - fix options parsing
  - re-factored so no need for copy & paste
---
 risu.c         | 108 +++++++++++++++++++++++++++++++++++++++++++++++----------
 risu_aarch64.c |   5 ++-
 risu_arm.c     |   4 +--
 3 files changed, 93 insertions(+), 24 deletions(-)

diff --git a/risu.c b/risu.c
index 22571cd..173dd3c 100644
--- a/risu.c
+++ b/risu.c
@@ -31,6 +31,7 @@
 void *memblock = 0;
 
 int apprentice_socket, master_socket;
+int trace_file = 0;
 
 sigjmp_buf jmpbuf;
 
@@ -40,10 +41,12 @@ int test_fp_exc = 0;
 long executed_tests = 0;
 void report_test_status(void *pc)
 {
-   executed_tests += 1;
-   if (executed_tests % 100 == 0) {
-      fprintf(stderr,"Executed %ld test instructions (pc=%p)\r",
-              executed_tests, pc);
+   if (ismaster || trace_file) {
+      executed_tests += 1;
+      if (executed_tests % 100 == 0) {
+         fprintf(stderr,"Executed %ld test instructions (pc=%p)\r",
+                 executed_tests, pc);
+      }
    }
 }
 
@@ -54,6 +57,12 @@ int read_sock(void *ptr, size_t bytes)
    return recv_data_pkt(master_socket, ptr, bytes);
 }
 
+int write_trace(void *ptr, size_t bytes)
+{
+   size_t res = write(trace_file, ptr, bytes);
+   return (res == bytes) ? 0 : 1;
+}
+
 void respond_sock(int r)
 {
    send_response_byte(master_socket, r);
@@ -66,26 +75,62 @@ int write_sock(void *ptr, size_t bytes)
    return send_data_pkt(apprentice_socket, ptr, bytes);
 }
 
+int read_trace(void *ptr, size_t bytes)
+{
+   size_t res = read(trace_file, ptr, bytes);
+   return (res == bytes) ? 0 : 1;
+}
+
+void respond_trace(int r)
+{
+   switch (r) {
+      case 0: /* test ok */
+      case 1: /* end of test */
+         break;
+      default:
+         fprintf(stderr,"%s: got response of %d\n", __func__, r);
+         break;
+   }
+}
+
 void master_sigill(int sig, siginfo_t *si, void *uc)
 {
-   switch (recv_and_compare_register_info(read_sock, respond_sock, uc))
+   int r;
+
+   if (trace_file) {
+      r = send_register_info(write_trace, uc);
+   } else {
+      r = recv_and_compare_register_info(read_sock, respond_sock, uc);
+   }
+
+   switch (r)
    {
       case 0:
-         /* match OK */
+         /* All OK */
          advance_pc(uc);
          return;
       default:
          /* mismatch, or end of test */
          siglongjmp(jmpbuf, 1);
+         /* never */
+         return;
    }
 }
 
 void apprentice_sigill(int sig, siginfo_t *si, void *uc)
 {
-   switch (send_register_info(write_sock, uc))
+   int r;
+
+   if (trace_file) {
+      r = recv_and_compare_register_info(read_trace, respond_trace, uc);
+   } else {
+      r = send_register_info(write_sock, uc);
+   }
+
+   switch (r)
    {
       case 0:
-         /* match OK */
+         /* All OK */
          advance_pc(uc);
          return;
       case 1:
@@ -94,6 +139,9 @@ void apprentice_sigill(int sig, siginfo_t *si, void *uc)
          exit(0);
       default:
          /* mismatch */
+         if (trace_file) {
+            report_match_status();
+         }
          exit(1);
    }
 }
@@ -155,7 +203,13 @@ int master(int sock)
 {
    if (sigsetjmp(jmpbuf, 1))
    {
-      return report_match_status();
+      if (trace_file) {
+         close(trace_file);
+         fprintf(stderr,"\nDone...\n");
+         return 0;
+      } else {
+         return report_match_status();
+      }
    }
    master_socket = sock;
    set_sigill_handler(&master_sigill);
@@ -184,6 +238,7 @@ void usage (void)
    fprintf(stderr, "between master and apprentice risu processes.\n\n");
    fprintf(stderr, "Options:\n");
    fprintf(stderr, "  --master          Be the master (server)\n");
+   fprintf(stderr, "  -t, --trace=FILE  Record/playback trace file\n");
    fprintf(stderr, "  -h, --host=HOST   Specify master host machine (apprentice only)\n");
    fprintf(stderr, "  -p, --port=PORT   Specify the port to connect to/listen on (default 9191)\n");
 }
@@ -194,6 +249,7 @@ int main(int argc, char **argv)
    uint16_t port = 9191;
    char *hostname = "localhost";
    char *imgfile;
+   char *trace_fn = NULL;
    int sock;
 
    // TODO clean this up later
@@ -204,13 +260,14 @@ int main(int argc, char **argv)
          {
             { "help", no_argument, 0, '?'},
             { "master", no_argument, &ismaster, 1 },
+            { "trace", required_argument, 0, 't' },
             { "host", required_argument, 0, 'h' },
             { "port", required_argument, 0, 'p' },
             { "test-fp-exc", no_argument, &test_fp_exc, 1 },
             { 0,0,0,0 }
          };
       int optidx = 0;
-      int c = getopt_long(argc, argv, "h:p:", longopts, &optidx);
+      int c = getopt_long(argc, argv, "h:p:t:", longopts, &optidx);
       if (c == -1)
       {
          break;
@@ -223,6 +280,11 @@ int main(int argc, char **argv)
             /* flag set by getopt_long, do nothing */
             break;
          }
+         case 't':
+         {
+           trace_fn = optarg;
+           break;
+         }
          case 'h':
          {
             hostname = optarg;
@@ -253,18 +315,28 @@ int main(int argc, char **argv)
    }
 
    load_image(imgfile);
-   
+
    if (ismaster)
    {
-      fprintf(stderr, "master port %d\n", port);
-      sock = master_connect(port);
-      return master(sock);
+     if (trace_fn)
+       {
+         trace_file = open(trace_fn, O_WRONLY|O_CREAT, S_IRWXU);
+       } else {
+         fprintf(stderr, "master port %d\n", port);
+         sock = master_connect(port);
+       }
+     return master(sock);
    }
    else
-   {
-      fprintf(stderr, "apprentice host %s port %d\n", hostname, port);
-      sock = apprentice_connect(hostname, port);
-      return apprentice(sock);
+     {
+     if (trace_fn)
+       {
+         trace_file = open(trace_fn, O_RDONLY);
+       } else {
+         fprintf(stderr, "apprentice host %s port %d\n", hostname, port);
+         sock = apprentice_connect(hostname, port);
+       }
+     return apprentice(sock);
    }
 }
 
diff --git a/risu_aarch64.c b/risu_aarch64.c
index c4c0d4d..7f9f612 100644
--- a/risu_aarch64.c
+++ b/risu_aarch64.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <ucontext.h>
 #include <string.h>
+#include <unistd.h>
 
 #include "risu.h"
 #include "risu_reginfo_aarch64.h"
@@ -28,9 +29,7 @@ void advance_pc(void *vuc)
 {
     ucontext_t *uc = vuc;
     uc->uc_mcontext.pc += 4;
-    if (ismaster) {
-      report_test_status((void *) uc->uc_mcontext.pc);
-    }
+    report_test_status((void *) uc->uc_mcontext.pc);
 }
 
 static void set_x0(void *vuc, uint64_t x0)
diff --git a/risu_arm.c b/risu_arm.c
index 474729c..77bdcac 100644
--- a/risu_arm.c
+++ b/risu_arm.c
@@ -50,9 +50,7 @@ void advance_pc(void *vuc)
 {
    ucontext_t *uc = vuc;
    uc->uc_mcontext.arm_pc += insnsize(uc);
-   if (ismaster) {
-      report_test_status((void *) uc->uc_mcontext.arm_pc);
-   }
+   report_test_status((void *) uc->uc_mcontext.arm_pc);
 }
 
 static void set_r0(void *vuc, uint32_t r0)
-- 
2.11.0
