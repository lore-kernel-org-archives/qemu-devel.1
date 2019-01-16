Received: from eggs.gnu.org ([209.51.188.92]:33120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjigE-0006ak-Rm
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjigD-0006wc-HY
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:44:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjigD-0006rG-0O
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:44:17 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-20-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8c5e79dd-b177-44fb-4a3d-7aa55216d13d@redhat.com>
Date: Wed, 16 Jan 2019 11:44:13 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-20-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 19/37] kconfig: introduce kconfig
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com

On 2019-01-15 15:10, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> The Kconfig files were generated mostly with this script:
> 
>   for i in `grep -ho CONFIG_[A-Z0-9_]* default-configs/* | sort -u`; do
>     set fnord `git grep -lw $i -- 'hw/*/Makefile.objs' `
>     shift
>     if test $# = 1; then
>       cat >> $(dirname $1)/Kconfig << EOF
> config ${i#CONFIG_}
>     bool
> 
> EOF
>       git add $(dirname $1)/Kconfig
>     else
>       echo $i $*
>     fi
>   done
>   sed -i '$d' hw/*/Kconfig
>   for i in hw/*; do
>     if test -d $i && ! test -f $i/Kconfig; then
>       touch $i/Kconfig
>       git add $i/Kconfig
>     fi
>   done
> 
> Whenever a symbol is referenced from multiple subdirectories, the
> script prints the list of directories that reference the symbol.
> These symbols have to be added manually to the Kconfig files.
> 
> Kconfig.host and hw/Kconfig were created manually.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  Kconfig.host          | 17 ++++++++
>  hw/9pfs/Kconfig       |  2 +
>  hw/Kconfig            | 60 ++++++++++++++++++++++++++
>  hw/acpi/Kconfig       | 23 ++++++++++
>  hw/adc/Kconfig        |  2 +
>  hw/arm/Kconfig        | 98 +++++++++++++++++++++++++++++++++++++++++++
>  hw/audio/Kconfig      | 35 ++++++++++++++++
>  hw/block/Kconfig      | 29 +++++++++++++
>  hw/bt/Kconfig         |  2 +
>  hw/char/Kconfig       | 32 ++++++++++++++
>  hw/core/Kconfig       | 11 +++++
>  hw/cpu/Kconfig        |  8 ++++
>  hw/display/Kconfig    | 77 ++++++++++++++++++++++++++++++++++
>  hw/dma/Kconfig        | 20 +++++++++
>  hw/gpio/Kconfig       |  8 ++++
>  hw/hyperv/Kconfig     |  5 +++
>  hw/i2c/Kconfig        | 20 +++++++++
>  hw/i386/Kconfig       | 23 ++++++++++
>  hw/ide/Kconfig        | 35 ++++++++++++++++
>  hw/input/Kconfig      | 23 ++++++++++
>  hw/intc/Kconfig       | 47 +++++++++++++++++++++
>  hw/ipack/Kconfig      |  2 +
>  hw/ipmi/Kconfig       | 14 +++++++
>  hw/isa/Kconfig        | 23 ++++++++++
>  hw/lm32/Kconfig       |  5 +++
>  hw/m68k/Kconfig       |  8 ++++
>  hw/mem/Kconfig        |  8 ++++
>  hw/microblaze/Kconfig |  8 ++++
>  hw/mips/Kconfig       | 20 +++++++++
>  hw/misc/Kconfig       | 92 ++++++++++++++++++++++++++++++++++++++++
>  hw/misc/macio/Kconfig | 11 +++++
>  hw/net/Kconfig        | 92 ++++++++++++++++++++++++++++++++++++++++
>  hw/nios2/Kconfig      |  2 +
>  hw/nvram/Kconfig      |  8 ++++
>  hw/pci-bridge/Kconfig | 20 +++++++++
>  hw/pci-host/Kconfig   | 35 ++++++++++++++++
>  hw/pci/Kconfig        |  2 +
>  hw/pcmcia/Kconfig     |  2 +
>  hw/ppc/Kconfig        | 38 +++++++++++++++++
>  hw/riscv/Kconfig      | 14 +++++++
>  hw/scsi/Kconfig       | 26 ++++++++++++
>  hw/sd/Kconfig         | 11 +++++
>  hw/sh4/Kconfig        |  8 ++++
>  hw/smbios/Kconfig     |  2 +
>  hw/sparc/Kconfig      |  5 +++
>  hw/sparc64/Kconfig    |  5 +++
>  hw/ssi/Kconfig        | 14 +++++++
>  hw/timer/Kconfig      | 53 +++++++++++++++++++++++
>  hw/tpm/Kconfig        | 14 +++++++
>  hw/usb/Kconfig        | 53 +++++++++++++++++++++++
>  hw/vfio/Kconfig       | 11 +++++
>  hw/virtio/Kconfig     | 17 ++++++++
>  hw/watchdog/Kconfig   | 11 +++++
>  hw/xtensa/Kconfig     |  5 +++
>  54 files changed, 1216 insertions(+)
>  create mode 100644 Kconfig.host
>  create mode 100644 hw/9pfs/Kconfig
>  create mode 100644 hw/Kconfig
>  create mode 100644 hw/acpi/Kconfig
>  create mode 100644 hw/adc/Kconfig
>  create mode 100644 hw/arm/Kconfig
>  create mode 100644 hw/audio/Kconfig
>  create mode 100644 hw/block/Kconfig
>  create mode 100644 hw/bt/Kconfig
>  create mode 100644 hw/char/Kconfig
>  create mode 100644 hw/core/Kconfig
>  create mode 100644 hw/cpu/Kconfig
>  create mode 100644 hw/display/Kconfig
>  create mode 100644 hw/dma/Kconfig
>  create mode 100644 hw/gpio/Kconfig
>  create mode 100644 hw/hyperv/Kconfig
>  create mode 100644 hw/i2c/Kconfig
>  create mode 100644 hw/i386/Kconfig
>  create mode 100644 hw/ide/Kconfig
>  create mode 100644 hw/input/Kconfig
>  create mode 100644 hw/intc/Kconfig
>  create mode 100644 hw/ipack/Kconfig
>  create mode 100644 hw/ipmi/Kconfig
>  create mode 100644 hw/isa/Kconfig
>  create mode 100644 hw/lm32/Kconfig
>  create mode 100644 hw/m68k/Kconfig
>  create mode 100644 hw/mem/Kconfig
>  create mode 100644 hw/microblaze/Kconfig
>  create mode 100644 hw/mips/Kconfig
>  create mode 100644 hw/misc/Kconfig
>  create mode 100644 hw/misc/macio/Kconfig
>  create mode 100644 hw/net/Kconfig
>  create mode 100644 hw/nios2/Kconfig
>  create mode 100644 hw/nvram/Kconfig
>  create mode 100644 hw/pci-bridge/Kconfig
>  create mode 100644 hw/pci-host/Kconfig
>  create mode 100644 hw/pci/Kconfig
>  create mode 100644 hw/pcmcia/Kconfig
>  create mode 100644 hw/ppc/Kconfig
>  create mode 100644 hw/riscv/Kconfig
>  create mode 100644 hw/scsi/Kconfig
>  create mode 100644 hw/sd/Kconfig
>  create mode 100644 hw/sh4/Kconfig
>  create mode 100644 hw/smbios/Kconfig
>  create mode 100644 hw/sparc/Kconfig
>  create mode 100644 hw/sparc64/Kconfig
>  create mode 100644 hw/ssi/Kconfig
>  create mode 100644 hw/timer/Kconfig
>  create mode 100644 hw/tpm/Kconfig
>  create mode 100644 hw/usb/Kconfig
>  create mode 100644 hw/vfio/Kconfig
>  create mode 100644 hw/virtio/Kconfig
>  create mode 100644 hw/watchdog/Kconfig
>  create mode 100644 hw/xtensa/Kconfig
> 
> diff --git a/Kconfig.host b/Kconfig.host
> new file mode 100644
> index 0000000000..2136a4c3ec
> --- /dev/null
> +++ b/Kconfig.host
> @@ -0,0 +1,17 @@
> +# These are "proxy" symbols used to pass config-host.mak values
> +# down to Kconfig.
> +
> +config KVM
> +    bool
> +
> +config OPENGL
> +    bool
> +
> +config SPICE
> +    bool
> +
> +config TPM
> +    bool
> +
> +config XEN
> +    bool
> diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
> new file mode 100644
> index 0000000000..a4750999d9
> --- /dev/null
> +++ b/hw/9pfs/Kconfig
> @@ -0,0 +1,2 @@
> +config VIRTIO_9P
> +    bool
> diff --git a/hw/Kconfig b/hw/Kconfig
> new file mode 100644
> index 0000000000..55743a958a
> --- /dev/null
> +++ b/hw/Kconfig
> @@ -0,0 +1,60 @@
> +# devices Kconfig
> +source 9pfs/Kconfig
> +source acpi/Kconfig
> +source audio/Kconfig
> +source block/Kconfig
> +source bt/Kconfig
> +source char/Kconfig
> +source core/Kconfig
> +source display/Kconfig
> +source dma/Kconfig
> +source gpio/Kconfig
> +source i2c/Kconfig
> +source ide/Kconfig
> +source input/Kconfig
> +source intc/Kconfig
> +source ipack/Kconfig
> +source isa/Kconfig
> +source mem/Kconfig
> +source misc/Kconfig
> +source net/Kconfig
> +source nvram/Kconfig
> +source pci-bridge/Kconfig
> +source pci-host/Kconfig
> +source pci/Kconfig
> +source scsi/Kconfig
> +source sd/Kconfig
> +source ssi/Kconfig
> +source timer/Kconfig
> +source tpm/Kconfig
> +source usb/Kconfig
> +source virtio/Kconfig
> +source watchdog/Kconfig
> +source smbios/Kconfig
> +source ipmi/Kconfig
> +source vfio/Kconfig
> +source adc/Kconfig
> +source pcmcia/Kconfig
> +source hyperv/Kconfig

Could you please sort the last 5 entries alphabetically into the list?

> +# arch Kconfig
> +source i386/Kconfig
> +source arm/Kconfig
> +source m68k/Kconfig
> +source microblaze/Kconfig
> +source mips/Kconfig
> +source ppc/Kconfig
> +source sh4/Kconfig
> +source sparc/Kconfig
> +source sparc64/Kconfig
> +source lm32/Kconfig
> +source xtensa/Kconfig
> +source nios2/Kconfig
> +source riscv/Kconfig

dito, please sort last 4 entries alphabetically into the list.

Apart from that, patch looks good to me.

 Thomas
