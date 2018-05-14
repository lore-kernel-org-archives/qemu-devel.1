Received: from eggs.gnu.org ([2001:4830:134:3::10]:41328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fI6KZ-0000Gl-Bq
	for qemu-devel@nongnu.org; Mon, 14 May 2018 01:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fI2kQ-0006xY-MQ
	for qemu-devel@nongnu.org; Sun, 13 May 2018 21:57:59 -0400
Date: Mon, 14 May 2018 09:57:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180514015745.GA16389@lemon.usersys.redhat.com>
References: <20180511120823.7892-1-famz@redhat.com>
	<20180511120823.7892-3-famz@redhat.com>
	<16dd8da5-e0cc-43d1-caba-b0dd3807a52c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16dd8da5-e0cc-43d1-caba-b0dd3807a52c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 02/10] raw: Check byte range uniformly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

On Fri, 05/11 08:59, Eric Blake wrote:
> On 05/11/2018 07:08 AM, Fam Zheng wrote:
> > We don't verify the request range against s->size in the I/O callbacks
> > except for raw_co_pwritev. This is wrong (especially for
> > raw_co_pwrite_zeroes and raw_co_pdiscard), so fix them.
> 
> Did you bother identifying how long the bug has been present (but read
> below, because I'm not sure there was even a bug)?
> 
> CC: qemu-stable@nongnu.org
> 
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >   block/raw-format.c | 63 ++++++++++++++++++++++++++++++++----------------------
> >   1 file changed, 38 insertions(+), 25 deletions(-)
> > 
> > diff --git a/block/raw-format.c b/block/raw-format.c
> > index a378547c99..803083f1a1 100644
> > --- a/block/raw-format.c
> > +++ b/block/raw-format.c
> > @@ -167,16 +167,36 @@ static void raw_reopen_abort(BDRVReopenState *state)
> >       state->opaque = NULL;
> >   }
> > +/* Check and adjust the offset, against 'offset' and 'size' options. */
> > +static inline int raw_adjust_offset(BlockDriverState *bs, uint64_t *offset,
> > +                                    uint64_t bytes)
> > +{
> > +    BDRVRawState *s = bs->opaque;
> > +
> > +    if (s->has_size && (*offset > s->size || bytes > (s->size - *offset))) {
> > +        /* There's not enough space for the data. Don't write anything and just
> > +         * fail to prevent leaking out of the size specified in options. */
> > +        return -ENOSPC;
> > +    }
> 
> Can this even trigger? The block layer should already be clamping requests
> according to the device's reported size, and we already report a smaller
> size according to s->size and s->offset.  This could probably be an
> assertion instead.

There is the "write_beyond_eof" semantics in block layer, so the requested range
can escape the allowed here. 

> 
> > +
> > +    if (*offset > UINT64_MAX - s->offset) {
> > +        return -EINVAL;
> 
> Should this be against INT64_MAX instead?  After all, we really do use off_t
> (a 63-bit quantity, since it is signed), rather than uint64_t, as our
> maximum (theoretical) image size.  But again, can it even trigger, or can it
> be an assertion?
> 
> > +    }
> > +    *offset += s->offset;
> > +
> > +    return 0;
> > +}
> > +
> >   static int coroutine_fn raw_co_preadv(BlockDriverState *bs, uint64_t offset,
> >                                         uint64_t bytes, QEMUIOVector *qiov,
> >                                         int flags)
> >   {
> > -    BDRVRawState *s = bs->opaque;
> > +    int ret;
> > -    if (offset > UINT64_MAX - s->offset) {
> > -        return -EINVAL;
> > +    ret = raw_adjust_offset(bs, &offset, bytes);
> 
> If I'm right and we can assert instead of failing, then raw_adjust_offset()
> doesn't return failure.  If I'm wrong, then there is now a code path where
> we can return ENOSPC on a read, which is unusual and probably wrong.

Yeah, EINVAL is the right value I think.

> 
> > +    if (ret) {
> > +        return ret;
> >       }
> > -    offset += s->offset;
> >       BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
> >       return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
> > @@ -186,23 +206,11 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
> >                                          uint64_t bytes, QEMUIOVector *qiov,
> >                                          int flags)
> >   {
> > -    BDRVRawState *s = bs->opaque;
> >       void *buf = NULL;
> >       BlockDriver *drv;
> >       QEMUIOVector local_qiov;
> >       int ret;
> > -    if (s->has_size && (offset > s->size || bytes > (s->size - offset))) {
> > -        /* There's not enough space for the data. Don't write anything and just
> > -         * fail to prevent leaking out of the size specified in options. */
> > -        return -ENOSPC;
> > -    }
> > -
> > -    if (offset > UINT64_MAX - s->offset) {
> > -        ret = -EINVAL;
> > -        goto fail;
> > -    }
> 
> Okay, so you're just doing code refactoring; perhaps we could have done
> assertions here.
> 
> > -
> >       if (bs->probed && offset < BLOCK_PROBE_BUF_SIZE && bytes) {
> >           /* Handling partial writes would be a pain - so we just
> >            * require that guests have 512-byte request alignment if
> > @@ -237,7 +245,10 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
> >           qiov = &local_qiov;
> >       }
> > -    offset += s->offset;
> > +    ret = raw_adjust_offset(bs, &offset, bytes);
> > +    if (ret) {
> > +        goto fail;
> > +    }
> >       BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
> >       ret = bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
> > @@ -267,22 +278,24 @@ static int coroutine_fn raw_co_pwrite_zeroes(BlockDriverState *bs,
> >                                                int64_t offset, int bytes,
> >                                                BdrvRequestFlags flags)
> >   {
> > -    BDRVRawState *s = bs->opaque;
> > -    if (offset > UINT64_MAX - s->offset) {
> > -        return -EINVAL;
> > +    int ret;
> > +
> > +    ret = raw_adjust_offset(bs, (uint64_t *)&offset, bytes);
> > +    if (ret) {
> > +        return ret;
> >       }
> > -    offset += s->offset;
> 
> If I'm right and raw_adjust_offset() can't fail, then this didn't add any
> protection.  If I'm wrong and it is possible to get the block layer to send
> a request beyond our advertised size, then this is indeed a bug fix worthy
> of being on the stable branch.
> 
> >       return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
> >   }
> >   static int coroutine_fn raw_co_pdiscard(BlockDriverState *bs,
> >                                           int64_t offset, int bytes)
> >   {
> > -    BDRVRawState *s = bs->opaque;
> > -    if (offset > UINT64_MAX - s->offset) {
> > -        return -EINVAL;
> > +    int ret;
> > +
> > +    ret = raw_adjust_offset(bs, (uint64_t *)&offset, bytes);
> > +    if (ret) {
> > +        return ret;
> >       }
> > -    offset += s->offset;
> >       return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
> >   }
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org

Fam
