Received: from eggs.gnu.org ([2001:4830:134:3::10]:50602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gV9op-0000jR-Cq
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 01:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gV9oo-0008PO-Dc
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 01:40:59 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181206151304.8388-1-kwolf@redhat.com>
	<20181206151304.8388-2-kwolf@redhat.com>
Date: Fri, 07 Dec 2018 07:40:50 +0100
In-Reply-To: <20181206151304.8388-2-kwolf@redhat.com> (Kevin Wolf's message of
	"Thu, 6 Dec 2018 16:13:01 +0100")
Message-ID: <871s6t4z65.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/4] vmdk: Refactor vmdk_create_extent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> From: Fam Zheng <famz@redhat.com>
>
> The extracted vmdk_init_extent takes a BlockBackend object and
> initializes the format metadata. It is the common part between "qemu-img
> create" and "blockdev-create".
>
> Add a "BlockBackend *pbb" parameter to vmdk_create_extent, to return the
> opened BB to the caller in the next patch.

I'd do this part in the next patch, when it has a user.  Matter of
taste.

>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/vmdk.c | 69 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 43 insertions(+), 26 deletions(-)
>
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 2c9e86d98f..32fc2c84b3 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1741,35 +1741,17 @@ static int coroutine_fn vmdk_co_pwrite_zeroes(BlockDriverState *bs,
>      return ret;
>  }
>  
> -static int vmdk_create_extent(const char *filename, int64_t filesize,
> -                              bool flat, bool compress, bool zeroed_grain,
> -                              QemuOpts *opts, Error **errp)
> +static int vmdk_init_extent(BlockBackend *blk,
> +                            int64_t filesize, bool flat,
> +                            bool compress, bool zeroed_grain,
> +                            Error **errp)
>  {
>      int ret, i;
> -    BlockBackend *blk = NULL;
>      VMDK4Header header;
> -    Error *local_err = NULL;
>      uint32_t tmp, magic, grains, gd_sectors, gt_size, gt_count;
>      uint32_t *gd_buf = NULL;
>      int gd_buf_size;
>  
> -    ret = bdrv_create_file(filename, opts, &local_err);
> -    if (ret < 0) {
> -        error_propagate(errp, local_err);
> -        goto exit;
> -    }
> -
> -    blk = blk_new_open(filename, NULL, NULL,
> -                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
> -                       &local_err);
> -    if (blk == NULL) {
> -        error_propagate(errp, local_err);
> -        ret = -EIO;
> -        goto exit;
> -    }
> -
> -    blk_set_allow_write_beyond_eof(blk, true);
> -
>      if (flat) {
>          ret = blk_truncate(blk, filesize, PREALLOC_MODE_OFF, errp);
>          goto exit;
> @@ -1863,15 +1845,50 @@ static int vmdk_create_extent(const char *filename, int64_t filesize,
>                       gd_buf, gd_buf_size, 0);
>      if (ret < 0) {
>          error_setg(errp, QERR_IO_ERROR);
> -        goto exit;
>      }
>  
>      ret = 0;
> +exit:
> +    g_free(gd_buf);
> +    return ret;
> +}
> +
> +static int vmdk_create_extent(const char *filename, int64_t filesize,
> +                              bool flat, bool compress, bool zeroed_grain,
> +                              BlockBackend **pbb,
> +                              QemuOpts *opts, Error **errp)
> +{
> +    int ret;
> +    BlockBackend *blk = NULL;
> +    Error *local_err = NULL;
> +
> +    ret = bdrv_create_file(filename, opts, &local_err);
> +    if (ret < 0) {
> +        error_propagate(errp, local_err);
> +        goto exit;
> +    }
> +
> +    blk = blk_new_open(filename, NULL, NULL,
> +                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
> +                       &local_err);
> +    if (blk == NULL) {
> +        error_propagate(errp, local_err);
> +        ret = -EIO;
> +        goto exit;
> +    }
> +
> +    blk_set_allow_write_beyond_eof(blk, true);
> +
> +    ret = vmdk_init_extent(blk, filesize, flat, compress, zeroed_grain, errp);
>  exit:
>      if (blk) {
> -        blk_unref(blk);
> +        if (pbb) {
> +            *pbb = blk;
> +        } else {
> +            blk_unref(blk);
> +            blk = NULL;

Dead assignment.  Matter of taste.

> +        }
>      }
> -    g_free(gd_buf);
>      return ret;
>  }
>  
> @@ -2094,7 +2111,7 @@ static int coroutine_fn vmdk_co_create_opts(const char *filename, QemuOpts *opts
>          snprintf(ext_filename, PATH_MAX, "%s%s", path, desc_filename);
>  
>          if (vmdk_create_extent(ext_filename, size,
> -                               flat, compress, zeroed_grain, opts, errp)) {
> +                               flat, compress, zeroed_grain, NULL, opts, errp)) {
>              ret = -EINVAL;
>              goto exit;
>          }

Reviewed-by: Markus Armbruster <armbru@redhat.com>
