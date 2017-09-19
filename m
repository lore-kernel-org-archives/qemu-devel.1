Received: from eggs.gnu.org ([2001:4830:134:3::10]:49925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duOQQ-0000Ef-PF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duOQP-0004lP-Cq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:43:18 -0400
References: <20170918185819.5984-1-eblake@redhat.com>
	<20170918185819.5984-19-eblake@redhat.com>
	<20170919124424.GD3789@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ef350240-dbe3-e91a-ac1c-734a0c5d24f1@redhat.com>
Date: Tue, 19 Sep 2017 14:42:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170919124424.GD3789@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BmclKvP40ErUksRlPB6upBwRVdPCrfQU1"
Subject: Re: [Qemu-devel] [PATCH v8 18/20] qcow2: Switch store_bitmap_data()
 to byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BmclKvP40ErUksRlPB6upBwRVdPCrfQU1
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <ef350240-dbe3-e91a-ac1c-734a0c5d24f1@redhat.com>
Subject: Re: [PATCH v8 18/20] qcow2: Switch store_bitmap_data() to byte-based
 iteration
References: <20170918185819.5984-1-eblake@redhat.com>
 <20170918185819.5984-19-eblake@redhat.com>
 <20170919124424.GD3789@localhost.localdomain>
In-Reply-To: <20170919124424.GD3789@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 07:44 AM, Kevin Wolf wrote:
> Am 18.09.2017 um 20:58 hat Eric Blake geschrieben:
>> Now that we have adjusted the majority of the calls this function
>> makes to be byte-based, it is easier to read the code if it makes
>> passes over the image using bytes rather than sectors.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

>> @@ -1100,18 +1099,17 @@ static uint64_t *store_bitmap_data(BlockDriver=
State *bs,
>>      dbi =3D bdrv_dirty_iter_new(bitmap);
>>      buf =3D g_malloc(s->cluster_size);
>>      limit =3D bytes_covered_by_bitmap_cluster(s, bitmap);

Limit is huge.  For ease of math, let's consider an image with 512-byte
clusters, and an explicit bitmap granularity of 512 bytes.  One cluster
(512 bytes, or 4k bits) of the bitmap covers 4k multiples of the
granularity, or 2M of image; and the minimum serialization alignment of
64 bits covers 32k bytes of image.  bytes_covered_by_bitmap_cluster()
computes granularity (512 bytes per bit), limit (2M bytes per cluster of
bits), and checks that 2M is indeed aligned to
bdrv_dirty_bitmap_serialization_align() (which is 32k).

Next, an image with default 64k clusters and a default bitmap
granularity of 64k bytes; one cluster (64k bytes, or 512k bits) now
covers 512k multiples of the granularity, or 32G of image size.

However...

>> -    sbc =3D limit >> BDRV_SECTOR_BITS;
>>      assert(DIV_ROUND_UP(bm_size, limit) =3D=3D tb_size);
>>
>> -    while ((sector =3D bdrv_dirty_iter_next(dbi) >> BDRV_SECTOR_BITS)=
 >=3D 0) {
>> -        uint64_t cluster =3D sector / sbc;
>> +    while ((offset =3D bdrv_dirty_iter_next(dbi)) >=3D 0) {
>> +        uint64_t cluster =3D offset / limit;

bdrv_dirty_iter_next() returns the next dirty bit (which is not
necessarily the first bit in the cluster).  For the purposes of
serialization, we want to serialize the entire cluster in one go, even
though we will be serializing 0 bits up until the first dirty bit.  So
offset at this point may be unaligned,

>>          uint64_t end, write_size;
>>          int64_t off;
>>
>> -        sector =3D cluster * sbc;
>> -        end =3D MIN(bm_sectors, sector + sbc);
>> -        write_size =3D bdrv_dirty_bitmap_serialization_size(bitmap,
>> -            sector * BDRV_SECTOR_SIZE, (end - sector) * BDRV_SECTOR_S=
IZE);
>> +        offset =3D QEMU_ALIGN_DOWN(offset, limit);

and we round it down to the start of the cluster that we will actually
be serializing.

>=20
> With the question that I asked in v6, apart from changing the spelling
> to be more explicit, I actually hoped that you would explain why
> aligning down is the right thing to do.
>=20
> It looks plausible to me that we can do this in correct code because we=

> don't support granularities < 512 bytes (a qemu restriction that is
> written down as a note in the qcow2 spec).

It's not granularities < 512 that we have to worry about, but dirty bits
with an offset < 4M (because we are serializing an entire cluster of
bitmap data, where the first dirty offset is not necessarily aligned to
that large).

>=20
> The part that I'm missing yet is why we need to do it. The bitmap
> granularity is also the granularity of bdrv_dirty_iter_next(), so isn't=

> offset already aligned and we could even assert that instead of alignin=
g
> down? (As long we enforce our restriction, which we seem to do in
> bitmap_list_load().)

Sadly, a quick:

diff --git i/block/qcow2-bitmap.c w/block/qcow2-bitmap.c
index 302fffd6e1..160f3b99f9 100644
--- i/block/qcow2-bitmap.c
+++ w/block/qcow2-bitmap.c
@@ -1106,6 +1106,7 @@ static uint64_t
*store_bitmap_data(BlockDriverState *bs,
         uint64_t end, write_size;
         int64_t off;

+        assert(QEMU_IS_ALIGNED(offset, limit));
         offset =3D QEMU_ALIGN_DOWN(offset, limit);
         end =3D MIN(bm_size, offset + limit);
         write_size =3D bdrv_dirty_bitmap_serialization_size(bitmap, offs=
et,

does NOT fail iotests 165, which appears to be the only test that
actually hammers on qcow2 bitmaps (changing it to an 'assert(false)'
only shows an effect on 165) - which means our test is NOT exercising
all possible alignments.  And it's python-based, with lame output, which
makes debugging it painful.  But never fear, for v9 I will improve the
test to actually affect the bitmap at a point that would fail with my
temporary assertion in place, and thus proving that we DO need to align
down.  Note that test 165 is testing only a 1G image, but I just showed
that 64k clusters with 64k granularity covers up to 32G of image space
in one cluster of the bitmap, so the test is only covering one cluster
of serialization in the first place, and as written, the test is
dirtying byte 0, which explains why it happens to get an offset aligned
to limit, even though that is not a valid assertion.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BmclKvP40ErUksRlPB6upBwRVdPCrfQU1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBc0MACgkQp6FrSiUn
Q2ryNgf7Bis+HU4qrYSOmjf+fbNmTUCqubeuIKMmut/REZ8vDvhRXuToZe33gBUA
kqGvDt3k//gcS/koKenEfp1Q5smbqnmtDN+iYecU8QO1mC6tALlYaiRAclhc5Eq8
ptus0hexKOEbsRmccmFtf/64jGtzI8FnMIv1Tbreujdx7FDGH0WUOoE+q6HWkvZe
g6y6MQNyGYv+xLzlHy87QY1XrsQe9jwQCytYEx4e3F2DcqwisJS8pX9/Ab72rtDM
nBCBotqVmAw2skcd8IfAQKdAzR4z5kIjKMFstklHCmfP7WkeBIw/odWO0k44/8W9
58RTj+i35d+5YW03eZhNDtnlvr7tfg==
=OD11
-----END PGP SIGNATURE-----

--BmclKvP40ErUksRlPB6upBwRVdPCrfQU1--
