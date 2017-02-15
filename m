Received: from eggs.gnu.org ([2001:4830:134:3::10]:57625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdyeF-0004oV-DV
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdyeE-0002ti-6a
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:25:27 -0500
Date: Wed, 15 Feb 2017 13:25:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170215122517.GB4935@noname.redhat.com>
References: <20170214192525.18624-1-eblake@redhat.com>
	<20170214192525.18624-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170214192525.18624-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/7] qcow2: Assert that cluster
 operations are aligned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 14.02.2017 um 20:25 hat Eric Blake geschrieben:
> qcow2_discard_clusters() is set up to silently ignore sub-cluster
> head or tail on unaligned requests.  However, it is easy to audit
> the various callers: qcow2_snapshot_create() has always passed
> aligned data since the call was introduced in 1ebf561;
> qcow2_co_pdiscard() has passed aligned clusters since commit
> ecdbead taught the block layer the preferred discard alignment (the
> block layer can still pass sub-cluster values, but those are
> handled directly in qcow2_co_pdiscard()); and qcow2_make_empty()
> was fixed to pass aligned clusters in commit a3e1505.

I don't think this is true for the very part in the image if the image
size isn't cluster aligned:

    ret = qcow2_discard_clusters(bs, start_sector * BDRV_SECTOR_SIZE,
                                 MIN(sector_step,
                                     bs->total_sectors - start_sector),
                                 QCOW2_DISCARD_SNAPSHOT, true);

sector_step is alright after commit a3e1505, but bs->total_sectors can
be unaligned.

The other callers look okay.

> Replace
> rounding with assertions to hold us to the tighter contract,
> eliminating the now-impossible case of an early exit for a
> sub-cluster request.
> 
> qcow2_zero_clusters() has always been called with cluster-aligned
> arguments from its lone caller qcow2_co_pwrite_zeroes() (like
> qcow2_co_pdiscard(), the caller takes care of sub-cluster requests
> from the block layer; and qcow2_zero_clusters() would have
> misbehaved on unaligned requests), but it deserves the same
> assertion for symmetry.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 
> ---
> v5: no change
> v4: new patch
> ---
>  block/qcow2-cluster.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 928c1e2..3304a15 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1521,13 +1521,9 @@ int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,
> 
>      end_offset = offset + (nb_sectors << BDRV_SECTOR_BITS);
> 
> -    /* Round start up and end down */
> -    offset = align_offset(offset, s->cluster_size);
> -    end_offset = start_of_cluster(s, end_offset);
> -
> -    if (offset > end_offset) {
> -        return 0;
> -    }
> +    /* Caller must pass aligned values */
> +    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
> +    assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size));
> 
>      nb_clusters = size_to_clusters(s, end_offset - offset);
> 
> @@ -1602,6 +1598,10 @@ int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_sectors,
>      uint64_t nb_clusters;
>      int ret;
> 
> +    /* Caller must pass aligned values */
> +    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
> +    assert(QEMU_IS_ALIGNED(nb_sectors, s->cluster_size >> BDRV_SECTOR_BITS));

Maybe using s->cluster_sectors is nicer than doing the shift here. Not
too important, the code is replaced in the next patch anyway.

>      /* The zero flag is only supported by version 3 and newer */
>      if (s->qcow_version < 3) {
>          return -ENOTSUP;

Kevin
