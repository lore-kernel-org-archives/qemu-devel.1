Received: from eggs.gnu.org ([2001:4830:134:3::10]:56693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1EzI-0002Yq-7a
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f1EzH-0004vP-8R
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:35:52 -0400
References: <1522204637-29589-1-git-send-email-zhenwei.pi@youruncloud.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fda2d61d-46c5-133f-7334-353564c799a5@redhat.com>
Date: Wed, 28 Mar 2018 12:35:44 -0500
MIME-Version: 1.0
In-Reply-To: <1522204637-29589-1-git-send-email-zhenwei.pi@youruncloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] file-posix: Support fallocate for block
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "zhenwei.pi" <zhenwei.pi@youruncloud.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 03/27/2018 09:37 PM, zhenwei.pi wrote:
> since linux 4.9, block device supports fallocate. kernel issues
> block device zereout request and invalidates page cache. So
> ioctl(fd, FALLOC_FL_ZERO_RANGE...) is safer than ioctl(fd,

did you mean fallocate() in the first half of the sentence?

> BLKZEROOUT...). try to call do_fallocate, if failing, fallback.
> 
> use new field "has_fallocate_zero_range" with default value as
> true. if do_fallocate returns -ENOTSUP, it will be set false.
> 
> Signed-off-by: zhenwei.pi <zhenwei.pi@youruncloud.com>
> ---
>   block/file-posix.c | 27 +++++++++++++++++----------
>   1 file changed, 17 insertions(+), 10 deletions(-)
> 

This feels more like a feature for 2.13, than a bug fix that would fit 
during freeze for 2.12.

> diff --git a/block/file-posix.c b/block/file-posix.c
> index d7fb772..842e940 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -159,8 +159,9 @@ typedef struct BDRVRawState {
>       bool discard_zeroes:1;
>       bool use_linux_aio:1;
>       bool page_cache_inconsistent:1;
> -    bool has_fallocate;
> -    bool needs_alignment;
> +    bool has_fallocate:1;
> +    bool has_fallocate_zero_range:1;
> +    bool needs_alignment:1;
>   
>       PRManager *pr_mgr;
>   } BDRVRawState;
> @@ -549,6 +550,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>   
>       s->has_discard = true;
>       s->has_write_zeroes = true;
> +    s->has_fallocate_zero_range = true;

Is blindly setting this to true reasonable, given that...

>       if ((bs->open_flags & BDRV_O_NOCACHE) != 0) {
>           s->needs_alignment = true;
>       }
> @@ -1365,10 +1367,6 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
>       int64_t len;
>   #endif
>   
> -    if (aiocb->aio_type & QEMU_AIO_BLKDEV) {
> -        return handle_aiocb_write_zeroes_block(aiocb);
> -    }
> -
>   #ifdef CONFIG_XFS
>       if (s->is_xfs) {
>           return xfs_write_zeroes(s, aiocb->aio_offset, aiocb->aio_nbytes);
> @@ -1376,16 +1374,25 @@ static ssize_t handle_aiocb_write_zeroes(RawPosixAIOData *aiocb)
>   #endif
>   
>   #ifdef CONFIG_FALLOCATE_ZERO_RANGE
> -    if (s->has_write_zeroes) {

...later use is guarded by something learned at compile time?

> +    /* since linux 4.9, block device supports fallocate. kernel issues

s/since/Since/
s/device supports/devices support/
s/kernel issues/The kernel issues a/

> +     * block device zereout request and invalidates page cache. So
> +     * ioctl(fd, FALLOC_FL_ZERO_RANGE...) is safer than ioctl(fd,

Same comment as on commit message; this looks like you meant fallocate 
rather than ioctl on one of the two uses.

> +     * BLKZEROOUT...). try to call do_fallocate, if failing, fallback.

s/try/Try/
s/if failing, fallback/and fall back if that fails/

> +     */
> +    if (s->has_fallocate_zero_range) {
>           int ret = do_fallocate(s->fd, FALLOC_FL_ZERO_RANGE,
>                                  aiocb->aio_offset, aiocb->aio_nbytes);
> -        if (ret == 0 || ret != -ENOTSUP) {
> +        if (ret == 0) {
>               return ret;
> -        }
> -        s->has_write_zeroes = false;
> +        } else if (ret == -ENOTSUP)
> +            s->has_fallocate_zero_range = false;
>       }

Before your patch, if we get any failure other than -ENOTSUP, we exit 
immediately rather than attempting a fallback.  Your code breaks that 
paradigm, and blindly attempts the fallback even when the failure was 
something like EIO.

>   #endif
>   
> +    if (aiocb->aio_type & QEMU_AIO_BLKDEV) {
> +        return handle_aiocb_write_zeroes_block(aiocb);
> +    }
> +
>   #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>       if (s->has_discard && s->has_fallocate) {
>           int ret = do_fallocate(s->fd,
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
