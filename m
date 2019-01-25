Received: from eggs.gnu.org ([209.51.188.92]:58394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyP0-0007q7-KL
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOr-0001z8-1l
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:54 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:38913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOq-0001wT-Hp
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:48 -0500
Received: by mail-wm1-x333.google.com with SMTP id y8so6009536wmi.4
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:47 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:51 +0100
Message-Id: <1548410831-19553-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 32/52] kconfig: introduce kconfig files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

The Kconfig files were generated mostly with this script:

  for i in `grep -ho CONFIG_[A-Z0-9_]* default-configs/* | sort -u`; do
    set fnord `git grep -lw $i -- 'hw/*/Makefile.objs' `
    shift
    if test $# = 1; then
      cat >> $(dirname $1)/Kconfig << EOF
config ${i#CONFIG_}
    bool

EOF
      git add $(dirname $1)/Kconfig
    else
      echo $i $*
    fi
  done
  sed -i '$d' hw/*/Kconfig
  for i in hw/*; do
    if test -d $i && ! test -f $i/Kconfig; then
      touch $i/Kconfig
      git add $i/Kconfig
    fi
  done

Whenever a symbol is referenced from multiple subdirectories, the
script prints the list of directories that reference the symbol.
These symbols have to be added manually to the Kconfig files.

Kconfig.host and hw/Kconfig were created manually.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <20190123065618.3520-27-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Kconfig.host          |  23 ++++++++++
 hw/9pfs/Kconfig       |   4 ++
 hw/Kconfig            |  68 ++++++++++++++++++++++++++++++
 hw/acpi/Kconfig       |  20 +++++++++
 hw/adc/Kconfig        |   2 +
 hw/alpha/Kconfig      |   2 +
 hw/arm/Kconfig        | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/audio/Kconfig      |  35 ++++++++++++++++
 hw/block/Kconfig      |  29 +++++++++++++
 hw/bt/Kconfig         |   2 +
 hw/char/Kconfig       |  32 ++++++++++++++
 hw/core/Kconfig       |  11 +++++
 hw/cpu/Kconfig        |   8 ++++
 hw/cris/Kconfig       |   5 +++
 hw/display/Kconfig    |  77 ++++++++++++++++++++++++++++++++++
 hw/dma/Kconfig        |  20 +++++++++
 hw/gpio/Kconfig       |   8 ++++
 hw/hppa/Kconfig       |   5 +++
 hw/hyperv/Kconfig     |   5 +++
 hw/i2c/Kconfig        |  20 +++++++++
 hw/i386/Kconfig       |  23 ++++++++++
 hw/ide/Kconfig        |  35 ++++++++++++++++
 hw/input/Kconfig      |  23 ++++++++++
 hw/intc/Kconfig       |  47 +++++++++++++++++++++
 hw/ipack/Kconfig      |   2 +
 hw/ipmi/Kconfig       |  14 +++++++
 hw/isa/Kconfig        |  23 ++++++++++
 hw/lm32/Kconfig       |   5 +++
 hw/m68k/Kconfig       |   8 ++++
 hw/mem/Kconfig        |   8 ++++
 hw/microblaze/Kconfig |   8 ++++
 hw/mips/Kconfig       |  20 +++++++++
 hw/misc/Kconfig       |  92 ++++++++++++++++++++++++++++++++++++++++
 hw/misc/macio/Kconfig |  11 +++++
 hw/moxie/Kconfig      |   2 +
 hw/net/Kconfig        |  92 ++++++++++++++++++++++++++++++++++++++++
 hw/nios2/Kconfig      |   5 +++
 hw/nvram/Kconfig      |   8 ++++
 hw/openrisc/Kconfig   |   2 +
 hw/pci-bridge/Kconfig |  20 +++++++++
 hw/pci-host/Kconfig   |  35 ++++++++++++++++
 hw/pci/Kconfig        |   2 +
 hw/pcmcia/Kconfig     |   2 +
 hw/ppc/Kconfig        |  56 +++++++++++++++++++++++++
 hw/riscv/Kconfig      |  19 +++++++++
 hw/s390x/Kconfig      |   2 +
 hw/scsi/Kconfig       |  26 ++++++++++++
 hw/sd/Kconfig         |  11 +++++
 hw/sh4/Kconfig        |  11 +++++
 hw/smbios/Kconfig     |   2 +
 hw/sparc/Kconfig      |  11 +++++
 hw/sparc64/Kconfig    |   5 +++
 hw/ssi/Kconfig        |  14 +++++++
 hw/timer/Kconfig      |  53 +++++++++++++++++++++++
 hw/tpm/Kconfig        |  14 +++++++
 hw/tricore/Kconfig    |   2 +
 hw/unicore32/Kconfig  |   2 +
 hw/usb/Kconfig        |  53 +++++++++++++++++++++++
 hw/vfio/Kconfig       |  23 ++++++++++
 hw/virtio/Kconfig     |  17 ++++++++
 hw/watchdog/Kconfig   |  11 +++++
 hw/xtensa/Kconfig     |   5 +++
 scripts/minikconf.py  |  35 ++++++++++++++--
 63 files changed, 1345 insertions(+), 3 deletions(-)
 create mode 100644 Kconfig.host
 create mode 100644 hw/9pfs/Kconfig
 create mode 100644 hw/Kconfig
 create mode 100644 hw/acpi/Kconfig
 create mode 100644 hw/adc/Kconfig
 create mode 100644 hw/alpha/Kconfig
 create mode 100644 hw/arm/Kconfig
 create mode 100644 hw/audio/Kconfig
 create mode 100644 hw/block/Kconfig
 create mode 100644 hw/bt/Kconfig
 create mode 100644 hw/char/Kconfig
 create mode 100644 hw/core/Kconfig
 create mode 100644 hw/cpu/Kconfig
 create mode 100644 hw/cris/Kconfig
 create mode 100644 hw/display/Kconfig
 create mode 100644 hw/dma/Kconfig
 create mode 100644 hw/gpio/Kconfig
 create mode 100644 hw/hppa/Kconfig
 create mode 100644 hw/hyperv/Kconfig
 create mode 100644 hw/i2c/Kconfig
 create mode 100644 hw/i386/Kconfig
 create mode 100644 hw/ide/Kconfig
 create mode 100644 hw/input/Kconfig
 create mode 100644 hw/intc/Kconfig
 create mode 100644 hw/ipack/Kconfig
 create mode 100644 hw/ipmi/Kconfig
 create mode 100644 hw/isa/Kconfig
 create mode 100644 hw/lm32/Kconfig
 create mode 100644 hw/m68k/Kconfig
 create mode 100644 hw/mem/Kconfig
 create mode 100644 hw/microblaze/Kconfig
 create mode 100644 hw/mips/Kconfig
 create mode 100644 hw/misc/Kconfig
 create mode 100644 hw/misc/macio/Kconfig
 create mode 100644 hw/moxie/Kconfig
 create mode 100644 hw/net/Kconfig
 create mode 100644 hw/nios2/Kconfig
 create mode 100644 hw/nvram/Kconfig
 create mode 100644 hw/openrisc/Kconfig
 create mode 100644 hw/pci-bridge/Kconfig
 create mode 100644 hw/pci-host/Kconfig
 create mode 100644 hw/pci/Kconfig
 create mode 100644 hw/pcmcia/Kconfig
 create mode 100644 hw/ppc/Kconfig
 create mode 100644 hw/riscv/Kconfig
 create mode 100644 hw/s390x/Kconfig
 create mode 100644 hw/scsi/Kconfig
 create mode 100644 hw/sd/Kconfig
 create mode 100644 hw/sh4/Kconfig
 create mode 100644 hw/smbios/Kconfig
 create mode 100644 hw/sparc/Kconfig
 create mode 100644 hw/sparc64/Kconfig
 create mode 100644 hw/ssi/Kconfig
 create mode 100644 hw/timer/Kconfig
 create mode 100644 hw/tpm/Kconfig
 create mode 100644 hw/tricore/Kconfig
 create mode 100644 hw/unicore32/Kconfig
 create mode 100644 hw/usb/Kconfig
 create mode 100644 hw/vfio/Kconfig
 create mode 100644 hw/virtio/Kconfig
 create mode 100644 hw/watchdog/Kconfig
 create mode 100644 hw/xtensa/Kconfig

diff --git a/Kconfig.host b/Kconfig.host
new file mode 100644
index 0000000..f43f418
--- /dev/null
+++ b/Kconfig.host
@@ -0,0 +1,23 @@
+# These are "proxy" symbols used to pass config-host.mak values
+# down to Kconfig.
+
+config KVM
+    bool
+
+config OPENGL
+    bool
+
+config SPICE
+    bool
+
+config TPM
+    bool
+
+config XEN
+    bool
+
+config VHOST_USER
+    bool
+
+config LINUX
+    bool
diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
new file mode 100644
index 0000000..be8e5b3
--- /dev/null
+++ b/hw/9pfs/Kconfig
@@ -0,0 +1,4 @@
+config VIRTFS
+
+config VIRTIO_9P
+    bool
diff --git a/hw/Kconfig b/hw/Kconfig
new file mode 100644
index 0000000..c4f1547
--- /dev/null
+++ b/hw/Kconfig
@@ -0,0 +1,68 @@
+# devices Kconfig
+source 9pfs/Kconfig
+source acpi/Kconfig
+source adc/Kconfig
+source audio/Kconfig
+source block/Kconfig
+source bt/Kconfig
+source char/Kconfig
+source core/Kconfig
+source display/Kconfig
+source dma/Kconfig
+source gpio/Kconfig
+source hyperv/Kconfig
+source i2c/Kconfig
+source ide/Kconfig
+source input/Kconfig
+source intc/Kconfig
+source ipack/Kconfig
+source ipmi/Kconfig
+source isa/Kconfig
+source mem/Kconfig
+source misc/Kconfig
+source net/Kconfig
+source nvram/Kconfig
+source pci-bridge/Kconfig
+source pci-host/Kconfig
+source pcmcia/Kconfig
+source pci/Kconfig
+source scsi/Kconfig
+source sd/Kconfig
+source smbios/Kconfig
+source ssi/Kconfig
+source timer/Kconfig
+source tpm/Kconfig
+source usb/Kconfig
+source virtio/Kconfig
+source vfio/Kconfig
+source watchdog/Kconfig
+
+# arch Kconfig
+source arm/Kconfig
+source alpha/Kconfig
+source cris/Kconfig
+source hppa/Kconfig
+source i386/Kconfig
+source lm32/Kconfig
+source m68k/Kconfig
+source microblaze/Kconfig
+source mips/Kconfig
+source moxie/Kconfig
+source nios2/Kconfig
+source openrisc/Kconfig
+source ppc/Kconfig
+source riscv/Kconfig
+source s390x/Kconfig
+source sh4/Kconfig
+source sparc/Kconfig
+source sparc64/Kconfig
+source tricore/Kconfig
+source unicore32/Kconfig
+source xtensa/Kconfig
+
+# Symbols used by multiple targets
+config XILINX
+    bool
+
+config XILINX_AXI
+    bool
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
new file mode 100644
index 0000000..c485a34
--- /dev/null
+++ b/hw/acpi/Kconfig
@@ -0,0 +1,20 @@
+config ACPI
+    bool
+
+config ACPI_X86
+    bool
+
+config ACPI_X86_ICH
+    bool
+
+config ACPI_CPU_HOTPLUG
+    bool
+
+config ACPI_MEMORY_HOTPLUG
+    bool
+
+config ACPI_NVDIMM
+    bool
+
+config ACPI_VMGENID
+    bool
diff --git a/hw/adc/Kconfig b/hw/adc/Kconfig
new file mode 100644
index 0000000..25d2229
--- /dev/null
+++ b/hw/adc/Kconfig
@@ -0,0 +1,2 @@
+config STM32F2XX_ADC
+    bool
diff --git a/hw/alpha/Kconfig b/hw/alpha/Kconfig
new file mode 100644
index 0000000..c5d0438
--- /dev/null
+++ b/hw/alpha/Kconfig
@@ -0,0 +1,2 @@
+config DP264
+    bool
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
new file mode 100644
index 0000000..1a0a5c9
--- /dev/null
+++ b/hw/arm/Kconfig
@@ -0,0 +1,113 @@
+config VIRT
+    bool
+
+config DIGIC
+    bool
+
+config EXYNOS4
+    bool
+
+config HIGHBANK
+    bool
+
+config INTEGRATOR
+    bool
+
+config MAINSTONE
+    bool
+
+config MUSICPAL
+    bool
+
+config NETDUINO2
+    bool
+
+config NSERIES
+    bool
+
+config OMAP
+    bool
+
+config PXA2XX
+    bool
+
+config REALVIEW
+    bool
+
+config STELLARIS
+    bool
+
+config STRONGARM
+    bool
+
+config VERSATILE
+    bool
+
+config ZYNQ
+    bool
+
+config ARM_V7M
+    bool
+
+config EXYNOS4
+    bool
+
+config ALLWINNER_A10
+    bool
+
+config RASPI
+    bool
+
+config STM32F205_SOC
+    bool
+
+config XLNX_ZYNQMP_ARM
+    bool
+
+config XLNX_VERSAL
+    bool
+
+config FSL_IMX25
+    bool
+
+config FSL_IMX31
+    bool
+
+config FSL_IMX6
+    bool
+
+config ASPEED_SOC
+    bool
+
+config MPS2
+    bool
+
+config IOTKIT
+    bool
+
+config FSL_IMX7
+    bool
+
+config ARM_SMMUV3
+    bool
+
+config FSL_IMX6UL
+    bool
+
+config NRF51_SOC
+    bool
+
+config MSF2
+    bool
+
+config ZAURUS
+    bool
+
+config A9MPCORE
+    bool
+
+config A15MPCORE
+    bool
+
+config ARM11MPCORE
+    bool
diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
new file mode 100644
index 0000000..207baee
--- /dev/null
+++ b/hw/audio/Kconfig
@@ -0,0 +1,35 @@
+config SB16
+    bool
+
+config ES1370
+    bool
+
+config AC97
+    bool
+
+config ADLIB
+    bool
+
+config GUS
+    bool
+
+config CS4231A
+    bool
+
+config HDA
+    bool
+
+config PCSPK
+    bool
+
+config WM8750
+    bool
+
+config PL041
+    bool
+
+config CS4231
+    bool
+
+config MARVELL_88W8618
+    bool
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
new file mode 100644
index 0000000..9d418bc
--- /dev/null
+++ b/hw/block/Kconfig
@@ -0,0 +1,29 @@
+config FDC
+    bool
+
+config SSI_M25P80
+    bool
+
+config NAND
+    bool
+
+config PFLASH_CFI01
+    bool
+
+config PFLASH_CFI02
+    bool
+
+config ECC
+    bool
+
+config ONENAND
+    bool
+
+config NVME_PCI
+    bool
+
+config VIRTIO_BLK
+    bool
+
+config VHOST_USER_BLK
+    bool
diff --git a/hw/bt/Kconfig b/hw/bt/Kconfig
new file mode 100644
index 0000000..554a9ee
--- /dev/null
+++ b/hw/bt/Kconfig
@@ -0,0 +1,2 @@
+config BLUETOOTH
+    bool
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
new file mode 100644
index 0000000..26c1324
--- /dev/null
+++ b/hw/char/Kconfig
@@ -0,0 +1,32 @@
+config ESCC
+    bool
+
+config PARALLEL
+    bool
+
+config PL011
+    bool
+
+config SERIAL
+    bool
+
+config SERIAL_ISA
+    bool
+
+config SERIAL_PCI
+    bool
+
+config VIRTIO_SERIAL
+    bool
+
+config STM32F2XX_USART
+    bool
+
+config CMSDK_APB_UART
+    bool
+
+config SCLPCONSOLE
+    bool
+
+config TERMINAL3270
+    bool
diff --git a/hw/core/Kconfig b/hw/core/Kconfig
new file mode 100644
index 0000000..c2a1ae8
--- /dev/null
+++ b/hw/core/Kconfig
@@ -0,0 +1,11 @@
+config EMPTY_SLOT
+    bool
+
+config PTIMER
+    bool
+
+config FITLOADER
+    bool
+
+config PLATFORM_BUS
+    bool
diff --git a/hw/cpu/Kconfig b/hw/cpu/Kconfig
new file mode 100644
index 0000000..1767d02
--- /dev/null
+++ b/hw/cpu/Kconfig
@@ -0,0 +1,8 @@
+config ARM11MPCORE
+    bool
+
+config A9MPCORE
+    bool
+
+config A15MPCORE
+    bool
diff --git a/hw/cris/Kconfig b/hw/cris/Kconfig
new file mode 100644
index 0000000..86954ab
--- /dev/null
+++ b/hw/cris/Kconfig
@@ -0,0 +1,5 @@
+config AXIS
+    bool
+
+config ETRAXFS
+   bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
new file mode 100644
index 0000000..d5c022c
--- /dev/null
+++ b/hw/display/Kconfig
@@ -0,0 +1,77 @@
+config EDID
+    bool
+
+config FW_CFG_DMA
+    bool
+
+config ADS7846
+    bool
+
+config VGA_CIRRUS
+    bool
+
+config G364FB
+    bool
+
+config JAZZ_LED
+    bool
+
+config PL110
+    bool
+
+config SII9022
+    bool
+
+config SSD0303
+    bool
+
+config SSD0323
+    bool
+
+config VGA_PCI
+    bool
+
+config VGA_ISA
+    bool
+
+config VGA_ISA_MM
+    bool
+
+config VMWARE_VGA
+    bool
+
+config BOCHS_DISPLAY
+    bool
+
+config BLIZZARD
+    bool
+
+config FRAMEBUFFER
+    bool
+
+config MILKYMIST_TMU2
+    bool
+
+config SM501
+    bool
+
+config TCX
+    bool
+
+config CG3
+    bool
+
+config VGA
+    bool
+
+config QXL
+    bool
+
+config VIRTIO_GPU
+    bool
+
+config VIRTIO_VGA
+    bool
+
+config DPCD
+    bool
diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
new file mode 100644
index 0000000..b9ce1c5
--- /dev/null
+++ b/hw/dma/Kconfig
@@ -0,0 +1,20 @@
+config RC4030
+    bool
+
+config PL080
+    bool
+
+config PL330
+    bool
+
+config I82374
+    bool
+
+config I8257
+    bool
+
+config ZYNQ_DEVCFG
+    bool
+
+config STP2000
+    bool
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
new file mode 100644
index 0000000..d0a4abf
--- /dev/null
+++ b/hw/gpio/Kconfig
@@ -0,0 +1,8 @@
+config MAX7310
+    bool
+
+config PL061
+    bool
+
+config GPIO_KEY
+    bool
diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
new file mode 100644
index 0000000..1be5915
--- /dev/null
+++ b/hw/hppa/Kconfig
@@ -0,0 +1,5 @@
+config HPPA
+    bool
+
+config DINO
+    bool
diff --git a/hw/hyperv/Kconfig b/hw/hyperv/Kconfig
new file mode 100644
index 0000000..be724b7
--- /dev/null
+++ b/hw/hyperv/Kconfig
@@ -0,0 +1,5 @@
+config HYPERV
+    bool
+
+config HYPERV_TESTDEV
+    bool
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
new file mode 100644
index 0000000..d6d4402
--- /dev/null
+++ b/hw/i2c/Kconfig
@@ -0,0 +1,20 @@
+config I2C
+    bool
+
+config SMBUS_EEPROM
+    bool
+
+config DDC
+    bool
+
+config VERSATILE_I2C
+    bool
+
+config ACPI_SMBUS
+    bool
+
+config BITBANG_I2C
+    bool
+
+config IMX_I2C
+    bool
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
new file mode 100644
index 0000000..2dbe2b5
--- /dev/null
+++ b/hw/i386/Kconfig
@@ -0,0 +1,23 @@
+config KVM
+    bool
+
+config I440FX
+    bool
+
+config ISAPC
+    bool
+
+config Q35
+    bool
+
+config VTD
+    bool
+
+config AMD_IOMMU
+    bool
+
+config VMPORT
+    bool
+
+config VMMOUSE
+    bool
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
new file mode 100644
index 0000000..5ec4495
--- /dev/null
+++ b/hw/ide/Kconfig
@@ -0,0 +1,35 @@
+config IDE_CORE
+    bool
+
+config IDE_QDEV
+    bool
+
+config IDE_PCI
+    bool
+
+config IDE_ISA
+    bool
+
+config IDE_PIIX
+    bool
+
+config IDE_CMD646
+    bool
+
+config IDE_MACIO
+    bool
+
+config IDE_MMIO
+    bool
+
+config IDE_VIA
+    bool
+
+config MICRODRIVE
+    bool
+
+config AHCI
+    bool
+
+config IDE_SII3112
+    bool
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
new file mode 100644
index 0000000..91bae47
--- /dev/null
+++ b/hw/input/Kconfig
@@ -0,0 +1,23 @@
+config ADB
+    bool
+
+config LM832X
+    bool
+
+config PCKBD
+    bool
+
+config PL050
+    bool
+
+config STELLARIS_INPUT
+    bool
+
+config TSC2005
+    bool
+
+config VIRTIO_INPUT
+    bool
+
+config TSC210X
+    bool
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
new file mode 100644
index 0000000..69adbd1
--- /dev/null
+++ b/hw/intc/Kconfig
@@ -0,0 +1,47 @@
+config HEATHROW_PIC
+    bool
+
+config I8259
+    bool
+
+config PL190
+    bool
+
+config IOAPIC
+    bool
+
+config ARM_GIC
+    bool
+
+config OPENPIC
+    bool
+
+config APIC
+    bool
+
+config ARM_GIC_KVM
+    bool
+
+config OPENPIC_KVM
+    bool
+
+config XICS
+    bool
+
+config XICS_SPAPR
+    bool
+
+config XICS_KVM
+    bool
+
+config ALLWINNER_A10_PIC
+    bool
+
+config S390_FLIC
+    bool
+
+config S390_FLIC_KVM
+    bool
+
+config OMPIC
+    bool
diff --git a/hw/ipack/Kconfig b/hw/ipack/Kconfig
new file mode 100644
index 0000000..481e0d2
--- /dev/null
+++ b/hw/ipack/Kconfig
@@ -0,0 +1,2 @@
+config IPACK
+    bool
diff --git a/hw/ipmi/Kconfig b/hw/ipmi/Kconfig
new file mode 100644
index 0000000..68f8ba1
--- /dev/null
+++ b/hw/ipmi/Kconfig
@@ -0,0 +1,14 @@
+config IPMI
+    bool
+
+config IPMI_LOCAL
+    bool
+
+config IPMI_EXTERN
+    bool
+
+config ISA_IPMI_KCS
+    bool
+
+config ISA_IPMI_BT
+    bool
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
new file mode 100644
index 0000000..b59d074
--- /dev/null
+++ b/hw/isa/Kconfig
@@ -0,0 +1,23 @@
+config ISA_BUS
+    bool
+
+config APM
+    bool
+
+config I82378
+    bool
+
+config PC87312
+    bool
+
+config PIIX4
+    bool
+
+config VT82C686
+    bool
+
+config SMC37C669
+    bool
+
+config LPC_ICH9
+    bool
diff --git a/hw/lm32/Kconfig b/hw/lm32/Kconfig
new file mode 100644
index 0000000..84c530e
--- /dev/null
+++ b/hw/lm32/Kconfig
@@ -0,0 +1,5 @@
+config LM32
+    bool
+
+config MILKYMIST
+    bool
diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
new file mode 100644
index 0000000..cd66ada
--- /dev/null
+++ b/hw/m68k/Kconfig
@@ -0,0 +1,8 @@
+config AN5206
+    bool
+
+config MCF5206
+    bool
+
+config MCF5208
+    bool
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
new file mode 100644
index 0000000..a3a4372
--- /dev/null
+++ b/hw/mem/Kconfig
@@ -0,0 +1,8 @@
+config DIMM
+    bool
+
+config MEM_DEVICE
+    bool
+
+config NVDIMM
+    bool
diff --git a/hw/microblaze/Kconfig b/hw/microblaze/Kconfig
new file mode 100644
index 0000000..44683b2
--- /dev/null
+++ b/hw/microblaze/Kconfig
@@ -0,0 +1,8 @@
+config PETALOGIX_S3ADSP1800
+    bool
+
+config PETALOGIX_ML605
+    bool
+
+config XLNX_ZYNQMP_PMU
+    bool
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
new file mode 100644
index 0000000..348c9bf
--- /dev/null
+++ b/hw/mips/Kconfig
@@ -0,0 +1,20 @@
+config R4K
+    bool
+
+config MALTA
+    bool
+
+config MIPSSIM
+    bool
+
+config JAZZ
+    bool
+
+config FULONG
+    bool
+
+config MIPS_CPS
+    bool
+
+config MIPS_BOSTON
+    bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
new file mode 100644
index 0000000..c006b04
--- /dev/null
+++ b/hw/misc/Kconfig
@@ -0,0 +1,92 @@
+config APPLESMC
+    bool
+
+config MAX111X
+    bool
+
+config TMP105
+    bool
+
+config TMP421
+    bool
+
+config ISA_DEBUG
+    bool
+
+config SGA
+    bool
+
+config ISA_TESTDEV
+    bool
+
+config PCI_TESTDEV
+    bool
+
+config EDU
+    bool
+
+config PCA9552
+    bool
+
+config PL310
+    bool
+
+config INTEGRATOR_DEBUG
+    bool
+
+config A9SCU
+    bool
+
+config ARM11SCU
+    bool
+
+config MOS6522
+    bool
+
+config MACIO
+    bool
+
+config IVSHMEM_DEVICE
+    bool
+
+config ECCMEMCTL
+    bool
+
+config IMX
+    bool
+
+config STM32F2XX_SYSCFG
+    bool
+
+config MIPS_ITU
+    bool
+
+config MPS2_FPGAIO
+    bool
+
+config MPS2_SCC
+    bool
+
+config TZ_MPC
+    bool
+
+config TZ_MSC
+    bool
+
+config TZ_PPC
+    bool
+
+config IOTKIT_SECCTL
+    bool
+
+config IOTKIT_SYSCTL
+    bool
+
+config IOTKIT_SYSINFO
+    bool
+
+config PVPANIC
+    bool
+
+config AUX
+    bool
diff --git a/hw/misc/macio/Kconfig b/hw/misc/macio/Kconfig
new file mode 100644
index 0000000..c6caeb6
--- /dev/null
+++ b/hw/misc/macio/Kconfig
@@ -0,0 +1,11 @@
+config CUDA
+    bool
+
+config MAC_PMU
+    bool
+
+config MAC_DBDMA
+    bool
+
+config MACIO_GPIO
+    bool
diff --git a/hw/moxie/Kconfig b/hw/moxie/Kconfig
new file mode 100644
index 0000000..52391bb
--- /dev/null
+++ b/hw/moxie/Kconfig
@@ -0,0 +1,2 @@
+config MOXIE
+    bool
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
new file mode 100644
index 0000000..d358b2c
--- /dev/null
+++ b/hw/net/Kconfig
@@ -0,0 +1,92 @@
+config DP8393X
+    bool
+
+config NE2000_PCI
+    bool
+
+config EEPRO100_PCI
+    bool
+
+config PCNET_PCI
+    bool
+
+config PCNET_COMMON
+    bool
+
+config E1000_PCI
+    bool
+
+config E1000E_PCI_EXPRESS
+    bool
+
+config RTL8139_PCI
+    bool
+
+config VMXNET3_PCI
+    bool
+
+config SMC91C111
+    bool
+
+config LAN9118
+    bool
+
+config NE2000_ISA
+    bool
+
+config OPENCORES_ETH
+    bool
+
+config XGMAC
+    bool
+
+config MIPSNET
+    bool
+
+config ALLWINNER_EMAC
+    bool
+
+config IMX_FEC
+    bool
+
+config CADENCE
+    bool
+
+config STELLARIS_ENET
+    bool
+
+config LANCE
+    bool
+
+config SUNHME
+    bool
+
+config FTGMAC100
+    bool
+
+config SUNGEM
+    bool
+
+config COLDFIRE
+    bool
+
+config XILINX_ETHLITE
+    bool
+
+config VIRTIO_NET
+   bool
+
+config ETSEC
+    bool
+
+config ROCKER
+    bool
+
+config CAN_BUS
+    bool
+
+config CAN_PCI
+    bool
+
+config CAN_SJA1000
+    bool
diff --git a/hw/nios2/Kconfig b/hw/nios2/Kconfig
new file mode 100644
index 0000000..22817e4
--- /dev/null
+++ b/hw/nios2/Kconfig
@@ -0,0 +1,5 @@
+config NIOS2_10M50
+    bool
+
+config NIOS2
+    bool
diff --git a/hw/nvram/Kconfig b/hw/nvram/Kconfig
new file mode 100644
index 0000000..1f5ec95
--- /dev/null
+++ b/hw/nvram/Kconfig
@@ -0,0 +1,8 @@
+config DS1225Y
+    bool
+
+config AT24C
+    bool
+
+config MAC_NVRAM
+    bool
diff --git a/hw/openrisc/Kconfig b/hw/openrisc/Kconfig
new file mode 100644
index 0000000..e0da4ac
--- /dev/null
+++ b/hw/openrisc/Kconfig
@@ -0,0 +1,2 @@
+config OPENRISC
+    bool
diff --git a/hw/pci-bridge/Kconfig b/hw/pci-bridge/Kconfig
new file mode 100644
index 0000000..bb19b7a
--- /dev/null
+++ b/hw/pci-bridge/Kconfig
@@ -0,0 +1,20 @@
+config PCIE_PORT
+    bool
+
+config PXB
+    bool
+
+config XIO3130
+    bool
+
+config IOH3420
+    bool
+
+config I82801B11
+    bool
+
+config DEC_PCI
+    bool
+
+config SIMBA
+    bool
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
new file mode 100644
index 0000000..2edc5bb
--- /dev/null
+++ b/hw/pci-host/Kconfig
@@ -0,0 +1,35 @@
+config PAM
+    bool
+
+config PREP_PCI
+    bool
+
+config GRACKLE_PCI
+    bool
+
+config UNIN_PCI
+    bool
+
+config PPCE500_PCI
+    bool
+
+config VERSATILE_PCI
+    bool
+
+config PCI_SABRE
+    bool
+
+config PCI_PIIX
+    bool
+
+config PCI_EXPRESS_Q35
+    bool
+
+config PCI_EXPRESS_GENERIC_BRIDGE
+    bool
+
+config PCI_EXPRESS_XILINX
+    bool
+
+config PCI_EXPRESS_DESIGNWARE
+    bool
diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
new file mode 100644
index 0000000..d3d2205
--- /dev/null
+++ b/hw/pci/Kconfig
@@ -0,0 +1,2 @@
+config PCI
+    bool
diff --git a/hw/pcmcia/Kconfig b/hw/pcmcia/Kconfig
new file mode 100644
index 0000000..41f2df9
--- /dev/null
+++ b/hw/pcmcia/Kconfig
@@ -0,0 +1,2 @@
+config PCMCIA
+    bool
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
new file mode 100644
index 0000000..9da9d7d
--- /dev/null
+++ b/hw/ppc/Kconfig
@@ -0,0 +1,56 @@
+config PSERIES
+    bool
+
+config SPAPR_RNG
+    bool
+
+config POWERNV
+    bool
+
+config PPC405
+    bool
+
+config PPC440
+    bool
+
+config PPC4XX
+    bool
+
+config SAM460EX
+    bool
+
+config PREP
+    bool
+
+config RS6000_MC
+    bool
+
+config MAC_OLDWORLD
+    bool
+
+config MAC_NEWWORLD
+    bool
+
+config E500
+    bool
+
+config VIRTEX
+    bool
+
+config MAC_DBDMA
+    bool
+
+config MAC_PMU
+    bool
+
+config XIVE
+    bool
+
+config MACIO_GPIO
+    bool
+
+config XIVE_SPAPR
+    bool
+
+config CUDA
+    bool
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
new file mode 100644
index 0000000..7603729
--- /dev/null
+++ b/hw/riscv/Kconfig
@@ -0,0 +1,19 @@
+config HTIF
+    bool
+
+config HART
+    bool
+
+config SIFIVE
+    bool
+
+config SIFIVE_E
+    bool
+
+config SIFIVE_U
+
+config SPIKE
+    bool
+
+config RISCV_VIRT
+    bool
diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
new file mode 100644
index 0000000..303db7f
--- /dev/null
+++ b/hw/s390x/Kconfig
@@ -0,0 +1,2 @@
+config S390_CCW_VIRTIO
+    bool
diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
new file mode 100644
index 0000000..eb78478
--- /dev/null
+++ b/hw/scsi/Kconfig
@@ -0,0 +1,26 @@
+config SCSI
+    bool
+
+config LSI_SCSI_PCI
+    bool
+
+config MPTSAS_SCSI_PCI
+    bool
+
+config MEGASAS_SCSI_PCI
+    bool
+
+config VMW_PVSCSI_SCSI_PCI
+    bool
+
+config ESP
+    bool
+
+config ESP_PCI
+    bool
+
+config VIRTIO_SCSI
+    bool
+
+config VHOST_USER_SCSI
+    bool
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
new file mode 100644
index 0000000..4f43bbb
--- /dev/null
+++ b/hw/sd/Kconfig
@@ -0,0 +1,11 @@
+config PL181
+    bool
+
+config SSI_SD
+    bool
+
+config SD
+    bool
+
+config SDHCI
+    bool
diff --git a/hw/sh4/Kconfig b/hw/sh4/Kconfig
new file mode 100644
index 0000000..417a72f
--- /dev/null
+++ b/hw/sh4/Kconfig
@@ -0,0 +1,11 @@
+config R2D
+    bool
+
+config SHIX
+    bool
+
+config SH7750
+    bool
+
+config SH4
+    bool
diff --git a/hw/smbios/Kconfig b/hw/smbios/Kconfig
new file mode 100644
index 0000000..553adf4
--- /dev/null
+++ b/hw/smbios/Kconfig
@@ -0,0 +1,2 @@
+config SMBIOS
+    bool
diff --git a/hw/sparc/Kconfig b/hw/sparc/Kconfig
new file mode 100644
index 0000000..3795754
--- /dev/null
+++ b/hw/sparc/Kconfig
@@ -0,0 +1,11 @@
+config SUN4M
+    bool
+
+config LEON3
+    bool
+
+config GRLIB
+    bool
+
+config SLAVIO
+    bool
diff --git a/hw/sparc64/Kconfig b/hw/sparc64/Kconfig
new file mode 100644
index 0000000..8c13345
--- /dev/null
+++ b/hw/sparc64/Kconfig
@@ -0,0 +1,5 @@
+config SUN4U
+    bool
+
+config NIAGARA
+    bool
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
new file mode 100644
index 0000000..5a03110
--- /dev/null
+++ b/hw/ssi/Kconfig
@@ -0,0 +1,14 @@
+config PL022
+    bool
+
+config SSI
+    bool
+
+config XILINX_SPI
+    bool
+
+config XILINX_SPIPS
+    bool
+
+config STM32F2XX_SPI
+    bool
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
new file mode 100644
index 0000000..7dbc121
--- /dev/null
+++ b/hw/timer/Kconfig
@@ -0,0 +1,53 @@
+config ARM_TIMER
+    bool
+
+config ARM_MPTIMER
+    bool
+
+config A9_GTIMER
+    bool
+
+config DS1338
+    bool
+
+config HPET
+    bool
+
+config I8254
+    bool
+
+config M41T80
+    bool
+
+config M48T59
+    bool
+
+config PL031
+    bool
+
+config TWL92230
+    bool
+
+config XLNX_ZYNQMP
+    bool
+
+config ALTERA_TIMER
+    bool
+
+config MC146818RTC
+    bool
+
+config ALLWINNER_A10_PIT
+    bool
+
+config STM32F2XX_TIMER
+    bool
+
+config SUN4V_RTC
+    bool
+
+config CMSDK_APB_TIMER
+    bool
+
+config CMSDK_APB_DUALTIMER
+    bool
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
new file mode 100644
index 0000000..2eee8eb
--- /dev/null
+++ b/hw/tpm/Kconfig
@@ -0,0 +1,14 @@
+config TPM
+    bool
+
+config TPM_TIS
+    bool
+
+config TPM_CRB
+    bool
+
+config TPM_PASSTHROUGH
+    bool
+
+config TPM_EMULATOR
+    bool
diff --git a/hw/tricore/Kconfig b/hw/tricore/Kconfig
new file mode 100644
index 0000000..9313409
--- /dev/null
+++ b/hw/tricore/Kconfig
@@ -0,0 +1,2 @@
+config TRICORE
+    bool
diff --git a/hw/unicore32/Kconfig b/hw/unicore32/Kconfig
new file mode 100644
index 0000000..b3cf294
--- /dev/null
+++ b/hw/unicore32/Kconfig
@@ -0,0 +1,2 @@
+config PUV3
+    bool
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
new file mode 100644
index 0000000..cbf5c5d
--- /dev/null
+++ b/hw/usb/Kconfig
@@ -0,0 +1,53 @@
+config USB
+    bool
+
+config USB_UHCI
+    bool
+
+config USB_OHCI
+    bool
+
+config USB_EHCI
+    bool
+
+config USB_EHCI_SYSBUS
+    bool
+
+config USB_XHCI
+    bool
+
+config USB_XHCI_NEC
+    bool
+
+config USB_MUSB
+    bool
+
+config TUSB6010
+    bool
+
+config USB_TABLET_WACOM
+    bool
+
+config USB_STORAGE_BOT
+    bool
+
+config USB_STORAGE_UAS
+    bool
+
+config USB_AUDIO
+    bool
+
+config USB_SERIAL
+    bool
+
+config USB_NETWORK
+    bool
+
+config USB_BLUETOOTH
+    bool
+
+config USB_SMARTCARD
+    bool
+
+config USB_STORAGE_MTP
+    bool
diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
new file mode 100644
index 0000000..31d8dfc
--- /dev/null
+++ b/hw/vfio/Kconfig
@@ -0,0 +1,23 @@
+config VFIO
+    bool
+
+config VFIO_PCI
+    bool
+
+config VFIO_SPAPR
+    bool
+
+config VFIO_CCW
+    bool
+
+config VFIO_PLATFORM
+    bool
+
+config VFIO_XGMAC
+    bool
+
+config VFIO_AMD_XGBE
+    bool
+
+config VFIO_AP
+    bool
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
new file mode 100644
index 0000000..ebf1812
--- /dev/null
+++ b/hw/virtio/Kconfig
@@ -0,0 +1,17 @@
+config VIRTIO
+    bool
+
+config VIRTIO_RNG
+    bool
+
+config VIRTIO_PCI
+    bool
+
+config VIRTIO_MMIO
+    bool
+
+config VIRTIO_BALLOON
+    bool
+
+config VIRTIO_CRYPTO
+    bool
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
new file mode 100644
index 0000000..cd0244f
--- /dev/null
+++ b/hw/watchdog/Kconfig
@@ -0,0 +1,11 @@
+config CMSDK_APB_WATCHDOG
+    bool
+
+config WDT_IB6300ESB
+    bool
+
+config WDT_IB700
+    bool
+
+config WDT_DIAG288
+    bool
diff --git a/hw/xtensa/Kconfig b/hw/xtensa/Kconfig
new file mode 100644
index 0000000..97543a9
--- /dev/null
+++ b/hw/xtensa/Kconfig
@@ -0,0 +1,5 @@
+config XTENSA_SIM
+    bool
+
+config XTENSA_FPGA
+    bool
diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 7fd1438..e26a0e4 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -13,6 +13,7 @@
 from __future__ import print_function
 import os
 import sys
+import re
 
 __all__ = [ 'KconfigParserError', 'KconfigData', 'KconfigParser' ]
 
@@ -336,6 +337,12 @@ class KconfigParser:
         self.get_token()
         self.parse_config()
 
+    def do_assignment(self, var, val):
+        if not var.startswith("CONFIG_"):
+            raise Error('assigned variable should start with CONFIG_')
+        var = self.data.do_var(var[7:])
+        self.data.do_assignment(var, val)
+
     # file management -----
 
     def error_path(self):
@@ -624,6 +631,28 @@ class KconfigParser:
         return None
 
 if __name__ == '__main__':
-    fname = len(sys.argv) > 1 and sys.argv[1] or 'Kconfig.test'
-    data = KconfigParser.parse(open(fname, 'r'))
-    print data.compute_config()
+    argv = sys.argv
+    if len(argv) == 1:
+        print ("%s: at least one argument is required" % argv[0], file=sys.stderr)
+        sys.exit(1)
+
+    data = KconfigData()
+    parser = KconfigParser(data)
+    for arg in argv[3:]:
+        m = re.match(r'^(CONFIG_[A-Z0-9_]+)=([yn]?)$', arg)
+        if m is not None:
+            name, value = m.groups()
+            parser.do_assignment(name, value == 'y')
+        else:
+            fp = open(arg, 'r')
+            parser.parse_file(fp)
+            fp.close()
+
+    config = data.compute_config()
+    for key in sorted(config.keys()):
+        print ('CONFIG_%s=%s' % (key, ('y' if config[key] else 'n')))
+
+    deps = open(argv[2], 'w')
+    for fname in data.previously_included:
+        print ('%s: %s' % (argv[1], fname), file=deps)
+    deps.close()
-- 
1.8.3.1
