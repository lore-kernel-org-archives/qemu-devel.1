Received: from eggs.gnu.org ([2001:4830:134:3::10]:57936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9XSG-0006Vl-Kc
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9XSC-0003Pw-C7
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:28:20 -0400
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
	<20180817122219.16206-2-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d9a218c8-3115-8b67-0840-37ddce399136@redhat.com>
Date: Mon, 8 Oct 2018 17:28:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180817122219.16206-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f0n2vtJEhuMGOtGJ10gJFcW9ufXWUJWVr"
Subject: Re: [Qemu-devel] [PATCH v2 1/7] block/qcow2-refcount: fix
 check_oflag_copied
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f0n2vtJEhuMGOtGJ10gJFcW9ufXWUJWVr
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org
Message-ID: <d9a218c8-3115-8b67-0840-37ddce399136@redhat.com>
Subject: Re: [PATCH v2 1/7] block/qcow2-refcount: fix check_oflag_copied
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
 <20180817122219.16206-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180817122219.16206-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.08.18 14:22, Vladimir Sementsov-Ogievskiy wrote:
> Increase corruptions_fixed only after successful fix.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-refcount.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 3c539f02e5..615847eb09 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1816,7 +1816,7 @@ static int check_oflag_copied(BlockDriverState *b=
s, BdrvCheckResult *res,
>      for (i =3D 0; i < s->l1_size; i++) {
>          uint64_t l1_entry =3D s->l1_table[i];
>          uint64_t l2_offset =3D l1_entry & L1E_OFFSET_MASK;
> -        bool l2_dirty =3D false;
> +        int l2_fixed_entries =3D 0;

I understand that this new variable kind of supersedes the other one,
but I think for the sake of readability it would be better to keep l2_dir=
ty.

Max

>          if (!l2_offset) {
>              continue;
> @@ -1878,8 +1878,7 @@ static int check_oflag_copied(BlockDriverState *b=
s, BdrvCheckResult *res,
>                          l2_table[j] =3D cpu_to_be64(refcount =3D=3D 1
>                                      ? l2_entry |  QCOW_OFLAG_COPIED
>                                      : l2_entry & ~QCOW_OFLAG_COPIED);
> -                        l2_dirty =3D true;
> -                        res->corruptions_fixed++;
> +                        l2_fixed_entries++;
>                      } else {
>                          res->corruptions++;
>                      }
> @@ -1887,7 +1886,7 @@ static int check_oflag_copied(BlockDriverState *b=
s, BdrvCheckResult *res,
>              }
>          }
> =20
> -        if (l2_dirty) {
> +        if (l2_fixed_entries > 0) {
>              ret =3D qcow2_pre_write_overlap_check(bs, QCOW2_OL_ACTIVE_=
L2,
>                                                  l2_offset, s->cluster_=
size);
>              if (ret < 0) {
> @@ -1905,6 +1904,7 @@ static int check_oflag_copied(BlockDriverState *b=
s, BdrvCheckResult *res,
>                  res->check_errors++;
>                  goto fail;
>              }
> +            res->corruptions_fixed +=3D l2_fixed_entries;
>          }
>      }
> =20
>=20



--f0n2vtJEhuMGOtGJ10gJFcW9ufXWUJWVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu7d4IACgkQ9AfbAGHV
z0D6VAf+PL5p+RP13PIdfCwhnhwvtbyfTMwqLO1oYPOv0tnc/+QSBk7mrOl6v/ml
eVigJjQxh3bIse4xs5nxPmo11tJMBuP6Ubo4yqn8kKyMo1y2koZ/p5ObrLtAW1gB
4NGhuxmpebof7pcfTegIV8iSa9trNBXAi8uLG4pBwuO6ywKr2fdShjaGPEWxhioq
IoxTxczZyMaYJ1zzjHOamuNcNLB1SRJgFBjshsAd2jGybb8rmmgoeSGXkycHpHAR
coJ0iz78vJMJUUCMNlR3M0oeluzE56eO7iiTsAa6V1wFgX2F0emGMBVHBxMWm1oL
4Upx2Ouzdp+cFiLoMvms3kNhGru46A==
=iuwI
-----END PGP SIGNATURE-----

--f0n2vtJEhuMGOtGJ10gJFcW9ufXWUJWVr--
