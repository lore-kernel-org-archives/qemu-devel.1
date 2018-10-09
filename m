Received: from eggs.gnu.org ([2001:4830:134:3::10]:48892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9oO7-0008Js-BV
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9oO6-0004fe-Dn
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:33:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:54632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9oO6-0004fO-74
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:33:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id r63-v6so1117343wma.4
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 02:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-13-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-13-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 13:32:57 +0400
Message-ID: <CAJ+F1C+henpMSEboS5iKpqDemS-oEFwFHXxXuMhgs6vz7Jdijw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/31] l2tpv3: Improve
 -netdev/netdev_add/-net/... error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>

Hi
On Mon, Oct 8, 2018 at 9:54 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> When -netdev l2tpv3 fails, it first reports a specific error, then a
> generic one, like this:
>
>     $ qemu-system-x86_64 -netdev l2tpv3,id=3Dfoo,src=3D,dst=3D,txsession=
=3D1
>     qemu-system-x86_64: -netdev l2tpv3,id=3Dfoo,src=3D,dst=3D,txsession=
=3D1: l2tpv3_open : could not resolve src, errno =3D Name or service not kn=
own
>     qemu-system-x86_64: Device 'l2tpv3' could not be initialized
>
> With the command line, the messages go to stderr.  In HMP, they go to
> the monitor.  In QMP, the second one becomes the error reply, and the
> first one goes to stderr.
>
> Convert net_init_tap() to Error.  This suppresses the unwanted second
> message, and makes the specific error the QMP error reply.
>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  net/l2tpv3.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/net/l2tpv3.c b/net/l2tpv3.c
> index 6745b78990..0c5dd22ef7 100644
> --- a/net/l2tpv3.c
> +++ b/net/l2tpv3.c
> @@ -28,6 +28,7 @@
>  #include <netdb.h>
>  #include "net/net.h"
>  #include "clients.h"
> +#include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "qemu/error-report.h"
>  #include "qemu/option.h"
> @@ -528,7 +529,6 @@ int net_init_l2tpv3(const Netdev *netdev,
>                      const char *name,
>                      NetClientState *peer, Error **errp)
>  {
> -    /* FIXME error_setg(errp, ...) on failure */
>      const NetdevL2TPv3Options *l2tpv3;
>      NetL2TPV3State *s;
>      NetClientState *nc;
> @@ -555,7 +555,7 @@ int net_init_l2tpv3(const Netdev *netdev,
>      }
>
>      if ((l2tpv3->has_offset) && (l2tpv3->offset > 256)) {
> -        error_report("l2tpv3_open : offset must be less than 256 bytes")=
;
> +        error_setg(errp, "l2tpv3_open : offset must be less than 256 byt=
es");
>          goto outerr;
>      }
>
> @@ -563,6 +563,8 @@ int net_init_l2tpv3(const Netdev *netdev,
>          if (l2tpv3->has_rxcookie && l2tpv3->has_txcookie) {
>              s->cookie =3D true;
>          } else {
> +            error_setg(errp,
> +                       "require both 'rxcookie' and 'txcookie' or neithe=
r");

maybe for consistency it would be a good idea to remove the
"l2tpv3_open : " prefix from the other messages while touching it?

looks good otherwise:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>              goto outerr;
>          }
>      } else {
> @@ -578,7 +580,8 @@ int net_init_l2tpv3(const Netdev *netdev,
>      if (l2tpv3->has_udp && l2tpv3->udp) {
>          s->udp =3D true;
>          if (!(l2tpv3->has_srcport && l2tpv3->has_dstport)) {
> -            error_report("l2tpv3_open : need both src and dst port for u=
dp");
> +            error_setg(errp,
> +                       "l2tpv3_open : need both src and dst port for udp=
");
>              goto outerr;
>          } else {
>              srcport =3D l2tpv3->srcport;
> @@ -639,20 +642,19 @@ int net_init_l2tpv3(const Netdev *netdev,
>      gairet =3D getaddrinfo(l2tpv3->src, srcport, &hints, &result);
>
>      if ((gairet !=3D 0) || (result =3D=3D NULL)) {
> -        error_report(
> -            "l2tpv3_open : could not resolve src, errno =3D %s",
> -            gai_strerror(gairet)
> -        );
> +        error_setg(errp, "l2tpv3_open : could not resolve src, errno =3D=
 %s",
> +                   gai_strerror(gairet));
>          goto outerr;
>      }
>      fd =3D socket(result->ai_family, result->ai_socktype, result->ai_pro=
tocol);
>      if (fd =3D=3D -1) {
>          fd =3D -errno;
> -        error_report("l2tpv3_open : socket creation failed, errno =3D %d=
", -fd);
> +        error_setg(errp, "l2tpv3_open : socket creation failed, errno =
=3D %d",
> +                   -fd);
>          goto outerr;
>      }
>      if (bind(fd, (struct sockaddr *) result->ai_addr, result->ai_addrlen=
)) {
> -        error_report("l2tpv3_open :  could not bind socket err=3D%i", er=
rno);
> +        error_setg(errp, "l2tpv3_open :  could not bind socket err=3D%i"=
, errno);
>          goto outerr;
>      }
>      if (result) {
> @@ -677,10 +679,8 @@ int net_init_l2tpv3(const Netdev *netdev,
>      result =3D NULL;
>      gairet =3D getaddrinfo(l2tpv3->dst, dstport, &hints, &result);
>      if ((gairet !=3D 0) || (result =3D=3D NULL)) {
> -        error_report(
> -            "l2tpv3_open : could not resolve dst, error =3D %s",
> -            gai_strerror(gairet)
> -        );
> +        error_setg(errp, "l2tpv3_open : could not resolve dst, error =3D=
 %s",
> +                   gai_strerror(gairet));
>          goto outerr;
>      }
>
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
