Received: from eggs.gnu.org ([2001:4830:134:3::10]:37728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXsZ1-0005FY-6B
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 11:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXsYz-0008M1-Ux
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 11:42:51 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-22-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c7c56077-16de-f297-1d94-d4623cbb3117@redhat.com>
Date: Sun, 29 Jan 2017 17:42:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170123121036.4823-22-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fMrFqpx7ukrsc9c5Ul54wjxBAmoPlTD3Q"
Subject: Re: [Qemu-devel] [PATCH 21/24] qcow2-bitmap: refcounts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fMrFqpx7ukrsc9c5Ul54wjxBAmoPlTD3Q
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <c7c56077-16de-f297-1d94-d4623cbb3117@redhat.com>
Subject: Re: [PATCH 21/24] qcow2-bitmap: refcounts
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-22-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-22-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
> Calculate refcounts for qcow2 bitmaps. It is needed for qcow2's qemu-im=
g
> check implementation.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c   | 80 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2-refcount.c |  6 ++++
>  block/qcow2.h          |  3 ++
>  3 files changed, 89 insertions(+)
>=20
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 8b8f2d11ec..2687a3acd5 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1232,3 +1232,83 @@ common_errp:
>                 name, bdrv_get_device_or_node_name(bs), reason);
>      return false;
>  }
> +
> +int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResul=
t *res,
> +                                  void **refcount_table,
> +                                  int64_t *refcount_table_size)
> +{
> +    int ret;
> +    BDRVQcow2State *s =3D bs->opaque;
> +    Qcow2BitmapList *bm_list;
> +    Qcow2Bitmap *bm;
> +
> +    if (s->nb_bitmaps =3D=3D 0) {
> +        return 0;
> +    }
> +
> +    ret =3D qcow2_inc_refcounts_imrt(bs, res, refcount_table, refcount=
_table_size,
> +                                   s->bitmap_directory_offset,
> +                                   s->bitmap_directory_size);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
> +                               s->bitmap_directory_size, NULL);
> +    if (bm_list =3D=3D NULL) {
> +        res->corruptions++;
> +        return -EINVAL;
> +    }
> +
> +    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
> +        uint64_t *bitmap_table =3D NULL;
> +        int i;
> +
> +        ret =3D qcow2_inc_refcounts_imrt(bs, res,
> +                                       refcount_table, refcount_table_=
size,
> +                                       bm->table.offset,
> +                                       bm->table.size * sizeof(uint64_=
t));
> +        if (ret < 0) {
> +            goto out;
> +        }
> +
> +        ret =3D bitmap_table_load(bs, &bm->table, &bitmap_table);
> +        if (ret < 0) {
> +            res->corruptions++;
> +            goto out;
> +        }
> +
> +        for (i =3D 0; i < bm->table.size; ++i) {
> +            uint64_t entry =3D bitmap_table[i];
> +            uint64_t offset =3D entry & BME_TABLE_ENTRY_OFFSET_MASK;
> +
> +            if (check_table_entry(entry, s->cluster_size) < 0) {
> +                res->corruptions++;
> +                continue;
> +            }
> +
> +            if (offset =3D=3D 0) {
> +                continue;
> +            }
> +
> +            ret =3D qcow2_inc_refcounts_imrt(bs, res,
> +                                           refcount_table, refcount_ta=
ble_size,
> +                                           offset, s->cluster_size);
> +            if (ret < 0) {
> +                g_free(bitmap_table);
> +                goto out;
> +            }
> +        }
> +
> +        g_free(bitmap_table);
> +    }
> +
> +    if (res->corruptions > 0) {
> +        ret =3D -EINVAL;
> +    }

res->corruptions may already be greater than zero when this function is
invoked.

But in any case, you don't need to return a negative value just because
some corruption was found. These check functions should only return
negative values if they were unable to do what they are supposed to do
(whatever that is), e.g. because of an I/O error or ENOMEM. In these
cases, however, they usually return to the caller immediately.

It wouldn't be strictly wrong to return a negative value if some table
entry is corrupted, but I don't think it's necessary either. So if you
just drop the above three lines:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--fMrFqpx7ukrsc9c5Ul54wjxBAmoPlTD3Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliOG30SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATn4H/RFD0T8wHU2YWFJ+aXorIN8lnGHfSEVx
7iMWXhORX7F71Y4602ENSyLc3OEivu0CaBrfYiT4WD9ARF5KXpK/C6jB99bP0ir/
n6epFCSupYuAkLB3bYdP1KQ7qrqRUWdmBKOi2qPSy/vvwy53yLtgNUWdeYlk1i4n
0Oiv+sXxABkyaV6ULWj9BYWCbFaYJf69lhCcVl5civF7HDcAMSTAFsk0MoRsG3bf
zj/EK81VNKi09IX65k07ohFyFwxat+uAQ47feVHfRycNdAA5Zl1u5JR1RcoAzod3
1EIg36ATfeYN72nG/dca2JVtzYd4DTF40cu0amrRSePFUry0FmaEOvo=
=0zji
-----END PGP SIGNATURE-----

--fMrFqpx7ukrsc9c5Ul54wjxBAmoPlTD3Q--
