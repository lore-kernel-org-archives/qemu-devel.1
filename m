Received: from eggs.gnu.org ([2001:4830:134:3::10]:52370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugo-0002ZQ-GH
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugn-0005Qm-5C
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:18 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:37619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTugm-0005OT-RS
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:17 -0400
Received: by mail-wr0-x22c.google.com with SMTP id d8-v6so10979112wro.4
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:47:16 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:22 +0100
Message-Id: <20180615194705.28019-12-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 11/54] tests/tcg/multiarch: enable
 additional linux-test tests
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

Un-comment the remaining tests.

I removed the itimer value tests because I'm fairly sure a re-arming
timer will always have a different value in it when you grab it.

I've also fixed up the clone thread flags as QEMU will only allow a
clone to use flags which match glibc. However the test is still racey
so it remains disabled by default - it can be run by passing any
additional parameters on the command line.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v3
  - make clone flags match CLONE_THREAD_FLAGS
v4
  - disable test_clone for default case
---
 tests/tcg/multiarch/linux-test.c | 51 +++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index 4457bd04ba..6f2c531474 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -16,6 +16,7 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+#define _GNU_SOURCE
 #include <stdarg.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -58,8 +59,8 @@ static void error1(const char *filename, int line, const char *fmt, ...)
 static int __chk_error(const char *filename, int line, int ret)
 {
     if (ret < 0) {
-        error1(filename, line, "%m (ret=%d, errno=%d)",
-               ret, errno);
+        error1(filename, line, "%m (ret=%d, errno=%d/%s)",
+               ret, errno, strerror(errno));
     }
     return ret;
 }
@@ -216,6 +217,7 @@ static void test_fork(void)
     pid = chk_error(fork());
     if (pid == 0) {
         /* child */
+        sleep(2);
         exit(2);
     }
     chk_error(waitpid(pid, &status, 0));
@@ -320,7 +322,6 @@ static void test_socket(void)
     chk_error(close(server_fd));
 }
 
-#if 0
 #define WCOUNT_MAX 512
 
 static void test_pipe(void)
@@ -355,7 +356,7 @@ static void test_pipe(void)
             }
             if (FD_ISSET(fds[1], &wfds)) {
                 ch = 'a';
-                chk_error(write(fds[0], &ch, 1));
+                chk_error(write(fds[1], &ch, 1));
                 wcount++;
             }
         }
@@ -387,28 +388,41 @@ static int thread2_func(void *arg)
     return 0;
 }
 
-void test_clone(void)
+static void wait_for_child(pid_t pid)
+{
+    int status;
+    chk_error(waitpid(pid, &status, 0));
+}
+
+/* For test_clone we must match the clone flags used by glibc, see
+ * CLONE_THREAD_FLAGS in the QEMU source code.
+ */
+static void test_clone(void)
 {
     uint8_t *stack1, *stack2;
-    int pid1, pid2, status1, status2;
+    pid_t pid1, pid2;
 
     stack1 = malloc(STACK_SIZE);
     pid1 = chk_error(clone(thread1_func, stack1 + STACK_SIZE,
-                           CLONE_VM | CLONE_FS | CLONE_FILES | SIGCHLD, "hello1"));
+                           CLONE_VM | CLONE_FS | CLONE_FILES |
+                           CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM,
+                            "hello1"));
 
     stack2 = malloc(STACK_SIZE);
     pid2 = chk_error(clone(thread2_func, stack2 + STACK_SIZE,
-                           CLONE_VM | CLONE_FS | CLONE_FILES | SIGCHLD, "hello2"));
+                           CLONE_VM | CLONE_FS | CLONE_FILES |
+                           CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM,
+                           "hello2"));
 
-    while (waitpid(pid1, &status1, 0) != pid1);
+    wait_for_child(pid1);
     free(stack1);
-    while (waitpid(pid2, &status2, 0) != pid2);
+    wait_for_child(pid2);
     free(stack2);
+
     if (thread1_res != 5 ||
         thread2_res != 6)
         error("clone");
 }
-#endif
 
 /***********************************/
 
@@ -449,12 +463,10 @@ static void test_signal(void)
     it.it_value.tv_usec = 10 * 1000;
     chk_error(setitimer(ITIMER_REAL, &it, NULL));
     chk_error(getitimer(ITIMER_REAL, &oit));
-    if (oit.it_value.tv_sec != it.it_value.tv_sec ||
-        oit.it_value.tv_usec != it.it_value.tv_usec)
-        error("itimer");
 
     while (alarm_count < 5) {
         usleep(10 * 1000);
+        getitimer(ITIMER_REAL, &oit);
     }
 
     it.it_interval.tv_sec = 0;
@@ -463,9 +475,6 @@ static void test_signal(void)
     it.it_value.tv_usec = 0;
     memset(&oit, 0xff, sizeof(oit));
     chk_error(setitimer(ITIMER_REAL, &it, &oit));
-    if (oit.it_value.tv_sec != 0 ||
-        oit.it_value.tv_usec != 10 * 1000)
-        error("setitimer");
 
     /* SIGSEGV test */
     act.sa_sigaction = sig_segv;
@@ -503,10 +512,16 @@ static void test_shm(void)
 int main(int argc, char **argv)
 {
     test_file();
+    test_pipe();
     test_fork();
     test_time();
     test_socket();
-    //    test_clone();
+
+    if (argc > 1) {
+        printf("test_clone still considered buggy\n");
+        test_clone();
+    }
+
     test_signal();
     test_shm();
     return 0;
-- 
2.17.1
