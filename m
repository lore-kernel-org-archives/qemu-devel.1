Received: from eggs.gnu.org ([2001:4830:134:3::10]:58939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxCNh-0003gn-HU
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxCNg-000343-IP
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:28:05 -0400
References: <20170927125340.12360-1-berrange@redhat.com>
	<20170927125340.12360-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a4fbc91e-8d9e-bb6c-758f-672b0a943bcd@redhat.com>
Date: Wed, 27 Sep 2017 08:27:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170927125340.12360-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EHjpgKl9grtNcdNgTTGlOd3iKG1oQjQLt"
Subject: Re: [Qemu-devel] [PATCH v4 1/6] block: use 1 MB bounce buffers for
 crypto instead of 16KB
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
--EHjpgKl9grtNcdNgTTGlOd3iKG1oQjQLt
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <a4fbc91e-8d9e-bb6c-758f-672b0a943bcd@redhat.com>
Subject: Re: [PATCH v4 1/6] block: use 1 MB bounce buffers for crypto instead
 of 16KB
References: <20170927125340.12360-1-berrange@redhat.com>
 <20170927125340.12360-2-berrange@redhat.com>
In-Reply-To: <20170927125340.12360-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/27/2017 07:53 AM, Daniel P. Berrange wrote:
> Using 16KB bounce buffers creates a significant performance
> penalty for I/O to encrypted volumes on storage which high
> I/O latency (rotating rust & network drives), because it
> triggers lots of fairly small I/O operations.
>=20
> On tests with rotating rust, and cache=3Dnone|directsync,
> write speed increased from 2MiB/s to 32MiB/s, on a par
> with that achieved by the in-kernel luks driver. With
> other cache modes the in-kernel driver is still notably
> faster because it is able to report completion of the
> I/O request before any encryption is done, while the
> in-QEMU driver must encrypt the data before completion.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>


> @@ -464,12 +467,11 @@ block_crypto_co_writev(BlockDriverState *bs, int6=
4_t sector_num,
> =20
>      qemu_iovec_init(&hd_qiov, qiov->niov);
> =20
> -    /* Bounce buffer so we have a linear mem region for
> -     * entire sector. XXX optimize so we avoid bounce
> -     * buffer in case that qiov->niov =3D=3D 1
> +    /* Bounce buffer because we're not permitted to touch
> +     * contents of qiov - it points to guest memory.
>       */
>      cipher_data =3D
> -        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS=
 * 512,
> +        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_IO_SIZE=
,
>                                                qiov->size));

We allocate and free a bounce buffer for every write - is there anything
we can do to reduce malloc() calls by reusing a bounce buffer associated
with a coroutine (we have to be careful that parallel coroutines don't
share bounce buffers, of course).  But that's independent of this patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EHjpgKl9grtNcdNgTTGlOd3iKG1oQjQLt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnLp10ACgkQp6FrSiUn
Q2pgfggAjg7rk8zY0EpjItTw1JL7nf2b6Kalautx+cw8R49gPdQY58eNRteOZJG3
k4gfHyrFFbxUFhAtDxVTF0qAEG6rzq/zEcFeNAE5uIURzPlXZNHmB+hJ3/9uoFmm
zGCNN5D5UgHiU4DFj3ksvORk5RCRUOjKVqj3gC4EbM6/AawDL6Eqj+qWzxc5knbm
GuxmsYAvJxXBnt4S+mZW7BKKENMZ6IK1Rte97dT/fKYf0aetIy5pDU43CYODbkCW
6rQWq5WkltwM18AXBvU23CW90e0VcAw426lLYhH/ra8w1ed1NkiOcMBFAXqpEVrl
u2jhDXfU4Z1sU7Diej/9mChzcECfPQ==
=gj5S
-----END PGP SIGNATURE-----

--EHjpgKl9grtNcdNgTTGlOd3iKG1oQjQLt--
