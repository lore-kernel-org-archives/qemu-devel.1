Received: from eggs.gnu.org ([2001:4830:134:3::10]:43568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gUatB-0005zn-0I
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gUat5-0008PL-IN
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:23:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54216
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gUat5-0008Kb-AX
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:23:03 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB5H4RYU081935
	for <qemu-devel@nongnu.org>; Wed, 5 Dec 2018 12:23:02 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p6hvmusud-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 12:23:01 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 5 Dec 2018 17:23:00 -0000
Date: Wed, 5 Dec 2018 18:22:53 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <1542904555-1136-3-git-send-email-pmorel@linux.ibm.com>
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<1542904555-1136-3-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181205182253.5eddf585@oc2783563651>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 2/6] s390x/vfio: ap: Use
 the APdevice as a child of the APBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, akrowiak@linux.ibm.com, peter.maydell@linaro.org, david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, agraf@suse.de, eric.auger@redhat.com, qemu-s390x@nongnu.org, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On Thu, 22 Nov 2018 17:35:51 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Two good reasons to use the base device as a child of the
> AP BUS:
> - We can easily find the device without traversing the qtree.
> - In case we have different APdevice instantiation, VFIO with
>   interception or emulation, we will need the APDevice as
>   a parent device.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  hw/s390x/ap-device.c         | 22 ++++++++++++++++++++++
>  hw/vfio/ap.c                 | 16 ++++++----------
>  include/hw/s390x/ap-device.h |  2 ++
>  3 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
> index f5ac8db..554d5aa 100644
> --- a/hw/s390x/ap-device.c
> +++ b/hw/s390x/ap-device.c
> @@ -11,13 +11,35 @@
>  #include "qemu/module.h"
>  #include "qapi/error.h"
>  #include "hw/qdev.h"
> +#include "hw/s390x/ap-bridge.h"
>  #include "hw/s390x/ap-device.h"
>  
> +APDevice *s390_get_ap(void)
> +{
> +    static DeviceState *apb;
> +    BusState *bus;
> +    BusChild *child;
> +    static APDevice *ap;
> +
> +    if (ap) {
> +        return ap;
> +    }
> +
> +    apb = s390_get_ap_bridge();
> +    /* We have only a single child on the BUS */
> +    bus = qdev_get_child_bus(apb, TYPE_AP_BUS);
> +    child = QTAILQ_FIRST(&bus->children);
> +    assert(child != NULL);
> +    ap = DO_UPCAST(APDevice, parent_obj, child->child);
> +    return ap;
> +}
> +
>  static void ap_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      dc->desc = "AP device class";
> +    dc->bus_type = TYPE_AP_BUS;
>      dc->hotpluggable = false;
>  }
>  
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 65de952..94e5a1a 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -35,9 +35,6 @@ typedef struct VFIOAPDevice {
>      VFIODevice vdev;
>  } VFIOAPDevice;
>  
> -#define VFIO_AP_DEVICE(obj) \
> -        OBJECT_CHECK(VFIOAPDevice, (obj), VFIO_AP_DEVICE_TYPE)
> -
>  static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>  {
>      vdev->needs_reset = false;
> @@ -90,8 +87,8 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>      char *mdevid;
>      Error *local_err = NULL;
>      VFIOGroup *vfio_group;
> -    APDevice *apdev = AP_DEVICE(dev);
> -    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
> +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
>  
>      vfio_group = vfio_ap_get_group(vapdev, &local_err);
>      if (!vfio_group) {
> @@ -120,8 +117,8 @@ out_err:
>  
>  static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
>  {
> -    APDevice *apdev = AP_DEVICE(dev);
> -    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
> +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
>      VFIOGroup *group = vapdev->vdev.group;
>  
>      vfio_ap_put_device(vapdev);
> @@ -136,8 +133,8 @@ static Property vfio_ap_properties[] = {
>  static void vfio_ap_reset(DeviceState *dev)
>  {
>      int ret;
> -    APDevice *apdev = AP_DEVICE(dev);
> -    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
> +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
>  
>      ret = ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
>      if (ret) {
> @@ -163,7 +160,6 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
>      dc->unrealize = vfio_ap_unrealize;
>      dc->hotpluggable = false;
>      dc->reset = vfio_ap_reset;
> -    dc->bus_type = TYPE_AP_BUS;

Inheriting this to the parent class as opposed to specifying it here
makes sense. 

>  }
>  
>  static const TypeInfo vfio_ap_info = {
> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
> index 765e908..5f3c840 100644
> --- a/include/hw/s390x/ap-device.h
> +++ b/include/hw/s390x/ap-device.h
> @@ -19,4 +19,6 @@ typedef struct APDevice {
>  #define AP_DEVICE(obj) \
>      OBJECT_CHECK(APDevice, (obj), AP_DEVICE_TYPE)
>  
> +APDevice *s390_get_ap(void);
> +
>  #endif /* HW_S390X_AP_DEVICE_H */
