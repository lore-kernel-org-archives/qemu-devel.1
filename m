Received: from eggs.gnu.org ([2001:4830:134:3::10]:52632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFPw-0006Co-JR
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFPr-0000ix-76
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqFPq-0000hp-UW
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:35 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:16:58 +0800
Message-Id: <20170908091700.14867-6-famz@redhat.com>
In-Reply-To: <20170908091700.14867-1-famz@redhat.com>
References: <20170908091700.14867-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 5/7] tests: Build fix for linux-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, programmingkidx@gmail.com, crosa@redhat.com, pbonzini@redhat.com, rth@twiddle.net

To keep the compiler happy, and to fit in our buildsys flags:

- Include "qemu/osdep.h" first
- Make local functions "static"
- #ifdef out unused functions

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/tcg/linux-test.c | 67 +++++++++++++++++---------------------------------
 1 file changed, 22 insertions(+), 45 deletions(-)

diff --git a/tests/tcg/linux-test.c b/tests/tcg/linux-test.c
index 5070d31446..2a7b8c2d05 100644
--- a/tests/tcg/linux-test.c
+++ b/tests/tcg/linux-test.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #define _GNU_SOURCE
+#include "qemu/osdep.h"
 #include <stdarg.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -31,6 +32,7 @@
 #include <utime.h>
 #include <time.h>
 #include <sys/time.h>
+#include <sys/resource.h>
 #include <sys/uio.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
@@ -45,7 +47,7 @@
 #define TESTPORT 7654
 #define STACK_SIZE 16384
 
-void error1(const char *filename, int line, const char *fmt, ...)
+static void error1(const char *filename, int line, const char *fmt, ...)
 {
     va_list ap;
     va_start(ap, fmt);
@@ -56,7 +58,7 @@ void error1(const char *filename, int line, const char *fmt, ...)
     exit(1);
 }
 
-int __chk_error(const char *filename, int line, int ret)
+static int __chk_error(const char *filename, int line, int ret)
 {
     if (ret < 0) {
         error1(filename, line, "%m (ret=%d, errno=%d)",
@@ -73,7 +75,7 @@ int __chk_error(const char *filename, int line, int ret)
 
 #define FILE_BUF_SIZE 300
 
-void test_file(void)
+static void test_file(void)
 {
     int fd, i, len, ret;
     uint8_t buf[FILE_BUF_SIZE];
@@ -210,7 +212,7 @@ void test_file(void)
     chk_error(rmdir(TESTPATH));
 }
 
-void test_fork(void)
+static void test_fork(void)
 {
     int pid, status;
 
@@ -224,7 +226,7 @@ void test_fork(void)
         error("waitpid status=0x%x", status);
 }
 
-void test_time(void)
+static void test_time(void)
 {
     struct timeval tv, tv2;
     struct timespec ts, rem;
@@ -251,34 +253,7 @@ void test_time(void)
         error("getrusage");
 }
 
-void pstrcpy(char *buf, int buf_size, const char *str)
-{
-    int c;
-    char *q = buf;
-
-    if (buf_size <= 0)
-        return;
-
-    for(;;) {
-        c = *str++;
-        if (c == 0 || q >= buf + buf_size - 1)
-            break;
-        *q++ = c;
-    }
-    *q = '\0';
-}
-
-/* strcat and truncate. */
-char *pstrcat(char *buf, int buf_size, const char *s)
-{
-    int len;
-    len = strlen(buf);
-    if (len < buf_size)
-        pstrcpy(buf + len, buf_size - len, s);
-    return buf;
-}
-
-int server_socket(void)
+static int server_socket(void)
 {
     int val, fd;
     struct sockaddr_in sockaddr;
@@ -298,7 +273,7 @@ int server_socket(void)
 
 }
 
-int client_socket(void)
+static int client_socket(void)
 {
     int fd;
     struct sockaddr_in sockaddr;
@@ -312,9 +287,9 @@ int client_socket(void)
     return fd;
 }
 
-const char socket_msg[] = "hello socket\n";
+static const char socket_msg[] = "hello socket\n";
 
-void test_socket(void)
+static void test_socket(void)
 {
     int server_fd, client_fd, fd, pid, ret, val;
     struct sockaddr_in sockaddr;
@@ -348,9 +323,10 @@ void test_socket(void)
     chk_error(close(server_fd));
 }
 
+#if 0
 #define WCOUNT_MAX 512
 
-void test_pipe(void)
+static void test_pipe(void)
 {
     fd_set rfds, wfds;
     int fds[2], fd_max, ret;
@@ -391,10 +367,10 @@ void test_pipe(void)
     chk_error(close(fds[1]));
 }
 
-int thread1_res;
-int thread2_res;
+static int thread1_res;
+static int thread2_res;
 
-int thread1_func(void *arg)
+static int thread1_func(void *arg)
 {
     int i;
     for(i=0;i<5;i++) {
@@ -404,7 +380,7 @@ int thread1_func(void *arg)
     return 0;
 }
 
-int thread2_func(void *arg)
+static int thread2_func(void *arg)
 {
     int i;
     for(i=0;i<6;i++) {
@@ -435,27 +411,28 @@ void test_clone(void)
         thread2_res != 6)
         error("clone");
 }
+#endif
 
 /***********************************/
 
 volatile int alarm_count;
 jmp_buf jmp_env;
 
-void sig_alarm(int sig)
+static void sig_alarm(int sig)
 {
     if (sig != SIGALRM)
         error("signal");
     alarm_count++;
 }
 
-void sig_segv(int sig, siginfo_t *info, void *puc)
+static void sig_segv(int sig, siginfo_t *info, void *puc)
 {
     if (sig != SIGSEGV)
         error("signal");
     longjmp(jmp_env, 1);
 }
 
-void test_signal(void)
+static void test_signal(void)
 {
     struct sigaction act;
     struct itimerval it, oit;
@@ -510,7 +487,7 @@ void test_signal(void)
 
 #define SHM_SIZE 32768
 
-void test_shm(void)
+static void test_shm(void)
 {
     void *ptr;
     int shmid;
-- 
2.13.5
