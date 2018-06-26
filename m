Received: from eggs.gnu.org ([2001:4830:134:3::10]:36980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXk4c-0001Vg-2R
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXk4Y-0007gw-SZ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:15:42 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:40356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fXk4Y-0007g4-Hs
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:15:38 -0400
Received: from player692.ha.ovh.net (unknown [10.109.105.20])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id B39901BF368
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 11:15:36 +0200 (CEST)
Date: Tue, 26 Jun 2018 11:15:33 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180626111533.38b27521@bahia.lan>
In-Reply-To: <823a49a8771e3214dc953ed9d7facd02df3060e4.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
	<823a49a8771e3214dc953ed9d7facd02df3060e4.1529196703.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/13] 9p: darwin: Ignore O_{NOATIME,
 DIRECT}
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

On Sat, 16 Jun 2018 20:56:50 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> Darwin doesn't have either of these flags. Darwin does have
> F_NOCACHE, which is similar to O_DIRECT, but has different
> enough semantics that other projects don't generally map
> them automatically. In any case, we don't support O_DIRECT
> on Linux at the moment either.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/9p.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 06139c9..e650459 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -123,11 +123,18 @@ static int dotl_to_open_flags(int flags)
>          { P9_DOTL_NONBLOCK, O_NONBLOCK } ,
>          { P9_DOTL_DSYNC, O_DSYNC },
>          { P9_DOTL_FASYNC, FASYNC },
> +#ifndef CONFIG_DARWIN
> +        { P9_DOTL_NOATIME, O_NOATIME },
> +        /* On Darwin, we could map to F_NOCACHE, which is
> +           similar, but doesn't quite have the same
> +           semantics. However, we don't support O_DIRECT
> +           even on linux at the moment, so we just ignore
> +           it here. */
>          { P9_DOTL_DIRECT, O_DIRECT },
> +#endif
>          { P9_DOTL_LARGEFILE, O_LARGEFILE },
>          { P9_DOTL_DIRECTORY, O_DIRECTORY },
>          { P9_DOTL_NOFOLLOW, O_NOFOLLOW },
> -        { P9_DOTL_NOATIME, O_NOATIME },
>          { P9_DOTL_SYNC, O_SYNC },
>      };
>  
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
