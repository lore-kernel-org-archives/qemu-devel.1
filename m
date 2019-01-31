Received: from eggs.gnu.org ([209.51.188.92]:59277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gpIv4-0002Vf-9K
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gpIv2-0008DT-9d
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:26:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43554
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gpIv1-0008B4-On
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:26:40 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0VKPwXh017478
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 15:26:37 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qc5umxc1s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 15:26:36 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 31 Jan 2019 20:26:36 -0000
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-7-david@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 31 Jan 2019 15:26:30 -0500
MIME-Version: 1.0
In-Reply-To: <20190130155733.32742-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <81a84f89-218f-f51b-67cc-37d2c0c05aad@linux.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 1/30/19 10:57 AM, David Hildenbrand wrote:
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
>   hw/s390x/s390-pci-bus.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 867801ccf9..b9b0f44087 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1092,6 +1092,21 @@ static void s390_pcihost_reset(DeviceState *dev)
>   {
>       S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
>       PCIBus *bus = s->parent_obj.bus;
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
>       /*
>        * When resetting a PCI bridge, the assigned numbers are set to 0. So
> 

Just "talking out loud" to reaffirm my understanding:

The ..._unplug_request function will have already generated the
deconfigure unplug event, and the unplug_requested flag will be set.
Makes sense -- easy to follow. :)

The callback that this code is essentially replacing used to generate a
CONFIGURED_TO_STBRES plug event, but as I recall from a previous
conversation regarding PCI states, we can skip this event because we're
removing the device from the guest during a reset here (there are a few
reasons why we'd do this, but no sense in listing them here). Also makes
sense to me.

Reviewed-by: Collin Walling <walling@linux.ibm.com>
