Received: from eggs.gnu.org ([2001:4830:134:3::10]:40709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eOnk6-0002Ff-Pi
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 11:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eOnk5-0001KH-Ug
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 11:49:18 -0500
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-10-eblake@redhat.com>
	<c0b4ca07-0404-963a-bd1f-9d182eebf469@virtuozzo.com>
	<bc667ec3-4107-4578-d236-5b914d1291a5@redhat.com>
	<f0d2401d-95e5-75a3-6112-7ef3fc3f9113@virtuozzo.com>
	<e7ac8195-d017-304f-06f1-544ceb7b1bf4@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1b5187c2-60ec-832f-5708-1000f2fb6c8f@virtuozzo.com>
Date: Tue, 12 Dec 2017 19:49:06 +0300
MIME-Version: 1.0
In-Reply-To: <e7ac8195-d017-304f-06f1-544ceb7b1bf4@redhat.com>
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

12.12.2017 19:32, Eric Blake wrote:
> On 12/11/2017 09:24 AM, Vladimir Sementsov-Ogievskiy wrote:
>
>>> On the other hand, '<< BDRV_SECTOR_BITS' only produces the same size
>>> output as the input; if the left side is 32 bits, it risks overflowing.
>>> But '* BDRV_SECTOR_SIZE' always produces a 64-bit value.=C2=A0 So I've
>>> learned (from past mistakes in other byte-conversion series) that the
>>> multiply form is less likely to introduce unintended truncation bugs.
>> hm, now I doubt. I've wrote tiny program:
>>
>> #include <stdint.h>
>> #include <stdio.h>
>>
>> int main() {
>>  =C2=A0=C2=A0=C2=A0 uint32_t blocks =3D 1 << 20;
>>  =C2=A0=C2=A0=C2=A0 int block_bits =3D 15;
>>  =C2=A0=C2=A0=C2=A0 uint32_t block_size =3D 1 << block_bits;
>>  =C2=A0=C2=A0=C2=A0 uint64_t a =3D blocks * block_size;
>>  =C2=A0=C2=A0=C2=A0 uint64_t b =3D blocks << block_bits;
>>  =C2=A0=C2=A0=C2=A0 uint64_t c =3D (uint64_t)blocks * block_size;
> Not the same.  'block_size' in your code is 'uint32_t', so your
> multiplication is still 32-bit if you don't cast blocks; while qemu has::
>
> include/block/block.h:#define BDRV_SECTOR_BITS   9
> include/block/block.h:#define BDRV_SECTOR_SIZE   (1ULL << BDRV_SECTOR_BIT=
S)
>
> and the 1ULL in the qemu definition forces 'unsigned long long' results
> whether or not you cast.
>

Ah, cool, missed this. And we can't do such thing for BDRV_SECTOR_BITS=20
because it will be unspecified behavior.
Thank you for explanation.

--=20
Best regards,
Vladimir
