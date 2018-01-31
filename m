Received: from eggs.gnu.org ([2001:4830:134:3::10]:58042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyjg-0000Hv-BU
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyjf-0000G4-EY
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:12:00 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<5e98f636670e1741b9bafae624efb0052d9d0b71.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d21ddbab-921c-3cc9-05dd-5113cb16fd8f@redhat.com>
Date: Wed, 31 Jan 2018 21:11:48 +0100
MIME-Version: 1.0
In-Reply-To: <5e98f636670e1741b9bafae624efb0052d9d0b71.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Lt0z4CcnPv0D5pJL5gw19HNUZyoUnJuwg"
Subject: Re: [Qemu-devel] [PATCH v3 18/39] qcow2: Refactor
 get_cluster_table()
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
--Lt0z4CcnPv0D5pJL5gw19HNUZyoUnJuwg
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <d21ddbab-921c-3cc9-05dd-5113cb16fd8f@redhat.com>
Subject: Re: [PATCH v3 18/39] qcow2: Refactor get_cluster_table()
References: <cover.1516978645.git.berto@igalia.com>
 <5e98f636670e1741b9bafae624efb0052d9d0b71.1516978645.git.berto@igalia.com>
In-Reply-To: <5e98f636670e1741b9bafae624efb0052d9d0b71.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> After the previous patch we're now always using l2_load() in
> get_cluster_table() regardless of whether a new L2 table has to be
> allocated or not.
>=20
> This patch refactors that part of the code to use one single l2_load()
> call.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 2a53c1dc5f..0c0cab85e8 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -695,15 +695,7 @@ static int get_cluster_table(BlockDriverState *bs,=
 uint64_t offset,
>          return -EIO;
>      }
> =20
> -    /* seek the l2 table of the given l2 offset */
> -
> -    if (s->l1_table[l1_index] & QCOW_OFLAG_COPIED) {
> -        /* load the l2 table in memory */
> -        ret =3D l2_load(bs, offset, l2_offset, &l2_table);
> -        if (ret < 0) {
> -            return ret;
> -        }
> -    } else {
> +    if (!(s->l1_table[l1_index] & QCOW_OFLAG_COPIED)) {
>          /* First allocate a new L2 table (and do COW if needed) */
>          ret =3D l2_allocate(bs, l1_index);
>          if (ret < 0) {
> @@ -719,11 +711,12 @@ static int get_cluster_table(BlockDriverState *bs=
, uint64_t offset,
>          /* Get the offset of the newly-allocated l2 table */
>          l2_offset =3D s->l1_table[l1_index] & L1E_OFFSET_MASK;
>          assert(offset_into_cluster(s, l2_offset) =3D=3D 0);
> -        /* Load the l2 table in memory */
> -        ret =3D l2_load(bs, offset, l2_offset, &l2_table);
> -        if (ret < 0) {
> -            return ret;
> -        }
> +    }
> +
> +    /* load the l2 table in memory */
> +    ret =3D l2_load(bs, offset, l2_offset, &l2_table);
> +    if (ret < 0) {
> +        return ret;
>      }

I'd pull the l2_offset assignment (and alignment check) down below the
QCOW_OFLAG_COPIED check, saving us another two lines (!!1!) which we
could then spend on an

assert(s->l1_table[l1_index] & QCOW_OFLAG_COPIED);

Max

> =20
>      /* find the cluster offset for the given disk offset */
>=20



--Lt0z4CcnPv0D5pJL5gw19HNUZyoUnJuwg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyIwQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AamoH/jmQRJSA9Fia1nbqa3ceOiIzD0pCOSag
t1douuJu0iiZcyvvsjaPxXUhCWDDAy/bpUbOy4jxqPnNmsy1LON649UMQ1gHl0/q
9aI0KwASh0TamLx73quS4ogUt4xOqik399K15Wfz0cH1EQa+JxvTc1U2Z+Shugl3
MxsRDABDONIQG5uC1e4/HsXthANQRQ/rt6YcIb0J5SaNbTp9f1Ydw5GxuFGvtPnp
N1YFUSV0Lhn0MGu4fLut5n5GU3a/poiIJrVfY4m1xNgovw/xhWEi6ME+3LDbAnXi
xYJ8YjvGa8WrvgehVS0G44rbxidWODn4DdlbUXVfxGGaCkM//PMCVJA=
=CH3h
-----END PGP SIGNATURE-----

--Lt0z4CcnPv0D5pJL5gw19HNUZyoUnJuwg--
