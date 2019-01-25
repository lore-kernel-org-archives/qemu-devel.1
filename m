Received: from eggs.gnu.org ([209.51.188.92]:58169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOz-0007fY-Rw
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOu-000238-8k
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:55 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOt-00021c-TF
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:52 -0500
Received: by mail-wr1-x442.google.com with SMTP id l9so9579902wrt.13
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:51 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:56 +0100
Message-Id: <1548410831-19553-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 37/52] build: convert pci.mak to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

Instead of including the same list of devices for each target,
set CONFIG_PCI to true, and make the devices default to present
whenever PCI is available.  However, s390x does not want all the
PCI devices, so there is a separate symbol to enable them.

Done mostly with the following script:

  while read i; do
     i=${i%=y}; i=${i#CONFIG_}
     sed -i -e'/^config '$i'$/!b' -en \
            -e'a\' -e'    default y if PCI_DEVICES\' -e'    depends on PCI' \
          `grep -lw $i hw/*/Kconfig`
  done < default-configs/pci.mak

followed by replacing a few "depends on" clauses with "select"
whenever the symbol is not really related to PCI.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190123065618.3520-31-yang.zhong@intel.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/alpha-softmmu.mak       |  3 ++-
 default-configs/arm-softmmu.mak         |  3 ++-
 default-configs/hppa-softmmu.mak        |  4 +--
 default-configs/i386-softmmu.mak        |  5 ++--
 default-configs/mips-softmmu-common.mak |  3 ++-
 default-configs/pci.mak                 | 48 ---------------------------------
 default-configs/ppc-softmmu.mak         |  3 ++-
 default-configs/riscv32-softmmu.mak     |  4 +--
 default-configs/riscv64-softmmu.mak     |  4 +--
 default-configs/sh4-softmmu.mak         |  3 ++-
 default-configs/sh4eb-softmmu.mak       |  3 ++-
 default-configs/sparc64-softmmu.mak     |  3 ++-
 docs/devel/build-system.txt             |  1 -
 hw/audio/Kconfig                        |  6 +++++
 hw/block/Kconfig                        |  2 ++
 hw/char/Kconfig                         |  2 ++
 hw/display/Kconfig                      | 16 +++++++++++
 hw/ide/Kconfig                          |  3 +++
 hw/ipack/Kconfig                        |  2 ++
 hw/misc/Kconfig                         |  6 ++++-
 hw/net/Kconfig                          | 23 ++++++++++++++++
 hw/pci-bridge/Kconfig                   |  8 ++++++
 hw/pci-host/Kconfig                     | 10 +++++++
 hw/pci/Kconfig                          |  3 +++
 hw/scsi/Kconfig                         | 11 ++++++++
 hw/sd/Kconfig                           |  3 +++
 hw/usb/Kconfig                          | 10 +++++++
 hw/virtio/Kconfig                       |  3 +++
 hw/watchdog/Kconfig                     |  2 ++
 29 files changed, 131 insertions(+), 66 deletions(-)
 delete mode 100644 default-configs/pci.mak

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index fc4afeb..a7b4a87 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -1,7 +1,8 @@
 # Default configuration for alpha-softmmu
 
-include pci.mak
 include usb.mak
+CONFIG_PCI=y
+CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
 CONFIG_I82374=y
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 59cf3d2..0109e68 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -1,7 +1,8 @@
 # Default configuration for arm-softmmu
 
-include pci.mak
 include usb.mak
+CONFIG_PCI=y
+CONFIG_PCI_DEVICES=y
 CONFIG_VGA=y
 CONFIG_NAND=y
 CONFIG_ECC=y
diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
index b594a6d..1594760 100644
--- a/default-configs/hppa-softmmu.mak
+++ b/default-configs/hppa-softmmu.mak
@@ -1,10 +1,10 @@
-include pci.mak
 include usb.mak
+CONFIG_PCI=y
+CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
 CONFIG_ISA_BUS=y
 CONFIG_I8259=y
-CONFIG_E1000_PCI=y
 CONFIG_IDE_ISA=y
 CONFIG_IDE_CMD646=y
 # CONFIG_IDE_MMIO=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index b5281d3..a139bd5 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,11 +1,11 @@
 # Default configuration for i386-softmmu
 
-include pci.mak
+CONFIG_PCI=y
+CONFIG_PCI_DEVICES=y
 include sound.mak
 include usb.mak
 include hyperv.mak
 CONFIG_VGA_ISA=y
-CONFIG_VGA_CIRRUS=y
 CONFIG_VMWARE_VGA=y
 CONFIG_VMXNET3_PCI=y
 CONFIG_VIRTIO_VGA=y
@@ -53,7 +53,6 @@ CONFIG_MEM_DEVICE=y
 CONFIG_DIMM=y
 CONFIG_NVDIMM=y
 CONFIG_ACPI_NVDIMM=y
-CONFIG_PCIE_PORT=y
 CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index ded7498..246af88 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -1,8 +1,9 @@
 # Common mips*-softmmu CONFIG defines
 
-include pci.mak
 include sound.mak
 include usb.mak
+CONFIG_PCI=y
+CONFIG_PCI_DEVICES=y
 CONFIG_ESP=y
 CONFIG_SCSI=y
 CONFIG_VGA_ISA=y
diff --git a/default-configs/pci.mak b/default-configs/pci.mak
deleted file mode 100644
index 41af5e7..0000000
--- a/default-configs/pci.mak
+++ /dev/null
@@ -1,48 +0,0 @@
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
-CONFIG_E1000E_PCI_EXPRESS=y
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
-CONFIG_VFIO_PCI=y
-CONFIG_EDID=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 47e4177..763184f 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -1,8 +1,9 @@
 # Default configuration for ppc-softmmu
 
-include pci.mak
 include sound.mak
 include usb.mak
+CONFIG_PCI=y
+CONFIG_PCI_DEVICES=y
 
 # For embedded PPCs:
 CONFIG_PPC4XX=y
diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index 8c3a91a..5501c1b 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -1,8 +1,8 @@
 # Default configuration for riscv-softmmu
 
-include pci.mak
 include usb.mak
-
+CONFIG_PCI=y
+CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
 CONFIG_VIRTIO_MMIO=y
 
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index 8c3a91a..5501c1b 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -1,8 +1,8 @@
 # Default configuration for riscv-softmmu
 
-include pci.mak
 include usb.mak
-
+CONFIG_PCI=y
+CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
 CONFIG_VIRTIO_MMIO=y
 
diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
index 1fdb009..0459d43 100644
--- a/default-configs/sh4-softmmu.mak
+++ b/default-configs/sh4-softmmu.mak
@@ -1,7 +1,8 @@
 # Default configuration for sh4-softmmu
 
-include pci.mak
 include usb.mak
+CONFIG_PCI=y
+CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
 CONFIG_PTIMER=y
diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
index 3b550a5..09a5b5e 100644
--- a/default-configs/sh4eb-softmmu.mak
+++ b/default-configs/sh4eb-softmmu.mak
@@ -1,7 +1,8 @@
 # Default configuration for sh4eb-softmmu
 
-include pci.mak
 include usb.mak
+CONFIG_PCI=y
+CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
 CONFIG_PTIMER=y
diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index 1fae488..d5e4a73 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -1,7 +1,8 @@
 # Default configuration for sparc64-softmmu
 
-include pci.mak
 include usb.mak
+CONFIG_PCI=y
+CONFIG_PCI_DEVICES=y
 CONFIG_M48T59=y
 CONFIG_PTIMER=y
 CONFIG_SERIAL=y
diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
index f9fd27f..addd274 100644
--- a/docs/devel/build-system.txt
+++ b/docs/devel/build-system.txt
@@ -417,7 +417,6 @@ into each QEMU system and userspace emulator targets. They merely
 contain a long list of config variable definitions. For example,
 default-configs/x86_64-softmmu.mak has:
 
-  include pci.mak
   include sound.mak
   include usb.mak
   CONFIG_QXL=$(CONFIG_SPICE)
diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
index 207baee..aa5c82b 100644
--- a/hw/audio/Kconfig
+++ b/hw/audio/Kconfig
@@ -3,9 +3,13 @@ config SB16
 
 config ES1370
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config AC97
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config ADLIB
     bool
@@ -18,6 +22,8 @@ config CS4231A
 
 config HDA
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config PCSPK
     bool
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 1780569..f7b9d3a 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -21,6 +21,8 @@ config ONENAND
 
 config NVME_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config VIRTIO_BLK
     bool
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 26c1324..6eba69a 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -15,6 +15,8 @@ config SERIAL_ISA
 
 config SERIAL_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config VIRTIO_SERIAL
     bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 429056b..f8d63c6 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -9,6 +9,9 @@ config ADS7846
 
 config VGA_CIRRUS
     bool
+    default y if PCI_DEVICES
+    depends on PCI
+    select VGA
 
 config G364FB
     bool
@@ -30,6 +33,9 @@ config SSD0323
 
 config VGA_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
+    select VGA
 
 config VGA_ISA
     bool
@@ -39,9 +45,15 @@ config VGA_ISA_MM
 
 config VMWARE_VGA
     bool
+    default y if PCI_DEVICES
+    depends on PCI
+    select VGA
 
 config BOCHS_DISPLAY
     bool
+    default y if PCI_DEVICES
+    depends on PCI
+    select VGA
 
 config BLIZZARD
     bool
@@ -70,12 +82,16 @@ config QXL
     bool
     default y if PC
     depends on SPICE && PCI
+    select VGA
 
 config VIRTIO_GPU
     bool
 
 config VIRTIO_VGA
     bool
+    default y if PCI_DEVICES && VIRTIO
+    depends on PCI
+    select VGA
 
 config DPCD
     bool
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index fe27705..246e27b 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -7,6 +7,7 @@ config IDE_QDEV
 
 config IDE_PCI
     bool
+    depends on PCI
     select IDE_CORE
 
 config IDE_ISA
@@ -42,6 +43,8 @@ config MICRODRIVE
 
 config AHCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
     select IDE_QDEV
 
 config IDE_SII3112
diff --git a/hw/ipack/Kconfig b/hw/ipack/Kconfig
index 481e0d2..f8da24a 100644
--- a/hw/ipack/Kconfig
+++ b/hw/ipack/Kconfig
@@ -1,2 +1,4 @@
 config IPACK
     bool
+    default y if PCI_DEVICES
+	    depends on PCI
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index cc8dbed..c85c085 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -21,9 +21,13 @@ config ISA_TESTDEV
 
 config PCI_TESTDEV
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config EDU
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config PCA9552
     bool
@@ -48,7 +52,7 @@ config MACIO
 
 config IVSHMEM_DEVICE
     bool
-    default y
+    default y if PCI_DEVICES
     depends on PCI
 
 config ECCMEMCTL
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index d358b2c..d50e301 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -3,27 +3,42 @@ config DP8393X
 
 config NE2000_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config EEPRO100_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config PCNET_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
+    select PCNET_COMMON
 
 config PCNET_COMMON
     bool
 
 config E1000_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config E1000E_PCI_EXPRESS
     bool
+    default y if PCI_DEVICES
+    depends on PCI_EXPRESS
 
 config RTL8139_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config VMXNET3_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config SMC91C111
     bool
@@ -81,12 +96,20 @@ config ETSEC
 
 config ROCKER
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config CAN_BUS
     bool
 
 config CAN_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
+    select CAN_BUS
 
 config CAN_SJA1000
     bool
+    default y if PCI_DEVICES
+    depends on PCI
+    select CAN_BUS
diff --git a/hw/pci-bridge/Kconfig b/hw/pci-bridge/Kconfig
index bb19b7a..0519eb1 100644
--- a/hw/pci-bridge/Kconfig
+++ b/hw/pci-bridge/Kconfig
@@ -1,17 +1,25 @@
 config PCIE_PORT
     bool
+    default y if PCI_DEVICES
+    depends on PCI_EXPRESS
 
 config PXB
     bool
 
 config XIO3130
     bool
+    default y if PCI_DEVICES
+    depends on PCI_EXPRESS
 
 config IOH3420
     bool
+    default y if PCI_DEVICES
+    depends on PCI_EXPRESS
 
 config I82801B11
     bool
+    default y if PCI_DEVICES
+    depends on PCI_EXPRESS
 
 config DEC_PCI
     bool
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 2edc5bb..c01812a 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -2,21 +2,27 @@ config PAM
     bool
 
 config PREP_PCI
+    select PCI
     bool
 
 config GRACKLE_PCI
+    select PCI
     bool
 
 config UNIN_PCI
+    select PCI
     bool
 
 config PPCE500_PCI
+    select PCI
     bool
 
 config VERSATILE_PCI
+    select PCI
     bool
 
 config PCI_SABRE
+    select PCI
     bool
 
 config PCI_PIIX
@@ -24,12 +30,16 @@ config PCI_PIIX
 
 config PCI_EXPRESS_Q35
     bool
+    select PCI_EXPRESS
 
 config PCI_EXPRESS_GENERIC_BRIDGE
     bool
+    select PCI_EXPRESS
 
 config PCI_EXPRESS_XILINX
     bool
+    select PCI_EXPRESS
 
 config PCI_EXPRESS_DESIGNWARE
     bool
+    select PCI_EXPRESS
diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
index 4ca2537..3b8638b 100644
--- a/hw/pci/Kconfig
+++ b/hw/pci/Kconfig
@@ -4,3 +4,6 @@ config PCI
 config PCI_EXPRESS
     bool
     select PCI
+
+config PCI_DEVICES
+    bool
diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
index 834413b..c02d880 100644
--- a/hw/scsi/Kconfig
+++ b/hw/scsi/Kconfig
@@ -3,21 +3,32 @@ config SCSI
 
 config LSI_SCSI_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config MPTSAS_SCSI_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config MEGASAS_SCSI_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config VMW_PVSCSI_SCSI_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config ESP
     bool
 
 config ESP_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
+    select ESP
 
 config SPAPR_VSCSI
     bool
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index 4f43bbb..c6c5dfb 100644
--- a/hw/sd/Kconfig
+++ b/hw/sd/Kconfig
@@ -9,3 +9,6 @@ config SD
 
 config SDHCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
+    select SD
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index cbf5c5d..86ee615 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -3,21 +3,31 @@ config USB
 
 config USB_UHCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config USB_OHCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config USB_EHCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config USB_EHCI_SYSBUS
     bool
 
 config USB_XHCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config USB_XHCI_NEC
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config USB_MUSB
     bool
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index ebf1812..5dafbe3 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -6,6 +6,9 @@ config VIRTIO_RNG
 
 config VIRTIO_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
+    select VIRTIO
 
 config VIRTIO_MMIO
     bool
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index cd0244f..edb3d42 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -3,6 +3,8 @@ config CMSDK_APB_WATCHDOG
 
 config WDT_IB6300ESB
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config WDT_IB700
     bool
-- 
1.8.3.1
