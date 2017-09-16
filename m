Received: from eggs.gnu.org ([2001:4830:134:3::10]:33282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtGep-0004TE-Na
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 13:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtGeo-0003M9-Pn
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 13:13:31 -0400
References: <20170912112855.24269-1-berrange@redhat.com>
	<20170912112855.24269-7-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a2bfde8b-e06f-9e52-2932-c027efeaf114@redhat.com>
Date: Sat, 16 Sep 2017 19:13:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170912112855.24269-7-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VOCjrngj2WRoPmTqfIUsPSD1sdqHfiqGp"
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block: convert
 qcrypto_block_encrypt|decrypt to take bytes offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VOCjrngj2WRoPmTqfIUsPSD1sdqHfiqGp
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <a2bfde8b-e06f-9e52-2932-c027efeaf114@redhat.com>
Subject: Re: [PATCH v3 6/7] block: convert qcrypto_block_encrypt|decrypt to
 take bytes offset
References: <20170912112855.24269-1-berrange@redhat.com>
 <20170912112855.24269-7-berrange@redhat.com>
In-Reply-To: <20170912112855.24269-7-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-12 13:28, Daniel P. Berrange wrote:
> Instead of sector offset, take the bytes offset when encrypting
> or decrypting data.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c         | 12 ++++--------
>  block/qcow.c           |  7 +++++--
>  block/qcow2-cluster.c  |  8 +++-----
>  block/qcow2.c          |  4 ++--
>  crypto/block-luks.c    | 12 ++++++++----
>  crypto/block-qcow.c    | 12 ++++++++----
>  crypto/block.c         | 20 ++++++++++++++------
>  crypto/blockpriv.h     |  4 ++--
>  include/crypto/block.h | 14 ++++++++------
>  9 files changed, 54 insertions(+), 39 deletions(-)

[...]

> diff --git a/block/qcow.c b/block/qcow.c
> index f450b00cfc..d242301ed2 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -478,7 +478,9 @@ static int get_cluster_offset(BlockDriverState *bs,=

>                      for(i =3D 0; i < s->cluster_sectors; i++) {
>                          if (i < n_start || i >=3D n_end) {
>                              memset(s->cluster_data, 0x00, 512);
> -                            if (qcrypto_block_encrypt(s->crypto, start=
_sect + i,
> +                            if (qcrypto_block_encrypt(s->crypto,
> +                                                      (start_sect + i)=
 *
> +                                                      BDRV_SECTOR_SIZE=
,
>                                                        s->cluster_data,=

>                                                        BDRV_SECTOR_SIZE=
,
>                                                        NULL) < 0) {
> @@ -668,7 +670,8 @@ static coroutine_fn int qcow_co_readv(BlockDriverSt=
ate *bs, int64_t sector_num,
>              }
>              if (bs->encrypted) {
>                  assert(s->crypto);
> -                if (qcrypto_block_decrypt(s->crypto, sector_num, buf,
> +                if (qcrypto_block_decrypt(s->crypto,
> +                                          sector_num * BDRV_SECTOR_SIZ=
E, buf,
>                                            n * BDRV_SECTOR_SIZE, NULL) =
< 0) {
>                      ret =3D -EIO;
>                      break;

There's another instance of qcrypto_block_encrypt() in qcow_co_writev()
that needs to be changed.

Max


--VOCjrngj2WRoPmTqfIUsPSD1sdqHfiqGp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm9W7ASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AEV0IAIq34SWF1LG/SBWuKnXNaldcqpi/RZ5B
ZZslAuio4ePocHxFPGV5aK7rDbBy3YPZm91YWVdfPpu5+L5V1cZUC80OOXNINOQ4
g54xcBAXCARgh+95xNcF6BEt8Xo3YJjK6JSyb7sOM3twJPQ0wXvkpR8tjbLn2bhT
Qmdl/LYVgo3k9hMn08yxxKoajudo90NXjj9m/SjV/6JY8R3XFFHfZlMMXnqXqwfT
lzFnnfSLrwYTRZ3FIdifZZ2xGSZTm+58ZU9WLNGVtKX8lfPDqZYA64Zs0Ln6kjNs
dkDR3bcZ+0JPKV1wMWsaEyb0vf17kAms/cUxdEGgeb2endZTCrl7g0g=
=qUGq
-----END PGP SIGNATURE-----

--VOCjrngj2WRoPmTqfIUsPSD1sdqHfiqGp--
