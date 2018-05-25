Received: from eggs.gnu.org ([208.118.235.92]:46120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1fMFbQ-0007qQ-Je
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1fMFbP-0007gB-LY
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:30:04 -0400
References: <20180425183223.580566-1-eblake@redhat.com>
	<20180425183223.580566-2-eblake@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <0c17a9eb-6398-1e77-5561-b365c94da741@openvz.org>
Date: Fri, 25 May 2018 19:29:49 +0300
MIME-Version: 1.0
In-Reply-To: <20180425183223.580566-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/8] parallels: Switch to byte-based calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:parallels" <qemu-block@nongnu.org>

On 04/25/2018 09:32 PM, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Make the change for the last few sector-based calls
> into the block layer from the parallels driver.
>
> Ideally, the parallels driver should switch to doing everything
> byte-based, but that's a more invasive change that requires a
> bit more auditing.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/parallels.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 3f74fcb877a..c071c7f759f 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -226,14 +226,15 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
>          };
>          qemu_iovec_init_external(&qiov, &iov, 1);
>
> -        ret = bdrv_co_readv(bs->backing, idx * s->tracks, nb_cow_sectors,
> -                            &qiov);
> +        ret = bdrv_co_preadv(bs->backing, idx * s->tracks * BDRV_SECTOR_SIZE,
> +                             nb_cow_bytes, &qiov, 0);
>          if (ret < 0) {
>              qemu_vfree(iov.iov_base);
>              return ret;
>          }
>
> -        ret = bdrv_co_writev(bs->file, s->data_end, nb_cow_sectors, &qiov);
> +        ret = bdrv_co_pwritev(bs->file, s->data_end * BDRV_SECTOR_SIZE,
> +                              nb_cow_bytes, &qiov, 0);
>          qemu_vfree(iov.iov_base);
>          if (ret < 0) {
>              return ret;
> @@ -339,7 +340,8 @@ static coroutine_fn int parallels_co_writev(BlockDriverState *bs,
>          qemu_iovec_reset(&hd_qiov);
>          qemu_iovec_concat(&hd_qiov, qiov, bytes_done, nbytes);
>
> -        ret = bdrv_co_writev(bs->file, position, n, &hd_qiov);
> +        ret = bdrv_co_pwritev(bs->file, position * BDRV_SECTOR_SIZE, nbytes,
> +                              &hd_qiov, 0);
>          if (ret < 0) {
>              break;
>          }
> @@ -378,7 +380,8 @@ static coroutine_fn int parallels_co_readv(BlockDriverState *bs,
>
>          if (position < 0) {
>              if (bs->backing) {
> -                ret = bdrv_co_readv(bs->backing, sector_num, n, &hd_qiov);
> +                ret = bdrv_co_preadv(bs->backing, sector_num * BDRV_SECTOR_SIZE,
> +                                     nbytes, &hd_qiov, 0);
>                  if (ret < 0) {
>                      break;
>                  }
> @@ -386,7 +389,8 @@ static coroutine_fn int parallels_co_readv(BlockDriverState *bs,
>                  qemu_iovec_memset(&hd_qiov, 0, 0, nbytes);
>              }
>          } else {
> -            ret = bdrv_co_readv(bs->file, position, n, &hd_qiov);
> +            ret = bdrv_co_preadv(bs->file, position * BDRV_SECTOR_SIZE, nbytes,
> +                                 &hd_qiov, 0);
>              if (ret < 0) {
>                  break;
>              }
Reviewed-by: Denis V. Lunev <den@openvz.org>
