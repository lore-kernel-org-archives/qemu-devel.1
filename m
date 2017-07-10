Received: from eggs.gnu.org ([2001:4830:134:3::10]:37309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dUTDx-0006xH-BF
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dUTDs-000711-DI
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:35:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dUTDs-00070V-3V
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:35:12 -0400
References: <1499413442-5053-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1499413442-5053-4-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <f0b5fca6-172d-d75b-7ade-2906601ed6ee@redhat.com>
Date: Mon, 10 Jul 2017 10:35:03 +0300
MIME-Version: 1.0
In-Reply-To: <1499413442-5053-4-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] pci: add reserved slot check to
 do_pci_register_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, mst@redhat.com, armbru@redhat.com

On 07/07/2017 10:44, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/pci/pci.c |   21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 239161e..9dece2a 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -961,6 +961,15 @@ static bool pci_bus_devfn_available(PCIBus *bus, int devfn)
>       }
>   }
>  

Hi Mark,


> +static bool pci_bus_devfn_reserved(PCIBus *bus, int devfn)
> +{
> +    if (bus->dev_reserved_mask & (1UL << PCI_SLOT(devfn))) {

Looking at this code maybe we should rename the field to
"slot_mask"? Only a suggestion.

> +        return true;
> +    } else {
> +        return false;
> +    }
> +}
> + >   /* -1 for devfn means auto assign */
>   static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>                                            const char *name, int devfn,
> @@ -984,14 +993,20 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>       if (devfn < 0) {
>           for(devfn = bus->devfn_min ; devfn < ARRAY_SIZE(bus->devices);
>               devfn += PCI_FUNC_MAX) {
> -            if (pci_bus_devfn_available(bus, devfn)) {
> +            if (pci_bus_devfn_available(bus, devfn) &&
> +                   !pci_bus_devfn_reserved(bus, devfn)) {
>                   goto found;
>               }
>           }
> -        error_setg(errp, "PCI: no slot/function available for %s, all in use",
> -                   name);
> +        error_setg(errp, "PCI: no slot/function available for %s, all in use "
> +                   "or reserved", name);

I wouldn't combine slot available/reserved, maybe check for reserved
before "available"?

>           return NULL;
>       found: ;
> +    } else if (pci_bus_devfn_reserved(bus, devfn)) {
> +        error_setg(errp, "PCI: slot %d function %d not available for %s,"
> +                   " reserved",
> +                   PCI_SLOT(devfn), PCI_FUNC(devfn), name);
> +        return NULL;
>       } else if (!pci_bus_devfn_available(bus, devfn)) {
>           error_setg(errp, "PCI: slot %d function %d not available for %s,"
>                      " in use by %s",
> 

Thanks for the patches!
Marcel
