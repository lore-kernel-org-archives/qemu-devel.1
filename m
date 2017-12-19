Received: from eggs.gnu.org ([2001:4830:134:3::10]:43860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR9mY-0006Jw-Tk
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:45:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR9mU-0000eG-P1
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:45:34 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Dec 2017 15:45:21 +1100
Message-Id: <20171219044522.10850-4-david@gibson.dropbear.id.au>
In-Reply-To: <20171219044522.10850-1-david@gibson.dropbear.id.au>
References: <20171219044522.10850-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv3 3/4] tests/pxe-test: Test net booting over
 IPv6 in some cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: thuth@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This adds IPv6 net boot testing (in addition to IPv4) when in slow test
mode on ppc64 or s390.  IPv6 PXE doesn't seem to work on x86, I'm guessing
our BIOS image doesn't support it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/pxe-test.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index 4758ce7d20..5689c7d7ee 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -81,7 +81,14 @@ static void test_pxe_ipv4(gconstpointer data)
     test_pxe_one(test, false);
 }
 
-static void test_batch(const testdef_t *tests)
+static void test_pxe_ipv6(gconstpointer data)
+{
+    const testdef_t *test = data;
+
+    test_pxe_one(test, true);
+}
+
+static void test_batch(const testdef_t *tests, bool ipv6)
 {
     int i;
 
@@ -93,6 +100,13 @@ static void test_batch(const testdef_t *tests)
                                    test->machine, test->model);
         qtest_add_data_func(testname, test, test_pxe_ipv4);
         g_free(testname);
+
+        if (ipv6) {
+            testname = g_strdup_printf("pxe/ipv6/%s/%s",
+                                       test->machine, test->model);
+            qtest_add_data_func(testname, test, test_pxe_ipv6);
+            g_free(testname);
+        }
     }
 }
 
@@ -108,17 +122,17 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        test_batch(x86_tests);
+        test_batch(x86_tests, false);
         if (g_test_slow()) {
-            test_batch(x86_tests_slow);
+            test_batch(x86_tests_slow, false);
         }
     } else if (strcmp(arch, "ppc64") == 0) {
-        test_batch(ppc64_tests);
+        test_batch(ppc64_tests, g_test_slow());
         if (g_test_slow()) {
-            test_batch(ppc64_tests_slow);
+            test_batch(ppc64_tests_slow, true);
         }
     } else if (g_str_equal(arch, "s390x")) {
-        test_batch(s390x_tests);
+        test_batch(s390x_tests, g_test_slow());
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
2.14.3
