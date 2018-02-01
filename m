Received: from eggs.gnu.org ([2001:4830:134:3::10]:35336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKxG-0005XU-7R
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:00:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKtp-00051Y-4p
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:55:30 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<896a464d5933927db49c968682de8c2b6e59635f.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <06131f65-28d8-44fb-ee96-2d8e78fe4b3c@redhat.com>
Date: Thu, 1 Feb 2018 20:46:46 +0100
MIME-Version: 1.0
In-Reply-To: <896a464d5933927db49c968682de8c2b6e59635f.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BdYraulc6RLarsF0fEOTAZSHneY4q7Obm"
Subject: Re: [Qemu-devel] [PATCH v3 31/39] qcow2: Update qcow2_truncate() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BdYraulc6RLarsF0fEOTAZSHneY4q7Obm
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <06131f65-28d8-44fb-ee96-2d8e78fe4b3c@redhat.com>
Subject: Re: [PATCH v3 31/39] qcow2: Update qcow2_truncate() to support L2
 slices
References: <cover.1516978645.git.berto@igalia.com>
 <896a464d5933927db49c968682de8c2b6e59635f.1516978645.git.berto@igalia.com>
In-Reply-To: <896a464d5933927db49c968682de8c2b6e59635f.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> The qcow2_truncate() code is mostly independent from whether
> we're using L2 slices or full L2 tables, but in full and
> falloc preallocation modes new L2 tables are allocated using
> qcow2_alloc_cluster_link_l2().  Therefore the code needs to be
> modified to ensure that all nb_clusters that are processed in each
> call can be allocated with just one L2 slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 78f067cae7..529becfa30 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3261,8 +3261,9 @@ static int qcow2_truncate(BlockDriverState *bs, i=
nt64_t offset,
>          guest_offset =3D old_length;
>          while (nb_new_data_clusters) {
>              int64_t guest_cluster =3D guest_offset >> s->cluster_bits;=

> -            int64_t nb_clusters =3D MIN(nb_new_data_clusters,
> -                                      s->l2_size - guest_cluster % s->=
l2_size);
> +            int64_t nb_clusters =3D MIN(
> +                nb_new_data_clusters,
> +                s->l2_slice_size - guest_cluster % s->l2_slice_size);

An alternative would be the
"s->l2_slice_size - offset_to_l2_slice_index(s, guest_offset)" we
basically have elsewhere, but that's longer and doesn't really matter:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>              QCowL2Meta allocation =3D {
>                  .offset       =3D guest_offset,
>                  .alloc_offset =3D host_offset,
>=20



--BdYraulc6RLarsF0fEOTAZSHneY4q7Obm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzbqYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AiJYIAL8xnLzbaL4A4KPnItACzxy6pKRjqHrh
1MIopaN1Ju9GuOhhi1ZIy6+RIjIYAZ1AfFT+eEA59/KlS90S4yusGojjbnzV6vgM
X1HzHYDhXlFmV6JypCl7xCzb72Uk8+J8y5l5rjVCPfIZOpwph4N4Pfp5/31oLufw
5HU63MQgj/dfw9A7IJSN5H7tcUXqJsYiYoAm1AB5XRiUC/QSDB3qwkDIi3ZmQMaR
1/xVixGJxNjwKiHzMvwblNH1HGA8g/ryFMKeyG85qQ87TLkUawodk41N7nunzYoi
uzFOKMtGf2BlnYN1jAhLAFZFvZnAg2u4//UJgiMs6Fv8AalkbGtlquc=
=a86A
-----END PGP SIGNATURE-----

--BdYraulc6RLarsF0fEOTAZSHneY4q7Obm--
