Received: from eggs.gnu.org ([2001:4830:134:3::10]:41939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVy4C-0005bJ-9c
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVy4A-0008Db-P3
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:47:56 -0400
References: <20180621031957.134718-1-eblake@redhat.com>
	<20180621031957.134718-6-eblake@redhat.com>
	<d07e7a19-3d8e-6049-04f6-e26f9e9c328b@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <273ec772-cbd2-a882-1029-7e31139b5e8d@redhat.com>
Date: Thu, 21 Jun 2018 06:47:47 -0500
MIME-Version: 1.0
In-Reply-To: <d07e7a19-3d8e-6049-04f6-e26f9e9c328b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 5/7] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

On 06/21/2018 05:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> 21.06.2018 06:19, Eric Blake wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Handle a new NBD meta namespace: "qemu", and corresponding queries:
>> "qemu:dirty-bitmap:<export bitmap name>".
>>
>> With the new metadata context negotiated, BLOCK_STATUS query will repl=
y
>> with dirty-bitmap data, converted to extents. The new public function
>> nbd_export_bitmap selects which bitmap to export. For now, only one=20
>> bitmap
>> may be exported.
>>

>> +/*
>> + * Populate @extents from a dirty bitmap. Unless @dont_fragment, the
>> + * final extent may exceed the original @length. Store in @length the
>> + * byte length encoded (which may be smaller or larger than the
>> + * original), and return the number of extents used.
>> + */
>> +static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap,=20
>> uint64_t offset,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t *length, NBDExtent=20
>> *extents,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 unsigned int nb_extents,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 bool dont_fragment)
>> +{
>> +=C2=A0=C2=A0=C2=A0 uint64_t begin =3D offset, end;
>> +=C2=A0=C2=A0=C2=A0 uint64_t overall_end =3D offset + *length;
>> +=C2=A0=C2=A0=C2=A0 unsigned int i =3D 0;
>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmapIter *it;
>> +=C2=A0=C2=A0=C2=A0 bool dirty;
>> +
>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_lock(bitmap);
>> +
>> +=C2=A0=C2=A0=C2=A0 it =3D bdrv_dirty_iter_new(bitmap);
>> +=C2=A0=C2=A0=C2=A0 dirty =3D bdrv_get_dirty_locked(NULL, bitmap, offs=
et);
>> +
>> +=C2=A0=C2=A0=C2=A0 while (begin < overall_end && i < nb_extents) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dirty) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
d =3D bdrv_dirty_bitmap_next_zero(bitmap, begin);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bd=
rv_set_dirty_iter(it, begin);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
d =3D bdrv_dirty_iter_next(it);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> after tjos begin may be zero, and end near to the bitmap end,
> so end !=3D -1 and end-begin > 4G (and dont_fragment may be false)

Oh, good catch. Such a situation will still need to be clamped to under=20
4G (it's only possible on the last extent reported to the user, since in=20
that case, end > overall_end given that overall_end is at most a 32-bit=20
request beyond the original begin), so...

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (end =3D=3D -1) {

...we just need to tweak this to 'if (end =3D=3D -1 || end - begin > UINT=
32_MAX)

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 Cap to an aligned value < 4G beyond begin. */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
d =3D MIN(bdrv_dirty_bitmap_size(bitmap),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 begin + 0x10000=
0000ULL -
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitm=
ap_granularity(bitmap));

Also, it might be more legible if I spell this as UINT32_MAX + 1 instead=20
of open-coding the 33-bit constant.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dont_fragment && end >=
 overall_end) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 en=
d =3D overall_end;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
