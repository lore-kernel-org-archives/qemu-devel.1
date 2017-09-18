Received: from eggs.gnu.org ([2001:4830:134:3::10]:37551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwYq-0000UM-Av
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwYp-0000SW-D8
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:58:08 -0400
References: <20170912112855.24269-1-berrange@redhat.com>
	<20170912112855.24269-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d5d5032b-ac8d-899a-b61e-0cd92a674d07@redhat.com>
Date: Mon, 18 Sep 2017 08:57:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170912112855.24269-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f8JBC7WXu5penNlGFCjbuGOXcdkVVdnXS"
Subject: Re: [Qemu-devel] [PATCH v3 4/7] block: don't use constant 512 as
 sector size in crypto driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f8JBC7WXu5penNlGFCjbuGOXcdkVVdnXS
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <d5d5032b-ac8d-899a-b61e-0cd92a674d07@redhat.com>
Subject: Re: [PATCH v3 4/7] block: don't use constant 512 as sector size in
 crypto driver
References: <20170912112855.24269-1-berrange@redhat.com>
 <20170912112855.24269-5-berrange@redhat.com>
In-Reply-To: <20170912112855.24269-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 06:28 AM, Daniel P. Berrange wrote:
> Use the qcrypto_block_get_sector_size() value in the block
> crypto driver instead of hardcoding 512 as the sector size.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index d68cbac2ac..49d6d4c058 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -392,8 +392,9 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t=
 sector_num,
>      uint8_t *cipher_data =3D NULL;
>      QEMUIOVector hd_qiov;
>      int ret =3D 0;
> +    uint64_t sector_size =3D qcrypto_block_get_sector_size(crypto->blo=
ck);
>      uint64_t payload_offset =3D
> -        qcrypto_block_get_payload_offset(crypto->block) / 512;
> +        qcrypto_block_get_payload_offset(crypto->block) / sector_size;=

>      assert(payload_offset < (INT64_MAX / 512));

In addition to Max's comments, should the assert be dividing by
sector_size instead of 512?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--f8JBC7WXu5penNlGFCjbuGOXcdkVVdnXS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/0OYACgkQp6FrSiUn
Q2pnhwgAjgroTVJ2E2hDOb8ajwLNTpODR/HhLi5PnVTAPfk8L1OP0mZKRqkU2pZO
Jf8G4SUTw4dlaqhsaFNtU0d/g860nsKpuyD8NcUsmZa6yMLcd+MUTzhTZdbqR/BB
lo81ViAjwlylVAY+QFoMiBvX3d72ZbgLE1TuJDUEsffBvQhxUZGyv72146blPN62
IPb12iZyczb0z3ATTcNoAKUi5aoOnJWBpOmztz+JA//6dJDWaJ8napS9W3osM7fl
QJTHiNVNC5fSW/S3qj7aXdsK+zX0qhFWitwihFSneVwUTgJKDt3pg4wWbfL7eUU6
xW1JNU96Wt5OsfbtoTNo/ws6NrWWQw==
=K0Dm
-----END PGP SIGNATURE-----

--f8JBC7WXu5penNlGFCjbuGOXcdkVVdnXS--
