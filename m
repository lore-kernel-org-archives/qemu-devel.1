Received: from eggs.gnu.org ([2001:4830:134:3::10]:51763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHtaX-0001ka-Pe
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHtaT-000193-1T
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:06:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dHtaS-00018h-NW
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:06:32 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-19-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <426afe4b-30b9-8d85-67d5-20af3bae775d@redhat.com>
Date: Mon, 5 Jun 2017 10:06:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-19-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iFHmwxU2EVD2X0sJQ3cjDUc6UN2Ql3cv0"
Subject: Re: [Qemu-devel] [PATCH 18/19] nbd/client: refactor TRACE of
 NBD_MAGIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iFHmwxU2EVD2X0sJQ3cjDUc6UN2Ql3cv0
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <426afe4b-30b9-8d85-67d5-20af3bae775d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/19] nbd/client: refactor TRACE of
 NBD_MAGIC
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-19-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-19-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>=20
> diff --git a/nbd/client.c b/nbd/client.c
> index 3d15596120..52f7981c9c 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -426,6 +426,21 @@ static QIOChannel *nbd_receive_starttls(QIOChannel=
 *ioc,
>      return QIO_CHANNEL(tioc);
>  }
> =20
> +static const char *nbd_magic_to_string(char *out, const char *in,
> +                                       size_t count)
> +{
> +    size_t i;
> +
> +    for (i =3D 0; i < count; ++i) {
> +        if (in[i] =3D=3D '\0') {
> +            out[i] =3D '\0';
> +            break;
> +        }
> +        out[i] =3D qemu_isprint(in[i]) ? in[i] : '.';
> +    }
> +
> +    return out;
> +}

Do we really need this?

> -    TRACE("Magic is %c%c%c%c%c%c%c%c",
> -          qemu_isprint(buf[0]) ? buf[0] : '.',
> -          qemu_isprint(buf[1]) ? buf[1] : '.',
> -          qemu_isprint(buf[2]) ? buf[2] : '.',
> -          qemu_isprint(buf[3]) ? buf[3] : '.',
> -          qemu_isprint(buf[4]) ? buf[4] : '.',
> -          qemu_isprint(buf[5]) ? buf[5] : '.',
> -          qemu_isprint(buf[6]) ? buf[6] : '.',
> -          qemu_isprint(buf[7]) ? buf[7] : '.');
> +    TRACE("Magic is %s", nbd_magic_to_string(print_buf, buf, 9));

Would it be any simpler to just print the received magic as a 64-bit
number in hex, instead of trying to string-ize it?  Either the client
sends the right magic (the usual case), so we don't need to waste time
string-izing it, or the client is bogus and sent us garbage (where
printing a hex value is just as efficient as string-izing things to see
what the garbage actually was).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iFHmwxU2EVD2X0sJQ3cjDUc6UN2Ql3cv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNXN2AAoJEKeha0olJ0NqNLoIAJuhAoFrctzJ1g0w9RnEpCcs
/VevW3xS5+N5DAfQ9kq2XcGLqyenr/ghL37Sge/8CBa5n6gbOHBi/1YD3v9k8XvX
QFXL2RpOOosp6c413nsZjGHSZawSBVnV69ea2ujKQGETScJeMy4I+9ueQl/n/l2Q
e+H81sO33mjf77+1ckKqO9M8Vnrx5p9EEly3mS6apLJ1IUQLXW+BlIU+afXhKyQ3
Mq9sKUZyik0pnjcQpRGOCfAtZHEW6+FajCakTGO3G+aFZg3K0mMA97xOjl6QTweJ
Pbok0NbjoRfAtEwuYi89ZnKaIWJD6uaVTVTft3AHILo5FzHPNp6EltzhGIydtwo=
=1Gpv
-----END PGP SIGNATURE-----

--iFHmwxU2EVD2X0sJQ3cjDUc6UN2Ql3cv0--
