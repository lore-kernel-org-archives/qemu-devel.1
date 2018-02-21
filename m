Received: from eggs.gnu.org ([2001:4830:134:3::10]:32911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoXc3-00073S-92
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoXc2-0003k5-5s
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:51:23 -0500
Date: Wed, 21 Feb 2018 17:51:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180221165116.GB4196@localhost.localdomain>
References: <20180220222459.8461-1-eblake@redhat.com>
	<20180220222459.8461-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220222459.8461-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qcow2: Avoid memory over-allocation on
 compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, berto@igalia.com

Am 20.02.2018 um 23:24 hat Eric Blake geschrieben:
> When reading a compressed image, we were allocating s->cluster_data
> to 32*cluster_size + 512 (possibly over 64 megabytes, for an image
> with 2M clusters).  Let's check out the history:
> 
> Back when qcow2 was first written, we used s->cluster_data for
> everything, including copy_sectors() and encryption, where we want
> to operate on more than one cluster at once.  Obviously, at that
> point, the buffer had to be aligned for other users, even though
> compression itself doesn't require any alignment.
> 
> But commit 1b9f1491 (v1.1!) changed things to allocate parallel
> buffers on demand rather than sharing a single buffer, for encryption
> and COW, leaving compression as the final client of s->cluster_data.
> That use was still preserved, because if a single compressed cluster
> is read more than once, we reuse the cache instead of decompressing
> it a second time (I'm not sure how often this optimization actually
> fires, or if it penalizes us from being able to decompress multiple
> clusters in parallel even though we can now decrypt clusters in
> parallel; the XXX comment in qcow2_co_preadv for
> QCOW2_CLUSTER_COMPRESSED is telling).
> 
> Much later, in commit de82815d (v2.2), we noticed that a 64M
> allocation is prone to failure, so we switched over to a graceful
> memory allocation error message.  But note that elsewhere in the
> code, we do g_malloc(2 * cluster_size) without ever checking for
> failure.
> 
> Then even later, in 3e4c7052 (2.11), we realized that allocating
> a large buffer up front for every qcow2 image is expensive, and
> switched to lazy allocation only for images that actually had
> compressed clusters.  But in the process, we never even bothered
> to check whether what we were allocating still made sense in its
> new context!
> 
> So, it's time to cut back on the waste.  A compressed cluster
> will NEVER occupy more than an uncompressed cluster (okay, gzip
> DOES document that because the compression stream adds metadata,
> and because of the pigeonhole principle, there are worst case
> scenarios where attempts to compress will actually inflate an
> image - but in those cases, we would just write the cluster
> uncompressed instead of inflating it).  And as that is a smaller
> amount of memory, we can get by with the simpler g_malloc.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

My comments feel a bit trivial compared to Berto's, but anyway:

> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 85be7d5e340..8c4b26ceaf2 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1603,15 +1603,9 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
>           * are freed in .bdrv_close().
>           */
>          if (!s->cluster_data) {
> -            /* one more sector for decompressed data alignment */
> -            s->cluster_data = qemu_try_blockalign(bs->file->bs,
> -                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size + 512);
> -            if (!s->cluster_data) {
> -                return -ENOMEM;
> -            }
> -        }
> -        if (!s->cluster_cache) {
> -            s->cluster_cache = g_malloc(s->cluster_size);
> +            assert(!s->cluster_cache);

Wouldn't it be better to assert (!!s->cluster_cache ==
!!s->cluster_data) unconditionally?

> +            s->cluster_data = g_try_malloc(s->cluster_size);

Why are you going from qemu_try_blockalign() to simple malloc here? This
buffer is used with bdrv_read() (or bdrv_pread() after patch 1), so we
should avoid unnecessary use of a bounce buffer.

> +            s->cluster_cache = g_try_malloc(s->cluster_size);

As you already said, either g_malloc() or check the result. I actually
think that g_try_malloc() and checking the result is nicer, we still
allocate up to 2 MB here.

Kevin
