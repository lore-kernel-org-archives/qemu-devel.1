Received: from eggs.gnu.org ([2001:4830:134:3::10]:54618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duuCr-0000K0-Lf
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 01:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duuCo-00048m-JE
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 01:39:25 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 21 Sep 2017 07:39:15 +0200
Message-Id: <1505972355-23903-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/prom-env: Bump the timeout,
 and test pseries only in slow mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Stefan Weil <sw@weilnetz.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

If QEMU has been compiled with the flags --enable-tcg-interpreter and
--enable-debug, the guest is running incredibly slow. The prom-env
test is approximately 10 times slower than normal in this case, and
it takes up to 500 seconds until the test with the pseries machine
finishs. While we should still look for ways to speed up the test
on the pseries machine here, let's bump the timeout to 600 seconds to
allow the test to pass with this unusal configuration already now.
Also move the pseries test into the "slow" category - since it is
really a very slow test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/prom-env-test.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/prom-env-test.c b/tests/prom-env-test.c
index eac207b..bc8b616 100644
--- a/tests/prom-env-test.c
+++ b/tests/prom-env-test.c
@@ -1,7 +1,7 @@
 /*
- * Test OpenBIOS-based machines.
+ * Test Open-Firmware-based machines.
  *
- * Copyright (c) 2016 Red Hat Inc.
+ * Copyright (c) 2016, 2017 Red Hat Inc.
  *
  * Author:
  *    Thomas Huth <thuth@redhat.com>
@@ -30,8 +30,8 @@ static void check_guest_memory(void)
     uint32_t signature;
     int i;
 
-    /* Poll until code has run and modified memory. Wait at most 120 seconds */
-    for (i = 0; i < 12000; ++i) {
+    /* Poll until code has run and modified memory. Wait at most 600 seconds */
+    for (i = 0; i < 60000; ++i) {
         signature = readl(ADDRESS);
         if (signature == MAGIC) {
             break;
@@ -78,7 +78,6 @@ int main(int argc, char *argv[])
     const char *sparc_machines[] = { "SPARCbook", "Voyager", "SS-20", NULL };
     const char *sparc64_machines[] = { "sun4u", NULL };
     const char *ppc_machines[] = { "mac99", "g3beige", NULL };
-    const char *ppc64_machines[] = { "mac99", "g3beige", "pseries", NULL };
     const char *arch = qtest_get_arch();
 
     g_test_init(&argc, &argv, NULL);
@@ -86,7 +85,10 @@ int main(int argc, char *argv[])
     if (!strcmp(arch, "ppc")) {
         add_tests(ppc_machines);
     } else if (!strcmp(arch, "ppc64")) {
-        add_tests(ppc64_machines);
+        add_tests(ppc_machines);
+        if (g_test_slow()) {
+            qtest_add_data_func("prom-env/pseries", "pseries", test_machine);
+        }
     } else if (!strcmp(arch, "sparc")) {
         add_tests(sparc_machines);
     } else if (!strcmp(arch, "sparc64")) {
-- 
1.8.3.1
