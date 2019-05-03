Received: from eggs.gnu.org ([209.51.188.92]:41101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hMWmZ-000410-VZ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hMWmY-0001Hy-Ob
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:55:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1hMWmY-0001EX-HI
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:55:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id w11so5681878edl.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 04:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190503110206.42811-1-sgarzare@redhat.com>
In-Reply-To: <20190503110206.42811-1-sgarzare@redhat.com>
Reply-To: dillaman@redhat.com
From: Jason Dillaman <jdillama@redhat.com>
Date: Fri, 3 May 2019 07:55:01 -0400
Message-ID: <CA+aFP1DBc_NdswPJLGGHq3H-uU+LqXON7SLQ16K3H3jAt_02HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] block/rbd: implement
 .bdrv_get_allocated_file_size callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>, qemu-block <qemu-block@nongnu.org>

On Fri, May 3, 2019 at 7:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> This patch allows 'qemu-img info' to show the 'disk size' for
> rbd images. We use the rbd_diff_iterate2() API to calculate the
> allocated size for the image.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/rbd.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 0c549c9935..61447bc0cb 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -1046,6 +1046,38 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
>      return info.size;
>  }
>
> +static int rbd_allocated_size_cb(uint64_t offset, size_t len, int exists,
> +                                 void *arg)
> +{
> +    int64_t *alloc_size = (int64_t *) arg;
> +
> +    if (exists) {
> +        (*alloc_size) += len;
> +    }
> +
> +    return 0;
> +}
> +
> +static int64_t qemu_rbd_get_allocated_file_size(BlockDriverState *bs)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +    int64_t alloc_size = 0;
> +    int r;
> +
> +    /*
> +     * rbd_diff_iterate2(), if the source snapshot name is NULL, invokes
> +     * the callback on all allocated regions of the image.
> +     */
> +    r = rbd_diff_iterate2(s->image, NULL, 0,
> +                          bs->total_sectors * BDRV_SECTOR_SIZE, 0, 1,
> +                          &rbd_allocated_size_cb, &alloc_size);

Is there any concern that running this on very large images will take
a very long time since it needs to iterate through each individual
4MiB (by default) backing object in the image? In libvirt, it only
attempts to calculate the actual usage if the fast-diff feature is
enabled, and recently it also got a new control to optionally disable
the functionality entirely since even with fast-diff it's can be very
slow to compute over hundreds of images in a libvirt storage pool.

> +    if (r < 0) {
> +        return r;
> +    }
> +
> +    return alloc_size;
> +}
> +
>  static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
>                                               int64_t offset,
>                                               PreallocMode prealloc,
> @@ -1254,6 +1286,7 @@ static BlockDriver bdrv_rbd = {
>      .bdrv_get_info          = qemu_rbd_getinfo,
>      .create_opts            = &qemu_rbd_create_opts,
>      .bdrv_getlength         = qemu_rbd_getlength,
> +    .bdrv_get_allocated_file_size = qemu_rbd_get_allocated_file_size,
>      .bdrv_co_truncate       = qemu_rbd_co_truncate,
>      .protocol_name          = "rbd",
>
> --
> 2.20.1
>


-- 
Jason
