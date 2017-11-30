Received: from eggs.gnu.org ([2001:4830:134:3::10]:44406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKnVN-0007cn-03
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKnUi-00055s-CF
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:45:32 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-13-eblake@redhat.com>
	<fd6ad85b-ea0c-0941-4402-4b8306a87533@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <922a4b71-664a-0316-1aa7-f56e0cc7f1ae@redhat.com>
Date: Thu, 30 Nov 2017 17:17:14 -0600
MIME-Version: 1.0
In-Reply-To: <fd6ad85b-ea0c-0941-4402-4b8306a87533@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 12/20] qed: Switch to
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
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

On 11/30/2017 04:27 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.10.2017 21:59, Eric Blake wrote:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.=C2=A0 Update the qed driver accordingly, taking the opport=
unity
>> to inline qed_is_allocated_cb() into its lone caller (the callback
>> used to be important, until we switched qed to coroutines).=C2=A0 Ther=
e is
>> no intent to optimize based on the want_zero flag for this format.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVQEDState *s =3D bs->opaque;
>> -=C2=A0=C2=A0=C2=A0 size_t len =3D (size_t)nb_sectors * BDRV_SECTOR_SI=
ZE;
>> -=C2=A0=C2=A0=C2=A0 QEDIsAllocatedCB cb =3D {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bs =3D bs,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pos =3D (uint64_t)sector_=
num * BDRV_SECTOR_SIZE,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .status =3D BDRV_BLOCK_OFF=
SET_MASK,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pnum =3D pnum,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .file =3D file,
>> -=C2=A0=C2=A0=C2=A0 };
>> +=C2=A0=C2=A0=C2=A0 size_t len;
>=20
> size_t len =3D bytes;
>=20

Or rather, size_t len =3D MIN(bytes, SIZE_MAX); thanks to 32-bit platform=
s.

> with that:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>> +=C2=A0=C2=A0=C2=A0 int status;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEDRequest request =3D { .l2_table =3D =
NULL };
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t offset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_mutex_lock(&s->table_lock);
>> -=C2=A0=C2=A0=C2=A0 ret =3D qed_find_cluster(s, &request, cb.pos, &len=
, &offset);
>> -=C2=A0=C2=A0=C2=A0 qed_is_allocated_cb(&cb, ret, offset, len);
>> +=C2=A0=C2=A0=C2=A0 ret =3D qed_find_cluster(s, &request, pos, &len, &=
offset);
>=20
> len is in-out parameter, you can't use it uninitialized.

Good catch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
