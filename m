Received: from eggs.gnu.org ([208.118.235.92]:54819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGd-0003FC-4z
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGN-0004LZ-QO
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:57858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gcPGN-0004B3-Fi
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:23 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 27 Dec 2018 14:34:04 +0800
Message-Id: <20181227063419.12981-11-yang.zhong@intel.com>
In-Reply-To: <20181227063419.12981-1-yang.zhong@intel.com>
References: <20181227063419.12981-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH 10/25] build: convert pci.mak to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

Instead of including the same list of devices for each target,
set CONFIG_PCI to true, and make the devices default to present
whenever PCI is available.

Done mostly with the following script:

  while read i; do
     i=${i%=y}; i=${i#CONFIG_}
     sed -i -e'/^config '$i'$/!b' -en \
            -e'a\' -e'    default y\' -e'    depends on PCI' \
          `grep -lw $i hw/*/Kconfig`
  done < default-configs/pci.mak

followed by replacing a few "depends on" clauses with "select"
whenever the symbol is not really related to PCI.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 default-configs/i386-softmmu.mak |  2 +-
 default-configs/pci.mak          | 47 --------------------------------
 hw/audio/Kconfig                 |  6 ++++
 hw/block/Kconfig                 |  2 ++
 hw/char/Kconfig                  |  2 ++
 hw/display/Kconfig               | 12 +++++++-
 hw/ide/Kconfig                   |  6 ++++
 hw/ipack/Kconfig                 |  2 ++
 hw/misc/Kconfig                  |  4 +++
 hw/net/Kconfig                   | 19 +++++++++++++
 hw/scsi/Kconfig                  | 11 ++++++++
 hw/sd/Kconfig                    |  3 ++
 hw/usb/Kconfig                   | 10 +++++++
 hw/virtio/Kconfig                |  3 ++
 hw/watchdog/Kconfig              |  2 ++
 15 files changed, 82 insertions(+), 49 deletions(-)
 delete mode 100644 default-configs/pci.mak

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 560250c998..61f19e5231 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,6 +1,6 @@
 # Default configuration for i386-softmmu
 
-include pci.mak
+CONFIG_PCI=y
 include sound.mak
 include usb.mak
 include hyperv.mak
diff --git a/default-configs/pci.mak b/default-configs/pci.mak
deleted file mode 100644
index c1b64922b9..0000000000
--- a/default-configs/pci.mak
+++ /dev/null
@@ -1,47 +0,0 @@
-CONFIG_PCI=y
-# For now, CONFIG_IDE_CORE requires ISA, so we enable it here
-CONFIG_ISA_BUS=y
-CONFIG_VIRTIO_PCI=y
-include virtio.mak
-CONFIG_USB_UHCI=y
-CONFIG_USB_OHCI=y
-CONFIG_USB_EHCI=y
-CONFIG_USB_XHCI=y
-CONFIG_USB_XHCI_NEC=y
-CONFIG_NE2000_PCI=y
-CONFIG_EEPRO100_PCI=y
-CONFIG_PCNET_PCI=y
-CONFIG_PCNET_COMMON=y
-CONFIG_AC97=y
-CONFIG_HDA=y
-CONFIG_ES1370=y
-CONFIG_SCSI=y
-CONFIG_LSI_SCSI_PCI=y
-CONFIG_VMW_PVSCSI_SCSI_PCI=y
-CONFIG_MEGASAS_SCSI_PCI=y
-CONFIG_MPTSAS_SCSI_PCI=y
-CONFIG_RTL8139_PCI=y
-CONFIG_E1000_PCI=y
-CONFIG_E1000E_PCI=y
-CONFIG_AHCI=y
-CONFIG_ESP=y
-CONFIG_ESP_PCI=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
-CONFIG_SERIAL_PCI=y
-CONFIG_CAN_BUS=y
-CONFIG_CAN_SJA1000=y
-CONFIG_CAN_PCI=y
-CONFIG_IPACK=y
-CONFIG_WDT_IB6300ESB=y
-CONFIG_PCI_TESTDEV=y
-CONFIG_NVME_PCI=y
-CONFIG_SD=y
-CONFIG_SDHCI=y
-CONFIG_EDU=y
-CONFIG_VGA=y
-CONFIG_VGA_PCI=y
-CONFIG_BOCHS_DISPLAY=y
-CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
-CONFIG_ROCKER=y
-CONFIG_EDID=y
diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
index 207baee6e1..af34bbcf0c 100644
--- a/hw/audio/Kconfig
+++ b/hw/audio/Kconfig
@@ -3,9 +3,13 @@ config SB16
 
 config ES1370
     bool
+    default y
+    depends on PCI
 
 config AC97
     bool
+    default y
+    depends on PCI
 
 config ADLIB
     bool
@@ -18,6 +22,8 @@ config CS4231A
 
 config HDA
     bool
+    default y
+    depends on PCI
 
 config PCSPK
     bool
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 9d418bce4d..3710434436 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -21,6 +21,8 @@ config ONENAND
 
 config NVME_PCI
     bool
+    default y
+    depends on PCI
 
 config VIRTIO_BLK
     bool
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 26c13243cf..1ed6f0dbce 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -15,6 +15,8 @@ config SERIAL_ISA
 
 config SERIAL_PCI
     bool
+    default y
+    depends on PCI
 
 config VIRTIO_SERIAL
     bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 132aeffdbe..5e73277cc2 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -30,6 +30,9 @@ config SSD0323
 
 config VGA_PCI
     bool
+    default y
+    depends on PCI
+    select VGA
 
 config VGA_ISA
     bool
@@ -39,9 +42,15 @@ config VGA_ISA_MM
 
 config VMWARE_VGA
     bool
+    default y
+    depends on PCI
+    select VGA
 
 config BOCHS_DISPLAY
     bool
+    default y
+    depends on PCI
+    select VGA
 
 config BLIZZARD
     bool
@@ -67,7 +76,8 @@ config VGA
 
 config QXL
     bool
-    depends on SPICE
+    depends on SPICE && PCI
+    select VGA
 
 config VIRTIO_GPU
     bool
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index 091f3a81c9..0f25b27163 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -7,6 +7,7 @@ config IDE_QDEV
 
 config IDE_PCI
     bool
+    depends on PCI
     select IDE_CORE
 
 config IDE_ISA
@@ -15,10 +16,12 @@ config IDE_ISA
 
 config IDE_PIIX
     bool
+    depends on PCI
     select IDE_QDEV
 
 config IDE_CMD646
     bool
+    select IDE_PCI
     select IDE_QDEV
 
 config IDE_MACIO
@@ -31,6 +34,7 @@ config IDE_MMIO
 
 config IDE_VIA
     bool
+    select IDE_PCI
     select IDE_QDEV
 
 config MICRODRIVE
@@ -39,6 +43,8 @@ config MICRODRIVE
 
 config AHCI
     bool
+    default y
+    depends on PCI
     select IDE_QDEV
 
 config IDE_SII3112
diff --git a/hw/ipack/Kconfig b/hw/ipack/Kconfig
index 481e0d2e64..98bd21cf0f 100644
--- a/hw/ipack/Kconfig
+++ b/hw/ipack/Kconfig
@@ -1,2 +1,4 @@
 config IPACK
     bool
+    default y
+    depends on PCI
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index cc8dbed24e..1ca4b2464e 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -21,9 +21,13 @@ config ISA_TESTDEV
 
 config PCI_TESTDEV
     bool
+    default y
+    depends on PCI
 
 config EDU
     bool
+    default y
+    depends on PCI
 
 config PCA9552
     bool
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 6b2ec971b5..c87375ee52 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -3,27 +3,42 @@ config DP8393X
 
 config NE2000_PCI
     bool
+    default y
+    depends on PCI
 
 config EEPRO100_PCI
     bool
+    default y
+    depends on PCI
 
 config PCNET_PCI
     bool
+    default y
+    depends on PCI
+    select PCNET_COMMON
 
 config PCNET_COMMON
     bool
 
 config E1000_PCI
     bool
+    default y
+    depends on PCI
 
 config E1000E_PCI
     bool
+    default y
+    depends on PCI
 
 config RTL8139_PCI
     bool
+    default y
+    depends on PCI
 
 config VMXNET3_PCI
     bool
+    default y
+    depends on PCI
 
 config SMC91C111
     bool
@@ -81,12 +96,16 @@ config ETSEC
 
 config ROCKER
     bool
+    default y
+    depends on PCI
 
 config CAN_BUS
     bool
 
 config CAN_PCI
     bool
+    default y
+    depends on PCI
 
 config CAN_SJA1000
     bool
diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
index c48bf4e8d0..6e7575397f 100644
--- a/hw/scsi/Kconfig
+++ b/hw/scsi/Kconfig
@@ -3,21 +3,32 @@ config SCSI
 
 config LSI_SCSI_PCI
     bool
+    default y
+    depends on PCI
 
 config MPTSAS_SCSI_PCI
     bool
+    default y
+    depends on PCI
 
 config MEGASAS_SCSI_PCI
     bool
+    default y
+    depends on PCI
 
 config VMW_PVSCSI_SCSI_PCI
     bool
+    default y
+    depends on PCI
 
 config ESP
     bool
 
 config ESP_PCI
     bool
+    default y
+    depends on PCI
+    select ESP
 
 config PSERIES
     bool
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index 4f43bbb352..90ac74950a 100644
--- a/hw/sd/Kconfig
+++ b/hw/sd/Kconfig
@@ -9,3 +9,6 @@ config SD
 
 config SDHCI
     bool
+    default y
+    depends on PCI
+    select SD
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index cbf5c5d761..f23c542d27 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -3,21 +3,31 @@ config USB
 
 config USB_UHCI
     bool
+    default y
+    depends on PCI
 
 config USB_OHCI
     bool
+    default y
+    depends on PCI
 
 config USB_EHCI
     bool
+    default y
+    depends on PCI
 
 config USB_EHCI_SYSBUS
     bool
 
 config USB_XHCI
     bool
+    default y
+    depends on PCI
 
 config USB_XHCI_NEC
     bool
+    default y
+    depends on PCI
 
 config USB_MUSB
     bool
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index ebf18124fb..aabd6d4d96 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -6,6 +6,9 @@ config VIRTIO_RNG
 
 config VIRTIO_PCI
     bool
+    default y
+    depends on PCI
+    select VIRTIO
 
 config VIRTIO_MMIO
     bool
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index cd0244f4e1..4e24bf8240 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -3,6 +3,8 @@ config CMSDK_APB_WATCHDOG
 
 config WDT_IB6300ESB
     bool
+    default y
+    depends on PCI
 
 config WDT_IB700
     bool
-- 
2.17.1
