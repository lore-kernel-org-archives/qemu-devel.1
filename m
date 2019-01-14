Received: from eggs.gnu.org ([209.51.188.92]:35340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj20n-0006fF-VN
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:10:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj20m-0007s1-MR
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:10:41 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-2-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
Date: Mon, 14 Jan 2019 14:10:22 +0100
MIME-Version: 1.0
In-Reply-To: <20181229122027.42245-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZeQXycoWFSQx31FzCmFWpWBXBt1PW4cZ7"
Subject: Re: [Qemu-devel] [PATCH v5 01/11] block/backup: simplify
 backup_incremental_init_copy_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com, den@openvz.org, eblake@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZeQXycoWFSQx31FzCmFWpWBXBt1PW4cZ7
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com, jsnow@redhat.com
Message-ID: <cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
Subject: Re: [PATCH v5 01/11] block/backup: simplify
 backup_incremental_init_copy_bitmap
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181229122027.42245-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
> Simplify backup_incremental_init_copy_bitmap using the function
> bdrv_dirty_bitmap_next_dirty_area.
>=20
> Note: move to job->len instead of bitmap size: it should not matter but=

> less code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 40 ++++++++++++----------------------------
>  1 file changed, 12 insertions(+), 28 deletions(-)

Overall: What is this function even supposed to do?  To me, it looks
like it marks all areas in job->copy_bitmap dirty that are dirty in
job->sync_bitmap.

If so, wouldn't just replacing this by hbitmap_merge() simplify things
further?

> diff --git a/block/backup.c b/block/backup.c
> index 435414e964..fbe7ce19e1 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -406,43 +406,27 @@ static int coroutine_fn backup_run_incremental(Ba=
ckupBlockJob *job)

[...]

> +    while (bdrv_dirty_bitmap_next_dirty_area(job->sync_bitmap,
> +                                             &offset, &bytes))
> +    {
> +        uint64_t cluster =3D offset / job->cluster_size;
> +        uint64_t last_cluster =3D (offset + bytes) / job->cluster_size=
;
> =20
> -        next_cluster =3D DIV_ROUND_UP(offset, job->cluster_size);
> -        hbitmap_set(job->copy_bitmap, cluster, next_cluster - cluster)=
;
> -        if (next_cluster >=3D end) {
> +        hbitmap_set(job->copy_bitmap, cluster, last_cluster - cluster =
+ 1);

Why the +1?  Shouldn't the division for last_cluster round up instead?

> +
> +        offset =3D (last_cluster + 1) * job->cluster_size;

Same here.

Max


--ZeQXycoWFSQx31FzCmFWpWBXBt1PW4cZ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw8ij8ACgkQ9AfbAGHV
z0ATbgf+P63VPPxmL6Y+F0AJmfTnX3lQujhDW1O3FqpZfN3UA3myARchoZxCokQI
U2ZpaYI68pYDaX/5JQ2GG7ibKwk8PYB5bVrHw0BDlOYx7XhZXP1alfOf9BkgWBNF
GeJGbFdsmwwpEpQs3lHNjY1IHSU4odLt5e4N5KmdLaqaK5izDiLqXq1Tg/HjIDOx
Ft6Ed+Ps3B7wDuxuGwZFmQob6Cyb0xrEJlWCrNrc/g2n6t1AvPsy67+Xp+penER3
5env6JJArXnY1whWT/tZFlRLWxw1COO2CftyGTRjIjVEYUl6eyw3xw0G7s/P0GJE
PXkSVWSq7Za65xEN6VMJ0DGwPZgbEA==
=3E6Y
-----END PGP SIGNATURE-----

--ZeQXycoWFSQx31FzCmFWpWBXBt1PW4cZ7--
