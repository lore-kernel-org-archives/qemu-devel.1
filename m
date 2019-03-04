Received: from eggs.gnu.org ([209.51.188.92]:45872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCY-0001vC-Lk
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCW-000400-HH
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:34 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:51869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCW-0003yT-6D
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:32 -0500
Received: by mail-wm1-x329.google.com with SMTP id n19so140537wmi.1
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:35 +0100
Message-Id: <1551723614-1823-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/54] build: convert pci.mak to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>

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
 default-configs/arm-softmmu.mak         |  7 ++++-
 default-configs/hppa-softmmu.mak        |  5 +++-
 default-configs/i386-softmmu.mak        |  5 ++--
 default-configs/mips-softmmu-common.mak |  3 ++-
 default-configs/mips64el-softmmu.mak    |  1 +
 default-configs/pci.mak                 | 47 ---------------------------------
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
 hw/display/Kconfig                      | 19 +++++++++++++
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
 30 files changed, 141 insertions(+), 64 deletions(-)
 delete mode 100644 default-configs/pci.mak

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index 8000a9a..27936dd 100644
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
index b430be5..e9a972f 100644
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
@@ -163,3 +164,7 @@ CONFIG_PCI_EXPRESS_DESIGNWARE=y
 CONFIG_STRONGARM=y
 CONFIG_HIGHBANK=y
 CONFIG_MUSICPAL=y
+
+# for realview and versatilepb
+CONFIG_SCSI=y
+CONFIG_LSI_SCSI_PCI=y
diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
index e0a6cdc..85a2011 100644
--- a/default-configs/hppa-softmmu.mak
+++ b/default-configs/hppa-softmmu.mak
@@ -1,5 +1,6 @@
-include pci.mak
 include usb.mak
+CONFIG_PCI=y
+CONFIG_PCI_DEVICES=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
 CONFIG_ISA_BUS=y
@@ -7,6 +8,8 @@ CONFIG_I8259=y
 CONFIG_E1000_PCI=y
 CONFIG_IDE_CMD646=y
 # CONFIG_IDE_MMIO=y
+CONFIG_SCSI=y
+CONFIG_LSI_SCSI_PCI=y
 CONFIG_VIRTIO_VGA=y
 CONFIG_MC146818RTC=y
 CONFIG_DINO=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index c7e32ce..b4dc3a0 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,12 +1,12 @@
 # Default configuration for i386-softmmu
 
-include pci.mak
+CONFIG_PCI=y
+CONFIG_PCI_DEVICES=y
 include sound.mak
 include usb.mak
 include hyperv.mak
 CONFIG_TEST_DEVICES=y
 CONFIG_VGA_ISA=y
-CONFIG_VGA_CIRRUS=y
 CONFIG_VMWARE_VGA=y
 CONFIG_VMXNET3_PCI=y
 CONFIG_VIRTIO_VGA=y
@@ -45,7 +45,6 @@ CONFIG_MEM_DEVICE=y
 CONFIG_DIMM=y
 CONFIG_NVDIMM=y
 CONFIG_ACPI_NVDIMM=y
-CONFIG_PCIE_PORT=y
 CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index cba8582..9c2146e 100644
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
diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips64el-softmmu.mak
index c6ad4da..8b255ef 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -10,6 +10,7 @@ CONFIG_JAZZ=y
 CONFIG_G364FB=y
 CONFIG_JAZZ_LED=y
 CONFIG_VT82C686=y
+CONFIG_AHCI=y
 CONFIG_MIPS_BOSTON=y
 CONFIG_FITLOADER=y
 CONFIG_PCI_EXPRESS=y
diff --git a/default-configs/pci.mak b/default-configs/pci.mak
deleted file mode 100644
index fc5edfc..0000000
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
-CONFIG_ROCKER=y
-CONFIG_VFIO_PCI=y
-CONFIG_EDID=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 5ccdcb6..74e31a6 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -1,8 +1,9 @@
 # Default configuration for ppc-softmmu
 
-include pci.mak
 include sound.mak
 include usb.mak
+CONFIG_PCI=y
+CONFIG_PCI_DEVICES=y
 CONFIG_TEST_DEVICES=y
 
 # For embedded PPCs:
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
index e406559..87da3a6 100644
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
index 14dea69..ce9aae9 100644
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
index 1e519b3..bf52d52 100644
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
index 45d3a6a..6517e90 100644
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
index aca8d11..0aa82ac 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -23,6 +23,8 @@ config ONENAND
 
 config NVME_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
 
 config VIRTIO_BLK
     bool
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index fbb0a9b..fc18481 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -20,6 +20,8 @@ config SERIAL_ISA
 
 config SERIAL_PCI
     bool
+    default y if PCI_DEVICES
+    depends on PCI
     select SERIAL
 
 config VIRTIO_SERIAL
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index bbd6dd9..4941773 100644
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
@@ -42,9 +48,15 @@ config VGA_ISA_MM
 
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
@@ -72,12 +84,19 @@ config VGA
 config QXL
     bool
     depends on SPICE && PCI
+    select VGA
 
 config VIRTIO_GPU
     bool
+    default y if PCI_DEVICES
+    depends on VIRTIO
+    select EDID
 
 config VIRTIO_VGA
     bool
+    default y if PCI_DEVICES
+    depends on VIRTIO_PCI
+    select VGA
 
 config DPCD
     bool
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index 88076a7..ab47b6a 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -7,6 +7,7 @@ config IDE_QDEV
 
 config IDE_PCI
     bool
+    depends on PCI
     select IDE_CORE
 
 config IDE_ISA
@@ -43,6 +44,8 @@ config MICRODRIVE
 
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
index a1e4bd8..41d8633 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -26,9 +26,13 @@ config ISA_TESTDEV
 
 config PCI_TESTDEV
     bool
+    default y if TEST_DEVICES
+    depends on PCI
 
 config EDU
     bool
+    default y if TEST_DEVICES
+    depends on PCI
 
 config PCA9552
     bool
@@ -53,7 +57,7 @@ config MACIO
 
 config IVSHMEM_DEVICE
     bool
-    default y
+    default y if PCI_DEVICES
     depends on PCI && LINUX && IVSHMEM
 
 config ECCMEMCTL
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index f4b5ff2..a309831 100644
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
@@ -85,12 +100,20 @@ config ETSEC
 
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
index 982537b..8144ccb 100644
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
index 4bbd981..35ccb72 100644
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
