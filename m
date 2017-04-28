Received: from eggs.gnu.org ([2001:4830:134:3::10]:46504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4Bqz-0000oa-AN
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4Bqy-0007w4-FS
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:46:57 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-8-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <99e512ad-d73a-09dd-ee68-ee57dc4581af@redhat.com>
Date: Fri, 28 Apr 2017 21:46:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170427014626.11553-8-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xepqQFfp5j1dFFD0tTFI708iRHTnToJLW"
Subject: Re: [Qemu-devel] [PATCH v10 07/17] qemu-io: Switch 'alloc' command
 to byte-based length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xepqQFfp5j1dFFD0tTFI708iRHTnToJLW
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <99e512ad-d73a-09dd-ee68-ee57dc4581af@redhat.com>
Subject: Re: [PATCH v10 07/17] qemu-io: Switch 'alloc' command to byte-based
 length
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-8-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2017 03:46, Eric Blake wrote:
> For the 'alloc' command, accepting an offset in bytes but a length
> in sectors, and reporting output in sectors, is confusing.  Do
> everything in bytes, and adjust the expected output accordingly.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> ---
> v10: rebase to code cleanup
> v9: new patch
> ---
>  qemu-io-cmds.c                    | 30 ++++++++++++++++++------------
>  tests/qemu-iotests/019.out        |  8 ++++----
>  tests/qemu-iotests/common.pattern |  2 +-
>  3 files changed, 23 insertions(+), 17 deletions(-)
>=20
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index fabc394..34f6707 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -1760,7 +1760,7 @@ out:
>  static int alloc_f(BlockBackend *blk, int argc, char **argv)
>  {
>      BlockDriverState *bs =3D blk_bs(blk);
> -    int64_t offset, sector_num, nb_sectors, remaining;
> +    int64_t offset, sector_num, nb_sectors, remaining, bytes;
>      char s1[64];
>      int num, ret;
>      int64_t sum_alloc;
> @@ -1776,18 +1776,24 @@ static int alloc_f(BlockBackend *blk, int argc,=
 char **argv)
>      }
>=20
>      if (argc =3D=3D 3) {
> -        nb_sectors =3D cvtnum(argv[2]);
> -        if (nb_sectors < 0) {
> -            print_cvtnum_err(nb_sectors, argv[2]);
> +        bytes =3D cvtnum(argv[2]);
> +        if (bytes < 0) {
> +            print_cvtnum_err(bytes, argv[2]);
>              return 0;
> -        } else if (nb_sectors > INT_MAX) {
> -            printf("length argument cannot exceed %d, given %s\n",
> -                   INT_MAX, argv[2]);
> +        } else if (bytes > INT_MAX * BDRV_SECTOR_SIZE) {
> +            printf("length argument cannot exceed %llu, given %s\n",
> +                   INT_MAX * BDRV_SECTOR_SIZE, argv[2]);
>              return 0;
>          }
>      } else {
> -        nb_sectors =3D 1;
> +        bytes =3D BDRV_SECTOR_SIZE;
>      }
> +    if (!QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE)) {
> +        printf("bytes %" PRId64 " is not sector aligned\n",

This isn't real English. :-)

With that fixed (somehow, you know better than me how to):

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +               bytes);
> +        return 0;
> +    }
> +    nb_sectors =3D bytes >> BDRV_SECTOR_BITS;
>=20
>      remaining =3D nb_sectors;
>      sum_alloc =3D 0;


--xepqQFfp5j1dFFD0tTFI708iRHTnToJLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkDnCcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AG3oH/i+wPiZaXS05a8Fse/0JTsxneE0YLd+g
Bv2xpdNuQY4JbntqvLB0bcXwG/kC6/gcUY5eJ/hhxG8PBITa15bYbR+D4wobKgRc
gh4W2R/DYAzcV3i1ltLPLuXTXG1foLcjMEUIxGFjkTQSggb8yHitUYoTzhDtKtYp
JRc52ljXp/GfyBcLV5dLxhC+RNWk48xhqkq9Rl5wfneWAVHwFL4CVMW4BHo/Gf1v
VNFMv8aFc2H+eiKsRJNI3sbdMvLJbWC9sPfpRucnrdjefSpvUE+Q2XeV3Tg8WBfx
NE8KoRQkm3yiGtIxtCdYHtYiU70mfNaZyljbj75848X+/s+VCgoFC/4=
=z3SJ
-----END PGP SIGNATURE-----

--xepqQFfp5j1dFFD0tTFI708iRHTnToJLW--
