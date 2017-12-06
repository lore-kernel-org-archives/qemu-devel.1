Received: from eggs.gnu.org ([2001:4830:134:3::10]:33395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMVl4-0003dt-GN
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMVl1-0005Ld-AG
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:12:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eMVl1-0005L4-4L
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:12:47 -0500
Date: Wed, 6 Dec 2017 10:12:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171206091243.GC4207@localhost.localdomain>
References: <CAJqJJggWTki8i_U7xr2oRSFR4sZt4eK5hRO+B55iOYVMyfGwDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJqJJggWTki8i_U7xr2oRSFR4sZt4eK5hRO+B55iOYVMyfGwDg@mail.gmail.com>
Subject: Re: [Qemu-devel] About [PULL 20/25] block: Guard against NULL
 bs->drv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kangjie Xi <imxikangjie@gmail.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com

Am 06.12.2017 um 08:28 hat Kangjie Xi geschrieben:
> Hi,
> 
> I encountered a qemu-nbd segfault, finally I found it was caused by
> NULL bs-drv,  which is located in block/io.c function bdrv_co_flush
> line 2377:
> 
> https://git.qemu.org/?p=qemu.git;a=blob;f=block/io.c;h=4fdf93a0144fa4761a14b8cc6b2a9a6b6e5d5bec;hb=d470ad42acfc73c45d3e8ed5311a491160b4c100#l2377
> 
> It is before the patch at line 2402, so the patch needs to be updated
> to fix NULL bs-drv at line 2337.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03425.html

Can you please post a full backtrace? Do you see any error message
on stderr before the process crashes?

I don't see at the moment how this can happen, except the case that Max
mentioned where bs->drv = NULL is set when an image corruption is
detected - this involves an error message, though.

We check bdrv_is_inserted() as the first thing, which includes a NULL
check for bs->drv. So it must have been non-NULL at the start of the
function and then become NULL. I suppose this can theoretically happen
in qemu_co_queue_wait() if another flush request detects image
corruption.

Max: I think bs->drv = NULL in the middle of a request was a stupid
idea. In fact, it's already a stupid idea to have any BDS with
bs->drv = NULL. Maybe it would be better to schedule a BH that replaces
the qcow2 node with a dummy node (null-co?) and properly closes the
qcow2 one.

Kevin

> > @@ -2373,6 +2399,12 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
> >      }
> >
> >      BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_DISK);
> > +    if (!bs->drv) {
> > +        /* bs->drv->bdrv_co_flush() might have ejected the BDS
> > +         * (even in case of apparent success) */
> > +        ret = -ENOMEDIUM;
> > +        goto out;
> > +    }
> >      if (bs->drv->bdrv_co_flush_to_disk) {
> >          ret = bs->drv->bdrv_co_flush_to_disk(bs);
> >      } else if (bs->drv->bdrv_aio_flush) {
> 
> I have tested the latest qemu-2.11.0-rc2 and I am sure the qemu-nbd
> segfault is caused by NULL bs-drv in block/io.c line 2337.
> 
> kernel: qemu-nbd[18768]: segfault at f8 ip 000055a24f7536a7 sp
> 00007f59b1137a40 error 4 in qemu-nbd[55a24f6d1000+188000]
> 
> However I have no methods to reproduce the segfault manually, the
> qemu-nbd segfaut just occurs in my server cluster every week.
> 
> Thanks
> -Kangjie
