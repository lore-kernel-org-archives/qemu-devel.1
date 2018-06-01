Received: from eggs.gnu.org ([2001:4830:134:3::10]:56914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOgQO-0002I5-7o
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOgQL-0002YJ-1Q
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:32:44 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:35235)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fOgQK-0002XU-Rk
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:32:40 -0400
Received: from player715.ha.ovh.net (unknown [10.109.108.63])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 383DF13AB36
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 11:32:38 +0200 (CEST)
Date: Fri, 1 Jun 2018 11:32:33 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180601113233.593f1740@bahia.lan>
In-Reply-To: <fa15d00fe0d36af827be442684658b2565e6d368.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
	<fa15d00fe0d36af827be442684658b2565e6d368.1527814874.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/20] 9p: Properly set errp in fstatfs
 error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: qemu-devel@nongnu.org

On Thu, 31 May 2018 21:26:00 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> In the review of
> 
>     9p: Avoid warning if FS_IOC_GETVERSION is not defined
> 
> Grep Kurz noted this error path was failing to set errp.
> Fix that.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---

This is a bug fix so I've applied it to 9p-next.

Thanks!

> 
> Changes since v1: New patch
> 
>  hw/9pfs/9p-local.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index adc169a..576c8e3 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1420,6 +1420,8 @@ static int local_init(FsContext *ctx, Error **errp)
>       */
>      if (fstatfs(data->mountfd, &stbuf) < 0) {
>          close_preserve_errno(data->mountfd);
> +        error_setg_errno(errp, errno,
> +            "failed to stat file system at '%s'", ctx->fs_root);
>          goto err;
>      }
>      switch (stbuf.f_type) {
