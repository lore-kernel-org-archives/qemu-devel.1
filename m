Received: from eggs.gnu.org ([2001:4830:134:3::10]:55348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gSL18-0007Vc-0z
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gSKlb-00070i-Ow
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:46:02 -0500
Date: Thu, 29 Nov 2018 12:45:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181129124545.18e74622.cohuck@redhat.com>
In-Reply-To: <1542904555-1136-3-git-send-email-pmorel@linux.ibm.com>
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<1542904555-1136-3-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com

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

So, there'll never a mixed environment? Or would that have a 'hybrid'
ap device?

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

Hm?

> -
>  static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>  {
>      vdev->needs_reset = false;
