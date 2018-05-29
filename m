Received: from eggs.gnu.org ([2001:4830:134:3::10]:36923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNmE2-0001Ec-Ks
	for qemu-devel@nongnu.org; Tue, 29 May 2018 17:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fNmDz-0000Eq-Ds
	for qemu-devel@nongnu.org; Tue, 29 May 2018 17:32:14 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:58267)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fNmDz-0000DW-7N
	for qemu-devel@nongnu.org; Tue, 29 May 2018 17:32:11 -0400
Received: from player695.ha.ovh.net (unknown [10.109.120.42])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 60A92B346C
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 23:32:09 +0200 (CEST)
Date: Tue, 29 May 2018 23:32:05 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180529233205.59770326@bahia.lan>
In-Reply-To: <a648afd776c8eb50398524c6c8d53629f5141211.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<a648afd776c8eb50398524c6c8d53629f5141211.1527310210.git.keno@alumni.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/13] 9p: darwin: Ignore O_{NOATIME,
 DIRECT}
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

On Sat, 26 May 2018 01:23:10 -0400
keno@juliacomputing.com wrote:

> From: Keno Fischer <keno@alumni.harvard.edu>
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  hw/9pfs/9p.c | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 49654ae..f5f00aa 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -115,20 +115,27 @@ static int dotl_to_open_flags(int flags)
>      int oflags = flags & O_ACCMODE;
>  
>      DotlOpenflagMap dotl_oflag_map[] = {
> -        { P9_DOTL_CREATE, O_CREAT },
> -        { P9_DOTL_EXCL, O_EXCL },
> -        { P9_DOTL_NOCTTY , O_NOCTTY },
> -        { P9_DOTL_TRUNC, O_TRUNC },
> -        { P9_DOTL_APPEND, O_APPEND },
> -        { P9_DOTL_NONBLOCK, O_NONBLOCK } ,
> -        { P9_DOTL_DSYNC, O_DSYNC },
> -        { P9_DOTL_FASYNC, FASYNC },
> -        { P9_DOTL_DIRECT, O_DIRECT },
> -        { P9_DOTL_LARGEFILE, O_LARGEFILE },
> -        { P9_DOTL_DIRECTORY, O_DIRECTORY },
> -        { P9_DOTL_NOFOLLOW, O_NOFOLLOW },
> -        { P9_DOTL_NOATIME, O_NOATIME },
> -        { P9_DOTL_SYNC, O_SYNC },
> +        {P9_DOTL_CREATE, O_CREAT},
> +        {P9_DOTL_EXCL, O_EXCL},
> +        {P9_DOTL_NOCTTY, O_NOCTTY},
> +        {P9_DOTL_TRUNC, O_TRUNC},
> +        {P9_DOTL_APPEND, O_APPEND},
> +        {P9_DOTL_NONBLOCK, O_NONBLOCK},
> +        {P9_DOTL_DSYNC, O_DSYNC},
> +        {P9_DOTL_FASYNC, FASYNC},

Please don't kill the spaces.

> +#ifndef CONFIG_DARWIN
> +        {P9_DOTL_NOATIME, O_NOATIME},
> +        /* On Darwin, we could map to F_NOCACHE, which is
> +           similar, but doesn't quite have the same
> +           semantics. However, we don't support O_DIRECT

But are these semantics worse than dumping the flag ?

> +           even on linux at the moment, so we just ignore
> +           it here. */

Yeah, and I doubt we'll ever support it on linux either. But,
anyway, why filter these out ? Do they cause a build break ?

> +        {P9_DOTL_DIRECT, O_DIRECT},
> +#endif
> +        {P9_DOTL_LARGEFILE, O_LARGEFILE},
> +        {P9_DOTL_DIRECTORY, O_DIRECTORY},
> +        {P9_DOTL_NOFOLLOW, O_NOFOLLOW},
> +        {P9_DOTL_SYNC, O_SYNC},
>      };
>  
>      for (i = 0; i < ARRAY_SIZE(dotl_oflag_map); i++) {
> @@ -156,10 +163,12 @@ static int get_dotl_openflags(V9fsState *s, int oflags)
>       */
>      flags = dotl_to_open_flags(oflags);
>      flags &= ~(O_NOCTTY | O_ASYNC | O_CREAT);
> +#ifndef CONFIG_DARWIN
>      /*
>       * Ignore direct disk access hint until the server supports it.
>       */
>      flags &= ~O_DIRECT;
> +#endif
>      return flags;
>  }
>  
