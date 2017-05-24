Received: from eggs.gnu.org ([2001:4830:134:3::10]:48180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDYcM-0001vC-8l
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDYcH-0008Ij-Sg
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:54:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDYcH-0008Ho-IV
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:54:29 -0400
References: <20170524154205.1914-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4706484e-b8dc-b8a8-d33f-48d82302d59b@redhat.com>
Date: Wed, 24 May 2017 10:54:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170524154205.1914-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EDjqb5vMnMfLfRAckg8abIvQJTSv53W3p"
Subject: Re: [Qemu-devel] [PATCH] sockets: report error if UNIX socket path
 is too long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Simon <qemu.bugs@whitewinterwolf.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EDjqb5vMnMfLfRAckg8abIvQJTSv53W3p
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Simon <qemu.bugs@whitewinterwolf.com>
Message-ID: <4706484e-b8dc-b8a8-d33f-48d82302d59b@redhat.com>
Subject: Re: [PATCH] sockets: report error if UNIX socket path is too long
References: <20170524154205.1914-1-berrange@redhat.com>
In-Reply-To: <20170524154205.1914-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/24/2017 10:42 AM, Daniel P. Berrange wrote:
> The 'struct sockaddr_un' only allows 108 bytes for the socket
> path. Currently QEMU uses snprintf() and so silently truncates
> the socket path provided by the user. This is undesirable because
> the user will then be unable to connect to the path they asked
> for. This change makes QEMU bounds check and report an explicit
> error message.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index d8183f7..e249dbe 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -855,6 +855,12 @@ static int unix_listen_saddr(UnixSocketAddress *sa=
ddr,
>      memset(&un, 0, sizeof(un));
>      un.sun_family =3D AF_UNIX;
>      if (saddr->path && strlen(saddr->path)) {
> +        if (strlen(saddr->path) > sizeof(un.sun_path)) {

Feels odd to be computing strlen(saddr->path) multiple times instead of
storing it in a temporary.

> +            error_setg(errp, "UNIX socket path '%s' is too long", sadd=
r->path);
> +            error_append_hint(errp, "Path must be less than %zu bytes\=
n",
> +                              sizeof(un.sun_path));
> +            return -1;
> +        }
>          snprintf(un.sun_path, sizeof(un.sun_path), "%s", saddr->path);=


Pre-existing, but now that we know things fit, isn't it faster to use
strcpy (or strpcpy or strncpy) instead of the overhead of snprintf?

You're on the right track, but it may be worth a v2 for further cleanups.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EDjqb5vMnMfLfRAckg8abIvQJTSv53W3p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJayyAAoJEKeha0olJ0NqZwMIAKGPkha36RjBiJ5V9O1qKI9h
HyV6b2i7sA4BRFtjsYcViTQZnxFFkCmNoqre96GXkpEVi8XmnFkvDlzNJyfyDBtA
vFnVSgekioe8o++IEwvrXVq9in/UgauBtViPNINcaC32e4ALB+71qvC9yEeCF5pD
MleTmgdxnT3CexqSRxcCi/TNOtgctcm0G/Z+pH0J0A3+K7+OF+yerjq73zPfitXU
zbXqWmm8zJUBG64DibESI6VmG59GhGZYIIXSOz0EMC6CTHbqd8H2TPNP9auPyAgk
kobBTJIpKSKeyk2jhPx2kbBBF9hYFzY8ZumQzU+VvA2X1+NXx3ag3DN1R/hhK/4=
=jyFZ
-----END PGP SIGNATURE-----

--EDjqb5vMnMfLfRAckg8abIvQJTSv53W3p--
