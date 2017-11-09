Received: from eggs.gnu.org ([2001:4830:134:3::10]:33218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eCmPl-0001uj-Rc
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eCmPi-0007fu-2s
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:58:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eCmPh-0007fW-TI
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:58:34 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Thu,  9 Nov 2017 14:58:26 +0200
Message-Id: <20171109125826.120228-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V4] hw/pcie-pci-bridge: restrict to X86 and ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, thuth@redhat.com, zuban32s@gmail.com, cohuck@redhat.com

The PCIE-PCI bridge is specific to "pure" PCIe systems
(on QEMU we have X86 and ARM), it does not make sense to
have it in other archs.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---

V3 -> V4:
 - Move the config line to pci.mak  (Thomas)

V2 -> V3:
 - Another tweak in subject s/if/it (Cornelia) 

V1 -> V2:
 Addressed Thomas and Cornelia comments:
 - Conditioned the pcie-pci-bridge compilation on
   the PCIe Root CONFIG_PCIE_PORT
 - Tweaked subject PCI -> PCIe

 Thanks,
 Marcel

 default-configs/pci.mak     | 1 +
 hw/pci-bridge/Makefile.objs | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index e514bdef42..7724b9657a 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -43,3 +43,4 @@ CONFIG_VGA_PCI=y
 CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
 CONFIG_ROCKER=y
 CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
+CONFIG_PCIE_PCI_BRIDGE=$(CONFIG_PCIE_PORT)
diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
index 666db37da2..9d23a7038a 100644
--- a/hw/pci-bridge/Makefile.objs
+++ b/hw/pci-bridge/Makefile.objs
@@ -1,6 +1,7 @@
-common-obj-y += pci_bridge_dev.o pcie_pci_bridge.o
+common-obj-y += pci_bridge_dev.o
 common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o gen_pcie_root_port.o
 common-obj-$(CONFIG_PXB) += pci_expander_bridge.o
+common-obj-$(CONFIG_PCIE_PCI_BRIDGE) += pcie_pci_bridge.o
 common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
 common-obj-$(CONFIG_IOH3420) += ioh3420.o
 common-obj-$(CONFIG_I82801B11) += i82801b11.o
-- 
2.13.5
