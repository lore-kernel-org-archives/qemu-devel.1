Received: from eggs.gnu.org ([2001:4830:134:3::10]:53434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dA5rb-0006Xt-Ev
	for qemu-devel@nongnu.org; Sun, 14 May 2017 22:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dA5rY-0004JW-9b
	for qemu-devel@nongnu.org; Sun, 14 May 2017 22:35:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dA5rX-0004JN-Vg
	for qemu-devel@nongnu.org; Sun, 14 May 2017 22:35:56 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4F2YA65143960
	for <qemu-devel@nongnu.org>; Sun, 14 May 2017 22:35:54 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aee6tv0vj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 14 May 2017 22:35:54 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Sun, 14 May 2017 20:35:53 -0600
Date: Mon, 15 May 2017 10:35:46 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
	<20170505020352.8984-10-bjsdjshi@linux.vnet.ibm.com>
	<20170511154904.30185793@w520.home>
	<20170515023148.GB11226@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170515023148.GB11226@bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170515023546.GC11226@bjsdjshi@linux.vnet.ibm.com>
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
To: Alex Williamson <alex.williamson@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, eric.auger@redhat.com

* Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-05-15 10:31:48 +0800]:

> * Alex Williamson <alex.williamson@redhat.com> [2017-05-11 15:49:04 -0600]:
> 
> Hi Alex,
> 
> [...]
> 
> > > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > > index 7ddcfd7..6760cee 100644
> > > --- a/hw/vfio/ccw.c
> > > +++ b/hw/vfio/ccw.c
> 
> [...]
> 
> > > +static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
> > > +{
> > > +    VFIODevice *vdev = &vcdev->vdev;
> > > +    struct vfio_irq_info *irq_info;
> > > +    struct vfio_irq_set *irq_set;
> > > +    size_t argsz;
> > > +    int32_t *pfd;
> > > +
> > > +    if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
> > > +        error_setg(errp, "vfio: unexpected number of io irqs %u",
> > > +                   vdev->num_irqs);
> > > +        return;
> > > +    }
> > > +
> > > +    argsz = sizeof(*irq_set);
> > > +    irq_info = g_malloc0(argsz);
> > > +    irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
> > > +    irq_info->argsz = argsz;
> > > +    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
> > > +              irq_info) < 0 || irq_info->count < 1) {
> > > +        error_setg_errno(errp, errno, "vfio: Error getting irq info");
> > > +        goto get_error;
> > > +    }
> > > +
> > > +    if (event_notifier_init(&vcdev->io_notifier, 0)) {
> > > +        error_setg_errno(errp, errno,
> > > +                         "vfio: Unable to init event notifier for IO");
> > > +        goto get_error;
> > > +    }
> > > +
> > > +    argsz = sizeof(*irq_set) + sizeof(*pfd);
> > > +    irq_set = g_malloc0(argsz);
> > > +    irq_set->argsz = argsz;
> > > +    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
> > > +                     VFIO_IRQ_SET_ACTION_TRIGGER;
> > > +    irq_set->index = VFIO_CCW_IO_IRQ_INDEX;
> > > +    irq_set->start = 0;
> > > +    irq_set->count = 1;
> > > +    pfd = (int32_t *) &irq_set->data;
> > > +
> > > +    *pfd = event_notifier_get_fd(&vcdev->io_notifier);
> > > +    qemu_set_fd_handler(*pfd, vfio_ccw_io_notifier_handler, NULL, vcdev);
> > > +    if (ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> > > +        error_setg(errp, "vfio: Failed to set up io notification");
> > > +        qemu_set_fd_handler(*pfd, NULL, NULL, vcdev);
> > > +        event_notifier_cleanup(&vcdev->io_notifier);
> > > +        goto set_error;
> > 
> > 
> > nit, unnecessary goto here.  set_error label is unused if removed.
> Ok, I will remove both this goto line and the set_error label line!
> 
And rename get_error to out_free_info, which is the more reasonable
label name to me. :>

> > 
> > Otherwise,
> > 
> > Acked-by: Alex Williamson <alex.williamson@redhat.com>
> > 
> > 
> Thanks for all of your A-Bs! I will add them in next version.
> 
> > > +    }
> > > +
> > > +set_error:
> > > +    g_free(irq_set);
> > > +
> > > +get_error:
> > > +    g_free(irq_info);
> > > +}
> > > +
> 
> [...]
> 
> -- 
> Dong Jia Shi

-- 
Dong Jia Shi
