Received: from eggs.gnu.org ([2001:4830:134:3::10]:56592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dRfRD-0000KY-8B
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 10:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dRfRC-0003NM-3S
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 10:01:23 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-20-vsementsov@virtuozzo.com>
	<f92fea0e-fe66-6888-dcd2-10782aec4fd2@redhat.com>
	<b084acc4-a9d6-ecf5-e8f1-beb7c3a80072@redhat.com>
	<bddd14a1-5d18-58b2-8e4b-8579ad0e7f49@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <368951d8-f683-4aeb-c702-8edd78c2fac7@redhat.com>
Date: Sun, 2 Jul 2017 16:01:04 +0200
MIME-Version: 1.0
In-Reply-To: <bddd14a1-5d18-58b2-8e4b-8579ad0e7f49@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WNFbeUKf8HixPQ9JJ5OftbqQJNeoOrh0l"
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
--WNFbeUKf8HixPQ9JJ5OftbqQJNeoOrh0l
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com,
 den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <368951d8-f683-4aeb-c702-8edd78c2fac7@redhat.com>
Subject: Re: [PATCH v22 19/30] qcow2: add persistent dirty bitmaps support
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
 <20170628120530.31251-20-vsementsov@virtuozzo.com>
 <f92fea0e-fe66-6888-dcd2-10782aec4fd2@redhat.com>
 <b084acc4-a9d6-ecf5-e8f1-beb7c3a80072@redhat.com>
 <bddd14a1-5d18-58b2-8e4b-8579ad0e7f49@redhat.com>
In-Reply-To: <bddd14a1-5d18-58b2-8e4b-8579ad0e7f49@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-30 19:47, Eric Blake wrote:
> On 06/29/2017 09:23 PM, Max Reitz wrote:
>> On 2017-06-30 04:18, Eric Blake wrote:
>>> On 06/28/2017 07:05 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Store persistent dirty bitmaps in qcow2 image.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>=20
>>>
>>> This grabs the size (currently in sectors, although I plan to fix it =
to
>>> be in bytes)...
>>>
>>>> +    const char *bm_name =3D bdrv_dirty_bitmap_name(bitmap);
>>>> +    uint8_t *buf =3D NULL;
>>>> +    BdrvDirtyBitmapIter *dbi;
>>>> +    uint64_t *tb;
>>>> +    uint64_t tb_size =3D
>>>> +            size_to_clusters(s,
>>>> +                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_=
size));
>>>
>>> ...then finds out how many bytes are required to serialize the entire=

>>> image, where bm_size should be the same as before...
>>>
>>>> +    while ((sector =3D bdrv_dirty_iter_next(dbi)) !=3D -1) {
>>>> +        uint64_t cluster =3D sector / sbc;
>>>> +        uint64_t end, write_size;
>>>> +        int64_t off;
>>>> +
>>>> +        sector =3D cluster * sbc;
>>>> +        end =3D MIN(bm_size, sector + sbc);
>>>> +        write_size =3D
>>>> +            bdrv_dirty_bitmap_serialization_size(bitmap, sector, en=
d - sector);
>>>
>>> But here, rather than tackling the entire image at once, you are
>>> subdividing your queries along arbitrary lines. But nowhere do I see =
a
>>> call to bdrv_dirty_bitmap_serialization_align() to make sure your
>>> end-sector value is properly aligned; if it is not aligned, you will
>>> trigger an assertion failure here...
>>
>> It's 4:21 am here, so I cannot claim to be right, but if I remember
>> correctly, it will automatically aligned because sbc is the number of
>> bits (and thus sectors) a bitmap cluster covers.
>=20
> Okay, I re-read the spec.  First thing I noticed: we have a potential
> conflict if an image is allowed to be resized:

It isn't, though. (At least currently qemu won't allow it.)

> "All stored bitmaps are related to the virtual disk stored in the same
> image, so each bitmap size is equal to the virtual disk size."
>=20
> If you resize an image, does the bitmap size have to be adjusted as
> well?

Sure.

>        What if you create one bitmap, then take an internal snapshot,
> then resize?

v3 images store the virtual disk size for each snapshot. So resizing an
image leaves snapshots unaffected.

Now bitmaps are not (yet) tied to snapshots. The spec thus says that the
bitmaps always correspond to the active state (it lists "snapshot
switching" as something that should dirty dirty bitmaps).

Therefore, if you then resize (which currently is doubly forbidden,
because qemu won't allow you to resize images with bitmaps or
snapshots), you would have to resize the bitmap, too.

In the future, we might want to allow binding bitmaps to snapshots. Then
the bitmap would not be resized but you couldn't see it anymore unless
you go back to the snapshot (which would bring the image to its original
size).

>               Or do we declare that (at least for now) the presence of =
a
> bitmap is incompatible with the use of an internal snapshot?

Well, that's not what the spec says. It clearly lists "snapshot
switching" as something that dirty bitmaps track.

> Conversely, we state that:
>=20
>=20
> "Structure of a bitmap directory entry:
> ...
>          8 - 11:    bitmap_table_size
>                     Number of entries in the bitmap table of the bitmap=
=2E"
>=20
> Since a bitmap therefore tracks its own size, I think the earlier
> statement that all bitmap sizes are equal to the virtual disk size is
> too strict (there seems to be no technical reason why a bitmap can't
> have a different size that the image).

But a logical. qcow2 is not a container format, it's an image format. I
for one am very opposed to storing bitmaps in a qcow2 file which have no
immediate connection to that virtual disk.

A reason I can see myself supporting would be that you could tie bitmaps
to snapshots and then they can have a size that differs from the one of
the active layer.

Max

> But, having read that, you are correct that we are subdividing our
> bitmaps according to what fits in a qcow2 cluster, and the smallest
> qcow2 cluster we can come up with is 512-bytes (or 4k bits of the
> bitmap).  Checking hbitmap.c, we are merely asserting that our alignmen=
t
> is always a multiple of 64 << hb->granularity.  But since we are
> partitioning a cluster at a time, our minimum alignment will be 512 <<
> hb->granularity, which is always aligned.
>=20
> So all the more I need to do is add an assertion.
>=20
>> I'm for fixing it later. I would have announced the series "applied" a=
n
>> hour ago if I hadn't had to bisect iotest 055 breakage...
>=20
> I'm working it into my v4 posting of dirty-bitmap cleanups.
>=20



--WNFbeUKf8HixPQ9JJ5OftbqQJNeoOrh0l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZWPygEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQPSx
CACIsX+fwzqY7HnvPnwOSA5TEVFVC4keZwIbdhcdQBpXqeo5iJXK/WjAXWyziY84
a6kFMBUFNVJq861zjmcNhJvVyqZAzGL8IKUF14xMgmKK7/DmdsG0LjRcVTtAzqF0
g8uxjpmnvYoN7vD1A04eUos2ZiziBB0HP/E1YCLp3F2RwwySpFvIqrMCxDtZLZpz
HRegzKWWAWK+8chvJP5ttNWax/ScOz5/elwQkwofZKsvHF66fyOo6ItCH1Z6awr8
CfeKDneaa0RX/KXVFd0+az/URK+mxuY5pCi4l6PZPTehWkE5lCiAKk2s+IEzmYXQ
RAfbQxsq10frMkzT+9cnz0EG
=vop/
-----END PGP SIGNATURE-----

--WNFbeUKf8HixPQ9JJ5OftbqQJNeoOrh0l--
