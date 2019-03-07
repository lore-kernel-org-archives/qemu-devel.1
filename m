Received: from eggs.gnu.org ([209.51.188.92]:43457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1trl-0004KF-AU
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:19:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1trk-00083M-Fe
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:19:21 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  7 Mar 2019 15:18:27 +0100
Message-Id: <1551968334-18982-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1551968334-18982-1-git-send-email-thuth@redhat.com>
References: <1551968334-18982-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 02/29] hw/ide/ahci: Add a Kconfig switch for
 the AHDI-ICH9 device
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

Some of our machines (like the ARM cubieboard) use CONFIG_AHCI for an AHCI
sysbus device, but do not use CONFIG_PCI since they do not feature a PCI
bus. With CONFIG_AHCI but without CONFIG_PCI, currently linking fails:

    ../hw/ide/ich.o: In function `pci_ich9_ahci_realize':
    hw/ide/ich.c:124: undefined reference to `pci_allocate_irq'
    hw/ide/ich.c:126: undefined reference to `pci_register_bar'
    hw/ide/ich.c:128: undefined reference to `pci_register_bar'
    hw/ide/ich.c:131: undefined reference to `pci_add_capability'
    hw/ide/ich.c:147: undefined reference to `msi_init'
    ../hw/ide/ich.o: In function `pci_ich9_uninit':
    hw/ide/ich.c:158: undefined reference to `msi_uninit'
    ../hw/ide/ich.o:(.data.rel+0x50): undefined reference to `vmstate_pci_device'

We must only compile ich.c if CONFIG_PCI is available, too, so introduce a
new config switch for this device.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ide/Kconfig       | 6 +++++-
 hw/ide/Makefile.objs | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index ab47b6a..5d9106b 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -44,9 +44,13 @@ config MICRODRIVE
 
 config AHCI
     bool
+    select IDE_QDEV
+
+config AHCI_ICH9
+    bool
     default y if PCI_DEVICES
     depends on PCI
-    select IDE_QDEV
+    select AHCI
 
 config IDE_SII3112
     bool
diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
index a142add..faf04e0 100644
--- a/hw/ide/Makefile.objs
+++ b/hw/ide/Makefile.objs
@@ -9,6 +9,6 @@ common-obj-$(CONFIG_IDE_MMIO) += mmio.o
 common-obj-$(CONFIG_IDE_VIA) += via.o
 common-obj-$(CONFIG_MICRODRIVE) += microdrive.o
 common-obj-$(CONFIG_AHCI) += ahci.o
-common-obj-$(CONFIG_AHCI) += ich.o
+common-obj-$(CONFIG_AHCI_ICH9) += ich.o
 common-obj-$(CONFIG_ALLWINNER_A10) += ahci-allwinner.o
 common-obj-$(CONFIG_IDE_SII3112) += sii3112.o
-- 
1.8.3.1
