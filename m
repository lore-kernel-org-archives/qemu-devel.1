Received: from eggs.gnu.org ([2001:4830:134:3::10]:48048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fkVdZ-0008Qq-Cy
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fkVdT-000810-Ip
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:28:33 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:40496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fkVdT-0007th-22
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:28:27 -0400
Received: from player732.ha.ovh.net (unknown [10.109.143.225])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 33B1F146E00
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 16:28:18 +0200 (CEST)
References: <20180731043635.9802-1-mail@sebastianbauer.info>
	<20180731043635.9802-2-mail@sebastianbauer.info>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <028b4a16-ca15-2ba0-ed24-7b956201763f@kaod.org>
Date: Tue, 31 Jul 2018 16:28:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180731043635.9802-2-mail@sebastianbauer.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/2] ppc: Allow clients of the
 440 pcix bus to specify the number of interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 07/31/2018 06:36 AM, Sebastian Bauer wrote:
> This can be done by using the newly introduced num_irqs property. In
> particular, this change introduces a special case if num_irqs is 1 in which
> case any interrupt pin will be connected to the single irq. The default
> case is untouched (but note that the only client is the Sam460ex board for
> which the special case was actually created).
> 
> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
> ---
>  hw/ppc/ppc440_pcix.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
> index d8af04b70f..cb7d7cfd2b 100644
> --- a/hw/ppc/ppc440_pcix.c
> +++ b/hw/ppc/ppc440_pcix.c
> @@ -57,6 +57,7 @@ typedef struct PPC440PCIXState {
>      struct PLBOutMap pom[PPC440_PCIX_NR_POMS];
>      struct PLBInMap pim[PPC440_PCIX_NR_PIMS];
>      uint32_t sts;
> +    uint16_t num_irqs;
>      qemu_irq irq[PCI_NUM_PINS];
>      AddressSpace bm_as;
>      MemoryRegion bm;
> @@ -423,6 +424,12 @@ static int ppc440_pcix_map_irq(PCIDevice *pci_dev, int irq_num)
>      return slot - 1;
>  }
>  
> +/* All pins from each slot are tied the same and only board IRQ. */
> +static int ppc440_pcix_map_irq_single(PCIDevice *pci_dev, int irq_num)
> +{
> +    return 0;
> +}
> +
>  static void ppc440_pcix_set_irq(void *opaque, int irq_num, int level)
>  {
>      qemu_irq *pci_irqs = opaque;
> @@ -469,6 +476,7 @@ const MemoryRegionOps ppc440_pcix_host_data_ops = {
>  
>  static int ppc440_pcix_initfn(SysBusDevice *dev)
>  {
> +    pci_map_irq_fn map_irq;
>      PPC440PCIXState *s;
>      PCIHostState *h;
>      int i;
> @@ -476,14 +484,22 @@ static int ppc440_pcix_initfn(SysBusDevice *dev)
>      h = PCI_HOST_BRIDGE(dev);
>      s = PPC440_PCIX_HOST_BRIDGE(dev);
>  
> -    for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
> +    if (s->num_irqs > 4) {

may be use PCI_NUM_PINS

> +        fprintf(stderr, "%s: Number of irqs must not exceed 4\n", __func__);

error_report would be better.
 
> +        return -1;
> +    }

It might be the right time to QOM'ify a bit more "ppc440-pcix-host" and 
introduce a realize() operation to handle errors. 

> +    for (i = 0; i < s->num_irqs; i++) {
>          sysbus_init_irq(dev, &s->irq[i]);
>      }
>  
>      memory_region_init(&s->busmem, OBJECT(dev), "pci bus memory", UINT64_MAX);
> +
> +    map_irq = s->num_irqs == 1 ?
> +            ppc440_pcix_map_irq_single : ppc440_pcix_map_irq;
>      h->bus = pci_register_root_bus(DEVICE(dev), NULL, ppc440_pcix_set_irq,
> -                         ppc440_pcix_map_irq, s->irq, &s->busmem,
> -                         get_system_io(), PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);
> +                         map_irq, s->irq, &s->busmem, get_system_io(),
> +                         PCI_DEVFN(0, 0), s->num_irqs, TYPE_PCI_BUS);
>  
>      s->dev = pci_create_simple(h->bus, PCI_DEVFN(0, 0), "ppc4xx-host-bridge");
>  
> @@ -507,6 +523,11 @@ static int ppc440_pcix_initfn(SysBusDevice *dev)
>      return 0;
>  }
>  
> +static Property ppc440_pcix_properties[] = {
> +    DEFINE_PROP_UINT16("num-irqs", PPC440PCIXState, num_irqs, 4),

PCI_NUM_PINS ?

> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
>  {
>      SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
> @@ -514,6 +535,7 @@ static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
>  
>      k->init = ppc440_pcix_initfn;
>      dc->reset = ppc440_pcix_reset;
> +    dc->props = ppc440_pcix_properties;
>  }
>  
>  static const TypeInfo ppc440_pcix_info = {
> 
