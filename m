Received: from eggs.gnu.org ([2001:4830:134:3::10]:56359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dgDVi-0000po-6I
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 13:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dgDVg-00046Z-K6
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 13:14:10 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:41236
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dgDVg-00045i-A9
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 13:14:08 -0400
References: <20170811140628.31935-1-f4bug@amsat.org>
	<bd1e9b06-56fd-fed0-e19b-c8a0c036c58c@redhat.com>
	<3bca0f5d-1daf-fff3-4002-9671adf29d6a@amsat.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <e218b688-01ac-2ec7-5a3f-60d22d163eef@adacore.com>
Date: Fri, 11 Aug 2017 19:13:38 +0200
MIME-Version: 1.0
In-Reply-To: <3bca0f5d-1daf-fff3-4002-9671adf29d6a@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] memory: fix
 access_with_adjusted_size() on big-endian
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, qemu-devel@nongnu.org

Hi Philippe,

Thanks for that, I'll try this out when I'm back. The 15th is
blank holiday here.

Thanks,
Fred

On 08/11/2017 04:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 08/11/2017 11:25 AM, Paolo Bonzini wrote:
>> On 11/08/2017 16:06, Philippe Mathieu-Daud=C3=A9 wrote:
>>> remove unnecessary memory_region_big_endian()
>>
>> Can you explain why it's unnecessary?...
>=20
> I might have missed a lot here, I'm focusing on something else=20
> and thought this might help Frederic so I only cherry-picked this=20
> patch from a bigger series, since I memory_region_big_endian() is=20
> static/unused I just dropped it, which is surely wrong.
>=20
> I see in this series I then call "adjust_endianness(mr, value,=20
> size)" before returning. And then lot of unit-tests to understand=20
> failures I'm having accessing PCI bus on armeb.
>=20
> This branch is few months old and I'm out of context, I shouldn't=20
> have rushed to send this patch, I'll try to get some time during=20
> the week-end to remember.
>=20
> Cheers,
>=20
> Phil.
>=20
>>
>> Paolo
>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>> This is part of a branch with many cross-endianness tests for=20
>>> 2.11
>>>
>>> Frederic does it helps your issues on armeb?
>>>
>>>   memory.c | 28 ++++++++++------------------
>>>   1 file changed, 10 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/memory.c b/memory.c
>>> index c0adc35410..600f5d5b1a 100644
>>> --- a/memory.c
>>> +++ b/memory.c
>>> @@ -338,15 +338,6 @@ static void flatview_simplify(FlatView=20
>>> *view)
>>>       }
>>>   }
>>> -static bool memory_region_big_endian(MemoryRegion *mr)
>>> -{
>>> -#ifdef TARGET_WORDS_BIGENDIAN
>>> -    return mr->ops->endianness !=3D DEVICE_LITTLE_ENDIAN;
>>> -#else
>>> -    return mr->ops->endianness =3D=3D DEVICE_BIG_ENDIAN;
>>> -#endif
>>> -}
>>> -
>>>   static bool memory_region_wrong_endianness(MemoryRegion *mr)
>>>   {
>>>   #ifdef TARGET_WORDS_BIGENDIAN
>>> @@ -572,7 +563,8 @@ static MemTxResult=20
>>> access_with_adjusted_size(hwaddr addr,
>>>   {
>>>       uint64_t access_mask;
>>>       unsigned access_size;
>>> -    unsigned i;
>>> +    hwaddr access_addr;
>>> +    unsigned offset;
>>>       MemTxResult r =3D MEMTX_OK;
>>>       if (!access_size_min) {
>>> @@ -585,17 +577,17 @@ static MemTxResult=20
>>> access_with_adjusted_size(hwaddr addr,
>>>       /* FIXME: support unaligned access? */
>>>       access_size =3D MAX(MIN(size, access_size_max),=20
>>> access_size_min);
>>>       access_mask =3D -1ULL >> (64 - access_size * 8);
>>> -    if (memory_region_big_endian(mr)) {
>>> -        for (i =3D 0; i < size; i +=3D access_size) {
>>> -            r |=3D access(mr, addr + i, value, access_size,
>>> -                        (size - access_size - i) * 8,=20
>>> access_mask, attrs);
>>> +    access_addr =3D addr & ~(access_size - 1);
>>> +    if (access_size < size) {
>>> +        for (offset =3D 0; offset < size; offset +=3D access_size) {
>>> +            r |=3D access(mr, access_addr + offset, value,=20
>>> access_size,
>>> +                        offset * 8, access_mask, attrs);
>>>           }
>>>       } else {
>>> -        for (i =3D 0; i < size; i +=3D access_size) {
>>> -            r |=3D access(mr, addr + i, value, access_size, i * 8,
>>> -                        access_mask, attrs);
>>> -        }
>>> +        r =3D access(mr, access_addr, value, access_size,
>>> +                    0, access_mask, attrs);
>>>       }
>>> +
>>>       return r;
>>>   }
>>>
>>
