Received: from eggs.gnu.org ([2001:4830:134:3::10]:58095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fPwI3-0001bJ-Pd
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fPwI2-000556-OC
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:41:19 -0400
Date: Mon, 4 Jun 2018 16:41:09 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180604204109.GC14298@localhost.localdomain>
References: <20180531205046.153256-1-eblake@redhat.com>
	<20180531205046.153256-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531205046.153256-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/8] qcow: Switch
 get_cluster_offset to be byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Thu, May 31, 2018 at 03:50:40PM -0500, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Make the change for the internal helper function
> get_cluster_offset(), by changing n_start and n_end to by byte

s/by\ byte/be\ byte/

> offsets rather than sector indices within the cluster being
> allocated.  However, assert that these values are still
> sector-aligned (at least qcrypto_block_encrypt() still wants that).
> For now we get that alignment for free because we still use
> sector-based driver callbacks.
> 
> A later patch will then switch the qcow driver as a whole over
> to byte-based operation; but will still leave things at sector
> alignments as it is not worth auditing the qcow image format
> to worry about sub-sector requests.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> 
> ---
> v2: assert sector alignment [Max]
> ---
>  block/qcow.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/block/qcow.c b/block/qcow.c
> index 3ba2ca25ea5..42d1bbb7643 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -345,8 +345,8 @@ static int qcow_reopen_prepare(BDRVReopenState *state,
>   *
>   * 0 to not allocate.
>   *
> - * 1 to allocate a normal cluster (for sector indexes 'n_start' to
> - * 'n_end')
> + * 1 to allocate a normal cluster (for sector-aligned byte offsets 'n_start'
> + * to 'n_end' within the cluster)
>   *
>   * 2 to allocate a compressed cluster of size
>   * 'compressed_size'. 'compressed_size' must be > 0 and <
> @@ -440,9 +440,10 @@ static int get_cluster_offset(BlockDriverState *bs,
>          if (!allocate)
>              return 0;
>          BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC);
> +        assert(QEMU_IS_ALIGNED(n_start | n_end, BDRV_SECTOR_SIZE));
>          /* allocate a new cluster */
>          if ((cluster_offset & QCOW_OFLAG_COMPRESSED) &&
> -            (n_end - n_start) < s->cluster_sectors) {
> +            (n_end - n_start) < s->cluster_size) {
>              /* if the cluster is already compressed, we must
>                 decompress it in the case it is not completely
>                 overwritten */
> @@ -480,16 +481,15 @@ static int get_cluster_offset(BlockDriverState *bs,
>                  /* if encrypted, we must initialize the cluster
>                     content which won't be written */
>                  if (bs->encrypted &&
> -                    (n_end - n_start) < s->cluster_sectors) {
> -                    uint64_t start_sect;
> +                    (n_end - n_start) < s->cluster_size) {
> +                    uint64_t start_offset;
>                      assert(s->crypto);
> -                    start_sect = (offset & ~(s->cluster_size - 1)) >> 9;
> -                    for(i = 0; i < s->cluster_sectors; i++) {
> +                    start_offset = offset & ~(s->cluster_size - 1);
> +                    for (i = 0; i < s->cluster_size; i += BDRV_SECTOR_SIZE) {
>                          if (i < n_start || i >= n_end) {
> -                            memset(s->cluster_data, 0x00, 512);
> +                            memset(s->cluster_data, 0x00, BDRV_SECTOR_SIZE);
>                              if (qcrypto_block_encrypt(s->crypto,
> -                                                      (start_sect + i) *
> -                                                      BDRV_SECTOR_SIZE,
> +                                                      start_offset + i,
>                                                        s->cluster_data,
>                                                        BDRV_SECTOR_SIZE,
>                                                        NULL) < 0) {
> @@ -497,8 +497,9 @@ static int get_cluster_offset(BlockDriverState *bs,
>                              }
>                              BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
>                              ret = bdrv_pwrite(bs->file,
> -                                              cluster_offset + i * 512,
> -                                              s->cluster_data, 512);
> +                                              cluster_offset + i,
> +                                              s->cluster_data,
> +                                              BDRV_SECTOR_SIZE);
>                              if (ret < 0) {
>                                  return ret;
>                              }
> @@ -758,8 +759,8 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
>              n = nb_sectors;
>          }
>          ret = get_cluster_offset(bs, sector_num << 9, 1, 0,
> -                                 index_in_cluster,
> -                                 index_in_cluster + n, &cluster_offset);
> +                                 index_in_cluster << 9,
> +                                 (index_in_cluster + n) << 9, &cluster_offset);
>          if (ret < 0) {
>              break;
>          }
> -- 
> 2.14.3
> 
> 
