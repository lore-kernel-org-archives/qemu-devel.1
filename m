Received: from eggs.gnu.org ([2001:4830:134:3::10]:46692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fVN1m-0000wE-RJ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fVN1i-0007k7-NC
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:14:58 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <naravamudan@digitalocean.com>)
	id 1fVN1i-0007j9-Bd
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:14:54 -0400
Received: by mail-pg0-x242.google.com with SMTP id r21-v6so369374pgv.4
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 13:14:53 -0700 (PDT)
Date: Tue, 19 Jun 2018 13:14:51 -0700
From: Nishanth Aravamudan <naravamudan@digitalocean.com>
Message-ID: <20180619201451.GA6337@breakout>
References: <20180614232119.31669-1-naravamudan@digitalocean.com>
	<20180615174729.20544-1-naravamudan@digitalocean.com>
	<1dbfeae9-6cae-179b-214b-61e3f96ac94c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dbfeae9-6cae-179b-214b-61e3f96ac94c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] [RFC v2] aio: properly bubble up errors
 from initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 19.06.2018 [14:35:33 -0500], Eric Blake wrote:
> On 06/15/2018 12:47 PM, Nishanth Aravamudan via Qemu-devel wrote:
> > laio_init() can fail for a couple of reasons, which will lead to a NULL
> > pointer dereference in laio_attach_aio_context().
> > 
> > To solve this, add a aio_setup_linux_aio() function which is called
> > before aio_get_linux_aio() where it is called currently, and which
> > propogates setup errors up. The signature of aio_get_linux_aio() was not
> 
> s/propogates/propagates/
 
Thanks!

> > modified, because it seems preferable to return the actual errno from
> > the possible failing initialization calls.
> > 
> > With respect to the error-handling in the file-posix.c, we properly
> > bubble any errors up in raw_co_prw and in the case s of
> > raw_aio_{,un}plug, the result is the same as if s->use_linux_aio was not
> > set (but there is no bubbling up). In all three cases, if the setup
> > function fails, we fallback to the thread pool and an error message is
> > emitted.
> > 
> > It is trivial to make qemu segfault in my testing. Set
> > /proc/sys/fs/aio-max-nr to 0 and start a guest with
> > aio=native,cache=directsync. With this patch, the guest successfully
> > starts (but obviously isn't using native AIO). Setting aio-max-nr back
> > up to a reasonable value, AIO contexts are consumed normally.
> > 
> > Signed-off-by: Nishanth Aravamudan <naravamudan@digitalocean.com>
> > 
> > ---
> > 
> > Changes from v1 -> v2:
> 
> When posting a v2, it's best to post as a new thread, rather than
> in-reply-to the v1 thread, so that automated tooling knows to check the new
> patch.  More patch submission tips at
> https://wiki.qemu.org/Contribute/SubmitAPatch

My apologies! I'll fix this in a (future) v3.

> > Rather than affect virtio-scsi/blk at all, make all the changes internal
> > to file-posix.c. Thanks to Kevin Wolf for the suggested change.
> > ---
> >   block/file-posix.c      | 24 ++++++++++++++++++++++++
> >   block/linux-aio.c       | 15 ++++++++++-----
> >   include/block/aio.h     |  3 +++
> >   include/block/raw-aio.h |  2 +-
> >   stubs/linux-aio.c       |  2 +-
> >   util/async.c            | 15 ++++++++++++---
> >   6 files changed, 51 insertions(+), 10 deletions(-)
> > 
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 07bb061fe4..2415d09bf1 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -1665,6 +1665,14 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
> >               type |= QEMU_AIO_MISALIGNED;
> >   #ifdef CONFIG_LINUX_AIO
> >           } else if (s->use_linux_aio) {
> > +            int rc;
> > +            rc = aio_setup_linux_aio(bdrv_get_aio_context(bs));
> > +            if (rc != 0) {
> > +                error_report("Unable to use native AIO, falling back to "
> > +                             "thread pool.");
> 
> In general, error_report() should not output a trailing '.'.

Will fix.

> > +                s->use_linux_aio = 0;
> > +                return rc;
> 
> Wait - the message claims we are falling back, but the non-zero return code
> sounds like we are returning an error instead of falling back.  (My
> preference - if the user requested something and we can't do it, it's better
> to error than to fall back to something that does not match the user's
> request).

I think that makes sense, I hadn't tested this specific case (in my
reading of the code, it wasn't clear to me if raw_co_prw() could be
called before raw_aio_plug() had been called, but I think returning the
error code up should be handled correctly. What about the cases where
there is no error handling (the other two changes in the patch)?

> > +            }
> >               LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
> >               assert(qiov->size == bytes);
> >               return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
> > @@ -1695,6 +1703,14 @@ static void raw_aio_plug(BlockDriverState *bs)
> >   #ifdef CONFIG_LINUX_AIO
> >       BDRVRawState *s = bs->opaque;
> >       if (s->use_linux_aio) {
> > +        int rc;
> > +        rc = aio_setup_linux_aio(bdrv_get_aio_context(bs));
> > +        if (rc != 0) {
> > +            error_report("Unable to use native AIO, falling back to "
> > +                         "thread pool.");
> > +            s->use_linux_aio = 0;
> 
> Should s->use_linux_aio be a bool instead of an int?

It is:

    bool use_linux_aio:1;

would you prefer I did a preparatory patch that converted users to
true/false?

Thanks,
Nish
