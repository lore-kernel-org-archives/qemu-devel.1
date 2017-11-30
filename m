Received: from eggs.gnu.org ([2001:4830:134:3::10]:39330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKoSY-0005bx-6L
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKoSU-00059o-1U
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:46:42 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-17-eblake@redhat.com>
	<9134df4a-480e-951f-b7ac-fe5be1a971a1@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b91d630d-936c-9bc7-d19a-29cd7e307b1d@redhat.com>
Date: Thu, 30 Nov 2017 17:11:17 -0600
MIME-Version: 1.0
In-Reply-To: <9134df4a-480e-951f-b7ac-fe5be1a971a1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 16/20] vdi: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com

On 11/30/2017 05:26 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.10.2017 21:59, Eric Blake wrote:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.=C2=A0 Update the vdi driver accordingly.=C2=A0 Note that t=
he
>> TODO is already covered (the block layer guarantees bounds of its
>> requests), and that we can remove the now-unused s->block_sectors.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVVdiState *s =3D (BDRVVdiState *)bs-=
>opaque;
>> -=C2=A0=C2=A0=C2=A0 size_t bmap_index =3D sector_num / s->block_sector=
s;
>> -=C2=A0=C2=A0=C2=A0 size_t sector_in_block =3D sector_num % s->block_s=
ectors;
>> -=C2=A0=C2=A0=C2=A0 int n_sectors =3D s->block_sectors - sector_in_blo=
ck;
>> +=C2=A0=C2=A0=C2=A0 size_t bmap_index =3D offset / s->block_size;
>> +=C2=A0=C2=A0=C2=A0 size_t index_in_block =3D offset % s->block_size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t bmap_entry =3D le32_to_cpu(s->=
bmap[bmap_index]);
>> -=C2=A0=C2=A0=C2=A0 uint64_t offset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int result;
>>
>> -=C2=A0=C2=A0=C2=A0 logout("%p, %" PRId64 ", %d, %p\n", bs, sector_num=
, nb_sectors,=20
>> pnum);
>> -=C2=A0=C2=A0=C2=A0 if (n_sectors > nb_sectors) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n_sectors =3D nb_sectors;
>> -=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 *pnum =3D n_sectors;
>> +=C2=A0=C2=A0=C2=A0 logout("%p, %" PRId64 ", %" PRId64 ", %p\n", bs, o=
ffset, bytes,=20
>> pnum);
>=20
> may be not bad to update message, as you changed numbers, like
>=20
> logout("%p, offset %" PRId64 ", bytes %" PRId64 ", %p\n", bs, offset,=20
> bytes, pnum);
>=20
> but for me it is ok as is too.

Debugging messages can be looked up in context when you enable=20
debugging. I'm not bothering to change that.

>=20
>> +=C2=A0=C2=A0=C2=A0 *pnum =3D MIN(s->block_size, bytes);
>=20
> looks like it should be MIN(s->block_size - index_in_block, bytes);

Oh, good catch. You are right.

>=20
> with that:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks again for a careful review throughout this series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
