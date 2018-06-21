Received: from eggs.gnu.org ([2001:4830:134:3::10]:53118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt2v-0000y1-MU
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt2u-0000ey-L1
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:26:17 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:50596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVt2u-0000eG-BR
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:26:16 -0400
Received: by mail-wm0-x241.google.com with SMTP id e16-v6so3126899wmd.0
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:26:16 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:21 +0100
Message-Id: <20180621062605.941-14-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 13/57] tests/tcg/multiarch: don't hard code
 paths/ports for linux-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The fixed path and ports get in the way of running our tests and
builds in parallel. Instead of using TESTPATH we use mkdtemp() and
instead of a fixed port we allow the kernel to assign one and query it
afterwards.

Ideally test directory creation should be common functionally across
all TCG tests but this could complicate an already huge patch series
so we mark it as a TODO for next time.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index 6f2c531474..e80eccc0ce 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -40,9 +40,8 @@
 #include <dirent.h>
 #include <setjmp.h>
 #include <sys/shm.h>
+#include <assert.h>
 
-#define TESTPATH "/tmp/linux-test.tmp"
-#define TESTPORT 7654
 #define STACK_SIZE 16384
 
 static void error1(const char *filename, int line, const char *fmt, ...)
@@ -85,19 +84,16 @@ static void test_file(void)
     struct iovec vecs[2];
     DIR *dir;
     struct dirent *de;
+    /* TODO: make common tempdir creation for tcg tests */
+    char template[] = "/tmp/linux-test-XXXXXX";
+    char *tmpdir = mkdtemp(template);
 
-    /* clean up, just in case */
-    unlink(TESTPATH "/file1");
-    unlink(TESTPATH "/file2");
-    unlink(TESTPATH "/file3");
-    rmdir(TESTPATH);
+    assert(tmpdir);
 
     if (getcwd(cur_dir, sizeof(cur_dir)) == NULL)
         error("getcwd");
 
-    chk_error(mkdir(TESTPATH, 0755));
-
-    chk_error(chdir(TESTPATH));
+    chk_error(chdir(tmpdir));
 
     /* open/read/write/close/readv/writev/lseek */
 
@@ -163,7 +159,7 @@ static void test_file(void)
         st.st_mtime != 1000)
         error("stat time");
 
-    chk_error(stat(TESTPATH, &st));
+    chk_error(stat(tmpdir, &st));
     if (!S_ISDIR(st.st_mode))
         error("stat mode");
 
@@ -185,7 +181,7 @@ static void test_file(void)
         error("stat mode");
 
     /* getdents */
-    dir = opendir(TESTPATH);
+    dir = opendir(tmpdir);
     if (!dir)
         error("opendir");
     len = 0;
@@ -207,7 +203,7 @@ static void test_file(void)
     chk_error(unlink("file3"));
     chk_error(unlink("file2"));
     chk_error(chdir(cur_dir));
-    chk_error(rmdir(TESTPATH));
+    chk_error(rmdir(tmpdir));
 }
 
 static void test_fork(void)
@@ -264,7 +260,7 @@ static int server_socket(void)
     chk_error(setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val)));
 
     sockaddr.sin_family = AF_INET;
-    sockaddr.sin_port = htons(TESTPORT);
+    sockaddr.sin_port = htons(0); /* choose random ephemeral port) */
     sockaddr.sin_addr.s_addr = 0;
     chk_error(bind(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)));
     chk_error(listen(fd, 0));
@@ -272,7 +268,7 @@ static int server_socket(void)
 
 }
 
-static int client_socket(void)
+static int client_socket(uint16_t port)
 {
     int fd;
     struct sockaddr_in sockaddr;
@@ -280,7 +276,7 @@ static int client_socket(void)
     /* server socket */
     fd = chk_error(socket(PF_INET, SOCK_STREAM, 0));
     sockaddr.sin_family = AF_INET;
-    sockaddr.sin_port = htons(TESTPORT);
+    sockaddr.sin_port = htons(port);
     inet_aton("127.0.0.1", &sockaddr.sin_addr);
     chk_error(connect(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)));
     return fd;
@@ -292,10 +288,17 @@ static void test_socket(void)
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
@@ -305,7 +308,7 @@ static void test_socket(void)
 
     pid = chk_error(fork());
     if (pid == 0) {
-        client_fd = client_socket();
+        client_fd = client_socket(server_port);
         send(client_fd, socket_msg, sizeof(socket_msg), 0);
         close(client_fd);
         exit(0);
-- 
2.17.1
