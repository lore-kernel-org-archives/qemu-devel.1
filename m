Received: from eggs.gnu.org ([2001:4830:134:3::10]:43396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJcxC-0000DG-Dx
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:21:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gJcxB-0007m0-Dj
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:21:58 -0500
Date: Mon, 5 Nov 2018 12:21:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181105122148.2eae5288.cohuck@redhat.com>
In-Reply-To: <20181105110313.29312-3-david@redhat.com>
References: <20181105110313.29312-1-david@redhat.com>
	<20181105110313.29312-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/4] s390x/zpci: use hotplug_dev instead
 of looking up the host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, =Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>

On Mon,  5 Nov 2018 12:03:11 +0100
David Hildenbrand <david@redhat.com> wrote:

> We directly have it in our hands.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 1eaae3aca6..68660eac74 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -814,9 +814,9 @@ static bool s390_pci_alloc_idx(S390pciState *s, S390PCIBusDevice *pbdev)
>  static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                Error **errp)
>  {
> +    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>      PCIDevice *pdev = NULL;
>      S390PCIBusDevice *pbdev = NULL;
> -    S390pciState *s = s390_get_phb();
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>          BusState *bus;
> @@ -924,11 +924,11 @@ static void s390_pcihost_timer_cb(void *opaque)
>  static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                  Error **errp)
>  {
> +    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>      PCIDevice *pci_dev = NULL;
>      PCIBus *bus;
>      int32_t devfn;
>      S390PCIBusDevice *pbdev = NULL;
> -    S390pciState *s = s390_get_phb();
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>          error_setg(errp, "PCI bridge hot unplug currently not supported");

Not sure whether that is an improvement (s390_get_phb() caches the
value, and is called from multiple other places as well.)
