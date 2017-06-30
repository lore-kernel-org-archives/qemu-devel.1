Received: from eggs.gnu.org ([2001:4830:134:3::10]:53810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQlWW-0002Bk-Vt
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQlWV-0007Zg-RI
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:19:08 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-20-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f92fea0e-fe66-6888-dcd2-10782aec4fd2@redhat.com>
Date: Thu, 29 Jun 2017 21:18:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170628120530.31251-20-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rIdO8XeRDNFdmA9Ta1mMaHtETrqxos8A6"
Subject: Re: [Qemu-devel] [PATCH v22 19/30] qcow2: add persistent dirty
 bitmaps support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rIdO8XeRDNFdmA9Ta1mMaHtETrqxos8A6
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <f92fea0e-fe66-6888-dcd2-10782aec4fd2@redhat.com>
Subject: Re: [PATCH v22 19/30] qcow2: add persistent dirty bitmaps support
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
 <20170628120530.31251-20-vsementsov@virtuozzo.com>
In-Reply-To: <20170628120530.31251-20-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2017 07:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> Store persistent dirty bitmaps in qcow2 image.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-bitmap.c | 475 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c        |   9 +
>  block/qcow2.h        |   1 +
>  3 files changed, 485 insertions(+)
>=20

> +
> +/* store_bitmap_data()
> + * Store bitmap to image, filling bitmap table accordingly.
> + */
> +static uint64_t *store_bitmap_data(BlockDriverState *bs,
> +                                   BdrvDirtyBitmap *bitmap,
> +                                   uint32_t *bitmap_table_size, Error =
**errp)
> +{
> +    int ret;
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int64_t sector;
> +    uint64_t sbc;
> +    uint64_t bm_size =3D bdrv_dirty_bitmap_size(bitmap);

This grabs the size (currently in sectors, although I plan to fix it to
be in bytes)...

> +    const char *bm_name =3D bdrv_dirty_bitmap_name(bitmap);
> +    uint8_t *buf =3D NULL;
> +    BdrvDirtyBitmapIter *dbi;
> +    uint64_t *tb;
> +    uint64_t tb_size =3D
> +            size_to_clusters(s,
> +                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_siz=
e));

=2E..then finds out how many bytes are required to serialize the entire
image, where bm_size should be the same as before...

> +    while ((sector =3D bdrv_dirty_iter_next(dbi)) !=3D -1) {
> +        uint64_t cluster =3D sector / sbc;
> +        uint64_t end, write_size;
> +        int64_t off;
> +
> +        sector =3D cluster * sbc;
> +        end =3D MIN(bm_size, sector + sbc);
> +        write_size =3D
> +            bdrv_dirty_bitmap_serialization_size(bitmap, sector, end -=
 sector);

But here, rather than tackling the entire image at once, you are
subdividing your queries along arbitrary lines. But nowhere do I see a
call to bdrv_dirty_bitmap_serialization_align() to make sure your
end-sector value is properly aligned; if it is not aligned, you will
trigger an assertion failure here...

> +        assert(write_size <=3D s->cluster_size);
> +
> +        off =3D qcow2_alloc_clusters(bs, s->cluster_size);
> +        if (off < 0) {
> +            error_setg_errno(errp, -off,
> +                             "Failed to allocate clusters for bitmap '=
%s'",
> +                             bm_name);
> +            goto fail;
> +        }
> +        tb[cluster] =3D off;
> +
> +        bdrv_dirty_bitmap_serialize_part(bitmap, buf, sector, end - se=
ctor);

=2E..and again here, during serialization_chunk().

I don't know if that means you need a v23 series, or if we can just
patch it in as a followup (perhaps by having me add the usage during my
byte-based dirty-bitmap series).  I guess it depends on whether we can
come up with any bitmap granularity (between 512 bytes and 2M is all the
more we are currently supporting, right?) that differs from the qcow2
cluster granularity in a manner that iteration by qcow2 clusters is no
longer guaranteed to be bitmap-granularity aligned, and thus trigger an
assertion failure on your code as-is.

I also think it's pretty gross to be calculating the iteration bounds by
sectors rather than bytes, when we are really worried about clusters
(it's easier to track just bytes/clusters than it is to track
bytes/sectors/clusters) - but that one is more along the lines of the
sector-to-byte conversions I've been tackling, so I won't insist on you
changing it if there is no other reason for a v23.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rIdO8XeRDNFdmA9Ta1mMaHtETrqxos8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVbUMAAoJEKeha0olJ0NqRKsH/RbZsTS1Rb+GSj9It02jXWWE
iiNG267gj+H0elZhOpvQQHJV2heRUjrou/JpOs6b3nniRDCwJuxP1bCelaUOm3Qr
+lZed/mIzSahCuhOpnlHkOUx5/lahRE9Vvbyli4KV3SmLnGivSmszmjtbdhd32Cj
PpwCkwxmHNFk1bbkruwKyKaRE96c/TiaMz/MhOTzsZ9UR9AIst5EnB3AhzgaHH3L
g8XrbD9xjx9yNjTHa9+ZwGJa17pYBHxRdDPGmzeQ06GARjZUkI0SPpk32xx0NcrZ
1CD+VIQbfZGealk1Ufn+pbCsh1TXV4vBdb/l2rstTrXuzQ7YYqjzLZvpSoOx7PM=
=AFLJ
-----END PGP SIGNATURE-----

--rIdO8XeRDNFdmA9Ta1mMaHtETrqxos8A6--
