Received: from eggs.gnu.org ([209.51.188.92]:43469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1tro-0004NQ-Nr
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:19:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1trm-00084S-SU
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:19:24 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  7 Mar 2019 15:18:26 +0100
Message-Id: <1551968334-18982-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1551968334-18982-1-git-send-email-thuth@redhat.com>
References: <1551968334-18982-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 01/29] hw/pci/pci-stub: Add msi_enabled()
 and msi_notify() to the pci stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Some machines have an AHCI adapter, but no PCI. To be able to
compile hw/ide/ahci.c without CONFIG_PCI, we still need the two
functions msi_enabled() and msi_notify() for linking.
This is required for the new Kconfig-like build system, if a user
wants to compile a QEMU binary with just one machine that has AHCI,
but no PCI, like the ARM "cubieboard" for example.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/pci/pci-stub.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index b941a0e..c04a5df 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -53,3 +53,14 @@ uint16_t pci_requester_id(PCIDevice *dev)
     g_assert(false);
     return 0;
 }
+
+/* Required by ahci.c */
+bool msi_enabled(const PCIDevice *dev)
+{
+    return false;
+}
+
+void msi_notify(PCIDevice *dev, unsigned int vector)
+{
+    g_assert_not_reached();
+}
-- 
1.8.3.1
