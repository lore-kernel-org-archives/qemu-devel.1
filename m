Received: from eggs.gnu.org ([2001:4830:134:3::10]:45368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1corDX-0005iD-F9
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 08:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1corDS-0005zA-KN
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 08:42:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1corDS-0005yu-Eq
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 08:42:46 -0400
Date: Fri, 17 Mar 2017 13:42:39 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170317124239.cinuauzt6shpxdik@kamzik.brq.redhat.com>
References: <20170317123242.32579-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170317123242.32579-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio: Fix error handling in
 virtio_bus_device_plugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Mar 17, 2017 at 08:32:42PM +0800, Fam Zheng wrote:
> For one thing we shouldn't continue if an error happened, for the other
> two steps failing can cause an abort() in error_setg because we reuse
> the same errp blindly.
> 
> Add error handling checks to fix both issues.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> ---
> 
> v2: Don't forget the last errp -> &local_err. [Drew]
> ---
>  hw/virtio/virtio-bus.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index a886011..3042232 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
>  #include "qemu/error-report.h"
> +#include "qapi/error.h"
>  #include "hw/qdev.h"
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio.h"
> @@ -48,20 +49,33 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>      VirtioBusClass *klass = VIRTIO_BUS_GET_CLASS(bus);
>      VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
>      bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
> +    Error *local_err = NULL;
>  
>      DPRINTF("%s: plug device.\n", qbus->name);
>  
>      if (klass->pre_plugged != NULL) {
> -        klass->pre_plugged(qbus->parent, errp);
> +        klass->pre_plugged(qbus->parent, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
>      }
>  
>      /* Get the features of the plugged device. */
>      assert(vdc->get_features != NULL);
>      vdev->host_features = vdc->get_features(vdev, vdev->host_features,
> -                                            errp);
> +                                            &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>  
>      if (klass->device_plugged != NULL) {
> -        klass->device_plugged(qbus->parent, errp);
> +        klass->device_plugged(qbus->parent, &local_err);
> +    }
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
>      }
>  
>      if (klass->get_dma_as != NULL && has_iommu) {
> -- 
> 2.9.3
> 
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
