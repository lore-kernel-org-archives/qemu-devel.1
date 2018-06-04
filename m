Received: from eggs.gnu.org ([2001:4830:134:3::10]:45129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fPx6e-0002Kq-HN
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fPx6d-0006Lt-Er
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:33:36 -0400
Date: Mon, 4 Jun 2018 17:33:27 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180604213327.GF14298@localhost.localdomain>
References: <20180531205046.153256-1-eblake@redhat.com>
	<20180531205046.153256-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531205046.153256-6-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 5/8] qcow: Switch to a
 byte-based driver
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

On Thu, May 31, 2018 at 03:50:43PM -0500, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  The qcow driver is now ready to fully utilize the
> byte-based callback interface, as long as we override the default
> alignment to still be 512 (needed at least for asserts present
> because of encryption, but easier to do everywhere than to audit
> which sub-sector requests are handled correctly, especially since
> we no longer recommend qcow for new disk images).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> v2: minor rebase to changes earlier in series
> ---
>  block/qcow.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/block/qcow.c b/block/qcow.c
> index 44adeba276c..55720b006ef 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -69,7 +69,6 @@ typedef struct QCowHeader {
>  typedef struct BDRVQcowState {
>      int cluster_bits;
>      int cluster_size;
> -    int cluster_sectors;
>      int l2_bits;
>      int l2_size;
>      unsigned int l1_size;
> @@ -235,7 +234,6 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
>      }
>      s->cluster_bits = header.cluster_bits;
>      s->cluster_size = 1 << s->cluster_bits;
> -    s->cluster_sectors = 1 << (s->cluster_bits - 9);
>      s->l2_bits = header.l2_bits;
>      s->l2_size = 1 << s->l2_bits;
>      bs->total_sectors = header.size / 512;
> @@ -613,8 +611,18 @@ static int decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
>      return 0;
>  }
> 
> -static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
> -                         int nb_sectors, QEMUIOVector *qiov)
> +static void qcow_refresh_limits(BlockDriverState *bs, Error **errp)
> +{
> +    /* At least encrypted images require 512-byte alignment. Apply the
> +     * limit universally, rather than just on encrypted images, as
> +     * it's easier to let the block layer handle rounding than to
> +     * audit this code further. */
> +    bs->bl.request_alignment = BDRV_SECTOR_SIZE;
> +}
> +
> +static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, uint64_t offset,
> +                                       uint64_t bytes, QEMUIOVector *qiov,
> +                                       int flags)
>  {
>      BDRVQcowState *s = bs->opaque;
>      int offset_in_cluster;
> @@ -624,9 +632,8 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
>      QEMUIOVector hd_qiov;
>      uint8_t *buf;
>      void *orig_buf;
> -    int64_t offset = sector_num * BDRV_SECTOR_SIZE;
> -    int64_t bytes = nb_sectors * BDRV_SECTOR_SIZE;
> 
> +    assert(!flags);

Why this assert here and in the _pwritev()?

>      if (qiov->niov > 1) {
>          buf = orig_buf = qemu_try_blockalign(bs, qiov->size);
>          if (buf == NULL) {
> @@ -718,9 +725,9 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
>      return ret;
>  }
> 
> -static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
> -                                       int nb_sectors, QEMUIOVector *qiov,
> -                                       int flags)
> +static coroutine_fn int qcow_co_pwritev(BlockDriverState *bs, uint64_t offset,
> +                                        uint64_t bytes, QEMUIOVector *qiov,
> +                                        int flags)
>  {
>      BDRVQcowState *s = bs->opaque;
>      int offset_in_cluster;
> @@ -730,8 +737,6 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
>      QEMUIOVector hd_qiov;
>      uint8_t *buf;
>      void *orig_buf;
> -    int64_t offset = sector_num * BDRV_SECTOR_SIZE;
> -    int64_t bytes = nb_sectors * BDRV_SECTOR_SIZE;
> 
>      assert(!flags);
>      s->cluster_cache_offset = -1; /* disable compressed cache */
> @@ -1108,8 +1113,7 @@ qcow_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
> 
>      if (ret != Z_STREAM_END || out_len >= s->cluster_size) {
>          /* could not compress: write normal cluster */
> -        ret = qcow_co_writev(bs, offset >> BDRV_SECTOR_BITS,
> -                             bytes >> BDRV_SECTOR_BITS, qiov, 0);
> +        ret = qcow_co_pwritev(bs, offset, bytes, qiov, 0);
>          if (ret < 0) {
>              goto fail;
>          }
> @@ -1194,9 +1198,10 @@ static BlockDriver bdrv_qcow = {
>      .bdrv_co_create_opts    = qcow_co_create_opts,
>      .bdrv_has_zero_init     = bdrv_has_zero_init_1,
>      .supports_backing       = true,
> +    .bdrv_refresh_limits    = qcow_refresh_limits,
> 
> -    .bdrv_co_readv          = qcow_co_readv,
> -    .bdrv_co_writev         = qcow_co_writev,
> +    .bdrv_co_preadv         = qcow_co_preadv,
> +    .bdrv_co_pwritev        = qcow_co_pwritev,
>      .bdrv_co_block_status   = qcow_co_block_status,
> 
>      .bdrv_make_empty        = qcow_make_empty,
> -- 
> 2.14.3
> 
> 
