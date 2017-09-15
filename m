Received: from eggs.gnu.org ([2001:4830:134:3::10]:54749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslaM-0007o3-3C
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslaI-0000fX-Ur
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dslaI-0000eO-PQ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:46 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 15 Sep 2017 10:02:24 +0200
Message-Id: <1505462549-27298-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1505462549-27298-1-git-send-email-thuth@redhat.com>
References: <1505462549-27298-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] tests: Fix broken ivshmem-server-msi/-irq
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, John Snow <jsnow@redhat.com>

Broken with commit b4ba67d9a7025 ("libqos: Change PCI accessors to take
opaque BAR handle") a while ago, but nobody noticed since the tests are
not run by default: The msix_pba_bar is not correctly initialized
anymore if bir_pba has the same value as bir_table. With this fix,
"make check SPEED=slow" should work fine again.

Fixes: b4ba67d9a702507793c2724e56f98e9b0f7be02b
Tested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
index df1f98e..0b73cb2 100644
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
