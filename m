Received: from eggs.gnu.org ([2001:4830:134:3::10]:34225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dB5qz-0000f6-6q
	for qemu-devel@nongnu.org; Wed, 17 May 2017 16:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dB5qy-0000h0-Ca
	for qemu-devel@nongnu.org; Wed, 17 May 2017 16:47:29 -0400
Date: Wed, 17 May 2017 16:47:19 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1874132859.8716126.1495054039026.JavaMail.zimbra@redhat.com>
In-Reply-To: <e6d9417e-87bb-a88f-4f55-0a72aae0a212@redhat.com>
References: <20170517170941.25850-1-stefanha@redhat.com>
	<20170517170941.25850-3-stefanha@redhat.com>
	<e6d9417e-87bb-a88f-4f55-0a72aae0a212@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] block: use BDRV_POLL_WHILE() in
 bdrv_rw_vmstate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org


> I'm surprised at how many separate hangs we actually had!

Note that I have seen quite a few before, though I am not sure about
the details and the reproducibility.  The release/acquire was hidden
behind RFifoLock contention callbacks instead of BDRV_POLL_WHILE.

Paolo

> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  block/io.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> > 
> > diff --git a/block/io.c b/block/io.c
> > index cc56e90..f0041cd 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -2031,9 +2031,7 @@ bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector
> > *qiov, int64_t pos,
> >          Coroutine *co = qemu_coroutine_create(bdrv_co_rw_vmstate_entry,
> >          &data);
> >  
> >          bdrv_coroutine_enter(bs, co);
> > -        while (data.ret == -EINPROGRESS) {
> > -            aio_poll(bdrv_get_aio_context(bs), true);
> > -        }
> > +        BDRV_POLL_WHILE(bs, data.ret == -EINPROGRESS);
> >          return data.ret;
> >      }
> 
> Do we have other culprits (not necessarily for vmsave, but for other
> situations), where we should be using BDRV_POLL_WHILE in separate
> patches? For example, a quick grep show that at least hw/9pfs/9p.c makes
> a direct call to aio_poll(,true) in a while loop.
> 
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
> 
