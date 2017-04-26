Received: from eggs.gnu.org ([2001:4830:134:3::10]:45472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d3WaR-0004hb-3d
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 19:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d3WaN-0006kV-6s
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 19:43:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d3WaM-0006kG-TM
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 19:43:03 -0400
Date: Thu, 27 Apr 2017 02:42:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170427024124-mutt-send-email-mst@kernel.org>
References: <149321107781.13002.9081643707477650100.stgit@bahia.lan>
	<20170426151548.0b30d39c.cornelia.huck@de.ibm.com>
	<20170426152946.5d7a4922@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426152946.5d7a4922@bahia>
Subject: Re: [Qemu-devel] [PATCH] virtio: allow broken device to notify guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Apr 26, 2017 at 03:29:46PM +0200, Greg Kurz wrote:
> On Wed, 26 Apr 2017 15:15:48 +0200
> Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> 
> > On Wed, 26 Apr 2017 14:51:17 +0200
> > Greg Kurz <groug@kaod.org> wrote:
> > 
> > > According to section 2.1.2 of the virtio-1 specification:
> > > 
> > > "The device SHOULD set DEVICE_NEEDS_RESET when it enters an error state that
> > > a reset is needed. If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET,
> > > the device MUST send a device configuration change notification to the
> > > driver."
> > > 
> > > Commit "f5ed36635d8f virtio: stop virtqueue processing if device is broken"
> > > introduced a virtio_error() call that just does that:
> > > 
> > > - internally mark the device as broken
> > > - set the DEVICE_NEEDS_RESET bit in the status
> > > - send a configuration change notification
> > > 
> > > Unfortunately, virtio_notify_vector(), called by virtio_notify_config(),
> > > returns right away when the device is marked as broken and the notification
> > > isn't sent in this case.
> > > 
> > > The spec doesn't say whether a broken device can send notifications
> > > in other situations or not. But since the driver isn't supposed to do
> > > anything but to reset the device, it makes sense to keep the check in
> > > virtio_notify_config().
> > > 
> > > Marking the device as broken AFTER the configuration change notification was
> > > sent is enough to fix the issue.
> > > 
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/virtio/virtio.c |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index 03592c542a55..890b4d7eb751 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -2451,12 +2451,12 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
> > >      error_vreport(fmt, ap);
> > >      va_end(ap);
> > > 
> > > -    vdev->broken = true;
> > > -
> > >      if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > >          virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
> > >          virtio_notify_config(vdev);
> > >      }
> > > +
> > > +    vdev->broken = true;
> > >  }
> > > 
> > >  static void virtio_memory_listener_commit(MemoryListener *listener)
> > >   
> > 
> > Good catch.
> > 
> > Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > 
> > Should this be cc:stable, as it's a spec violation?
> > 
> 
> I don't know if this qualifies for stable, but if it does then it affects
> all versions >= 2.8.0.


It's a SHOULD so not a violation, just a quality of implementation
issue. Seems a bit too intrusive for stable and we are yet to
have drivers actually handling these errors, so let's wait a bit
and see.

I'll apply this to master for now.


-- 
MST
