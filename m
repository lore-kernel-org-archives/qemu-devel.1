Received: from eggs.gnu.org ([2001:4830:134:3::10]:38314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNIZo-0008Vt-Fk
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNIZh-0003FA-44
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:52:44 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:42309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fNIZg-0003E4-TT
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:52:37 -0400
Received: from player716.ha.ovh.net (unknown [10.109.108.117])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 45896B01CF
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 15:52:33 +0200 (CEST)
Date: Mon, 28 May 2018 15:52:28 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180528155228.3294c7f3@bahia.lan>
In-Reply-To: <a6ce15881bf120c8df68acfff6f2bd9c0745007b.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<a6ce15881bf120c8df68acfff6f2bd9c0745007b.1527310210.git.keno@alumni.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/13] 9p: Avoid warning if
 FS_IOC_GETVERSION is not defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keno@juliacomputing.com
Cc: qemu-devel@nongnu.org, Keno Fischer <keno@alumni.harvard.edu>

On Sat, 26 May 2018 01:23:04 -0400
keno@juliacomputing.com wrote:

> From: Keno Fischer <keno@alumni.harvard.edu>
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  hw/9pfs/9p-local.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index f6c7526..7592f8d 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1375,10 +1375,10 @@ static int local_unlinkat(FsContext *ctx, V9fsPath *dir,
>      return ret;
>  }
>  
> +#ifdef FS_IOC_GETVERSION
>  static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
>                                  mode_t st_mode, uint64_t *st_gen)
>  {
> -#ifdef FS_IOC_GETVERSION
>      int err;
>      V9fsFidOpenState fid_open;
>  
> @@ -1397,15 +1397,11 @@ static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
>      err = ioctl(fid_open.fd, FS_IOC_GETVERSION, st_gen);
>      local_close(ctx, &fid_open);
>      return err;
> -#else
> -    errno = ENOTTY;
> -    return -1;
> -#endif
>  }
> +#endif
>  
>  static int local_init(FsContext *ctx, Error **errp)
>  {
> -    struct statfs stbuf;
>      LocalData *data = g_malloc(sizeof(*data));
>  
>      data->mountfd = open(ctx->fs_root, O_DIRECTORY | O_RDONLY);
> @@ -1415,20 +1411,23 @@ static int local_init(FsContext *ctx, Error **errp)
>      }
>  
>  #ifdef FS_IOC_GETVERSION
> -    /*
> -     * use ioc_getversion only if the ioctl is definied
> -     */
> -    if (fstatfs(data->mountfd, &stbuf) < 0) {
> -        close_preserve_errno(data->mountfd);

Hmm... I now realize that this path doesn't set errp, which means that
we could possibly fail the device realization without reporting any
error to the caller. Could you please fix this in a preparatory patch ?

> -        goto err;
> -    }
> -    switch (stbuf.f_type) {
> -    case EXT2_SUPER_MAGIC:
> -    case BTRFS_SUPER_MAGIC:
> -    case REISERFS_SUPER_MAGIC:
> -    case XFS_SUPER_MAGIC:
> -        ctx->exops.get_st_gen = local_ioc_getversion;
> -        break;
> +    {
> +        struct statfs stbuf;
> +        /*
> +        * use ioc_getversion only if the ioctl is definied
> +        */
> +        if (fstatfs(data->mountfd, &stbuf) < 0) {
> +            close_preserve_errno(data->mountfd);
> +            goto err;
> +        }
> +        switch (stbuf.f_type) {
> +        case EXT2_SUPER_MAGIC:
> +        case BTRFS_SUPER_MAGIC:
> +        case REISERFS_SUPER_MAGIC:
> +        case XFS_SUPER_MAGIC:
> +            ctx->exops.get_st_gen = local_ioc_getversion;
> +            break;
> +        }

Please move this to a separate local_ioc_getversion_init() function, that would
be empty if FS_IOC_GETVERSION is not defined.

>      }
>  #endif
>  
