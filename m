Received: from eggs.gnu.org ([2001:4830:134:3::10]:35974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fijKr-0001V3-1a
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fijKp-0003df-Rp
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:41:53 -0400
Date: Thu, 26 Jul 2018 18:41:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180726164143.GI4215@localhost.localdomain>
References: <20180726113337.23144-1-kwolf@redhat.com>
	<CAMRbyyt-+ncsJzNbtF6dVNVHGiykORE-edF4z=nXepW9U=-RZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRbyyt-+ncsJzNbtF6dVNVHGiykORE-edF4z=nXepW9U=-RZg@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-3.0] file-posix: Fix
 write_zeroes with unmap on block devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

Am 26.07.2018 um 18:22 hat Nir Soffer geschrieben:
> On Thu, Jul 26, 2018 at 2:33 PM Kevin Wolf <kwolf@redhat.com> wrote:
> 
> > The BLKDISCARD ioctl doesn't guarantee that the discarded blocks read as
> > all-zero afterwards, so don't try to abuse it for zero writing. We try
> > to only use this if BLKDISCARDZEROES tells us that it is safe, but this
> > is unreliable on older kernels and a constant 0 in newer kernels. In
> > other words, this code path is never actually used with newer kernels,
> > so we don't even try to unmap while writing zeros.
> >
> > This patch removes the abuse of discard for writing zeroes from
> > file-posix and instead adds a new function that uses interfaces that are
> > actually meant to deallocate and zero out at the same time. Only if
> > those fail, it falls back to zeroing out without unmap. We never fall
> > back to a discard operation any more that may or may not result in
> > zeros.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/file-posix.c | 62
> > +++++++++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 47 insertions(+), 15 deletions(-)
> >
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 60af4b3d51..9c66cd87d1 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -648,7 +648,7 @@ static int raw_open_common(BlockDriverState *bs, QDict
> > *options,
> >      }
> >  #endif
> >
> > -    bs->supported_zero_flags = s->discard_zeroes ? BDRV_REQ_MAY_UNMAP : 0;
> > +    bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP;
> >      ret = 0;
> >  fail:
> >      if (filename && (bdrv_flags & BDRV_O_TEMPORARY)) {
> > @@ -1487,6 +1487,38 @@ static ssize_t
> > handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
> >      return -ENOTSUP;
> >  }
> >
> > +static ssize_t handle_aiocb_write_zeroes_unmap(RawPosixAIOData *aiocb)
> > +{
> > +    BDRVRawState *s = aiocb->bs->opaque;
> > +    int ret;
> > +
> > +    /* First try to write zeros and unmap at the same time */
> > +
> > +#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> > +    ret = do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> > +                       aiocb->aio_offset, aiocb->aio_nbytes);
> > +    if (ret != -ENOTSUP) {
> >
> 
> This fails with ENODEV on RHEL 7.5 when fd is a block device.
> 
> The manual says:
> 
>        ENODEV fd does not refer to a regular file or a directory.  (If fd
> is a pipe or FIFO, a different error results.)

do_fallocate() is a wrapper around fallocate() that handles EINTR and
translates a few errno values (including ENODEV) into a -ENOTSUP return
code.

Kevin
