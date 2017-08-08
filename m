Received: from eggs.gnu.org ([2001:4830:134:3::10]:33790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dezsw-0002Vd-HI
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dezsv-0008L2-3n
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:29:06 -0400
Date: Tue, 8 Aug 2017 10:28:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170808082854.GB4850@dhcp-200-186.str.redhat.com>
References: <20170807203007.19033-1-eblake@redhat.com>
	<20170807203007.19033-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170807203007.19033-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] qcow: Check failure of
 bdrv_getlength() and bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 07.08.2017 um 22:30 hat Eric Blake geschrieben:
> This also requires changing the return type of get_cluster_offset()
> and adjusting all callers.
> 
> Use osdep.h macros instead of open-coded rounding while in the
> area.
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow.c | 64 ++++++++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 45 insertions(+), 19 deletions(-)
> 
> diff --git a/block/qcow.c b/block/qcow.c
> index c08cdc4a7b..937023d447 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -347,16 +347,17 @@ static int qcow_reopen_prepare(BDRVReopenState *state,
>   * 'compressed_size'. 'compressed_size' must be > 0 and <
>   * cluster_size
>   *
> - * return 0 if not allocated.
> + * return 0 if not allocated, -errno on failure.
>   */
> -static uint64_t get_cluster_offset(BlockDriverState *bs,
> -                                   uint64_t offset, int allocate,
> -                                   int compressed_size,
> -                                   int n_start, int n_end)
> +static int64_t get_cluster_offset(BlockDriverState *bs,
> +                                  uint64_t offset, int allocate,
> +                                  int compressed_size,
> +                                  int n_start, int n_end)

qcow2 ended up with this prototype:

int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
                             unsigned int *bytes, uint64_t *cluster_offset)

Separating a full uin64_t offset by-reference parameter and an 0/-errno
status return code feels a little cleaner to me.

And in fact, it's not only cleaner, but bit 63 is QCOW_OFLAG_COMPRESSED,
so this patch breaks compressed images.

>  {
>      BDRVQcowState *s = bs->opaque;
>      int min_index, i, j, l1_index, l2_index;
> -    uint64_t l2_offset, *l2_table, cluster_offset, tmp;
> +    int64_t l2_offset, cluster_offset;
> +    uint64_t *l2_table, tmp;
>      uint32_t min_count;
>      int new_l2_table;
> 
> @@ -368,8 +369,11 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
>              return 0;
>          /* allocate a new l2 entry */
>          l2_offset = bdrv_getlength(bs->file->bs);
> +        if (l2_offset < 0) {
> +            return l2_offset;
> +        }
>          /* round to cluster size */
> -        l2_offset = (l2_offset + s->cluster_size - 1) & ~(s->cluster_size - 1);
> +        l2_offset = QEMU_ALIGN_UP(l2_offset, s->cluster_size);
>          /* update the L1 entry */
>          s->l1_table[l1_index] = l2_offset;
>          tmp = cpu_to_be64(l2_offset);
> @@ -430,8 +434,10 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
>              if (decompress_cluster(bs, cluster_offset) < 0)
>                  return 0;
>              cluster_offset = bdrv_getlength(bs->file->bs);
> -            cluster_offset = (cluster_offset + s->cluster_size - 1) &
> -                ~(s->cluster_size - 1);
> +            if (cluster_offset < 0) {
> +                return cluster_offset;
> +            }
> +            cluster_offset = QEMU_ALIGN_UP(cluster_offset, s->cluster_size);
>              /* write the cluster content */
>              if (bdrv_pwrite(bs->file, cluster_offset, s->cluster_cache,
>                              s->cluster_size) !=
> @@ -439,12 +445,19 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
>                  return -1;
>          } else {
>              cluster_offset = bdrv_getlength(bs->file->bs);
> +            if (cluster_offset < 0) {
> +                return cluster_offset;
> +            }
>              if (allocate == 1) {
> +                int ret;
> +
>                  /* round to cluster size */
> -                cluster_offset = (cluster_offset + s->cluster_size - 1) &
> -                    ~(s->cluster_size - 1);
> -                bdrv_truncate(bs->file, cluster_offset + s->cluster_size,
> -                              PREALLOC_MODE_OFF, NULL);
> +                cluster_offset = QEMU_ALIGN_UP(cluster_offset, s->cluster_size);
> +                ret = bdrv_truncate(bs->file, cluster_offset + s->cluster_size,
> +                                    PREALLOC_MODE_OFF, NULL);
> +                if (ret < 0) {
> +                    return ret;
> +                }
>                  /* if encrypted, we must initialize the cluster
>                     content which won't be written */
>                  if (bs->encrypted &&
> @@ -491,11 +504,14 @@ static int64_t coroutine_fn qcow_co_get_block_status(BlockDriverState *bs,
>  {
>      BDRVQcowState *s = bs->opaque;
>      int index_in_cluster, n;
> -    uint64_t cluster_offset;
> +    int64_t cluster_offset;
> 
>      qemu_co_mutex_lock(&s->lock);
>      cluster_offset = get_cluster_offset(bs, sector_num << 9, 0, 0, 0, 0);
>      qemu_co_mutex_unlock(&s->lock);
> +    if (cluster_offset < 0) {
> +        return cluster_offset;
> +    }
>      index_in_cluster = sector_num & (s->cluster_sectors - 1);
>      n = s->cluster_sectors - index_in_cluster;
>      if (n > nb_sectors)
> @@ -567,7 +583,7 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
>      BDRVQcowState *s = bs->opaque;
>      int index_in_cluster;
>      int ret = 0, n;
> -    uint64_t cluster_offset;
> +    int64_t cluster_offset;
>      struct iovec hd_iov;
>      QEMUIOVector hd_qiov;
>      uint8_t *buf;
> @@ -588,8 +604,10 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
> 
>      while (nb_sectors != 0) {
>          /* prepare next request */
> -        cluster_offset = get_cluster_offset(bs, sector_num << 9,
> -                                                 0, 0, 0, 0);
> +        cluster_offset = get_cluster_offset(bs, sector_num << 9, 0, 0, 0, 0);
> +        if (cluster_offset < 0) {
> +            return cluster_offset;
> +        }

Oops, we're still holding s->lock. Combined with the bug that compressed
clusters are treated as errors now, this makes compressed images result
in an assertion failure:

qemu-system-x86_64: util/qemu-coroutine.c:138: qemu_aio_coroutine_enter: Assertion `!co->locks_held' failed.

>          index_in_cluster = sector_num & (s->cluster_sectors - 1);
>          n = s->cluster_sectors - index_in_cluster;
>          if (n > nb_sectors) {

Kevin
