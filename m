Received: from eggs.gnu.org ([2001:4830:134:3::10]:50446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1djnCl-0002sL-3L
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1djnCk-0002gz-9v
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:57:23 -0400
Date: Mon, 21 Aug 2017 14:50:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170821135038.GB30187@stefanha-x1.localdomain>
References: <20170818133118.8650-1-stefanha@redhat.com>
	<72ab2a83-3da3-a87e-0196-6b4c533e9461@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72ab2a83-3da3-a87e-0196-6b4c533e9461@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: allocate cluster_cache/cluster_data
 on demand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Fri, Aug 18, 2017 at 10:18:37AM -0500, Eric Blake wrote:
> On 08/18/2017 08:31 AM, Stefan Hajnoczi wrote:
> > Most qcow2 files are uncompressed so it is wasteful to allocate (32 + 1)
> > * cluster_size + 512 bytes upfront.  Allocate s->cluster_cache and
> > s->cluster_data when the first read operation is performance on a
> > compressed cluster.
> > 
> > The buffers are freed in .bdrv_close().  .bdrv_open() no longer has any
> > code paths that can allocate these buffers, so remove the free functions
> > in the error code path.
> > 
> > Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Alexey: Does this improve your memory profiling results?
> 
> Is this a regression from earlier versions?  Likely, it is NOT -rc4
> material, and thus can wait for 2.11; but it should be fine for -stable
> as part of 2.10.1 down the road.

It's not a regression.  s->cluster_data was always allocated upfront in
.bdrv_open().

> > +++ b/block/qcow2-cluster.c
> > @@ -1516,6 +1516,23 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
> >          nb_csectors = ((cluster_offset >> s->csize_shift) & s->csize_mask) + 1;
> >          sector_offset = coffset & 511;
> >          csize = nb_csectors * 512 - sector_offset;
> > +
> > +        /* Allocate buffers on first decompress operation, most images are
> > +         * uncompressed and the memory overhead can be avoided.  The buffers
> > +         * are freed in .bdrv_close().
> > +         */
> > +        if (!s->cluster_data) {
> > +            /* one more sector for decompressed data alignment */
> > +            s->cluster_data = qemu_try_blockalign(bs->file->bs,
> > +                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size + 512);
> > +            if (!s->cluster_data) {
> > +                return -EIO;
> 
> Is -ENOMEM any better than -EIO here?

There is another instance of -ENOMEM in qcow2.c so it seems reasonable
to use the more specific ENOMEM error code.

I'll resend the patch.

Stefan
