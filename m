Received: from eggs.gnu.org ([209.51.188.92]:58590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzp9-00063f-Cl
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzp4-0002Lr-BE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:04:38 -0500
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
	<20181214134240.217870-6-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <15e27f9f-8788-66ce-7843-0922662e42b1@redhat.com>
Date: Wed, 27 Feb 2019 13:42:33 +0100
MIME-Version: 1.0
In-Reply-To: <20181214134240.217870-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kbv0elEJACZq3qiI0B4dVZ4QPzpxHYd13"
Subject: Re: [Qemu-devel] [PATCH v4 5/5] qcow2-refcount: don't mask
 corruptions under internal errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kbv0elEJACZq3qiI0B4dVZ4QPzpxHYd13
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org
Message-ID: <15e27f9f-8788-66ce-7843-0922662e42b1@redhat.com>
Subject: Re: [PATCH v4 5/5] qcow2-refcount: don't mask corruptions under
 internal errors
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
 <20181214134240.217870-6-vsementsov@virtuozzo.com>
In-Reply-To: <20181214134240.217870-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.12.18 14:42, Vladimir Sementsov-Ogievskiy wrote:
> No reasons for not reporting found corruptions as corruptions in case
> of some internal errors, especially in case of just failed to fix l2
> entry (and in this case, missed corruptions may influence comparing
> logic, when we calculate difference between corruptions fields of two
> results)
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-refcount.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 8da0e91dd3..b0e006e628 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c

[...]

> @@ -1899,19 +1899,16 @@ static int check_oflag_copied(BlockDriverState =
*bs, BdrvCheckResult *res,
>                      fprintf(stderr, "%s OFLAG_COPIED data cluster: "
>                              "l2_entry=3D%" PRIx64 " refcount=3D%" PRIu=
64 "\n",
>                              repair ? "Repairing" : "ERROR", l2_entry, =
refcount);
> -                    if (repair) {
> -                        l2_table[j] =3D cpu_to_be64(refcount =3D=3D 1
> -                                    ? l2_entry |  QCOW_OFLAG_COPIED
> -                                    : l2_entry & ~QCOW_OFLAG_COPIED);
> -                        l2_dirty++;
> -                    } else {
> -                        res->corruptions++;
> -                    }
> +                    l2_table[j] =3D cpu_to_be64(refcount =3D=3D 1
> +                                ? l2_entry |  QCOW_OFLAG_COPIED
> +                                : l2_entry & ~QCOW_OFLAG_COPIED);
> +                    l2_dirty++;

I found the old logic to be easier to understand, actually.  It made it
clear that if !repair, the L2 table is not going to be touched.

Max


--kbv0elEJACZq3qiI0B4dVZ4QPzpxHYd13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlx2hbkACgkQ9AfbAGHV
z0C1SQgAsYiK8CsuqKw3iaq02dDTnrPxwKJMkteINlVY39d3pDTTak75qMTWC5Hb
Vw91WdMAcqNPA2LF1j8f5U7hhYNQacm+rVGzR1ohIwSde13H4ZWb/znJ6STbhun7
vYyzB7C3g5jnF7jiBw+inzJkfsHtPXxDAO5WGSnYn413rBW6TYYQubRcx7guz8D6
SlMLtFm/jgAlyvu9FxgS9a4vX13i0VbfafyrQfw10LEWSr/4DM6wvQYy7gWPBkEN
3RsDxt2Z5eur7qrxXGZHTQ4Q8Q0Ji7ME4MWz8gOn2tUzfkGkPdVrXjpJKDBdVcFs
hxs5EvCIhnsBE+WGrsNQ/en23qiQ0A==
=VpLH
-----END PGP SIGNATURE-----

--kbv0elEJACZq3qiI0B4dVZ4QPzpxHYd13--
