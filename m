Received: from eggs.gnu.org ([2001:4830:134:3::10]:42764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9A5m-00065B-0Z
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9A5k-0002Od-SB
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:18 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9A5k-0002MM-LV
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:16 -0400
Received: by mail-wr0-x242.google.com with SMTP id u11-v6so14326933wri.12
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 06:59:16 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:32 +0100
Message-Id: <20180419135901.30035-15-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 14/43] tests/tcg/multiarch: enable
 additional linux-test tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Un-comment the remaining tests. I removed the itimer value tests
because I'm fairly sure a re-arming timer will always have a different
value in it when you grab it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/linux-test.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index 4457bd04ba..519b0ac653 100644
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
@@ -39,6 +40,7 @@
 #include <dirent.h>
 #include <setjmp.h>
 #include <sys/shm.h>
+#include <sched.h>
 
 #define TESTPATH "/tmp/linux-test.tmp"
 #define TESTPORT 7654
@@ -58,8 +60,8 @@ static void error1(const char *filename, int line, const char *fmt, ...)
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
@@ -408,7 +409,6 @@ void test_clone(void)
         thread2_res != 6)
         error("clone");
 }
-#endif
 
 /***********************************/
 
@@ -449,12 +449,10 @@ static void test_signal(void)
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
@@ -463,9 +461,6 @@ static void test_signal(void)
     it.it_value.tv_usec = 0;
     memset(&oit, 0xff, sizeof(oit));
     chk_error(setitimer(ITIMER_REAL, &it, &oit));
-    if (oit.it_value.tv_sec != 0 ||
-        oit.it_value.tv_usec != 10 * 1000)
-        error("setitimer");
 
     /* SIGSEGV test */
     act.sa_sigaction = sig_segv;
@@ -503,10 +498,11 @@ static void test_shm(void)
 int main(int argc, char **argv)
 {
     test_file();
+    test_pipe();
     test_fork();
     test_time();
     test_socket();
-    //    test_clone();
+    test_clone();
     test_signal();
     test_shm();
     return 0;
-- 
2.17.0
