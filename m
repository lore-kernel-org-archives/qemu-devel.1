Received: from eggs.gnu.org ([2001:4830:134:3::10]:41311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fOZfc-0005Ce-I6
	for qemu-devel@nongnu.org; Thu, 31 May 2018 22:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fOZfb-0000NR-C1
	for qemu-devel@nongnu.org; Thu, 31 May 2018 22:20:00 -0400
Date: Thu, 31 May 2018 22:19:49 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180601021949.GE11303@localhost.localdomain>
References: <20180531205046.153256-1-eblake@redhat.com>
	<20180531205046.153256-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531205046.153256-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/8] parallels: Switch to
 byte-based calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com

On Thu, May 31, 2018 at 03:50:39PM -0500, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Make the change for the last few sector-based calls
> into the block layer from the parallels driver.
> 
> Ideally, the parallels driver should switch to doing everything
> byte-based, but that's a more invasive change that requires a
> bit more auditing.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Denis V. Lunev <den@openvz.org>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  block/parallels.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/block/parallels.c b/block/parallels.c
> index 6e9c37f44e1..a761c896d35 100644
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
> -- 
> 2.14.3
> 
> 
