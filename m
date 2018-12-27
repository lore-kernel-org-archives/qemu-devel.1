Received: from eggs.gnu.org ([208.118.235.92]:54816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGd-0003F4-4j
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPGN-0004LB-Ki
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:57867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gcPGN-0004Bd-6S
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:35:23 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 27 Dec 2018 14:34:01 +0800
Message-Id: <20181227063419.12981-8-yang.zhong@intel.com>
In-Reply-To: <20181227063419.12981-1-yang.zhong@intel.com>
References: <20181227063419.12981-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH 07/25] kconfig: introduce kconfig files
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
---
 Kconfig.host          | 17 ++++++++
 hw/9pfs/Kconfig       |  2 +
 hw/Kconfig            | 48 ++++++++++++++++++++++
 hw/acpi/Kconfig       | 23 +++++++++++
 hw/adc/Kconfig        |  2 +
 hw/audio/Kconfig      | 35 ++++++++++++++++
 hw/block/Kconfig      | 29 ++++++++++++++
 hw/bt/Kconfig         |  2 +
 hw/char/Kconfig       | 32 +++++++++++++++
 hw/core/Kconfig       | 11 ++++++
 hw/cpu/Kconfig        |  8 ++++
 hw/display/Kconfig    | 77 ++++++++++++++++++++++++++++++++++++
 hw/dma/Kconfig        | 20 ++++++++++
 hw/gpio/Kconfig       |  8 ++++
 hw/hyperv/Kconfig     |  5 +++
 hw/i2c/Kconfig        | 20 ++++++++++
 hw/i386/Kconfig       | 23 +++++++++++
 hw/ide/Kconfig        | 35 ++++++++++++++++
 hw/input/Kconfig      | 23 +++++++++++
 hw/intc/Kconfig       | 47 ++++++++++++++++++++++
 hw/ipack/Kconfig      |  2 +
 hw/ipmi/Kconfig       | 14 +++++++
 hw/isa/Kconfig        | 23 +++++++++++
 hw/mem/Kconfig        |  8 ++++
 hw/misc/Kconfig       | 92 +++++++++++++++++++++++++++++++++++++++++++
 hw/misc/macio/Kconfig | 11 ++++++
 hw/net/Kconfig        | 92 +++++++++++++++++++++++++++++++++++++++++++
 hw/nvram/Kconfig      |  8 ++++
 hw/pci-bridge/Kconfig | 20 ++++++++++
 hw/pci-host/Kconfig   | 35 ++++++++++++++++
 hw/pci/Kconfig        |  2 +
 hw/pcmcia/Kconfig     |  2 +
 hw/scsi/Kconfig       | 29 ++++++++++++++
 hw/sd/Kconfig         | 11 ++++++
 hw/smbios/Kconfig     |  2 +
 hw/ssi/Kconfig        | 14 +++++++
 hw/timer/Kconfig      | 53 +++++++++++++++++++++++++
 hw/tpm/Kconfig        | 14 +++++++
 hw/usb/Kconfig        | 53 +++++++++++++++++++++++++
 hw/vfio/Kconfig       | 11 ++++++
 hw/virtio/Kconfig     | 17 ++++++++
 hw/watchdog/Kconfig   | 11 ++++++
 42 files changed, 991 insertions(+)
 create mode 100644 Kconfig.host
 create mode 100644 hw/9pfs/Kconfig
 create mode 100644 hw/Kconfig
 create mode 100644 hw/acpi/Kconfig
 create mode 100644 hw/adc/Kconfig
 create mode 100644 hw/audio/Kconfig
 create mode 100644 hw/block/Kconfig
 create mode 100644 hw/bt/Kconfig
 create mode 100644 hw/char/Kconfig
 create mode 100644 hw/core/Kconfig
 create mode 100644 hw/cpu/Kconfig
 create mode 100644 hw/display/Kconfig
 create mode 100644 hw/dma/Kconfig
 create mode 100644 hw/gpio/Kconfig
 create mode 100644 hw/hyperv/Kconfig
 create mode 100644 hw/i2c/Kconfig
 create mode 100644 hw/i386/Kconfig
 create mode 100644 hw/ide/Kconfig
 create mode 100644 hw/input/Kconfig
 create mode 100644 hw/intc/Kconfig
 create mode 100644 hw/ipack/Kconfig
 create mode 100644 hw/ipmi/Kconfig
 create mode 100644 hw/isa/Kconfig
 create mode 100644 hw/mem/Kconfig
 create mode 100644 hw/misc/Kconfig
 create mode 100644 hw/misc/macio/Kconfig
 create mode 100644 hw/net/Kconfig
 create mode 100644 hw/nvram/Kconfig
 create mode 100644 hw/pci-bridge/Kconfig
 create mode 100644 hw/pci-host/Kconfig
 create mode 100644 hw/pci/Kconfig
 create mode 100644 hw/pcmcia/Kconfig
 create mode 100644 hw/scsi/Kconfig
 create mode 100644 hw/sd/Kconfig
 create mode 100644 hw/smbios/Kconfig
 create mode 100644 hw/ssi/Kconfig
 create mode 100644 hw/timer/Kconfig
 create mode 100644 hw/tpm/Kconfig
 create mode 100644 hw/usb/Kconfig
 create mode 100644 hw/vfio/Kconfig
 create mode 100644 hw/virtio/Kconfig
 create mode 100644 hw/watchdog/Kconfig

diff --git a/Kconfig.host b/Kconfig.host
new file mode 100644
index 0000000000..2136a4c3ec
--- /dev/null
+++ b/Kconfig.host
@@ -0,0 +1,17 @@
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
diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
new file mode 100644
index 0000000000..a4750999d9
--- /dev/null
+++ b/hw/9pfs/Kconfig
@@ -0,0 +1,2 @@
+config VIRTIO_9P
+    bool
diff --git a/hw/Kconfig b/hw/Kconfig
new file mode 100644
index 0000000000..b27290d332
--- /dev/null
+++ b/hw/Kconfig
@@ -0,0 +1,48 @@
+# devices Kconfig
+source 9pfs/Kconfig
+source acpi/Kconfig
+source audio/Kconfig
+source block/Kconfig
+source bt/Kconfig
+source char/Kconfig
+source core/Kconfig
+source display/Kconfig
+source dma/Kconfig
+source gpio/Kconfig
+source i2c/Kconfig
+source ide/Kconfig
+source input/Kconfig
+source intc/Kconfig
+source ipack/Kconfig
+source isa/Kconfig
+source mem/Kconfig
+source misc/Kconfig
+source net/Kconfig
+source nvram/Kconfig
+source pci-bridge/Kconfig
+source pci-host/Kconfig
+source pci/Kconfig
+source scsi/Kconfig
+source sd/Kconfig
+source ssi/Kconfig
+source timer/Kconfig
+source tpm/Kconfig
+source usb/Kconfig
+source virtio/Kconfig
+source watchdog/Kconfig
+source smbios/Kconfig
+source ipmi/Kconfig
+source vfio/Kconfig
+source adc/Kconfig
+source pcmcia/Kconfig
+source hyperv/Kconfig
+
+# arch Kconfig
+source i386/Kconfig
+
+# Symbols used by multiple targets
+config XILINX
+    bool
+
+config XILINX_AXI
+    bool
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
new file mode 100644
index 0000000000..2f4871c10a
--- /dev/null
+++ b/hw/acpi/Kconfig
@@ -0,0 +1,23 @@
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
+
+config IPMI
+    bool
diff --git a/hw/adc/Kconfig b/hw/adc/Kconfig
new file mode 100644
index 0000000000..25d2229fb8
--- /dev/null
+++ b/hw/adc/Kconfig
@@ -0,0 +1,2 @@
+config STM32F2XX_ADC
+    bool
diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
new file mode 100644
index 0000000000..207baee6e1
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
index 0000000000..9d418bce4d
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
index 0000000000..554a9ee75e
--- /dev/null
+++ b/hw/bt/Kconfig
@@ -0,0 +1,2 @@
+config BLUETOOTH
+    bool
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
new file mode 100644
index 0000000000..26c13243cf
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
index 0000000000..c2a1ae8122
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
index 0000000000..1767d028ac
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
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
new file mode 100644
index 0000000000..d5c022c886
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
index 0000000000..b9ce1c58c4
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
index 0000000000..d0a4abf93f
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
diff --git a/hw/hyperv/Kconfig b/hw/hyperv/Kconfig
new file mode 100644
index 0000000000..be724b7f8b
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
index 0000000000..d6d4402608
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
index 0000000000..2dbe2b5d3e
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
index 0000000000..5ec449525f
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
index 0000000000..91bae47498
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
index 0000000000..69adbd135f
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
index 0000000000..481e0d2e64
--- /dev/null
+++ b/hw/ipack/Kconfig
@@ -0,0 +1,2 @@
+config IPACK
+    bool
diff --git a/hw/ipmi/Kconfig b/hw/ipmi/Kconfig
new file mode 100644
index 0000000000..68f8ba1a54
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
index 0000000000..b59d074453
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
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
new file mode 100644
index 0000000000..a3a4372fa7
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
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
new file mode 100644
index 0000000000..c006b046d4
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
index 0000000000..c6caeb672f
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
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
new file mode 100644
index 0000000000..6b2ec971b5
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
+config E1000E_PCI
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
diff --git a/hw/nvram/Kconfig b/hw/nvram/Kconfig
new file mode 100644
index 0000000000..1f5ec95d8b
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
diff --git a/hw/pci-bridge/Kconfig b/hw/pci-bridge/Kconfig
new file mode 100644
index 0000000000..bb19b7aac1
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
index 0000000000..359df1d239
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
+config PCI_Q35
+    bool
+
+config PCI_GENERIC
+    bool
+
+config PCI_XILINX
+    bool
+
+config PCI_DESIGNWARE
+    bool
diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
new file mode 100644
index 0000000000..d3d2205577
--- /dev/null
+++ b/hw/pci/Kconfig
@@ -0,0 +1,2 @@
+config PCI
+    bool
diff --git a/hw/pcmcia/Kconfig b/hw/pcmcia/Kconfig
new file mode 100644
index 0000000000..41f2df9136
--- /dev/null
+++ b/hw/pcmcia/Kconfig
@@ -0,0 +1,2 @@
+config PCMCIA
+    bool
diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
new file mode 100644
index 0000000000..c48bf4e8d0
--- /dev/null
+++ b/hw/scsi/Kconfig
@@ -0,0 +1,29 @@
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
+config PSERIES
+    bool
+
+config VIRTIO_SCSI
+    bool
+
+config VHOST_USER_SCSI
+    bool
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
new file mode 100644
index 0000000000..4f43bbb352
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
diff --git a/hw/smbios/Kconfig b/hw/smbios/Kconfig
new file mode 100644
index 0000000000..553adf4bfc
--- /dev/null
+++ b/hw/smbios/Kconfig
@@ -0,0 +1,2 @@
+config SMBIOS
+    bool
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
new file mode 100644
index 0000000000..5a03110a8d
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
index 0000000000..7dbc1211ab
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
index 0000000000..2eee8eb865
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
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
new file mode 100644
index 0000000000..cbf5c5d761
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
index 0000000000..3cb7b25fe6
--- /dev/null
+++ b/hw/vfio/Kconfig
@@ -0,0 +1,11 @@
+config VFIO_CCW
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
index 0000000000..ebf18124fb
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
index 0000000000..cd0244f4e1
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
-- 
2.17.1
