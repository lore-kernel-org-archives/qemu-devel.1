Received: from eggs.gnu.org ([209.51.188.92]:33182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1go57i-0003W6-EF
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1go57Y-0005EO-6k
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:30:35 -0500
Date: Mon, 28 Jan 2019 12:24:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190128122448.4c99fe97.cohuck@redhat.com>
In-Reply-To: <20190122094143.8857-1-david@redhat.com>
References: <20190122094143.8857-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/pci: Warn when adding PCI devices
 without the 'zpci' feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On Tue, 22 Jan 2019 10:41:43 +0100
David Hildenbrand <david@redhat.com> wrote:

> We decided to always create the PCI host bridge, even if 'zpci' is not
> enabled (due to migration compatibility). This however right now allows
> to add zPCI/PCI devices to a VM although the guest will never actually see
> them, confusing people that are using a simple CPU model that has no
> 'zpci' enabled - "Why isn't this working" (David Hildenbrand)
> 
> Let's check for 'zpci' and at least print a warning that this will not
> work as expected. We could also bail out, however that might break
> existing QEMU commandlines.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index b86a8bdcd4..e7d4f49611 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -863,6 +863,11 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  {
>      S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>  
> +    if (!s390_has_feat(S390_FEAT_ZPCI)) {
> +        warn_report("Adding PCI or zPCI devices without the 'zpci' CPU feature."
> +                    " The guest will not be able to see/use these devices.");
> +    }
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>          PCIDevice *pdev = PCI_DEVICE(dev);
>  

So, it seems that the consensus was that this patch is fine in its
current shape, right? If so, can I please get an ack from the zpci
maintainer so I can queue it?
