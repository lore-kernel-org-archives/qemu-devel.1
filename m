Received: from eggs.gnu.org ([2001:4830:134:3::10]:53330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dddGy-0001oc-7y
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dddGl-0002ke-KC
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:08:16 -0400
Date: Fri, 4 Aug 2017 15:06:30 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170804140630.GC14504@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170804105059.11941-1-berrange@redhat.com>
	<20170804140210.GD4108@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170804140210.GD4108@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] block: document semanatics of
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, Aug 04, 2017 at 04:02:10PM +0200, Kevin Wolf wrote:
> Am 04.08.2017 um 12:50 hat Daniel P. Berrange geschrieben:
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  include/block/block_int.h | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/include/block/block_int.h b/include/block/block_int.h
> > index d4f4ea7584..deb81a58bd 100644
> > --- a/include/block/block_int.h
> > +++ b/include/block/block_int.h
> > @@ -147,12 +147,41 @@ struct BlockDriver {
> >  
> >      int coroutine_fn (*bdrv_co_readv)(BlockDriverState *bs,
> >          int64_t sector_num, int nb_sectors, QEMUIOVector *qiov);
> > +
> > +    /**
> > +     * @offset: position in bytes to read at
> > +     * @bytes: number of bytes to read
> > +     * @qiov: the buffers to fill with read data
> > +     *
> > +     * @offset and @bytes will be a multiple of 'request_alignment',
> > +     * but the length of individual @qiov elements does not have to
> > +     * be a multiple.
> > +     *
> > +     * @bytes may be less than the total sizeof @iov, and will be
> > +     * no larger than 'max_transfer'.
> 
> Really? We are asserting that they match in bdrv_aligned_preadv():
> 
>     assert(!qiov || bytes == qiov->size);

Hmm, why do we pass @bytes at all then ? If they're always the same,
how about deleting it and just letting everyone read qiov->size
directly.

> Also, s/sizeof @iov/size of @qiov/



> 
> > +     *
> > +     * The buffer in @qiov may point directly to guest memory.
> > +     */
> >      int coroutine_fn (*bdrv_co_preadv)(BlockDriverState *bs,
> >          uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
> >      int coroutine_fn (*bdrv_co_writev)(BlockDriverState *bs,
> >          int64_t sector_num, int nb_sectors, QEMUIOVector *qiov);
> >      int coroutine_fn (*bdrv_co_writev_flags)(BlockDriverState *bs,
> >          int64_t sector_num, int nb_sectors, QEMUIOVector *qiov, int flags);
> > +    /**
> > +     * @offset: position in bytes to write at
> > +     * @bytes: number of bytes to write
> > +     * @qiov: the buffers containing data to write
> > +     *
> > +     * @offset and @bytes will be a multiple of 'request_alignment',
> > +     * but the length of individual @qiov elements does not have to
> > +     * be a multiple.
> > +     *
> > +     * @bytes may be less than the total sizeof @iov, and will be
> > +     * no larger than 'max_transfer'.
> 
> The same assertion exists in bdrv_aligned_pwritev() (and the same typo
> in your comment).
> 
> > +     * The buffer in @qiov may point directly to guest memory.
> > +     */
> >      int coroutine_fn (*bdrv_co_pwritev)(BlockDriverState *bs,
> >          uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
> 
> Kevin

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
