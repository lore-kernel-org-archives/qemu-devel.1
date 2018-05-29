Received: from eggs.gnu.org ([2001:4830:134:3::10]:52856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNlSi-0006WC-Em
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNlSf-0001uc-9m
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:43:20 -0400
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:48945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fNlSf-0001tg-2x
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:43:17 -0400
Received: from player760.ha.ovh.net (unknown [10.109.108.46])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 8A33FFFD6D
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 22:43:15 +0200 (CEST)
Date: Tue, 29 May 2018 22:43:11 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180529224311.79e0c201@bahia.lan>
In-Reply-To: <cd4661a5e122b1dcd848ff5cdf202e728a0359a8.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<cd4661a5e122b1dcd848ff5cdf202e728a0359a8.1527310210.git.keno@alumni.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/13] 9p: darwin: Properly translate
 AT_REMOVEDIR flag
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

On Sat, 26 May 2018 01:23:09 -0400
keno@juliacomputing.com wrote:

> From: Keno Fischer <keno@alumni.harvard.edu>
> 
> This code relied on P9_DOTL_AT_REMOVEDIR and AT_REMOVEDIR having the same
> numerical value, but on Darwin, they do not.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  hw/9pfs/9p-local.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 6e0b2e8..c55ea25 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1376,7 +1376,17 @@ static int local_unlinkat(FsContext *ctx, V9fsPath *dir,
>          return -1;
>      }
>  
> -    ret = local_unlinkat_common(ctx, dirfd, name, flags);
> +    if ((flags & ~P9_DOTL_AT_REMOVEDIR) != 0) {

The != 0 isn't needed but...

> +        errno = EINVAL;
> +        return -1;

... I'm more concerned about this new error path. How can this happen ?

> +    }
> +
> +    size_t rflags = 0;

Please declare this at the beginning of the function.

> +    if (flags & P9_DOTL_AT_REMOVEDIR) {
> +        rflags |= AT_REMOVEDIR;
> +    }
> +
> +    ret = local_unlinkat_common(ctx, dirfd, name, rflags);
>      close_preserve_errno(dirfd);
>      return ret;
>  }
