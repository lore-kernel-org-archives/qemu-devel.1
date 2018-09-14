Received: from eggs.gnu.org ([2001:4830:134:3::10]:44636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0s05-0000hC-UT
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0s01-0004eN-S4
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:35:24 -0400
References: <20180914165116.23182-1-vsementsov@virtuozzo.com>
	<05b6e954-744f-d52c-1f5e-51d52062e195@redhat.com>
	<ce8e83a8-40c1-1fa9-3d83-c5f84796d514@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d127a88-58e9-dd74-e9ea-d13542aff92d@redhat.com>
Date: Fri, 14 Sep 2018 12:35:08 -0500
MIME-Version: 1.0
In-Reply-To: <ce8e83a8-40c1-1fa9-3d83-c5f84796d514@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nbd/server: fix bitmap export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org, John Snow <jsnow@redhat.com>

On 9/14/18 12:30 PM, Vladimir Sementsov-Ogievskiy wrote:

>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (begin < overall_end && i < nb_e=
xtents) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool next_dirty =3D !dirt=
y;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dirty) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 end =3D bdrv_dirty_bitmap_next_zero(bitmap, begin);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> @@ -1962,6 +1964,7 @@ static unsigned int=20
>>> bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 end =3D MIN(bdrv_dirty_bitmap_size(bitmap),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 beg=
in + UINT32_MAX + 1 -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdr=
v_dirty_bitmap_granularity(bitmap));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n=
ext_dirty =3D dirty;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> Rather than introducing next_dirty, couldn't you just make this:
>>
>> if (end =3D=3D -1 || end - begin > UINT32_MAX) {
>> =C2=A0=C2=A0=C2=A0 /* Cap ... */
>> =C2=A0=C2=A0=C2=A0 end =3D MIN(...);
>> } else {
>> =C2=A0=C2=A0=C2=A0 dirty =3D !dirty;
>> }
>=20
> no, dirty variable is used after it, we can't change it here.

Ah, right. But we could also hoist the extents[i].flags =3D=20
cpu_to_be32(dirty ? NBD_STATEE_DIRTY : 0) line to occur prior to the=20
'if' doing the end capping calculation.  However, splitting the two=20
assignments into extents[i].* to no longer be consecutive statements,=20
just to avoid the use of a temporary variable, starts to get less=20
aesthetically pleasing.

Thus, I'm fine with your version (with commit message improved), unless=20
you want to send a v2.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
