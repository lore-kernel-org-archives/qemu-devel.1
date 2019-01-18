Received: from eggs.gnu.org ([209.51.188.92]:59149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gkTQ7-0004Me-Fn
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gkTQ1-0007O4-Qo
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:38:43 -0500
Received: from 20.mo4.mail-out.ovh.net ([46.105.33.73]:46959)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gkTPu-0007Fb-Vb
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:38:36 -0500
Received: from player773.ha.ovh.net (unknown [10.109.146.132])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 27BD61C832B
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:38:23 +0100 (CET)
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774530571.1208625.5318753891932747707.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <933449f5-e65a-caf1-4dad-81a62a0b95e4@kaod.org>
Date: Fri, 18 Jan 2019 13:38:02 +0100
MIME-Version: 1.0
In-Reply-To: <154774530571.1208625.5318753891932747707.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/19] spapr: Identify LSIs of all
 possible PHBs at machine init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

On 1/17/19 6:15 PM, Greg Kurz wrote:
> Every PHB needs to claim 4 LSIs to support legacy PCI devices. This is
> currently done at PHB realize. When using in-kernel XICS (or upcoming
> in-kernel XIVE), QEMU synchronizes the state of all irqs, including
> these LSIs, later on at machine reset.
> 
> In order to support PHB hotplug, we need a way to tell KVM about the
> LSIs that doesn't require a machine reset. Since these irq numbers are
> fixed values derived from the PHB index, let's identify them all at
> machine init. Older machines that don't have fixed irq numbers cannot
> support PHB hotplug and keep the existing behavior.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c              |    6 ++++++
>  hw/ppc/spapr_pci.c          |   20 ++++++++++++++++++--
>  include/hw/pci-host/spapr.h |    2 ++
>  3 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 26f8e55cc25e..9189b4d3a9d6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2802,6 +2802,12 @@ static void spapr_machine_init(MachineState *machine)
>  
>      phb = spapr_create_default_phb();
>  
> +    if (!smc->legacy_irq_allocation) {
> +        for (i = 0; i < SPAPR_MAX_PHBS; i++) {
> +            spapr_phb_set_lsis(i, spapr);
> +        }
> +    }
> +

Can't we be more brutal and do the LSI setting in spapr_irq_init() 
for the whole [ SPAPR_IRQ_PCI_LSI ... SPAPR_IRQ_MSI -1 ] range ? 

C. 

>      for (i = 0; i < nb_nics; i++) {
>          NICInfo *nd = &nd_table[i];
>  
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index ec9d4d28004c..f5f13a4d4816 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1559,6 +1559,22 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
>      }
>  }
>  
> +static uint32_t spapr_phb_index_to_lsi(int phb_index, int irq_index)
> +{
> +    return SPAPR_IRQ_PCI_LSI + phb_index * PCI_NUM_PINS + irq_index;
> +}
> +
> +void spapr_phb_set_lsis(int index, sPAPRMachineState *spapr)
> +{
> +    int i;
> +
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
> +        uint32_t irq = spapr_phb_index_to_lsi(index, i);
> +
> +        spapr_irq_set_type(spapr, irq, true);
> +    }
> +}
> +
>  static void spapr_phb_realize(DeviceState *dev, Error **errp)
>  {
>      /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
> @@ -1726,7 +1742,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>  
>      /* Initialize the LSI table */
>      for (i = 0; i < PCI_NUM_PINS; i++) {
> -        uint32_t irq = SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
> +        uint32_t irq = spapr_phb_index_to_lsi(sphb->index, i);
>          Error *local_err = NULL;
>  
>          if (smc->legacy_irq_allocation) {
> @@ -1736,6 +1752,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>                                          "can't allocate LSIs: ");
>                  return;
>              }
> +            spapr_irq_set_type(spapr, irq, true);
>          }
>  
>          spapr_irq_claim(spapr, irq, &local_err);
> @@ -1743,7 +1760,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>              error_propagate_prepend(errp, local_err, "can't allocate LSIs: ");
>              return;
>          }
> -        spapr_irq_set_type(spapr, irq, true);
>  
>          sphb->lsi_table[i].irq = irq;
>      }
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index e0e683c32469..bb0ae7fdd41d 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -164,4 +164,6 @@ static inline void spapr_phb_vfio_reset(DeviceState *qdev)
>  
>  void spapr_phb_dma_reset(sPAPRPHBState *sphb);
>  
> +void spapr_phb_set_lsis(int index, sPAPRMachineState *spapr);
> +
>  #endif /* PCI_HOST_SPAPR_H */
> 
