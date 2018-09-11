Received: from eggs.gnu.org ([2001:4830:134:3::10]:54104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzjGi-0006hA-TP
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzj9V-000784-27
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:56:25 -0400
References: <20180911083706.5378-1-mahaocong_work@163.com>
	<20180911083706.5378-2-mahaocong_work@163.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3a26f63a-f05b-186f-316c-9a91be752065@redhat.com>
Date: Tue, 11 Sep 2018 08:56:19 -0500
MIME-Version: 1.0
In-Reply-To: <20180911083706.5378-2-mahaocong_work@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] qemu-img: add new function to
 remove bitmap in image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ma Haocong <mahaocong_work@163.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 9/11/18 3:37 AM, Ma Haocong wrote:
> Signed-off-by: Ma Haocong <mahaocong_work@163.com>
> ---
>   qemu-img-cmds.hx |   6 +++
>   qemu-img.c       | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 125 insertions(+)
> 
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index 1526f327a5..cc397b64e4 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -97,6 +97,12 @@ STEXI
>   @item resize [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--preallocation=@var{prealloc}] [-q] [--shrink] @var{filename} [+ | -]@var{size}
>   ETEXI
>   
> +DEF("removebmp", img_removebmp,

Not alphabetical - if we keep this name (which I'm already questioning), 
this should come prior to 'resize'.

> +    "removebmp [--object objectdef] [--image-opts] [-q] [-f fmt] filename dirtybitmap")
> +STEXI
> +@item removebmp [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}] @var{filename} @var{dirtybitmap}
> +ETEXI
> +
>   STEXI
>   @end table
>   ETEXI
> diff --git a/qemu-img.c b/qemu-img.c
> index b12f4cd19b..fdafb4a131 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -835,6 +835,125 @@ fail:
>       return ret;
>   }
>   
> +/*
> + * Remove a named dirty bitmap in image.
> + * This command should be used with no other QEMU process
> + * open the image at the same time. Otherwise it may be
> + * croputed the bitmap even the image.

s/be croputed/corrupt/
s/even/or even/

However, the last sentence is not adding anything useful - we already 
have image locking that should make it impossible to attempt to remove a 
bitmap while some other qemu process has the image open.

> + */
> +static int img_removebmp(int argc, char **argv)
> +{
> +    int               c, ret;
> +    const char       *filename, *fmt, *bitmapname;
> +    bool              quiet = false;
> +    BlockBackend     *blk;
> +    BlockDriverState *bs;
> +    BdrvDirtyBitmap  *bitmap;
> +    Error            *local_err = NULL;
> +    bool image_opts = false;
> +    fmt = NULL;
> +
> +    for (;;) {
> +        int option_index = 0;
> +        static const struct option long_options[] = {
> +            {"help", no_argument, 0, 'h'},
> +            {"format", required_argument, 0, 'f'},
> +            {"object", required_argument, 0, OPTION_OBJECT},
> +            {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
> +            {0, 0, 0, 0}
> +        };
> +        c = getopt_long(argc, argv, ":hf:q",
> +                        long_options, &option_index);

> +    bitmap = bdrv_find_dirty_bitmap(bs, bitmapname);
> +
> +    /*
> +     * Dirty bitmap may not be load if the 'IN_USE' flag is set (e.g. the
> +     * qemu thread is corrupted and the 'IN_USE' flag is not be cleared),
> +     * so the result of bdrv_find_dirty_bitmap is null. In this case,
> +     * we delete bitmap in qcow2 file directly.
> +    */
> +    if (!bitmap) {
> +        bdrv_remove_persistent_dirty_bitmap(bs, bitmapname, &local_err);
> +        if (local_err != NULL) {
> +            ret = -1;
> +            goto out;
> +        }
> +    } else {
> +        if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
> +            bdrv_remove_persistent_dirty_bitmap(bs, bitmapname, &local_err);
> +            if (local_err != NULL) {
> +                ret = -1;
> +                goto out;
> +            }
> +        }
> +        bdrv_release_dirty_bitmap(bs, bitmap);
> +    }

Why aren't you calling bdrv_block_dirty_bitmap_remove()?  In general, 
HMP commands that are mere wrappers around counterpart QMP commands are 
easier to maintain, rather than open-coding the same work in two places.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
