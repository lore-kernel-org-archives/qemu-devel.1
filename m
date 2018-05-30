Received: from eggs.gnu.org ([2001:4830:134:3::10]:60731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fO05l-0004HI-BG
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fO05h-0004XG-7a
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:20:37 -0400
Received: from 20.mo3.mail-out.ovh.net ([178.33.47.94]:39447)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fO05h-0004Wv-0P
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:20:33 -0400
Received: from player758.ha.ovh.net (unknown [10.109.108.89])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 3191C1B7BF5
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 14:20:31 +0200 (CEST)
Date: Wed, 30 May 2018 14:20:26 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180530142026.7c59d967@bahia.lan>
In-Reply-To: <e47c58ca95c93503a9d85dc6d749acf9fe9c6e76.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<e47c58ca95c93503a9d85dc6d749acf9fe9c6e76.1527310210.git.keno@alumni.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/13] 9p: darwin: Mark mknod as unsupported
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

On Sat, 26 May 2018 01:23:13 -0400
keno@juliacomputing.com wrote:

> From: Keno Fischer <keno@alumni.harvard.edu>
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  hw/9pfs/9p-local.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index c55ea25..3e358b7 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -669,6 +669,13 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
>          return -1;
>      }
>  
> +#ifdef CONFIG_DARWIN
> +    /* Darwin doesn't have mknodat and it's unlikely to work anyway,

What's unlikely to work ?

> +       so let's just mark it as unsupported */
> +    err = -1;
> +    errno = EOPNOTSUPP;
> +    goto out;
> +#else

Please introduce qemu_mknodat() with distinct implementations for linux
and darwin.

>      if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
>          fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
>          err = mknodat(dirfd, name, fs_ctx->fmode | S_IFREG, 0);
> @@ -699,6 +706,8 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
>  
>  err_end:
>      unlinkat_preserve_errno(dirfd, name, 0);
> +#endif
> +
>  out:
>      close_preserve_errno(dirfd);
>      return err;
