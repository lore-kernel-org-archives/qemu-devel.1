Received: from eggs.gnu.org ([2001:4830:134:3::10]:39959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddcYP-0005Ow-Sr
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddc3G-00084J-Up
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:51:08 -0400
Date: Fri, 4 Aug 2017 13:48:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170804124801.GB14565@stefanha-x1.localdomain>
References: <20170804105136.12061-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <20170804105136.12061-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10] block: use 1 MB bounce buffers
 for crypto instead of 16KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 11:51:36AM +0100, Daniel P. Berrange wrote:
> Using 16KB bounce buffers creates a significant performance
> penalty for I/O to encrypted volumes on storage with high
> I/O latency (rotating rust & network drives), because it
> triggers lots of fairly small I/O operations.
>=20
> On tests with rotating rust, and cache=3Dnone|directsync,
> write speed increased from 2MiB/s to 32MiB/s, on a par
> with that achieved by the in-kernel luks driver.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index 58ef6f2f52..207941db9a 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -379,7 +379,7 @@ static void block_crypto_close(BlockDriverState *bs)
>  }
> =20
> =20
> -#define BLOCK_CRYPTO_MAX_SECTORS 32
> +#define BLOCK_CRYPTO_MAX_SECTORS 2048
> =20
>  static coroutine_fn int
>  block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
> @@ -396,9 +396,8 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t s=
ector_num,
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
>          qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS *=
 512,

In the *read* case you can modify the data buffers in-place.  But the
guest might see intermediate states in its buffers - not sure whether
this could pose a security problem.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZhG0BAAoJEJykq7OBq3PIZSwH/0cIi5J+sFL2PjKmok6fj9td
uNEGsOFM3NL2CWLaVDH3HfqJGFlP/tIgvkZvPgQf9Y7b57Hro1S8F2Fj/UDml6Aj
noHEx6GBnBWE6F+CU9eJV6Im8qr/i+oYrRekI1KcJZkEaMA08T+jAMgLYYNbqTOZ
WpOs7vpt8MtbPkNV2QUnGwTv65NM8EHbxxAbcaS8J8uWpnZOMNYM7vQ4qRAn7fzn
kdJOIKuJw35wv/fvi6r89i1iic5bH+DsvSZD3Cm6L71VBqZxUnOV/x+7Sr16rghe
v948RjWedMk5JiCS6zgUs9wpMloT6Lqo2RK4xU4RdrVJGZK2ZwCpGUD+6XrDVYw=
=8XOP
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
