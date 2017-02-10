Received: from eggs.gnu.org ([2001:4830:134:3::10]:55766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ccCuh-0005XE-Oa
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:15:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ccCud-0005RW-LB
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:15:07 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 10 Feb 2017 16:14:59 +0100
Message-Id: <1486739699-1076-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] tests/prom-env: Ease time-out problems on
 slow hosts
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
we can speed up the test by running QEMU with "-nodefaults" for
the pseries machine, so that SLOF has less devices to scan during
boot, and by using the "nvramrc" environment variable instead of
"boot-command", since this variable is evaluated earlier in the
boot process.
And to be really sure that we do not face such time out problems
again, let's also increase the time out value from 100s to 120s
instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use "-nodefaults" only for the pseries machine, since the
     sparc machines have a built-in ethernet controller and spill
     out a warning otherwise.

 tests/prom-env-test.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/prom-env-test.c b/tests/prom-env-test.c
index 0ba6f48..bd33bc3 100644
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
@@ -45,9 +45,14 @@ static void check_guest_memory(void)
 static void test_machine(const void *machine)
 {
     char *args;
+    const char *extra_args;
 
-    args = g_strdup_printf("-M %s,accel=tcg -prom-env 'boot-command=%x %x l!'",
-                           (const char *)machine, MAGIC, ADDRESS);
+    /* The pseries firmware boots much faster without the default devices */
+    extra_args = strcmp(machine, "pseries") == 0 ? "-nodefaults" : "";
+
+    args = g_strdup_printf("-M %s,accel=tcg %s -prom-env 'use-nvramrc?=true' "
+                           "-prom-env 'nvramrc=%x %x l!' ",
+                           (const char *)machine, extra_args, MAGIC, ADDRESS);
 
     qtest_start(args);
     check_guest_memory();
-- 
1.8.3.1
