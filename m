Received: from eggs.gnu.org ([2001:4830:134:3::10]:47500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciSir-0000LK-7s
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 16:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciSio-0006nk-2Z
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 16:20:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciSin-0006nZ-Pr
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 16:20:41 -0500
References: <20170227201456.31814-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <739c3a03-fffe-46d0-0ba6-a328a9a18eb2@redhat.com>
Date: Mon, 27 Feb 2017 15:20:37 -0600
MIME-Version: 1.0
In-Reply-To: <20170227201456.31814-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vG58eojSLPw6eddk8MDmIpqDKRC4knr9f"
Subject: Re: [Qemu-devel] [PATCH] io: ignore case when matching websockets
 HTTP headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vG58eojSLPw6eddk8MDmIpqDKRC4knr9f
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <739c3a03-fffe-46d0-0ba6-a328a9a18eb2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io: ignore case when matching websockets
 HTTP headers
References: <20170227201456.31814-1-berrange@redhat.com>
In-Reply-To: <20170227201456.31814-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 02:14 PM, Daniel P. Berrange wrote:
> According to RFC7230 Section 3.2, header field name is case-insensitive=
=2E
> Convert the header data into all lowercase before doing string matching=

> on the headers.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20

> @@ -223,7 +223,7 @@ static int qio_channel_websock_handshake_process(QI=
OChannelWebsock *ioc,
>  static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
>                                                Error **errp)
>  {
> -    char *handshake_end;
> +    char *handshake_end, *tmp;
>      ssize_t ret;
>      /* Typical HTTP headers from novnc are 512 bytes, so limiting
>       * total header size to 4096 is easily enough. */

Drive-by grammar nit: s/easily/easy/

> @@ -249,9 +249,13 @@ static int qio_channel_websock_handshake_read(QIOC=
hannelWebsock *ioc,
>          }
>      }
> =20
> +    for (tmp =3D (char *)ioc->encinput.buffer; tmp < handshake_end; tm=
p++) {
> +        *tmp =3D g_ascii_tolower(*tmp);
> +    }
> +
>      if (qio_channel_websock_handshake_process(ioc,
>                                                (char *)ioc->encinput.bu=
ffer,
> -                                              ioc->encinput.offset,
> +                                              handshake_end - (char *)=
ioc->encinput.buffer,

I'm not sure why this change is here; nothing else in the patch changed
ioc->encinput.offset.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vG58eojSLPw6eddk8MDmIpqDKRC4knr9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtJglAAoJEKeha0olJ0Nqd0oH/Rx+9spfWyr2KvfF49F+LALk
hCjI4mxMnT9weg5txjkwQVJ33kx9RNhU9e+O6nqHIbcag1nmqTvq1vKQ0D3P4LDl
SzHdy4p4WlxfTcFopEPB8sn/rEwCW5Bt4hr3n2qrxcIMkkiXsXnUyyoabidtYzUV
6tsBdWmlRQHxvsYSdv73zzhtfvphgiOtuYUfWcMMgVRGFIHqFpVQ+B/kLbtT2TPi
ah1mudVmrHdlr5dg0jtuE76lj23lHEuxNRNCbAUyQP/AZx+7dMAACazELADdQIYF
NJ646cRK0ABypbIpRWcMAE5U4/QLJgmxx6Sm1g7b/BwTCrkg8PXPhuwV9BAD9r8=
=+R/k
-----END PGP SIGNATURE-----

--vG58eojSLPw6eddk8MDmIpqDKRC4knr9f--
