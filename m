Received: from eggs.gnu.org ([2001:4830:134:3::10]:40284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fL2go-0007R0-EM
	for qemu-devel@nongnu.org; Tue, 22 May 2018 04:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fL2gk-0003BU-BK
	for qemu-devel@nongnu.org; Tue, 22 May 2018 04:30:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42418 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fL2gk-0003BF-74
	for qemu-devel@nongnu.org; Tue, 22 May 2018 04:30:34 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 22 May 2018 10:30:31 +0200
Message-Id: <1526977831-31129-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/boot-serial: Do not delete the output
 file in case of errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Peter reported that the boot-serial tester sometimes runs into timeouts
with SPARC guests. It's currently completely unclear whether this is due
to too much load on the host machine (so that the guest really just ran
too slow), or whether there is something wrong with the guest's firmware
boot. For further debugging, we need the serial output of the guest in
case of errors, so instead of unlinking the file immediately, this is
now only done in case of success. In case of error, print the name of the
file with the serial output via g_error() (which then also calls abort()
internally to mark the test as failed).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/boot-serial-test.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 4d6815c..952a2e7 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -111,9 +111,8 @@ static testdef_t tests[] = {
     { NULL }
 };
 
-static void check_guest_output(const testdef_t *test, int fd)
+static bool check_guest_output(const testdef_t *test, int fd)
 {
-    bool output_ok = false;
     int i, nbr = 0, pos = 0, ccnt;
     char ch;
 
@@ -125,8 +124,7 @@ static void check_guest_output(const testdef_t *test, int fd)
                 pos += 1;
                 if (test->expect[pos] == '\0') {
                     /* We've reached the end of the expected string! */
-                    output_ok = true;
-                    goto done;
+                    return true;
                 }
             } else {
                 pos = 0;
@@ -136,8 +134,7 @@ static void check_guest_output(const testdef_t *test, int fd)
         g_usleep(10000);
     }
 
-done:
-    g_assert(output_ok);
+    return false;
 }
 
 static void test_machine(const void *data)
@@ -180,12 +177,16 @@ static void test_machine(const void *data)
                                 "-no-shutdown -serial chardev:serial0 %s",
                                 codeparam, code ? codetmp : "",
                                 test->machine, serialtmp, test->extra);
-    unlink(serialtmp);
     if (code) {
         unlink(codetmp);
     }
 
-    check_guest_output(test, ser_fd);
+    if (!check_guest_output(test, ser_fd)) {
+        g_error("Failed to find expected string. Please check '%s'",
+                serialtmp);
+    }
+    unlink(serialtmp);
+
     qtest_quit(global_qtest);
 
     close(ser_fd);
-- 
1.8.3.1
