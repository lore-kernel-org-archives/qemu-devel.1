Received: from eggs.gnu.org ([2001:4830:134:3::10]:45192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eRxyN-00056H-0D
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eRxyL-0005Ld-R2
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:21:06 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:33468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1eRxyL-0005LQ-LC
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:21:05 -0500
Received: by mail-io0-x242.google.com with SMTP id t196so20500499iof.0
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 02:21:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221082045.14022-8-mark.cave-ayland@ilande.co.uk>
References: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
	<20171221082045.14022-8-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Thu, 21 Dec 2017 11:20:44 +0100
Message-ID: <CACXAS8CZh9TdVbZp8ChmWcWFHZwdRUwq3PhPdCi0qtydNtCkpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv3 07/16] apb: return APBState from
 pci_apb_init() rather than PCIBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Thu, Dec 21, 2017 at 9:20 AM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> This is a first step towards removing pci_apb_init() completely.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  hw/pci-host/apb.c         | 8 ++++----
>  hw/sparc64/sun4u.c        | 6 ++++--
>  include/hw/pci-host/apb.h | 6 +++---
>  3 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index c7837efb7a..0c709992ec 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -612,9 +612,9 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Er=
ror **errp)
>      pci_bridge_update_mappings(PCI_BRIDGE(br));
>  }
>
> -PCIBus *pci_apb_init(hwaddr special_base,
> -                     hwaddr mem_base,
> -                     qemu_irq *ivec_irqs, PCIBus **busA, PCIBus **busB)
> +APBState *pci_apb_init(hwaddr special_base,
> +                       hwaddr mem_base,
> +                       qemu_irq *ivec_irqs, PCIBus **busA, PCIBus **busB=
)
>  {
>      DeviceState *dev;
>      SysBusDevice *s;
> @@ -675,7 +675,7 @@ PCIBus *pci_apb_init(hwaddr special_base,
>      qdev_init_nofail(&pci_dev->qdev);
>      *busA =3D pci_bridge_get_sec_bus(br);
>
> -    return phb->bus;
> +    return d;
>  }
>
>  static void pci_pbm_reset(DeviceState *d)
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index b441f1ecdb..a64ddc569d 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -482,6 +482,7 @@ static void sun4uv_init(MemoryRegion *address_space_m=
em,
>      Nvram *nvram;
>      unsigned int i;
>      uint64_t initrd_addr, initrd_size, kernel_addr, kernel_size, kernel_=
entry;
> +    APBState *apb;
>      PCIBus *pci_bus, *pci_busA, *pci_busB;
>      PCIDevice *ebus, *pci_dev;
>      SysBusDevice *s;
> @@ -502,8 +503,9 @@ static void sun4uv_init(MemoryRegion *address_space_m=
em,
>      prom_init(hwdef->prom_addr, bios_name);
>
>      ivec_irqs =3D qemu_allocate_irqs(sparc64_cpu_set_ivec_irq, cpu, IVEC=
_MAX);
> -    pci_bus =3D pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE, ivec_irqs, =
&pci_busA,
> -                           &pci_busB);
> +    apb =3D pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE, ivec_irqs, &pci=
_busA,
> +                       &pci_busB);
> +    pci_bus =3D PCI_HOST_BRIDGE(apb)->bus;
>
>      /* Only in-built Simba PBMs can exist on the root bus, slot 0 on bus=
A is
>         reserved (leaving no slots free after on-board devices) however s=
lots
> diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
> index 35d7d5ad7b..a4ef51adc8 100644
> --- a/include/hw/pci-host/apb.h
> +++ b/include/hw/pci-host/apb.h
> @@ -89,7 +89,7 @@ typedef struct PBMPCIBridge {
>  #define PBM_PCI_BRIDGE(obj) \
>      OBJECT_CHECK(PBMPCIBridge, (obj), TYPE_PBM_PCI_BRIDGE)
>
> -PCIBus *pci_apb_init(hwaddr special_base,
> -                     hwaddr mem_base,
> -                     qemu_irq *ivec_irqs, PCIBus **bus2, PCIBus **bus3);
> +APBState *pci_apb_init(hwaddr special_base,
> +                       hwaddr mem_base,
> +                       qemu_irq *ivec_irqs, PCIBus **bus2, PCIBus **bus3=
);
>  #endif
> --
> 2.11.0
>



--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu
