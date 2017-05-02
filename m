Received: from eggs.gnu.org ([2001:4830:134:3::10]:53637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d5QVT-0005vS-Ap
	for qemu-devel@nongnu.org; Tue, 02 May 2017 01:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d5QVQ-0007sf-78
	for qemu-devel@nongnu.org; Tue, 02 May 2017 01:37:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d5QVP-0007qw-Tm
	for qemu-devel@nongnu.org; Tue, 02 May 2017 01:37:48 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v425Sd17090087
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 01:37:46 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a68w0bj0g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 01:37:46 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 1 May 2017 23:37:45 -0600
Date: Tue, 2 May 2017 13:37:38 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
	<20170428130951.44771-10-bjsdjshi@linux.vnet.ibm.com>
	<b348d59f-8352-542a-5957-e015cb706a6d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b348d59f-8352-542a-5957-e015cb706a6d@redhat.com>
Message-Id: <20170502053738.GE27968@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 09/13] vfio/ccw: get irqs info and set
 the eventfd fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, agraf@suse.com

* Auger Eric <eric.auger@redhat.com> [2017-05-01 13:08:45 +0200]:

Hi Eric,

> Hi,
> On 28/04/2017 15:09, Dong Jia Shi wrote:
> > vfio-ccw resorts to the eventfd mechanism to communicate with userspace.
> > We fetch the irqs info via the ioctl VFIO_DEVICE_GET_IRQ_INFO,
> > register a event notifier to get the eventfd fd which is sent
> > to kernel via the ioctl VFIO_DEVICE_SET_IRQS, then we can implement
> > read operation once kernel sends the signal.
> > 
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > ---
> >  hw/vfio/ccw.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> > 
> > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > index a285b23..cda3057 100644
> > --- a/hw/vfio/ccw.c
> > +++ b/hw/vfio/ccw.c
> > @@ -22,6 +22,7 @@
> >  #include "hw/vfio/vfio-common.h"
> >  #include "hw/s390x/s390-ccw.h"
> >  #include "hw/s390x/ccw-device.h"
> > +#include "qemu/error-report.h"
> >  
> >  #define TYPE_VFIO_CCW "vfio-ccw"
> >  typedef struct VFIOCCWDevice {
> > @@ -30,6 +31,7 @@ typedef struct VFIOCCWDevice {
> >      uint64_t io_region_size;
> >      uint64_t io_region_offset;
> >      struct ccw_io_region *io_region;
> > +    EventNotifier io_notifier;
> >  } VFIOCCWDevice;
> >  
> >  static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
> > @@ -54,6 +56,98 @@ static void vfio_ccw_reset(DeviceState *dev)
> >      ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
> >  }
> >  
> > +static void vfio_ccw_io_notifier_handler(void *opaque)
> > +{
> > +    VFIOCCWDevice *vcdev = opaque;
> > +
> > +    if (!event_notifier_test_and_clear(&vcdev->io_notifier)) {
> > +        return;
> > +    }
> > +}
> > +
> > +static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
> > +{
> > +    VFIODevice *vdev = &vcdev->vdev;
> > +    struct vfio_irq_info *irq_info;
> > +    struct vfio_irq_set *irq_set;
> > +    size_t argsz;
> > +    int32_t *pfd;
> > +
> > +    if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
> > +        error_setg(errp, "vfio: unexpected number of io irqs %u",
> > +                   vdev->num_irqs);
> > +        return;
> > +    }
> > +
> > +    argsz = sizeof(*irq_set);
> > +    irq_info = g_malloc0(argsz);
> > +    irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
> > +    irq_info->argsz = argsz;
> > +    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
> > +              irq_info) < 0 || irq_info->count < 1) {
> > +        error_setg(errp, "vfio: Error getting irq info");
> nit: error_setg_errno?
Ok.

> > +        goto get_error;
> > +    }
> > +
> > +    if (event_notifier_init(&vcdev->io_notifier, 0)) {
> > +        error_setg(errp, "vfio: Unable to init event notifier for IO");
> nit: same
Ok.

> > +        goto get_error;
> > +    }
> > +
> > +    argsz = sizeof(*irq_set) + sizeof(*pfd);
> > +    irq_set = g_malloc0(argsz);
> > +    irq_set->argsz = argsz;
> > +    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> > +                     VFIO_IRQ_SET_ACTION_TRIGGER;
> > +    irq_set->index = VFIO_CCW_IO_IRQ_INDEX;
> > +    irq_set->start = 0;
> > +    irq_set->count = 1;
> > +    pfd = (int32_t *) &irq_set->data;
> > +
> > +    *pfd = event_notifier_get_fd(&vcdev->io_notifier);
> > +    qemu_set_fd_handler(*pfd, vfio_ccw_io_notifier_handler, NULL, vcdev);
> > +    if (ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> > +        error_setg(errp, "vfio: Failed to set up io notification");
> > +        qemu_set_fd_handler(*pfd, NULL, NULL, vcdev);
> > +        event_notifier_cleanup(&vcdev->io_notifier);
> > +        goto set_error;
> > +    }
> > +
> > +set_error:
> > +    g_free(irq_set);
> > +
> > +get_error:
> > +    g_free(irq_info);
> > +}
> > +
> > +static void vfio_ccw_unregister_io_notifier(VFIOCCWDevice *vcdev)
> > +{
> > +    struct vfio_irq_set *irq_set;
> > +    size_t argsz;
> > +    int32_t *pfd;
> > +
> > +    argsz = sizeof(*irq_set) + sizeof(*pfd);
> > +    irq_set = g_malloc0(argsz);
> > +    irq_set->argsz = argsz;
> > +    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> > +                     VFIO_IRQ_SET_ACTION_TRIGGER;
> > +    irq_set->index = VFIO_CCW_IO_IRQ_INDEX;
> > +    irq_set->start = 0;
> > +    irq_set->count = 1;
> > +    pfd = (int32_t *) &irq_set->data;
> > +    *pfd = -1;
> > +
> > +    if (ioctl(vcdev->vdev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> > +        error_report("vfio: Failed to de-assign device io fd");
> ditto

error_report("vfio: Failed to de-assign device io fd: %s",
             strerror(drrno));

> > +    }
> > +
> > +    qemu_set_fd_handler(event_notifier_get_fd(&vcdev->io_notifier),
> > +                        NULL, NULL, vcdev);
> > +    event_notifier_cleanup(&vcdev->io_notifier);
> > +
> > +    g_free(irq_set);
> > +}
> > +
> >  static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
> >  {
> >      VFIODevice *vdev = &vcdev->vdev;
> > @@ -175,8 +269,15 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
> >          goto out_region_err;
> >      }
> >  
> > +    vfio_ccw_register_io_notifier(vcdev, errp);
> > +    if (*errp) {
> ditto
Ok.

> 
> Thanks
> 
> Eric
> > +        goto out_notifier_err;
> > +    }
> > +
> >      return;
> >  
> > +out_notifier_err:
> > +    vfio_ccw_put_region(vcdev);
> >  out_region_err:
> >      vfio_put_device(vcdev);
> >  out_device_err:
> > @@ -195,6 +296,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
> >      S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
> >      VFIOGroup *group = vcdev->vdev.group;
> >  
> > +    vfio_ccw_unregister_io_notifier(vcdev);
> >      vfio_ccw_put_region(vcdev);
> >      vfio_put_device(vcdev);
> >      vfio_put_group(group);
> > 
> 

-- 
Dong Jia Shi
