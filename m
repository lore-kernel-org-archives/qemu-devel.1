Received: from eggs.gnu.org ([2001:4830:134:3::10]:52622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eFhpf-0001IT-J2
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eFhpe-0005Dy-Ft
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:41:27 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:43328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1eFhpe-0005DJ-Ag
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:41:26 -0500
Received: by mail-it0-x242.google.com with SMTP id m191so4281047itg.2
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 06:41:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510926167-23326-10-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-10-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 17 Nov 2017 15:41:05 +0100
Message-ID: <CACXAS8B6i42TvVXTTktKk2J4bufoLUv=WSit3+BjurR72knkGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 09/15] apb: move the two secondary PCI
 bridges objects into APBState
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

On Fri, Nov 17, 2017 at 2:42 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> This enables us to remove these parameters from pci_apb_init().
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  hw/pci-host/apb.c         |   14 +++++---------
>  hw/sparc64/sun4u.c        |    5 ++++-
>  include/hw/pci-host/apb.h |    5 +++--
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index c0b97e4..823661a 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -612,8 +612,7 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
>  }
>
>  APBState *pci_apb_init(hwaddr special_base,
> -                       hwaddr mem_base,
> -                       PCIBus **busA, PCIBus **busB)
> +                       hwaddr mem_base)
>  {
>      DeviceState *dev;
>      SysBusDevice *s;
> @@ -621,7 +620,6 @@ APBState *pci_apb_init(hwaddr special_base,
>      APBState *d;
>      IOMMUState *is;
>      PCIDevice *pci_dev;
> -    PCIBridge *br;
>
>      /* Ultrasparc PBM main bus */
>      dev = qdev_create(NULL, TYPE_APB);
> @@ -659,18 +657,16 @@ APBState *pci_apb_init(hwaddr special_base,
>      /* APB secondary busses */
>      pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 0), true,
>                                     TYPE_PBM_PCI_BRIDGE);
> -    br = PCI_BRIDGE(pci_dev);
> -    pci_bridge_map_irq(br, "pciB", pci_pbm_map_irq);
> +    d->bridgeB = PCI_BRIDGE(pci_dev);
> +    pci_bridge_map_irq(d->bridgeB, "pciB", pci_pbm_map_irq);
>      qdev_init_nofail(&pci_dev->qdev);
> -    *busB = pci_bridge_get_sec_bus(br);
>
>      pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 1), true,
>                                     TYPE_PBM_PCI_BRIDGE);
> -    br = PCI_BRIDGE(pci_dev);
> -    pci_bridge_map_irq(br, "pciA", pci_pbm_map_irq);
> +    d->bridgeA = PCI_BRIDGE(pci_dev);
> +    pci_bridge_map_irq(d->bridgeA, "pciA", pci_pbm_map_irq);
>      qdev_prop_set_bit(DEVICE(pci_dev), "busA", true);
>      qdev_init_nofail(&pci_dev->qdev);
> -    *busA = pci_bridge_get_sec_bus(br);
>
>      return d;
>  }
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 2afd3f2..47952be 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -27,6 +27,7 @@
>  #include "cpu.h"
>  #include "hw/hw.h"
>  #include "hw/pci/pci.h"
> +#include "hw/pci/pci_bridge.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/pci-host/apb.h"
>  #include "hw/i386/pc.h"
> @@ -501,7 +502,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>
>      prom_init(hwdef->prom_addr, bios_name);
>
> -    apb = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE, &pci_busA, &pci_busB);
> +    apb = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE);
>
>      /* Wire up PCI interrupts to CPU */
>      for (i = 0; i < IVEC_MAX; i++) {
> @@ -510,6 +511,8 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      }
>
>      pci_bus = PCI_HOST_BRIDGE(apb)->bus;
> +    pci_busA = pci_bridge_get_sec_bus(apb->bridgeA);
> +    pci_busB = pci_bridge_get_sec_bus(apb->bridgeB);
>
>      /* Only in-built Simba PBMs can exist on the root bus, slot 0 on busA is
>         reserved (leaving no slots free after on-board devices) however slots
> diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
> index f7ead68..ae15d8c 100644
> --- a/include/hw/pci-host/apb.h
> +++ b/include/hw/pci-host/apb.h
> @@ -68,6 +68,8 @@ typedef struct APBState {
>      MemoryRegion pci_ioport;
>      uint64_t pci_irq_in;
>      IOMMUState iommu;
> +    PCIBridge *bridgeA;
> +    PCIBridge *bridgeB;
>      uint32_t pci_control[16];
>      uint32_t pci_irq_map[8];
>      uint32_t pci_err_irq_map[4];
> @@ -92,6 +94,5 @@ typedef struct PBMPCIBridge {
>      OBJECT_CHECK(PBMPCIBridge, (obj), TYPE_PBM_PCI_BRIDGE)
>
>  APBState *pci_apb_init(hwaddr special_base,
> -                       hwaddr mem_base,
> -                       PCIBus **bus2, PCIBus **bus3);
> +                       hwaddr mem_base);
>  #endif
> --
> 1.7.10.4
>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
