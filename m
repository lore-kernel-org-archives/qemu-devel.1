Received: from eggs.gnu.org ([2001:4830:134:3::10]:49024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYvcI-0001Xp-Lp
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYvcH-0003Ms-Bv
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:47:22 -0400
Date: Fri, 29 Jun 2018 17:47:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180629154711.GI15588@localhost.localdomain>
References: <20180628190723.276458-1-eblake@redhat.com>
	<20180628190723.276458-7-eblake@redhat.com>
	<20180629090317.GD15588@localhost.localdomain>
	<b041ee2a-6d59-1d8a-cf41-1164d9c3e129@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b041ee2a-6d59-1d8a-cf41-1164d9c3e129@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 6/6] qcow2: Avoid memory over-allocation
 on compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org, berto@igalia.com

Am 29.06.2018 um 17:16 hat Eric Blake geschrieben:
> On 06/29/2018 04:03 AM, Kevin Wolf wrote:
> > Am 28.06.2018 um 21:07 hat Eric Blake geschrieben:
> > > When reading a compressed image, we were allocating s->cluster_data
> > > to 32*cluster_size + 512 (possibly over 64 megabytes, for an image
> > > with 2M clusters).  Let's check out the history:
> > > 
> 
> > > However, the qcow2 spec permits an all-ones sector count, plus
> > > a full sector containing the initial offset, for a maximum read
> > > of 2 full clusters.  Thanks to the way decompression works, even
> > > though such a value is too large for the actual compressed data
> > > (for all but 512-byte clusters), it really doesn't matter if we
> > > read too much (gzip ignores slop, once it has decoded a full
> > > cluster).  So it's easier to just allocate cluster_data to be as
> > > large as we can ever possibly see; even if it still wastes up to
> > > 2M on any image created by qcow2, that's still an improvment of
> 
> s/improvment/improvement/
> 
> > > 60M less waste than pre-patch.
> > > 
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > Reviewed-by: Alberto Garcia <berto@igalia.com>
> > > 
> > > ---
> 
> > > +++ b/block/qcow2-cluster.c
> > > @@ -1599,20 +1599,29 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
> > >           sector_offset = coffset & 511;
> > >           csize = nb_csectors * 512 - sector_offset;
> > > 
> > > -        /* Allocate buffers on first decompress operation, most images are
> > > -         * uncompressed and the memory overhead can be avoided.  The buffers
> > > -         * are freed in .bdrv_close().
> > > +        /* Allocate buffers on the first decompress operation; most
> > > +         * images are uncompressed and the memory overhead can be
> > > +         * avoided.  The buffers are freed in .bdrv_close().  qemu
> > > +         * never writes an inflated cluster, and gzip itself never
> > > +         * inflates a problematic cluster by more than 0.015%, but the
> > > +         * qcow2 format allows up to 1 byte short of 2 full clusters
> > > +         * when including the sector containing offset.  gzip ignores
> > > +         * trailing slop, so just allocate that much up front rather
> > > +         * than reject third-party images with overlarge csize.
> > >            */
> > > +        assert(!!s->cluster_data == !!s->cluster_cache);
> > > +        assert(csize <= 2 * s->cluster_size);
> > >           if (!s->cluster_data) {
> > > -            /* one more sector for decompressed data alignment */
> > > -            s->cluster_data = qemu_try_blockalign(bs->file->bs,
> > > -                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size + 512);
> > > +            s->cluster_data = g_try_malloc(2 * s->cluster_size);
> > >               if (!s->cluster_data) {
> > >                   return -ENOMEM;
> > >               }
> > > -        }
> > > -        if (!s->cluster_cache) {
> > > -            s->cluster_cache = g_malloc(s->cluster_size);
> > > +            s->cluster_cache = g_try_malloc(s->cluster_size);
> > > +            if (!s->cluster_cache) {
> > > +                g_free(s->cluster_data);
> > > +                s->cluster_data = NULL;
> > > +                return -ENOMEM;
> > > +            }
> > >           }
> > 
> > I wonder how much of a difference s->cluster_cache really makes. I
> > wouldn't expect guests to access the same cluster twice in a row.
> 
> I don't know if it makes a difference.  But my patch is not even touching
> that - ALL I'm doing is changing a 64M allocation into a 4M allocation, with
> otherwise no change to the frequency of allocation (which is once per
> image).
> 
> > 
> > Maybe the easiest solution would be switching to temporary buffers that
> > would have the exact size we need and would be freed at the end of the
> > request?
> 
> The exact size for a qemu-produced image would be at most 2M instead of 4M -
> but doing the change you propose WILL cause more frequent allocations (once
> per cluster, rather than once per image).  We'd have to benchmark if it
> makes sense.

I wouldn't expect that another allocation makes a big difference when
you already have to decompress the whole cluster. In fact, it could
speed things up because we could then parallelise this.

Hmm... Wasn't there a series for using a worker thread for decompression
recently? It might actually already make that change, I don't remember.

> But that would be a separate patch from this one.

Yes, just a thought I had while reviewing your patch.

Kevin
