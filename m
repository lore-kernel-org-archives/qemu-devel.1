Received: from eggs.gnu.org ([2001:4830:134:3::10]:55181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cbpTa-00026H-Mv
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:13:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cbpTW-0000yR-Lr
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:13:34 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  9 Feb 2017 15:13:27 +0100
Message-Id: <1486649607-31248-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/prom-env: Ease time-out problems on slow
 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Peter Maydell recently ran into time-out problems with the
prom-env test on a rather slow ARM board. To tackle this issue,
we can speed up the test by running QEMU with "-nodefaults" here,
so that SLOF has less devices to scan during boot, and by using
the "nvramrc" environment variable instead of "boot-command",
since this variable is evaluated earlier in the boot process.
And to be really sure that we do not face such time out problems
again, let's also increase the time out value from 100s to 120s
instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/prom-env-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/prom-env-test.c b/tests/prom-env-test.c
index 0ba6f48..7d97ae4 100644
--- a/tests/prom-env-test.c
+++ b/tests/prom-env-test.c
@@ -30,8 +30,8 @@ static void check_guest_memory(void)
     uint32_t signature;
     int i;
 
-    /* Poll until code has run and modified memory. Wait at most 30 seconds */
-    for (i = 0; i < 10000; ++i) {
+    /* Poll until code has run and modified memory. Wait at most 120 seconds */
+    for (i = 0; i < 12000; ++i) {
         signature = readl(ADDRESS);
         if (signature == MAGIC) {
             break;
@@ -46,7 +46,9 @@ static void test_machine(const void *machine)
 {
     char *args;
 
-    args = g_strdup_printf("-M %s,accel=tcg -prom-env 'boot-command=%x %x l!'",
+    args = g_strdup_printf("-M %s,accel=tcg -nodefaults "
+                           "-prom-env 'use-nvramrc?=true' "
+                           "-prom-env 'nvramrc=%x %x l!'",
                            (const char *)machine, MAGIC, ADDRESS);
 
     qtest_start(args);
-- 
1.8.3.1
