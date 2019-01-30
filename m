Received: from eggs.gnu.org ([209.51.188.92]:53717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gomxC-0006QH-4p
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gomxB-0006pk-6b
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:18:46 -0500
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
	<1548841387-7670-1-git-send-email-thuth@redhat.com>
	<1548841387-7670-4-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <589e3fed-afc8-ea5e-14d5-fda516e925e9@redhat.com>
Date: Wed, 30 Jan 2019 11:18:34 +0100
MIME-Version: 1.0
In-Reply-To: <1548841387-7670-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/5] ppc: Express dependencies of the
 Mac machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, yang.zhong@intel.com
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 30/01/19 10:43, Thomas Huth wrote:
> This will make it for example easier if the users want to disable
> one of the two machines for their builds.
> 
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
>  default-configs/ppc-softmmu.mak | 15 ---------------
>  hw/misc/Kconfig                 |  8 ++++++++
>  hw/net/Kconfig                  |  2 ++
>  hw/pci-host/Kconfig             |  4 +++-
>  hw/ppc/Kconfig                  |  7 +++++++
>  5 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
> index 422f1b7..513a8e9 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -37,21 +37,6 @@ CONFIG_VGA_CIRRUS=y
>  CONFIG_SMBUS_EEPROM=y
>  
>  # For Macs
> -CONFIG_ESCC=y
> -CONFIG_MACIO=y
> -CONFIG_MACIO_GPIO=y
> -CONFIG_SUNGEM=y
> -CONFIG_MOS6522=y
> -CONFIG_CUDA=y
> -CONFIG_ADB=y
> -CONFIG_MAC_NVRAM=y
> -CONFIG_MAC_DBDMA=y
> -CONFIG_MAC_PMU=y
> -CONFIG_HEATHROW_PIC=y
> -CONFIG_GRACKLE_PCI=y
> -CONFIG_UNIN_PCI=y
> -CONFIG_DEC_PCI=y
> -CONFIG_IDE_MACIO=y
>  CONFIG_MAC_OLDWORLD=y
>  CONFIG_MAC_NEWWORLD=y
>  
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 3ebe30f..f392502 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -59,6 +59,14 @@ config MOS6522
>  
>  config MACIO
>      bool
> +    select CUDA
> +    select ESCC
> +    select IDE_MACIO
> +    select MACIO_GPIO
> +    select MAC_DBDMA
> +    select MAC_NVRAM
> +    select MAC_PMU
> +    select MOS6522
>  
>  config IVSHMEM_DEVICE
>      bool
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index 47368d7..9047f6d 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -85,6 +85,8 @@ config FTGMAC100
>  
>  config SUNGEM
>      bool
> +    default y if (MAC_OLDWORLD || MAC_NEWWORLD)
> +    depends on PCI
>  
>  config COLDFIRE
>      bool
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index ff4080c..b39ea29 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -10,8 +10,10 @@ config GRACKLE_PCI
>      bool
>  
>  config UNIN_PCI
> -    select PCI
>      bool
> +    select PCI
> +    select DEC_PCI
> +    select OPENPIC
>  
>  config PPCE500_PCI
>      select PCI
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 809830e..f6b4206 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -44,9 +44,16 @@ config RS6000_MC
>  
>  config MAC_OLDWORLD
>      bool
> +    select ADB
> +    select GRACKLE_PCI
> +    select HEATHROW_PIC
> +    select MACIO
>  
>  config MAC_NEWWORLD
>      bool
> +    select ADB
> +    select MACIO
> +    select UNIN_PCI
>  
>  config E500
>      bool
> 
