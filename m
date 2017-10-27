Received: from eggs.gnu.org ([2001:4830:134:3::10]:58855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1e83WQ-0000Xs-HJ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1e83WK-0000V5-7z
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:13:58 -0400
References: <cover.1509094209.git.jcody@redhat.com>
	<2f0114c773e8fb917a7a54acccfd2e2adfb6e066.1509094209.git.jcody@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <bd009057-1ca8-ab7b-1132-902647a2c082@openvz.org>
Date: Fri, 27 Oct 2017 14:13:43 +0200
MIME-Version: 1.0
In-Reply-To: <2f0114c773e8fb917a7a54acccfd2e2adfb6e066.1509094209.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/4] block/parallels: Don't update header
 until the first actual write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, mreitz@redhat.com, stefanha@redhat.com

On 10/27/2017 10:57 AM, Jeff Cody wrote:
> The on disk image format 'inuse' header field is updated blindly if the
> image is opened RDWR.  This can cause problems if the QEMU runstate is
> set to INMIGRATE, at which point the underlying file is set to INACTIVE.
> This causes an assert in bdrv_co_pwritev().
>
> Do something similar to what is done in VHDX; latch the first write, and
> update the header the first time we modify the file.
>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/parallels.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index fed199eccd..c560e2fcf2 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -100,6 +100,8 @@ typedef struct BDRVParallelsState {
>      unsigned int tracks;
>  
>      unsigned int off_multiplier;
> +
> +    bool first_write_latch;
>  } BDRVParallelsState;
>  
>  
> @@ -317,6 +319,16 @@ static coroutine_fn int parallels_co_writev(BlockDriverState *bs,
>      QEMUIOVector hd_qiov;
>      int ret = 0;
>  
> +    if (s->first_write_latch) {
> +        s->first_write_latch = false;
> +        qemu_co_mutex_lock(&s->lock);
> +        ret = parallels_update_header(bs);
> +        qemu_co_mutex_unlock(&s->lock);
> +    }
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
>      qemu_iovec_init(&hd_qiov, qiov->niov);
>  
>      while (nb_sectors > 0) {
> @@ -416,6 +428,9 @@ static int parallels_check(BlockDriverState *bs, BdrvCheckResult *res,
>              /* parallels_close will do the job right */
>              res->corruptions_fixed++;
>              s->header_unclean = false;
> +            /* set that a write has occurred, so that parallels_close() will
> +             * update the inuse field in the header */
> +            s->first_write_latch = false;
>          }
>      }
>  
> @@ -597,6 +612,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>      Error *local_err = NULL;
>      char *buf;
>  
> +    s->first_write_latch = true;
> +
>      bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
>                                 false, errp);
>      if (!bs->file) {
> @@ -710,10 +727,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>  
>      if (flags & BDRV_O_RDWR) {
>          s->header->inuse = cpu_to_le32(HEADER_INUSE_MAGIC);
> -        ret = parallels_update_header(bs);
> -        if (ret < 0) {
> -            goto fail;
> -        }
>      }
>  
>      s->bat_dirty_block = 4 * getpagesize();
> @@ -741,7 +754,9 @@ static void parallels_close(BlockDriverState *bs)
>  {
>      BDRVParallelsState *s = bs->opaque;
>  
> -    if (bs->open_flags & BDRV_O_RDWR) {
> +    /* Only need to update the header, if we ever actually wrote to the
> +     * image at all */
> +    if ((bs->open_flags & BDRV_O_RDWR) && !s->first_write_latch) {
>          s->header->inuse = 0;
>          parallels_update_header(bs);
>      }
Reviewed-by: Denis V. Lunev <den@openvz.org>
