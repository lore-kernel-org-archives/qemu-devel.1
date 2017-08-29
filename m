Received: from eggs.gnu.org ([2001:4830:134:3::10]:46254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dml1J-0005H1-Te
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 14:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dml1E-0001np-Ru
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 14:13:49 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 29 Aug 2017 20:13:36 +0200
Message-Id: <1504030416-18618-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] tests: Fix broken
 ivshmem-server-msi/-irq tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Broken with commit b4ba67d9a7025 ("libqos: Change PCI accessors to take
opaque BAR handle") a while ago, but nobody noticed since the tests are
only run in SPEED=slow mode: The msix_pba_bar is not correctly initialized
anymore if bir_pba has the same value as bir_table. With this fix,
"make check SPEED=slow" should work fine again.

Fixes: b4ba67d9a702507793c2724e56f98e9b0f7be02b
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
index 2dcdead..28d576c 100644
--- a/tests/libqos/pci.c
+++ b/tests/libqos/pci.c
@@ -120,6 +120,8 @@ void qpci_msix_enable(QPCIDevice *dev)
     bir_pba = table & PCI_MSIX_FLAGS_BIRMASK;
     if (bir_pba != bir_table) {
         dev->msix_pba_bar = qpci_iomap(dev, bir_pba, NULL);
+    } else {
+        dev->msix_pba_bar = dev->msix_table_bar;
     }
     dev->msix_pba_off = table & ~PCI_MSIX_FLAGS_BIRMASK;
 
@@ -138,8 +140,11 @@ void qpci_msix_disable(QPCIDevice *dev)
     qpci_config_writew(dev, addr + PCI_MSIX_FLAGS,
                                                 val & ~PCI_MSIX_FLAGS_ENABLE);
 
+    if (dev->msix_pba_bar.addr != dev->msix_table_bar.addr) {
+        qpci_iounmap(dev, dev->msix_pba_bar);
+    }
     qpci_iounmap(dev, dev->msix_table_bar);
-    qpci_iounmap(dev, dev->msix_pba_bar);
+
     dev->msix_enabled = 0;
     dev->msix_table_off = 0;
     dev->msix_pba_off = 0;
-- 
1.8.3.1
