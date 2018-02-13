Received: from eggs.gnu.org ([2001:4830:134:3::10]:52592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1elize-0004bM-D2
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 17:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eliza-0005ft-E8
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 17:24:06 -0500
Date: Wed, 14 Feb 2018 00:23:44 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180214001809-mutt-send-email-mst@kernel.org>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
	<1513866427-27125-11-git-send-email-mst@redhat.com>
	<800aef3f-56c1-b896-1c93-24e2a523833d@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <800aef3f-56c1-b896-1c93-24e2a523833d@kamp.de>
Subject: Re: [Qemu-devel] [Qemu-stable] [PULL 10/25] virtio_error: don't
 invoke status callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, Ilya Maximets <i.maximets@samsung.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org

On Tue, Feb 13, 2018 at 09:53:58PM +0100, Peter Lieven wrote:
> 
> Am 21.12.2017 um 15:29 schrieb Michael S. Tsirkin:
> > Backends don't need to know what frontend requested a reset,
> > and notifying then from virtio_error is messy because
> > virtio_error itself might be invoked from backend.
> >
> > Let's just set the status directly.
> >
> > Cc: qemu-stable@nongnu.org
> > Reported-by: Ilya Maximets <i.maximets@samsung.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/virtio/virtio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index ad564b0..d6002ee 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -2469,7 +2469,7 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
> >      va_end(ap);
> >  
> >      if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > -        virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
> > +        vdev->status = vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET;
> >          virtio_notify_config(vdev);
> >      }
> >  
> 
> 
> Is it possible that this patch introduces a stall in I/O and a deadlock on a drain all?
> 
> I have seen Qemu VMs being I/O stalled and deadlocking on a vm stop command in
> 
> blk_drain_all. This happened after a longer storage outage.
> 
> 
> I am asking just theoretically because I have seen this behaviour first when we
> 
> backported this patch in our stable 2.9 branch.
> 
> 
> Thank you,
> 
> Peter

Well - this patch was introduced to fix a crash, but
a well behaved VM should not trigger VIRTIO_CONFIG_S_NEEDS_RESET -
did you see any error messages in the log when this triggered?

-- 
MST
