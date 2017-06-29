Received: from eggs.gnu.org ([2001:4830:134:3::10]:56750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQfEv-0001Nz-IY
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQfEr-00039j-Gq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:36:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQfEr-00039E-8B
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:36:29 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <41d055f4-1952-fbd8-7cc2-fe377b3c9d7d@redhat.com>
Date: Thu, 29 Jun 2017 14:36:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170621153424.16690-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mSpCo891uE48iULc25MHDmlHiS8N4otSp"
Subject: Re: [Qemu-devel] [PATCH v2 5/6] nbd/client: refactor TRACE of
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
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mSpCo891uE48iULc25MHDmlHiS8N4otSp
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <41d055f4-1952-fbd8-7cc2-fe377b3c9d7d@redhat.com>
Subject: Re: [PATCH v2 5/6] nbd/client: refactor TRACE of NBD_MAGIC
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
 <20170621153424.16690-6-vsementsov@virtuozzo.com>
In-Reply-To: <20170621153424.16690-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/21/2017 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:
> We are going to switch from TRACE macro to trace points,
> this TRACE complicates things, this patch simplifies it.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>=20
> diff --git a/nbd/client.c b/nbd/client.c
> index b97143fa60..5a4825ebe0 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -426,14 +426,13 @@ static QIOChannel *nbd_receive_starttls(QIOChanne=
l *ioc,
>      return QIO_CHANNEL(tioc);
>  }
> =20
> -
>  int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t =
*flags,

Spurious whitespace change?

>                            QCryptoTLSCreds *tlscreds, const char *hostn=
ame,
>                            QIOChannel **outioc,
>                            off_t *size, Error **errp)
>  {
>      char buf[256];
> -    uint64_t magic, s;
> +    uint64_t nbd_magic, magic, s;

Why do we need two separate variables? Can't you just reuse 'magic'?

>      int rc;
>      bool zeroes =3D true;
> =20
> @@ -461,15 +460,9 @@ int nbd_receive_negotiate(QIOChannel *ioc, const c=
har *name, uint16_t *flags,
>          goto fail;
>      }
> =20
> -    TRACE("Magic is %c%c%c%c%c%c%c%c",
> -          qemu_isprint(buf[0]) ? buf[0] : '.',
> -          qemu_isprint(buf[1]) ? buf[1] : '.',
> -          qemu_isprint(buf[2]) ? buf[2] : '.',
> -          qemu_isprint(buf[3]) ? buf[3] : '.',
> -          qemu_isprint(buf[4]) ? buf[4] : '.',
> -          qemu_isprint(buf[5]) ? buf[5] : '.',
> -          qemu_isprint(buf[6]) ? buf[6] : '.',
> -          qemu_isprint(buf[7]) ? buf[7] : '.');
> +    memcpy(&nbd_magic, buf, 8);
> +    nbd_magic =3D be64_to_cpu(nbd_magic);

Do we really need to copy the memory around twice?  Can't we just use:
 magic =3D ldq_be_p(buf);
and call it good?

> +    TRACE("Magic is 0x%" PRIx64, nbd_magic);
> =20
>      if (memcmp(buf, "NBDMAGIC", 8) !=3D 0) {
>          error_setg(errp, "Invalid magic received");
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mSpCo891uE48iULc25MHDmlHiS8N4otSp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVVa1AAoJEKeha0olJ0NqJ1AH/0vRK8uUlhMN6G5podEv+rzV
xbDKcTiWiZBMLZLhFXlT5mb9C4Dmjxzd7mT8t4G72Mf6ZO2X4ZnpGnkW2X/Fsiyg
0TS2daEZ5OH4FCkYSqhGJQOTjoiXgpNcs7NLWW5nVjwZUg+252c0d5MxI8Vg+U4q
IhfGV33JBHb3+tk4cT8ftKz0TrnZIi6qg5XrluaWug60Tggjg3H0sBacp8XbCcyp
5qRDYgrWCbyHULU7u41YDiyHuxxo1Sn39GWvc/xeIY5JpZnI/131d0QGHKjPMrgD
gFymDIYe5wSusr/kQsV5WM/WpfcvOYqshpfuV0bG5YtiCSxWtLN37dvjx1Xhuiw=
=p69k
-----END PGP SIGNATURE-----

--mSpCo891uE48iULc25MHDmlHiS8N4otSp--
