Received: from eggs.gnu.org ([2001:4830:134:3::10]:53506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d5RdE-0001Ub-10
	for qemu-devel@nongnu.org; Tue, 02 May 2017 02:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d5RdA-0007Hg-Sh
	for qemu-devel@nongnu.org; Tue, 02 May 2017 02:49:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d5RdA-0007H7-Jq
	for qemu-devel@nongnu.org; Tue, 02 May 2017 02:49:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v426d50F054116
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 02:49:51 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a6jtxx1dr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 02:49:50 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 2 May 2017 00:49:48 -0600
Date: Tue, 2 May 2017 14:49:41 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
	<20170428130951.44771-10-bjsdjshi@linux.vnet.ibm.com>
	<b348d59f-8352-542a-5957-e015cb706a6d@redhat.com>
	<20170502053738.GE27968@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502053738.GE27968@bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170502064941.GF27968@bjsdjshi@linux.vnet.ibm.com>
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
To: Auger Eric <eric.auger@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, agraf@suse.com

* Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-05-02 13:37:38 +0800]:

[...]
> > > +static void vfio_ccw_unregister_io_notifier(VFIOCCWDevice *vcdev)
> > > +{
> > > +    struct vfio_irq_set *irq_set;
> > > +    size_t argsz;
> > > +    int32_t *pfd;
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
> > > +    *pfd = -1;
> > > +
> > > +    if (ioctl(vcdev->vdev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
> > > +        error_report("vfio: Failed to de-assign device io fd");
> > ditto
> 
> error_report("vfio: Failed to de-assign device io fd: %s",
>              strerror(drrno));
> 
Or:
error_report("vfio: Failed to de-assign device io fd: %m");

> > > +    }
> > > +
> > > +    qemu_set_fd_handler(event_notifier_get_fd(&vcdev->io_notifier),
> > > +                        NULL, NULL, vcdev);
> > > +    event_notifier_cleanup(&vcdev->io_notifier);
> > > +
> > > +    g_free(irq_set);
> > > +}
> > > +
> > >  static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
> > >  {
> > >      VFIODevice *vdev = &vcdev->vdev;
[...]

-- 
Dong Jia Shi
