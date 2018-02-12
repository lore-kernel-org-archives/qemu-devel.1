Received: from eggs.gnu.org ([2001:4830:134:3::10]:52588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elDTd-00005D-Ql
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elDTa-0003OR-Cm
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:44:57 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 12 Feb 2018 13:44:46 +0100
Message-Id: <1518439489-2724-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1518439489-2724-1-git-send-email-thuth@redhat.com>
References: <1518439489-2724-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] tests/m48t59: Fix and re-enable the test
 for sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org

The m48t59 test has been disabled in commit baeddded5fe6fa37d13fb94bf8d
("sparc: disable qtest in make check"), likely due to some timing issues
in the bcd_check_time tests which might fail if it gets interrupted for
too long. It should be OK to re-enable this test if we make sure that we
do not run it on timing-sensitive machines, thus it should be OK if we only
run it in the g_test_slow() mode.

Additionally, there are two other issues:

First, the test can not run so easily on sparc64 anymore, since commit
f3b18f35a23c60edbda6420cd ("sun4u: switch m48t59 NVRAM to MMIO access")
moved the m48t59 device to the ebus instead, and for this you first
have to set up the corresponding PCI device (which is currently not
possible from within the m48t59 test). So we can only re-enable this
test on sparc, but not the sparc64 target.

Second, the fuzzing test is executed before the bcd-check-time test
(due to the naming of the tests), without having the base address set
up properly, so the fuzzing test does not really check anything at all.
Fix it by setting up the base address from the main function already
and by moving the qtest_start() to the tests themselves, so that each
test starts with a clean environment (since after the fuzzing, the clock
is unusable for the bcd-check-time test).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include |  6 ++----
 tests/m48t59-test.c    | 58 ++++++++++++++++++++++++++++----------------------
 2 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5d430e5..78bd163 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -350,13 +350,11 @@ check-qtest-sh4-y = tests/endianness-test$(EXESUF)
 check-qtest-sh4eb-y = tests/endianness-test$(EXESUF)
 
 check-qtest-sparc-y = tests/prom-env-test$(EXESUF)
-#check-qtest-sparc-y += tests/m48t59-test$(EXESUF)
-#gcov-files-sparc-y = hw/timer/m48t59.c
+check-qtest-sparc-y += tests/m48t59-test$(EXESUF)
+gcov-files-sparc-y = hw/timer/m48t59.c
 check-qtest-sparc-y += tests/boot-serial-test$(EXESUF)
 
 check-qtest-sparc64-y = tests/endianness-test$(EXESUF)
-#check-qtest-sparc64-y += tests/m48t59-test$(EXESUF)
-#gcov-files-sparc64-y += hw/timer/m48t59.c
 check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
 check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
 
diff --git a/tests/m48t59-test.c b/tests/m48t59-test.c
index 0f921ef..a85f84d 100644
--- a/tests/m48t59-test.c
+++ b/tests/m48t59-test.c
@@ -143,11 +143,18 @@ static void cmos_get_date_time(struct tm *date)
     ts = mktime(date);
 }
 
-static void check_time(int wiggle)
+static QTestState *m48t59_qtest_start(void)
+{
+    return qtest_start("-rtc clock=vm");
+}
+
+static void bcd_check_time(void)
 {
     struct tm start, date[4], end;
     struct tm *datep;
     time_t ts;
+    const int wiggle = 2;
+    QTestState *s = m48t59_qtest_start();
 
     /*
      * This check assumes a few things.  First, we cannot guarantee that we get
@@ -198,30 +205,15 @@ static void check_time(int wiggle)
 
         g_assert_cmpint(ABS(t - s), <=, wiggle);
     }
-}
-
-static int wiggle = 2;
 
-static void bcd_check_time(void)
-{
-    if (strcmp(qtest_get_arch(), "sparc64") == 0) {
-        base = 0x74;
-        base_year = 1900;
-        use_mmio = false;
-    } else if (strcmp(qtest_get_arch(), "sparc") == 0) {
-        base = 0x71200000;
-        base_year = 1968;
-        use_mmio = true;
-    } else { /* PPC: need to map macio in PCI */
-        g_assert_not_reached();
-    }
-    check_time(wiggle);
+    qtest_quit(s);
 }
 
 /* success if no crash or abort */
 static void fuzz_registers(void)
 {
     unsigned int i;
+    QTestState *s = m48t59_qtest_start();
 
     for (i = 0; i < 1000; i++) {
         uint8_t reg, val;
@@ -237,24 +229,38 @@ static void fuzz_registers(void)
         cmos_write(reg, val);
         cmos_read(reg);
     }
+
+    qtest_quit(s);
+}
+
+static void base_setup(void)
+{
+    const char *arch = qtest_get_arch();
+
+    if (g_str_equal(arch, "sparc")) {
+        /* Note: For sparc64, we'd need to map-in the PCI bridge memory first */
+        base = 0x71200000;
+        base_year = 1968;
+        use_mmio = true;
+    } else {
+        g_assert_not_reached();
+    }
 }
 
 int main(int argc, char **argv)
 {
-    QTestState *s = NULL;
     int ret;
 
-    g_test_init(&argc, &argv, NULL);
+    base_setup();
 
-    s = qtest_start("-rtc clock=vm");
+    g_test_init(&argc, &argv, NULL);
 
-    qtest_add_func("/rtc/bcd/check-time", bcd_check_time);
+    if (g_test_slow()) {
+        /* Do not run this in timing-sensitive environments */
+        qtest_add_func("/rtc/bcd-check-time", bcd_check_time);
+    }
     qtest_add_func("/rtc/fuzz-registers", fuzz_registers);
     ret = g_test_run();
 
-    if (s) {
-        qtest_quit(s);
-    }
-
     return ret;
 }
-- 
1.8.3.1
