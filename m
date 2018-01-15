Received: from eggs.gnu.org ([2001:4830:134:3::10]:36119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb16e-0007h7-QI
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb16d-0003XN-UN
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:31:04 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 15 Jan 2018 10:30:54 +0100
Message-Id: <1516008655-31732-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1516008655-31732-1-git-send-email-thuth@redhat.com>
References: <1516008655-31732-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] default-configs/ppc64-softmmu: Include
 32-bit configs instead of copying them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

qemu-softmmu-ppc64 is supposed to be a superset of qemu-softmmu-ppc.
However, instead of simply including the 32-bit config file, we've
duplicated all CONFIG_xxx settings there instead. This way, we've missed
some CONFIG switches in ppc64-softmmu.mak which were only added to the
32-bit config file (e.g. CONFIG_SUNGEM). Let's fix this problem by
including the 32-bit config file into the 64-bit config file instead
of duplicating all the CONFIG switches there.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/ppc64-softmmu.mak | 61 +++++----------------------------------
 1 file changed, 8 insertions(+), 53 deletions(-)

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
index d1b3a6d..b94af6c 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -1,64 +1,19 @@
 # Default configuration for ppc64-softmmu
 
-include pci.mak
-include sound.mak
-include usb.mak
-CONFIG_PPC4XX=y
-CONFIG_VIRTIO_VGA=y
-CONFIG_ESCC=y
-CONFIG_M48T59=y
+# Include all 32-bit boards
+include ppc-softmmu.mak
+
+# For PowerNV
+CONFIG_POWERNV=y
 CONFIG_IPMI=y
 CONFIG_IPMI_LOCAL=y
 CONFIG_IPMI_EXTERN=y
 CONFIG_ISA_IPMI_BT=y
-CONFIG_SERIAL=y
-CONFIG_PARALLEL=y
-CONFIG_I8254=y
-CONFIG_PCKBD=y
-CONFIG_FDC=y
-CONFIG_I8257=y
-CONFIG_I82374=y
-CONFIG_OPENPIC=y
-CONFIG_PREP_PCI=y
-CONFIG_I82378=y
-CONFIG_PC87312=y
-CONFIG_MACIO=y
-CONFIG_PCSPK=y
-CONFIG_CUDA=y
-CONFIG_ADB=y
-CONFIG_MAC_NVRAM=y
-CONFIG_MAC_DBDMA=y
-CONFIG_HEATHROW_PIC=y
-CONFIG_GRACKLE_PCI=y
-CONFIG_UNIN_PCI=y
-CONFIG_DEC_PCI=y
-CONFIG_PPCE500_PCI=y
-CONFIG_IDE_ISA=y
-CONFIG_IDE_CMD646=y
-CONFIG_IDE_MACIO=y
-CONFIG_NE2000_ISA=y
-CONFIG_PFLASH_CFI01=y
-CONFIG_PFLASH_CFI02=y
-CONFIG_PTIMER=y
-CONFIG_I8259=y
-CONFIG_XILINX=y
-CONFIG_XILINX_ETHLITE=y
-CONFIG_PSERIES=y
-CONFIG_POWERNV=y
-CONFIG_PREP=y
-CONFIG_MAC=y
-CONFIG_E500=y
-CONFIG_OPENPIC_KVM=$(call land,$(CONFIG_E500),$(CONFIG_KVM))
-CONFIG_PLATFORM_BUS=y
-CONFIG_ETSEC=y
-CONFIG_SM501=y
+
 # For pSeries
+CONFIG_PSERIES=y
+CONFIG_VIRTIO_VGA=y
 CONFIG_XICS=$(CONFIG_PSERIES)
 CONFIG_XICS_SPAPR=$(CONFIG_PSERIES)
 CONFIG_XICS_KVM=$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
-# For PReP
-CONFIG_SERIAL_ISA=y
-CONFIG_MC146818RTC=y
-CONFIG_ISA_TESTDEV=y
 CONFIG_MEM_HOTPLUG=y
-CONFIG_RS6000_MC=y
-- 
1.8.3.1
