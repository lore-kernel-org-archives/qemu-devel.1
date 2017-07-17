Received: from eggs.gnu.org ([2001:4830:134:3::10]:59407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dX1HS-00045P-9z
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dX1HN-0006yS-DV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:21:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dX1HN-0006xG-6s
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:21:21 -0400
References: <1500236854-28271-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1500236854-28271-2-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <5e2e3456-9294-765a-d113-9caa83bc4b2b@redhat.com>
Date: Mon, 17 Jul 2017 11:21:11 +0300
MIME-Version: 1.0
In-Reply-To: <1500236854-28271-2-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv3 1/2] pci: move check for existing devfn
 into new pci_bus_devfn_available() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, mst@redhat.com, armbru@redhat.com

On 16/07/2017 23:27, Mark Cave-Ayland wrote:
> Also touch up the logic in do_pci_register_device() accordingly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/pci/pci.c |   10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 0c6f74a..efc9c86 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -951,6 +951,11 @@ uint16_t pci_requester_id(PCIDevice *dev)
>       return pci_req_id_cache_extract(&dev->requester_id_cache);
>   }
>   
> +static bool pci_bus_devfn_available(PCIBus *bus, int devfn)
> +{
> +    return !(bus->devices[devfn]);
> +}
> +
>   /* -1 for devfn means auto assign */
>   static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>                                            const char *name, int devfn,
> @@ -974,14 +979,15 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
>       if (devfn < 0) {
>           for(devfn = bus->devfn_min ; devfn < ARRAY_SIZE(bus->devices);
>               devfn += PCI_FUNC_MAX) {
> -            if (!bus->devices[devfn])
> +            if (pci_bus_devfn_available(bus, devfn)) {
>                   goto found;
> +            }
>           }
>           error_setg(errp, "PCI: no slot/function available for %s, all in use",
>                      name);
>           return NULL;
>       found: ;
> -    } else if (bus->devices[devfn]) {
> +    } else if (!pci_bus_devfn_available(bus, devfn)) {
>           error_setg(errp, "PCI: slot %d function %d not available for %s,"
>                      " in use by %s",
>                      PCI_SLOT(devfn), PCI_FUNC(devfn), name,
> 

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
