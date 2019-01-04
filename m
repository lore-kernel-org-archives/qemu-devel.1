Received: from eggs.gnu.org ([208.118.235.92]:33870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfQ0t-00071u-LL
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfQ0q-0006gC-Ey
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:59:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gfQ0q-0006fq-8P
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 08:59:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so36640655wrt.13
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 05:59:48 -0800 (PST)
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-23-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1f94070a-d9df-9fb9-66e8-77e576aeb229@redhat.com>
Date: Fri, 4 Jan 2019 14:59:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181227063419.12981-23-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 22/25] i386-softmmu.mak: remove all
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com

On 27/12/18 07:34, Yang Zhong wrote:
> %-softmmu.mak only keep boards definitions in Kconfig mode.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  default-configs/i386-softmmu.mak | 30 ------------------------------
>  hw/i386/Kconfig                  | 30 ++++++++++++++++++++++++++++++
>  hw/ide/Kconfig                   |  2 +-
>  hw/net/Kconfig                   |  2 ++
>  4 files changed, 33 insertions(+), 31 deletions(-)
> 
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index d3488b5a6d..7b083412af 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -1,35 +1,5 @@
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
> -CONFIG_VMPORT=y
> -CONFIG_SGA=y
> -CONFIG_PVPANIC=y
> -CONFIG_MEM_DEVICE=y
> -CONFIG_DIMM=y
> -CONFIG_NVDIMM=y
> -CONFIG_ACPI_NVDIMM=y
> -CONFIG_PCIE_PORT=y
> -CONFIG_SMBIOS=y
> -CONFIG_PXB=y
> -CONFIG_ACPI_VMGENID=y
> -CONFIG_FW_CFG_DMA=y
> -CONFIG_I2C=y
> -CONFIG_SEV=$(CONFIG_KVM)
> -CONFIG_VTD=y
> -CONFIG_AMD_IOMMU=y
> -
>  # Boards:
>  #
>  CONFIG_ISAPC=y
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index af4b81bae1..c00080ac76 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -1,6 +1,9 @@
>  config KVM
>      bool
>  
> +config SEV
> +    bool

The rest of this patch should not be needed:

>  config PC
>      bool
>      select ISA_DEBUG
> @@ -13,6 +16,29 @@ config PC
>      select TPM_TIS if TPM
>      select HYPERV
>      select HYPERV_TESTDEV
> +    select DIMM
> +    select AMD_IOMMU

This should be selected by Q35 only, in patch 16.

> +    select NVDIMM
> +    select ACPI_NVDIMM
> +    select ACPI_VMGENID

I think these should not be selected

> +    select SMBIOS

Please add this to patch 16 instead.

> +    select IPMI

This should be selected through ISA_IPMI_KCS and ISA_IPMI_BT.

> +    select IPMI_LOCAL
> +    select IPMI_EXTERN

These should be config symbols that depend on IPMI.

> +    select ISA_IPMI_KCS
> +    select ISA_IPMI_BT

These should be config symbols that depend on PC and select IPMI.  The
default should be y.

> +    select PFLASH_CFI01
> +    select I2C

This should be selected automatically via PC_ACPI and ACPI_SMBUS.  No
need to specify it here.

> +    select PVPANIC

This should be a config symbol that has "default y if PC".  No need to
specify it here.

> +    select PXB

This should be "default y if PC", again no need to specify it here.

> +    select VMPORT
> +    select VMMOUSE

These ones are good, but they should be in patch 16.

> +    select SEV if KVM

This one should be "default y if PC && KVM", and not selected here.

> +    select HPET
> +    select APPLESMC
> +    select ISA_TESTDEV
> +    select SGA

These four should be "default y if PC" and not selected here.

> +    select FW_CFG_DMA

And finally this one should be in patch 16.

>  config PC_PCI
>      bool
> @@ -37,6 +63,7 @@ config I440FX
>      select PCI_PIIX
>      select FDC
>      select IDE_PIIX
> +    select VTD

I440FX should not select VTD, like AMD_IOMMU.

>  
>  config ISAPC
>      bool
> @@ -55,6 +82,8 @@ config Q35
>      select PCI_Q35
>      select LPC_ICH9
>      select AHCI
> +    select VTD

This should be in patch 16.

> +    select PCIE_PORT

There should be a "config PCIE" in patch 10, and then

config PCIE_PORT
    depends on PCIE
    default y if PCIE

In patch 10, all of XIO3130, IOH3420 and PCIE_PORT should depend on
PCIE.  PCI_Q35, PCI_XILINX, PCI_GENERIC and PCI_DESIGNWARE should select
PCIE.

>  config VTD
>      bool
> @@ -67,3 +96,4 @@ config VMPORT
>  
>  config VMMOUSE
>      bool
> +    depends on VMPORT

This should be in patch 16.

> diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
> index 41d3057675..b9ba571c04 100644
> --- a/hw/ide/Kconfig
> +++ b/hw/ide/Kconfig
> @@ -17,7 +17,7 @@ config IDE_ISA
>  
>  config IDE_PIIX
>      bool
> -    depends on PCI
> +    select IDE_PCI

This is correct, but move it to patch 10.

>      select IDE_QDEV
>  
>  config IDE_CMD646
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index 8b65de1d7f..3be0571649 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -108,6 +108,7 @@ config ROCKER
>  
>  config CAN_BUS
>      bool
> +    default y

This should not be default y.

>  config CAN_PCI
>      bool
> @@ -116,3 +117,4 @@ config CAN_PCI
>  
>  config CAN_SJA1000
>      bool
> +    default y

This should select CAN_BUS and, after patch 10, depend on PCI.

Paolo
