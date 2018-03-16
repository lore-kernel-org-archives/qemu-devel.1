Received: from eggs.gnu.org ([2001:4830:134:3::10]:59918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ewlbI-0006ux-Vx
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ewlbF-0001ig-Ov
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:24:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ewlbF-0001iP-K3
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:24:33 -0400
References: <1521144392-26203-1-git-send-email-jusual@mail.ru>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cf539498-797c-57df-7fad-d6883b2cba2f@redhat.com>
Date: Fri, 16 Mar 2018 17:24:09 +0800
MIME-Version: 1.0
In-Reply-To: <1521144392-26203-1-git-send-email-jusual@mail.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net/vde: print error on vde_open() failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: Jim Mussared <jim@groklearning.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>



On 2018=E5=B9=B403=E6=9C=8816=E6=97=A5 04:06, Julia Suvorova via Qemu-dev=
el wrote:
> Despite the fact that now when the initialization of vde fails, qemu
> does not end silently, no informative error is printed. The patch
> generates an error and pushes it through the calling function.
>
> Related bug: https://bugs.launchpad.net/qemu/+bug/676029
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>   net/vde.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/vde.c b/net/vde.c
> index e50e5d6..99189cc 100644
> --- a/net/vde.c
> +++ b/net/vde.c
> @@ -30,6 +30,7 @@
>   #include "qemu-common.h"
>   #include "qemu/option.h"
>   #include "qemu/main-loop.h"
> +#include "qapi/error.h"
>  =20
>   typedef struct VDEState {
>       NetClientState nc;
> @@ -76,7 +77,7 @@ static NetClientInfo net_vde_info =3D {
>  =20
>   static int net_vde_init(NetClientState *peer, const char *model,
>                           const char *name, const char *sock,
> -                        int port, const char *group, int mode)
> +                        int port, const char *group, int mode, Error *=
*errp)
>   {
>       NetClientState *nc;
>       VDEState *s;
> @@ -92,6 +93,7 @@ static int net_vde_init(NetClientState *peer, const c=
har *model,
>  =20
>       vde =3D vde_open(init_sock, (char *)"QEMU", &args);
>       if (!vde){
> +        error_setg_errno(errp, errno, "Could not open vde");
>           return -1;
>       }
>  =20
> @@ -112,7 +114,6 @@ static int net_vde_init(NetClientState *peer, const=
 char *model,
>   int net_init_vde(const Netdev *netdev, const char *name,
>                    NetClientState *peer, Error **errp)
>   {
> -    /* FIXME error_setg(errp, ...) on failure */
>       const NetdevVdeOptions *vde;
>  =20
>       assert(netdev->type =3D=3D NET_CLIENT_DRIVER_VDE);
> @@ -120,7 +121,7 @@ int net_init_vde(const Netdev *netdev, const char *=
name,
>  =20
>       /* missing optional values have been initialized to "all bits zer=
o" */
>       if (net_vde_init(peer, "vde", name, vde->sock, vde->port, vde->gr=
oup,
> -                     vde->has_mode ? vde->mode : 0700) =3D=3D -1) {
> +                     vde->has_mode ? vde->mode : 0700, errp) =3D=3D -1=
) {
>           return -1;
>       }
>  =20

Applied.

Thanks
