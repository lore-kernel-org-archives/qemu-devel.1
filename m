Received: from eggs.gnu.org ([209.51.188.92]:40560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gkX9A-0000dE-FU
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:37:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gkX98-0003ge-CG
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:37:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:24485)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gkX98-0002nW-2B
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:37:30 -0500
Date: Fri, 18 Jan 2019 11:36:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190118113317-mutt-send-email-mst@kernel.org>
References: <20190118112410.3010-1-yang.zhong@intel.com>
	<20190118112410.3010-30-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118112410.3010-30-yang.zhong@intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH v3 29/43] build: convert pci.mak to
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com

On Fri, Jan 18, 2019 at 07:23:56PM +0800, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Instead of including the same list of devices for each target,
> set CONFIG_PCI to true, and make the devices default to present
> whenever PCI is available.
> 
> Done mostly with the following script:
> 
>   while read i; do
>      i=${i%=y}; i=${i#CONFIG_}
>      sed -i -e'/^config '$i'$/!b' -en \
>             -e'a\' -e'    default y\' -e'    depends on PCI' \
>           `grep -lw $i hw/*/Kconfig`
>   done < default-configs/pci.mak
> 
> followed by replacing a few "depends on" clauses with "select"
> whenever the symbol is not really related to PCI.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>


Pls CC me directly on pci patches.

> ---
>  default-configs/alpha-softmmu.mak       |  2 +-
>  default-configs/arm-softmmu.mak         |  2 +-
>  default-configs/hppa-softmmu.mak        |  2 +-
>  default-configs/i386-softmmu.mak        |  4 +--
>  default-configs/mips-softmmu-common.mak |  2 +-
>  default-configs/pci.mak                 | 48 -------------------------
>  default-configs/ppc-softmmu.mak         |  2 +-
>  default-configs/riscv32-softmmu.mak     |  3 +-
>  default-configs/riscv64-softmmu.mak     |  3 +-
>  default-configs/sh4-softmmu.mak         |  2 +-
>  default-configs/sh4eb-softmmu.mak       |  2 +-
>  default-configs/sparc64-softmmu.mak     |  2 +-
>  hw/audio/Kconfig                        |  6 ++++
>  hw/block/Kconfig                        |  2 ++
>  hw/char/Kconfig                         |  2 ++
>  hw/display/Kconfig                      | 15 +++++++-
>  hw/ide/Kconfig                          |  3 ++
>  hw/ipack/Kconfig                        |  2 ++
>  hw/misc/Kconfig                         |  4 +++
>  hw/net/Kconfig                          | 23 ++++++++++++
>  hw/pci-bridge/Kconfig                   |  4 +++
>  hw/pci-host/Kconfig                     |  4 +++
>  hw/scsi/Kconfig                         | 11 ++++++
>  hw/sd/Kconfig                           |  3 ++
>  hw/usb/Kconfig                          | 10 ++++++
>  hw/virtio/Kconfig                       |  3 ++
>  hw/watchdog/Kconfig                     |  2 ++
>  27 files changed, 104 insertions(+), 64 deletions(-)
>  delete mode 100644 default-configs/pci.mak
> 
> diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
> index 400dff3c1c..e583177e79 100644
> --- a/default-configs/alpha-softmmu.mak
> +++ b/default-configs/alpha-softmmu.mak
> @@ -1,7 +1,7 @@
>  # Default configuration for alpha-softmmu
>  
> -include pci.mak
>  include usb.mak
> +CONFIG_PCI=y
>  CONFIG_SERIAL=y
>  CONFIG_SERIAL_ISA=y
>  CONFIG_I82374=y
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 05e085a75f..8734c508ee 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -1,7 +1,7 @@
>  # Default configuration for arm-softmmu
>  
> -include pci.mak
>  include usb.mak
> +CONFIG_PCI=y
>  CONFIG_VGA=y
>  CONFIG_NAND=y
>  CONFIG_ECC=y
> diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
> index 846e9f0ba6..673ae5a7cf 100644
> --- a/default-configs/hppa-softmmu.mak
> +++ b/default-configs/hppa-softmmu.mak
> @@ -1,5 +1,5 @@
> -include pci.mak
>  include usb.mak
> +CONFIG_PCI=y
>  CONFIG_SERIAL=y
>  CONFIG_SERIAL_ISA=y
>  CONFIG_ISA_BUS=y
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index f71284516c..b868d1f4e6 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -1,11 +1,10 @@
>  # Default configuration for i386-softmmu
>  
> -include pci.mak
> +CONFIG_PCI=y
>  include sound.mak
>  include usb.mak
>  include hyperv.mak
>  CONFIG_VGA_ISA=y
> -CONFIG_VGA_CIRRUS=y
>  CONFIG_VMWARE_VGA=y
>  CONFIG_VMXNET3_PCI=y
>  CONFIG_VIRTIO_VGA=y
> @@ -52,7 +51,6 @@ CONFIG_MEM_DEVICE=y
>  CONFIG_DIMM=y
>  CONFIG_NVDIMM=y
>  CONFIG_ACPI_NVDIMM=y
> -CONFIG_PCIE_PORT=y
>  CONFIG_XIO3130=y
>  CONFIG_IOH3420=y
>  CONFIG_I82801B11=y
> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
> index 479fb4d900..ecb45276f3 100644
> --- a/default-configs/mips-softmmu-common.mak
> +++ b/default-configs/mips-softmmu-common.mak
> @@ -1,8 +1,8 @@
>  # Common mips*-softmmu CONFIG defines
>  
> -include pci.mak
>  include sound.mak
>  include usb.mak
> +CONFIG_PCI=y
>  CONFIG_ESP=y
>  CONFIG_SCSI=y
>  CONFIG_VGA_ISA=y
> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
> deleted file mode 100644
> index 553b1905de..0000000000
> --- a/default-configs/pci.mak
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -CONFIG_PCI=y
> -CONFIG_PCIE=y
> -# For now, CONFIG_IDE_CORE requires ISA, so we enable it here
> -CONFIG_ISA_BUS=y
> -CONFIG_VIRTIO_PCI=y
> -include virtio.mak
> -CONFIG_USB_UHCI=y
> -CONFIG_USB_OHCI=y
> -CONFIG_USB_EHCI=y
> -CONFIG_USB_XHCI=y
> -CONFIG_USB_XHCI_NEC=y
> -CONFIG_NE2000_PCI=y
> -CONFIG_EEPRO100_PCI=y
> -CONFIG_PCNET_PCI=y
> -CONFIG_PCNET_COMMON=y
> -CONFIG_AC97=y
> -CONFIG_HDA=y
> -CONFIG_ES1370=y
> -CONFIG_SCSI=y
> -CONFIG_LSI_SCSI_PCI=y
> -CONFIG_VMW_PVSCSI_SCSI_PCI=y
> -CONFIG_MEGASAS_SCSI_PCI=y
> -CONFIG_MPTSAS_SCSI_PCI=y
> -CONFIG_RTL8139_PCI=y
> -CONFIG_E1000_PCI=y
> -CONFIG_E1000E_PCI=y
> -CONFIG_AHCI=y
> -CONFIG_ESP=y
> -CONFIG_ESP_PCI=y
> -CONFIG_SERIAL=y
> -CONFIG_SERIAL_ISA=y
> -CONFIG_SERIAL_PCI=y
> -CONFIG_CAN_BUS=y
> -CONFIG_CAN_SJA1000=y
> -CONFIG_CAN_PCI=y
> -CONFIG_IPACK=y
> -CONFIG_WDT_IB6300ESB=y
> -CONFIG_PCI_TESTDEV=y
> -CONFIG_NVME_PCI=y
> -CONFIG_SD=y
> -CONFIG_SDHCI=y
> -CONFIG_EDU=y
> -CONFIG_VGA=y
> -CONFIG_VGA_PCI=y
> -CONFIG_BOCHS_DISPLAY=y
> -CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
> -CONFIG_ROCKER=y
> -CONFIG_EDID=y
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
> index 7f80f0ccba..2d69adfabd 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -1,8 +1,8 @@
>  # Default configuration for ppc-softmmu
>  
> -include pci.mak
>  include sound.mak
>  include usb.mak
> +CONFIG_PCI=y
>  
>  # For embedded PPCs:
>  CONFIG_PPC4XX=y
> diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
> index 2dccd512d2..d45f01bdcf 100644
> --- a/default-configs/riscv32-softmmu.mak
> +++ b/default-configs/riscv32-softmmu.mak
> @@ -1,8 +1,7 @@
>  # Default configuration for riscv-softmmu
>  
> -include pci.mak
>  include usb.mak
> -
> +CONFIG_PCI=y
>  CONFIG_SERIAL=y
>  CONFIG_VIRTIO_MMIO=y
>  
> diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
> index 2dccd512d2..d45f01bdcf 100644
> --- a/default-configs/riscv64-softmmu.mak
> +++ b/default-configs/riscv64-softmmu.mak
> @@ -1,8 +1,7 @@
>  # Default configuration for riscv-softmmu
>  
> -include pci.mak
>  include usb.mak
> -
> +CONFIG_PCI=y
>  CONFIG_SERIAL=y
>  CONFIG_VIRTIO_MMIO=y
>  
> diff --git a/default-configs/sh4-softmmu.mak b/default-configs/sh4-softmmu.mak
> index 1fdb009151..8382504d11 100644
> --- a/default-configs/sh4-softmmu.mak
> +++ b/default-configs/sh4-softmmu.mak
> @@ -1,7 +1,7 @@
>  # Default configuration for sh4-softmmu
>  
> -include pci.mak
>  include usb.mak
> +CONFIG_PCI=y
>  CONFIG_SERIAL=y
>  CONFIG_SERIAL_ISA=y
>  CONFIG_PTIMER=y
> diff --git a/default-configs/sh4eb-softmmu.mak b/default-configs/sh4eb-softmmu.mak
> index 3b550a5fe8..a77e1538e9 100644
> --- a/default-configs/sh4eb-softmmu.mak
> +++ b/default-configs/sh4eb-softmmu.mak
> @@ -1,7 +1,7 @@
>  # Default configuration for sh4eb-softmmu
>  
> -include pci.mak
>  include usb.mak
> +CONFIG_PCI=y
>  CONFIG_SERIAL=y
>  CONFIG_SERIAL_ISA=y
>  CONFIG_PTIMER=y
> diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
> index 1fae4888db..db393d9eb3 100644
> --- a/default-configs/sparc64-softmmu.mak
> +++ b/default-configs/sparc64-softmmu.mak
> @@ -1,7 +1,7 @@
>  # Default configuration for sparc64-softmmu
>  
> -include pci.mak
>  include usb.mak
> +CONFIG_PCI=y
>  CONFIG_M48T59=y
>  CONFIG_PTIMER=y
>  CONFIG_SERIAL=y
> diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
> index 207baee6e1..af34bbcf0c 100644
> --- a/hw/audio/Kconfig
> +++ b/hw/audio/Kconfig
> @@ -3,9 +3,13 @@ config SB16
>  
>  config ES1370
>      bool
> +    default y
> +    depends on PCI
>  
>  config AC97
>      bool
> +    default y
> +    depends on PCI
>  
>  config ADLIB
>      bool
> @@ -18,6 +22,8 @@ config CS4231A
>  
>  config HDA
>      bool
> +    default y
> +    depends on PCI
>  
>  config PCSPK
>      bool
> diff --git a/hw/block/Kconfig b/hw/block/Kconfig
> index 9d418bce4d..3710434436 100644
> --- a/hw/block/Kconfig
> +++ b/hw/block/Kconfig
> @@ -21,6 +21,8 @@ config ONENAND
>  
>  config NVME_PCI
>      bool
> +    default y
> +    depends on PCI
>  
>  config VIRTIO_BLK
>      bool
> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> index 26c13243cf..1ed6f0dbce 100644
> --- a/hw/char/Kconfig
> +++ b/hw/char/Kconfig
> @@ -15,6 +15,8 @@ config SERIAL_ISA
>  
>  config SERIAL_PCI
>      bool
> +    default y
> +    depends on PCI
>  
>  config VIRTIO_SERIAL
>      bool
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 132aeffdbe..6bcfc10bcb 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -9,6 +9,9 @@ config ADS7846
>  
>  config VGA_CIRRUS
>      bool
> +    default y
> +    depends on PCI
> +    select VGA
>  
>  config G364FB
>      bool
> @@ -30,6 +33,9 @@ config SSD0323
>  
>  config VGA_PCI
>      bool
> +    default y
> +    depends on PCI
> +    select VGA
>  
>  config VGA_ISA
>      bool
> @@ -39,9 +45,15 @@ config VGA_ISA_MM
>  
>  config VMWARE_VGA
>      bool
> +    default y
> +    depends on PCI
> +    select VGA
>  
>  config BOCHS_DISPLAY
>      bool
> +    default y
> +    depends on PCI
> +    select VGA
>  
>  config BLIZZARD
>      bool
> @@ -67,7 +79,8 @@ config VGA
>  
>  config QXL
>      bool
> -    depends on SPICE
> +    depends on SPICE && PCI
> +    select VGA
>  
>  config VIRTIO_GPU
>      bool
> diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
> index fe27705790..3778580df2 100644
> --- a/hw/ide/Kconfig
> +++ b/hw/ide/Kconfig
> @@ -7,6 +7,7 @@ config IDE_QDEV
>  
>  config IDE_PCI
>      bool
> +    depends on PCI
>      select IDE_CORE
>  
>  config IDE_ISA
> @@ -42,6 +43,8 @@ config MICRODRIVE
>  
>  config AHCI
>      bool
> +    default y
> +    depends on PCI
>      select IDE_QDEV
>  
>  config IDE_SII3112
> diff --git a/hw/ipack/Kconfig b/hw/ipack/Kconfig
> index 481e0d2e64..98bd21cf0f 100644
> --- a/hw/ipack/Kconfig
> +++ b/hw/ipack/Kconfig
> @@ -1,2 +1,4 @@
>  config IPACK
>      bool
> +    default y
> +    depends on PCI
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index cc8dbed24e..1ca4b2464e 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -21,9 +21,13 @@ config ISA_TESTDEV
>  
>  config PCI_TESTDEV
>      bool
> +    default y
> +    depends on PCI
>  
>  config EDU
>      bool
> +    default y
> +    depends on PCI
>  
>  config PCA9552
>      bool
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index 6b2ec971b5..35204260fa 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -3,27 +3,42 @@ config DP8393X
>  
>  config NE2000_PCI
>      bool
> +    default y
> +    depends on PCI
>  
>  config EEPRO100_PCI
>      bool
> +    default y
> +    depends on PCI
>  
>  config PCNET_PCI
>      bool
> +    default y
> +    depends on PCI
> +    select PCNET_COMMON
>  
>  config PCNET_COMMON
>      bool
>  
>  config E1000_PCI
>      bool
> +    default y
> +    depends on PCI
>  
>  config E1000E_PCI
>      bool
> +    default y
> +    depends on PCIE
>  
>  config RTL8139_PCI
>      bool
> +    default y
> +    depends on PCI
>  
>  config VMXNET3_PCI
>      bool
> +    default y
> +    depends on PCI
>  
>  config SMC91C111
>      bool
> @@ -81,12 +96,20 @@ config ETSEC
>  
>  config ROCKER
>      bool
> +    default y
> +    depends on PCI
>  
>  config CAN_BUS
>      bool
>  
>  config CAN_PCI
>      bool
> +    default y
> +    depends on PCI
> +    select CAN_BUS
>  
>  config CAN_SJA1000
>      bool
> +    default y
> +    depends on PCI
> +    select CAN_BUS
> diff --git a/hw/pci-bridge/Kconfig b/hw/pci-bridge/Kconfig
> index bb19b7aac1..d54d878023 100644
> --- a/hw/pci-bridge/Kconfig
> +++ b/hw/pci-bridge/Kconfig
> @@ -1,14 +1,18 @@
>  config PCIE_PORT
>      bool
> +    default y
> +    depends on PCIE
>  
>  config PXB
>      bool
>  
>  config XIO3130
>      bool
> +    depends on PCIE
>  
>  config IOH3420
>      bool
> +    depends on PCIE
>  
>  config I82801B11
>      bool
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index 359df1d239..20c3de37a3 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -24,12 +24,16 @@ config PCI_PIIX
>  
>  config PCI_Q35
>      bool
> +    select PCIE

ok...

>  config PCI_GENERIC
>      bool
> +    select PCIE
>


why is this?
  
>  config PCI_XILINX
>      bool
> +    select PCIE
>  
>  config PCI_DESIGNWARE
>      bool
> +    select PCIE


sure about the above?

> diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
> index eb78478ef0..812a12522b 100644
> --- a/hw/scsi/Kconfig
> +++ b/hw/scsi/Kconfig
> @@ -3,21 +3,32 @@ config SCSI
>  
>  config LSI_SCSI_PCI
>      bool
> +    default y
> +    depends on PCI
>  
>  config MPTSAS_SCSI_PCI
>      bool
> +    default y
> +    depends on PCI
>  
>  config MEGASAS_SCSI_PCI
>      bool
> +    default y
> +    depends on PCI
>  
>  config VMW_PVSCSI_SCSI_PCI
>      bool
> +    default y
> +    depends on PCI
>  
>  config ESP
>      bool
>  
>  config ESP_PCI
>      bool
> +    default y
> +    depends on PCI
> +    select ESP
>  
>  config VIRTIO_SCSI
>      bool
> diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
> index 4f43bbb352..90ac74950a 100644
> --- a/hw/sd/Kconfig
> +++ b/hw/sd/Kconfig
> @@ -9,3 +9,6 @@ config SD
>  
>  config SDHCI
>      bool
> +    default y
> +    depends on PCI
> +    select SD
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index cbf5c5d761..f23c542d27 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -3,21 +3,31 @@ config USB
>  
>  config USB_UHCI
>      bool
> +    default y
> +    depends on PCI
>  
>  config USB_OHCI
>      bool
> +    default y
> +    depends on PCI
>  
>  config USB_EHCI
>      bool
> +    default y
> +    depends on PCI
>  
>  config USB_EHCI_SYSBUS
>      bool
>  
>  config USB_XHCI
>      bool
> +    default y
> +    depends on PCI
>  
>  config USB_XHCI_NEC
>      bool
> +    default y
> +    depends on PCI
>  
>  config USB_MUSB
>      bool
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index ebf18124fb..aabd6d4d96 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -6,6 +6,9 @@ config VIRTIO_RNG
>  
>  config VIRTIO_PCI
>      bool
> +    default y
> +    depends on PCI
> +    select VIRTIO
>  
>  config VIRTIO_MMIO
>      bool
> diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
> index cd0244f4e1..4e24bf8240 100644
> --- a/hw/watchdog/Kconfig
> +++ b/hw/watchdog/Kconfig
> @@ -3,6 +3,8 @@ config CMSDK_APB_WATCHDOG
>  
>  config WDT_IB6300ESB
>      bool
> +    default y
> +    depends on PCI
>  
>  config WDT_IB700
>      bool
> -- 
> 2.17.1
> 
