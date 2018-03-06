Received: from eggs.gnu.org ([2001:4830:134:3::10]:44598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1etMG5-00007o-Su
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1etMG2-00062T-O4
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:44:37 -0500
Date: Wed, 7 Mar 2018 00:44:32 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180306203103.25563-8-mark.cave-ayland@ilande.co.uk>
Message-ID: <alpine.BSF.2.21.1803070040490.57076@zero.eik.bme.hu>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-8-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 07/19] uninorth: move PCI mmio
 memory region initialisation into init function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On Tue, 6 Mar 2018, Mark Cave-Ayland wrote:
> Whilst we are here, rename the memory regions to better reflect whether they
> belong to either a PCI or an AGP bus.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
> hw/pci-host/uninorth.c | 28 ++++++++++++++++++----------
> 1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index b081e3c153..5b8fc3aa16 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -111,29 +111,39 @@ static const MemoryRegionOps unin_data_ops = {
>
> static void pci_unin_main_init(Object *obj)
> {
> +    UNINState *s = UNI_NORTH_PCI_HOST_BRIDGE(obj);
>     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>     PCIHostState *h = PCI_HOST_BRIDGE(obj);
>
>     /* Use values found on a real PowerMac */
>     /* Uninorth main bus */
>     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops,
> -                          obj, "pci-conf-idx", 0x1000);
> +                          obj, "unin-pci-conf-idx", 0x1000);
>     memory_region_init_io(&h->data_mem, OBJECT(h), &unin_data_ops, obj,
> -                          "pci-conf-data", 0x1000);
> +                          "unin-pci-conf-data", 0x1000);
> +
> +    memory_region_init(&s->pci_mmio, OBJECT(s), "unin-pci-mmio",
> +                       0x100000000ULL);
> +
>     sysbus_init_mmio(sbd, &h->conf_mem);
>     sysbus_init_mmio(sbd, &h->data_mem);
> }
>
> static void pci_u3_agp_init(Object *obj)
> {
> +    UNINState *s = U3_AGP_HOST_BRIDGE(obj);
>     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>     PCIHostState *h = PCI_HOST_BRIDGE(obj);
>
>     /* Uninorth U3 AGP bus */
>     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops,
> -                          obj, "pci-conf-idx", 0x1000);
> +                          obj, "unin-pci-conf-idx", 0x1000);
>     memory_region_init_io(&h->data_mem, OBJECT(h), &unin_data_ops, obj,
> -                          "pci-conf-data", 0x1000);
> +                          "unin-pci-conf-data", 0x1000);
> +
> +    memory_region_init(&s->pci_mmio, OBJECT(s), "unin-pci-mmio",

The name of this function and the above comment both suggest this is an 
AGP bus so did you mean to rename these to unin-agp-* instead of 
unin-pci-*?

Regards,
BALATON Zoltan

> +                       0x100000000ULL);
> +
>     sysbus_init_mmio(sbd, &h->conf_mem);
>     sysbus_init_mmio(sbd, &h->data_mem);
> }
> @@ -145,9 +155,9 @@ static void pci_unin_agp_init(Object *obj)
>
>     /* Uninorth AGP bus */
>     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops,
> -                          obj, "pci-conf-idx", 0x1000);
> +                          obj, "unin-agp-conf-idx", 0x1000);
>     memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops,
> -                          obj, "pci-conf-data", 0x1000);
> +                          obj, "unin-agp-conf-data", 0x1000);
>     sysbus_init_mmio(sbd, &h->conf_mem);
>     sysbus_init_mmio(sbd, &h->data_mem);
> }
> @@ -159,9 +169,9 @@ static void pci_unin_internal_init(Object *obj)
>
>     /* Uninorth internal bus */
>     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops,
> -                          obj, "pci-conf-idx", 0x1000);
> +                          obj, "unin-pci-conf-idx", 0x1000);
>     memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops,
> -                          obj, "pci-conf-data", 0x1000);
> +                          obj, "unin-pci-conf-data", 0x1000);
>     sysbus_init_mmio(sbd, &h->conf_mem);
>     sysbus_init_mmio(sbd, &h->data_mem);
> }
> @@ -182,7 +192,6 @@ UNINState *pci_pmac_init(qemu_irq *pic,
>     s = SYS_BUS_DEVICE(dev);
>     h = PCI_HOST_BRIDGE(s);
>     d = UNI_NORTH_PCI_HOST_BRIDGE(dev);
> -    memory_region_init(&d->pci_mmio, OBJECT(d), "pci-mmio", 0x100000000ULL);
>     memory_region_init_alias(&d->pci_hole, OBJECT(d), "pci-hole", &d->pci_mmio,
>                              0x80000000ULL, 0x10000000ULL);
>     memory_region_add_subregion(address_space_mem, 0x80000000ULL,
> @@ -247,7 +256,6 @@ UNINState *pci_pmac_u3_init(qemu_irq *pic,
>     h = PCI_HOST_BRIDGE(dev);
>     d = U3_AGP_HOST_BRIDGE(dev);
>
> -    memory_region_init(&d->pci_mmio, OBJECT(d), "pci-mmio", 0x100000000ULL);
>     memory_region_init_alias(&d->pci_hole, OBJECT(d), "pci-hole", &d->pci_mmio,
>                              0x80000000ULL, 0x70000000ULL);
>     memory_region_add_subregion(address_space_mem, 0x80000000ULL,
>
