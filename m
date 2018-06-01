Received: from eggs.gnu.org ([2001:4830:134:3::10]:37220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOh4J-0001Lq-RN
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOh4F-00070h-Nu
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:13:59 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:55458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fOh4F-000706-Fu
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 06:13:55 -0400
Received: from player787.ha.ovh.net (unknown [10.109.108.70])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id F271917A30
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 12:13:53 +0200 (CEST)
Date: Fri, 1 Jun 2018 12:13:51 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180601121351.3083ec1b@bahia.lan>
In-Reply-To: <21ef05f216f09056c252d2d23a18dd75008e8c72.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
	<21ef05f216f09056c252d2d23a18dd75008e8c72.1527814874.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/20] 9p: Properly check/translate
 flags in unlinkat
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

On Thu, 31 May 2018 21:26:04 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> This code previously relied on P9_DOTL_AT_REMOVEDIR and AT_REMOVEDIR
> having the same numerical value and deferred any errorchecking to the
> syscall itself. However, while the former assumption is true on Linux,
> it is not true in general. Thus, add appropriate error checking and
> translation to the 9p unlinkat server code.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
> 

Looks good but handle_unlinkat() needs to be adapted to this change.
Other backends (proxy and synth) seem to ignore the flags.

> Changes since v1:
>  * Code was moved from 9p-local.c to server entry point in 9p.c
> 
>  hw/9pfs/9p.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index b80db65..a757374 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -2522,7 +2522,7 @@ static void coroutine_fn v9fs_unlinkat(void *opaque)
>  {
>      int err = 0;
>      V9fsString name;
> -    int32_t dfid, flags;
> +    int32_t dfid, flags, rflags = 0;
>      size_t offset = 7;
>      V9fsPath path;
>      V9fsFidState *dfidp;
> @@ -2549,6 +2549,15 @@ static void coroutine_fn v9fs_unlinkat(void *opaque)
>          goto out_nofid;
>      }
>  
> +    if (flags & ~P9_DOTL_AT_REMOVEDIR) {
> +        err = -EINVAL;
> +        goto out_nofid;
> +    }
> +
> +    if (flags & P9_DOTL_AT_REMOVEDIR) {
> +        rflags |= AT_REMOVEDIR;
> +    }
> +
>      dfidp = get_fid(pdu, dfid);
>      if (dfidp == NULL) {
>          err = -EINVAL;
> @@ -2567,7 +2576,7 @@ static void coroutine_fn v9fs_unlinkat(void *opaque)
>      if (err < 0) {
>          goto out_err;
>      }
> -    err = v9fs_co_unlinkat(pdu, &dfidp->path, &name, flags);
> +    err = v9fs_co_unlinkat(pdu, &dfidp->path, &name, rflags);
>      if (!err) {
>          err = offset;
>      }
