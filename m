Received: from eggs.gnu.org ([2001:4830:134:3::10]:36577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKkT8-0002bz-6H
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKkT2-0007hq-Vs
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:35:32 -0500
Date: Thu, 8 Nov 2018 14:35:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181108143501.0f2427d2.cohuck@redhat.com>
In-Reply-To: <20181105110313.29312-5-david@redhat.com>
References: <20181105110313.29312-1-david@redhat.com>
	<20181105110313.29312-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/4] s390x/zpci: properly fail if the
 zPCI device cannot be created
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

On Mon,  5 Nov 2018 12:03:13 +0100
David Hildenbrand <david@redhat.com> wrote:

> Right now, errors during realize()/pre_plug/plug of the zPCI device
> would result in QEMU crashing instead of failing nicely when creating
> a zPCI device for a PCI device.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)

Unfortunately, this patch applied as-is on top of master breaks zpci
device autogeneration:

-device zpci,target=pcidev -device virtio-net-pci,id=pcidev works

-device virtio-net-pci fails with

qemu-system-s390x: -device virtio-net-pci: zPCI device could not be created: Property '.auto_00:00.0' not found

Any idea?

[insert my usual rants about the zpci architecture here]

> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 1849f9d334..4939490c7c 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -778,17 +778,31 @@ static void s390_pci_msix_free(S390PCIBusDevice *pbdev)
>  }
>  
>  static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
> -                                             const char *target)
> +                                             const char *target, Error **errp)
>  {
> -    DeviceState *dev = NULL;
> +    Error *local_err = NULL;
> +    DeviceState *dev;
>  
>      dev = qdev_try_create(BUS(s->bus), TYPE_S390_PCI_DEVICE);
>      if (!dev) {
> +        error_setg(errp, "zPCI device could not be created");
>          return NULL;
>      }
>  
> -    qdev_prop_set_string(dev, "target", target);
> -    qdev_init_nofail(dev);
> +    object_property_set_str(OBJECT(dev), "target", target, &local_err);
> +    if (local_err) {
> +        object_unparent(OBJECT(dev));
> +        error_propagate_prepend(errp, local_err,
> +                                "zPCI device could not be created: ");
> +        return NULL;
> +    }
> +    object_property_set_bool(OBJECT(dev), true, "realized", &local_err);
> +    if (local_err) {
> +        object_unparent(OBJECT(dev));
> +        error_propagate_prepend(errp, local_err,
> +                                "zPCI device could not be created: ");
> +        return NULL;
> +    }
>  
>      return S390_PCI_DEVICE(dev);
>  }
> @@ -873,9 +887,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  
>          pbdev = s390_pci_find_dev_by_target(s, dev->id);
>          if (!pbdev) {
> -            pbdev = s390_pci_device_new(s, dev->id);
> +            pbdev = s390_pci_device_new(s, dev->id, errp);
>              if (!pbdev) {
> -                error_setg(errp, "create zpci device failed");
>                  return;
>              }
>          }
