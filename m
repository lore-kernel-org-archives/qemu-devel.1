Received: from eggs.gnu.org ([2001:4830:134:3::10]:52374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugo-0002Zn-SR
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugn-0005SQ-PE
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:18 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTugn-0005QG-G7
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:17 -0400
Received: by mail-wm0-x241.google.com with SMTP id o13-v6so5155375wmf.4
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:47:17 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:23 +0100
Message-Id: <20180615194705.28019-13-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 12/54] tests/tcg/multiarch: don't hard code
 paths/ports for linux-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The fixed path and ports get in the way of running our tests and
builds in parallel. Instead of using TESTPATH we use mkdtemp() and
instead of a fixed port we allow the kernel to assign one and query it
afterwards.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/linux-test.c | 37 ++++++++++++++++----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index 6f2c531474..3f73b96420 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -41,8 +41,6 @@
 #include <setjmp.h>
 #include <sys/shm.h>
 
-#define TESTPATH "/tmp/linux-test.tmp"
-#define TESTPORT 7654
 #define STACK_SIZE 16384
 
 static void error1(const char *filename, int line, const char *fmt, ...)
@@ -85,19 +83,15 @@ static void test_file(void)
     struct iovec vecs[2];
     DIR *dir;
     struct dirent *de;
+    char template[] = "/tmp/linux-test-XXXXXX";
+    char *tmpdir = mkdtemp(template);
 
-    /* clean up, just in case */
-    unlink(TESTPATH "/file1");
-    unlink(TESTPATH "/file2");
-    unlink(TESTPATH "/file3");
-    rmdir(TESTPATH);
+    chk_error(strlen(tmpdir));
 
     if (getcwd(cur_dir, sizeof(cur_dir)) == NULL)
         error("getcwd");
 
-    chk_error(mkdir(TESTPATH, 0755));
-
-    chk_error(chdir(TESTPATH));
+    chk_error(chdir(tmpdir));
 
     /* open/read/write/close/readv/writev/lseek */
 
@@ -163,7 +157,7 @@ static void test_file(void)
         st.st_mtime != 1000)
         error("stat time");
 
-    chk_error(stat(TESTPATH, &st));
+    chk_error(stat(tmpdir, &st));
     if (!S_ISDIR(st.st_mode))
         error("stat mode");
 
@@ -185,7 +179,7 @@ static void test_file(void)
         error("stat mode");
 
     /* getdents */
-    dir = opendir(TESTPATH);
+    dir = opendir(tmpdir);
     if (!dir)
         error("opendir");
     len = 0;
@@ -207,7 +201,7 @@ static void test_file(void)
     chk_error(unlink("file3"));
     chk_error(unlink("file2"));
     chk_error(chdir(cur_dir));
-    chk_error(rmdir(TESTPATH));
+    chk_error(rmdir(tmpdir));
 }
 
 static void test_fork(void)
@@ -264,7 +258,7 @@ static int server_socket(void)
     chk_error(setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val)));
 
     sockaddr.sin_family = AF_INET;
-    sockaddr.sin_port = htons(TESTPORT);
+    sockaddr.sin_port = htons(0); /* choose random ephemeral port) */
     sockaddr.sin_addr.s_addr = 0;
     chk_error(bind(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)));
     chk_error(listen(fd, 0));
@@ -272,7 +266,7 @@ static int server_socket(void)
 
 }
 
-static int client_socket(void)
+static int client_socket(uint16_t port)
 {
     int fd;
     struct sockaddr_in sockaddr;
@@ -280,7 +274,7 @@ static int client_socket(void)
     /* server socket */
     fd = chk_error(socket(PF_INET, SOCK_STREAM, 0));
     sockaddr.sin_family = AF_INET;
-    sockaddr.sin_port = htons(TESTPORT);
+    sockaddr.sin_port = htons(port);
     inet_aton("127.0.0.1", &sockaddr.sin_addr);
     chk_error(connect(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)));
     return fd;
@@ -292,10 +286,17 @@ static void test_socket(void)
 {
     int server_fd, client_fd, fd, pid, ret, val;
     struct sockaddr_in sockaddr;
-    socklen_t len;
+    struct sockaddr_in server_addr;
+    socklen_t len, socklen;
+    uint16_t server_port;
     char buf[512];
 
     server_fd = server_socket();
+    /* find out what port we got */
+    socklen = sizeof(server_addr);
+    ret = getsockname(server_fd, &server_addr, &socklen);
+    chk_error(ret);
+    server_port = ntohs(server_addr.sin_port);
 
     /* test a few socket options */
     len = sizeof(val);
@@ -305,7 +306,7 @@ static void test_socket(void)
 
     pid = chk_error(fork());
     if (pid == 0) {
-        client_fd = client_socket();
+        client_fd = client_socket(server_port);
         send(client_fd, socket_msg, sizeof(socket_msg), 0);
         close(client_fd);
         exit(0);
-- 
2.17.1
