Received: from eggs.gnu.org ([209.51.188.92]:34152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go9Ls-0006n8-NS
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go9Lf-0000gf-Ta
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:01:27 -0500
Date: Mon, 28 Jan 2019 17:01:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190128160109.GF5756@localhost.localdomain>
References: <cover.1548171741.git.berto@igalia.com>
	<6ad371df66eecffccce29a0bd14695f40edd6120.1548171741.git.berto@igalia.com>
	<735410dc-a63e-6a28-4526-2caa810a797d@redhat.com>
	<w518szbmmw9.fsf@maestria.local.igalia.com>
	<b3e3cb90-32a6-77b0-1c5b-8281181c8ae8@redhat.com>
	<w5136pjmjrp.fsf@maestria.local.igalia.com>
	<20190124091222.GB4601@localhost.localdomain>
	<w51d0ogsv1y.fsf@maestria.local.igalia.com>
	<20190128145743.GC5756@localhost.localdomain>
	<w517eeoss2l.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w517eeoss2l.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] virtio-scsi: Forbid devices with
 different iothreads sharing a blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 28.01.2019 um 16:46 hat Alberto Garcia geschrieben:
> On Mon 28 Jan 2019 03:57:43 PM CET, Kevin Wolf wrote:
> 
> >> > I think the proper solution on the block layer level would be that
> >> > AioContext is managed per BdrvChild and only BdrvChild objects with
> >> > the same AioContext can be attached to the same node.
> >> > bdrv_set_aio_context() would then fail if another parent is already
> >> > using the node.
> >> 
> >> How would that solve the virtio-blk problem, though? :-?
> >
> > It wouldn't, but it would make clear that bdrv_set_aio_context() can
> > fail and we'd have to handle the problem exactly there.
> 
> Yes, that sound like the proper solution.
> 
> > The only other option I see is downgrading to non-dataplane mode, but
> > this would have to be silent because during machine reset we have no
> > way to report errors.
> 
> Yes, I actually had a patch doing that, but as you said the user has no
> way of knowing that it went wrong.
> 
> If you have 2 or 3 virtio-blk devices with different iothreads using the
> same BDS then after the guest reboot only one would succeed, but you
> can't see which one, or can you?

I suppose you could add a QOM property that tells whether the assigned
iothread is actually in use, but it would still be quite obscure. And
you would have to check explicitly, so I don't think that's a good
solution.

And actually... if you move the first virtio-blk device to an iothread,
then downgrading the others isn't going to save us, because that would
still be using the backend from two threads (one successfully enabled
iothread, and the main thread).

Kevin
