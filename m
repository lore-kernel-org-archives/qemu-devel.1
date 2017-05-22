Received: from eggs.gnu.org ([2001:4830:134:3::10]:33136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCskx-0006jW-E8
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCskt-0008VM-E0
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:12:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCskt-0008TT-3W
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:12:35 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-3-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7fbddc0e-298b-5973-8f0e-47b753ab41a8@redhat.com>
Date: Mon, 22 May 2017 14:12:24 -0500
MIME-Version: 1.0
In-Reply-To: <1495186480-114192-3-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HFpNsmj3RPOPgXgdhADJXLttloAWMsnpf"
Subject: Re: [Qemu-devel] [PATCH v1 02/13] qcow2: is_zero_sectors(): return
 true if area is outside of backing file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HFpNsmj3RPOPgXgdhADJXLttloAWMsnpf
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, mreitz@redhat.com
Message-ID: <7fbddc0e-298b-5973-8f0e-47b753ab41a8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 02/13] qcow2: is_zero_sectors(): return
 true if area is outside of backing file
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1495186480-114192-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-3-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 04:34 AM, Anton Nefedov wrote:
> in such case, bdrv_get_block_status() shall return 0, *nr =3D=3D 0

Sounds better as s/shall/will/

>=20
> iotest 154 updated accordingly: write-zeroes tail alignment can be dete=
cted
> as zeroes now, so pwrite_zeroes succeeds
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/qcow2.c              | 6 ++++--
>  tests/qemu-iotests/154.out | 4 ++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20

You'll want to also patch test 154 proper to remove these two TODO commen=
ts:

# TODO: Note that this forces an allocation, because we aren't yet able t=
o
# quickly detect that reads beyond EOF of the backing file are always zer=
o


> diff --git a/block/qcow2.c b/block/qcow2.c
> index 2e6a0ec..b885dfc 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2482,7 +2482,7 @@ static bool is_zero_sectors(BlockDriverState *bs,=
 int64_t start,
>      int64_t res;
> =20
>      if (start + count > bs->total_sectors) {
> -        count =3D bs->total_sectors - start;
> +        count =3D start < bs->total_sectors ? bs->total_sectors - star=
t : 0;
>      }
> =20
>      if (!count) {
> @@ -2490,7 +2490,9 @@ static bool is_zero_sectors(BlockDriverState *bs,=
 int64_t start,
>      }
>      res =3D bdrv_get_block_status_above(bs, NULL, start, count,
>                                        &nr, &file);
> -    return res >=3D 0 && (res & BDRV_BLOCK_ZERO) && nr =3D=3D count;
> +    return res >=3D 0
> +        && (((res & BDRV_BLOCK_ZERO) && nr =3D=3D count)
> +            || nr =3D=3D 0);

The logic makes sense to me, although the formatting is unusual (we tend
to split && and || with the operator at the tail of the previous line,
not the head of the new line).

This quick check may make me revisit whether it is worth my my RFC
series about adding BDRV_BLOCK_EOF for more quickly tracking reads
beyond EOF (my solution in that series was able to make the same change
to test 154, but by doing it at the block layer instead of the qcow2.c
code).  https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01127.ht=
ml


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HFpNsmj3RPOPgXgdhADJXLttloAWMsnpf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIzgYAAoJEKeha0olJ0NqGiYIAIcqOMl9Lu5FVbSm4vpRtwkd
GEWwAqLl2dZ6vfg9eHAj8B77nXQfy0dFpPl/kNlkJe6bozcTvW/KZcTLK9maCuzs
ZeehNantQnfA6U5RWqdtcexiJbCS6bKPfIm4Q94AFcRedRAJQld15NPqMxpWNLJ1
2GsZhytcvv3y5HhTu16RqLdbkORRolTto7fXsErTeqHhl7CWH8t17ePtQQLIV5N8
LCFIRnJ4LdsJlZioMhPxj8LzgXUzS838Vq/3+wKZHZrsK+MxVh5087Mu6ZRogUnG
1g3Xw61V13iQvV9JpSdbX8HuEYhtCyOC22mVZep4vUkdCCKRiVTu+oJV7saa28U=
=DHgK
-----END PGP SIGNATURE-----

--HFpNsmj3RPOPgXgdhADJXLttloAWMsnpf--
