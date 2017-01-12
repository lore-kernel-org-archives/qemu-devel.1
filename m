Received: from eggs.gnu.org ([2001:4830:134:3::10]:46935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkD-0003Ez-Lf
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUkA-0006mA-SF
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:04:01 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:03:20 +1100
Message-Id: <20170112020327.24882-61-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 60/67] pxb: Restrict to x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

The PCI Expander Bridge (PXB) device is essentially a hack to allow
different PCIe devices to be assigned to different NUMA nodes on x86.  Each
PXB is sort-of a separate PCI host bridge, except that its config space
is shared with the config space of the main PCI host bridge, rather than
being independent.

This is only necessary if the platform doesn't (easily) allow truly
independent PCI host bridges.  AFAIK that's just x86.

This patch makes it possible to configure PXB out of the build, and adjusts
the default configs so it's only included on x86 targets.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 default-configs/i386-softmmu.mak   | 1 +
 default-configs/x86_64-softmmu.mak | 1 +
 hw/pci-bridge/Makefile.objs        | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 0b51360..6c52d26 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -56,3 +56,4 @@ CONFIG_IOH3420=y
 CONFIG_I82801B11=y
 CONFIG_SMBIOS=y
 CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
+CONFIG_PXB=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 7f89503..2d0341c 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -56,3 +56,4 @@ CONFIG_IOH3420=y
 CONFIG_I82801B11=y
 CONFIG_SMBIOS=y
 CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
+CONFIG_PXB=y
diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
index f2adfe3..5612bd7 100644
--- a/hw/pci-bridge/Makefile.objs
+++ b/hw/pci-bridge/Makefile.objs
@@ -1,5 +1,5 @@
 common-obj-y += pci_bridge_dev.o
-common-obj-y += pci_expander_bridge.o
+common-obj-$(CONFIG_PXB) += pci_expander_bridge.o
 common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
 common-obj-$(CONFIG_IOH3420) += ioh3420.o
 common-obj-$(CONFIG_I82801B11) += i82801b11.o
-- 
2.9.3
