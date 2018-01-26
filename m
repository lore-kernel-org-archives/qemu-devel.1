Received: from eggs.gnu.org ([2001:4830:134:3::10]:50474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ef47e-0005bU-0v
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ef47a-0002QD-3w
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:32:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ef47W-0002Ng-QC
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:32:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B47328217
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 11:05:52 +0000 (UTC)
References: <20180125171412.21627-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7390cf07-21fb-ec08-5d39-cba66ac91dc9@redhat.com>
Date: Fri, 26 Jan 2018 12:05:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180125171412.21627-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] sockets: fix parsing of ipv4/ipv6 opts
 in parse_socket_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 25/01/2018 18:14, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> The inet_parse() function looks for 'ipv4' and 'ipv6' flags, but only
> treats them as bare bool flags. The normal QemuOpts parsing would allow
> on/off values to be set too.
>=20
> This updates inet_parse() so that its handling of the 'ipv4' and 'ipv6'
> flags matches that done by QemuOpts.
>=20
> This impacts the NBD block driver parsing the legacy filename syntax an=
d
> the migration code parsing the socket scheme.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 44 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
>=20
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index d6a1e1759e..300ebce795 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -554,6 +554,33 @@ err:
>  }
> =20
>  /* compatibility wrapper */
> +static int inet_parse_flag(const char *flagname, const char *optstr, b=
ool *val,
> +                           Error **errp)
> +{
> +    char *end;
> +    size_t len;
> +
> +    end =3D strstr(optstr, ",");
> +    if (end) {
> +        if (end[1] =3D=3D ',') { /* Reject 'ipv6=3Don,,foo' */
> +            error_setg(errp, "error parsing '%s' flag '%s'", flagname,=
 optstr);
> +            return -1;
> +        }
> +        len =3D end - optstr;
> +    } else {
> +        len =3D strlen(optstr);
> +    }
> +    if (len =3D=3D 0 || (len =3D=3D 3 && strncmp(optstr, "=3Don", len)=
 =3D=3D 0)) {
> +        *val =3D true;
> +    } else if ((len =3D=3D 4) && strncmp(optstr, "=3Doff", len) =3D=3D=
 0) {
> +        *val =3D false;
> +    } else {
> +        error_setg(errp, "error parsing '%s' flag '%s'", flagname, opt=
str);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
>  int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
>  {
>      const char *optstr, *h;
> @@ -561,6 +588,7 @@ int inet_parse(InetSocketAddress *addr, const char =
*str, Error **errp)
>      char port[33];
>      int to;
>      int pos;
> +    char *begin;
> =20
>      memset(addr, 0, sizeof(*addr));
> =20
> @@ -602,11 +630,19 @@ int inet_parse(InetSocketAddress *addr, const cha=
r *str, Error **errp)
>          addr->has_to =3D true;
>          addr->to =3D to;
>      }
> -    if (strstr(optstr, ",ipv4")) {
> -        addr->ipv4 =3D addr->has_ipv4 =3D true;
> +    begin =3D strstr(optstr, ",ipv4");
> +    if (begin) {
> +        if (inet_parse_flag("ipv4", begin + 5, &addr->ipv4, errp) < 0)=
 {
> +            return -1;
> +        }
> +        addr->has_ipv4 =3D true;
>      }
> -    if (strstr(optstr, ",ipv6")) {
> -        addr->ipv6 =3D addr->has_ipv6 =3D true;
> +    begin =3D strstr(optstr, ",ipv6");
> +    if (begin) {
> +        if (inet_parse_flag("ipv6", begin + 5, &addr->ipv6, errp) < 0)=
 {
> +            return -1;
> +        }
> +        addr->has_ipv6 =3D true;
>      }
>      return 0;
>  }
>=20

Applied with Eric's suggested change.

Paolo
