Received: from eggs.gnu.org ([209.51.188.92]:46648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyesX-0003R8-89
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 10:42:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyesW-00061H-0t
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 10:42:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gyesV-0005yz-GX
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 10:42:43 -0500
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-18-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fdcc00a8-4d8e-d0da-7358-196f9732b05b@redhat.com>
Date: Tue, 26 Feb 2019 16:42:36 +0100
MIME-Version: 1.0
In-Reply-To: <1549562254-41157-18-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 17/51] i386: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, Yang Zhong <yang.zhong@intel.com>, Stefano Garzarella <sgarzare@redhat.com>

On 07/02/2019 18.57, Paolo Bonzini wrote:
> This way, the default-configs file only need to specify the boards
> and any optional devices.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Message-Id: <20190123065618.3520-37-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[...]
> ---
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 0f94ae1..daf2015 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -7,16 +7,65 @@ config PC
>      imply QXL
>      imply SEV
>      imply TPM_TIS
> +    select I8259
> +    select I8254
> +    select PCSPK
> +    select I82374
> +    select I8257
> +    select MC146818RTC
> +
> +config PC_PCI
> +    bool
> +    select APIC
> +    select IOAPIC
> +    select APM
> +    select PC
> +
> +config PC_ACPI
> +    bool
> +    select ACPI_X86
> +    select ACPI_CPU_HOTPLUG
> +    select ACPI_MEMORY_HOTPLUG
> +    depends on ACPI_SMBUS
> =20
>  config I440FX
>      bool
> +    select PC_PCI
> +    select PC_ACPI
> +    select ACPI_SMBUS
> +    select PCI_PIIX
> +    select FDC
> +    select IDE_PIIX
> +    select DIMM
> +    select SMBIOS
> +    select VMPORT
> +    select VMMOUSE
> +    select FW_CFG_DMA

Just a thought: Should we also "imply E1000_PCI" here to indicate the
default NIC?

>  config ISAPC
>      bool
>      select ISA_BUS
> +    select PC
> +    select IDE_ISA
> +    select VGA_ISA

ISAPC seems also to work without a vga card when you specify
-nodefaults, so I think this should be "imply VGA_ISA" instead.

Maybe also "imply NE2000_ISA" for the default NIC?

> +    # FIXME: it is in the same file as i440fx, and does not compile
> +    # if separated
> +    depends on I440FX
> =20
>  config Q35
>      bool
> +    imply VTD
> +    imply AMD_IOMMU
> +    select PC_PCI
> +    select PC_ACPI
> +    select PCI_EXPRESS_Q35
> +    select LPC_ICH9
> +    select AHCI
> +    select DIMM
> +    select SMBIOS
> +    select VMPORT
> +    select VMMOUSE
> +    select FW_CFG_DMA

Maybe add "imply E1000E_PCI_EXPRESS" for the default NIC?

 Thomas
