Received: from eggs.gnu.org ([209.51.188.92]:35991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpVvI-0007fi-I4
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gpVvH-0008LP-Cr
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:19:48 -0500
Date: Fri, 1 Feb 2019 11:19:36 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190201111936.4ba9dfe7.cohuck@redhat.com>
In-Reply-To: <20190130155733.32742-7-david@redhat.com>
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] s390x/pci: Unplug remaining
 requested devices on pcihost reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Pierre Morel <pmorel@linux.ibm.com>

On Wed, 30 Jan 2019 16:57:33 +0100
David Hildenbrand <david@redhat.com> wrote:

> When resetting the guest we should unplug and remove all devices that
> are still pending.
> 
> With this patch, the requested device will be unpluged on reboot
> (S390_RESET_EXTERNAL and S390_RESET_REIPL, which reset the pcihost bridge
> via qemu_devices_reset()).
> 
> This approach is similar to what's done for acpi PCI hotplug in
> acpi_pcihp_reset() -> acpi_pcihp_update() ->
> acpi_pcihp_update_hotplug_bus() -> acpi_pcihp_eject_slot().
> 
> s390_pci_generate_plug_event()'s will still be generated, I guess this
> is not an issue. The same thing would happen right now when unplugging
> a device just before starting the guest.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 867801ccf9..b9b0f44087 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1092,6 +1092,21 @@ static void s390_pcihost_reset(DeviceState *dev)
>  {
>      S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
>      PCIBus *bus = s->parent_obj.bus;
> +    S390PCIBusDevice *pbdev, *next;
> +
> +    /* Process all pending unplug requests */
> +    QTAILQ_FOREACH_SAFE(pbdev, &s->zpci_devs, link, next) {
> +        if (pbdev->unplug_requested) {
> +            if (pbdev->summary_ind) {
> +                pci_dereg_irqs(pbdev);
> +            }
> +            if (pbdev->iommu->enabled) {
> +                pci_dereg_ioat(pbdev->iommu);
> +            }
> +            pbdev->state = ZPCI_FS_STANDBY;
> +            s390_pci_perform_unplug(pbdev);
> +        }
> +    }
>  
>      /*
>       * When resetting a PCI bridge, the assigned numbers are set to 0. So

I'm afraid this one doesn't quite apply without the first patches in
the series, and I'm not sure how to fix it up. I'll either take a
rebase on a codebase without patches 1-3, or this patch together with
patches 1-3 after they get acks (whatever comes first :)
