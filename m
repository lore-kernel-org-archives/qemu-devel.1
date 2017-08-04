Received: from eggs.gnu.org ([2001:4830:134:3::10]:35350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dddOH-0001Ba-Ij
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddbQh-0007Hp-7B
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:11:19 -0400
References: <20170804105136.12061-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5ffc4c4c-35be-4d99-94f0-d0f3a3d43521@redhat.com>
Date: Fri, 4 Aug 2017 07:08:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170804105136.12061-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tfXUujdVEgtFvJCdiwA9MAKt8Ae3fCaOV"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for 2.10] block: use 1 MB
 bounce buffers for crypto instead of 16KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tfXUujdVEgtFvJCdiwA9MAKt8Ae3fCaOV
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <famz@redhat.com>
Message-ID: <5ffc4c4c-35be-4d99-94f0-d0f3a3d43521@redhat.com>
Subject: Re: [Qemu-block] [PATCH for 2.10] block: use 1 MB bounce buffers for
 crypto instead of 16KB
References: <20170804105136.12061-1-berrange@redhat.com>
In-Reply-To: <20170804105136.12061-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 05:51 AM, Daniel P. Berrange wrote:
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
> @@ -379,7 +379,7 @@ static void block_crypto_close(BlockDriverState *bs=
)
>  }
> =20
> =20
> -#define BLOCK_CRYPTO_MAX_SECTORS 32
> +#define BLOCK_CRYPTO_MAX_SECTORS 2048
> =20
>  static coroutine_fn int
>  block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
> @@ -396,9 +396,8 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t=
 sector_num,
> =20
>      qemu_iovec_init(&hd_qiov, qiov->niov);
> =20
> -    /* Bounce buffer so we have a linear mem region for
> -     * entire sector. XXX optimize so we avoid bounce
> -     * buffer in case that qiov->niov =3D=3D 1
> +    /* Bounce buffer because we're not permitted to touch
> +     * contents of qiov - it points to guest memory.

The comment updates are accurate (and in line with your other patch for
improving documentation of the callback semantics), but slightly
unrelated to the fix at hand. However, I have no problem keeping it in
the patch.

(To make sure I understand the importance of the bounce buffer: On
reads, we can't store into the buffer until we have decrypted, so that
the guest can't transiently spy on the encrypted form; on writes, we
must read from the buffer at most once before encrypting, so that the
guest can't change the buffer under our feet while we are encrypting.)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tfXUujdVEgtFvJCdiwA9MAKt8Ae3fCaOV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmEY9YACgkQp6FrSiUn
Q2qkjQf+NkGZ/aUZVHUzE82zo6dvb0s4EtZVPf//XExm3AixEIS3D6AGkWb3yUkp
adBlPt+eBBXjgtJ9Awi+kVJgDLC+N9+SjjlrCvgmoz7NVIw/SafM3REgSKp4baGw
LQhxzpcyA1ksWH5XBrHBs7Fa4bd3jSMpa550lR9Zy9J+6UySR1QP1Ga4wpRETA56
jHU//7Z4y7T79TWeX4inIkTztjUtlsWDPSnrBtyZWR44bXbkICmjf2H9EHS1DhYv
+4S+6uzNZEIReBbICATsAbqSznU17FhKRw32tT6JAKxHzp3YFmJvH/w2gIooS9pn
5w6+u1wOW476pHExWAAwt2RBJMflUw==
=AJot
-----END PGP SIGNATURE-----

--tfXUujdVEgtFvJCdiwA9MAKt8Ae3fCaOV--
