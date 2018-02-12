Received: from eggs.gnu.org ([2001:4830:134:3::10]:52678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elDTg-00008g-QN
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elDTf-0003Tp-3o
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:45:00 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 12 Feb 2018 13:44:49 +0100
Message-Id: <1518439489-2724-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1518439489-2724-1-git-send-email-thuth@redhat.com>
References: <1518439489-2724-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] tests/m48t59: Add the m48t59 test on ppc,
 too
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

The ref405ep machine has a memory-mapped m48t59 device, so
we can run the m48t59 test on this machine, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 2 ++
 tests/m48t59-test.c    | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3ac874c..d46807a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -318,6 +318,8 @@ check-qtest-ppc-y += tests/boot-order-test$(EXESUF)
 check-qtest-ppc-y += tests/prom-env-test$(EXESUF)
 check-qtest-ppc-y += tests/drive_del-test$(EXESUF)
 check-qtest-ppc-y += tests/boot-serial-test$(EXESUF)
+check-qtest-ppc-y += tests/m48t59-test$(EXESUF)
+gcov-files-ppc-y += hw/timer/m48t59.c
 
 check-qtest-ppc64-y = $(check-qtest-ppc-y)
 gcov-files-ppc64-y = $(subst ppc-softmmu/,ppc64-softmmu/,$(gcov-files-ppc-y))
diff --git a/tests/m48t59-test.c b/tests/m48t59-test.c
index 8c25467..26af7d6 100644
--- a/tests/m48t59-test.c
+++ b/tests/m48t59-test.c
@@ -28,6 +28,7 @@
 static uint32_t base;
 static uint16_t reg_base = 0x1ff0; /* 0x7f0 for m48t02 */
 static int base_year;
+static const char *base_machine;
 static bool use_mmio;
 
 static uint8_t cmos_read_mmio(QTestState *s, uint8_t reg)
@@ -145,7 +146,7 @@ static void cmos_get_date_time(QTestState *s, struct tm *date)
 
 static QTestState *m48t59_qtest_start(void)
 {
-    return qtest_init("-rtc clock=vm");
+    return qtest_startf("-M %s -rtc clock=vm", base_machine);
 }
 
 static void bcd_check_time(void)
@@ -241,6 +242,12 @@ static void base_setup(void)
         /* Note: For sparc64, we'd need to map-in the PCI bridge memory first */
         base = 0x71200000;
         base_year = 1968;
+        base_machine = "SS-5";
+        use_mmio = true;
+    } else if (g_str_equal(arch, "ppc") || g_str_equal(arch, "ppc64")) {
+        base = 0xF0000000;
+        base_year = 1968;
+        base_machine = "ref405ep";
         use_mmio = true;
     } else {
         g_assert_not_reached();
-- 
1.8.3.1
