Received: from eggs.gnu.org ([2001:4830:134:3::10]:57855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQlab-00042g-2w
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQlaZ-0002Pj-TS
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 22:23:21 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-20-vsementsov@virtuozzo.com>
	<f92fea0e-fe66-6888-dcd2-10782aec4fd2@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b084acc4-a9d6-ecf5-e8f1-beb7c3a80072@redhat.com>
Date: Fri, 30 Jun 2017 04:23:02 +0200
MIME-Version: 1.0
In-Reply-To: <f92fea0e-fe66-6888-dcd2-10782aec4fd2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uTtwWwahwVbbr1i9OVuSdLs6p57CdggEp"
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
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uTtwWwahwVbbr1i9OVuSdLs6p57CdggEp
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com,
 den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <b084acc4-a9d6-ecf5-e8f1-beb7c3a80072@redhat.com>
Subject: Re: [PATCH v22 19/30] qcow2: add persistent dirty bitmaps support
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
 <20170628120530.31251-20-vsementsov@virtuozzo.com>
 <f92fea0e-fe66-6888-dcd2-10782aec4fd2@redhat.com>
In-Reply-To: <f92fea0e-fe66-6888-dcd2-10782aec4fd2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-30 04:18, Eric Blake wrote:
> On 06/28/2017 07:05 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Store persistent dirty bitmaps in qcow2 image.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2-bitmap.c | 475 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  block/qcow2.c        |   9 +
>>  block/qcow2.h        |   1 +
>>  3 files changed, 485 insertions(+)
>>
>=20
>> +
>> +/* store_bitmap_data()
>> + * Store bitmap to image, filling bitmap table accordingly.
>> + */
>> +static uint64_t *store_bitmap_data(BlockDriverState *bs,
>> +                                   BdrvDirtyBitmap *bitmap,
>> +                                   uint32_t *bitmap_table_size, Error=
 **errp)
>> +{
>> +    int ret;
>> +    BDRVQcow2State *s =3D bs->opaque;
>> +    int64_t sector;
>> +    uint64_t sbc;
>> +    uint64_t bm_size =3D bdrv_dirty_bitmap_size(bitmap);
>=20
> This grabs the size (currently in sectors, although I plan to fix it to=

> be in bytes)...
>=20
>> +    const char *bm_name =3D bdrv_dirty_bitmap_name(bitmap);
>> +    uint8_t *buf =3D NULL;
>> +    BdrvDirtyBitmapIter *dbi;
>> +    uint64_t *tb;
>> +    uint64_t tb_size =3D
>> +            size_to_clusters(s,
>> +                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_si=
ze));
>=20
> ...then finds out how many bytes are required to serialize the entire
> image, where bm_size should be the same as before...
>=20
>> +    while ((sector =3D bdrv_dirty_iter_next(dbi)) !=3D -1) {
>> +        uint64_t cluster =3D sector / sbc;
>> +        uint64_t end, write_size;
>> +        int64_t off;
>> +
>> +        sector =3D cluster * sbc;
>> +        end =3D MIN(bm_size, sector + sbc);
>> +        write_size =3D
>> +            bdrv_dirty_bitmap_serialization_size(bitmap, sector, end =
- sector);
>=20
> But here, rather than tackling the entire image at once, you are
> subdividing your queries along arbitrary lines. But nowhere do I see a
> call to bdrv_dirty_bitmap_serialization_align() to make sure your
> end-sector value is properly aligned; if it is not aligned, you will
> trigger an assertion failure here...

It's 4:21 am here, so I cannot claim to be right, but if I remember
correctly, it will automatically aligned because sbc is the number of
bits (and thus sectors) a bitmap cluster covers.

>=20
>> +        assert(write_size <=3D s->cluster_size);
>> +
>> +        off =3D qcow2_alloc_clusters(bs, s->cluster_size);
>> +        if (off < 0) {
>> +            error_setg_errno(errp, -off,
>> +                             "Failed to allocate clusters for bitmap =
'%s'",
>> +                             bm_name);
>> +            goto fail;
>> +        }
>> +        tb[cluster] =3D off;
>> +
>> +        bdrv_dirty_bitmap_serialize_part(bitmap, buf, sector, end - s=
ector);
>=20
> ...and again here, during serialization_chunk().
>=20
> I don't know if that means you need a v23 series, or if we can just
> patch it in as a followup (perhaps by having me add the usage during my=

> byte-based dirty-bitmap series).  I guess it depends on whether we can
> come up with any bitmap granularity (between 512 bytes and 2M is all th=
e
> more we are currently supporting, right?) that differs from the qcow2
> cluster granularity in a manner that iteration by qcow2 clusters is no
> longer guaranteed to be bitmap-granularity aligned, and thus trigger an=

> assertion failure on your code as-is.
>=20
> I also think it's pretty gross to be calculating the iteration bounds b=
y
> sectors rather than bytes, when we are really worried about clusters
> (it's easier to track just bytes/clusters than it is to track
> bytes/sectors/clusters) - but that one is more along the lines of the
> sector-to-byte conversions I've been tackling, so I won't insist on you=

> changing it if there is no other reason for a v23.

I'm for fixing it later. I would have announced the series "applied" an
hour ago if I hadn't had to bisect iotest 055 breakage...

Max


--uTtwWwahwVbbr1i9OVuSdLs6p57CdggEp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZVbYGEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQK4m
B/4mK1g7PvjhL0dlkfzZK6OrWYgh4DIyuxkHNqxPqvHV2DjV+7paivAZY9aI4uG9
uhGBTerxQJeOJESPMJOVWZbksALkegN8AbPe/U5jkZSxalmUxUdpGFaefWL5Baf5
JGBNqUY1xNoVkKTZY1GLKFnqx0RRbOqTqsMqFNVLPrfiiT6+0DeP1HSIpNlY2h3V
yR/30q+7v26pxYdC+jJi3f6y4qdmMhG6T4xzyTyBdgL7saxDKyy9J9DrI0xkl9XW
lWWZqtg9XnDlbbAyali9qrWnGqlZXkficFKofLYk2QEYQRJbdNLftsq+YVUtghxP
CSuL2S5p6j9mVFQJ4We131K2
=dGDn
-----END PGP SIGNATURE-----

--uTtwWwahwVbbr1i9OVuSdLs6p57CdggEp--
