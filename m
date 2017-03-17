Received: from eggs.gnu.org ([2001:4830:134:3::10]:52709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cowX3-0005SI-H7
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 14:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cowWy-0006lE-K4
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 14:23:21 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cowWy-0006k4-Di
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 14:23:16 -0400
Received: by mail-qt0-x244.google.com with SMTP id n37so10456974qtb.3
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 11:23:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170317123242.32579-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a2c5cc0f-fcb3-3578-bfef-a85e6bcfc646@amsat.org>
Date: Fri, 17 Mar 2017 15:23:12 -0300
MIME-Version: 1.0
In-Reply-To: <20170317123242.32579-1-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: cornelia.huck@de.ibm.com, drjones@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On 03/17/2017 09:32 AM, Fam Zheng wrote:
> For one thing we shouldn't continue if an error happened, for the other
> two steps failing can cause an abort() in error_setg because we reuse
> the same errp blindly.
>
> Add error handling checks to fix both issues.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>
