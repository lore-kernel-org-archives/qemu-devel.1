Received: from eggs.gnu.org ([2001:4830:134:3::10]:56046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eOPx2-0000Lf-T7
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eOPwy-0000gd-PW
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:25:04 -0500
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-10-eblake@redhat.com>
	<c0b4ca07-0404-963a-bd1f-9d182eebf469@virtuozzo.com>
	<bc667ec3-4107-4578-d236-5b914d1291a5@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f0d2401d-95e5-75a3-6112-7ef3fc3f9113@virtuozzo.com>
Date: Mon, 11 Dec 2017 18:24:48 +0300
MIME-Version: 1.0
In-Reply-To: <bc667ec3-4107-4578-d236-5b914d1291a5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v6 09/20] parallels: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Max Reitz <mreitz@redhat.com>

09.12.2017 19:39, Eric Blake wrote:
> On 12/09/2017 06:31 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 07.12.2017 23:30, Eric Blake wrote:
>>> We are gradually moving away from sector-based interfaces, towards
>>> byte-based.=C2=A0 Update the parallels driver accordingly.=C2=A0 Note t=
hat
>>> the internal function block_status() is still sector-based, because
>>> it is still in use by other sector-based functions; but that's okay
>>> because request_alignment is 512 as a result of those functions.
>>> For now, no optimizations are added based on the mapping hint.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>
>>>  =C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVParallelsState *s =3D bs->opaque;
>>> -=C2=A0=C2=A0=C2=A0 int64_t offset;
>>> +=C2=A0=C2=A0=C2=A0 int count;
>>>
>>> +=C2=A0=C2=A0=C2=A0 assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_=
SIZE));
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_mutex_lock(&s->lock);
>>> -=C2=A0=C2=A0=C2=A0 offset =3D block_status(s, sector_num, nb_sectors, =
pnum);
>>> +=C2=A0=C2=A0=C2=A0 offset =3D block_status(s, offset >> BDRV_SECTOR_BI=
TS,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bytes >> BDRV_SECTOR_BITS, &count);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_mutex_unlock(&s->lock);
>>>
>>> +=C2=A0=C2=A0=C2=A0 *pnum =3D count * BDRV_SECTOR_SIZE;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (offset < 0) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> +=C2=A0=C2=A0=C2=A0 *map =3D offset;
>> oh, didn't notice previous time :(, should be
>>
>> *map =3D offset * BDRV_SECTOR_SIZE
>>
> Oh, right.
>
>> (also, if you already use ">> BDRV_SECTOR_BITS" in this function,
>> would not it be more consistent to use "<< BDRV_SECTOR_BITS"
>> for sector-to-byte conversion?)
>>
>> with that fixed (with "<<" or "*", up to you),
> '>> BDRV_SECTOR_BITS' always works.  You could also write '/
> BDRV_SECTOR_SIZE' (the compiler should figure out that you are dividing
> by a power of 2, and use the shift instruction under the hood), but I
> find that a bit harder to reason about.
>
> On the other hand, '<< BDRV_SECTOR_BITS' only produces the same size
> output as the input; if the left side is 32 bits, it risks overflowing.
> But '* BDRV_SECTOR_SIZE' always produces a 64-bit value.  So I've
> learned (from past mistakes in other byte-conversion series) that the
> multiply form is less likely to introduce unintended truncation bugs.

hm, now I doubt. I've wrote tiny program:

#include <stdint.h>
#include <stdio.h>

int main() {
 =C2=A0=C2=A0=C2=A0 uint32_t blocks =3D 1 << 20;
 =C2=A0=C2=A0=C2=A0 int block_bits =3D 15;
 =C2=A0=C2=A0=C2=A0 uint32_t block_size =3D 1 << block_bits;
 =C2=A0=C2=A0=C2=A0 uint64_t a =3D blocks * block_size;
 =C2=A0=C2=A0=C2=A0 uint64_t b =3D blocks << block_bits;
 =C2=A0=C2=A0=C2=A0 uint64_t c =3D (uint64_t)blocks * block_size;
 =C2=A0=C2=A0=C2=A0 uint64_t d =3D (uint64_t)blocks << block_bits;
 =C2=A0=C2=A0=C2=A0 printf("%lx %lx %lx %lx\n", a, b, c, d);
 =C2=A0=C2=A0=C2=A0 return 0;
}


and it prints
0 0 800000000 800000000
for me. So, no difference between * and <<...

>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>


--=20
Best regards,
Vladimir
