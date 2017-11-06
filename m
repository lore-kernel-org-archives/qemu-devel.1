Received: from eggs.gnu.org ([2001:4830:134:3::10]:34998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiPR-0001xu-VB
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:29:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiPO-0002tY-RL
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:29:53 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:51812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBiPO-0002sB-KV
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:29:50 -0500
Received: by mail-wr0-f195.google.com with SMTP id j15so8768223wre.8
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 06:29:50 -0800 (PST)
References: <20170929111323.6308-1-michael@fritscher.net>
	<20170929111323.6308-8-michael@fritscher.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7eb00f04-101d-96af-08ca-28f892e2ca1c@redhat.com>
Date: Mon, 6 Nov 2017 15:29:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170929111323.6308-8-michael@fritscher.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/18] Fix unused variable error and
 unsuded function if FS_IOC_GETVERSION is not defined.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>, gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org

On 29/09/2017 13:13, Michael Fritscher wrote:
> Signed-off-by: Michael Fritscher <michael@fritscher.net>
> ---
>  hw/9pfs/9p-local.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index e51af87309..4c8e0f3296 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1372,10 +1372,10 @@ static int local_unlinkat(FsContext *ctx, V9fsPath *dir,
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
> @@ -1394,15 +1394,14 @@ static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
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
>  static int local_init(FsContext *ctx)
>  {
> +#ifdef FS_IOC_GETVERSION
>      struct statfs stbuf;
> +#endif
>      LocalData *data = g_malloc(sizeof(*data));
>  
>      data->mountfd = open(ctx->fs_root, O_DIRECTORY | O_RDONLY);
> 

This is probably the change in which patch 2 should be merged.  With the
#include added here, the patch is fine.

Paolo
