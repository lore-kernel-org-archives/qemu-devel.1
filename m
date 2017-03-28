Received: from eggs.gnu.org ([2001:4830:134:3::10]:59583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1csle3-0004BK-Pi
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1csle0-0007Q1-LM
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:34:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1csle0-0007Px-Bv
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:34:20 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2S7Vosf145785
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 03:34:18 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29fkh1g5xe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 03:34:18 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 28 Mar 2017 08:34:15 +0100
Date: Tue, 28 Mar 2017 09:34:11 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170327211728-mutt-send-email-mst@kernel.org>
References: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
	<149063676337.4447.2095575576822297032.stgit@bahia.lan>
	<20170327211728-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170328093411.7535b59f.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio: Error object based
 virtio_error()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org

On Mon, 27 Mar 2017 21:20:56 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Mar 27, 2017 at 07:46:03PM +0200, Greg Kurz wrote:
> > This introduces an Error object based implementation of virtio_error(). It
> > allows to implement virtio_error() wrappers in device-specific code.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/virtio/virtio.c         |   21 ++++++++++++++++-----
> >  include/hw/virtio/virtio.h |    1 +
> >  2 files changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 03592c542a55..4036f4816038 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -2443,6 +2443,16 @@ void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name)
> >      vdev->bus_name = g_strdup(bus_name);
> >  }
> >  
> > +static void virtio_device_set_broken(VirtIODevice *vdev)
> > +{
> > +    vdev->broken = true;
> > +
> > +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > +        virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
> > +        virtio_notify_config(vdev);
> > +    }
> > +}
> > +
> >  void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
> >  {
> >      va_list ap;
> 
> It's worth pondering whether we can set this for versions < 1.0 too.

I'm a bit torn there. In theory, setting an unknown status bit should
not really do harm; but we can't be sure that there aren't legacy
drivers out there that will crash when they notice an unknown status
bit, and I'm not sure we want that.

> 
> 
> > @@ -2451,12 +2461,13 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
> >      error_vreport(fmt, ap);
> >      va_end(ap);
> >  
> > -    vdev->broken = true;
> > +    virtio_device_set_broken(vdev);
> > +}
> >  
> > -    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > -        virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
> > -        virtio_notify_config(vdev);
> > -    }
> > +void virtio_error_err(VirtIODevice *vdev, Error *err)
> > +{
> > +    error_report_err(err);
> > +    virtio_device_set_broken(vdev);
> >  }
> >  
> >  static void virtio_memory_listener_commit(MemoryListener *listener)
> 
> Should this skip error report if device is already broken?
> Otherwise we'll get a ton of errors in the log.

One would hope that qemu stops processing broken devices, but a check
might be better.

> 
> Also, whether to stop the device, or the VM, or just warn,
> seems like a policy decision. Why not set it on command line
> like we do for other storage?

I would trust the device implementation to make the decision: Can we
recover, can we start using the device again after a reset, or are we
so broken that we want to terminate the vm?

Note that all of this already applies to the existing virtio_error(); I
think we should discuss this independently of this patch.
