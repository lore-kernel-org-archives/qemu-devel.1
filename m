Received: from eggs.gnu.org ([209.51.188.92]:53832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmbJN-0004f8-Ja
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmb47-0001Z8-KF
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:12:52 -0500
Date: Thu, 24 Jan 2019 10:12:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190124091222.GB4601@localhost.localdomain>
References: <cover.1548171741.git.berto@igalia.com>
	<6ad371df66eecffccce29a0bd14695f40edd6120.1548171741.git.berto@igalia.com>
	<735410dc-a63e-6a28-4526-2caa810a797d@redhat.com>
	<w518szbmmw9.fsf@maestria.local.igalia.com>
	<b3e3cb90-32a6-77b0-1c5b-8281181c8ae8@redhat.com>
	<w5136pjmjrp.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w5136pjmjrp.fsf@maestria.local.igalia.com>
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

Am 23.01.2019 um 17:16 hat Alberto Garcia geschrieben:
> On Wed 23 Jan 2019 04:47:30 PM CET, Paolo Bonzini wrote:
> >> You mean a common function with the code below?
> >> 
> >>>> +        ctx = blk_get_aio_context(sd->conf.blk);
> >>>> +        if (ctx != s->ctx && ctx != qemu_get_aio_context()) {
> >>>> +            error_setg(errp, "Cannot attach a blockdev that is using "
> >>>> +                       "a different iothread");
> >>>> +            return;
> >>>> +        }
> >> 
> >> Who else would be the user?
> >
> > If it isn't, probably virtio-blk should be using too.
> 
> I agree, but that's the problem that I mentioned on the cover letter.
> 
> In the virtio-blk case I don't know how to tell that the block device is
> using a different iothread during device_add, because the iothread is
> not set during realize() but by virtio_blk_data_plane_start() that
> happens only when I reboot the guest.

I think the proper solution on the block layer level would be that
AioContext is managed per BdrvChild and only BdrvChild objects with the
same AioContext can be attached to the same node. bdrv_set_aio_context()
would then fail if another parent is already using the node.

Now, Paolo keeps talking about how AioContexts are going to disappear
soon (TM), so I wonder whether it's still worth fixing this properly
now?

Kevin
