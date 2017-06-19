Received: from eggs.gnu.org ([2001:4830:134:3::10]:40768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCW-0007Pb-RB
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCV-0004wS-I6
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:32 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dMuCV-0004vk-9F
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:31 -0400
Received: by mail-wm0-x236.google.com with SMTP id x70so75453819wme.0
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 03:46:31 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 19 Jun 2017 11:46:51 +0100
Message-Id: <20170619104655.31104-10-alex.bennee@linaro.org>
In-Reply-To: <20170619104655.31104-1-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v5 09/13] risu: add simple trace and
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This adds a very dumb and easily breakable trace and replay support. In
--master mode the various risu ops trigger a write of register/memory
state into a binary file which can be played back to an apprentice.
Currently there is no validation of the image source so feeding the
wrong image will fail straight away.

The trace files will get very big for any appreciable sized test file
and this will be addressed in later patches.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v5
  - re-base without formatting fixes
  - unify socket/file descriptors
  - count number of signals/checkpoint
  - all output from sigjmp (not in signhandlers)
v4
  - fix formatting mess
  - abort() instead of reporting de-sync
  - don't fake return for compiler
v3
  - fix options parsing
  - re-factored so no need for copy & paste
v2
  - moved read/write functions into main risu.c
  - cleaned up formatting
  - report more in apprentice --trace mode
---
 risu.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 93 insertions(+), 19 deletions(-)

diff --git a/risu.c b/risu.c
index 88e586c..93c274b 100644
--- a/risu.c
+++ b/risu.c
@@ -30,7 +30,9 @@
 
 void *memblock;
 
-int apprentice_socket, master_socket;
+int apprentice_fd, master_fd;
+int trace;
+size_t signal_count;
 
 sigjmp_buf jmpbuf;
 
@@ -41,24 +43,60 @@ int test_fp_exc;
 
 int read_sock(void *ptr, size_t bytes)
 {
-    return recv_data_pkt(master_socket, ptr, bytes);
+    return recv_data_pkt(master_fd, ptr, bytes);
+}
+
+int write_trace(void *ptr, size_t bytes)
+{
+    size_t res = write(master_fd, ptr, bytes);
+    return (res == bytes) ? 0 : 1;
 }
 
 void respond_sock(int r)
 {
-    send_response_byte(master_socket, r);
+    send_response_byte(master_fd, r);
 }
 
 /* Apprentice function */
 
 int write_sock(void *ptr, size_t bytes)
 {
-    return send_data_pkt(apprentice_socket, ptr, bytes);
+    return send_data_pkt(apprentice_fd, ptr, bytes);
+}
+
+int read_trace(void *ptr, size_t bytes)
+{
+    size_t res = read(apprentice_fd, ptr, bytes);
+    return (res == bytes) ? 0 : 1;
+}
+
+void respond_trace(int r)
+{
+    switch (r) {
+    case 0: /* test ok */
+    case 1: /* end of test */
+        break;
+    default:
+        /* mismatch - if tracing we need to report, otherwise barf */
+        if (!trace) {
+           abort();
+        }
+        break;
+    }
 }
 
 void master_sigill(int sig, siginfo_t *si, void *uc)
 {
-    switch (recv_and_compare_register_info(read_sock, respond_sock, uc)) {
+    int r;
+    signal_count++;
+
+    if (trace) {
+        r = send_register_info(write_trace, uc);
+    } else {
+        r = recv_and_compare_register_info(read_sock, respond_sock, uc);
+    }
+
+    switch (r) {
     case 0:
         /* match OK */
         advance_pc(uc);
@@ -71,7 +109,16 @@ void master_sigill(int sig, siginfo_t *si, void *uc)
 
 void apprentice_sigill(int sig, siginfo_t *si, void *uc)
 {
-    switch (send_register_info(write_sock, uc)) {
+    int r;
+    signal_count++;
+
+    if (trace) {
+        r = recv_and_compare_register_info(read_trace, respond_trace, uc);
+    } else {
+        r = send_register_info(write_sock, uc);
+    }
+
+    switch (r) {
     case 0:
         /* match OK */
         advance_pc(uc);
@@ -81,6 +128,9 @@ void apprentice_sigill(int sig, siginfo_t *si, void *uc)
         exit(0);
     default:
         /* mismatch */
+        if (trace) {
+            siglongjmp(jmpbuf, 1);
+        }
         exit(1);
     }
 }
@@ -136,12 +186,17 @@ void load_image(const char *imgfile)
     image_start_address = (uintptr_t) addr;
 }
 
-int master(int sock)
+int master(void)
 {
     if (sigsetjmp(jmpbuf, 1)) {
-        return report_match_status();
+        close(master_fd);
+        if (trace) {
+            fprintf(stderr, "trace complete after %zd checkpoints\n", signal_count);
+            return 0;
+        } else {
+            return report_match_status();
+        }
     }
-    master_socket = sock;
     set_sigill_handler(&master_sigill);
     fprintf(stderr, "starting master image at 0x%"PRIxPTR"\n",
             image_start_address);
@@ -151,9 +206,13 @@ int master(int sock)
     exit(1);
 }
 
-int apprentice(int sock)
+int apprentice(void)
 {
-    apprentice_socket = sock;
+    if (sigsetjmp(jmpbuf, 1)) {
+        close(apprentice_fd);
+        fprintf(stderr, "finished early after %zd checkpoints\n", signal_count);
+        return report_match_status();
+    }
     set_sigill_handler(&apprentice_sigill);
     fprintf(stderr, "starting apprentice image at 0x%"PRIxPTR"\n",
             image_start_address);
@@ -175,6 +234,7 @@ void usage(void)
     fprintf(stderr, "between master and apprentice risu processes.\n\n");
     fprintf(stderr, "Options:\n");
     fprintf(stderr, "  --master          Be the master (server)\n");
+    fprintf(stderr, "  -t, --trace=FILE  Record/playback trace file\n");
     fprintf(stderr,
             "  -h, --host=HOST   Specify master host machine (apprentice only)"
             "\n");
@@ -189,7 +249,7 @@ int main(int argc, char **argv)
     uint16_t port = 9191;
     char *hostname = "localhost";
     char *imgfile;
-    int sock;
+    char *trace_fn = NULL;
 
     /* TODO clean this up later */
 
@@ -203,7 +263,7 @@ int main(int argc, char **argv)
             {0, 0, 0, 0}
         };
         int optidx = 0;
-        int c = getopt_long(argc, argv, "h:p:", longopts, &optidx);
+        int c = getopt_long(argc, argv, "h:p:t:", longopts, &optidx);
         if (c == -1) {
             break;
         }
@@ -214,6 +274,12 @@ int main(int argc, char **argv)
             /* flag set by getopt_long, do nothing */
             break;
         }
+        case 't':
+        {
+            trace_fn = optarg;
+            trace = 1;
+            break;
+        }
         case 'h':
         {
             hostname = optarg;
@@ -245,12 +311,20 @@ int main(int argc, char **argv)
     load_image(imgfile);
 
     if (ismaster) {
-        fprintf(stderr, "master port %d\n", port);
-        sock = master_connect(port);
-        return master(sock);
+        if (trace) {
+            master_fd = open(trace_fn, O_WRONLY|O_CREAT, S_IRWXU);
+        } else {
+            fprintf(stderr, "master port %d\n", port);
+            master_fd = master_connect(port);
+        }
+        return master();
     } else {
-        fprintf(stderr, "apprentice host %s port %d\n", hostname, port);
-        sock = apprentice_connect(hostname, port);
-        return apprentice(sock);
+        if (trace) {
+            apprentice_fd = open(trace_fn, O_RDONLY);
+        } else {
+            fprintf(stderr, "apprentice host %s port %d\n", hostname, port);
+            apprentice_fd = apprentice_connect(hostname, port);
+        }
+        return apprentice();
     }
 }
-- 
2.13.0
