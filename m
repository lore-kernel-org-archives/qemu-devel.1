Received: from eggs.gnu.org ([2001:4830:134:3::10]:45436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gST90-0007aD-A1
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gST8v-0008UH-A1
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:42:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44040
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gST8v-0008U2-3z
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:42:37 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wATKcwWJ041612
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 15:42:36 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p2p55kakj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 15:42:36 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Thu, 29 Nov 2018 20:42:35 -0000
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<1542904555-1136-3-git-send-email-pmorel@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 29 Nov 2018 15:42:29 -0500
MIME-Version: 1.0
In-Reply-To: <1542904555-1136-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <07102a0f-d37e-b9a6-047e-370bc3209686@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] s390x/vfio: ap: Use the APdevice as
 a child of the APBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, pasic@linux.ibm.com

On 11/22/18 11:35 AM, Pierre Morel wrote:
> Two good reasons to use the base device as a child of the
> AP BUS:
> - We can easily find the device without traversing the qtree.
> - In case we have different APdevice instantiation, VFIO with
>    interception or emulation, we will need the APDevice as
>    a parent device.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   hw/s390x/ap-device.c         | 22 ++++++++++++++++++++++
>   hw/vfio/ap.c                 | 16 ++++++----------
>   include/hw/s390x/ap-device.h |  2 ++
>   3 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/s390x/ap-device.c b/hw/s390x/ap-device.c
> index f5ac8db..554d5aa 100644
> --- a/hw/s390x/ap-device.c
> +++ b/hw/s390x/ap-device.c
> @@ -11,13 +11,35 @@
>   #include "qemu/module.h"
>   #include "qapi/error.h"
>   #include "hw/qdev.h"
> +#include "hw/s390x/ap-bridge.h"
>   #include "hw/s390x/ap-device.h"
>   
> +APDevice *s390_get_ap(void)

How about ap_get_device(void)?

> +{
> +    static DeviceState *apb;

Why static if you call s390_get_ap_bridge()
to retrieve it without first checking for NULL?

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
> +    bus = qdev_get_child_bus(apb, TYPE_AP_BUS
> +    child = QTAILQ_FIRST(&bus->children);
> +    assert(child != NULL);
> +    ap = DO_UPCAST(APDevice, parent_obj, child->child);

I received a comment from Thomas Huth in Message ID
<2291104a-4cbf-e4fd-3496-fa0910beb96a@redhat.com>
that DO_UPCAST should be avoided in new code. You should
create an AP_DEVICE macro for this in ap-device.h

> +    return ap;
> +}
> +
>   static void ap_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       dc->desc = "AP device class";
> +    dc->bus_type = TYPE_AP_BUS;
>       dc->hotpluggable = false;
>   }
>   
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 65de952..94e5a1a 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -35,9 +35,6 @@ typedef struct VFIOAPDevice {See my comment above about DO_UPCAST
>       VFIODevice vdev;
>   } VFIOAPDevice;
>   
> -#define VFIO_AP_DEVICE(obj) \
> -        OBJECT_CHECK(VFIOAPDevice, (obj), VFIO_AP_DEVICE_TYPE)
> -
>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>   {
>       vdev->needs_reset = false;
> @@ -90,8 +87,8 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>       char *mdevid;
>       Error *local_err = NULL;
>       VFIOGroup *vfio_group;
> -    APDevice *apdev = AP_DEVICE(dev);
> -    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);See my comment above about DO_UPCAST
> +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);

See my comment above about DO_UPCAST.

>   
>       vfio_group = vfio_ap_get_group(vapdev, &local_err);
>       if (!vfio_group) {
> @@ -120,8 +117,8 @@ out_err:
>   
>   static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
>   {
> -    APDevice *apdev = AP_DEVICE(dev);
> -    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
> +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);

See my comment above about DO_UPCAST

>       VFIOGroup *group = vapdev->vdev.group;
>   
>       vfio_ap_put_device(vapdev);
> @@ -136,8 +133,8 @@ static Property vfio_ap_properties[] = {
>   static void vfio_ap_reset(DeviceState *dev)
>   {
>       int ret;
> -    APDevice *apdev = AP_DEVICE(dev);
> -    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);

FYI, these macros were created in response to Thomas Huth's
comments about DO_UPCAST.

> +    APDevice *apdev = DO_UPCAST(APDevice, parent_obj, dev);
> +    VFIOAPDevice *vapdev = DO_UPCAST(VFIOAPDevice, apdev, apdev);
>   
>       ret = ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
>       if (ret) {
> @@ -163,7 +160,6 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
>       dc->unrealize = vfio_ap_unrealize;
>       dc->hotpluggable = false;
>       dc->reset = vfio_ap_reset;
> -    dc->bus_type = TYPE_AP_BUS;
>   }
>   
>   static const TypeInfo vfio_ap_info = {
> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
> index 765e908..5f3c840 100644
> --- a/include/hw/s390x/ap-device.h
> +++ b/include/hw/s390x/ap-device.h
> @@ -19,4 +19,6 @@ typedef struct APDevice {
>   #define AP_DEVICE(obj) \
>       OBJECT_CHECK(APDevice, (obj), AP_DEVICE_TYPE)
>   
> +APDevice *s390_get_ap(void);

How about APDevice *ap_get_device(void)?

> +
>   #endif /* HW_S390X_AP_DEVICE_H */
> 
