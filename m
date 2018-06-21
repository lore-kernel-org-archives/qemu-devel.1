Received: from eggs.gnu.org ([2001:4830:134:3::10]:56720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtI5-0004t0-9l
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtI3-0003JN-U9
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:41:57 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:40586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVtI3-0003Ia-Jr
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:41:55 -0400
Received: by mail-wm0-x231.google.com with SMTP id n5-v6so3642843wmc.5
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:41:55 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:19 +0100
Message-Id: <20180621062605.941-12-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 11/57] tests/tcg/multiarch: Build fix for
 linux-test
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

From: Fam Zheng <famz@redhat.com>

To keep the compiler happy, and to fit in our buildsys flags:

- Make local functions "static"
- #ifdef out unused functions
- drop cutils/osdep dependencies

Signed-off-by: Fam Zheng <famz@redhat.com>
[AJB: drop cutils/osdep dependencies]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index 5070d31446..4457bd04ba 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -16,7 +16,6 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
-#define _GNU_SOURCE
 #include <stdarg.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -31,6 +30,7 @@
 #include <utime.h>
 #include <time.h>
 #include <sys/time.h>
+#include <sys/resource.h>
 #include <sys/uio.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
@@ -39,13 +39,12 @@
 #include <dirent.h>
 #include <setjmp.h>
 #include <sys/shm.h>
-#include "qemu/cutils.h"
 
 #define TESTPATH "/tmp/linux-test.tmp"
 #define TESTPORT 7654
 #define STACK_SIZE 16384
 
-void error1(const char *filename, int line, const char *fmt, ...)
+static void error1(const char *filename, int line, const char *fmt, ...)
 {
     va_list ap;
     va_start(ap, fmt);
@@ -56,7 +55,7 @@ void error1(const char *filename, int line, const char *fmt, ...)
     exit(1);
 }
 
-int __chk_error(const char *filename, int line, int ret)
+static int __chk_error(const char *filename, int line, int ret)
 {
     if (ret < 0) {
         error1(filename, line, "%m (ret=%d, errno=%d)",
@@ -73,7 +72,7 @@ int __chk_error(const char *filename, int line, int ret)
 
 #define FILE_BUF_SIZE 300
 
-void test_file(void)
+static void test_file(void)
 {
     int fd, i, len, ret;
     uint8_t buf[FILE_BUF_SIZE];
@@ -210,7 +209,7 @@ void test_file(void)
     chk_error(rmdir(TESTPATH));
 }
 
-void test_fork(void)
+static void test_fork(void)
 {
     int pid, status;
 
@@ -224,7 +223,7 @@ void test_fork(void)
         error("waitpid status=0x%x", status);
 }
 
-void test_time(void)
+static void test_time(void)
 {
     struct timeval tv, tv2;
     struct timespec ts, rem;
@@ -251,34 +250,7 @@ void test_time(void)
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
@@ -298,7 +270,7 @@ int server_socket(void)
 
 }
 
-int client_socket(void)
+static int client_socket(void)
 {
     int fd;
     struct sockaddr_in sockaddr;
@@ -312,9 +284,9 @@ int client_socket(void)
     return fd;
 }
 
-const char socket_msg[] = "hello socket\n";
+static const char socket_msg[] = "hello socket\n";
 
-void test_socket(void)
+static void test_socket(void)
 {
     int server_fd, client_fd, fd, pid, ret, val;
     struct sockaddr_in sockaddr;
@@ -348,9 +320,10 @@ void test_socket(void)
     chk_error(close(server_fd));
 }
 
+#if 0
 #define WCOUNT_MAX 512
 
-void test_pipe(void)
+static void test_pipe(void)
 {
     fd_set rfds, wfds;
     int fds[2], fd_max, ret;
@@ -391,10 +364,10 @@ void test_pipe(void)
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
@@ -404,7 +377,7 @@ int thread1_func(void *arg)
     return 0;
 }
 
-int thread2_func(void *arg)
+static int thread2_func(void *arg)
 {
     int i;
     for(i=0;i<6;i++) {
@@ -435,27 +408,28 @@ void test_clone(void)
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
@@ -510,7 +484,7 @@ void test_signal(void)
 
 #define SHM_SIZE 32768
 
-void test_shm(void)
+static void test_shm(void)
 {
     void *ptr;
     int shmid;
-- 
2.17.1
