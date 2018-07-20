Received: from eggs.gnu.org ([2001:4830:134:3::10]:33243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fgcE8-0005cG-NL
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 16:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fgcE7-0007sx-Po
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 16:42:12 -0400
References: <20180704112302.471456-1-vsementsov@virtuozzo.com>
	<20180704112302.471456-3-vsementsov@virtuozzo.com>
	<894031cf-d826-1d20-21de-a8f7af4be5fc@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9f971ed8-e43c-28a5-e44e-6f7f3720afed@redhat.com>
Date: Fri, 20 Jul 2018 15:42:05 -0500
MIME-Version: 1.0
In-Reply-To: <894031cf-d826-1d20-21de-a8f7af4be5fc@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] nbd/server: send more than one extent
 of base:allocation context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

On 07/10/2018 09:33 AM, Vladimir Sementsov-Ogievskiy wrote:
> 04.07.2018 14:23, Vladimir Sementsov-Ogievskiy wrote:
>> This is necessary for efficient block-status export, for clients which
>> support it.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---

>> +static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offs=
et,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t *bytes, N=
BDExtent *extents,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *nb_e=
xtents)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 uint64_t remaining_bytes =3D bytes;
>> +=C2=A0=C2=A0=C2=A0 uint64_t remaining_bytes =3D *bytes;
>> +=C2=A0=C2=A0=C2=A0 NBDExtent *extent =3D extents, *extents_end =3D ex=
tents + *nb_extents;
>> +=C2=A0=C2=A0=C2=A0 bool first_extent =3D true;
>> +=C2=A0=C2=A0=C2=A0 assert(*nb_extents);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (remaining_bytes) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t flags;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t num;
>> @@ -1860,21 +1871,40 @@ static int=20
>> blockstatus_to_extent_be(BlockDriverState *bs, uint64_t offset,
>=20
> after bdrv_block_status_above, is there a guarantee that num > 0? Shoul=
d=20
> we add an assertion?

bdrv_block_status_above() asserts that drivers set *pnum to non-zero on=20
success (that is, a driver's .bdrv_co_block_status must make progress or=20
fail); however, a caller can still get *pnum =3D=3D 0 on the corner case =
of=20
requesting status at or beyond the end-of-file boundary (where=20
bdrv_block_status_above() does not call into a driver's=20
.bdrv_co_block_status callback).  Since the NBD code already validated=20
that the client's code does not exceed EOF, and the block layer=20
guaranteed that an in-range request made progress on success, you should=20
be fine with an assertion that num > 0.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
