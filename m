Received: from eggs.gnu.org ([2001:4830:134:3::10]:55190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gKUEu-0005mC-8y
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 15:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gKUEq-0007s1-Q1
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 15:15:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58076
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gKUEq-0007q0-CC
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 15:15:44 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA7KERGO009102
	for <qemu-devel@nongnu.org>; Wed, 7 Nov 2018 15:15:42 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nm4a7xrwn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 15:15:42 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Wed, 7 Nov 2018 20:15:41 -0000
References: <20181105110313.29312-1-david@redhat.com>
	<20181105110313.29312-5-david@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 7 Nov 2018 15:15:36 -0500
MIME-Version: 1.0
In-Reply-To: <20181105110313.29312-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a24b8619-da35-47fa-7fcc-bb610177265d@linux.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 11/5/18 6:03 AM, David Hildenbrand wrote:
> Right now, errors during realize()/pre_plug/plug of the zPCI device
> would result in QEMU crashing instead of failing nicely when creating
> a zPCI device for a PCI device.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
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
> 

LGTM

Reviewed-by: Collin Walling <walling@linux.ibm.com>

-- 
Respectfully,
- Collin Walling
