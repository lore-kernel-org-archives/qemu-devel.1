Received: from eggs.gnu.org ([2001:4830:134:3::10]:34398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eFh5z-0001I7-NZ
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eFh5x-0001Iq-5u
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:54:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eFh5w-0001FH-V7
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:54:13 -0500
Date: Fri, 17 Nov 2017 13:54:09 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171117135409.GA3669@stefanha-x1.localdomain>
References: <1510899814-19372-1-git-send-email-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <1510899814-19372-1-git-send-email-yang.zhong@intel.com>
Subject: Re: [Qemu-devel] [PATCH] rcu: reduce half heap memory size by
 malloc_trim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, anthony.xu@intel.com, stone.xulei@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, zhang.zhanghailiang@huawei.com, liujunjie23@huawei.com


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2017 at 02:23:34PM +0800, Yang Zhong wrote:
> diff --git a/util/rcu.c b/util/rcu.c
> index ca5a63e..8d491a6 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -26,6 +26,7 @@
>   * IBM's contributions to this file may be relicensed under LGPLv2 or la=
ter.
>   */
> =20
> +#include <malloc.h>

This header file is not mentioned in the C99 standard or POSIX.  It is
probably not available on all host OSes that QEMU supports.  Please use
#ifdef CONFIG_LINUX.

>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qemu/rcu.h"
> @@ -272,6 +273,9 @@ static void *call_rcu_thread(void *opaque)
>              node->func(node);
>          }
>          qemu_mutex_unlock_iothread();
> +#ifdef CONFIG_LINUX
> +        malloc_trim(0);
> +#endif

It is important that the rcu thread isn't overzealous in minimizing heap
size if that means ordinary malloc(3) calls will experience latency
spikes.  Please leave a few MB free so that malloc(3) doesn't take the
slow path.

Stefan

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaDuoBAAoJEJykq7OBq3PI2xgH/3sTsLSHZUcdNAVJcLpxmn8O
GDOwPO5VhW3PcrO5Gqg3XH0M+n78437IUoTmBEQJCa6R9fuk9FS2YIUkoiQwUcGj
mEncvb+XKMsMIpujL/h6rq4yxAw4e9gerIB9jWp3mp8kcPqu8IJEgPZTVboW7FWZ
oQlhJUjp/4jOfxs4gyA1Q4aqxQhge9LuyIPW+xXYwDOmtUJXkPgtCFeI8zjwzmcD
wkkn5oiaERctwPbEhvp/91AMBwtW1PKiZAtUe6hiTSiobABZDgRhxKqqVED7g7/b
3id+sN+ybrshFjVXX/77hceZq0lrBpIxJfPFZsdLK+g9yw6az7KrVwaIWfs2UkY=
=bgkZ
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
