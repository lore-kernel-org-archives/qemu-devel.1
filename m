Received: from eggs.gnu.org ([209.51.188.92]:36148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hMbsP-0004cP-AC
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hMbsO-0007ij-8O
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:21:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1hMbsO-0007hm-1k
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:21:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id f37so6822359edb.13
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190503163028.213823-1-sgarzare@redhat.com>
In-Reply-To: <20190503163028.213823-1-sgarzare@redhat.com>
Reply-To: dillaman@redhat.com
From: Jason Dillaman <jdillama@redhat.com>
Date: Fri, 3 May 2019 13:21:23 -0400
Message-ID: <CA+aFP1BWA416Q1=PB3xcQUPc1fQ-Cq+mhnG8FbkJiLDEvT0wyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] block/rbd: increase dynamically the
 image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Fri, May 3, 2019 at 12:30 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> RBD APIs don't allow us to write more than the size set with
> rbd_create() or rbd_resize().
> In order to support growing images (eg. qcow2), we resize the
> image before write operations that exceed the current size.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v2:
>   - use bs->total_sectors instead of adding a new field [Kevin]
>   - resize the image only during write operation [Kevin]
>     for read operation, the bdrv_aligned_preadv() already handles reads
>     that exceed the length returned by bdrv_getlength(), so IMHO we can
>     avoid to handle it in the rbd driver
> ---
>  block/rbd.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 0c549c9935..613e8f4982 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -934,13 +934,25 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
>      }
>
>      switch (cmd) {
> -    case RBD_AIO_WRITE:
> +    case RBD_AIO_WRITE: {
> +        /*
> +         * RBD APIs don't allow us to write more than actual size, so in order
> +         * to support growing images, we resize the image before write
> +         * operations that exceed the current size.
> +         */
> +        if (off + size > bs->total_sectors * BDRV_SECTOR_SIZE) {

When will "bs->total_sectors" be refreshed to represent the correct
current size? You wouldn't want a future write whose extent was
greater than the original image size but less then a previous IO that
expanded the image to attempt to shrink the image.

> +            r = rbd_resize(s->image, off + size);
> +            if (r < 0) {
> +                goto failed_completion;
> +            }
> +        }
>  #ifdef LIBRBD_SUPPORTS_IOVEC
>              r = rbd_aio_writev(s->image, qiov->iov, qiov->niov, off, c);
>  #else
>              r = rbd_aio_write(s->image, off, size, rcb->buf, c);
>  #endif
>          break;
> +    }
>      case RBD_AIO_READ:
>  #ifdef LIBRBD_SUPPORTS_IOVEC
>              r = rbd_aio_readv(s->image, qiov->iov, qiov->niov, off, c);
> --
> 2.20.1
>
>


-- 
Jason
