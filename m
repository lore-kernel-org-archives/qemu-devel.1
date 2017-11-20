Received: from eggs.gnu.org ([2001:4830:134:3::10]:36602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGaNp-0005q7-3y
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGaNm-00063M-0R
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:56:21 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:43943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGaNl-00062c-R5
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:56:17 -0500
Received: by mail-qk0-x243.google.com with SMTP id j202so5631790qke.10
	for <qemu-devel@nongnu.org>; Sun, 19 Nov 2017 16:56:17 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-10-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8a9d3b04-ff65-cb29-28cf-867fd832e02e@amsat.org>
Date: Sun, 19 Nov 2017 21:56:14 -0300
MIME-Version: 1.0
In-Reply-To: <1510926167-23326-10-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 11/17/2017 10:42 AM, Mark Cave-Ayland wrote:
> This enables us to remove these parameters from pci_apb_init().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
> 
