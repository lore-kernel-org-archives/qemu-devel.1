Received: from eggs.gnu.org ([2001:4830:134:3::10]:42530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df8lZ-00018f-2r
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 13:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df8lY-0002aa-0X
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 13:58:05 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  8 Aug 2017 13:57:09 -0400
Message-Id: <20170808175711.12203-3-jsnow@redhat.com>
In-Reply-To: <20170808175711.12203-1-jsnow@redhat.com>
References: <20170808175711.12203-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] IDE: test flush on empty CDROM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, pjp@redhat.com, John Snow <jsnow@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/ide-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/ide-test.c b/tests/ide-test.c
index bfd79dd..ffbfb04 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -689,6 +689,24 @@ static void test_flush_nodev(void)
     ide_test_quit();
 }
 
+static void test_flush_empty_drive(void)
+{
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar;
+
+    ide_test_start("-device ide-cd,bus=ide.0");
+    dev = get_pci_device(&bmdma_bar, &ide_bar);
+
+    /* FLUSH CACHE command on device 0*/
+    qpci_io_writeb(dev, ide_bar, reg_device, 0);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_FLUSH_CACHE);
+
+    /* Just testing that qemu doesn't crash... */
+
+    free_pci_device(dev);
+    ide_test_quit();
+}
+
 static void test_pci_retry_flush(void)
 {
     test_retry_flush("pc");
@@ -954,6 +972,7 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ide/flush", test_flush);
     qtest_add_func("/ide/flush/nodev", test_flush_nodev);
+    qtest_add_func("/ide/flush/empty_drive", test_flush_empty_drive);
     qtest_add_func("/ide/flush/retry_pci", test_pci_retry_flush);
     qtest_add_func("/ide/flush/retry_isa", test_isa_retry_flush);
 
-- 
2.9.4
