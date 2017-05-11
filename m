Received: from eggs.gnu.org ([2001:4830:134:3::10]:46378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d8vxO-00041z-Sn
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d8vxN-0001Dj-U2
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:49:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d8vxN-0001D8-Kk
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:49:09 -0400
Date: Thu, 11 May 2017 15:49:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170511154904.30185793@w520.home>
In-Reply-To: <20170505020352.8984-10-bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
	<20170505020352.8984-10-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 09/13] vfio/ccw: get irqs info and set
 the eventfd fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, eric.auger@redhat.com

On Fri,  5 May 2017 04:03:48 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> vfio-ccw resorts to the eventfd mechanism to communicate with userspace.
> We fetch the irqs info via the ioctl VFIO_DEVICE_GET_IRQ_INFO,
> register a event notifier to get the eventfd fd which is sent
> to kernel via the ioctl VFIO_DEVICE_SET_IRQS, then we can implement
> read operation once kernel sends the signal.
> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  hw/vfio/ccw.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 7ddcfd7..6760cee 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -22,6 +22,7 @@
>  #include "hw/vfio/vfio-common.h"
>  #include "hw/s390x/s390-ccw.h"
>  #include "hw/s390x/ccw-device.h"
> +#include "qemu/error-report.h"
>  
>  #define TYPE_VFIO_CCW "vfio-ccw"
>  typedef struct VFIOCCWDevice {
> @@ -30,6 +31,7 @@ typedef struct VFIOCCWDevice {
>      uint64_t io_region_size;
>      uint64_t io_region_offset;
>      struct ccw_io_region *io_region;
> +    EventNotifier io_notifier;
>  } VFIOCCWDevice;
>  
>  static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
> @@ -54,6 +56,99 @@ static void vfio_ccw_reset(DeviceState *dev)
>      ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
>  }
>  
> +static void vfio_ccw_io_notifier_handler(void *opaque)
> +{
> +    VFIOCCWDevice *vcdev = opaque;
> +
> +    if (!event_notifier_test_and_clear(&vcdev->io_notifier)) {
> +        return;
> +    }
> +}
> +
> +static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
> +{
> +    VFIODevice *vdev = &vcdev->vdev;
> +    struct vfio_irq_info *irq_info;
> +    struct vfio_irq_set *irq_set;
> +    size_t argsz;
> +    int32_t *pfd;
> +
> +    if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
> +        error_setg(errp, "vfio: unexpected number of io irqs %u",
> +                   vdev->num_irqs);
> +        return;
> +    }
> +
> +    argsz = sizeof(*irq_set);
> +    irq_info = g_malloc0(argsz);
> +    irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
> +    irq_info->argsz = argsz;
> +    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
> +              irq_info) < 0 || irq_info->count < 1) {
> +        error_setg_errno(errp, errno, "vfio: Error getting irq info");
> +        goto get_error;
> +    }
> +
> +    if (event_notifier_init(&vcdev->io_notifier, 0)) {
> +        error_setg_errno(errp, errno,
> +                         "vfio: Unable to init event notifier for IO");
> +        goto get_error;
> +    }
> +
> +    argsz = sizeof(*irq_set) + sizeof(*pfd);
> +    irq_set = g_malloc0(argsz);
> +    irq_set->argsz = argsz;
> +    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> +                     VFIO_IRQ_SET_ACTION_TRIGGER;
> +    irq_set->index = VFIO_CCW_IO_IRQ_INDEX;
> +    irq_set->start = 0;
> +    irq_set->count = 1;
> +    pfd = (int32_t *) &irq_set->data;
> +
> +    *pfd = event_notifier_get_fd(&vcdev->io_notifier);
> +    qemu_set_fd_handler(*pfd, vfio_ccw_io_notifier_handler, NULL, vcdev);
> +    if (ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> +        error_setg(errp, "vfio: Failed to set up io notification");
> +        qemu_set_fd_handler(*pfd, NULL, NULL, vcdev);
> +        event_notifier_cleanup(&vcdev->io_notifier);
> +        goto set_error;


nit, unnecessary goto here.  set_error label is unused if removed.

Otherwise,

Acked-by: Alex Williamson <alex.williamson@redhat.com>


> +    }
> +
> +set_error:
> +    g_free(irq_set);
> +
> +get_error:
> +    g_free(irq_info);
> +}
> +
> +static void vfio_ccw_unregister_io_notifier(VFIOCCWDevice *vcdev)
> +{
> +    struct vfio_irq_set *irq_set;
> +    size_t argsz;
> +    int32_t *pfd;
> +
> +    argsz = sizeof(*irq_set) + sizeof(*pfd);
> +    irq_set = g_malloc0(argsz);
> +    irq_set->argsz = argsz;
> +    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> +                     VFIO_IRQ_SET_ACTION_TRIGGER;
> +    irq_set->index = VFIO_CCW_IO_IRQ_INDEX;
> +    irq_set->start = 0;
> +    irq_set->count = 1;
> +    pfd = (int32_t *) &irq_set->data;
> +    *pfd = -1;
> +
> +    if (ioctl(vcdev->vdev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> +        error_report("vfio: Failed to de-assign device io fd: %m");
> +    }
> +
> +    qemu_set_fd_handler(event_notifier_get_fd(&vcdev->io_notifier),
> +                        NULL, NULL, vcdev);
> +    event_notifier_cleanup(&vcdev->io_notifier);
> +
> +    g_free(irq_set);
> +}
> +
>  static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
>  {
>      VFIODevice *vdev = &vcdev->vdev;
> @@ -173,8 +268,15 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>          goto out_region_err;
>      }
>  
> +    vfio_ccw_register_io_notifier(vcdev, &err);
> +    if (err) {
> +        goto out_notifier_err;
> +    }
> +
>      return;
>  
> +out_notifier_err:
> +    vfio_ccw_put_region(vcdev);
>  out_region_err:
>      vfio_put_device(vcdev);
>  out_device_err:
> @@ -195,6 +297,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
>      S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
>      VFIOGroup *group = vcdev->vdev.group;
>  
> +    vfio_ccw_unregister_io_notifier(vcdev);
>      vfio_ccw_put_region(vcdev);
>      vfio_put_device(vcdev);
>      vfio_put_group(group);
