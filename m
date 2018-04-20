Received: from eggs.gnu.org ([2001:4830:134:3::10]:43327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f9Mqr-00072z-5k
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f9Mqq-0008EY-8Y
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:36:45 -0400
Date: Fri, 20 Apr 2018 11:36:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180420033626.GF17690@lemon.usersys.redhat.com>
References: <20180419075232.31407-1-stefanha@redhat.com>
	<20180419075232.31407-2-stefanha@redhat.com>
	<20180419081344.GA14514@lemon.usersys.redhat.com>
	<20180420031508.GE10319@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420031508.GE10319@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC 1/2] block/file-posix: implement
 bdrv_co_invalidate_cache() on Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, 04/20 11:15, Stefan Hajnoczi wrote:
> On Thu, Apr 19, 2018 at 04:13:44PM +0800, Fam Zheng wrote:
> > On Thu, 04/19 15:52, Stefan Hajnoczi wrote:
> > > On Linux posix_fadvise(POSIX_FADV_DONTNEED) invalidates pages*.  Use
> > > this to drop page cache on the destination host during shared storage
> > > migration.  This way the destination host will read the latest copy of
> > > the data and will not use stale data from the page cache.
> > > 
> > > The flow is as follows:
> > > 
> > > 1. Source host writes out all dirty pages and inactivates drives.
> > > 2. QEMU_VM_EOF is sent on migration stream.
> > > 3. Destination host invalidates caches before accessing drives.
> > > 
> > > This patch enables live migration even with -drive cache.direct=off.
> > > 
> > > * Terms and conditions may apply, please see patch for details.
> > > 
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  block/file-posix.c | 39 +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 39 insertions(+)
> > > 
> > > diff --git a/block/file-posix.c b/block/file-posix.c
> > > index 3794c0007a..df4f52919f 100644
> > > --- a/block/file-posix.c
> > > +++ b/block/file-posix.c
> > > @@ -2236,6 +2236,42 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
> > >      return ret | BDRV_BLOCK_OFFSET_VALID;
> > >  }
> > >  
> > > +static void coroutine_fn raw_co_invalidate_cache(BlockDriverState *bs,
> > > +                                                 Error **errp)
> > > +{
> > > +    BDRVRawState *s = bs->opaque;
> > > +    int ret;
> > > +
> > > +    ret = fd_open(bs);
> > > +    if (ret < 0) {
> > > +        error_setg_errno(errp, -ret, "The file descriptor is not open");
> > > +        return;
> > > +    }
> > > +
> > > +    if (s->open_flags & O_DIRECT) {
> > > +        return; /* No host kernel page cache */
> > > +    }
> > > +
> > > +#if defined(__linux__)
> > > +    /* This sets the scene for the next syscall... */
> > > +    ret = bdrv_co_flush(bs);
> > > +    if (ret < 0) {
> > > +        error_setg_errno(errp, -ret, "flush failed");
> > > +        return;
> > > +    }
> > > +
> > > +    /* Linux does not invalidate pages that are dirty, locked, or mmapped by a
> > > +     * process.  These limitations are okay because we just fsynced the file,
> > > +     * we don't use mmap, and the file should not be in use by other processes.
> > > +     */
> > > +    ret = posix_fadvise(s->fd, 0, 0, POSIX_FADV_DONTNEED);
> > > +    if (ret != 0) { /* the return value is a positive errno */
> > > +        error_setg_errno(errp, ret, "fadvise failed");
> > > +        return;
> > > +    }
> > > +#endif /* __linux__ */
> > 
> > What about the #else branch? It doesn't automatically work, I guess?
> 
> Right, no error is reported.  This is existing QEMU behavior.
> 
> If we want to change behavior then it must be done consistently (i.e. by
> auditing the other block drivers) and we need to be prepared for bug
> reports (just like file locking, it may expose interesting use cases
> that we cannot easily dismiss as wrong).  I didn't want to go there.
> 
> If there is consensus then I will change the behavior.

No need to change behavior (reporting error), at least not in this patch. But a

#else
    /* TODO: ... */
#endif

to remember adding similar code to invalidate system cache on other *nix systems
cannot hurt.  E.g BSDes have posix_fadvise() too, though I have no idea if
POSIX_FADV_DONTNEED works the same.

(I'm sure there are some tricks on Windows to but do we care? :)

Fam
