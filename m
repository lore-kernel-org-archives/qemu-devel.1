Received: from eggs.gnu.org ([209.51.188.92]:46380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk5SY-0000ZA-5D
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk5SX-0004cp-6k
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:03:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gk5SW-0004ZF-U2
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:03:41 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-36-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fb502f25-0307-b52f-2810-26bb3cf72dd6@redhat.com>
Date: Thu, 17 Jan 2019 12:03:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-36-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 35/37] i386-softmmu.mak: remove all
 CONFIG_* except boards definitions
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

On 2019-01-15 15:11, Yang Zhong wrote:
> %-softmmu.mak only keep boards definitions in Kconfig mode.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/i386-softmmu.mak | 22 ----------------------
>  hw/acpi/Kconfig                  |  4 ++++
>  hw/i386/Kconfig                  |  5 +++++
>  hw/ipmi/Kconfig                  |  6 ++++++
>  hw/mem/Kconfig                   |  2 ++
>  hw/misc/Kconfig                  |  4 ++++
>  hw/pci-bridge/Kconfig            |  1 +
>  hw/timer/Kconfig                 |  1 +
>  8 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index 992aea8f30..7b083412af 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -1,27 +1,5 @@
>  # Default configuration for i386-softmmu
>  
> -CONFIG_VMXNET3_PCI=y
> -CONFIG_IPMI=y
> -CONFIG_IPMI_LOCAL=y
> -CONFIG_IPMI_EXTERN=y
> -CONFIG_ISA_IPMI_KCS=y
> -CONFIG_ISA_IPMI_BT=y
> -
> -# Optional devices:
> -#
> -CONFIG_HPET=y
> -CONFIG_APPLESMC=y
> -CONFIG_PFLASH_CFI01=y
> -CONFIG_ISA_TESTDEV=y
> -CONFIG_SGA=y
> -CONFIG_PVPANIC=y
> -CONFIG_MEM_DEVICE=y
> -CONFIG_NVDIMM=y
> -CONFIG_ACPI_NVDIMM=y
> -CONFIG_PXB=y
> -CONFIG_ACPI_VMGENID=y
> -CONFIG_SEV=$(CONFIG_KVM)
> -
>  # Boards:
>  #
>  CONFIG_ISAPC=y
> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> index 98bb3539e1..09af3ce3be 100644
> --- a/hw/acpi/Kconfig
> +++ b/hw/acpi/Kconfig
> @@ -18,9 +18,13 @@ config ACPI_MEMORY_HOTPLUG
>  
>  config ACPI_NVDIMM
>      bool
> +    default y
> +    depends on I440FX && Q35
>  
>  config ACPI_VMGENID
>      bool
> +    default y
> +    depends on I440FX && Q35

Shouldn't that rather be I440FX || Q35 ?

> diff --git a/hw/ipmi/Kconfig b/hw/ipmi/Kconfig
> index 68f8ba1a54..7730ff5193 100644
> --- a/hw/ipmi/Kconfig
> +++ b/hw/ipmi/Kconfig
> @@ -3,12 +3,18 @@ config IPMI
>  
>  config IPMI_LOCAL
>      bool
> +    depends on IPMI

default y ?

>  config IPMI_EXTERN
>      bool
> +    depends on IPMI

default y ?

>  config ISA_IPMI_KCS
>      bool
> +    default y if PC
> +    select IPMI
>  
>  config ISA_IPMI_BT
>      bool
> +    default y if PC
> +    select IPMI
> diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
> index a3a4372fa7..099fb84df4 100644
> --- a/hw/mem/Kconfig
> +++ b/hw/mem/Kconfig
> @@ -6,3 +6,5 @@ config MEM_DEVICE
>  
>  config NVDIMM
>      bool
> +    default y
> +    depends on I440FX && Q35

I440FX || Q35 ?

(FWIW: it's also used by mips-softmmu.mak, so we need to add this here
later, too)

 Thomas
