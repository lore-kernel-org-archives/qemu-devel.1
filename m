Received: from eggs.gnu.org ([2001:4830:134:3::10]:33631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g0uJj-0003Jl-Jd
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 16:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g0uJi-0000t0-Nc
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 16:03:51 -0400
References: <20180814121443.33114-1-vsementsov@virtuozzo.com>
	<20180814121443.33114-2-vsementsov@virtuozzo.com>
	<954db07e-d338-9cd4-341f-d8916470b89b@redhat.com>
	<443e612e-399b-7bf9-9379-cfa6ea516dfb@virtuozzo.com>
	<f50d72a0-7fa7-d2b9-3010-2e9ad10a574b@redhat.com>
	<0f8ecd93-3320-99aa-44aa-c8b11717c784@virtuozzo.com>
	<4f44be05-0756-9966-9f2c-83a8e0f644a8@redhat.com>
	<9c32d9a3-e171-0173-f6be-e1b10fb2c439@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <33ae4d31-6b43-cea9-9442-cf41c0f14aec@redhat.com>
Date: Fri, 14 Sep 2018 16:03:33 -0400
MIME-Version: 1.0
In-Reply-To: <9c32d9a3-e171-0173-f6be-e1b10fb2c439@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/8] dirty-bitmap: improve
 bdrv_dirty_bitmap_next_zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org



On 09/14/2018 01:51 PM, Vladimir Sementsov-Ogievskiy wrote:
> 14.09.2018 20:39, John Snow wrote:
>>
>> On 09/10/2018 01:00 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> 10.09.2018 19:55, Eric Blake wrote:
>>>> On 9/10/18 11:49 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>
>>>>>>> -int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start);
>>>>>>> +int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start,
>>>>>>> int64_t end);
>>>>>> The interface looks weird because we can define a 'start' that's
>>>>>> beyond
>>>>>> the 'end'.
>>>>>>
>>>>>> I realize that you need a signed integer for 'end' to signify EOF.=
..
>>>>>> should we do a 'bytes' parameter instead? (Did you already do that
>>>>>> in an
>>>>>> earlier version and we changed it?)
>>>>>>
>>>>>> Well, it's not a big deal to me personally.
>>>>> interface with constant end parameter is more comfortable for loop:
>>>>> we don't need to update 'bytes' parameter on each iteration
>>>> But there's still the question of WHO should be calculating end. You=
r
>>>> interface argues for the caller:
>>>>
>>>> hbitmap_next_zero(start, start + bytes)
>>>>
>>>> int64_t hbitmap_next_zero(...)
>>>> {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 while (offset !=3D end) ...
>>>> }
>>>>
>>>> while we're asking about a consistent interface for the caller (if
>>>> most callers already have a 'bytes' rather than an 'end' computed):
>>>>
>>>> hbitmap_next_zero(start, bytes)
>>>>
>>>> int64_t hbitmap_next_zero(...)
>>>> {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 int64_t end =3D start + bytes;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 while (offset !=3D end) ...
>>>> }
>>>>
>>> Yes, that's an issue. Ok, if you are not comfortable with start,end, =
I
>>> can switch to start,bytes.
>>>
>> The series looks pretty close, I can merge the next version if you thi=
nk
>> it's worth changing the interface.
>>
>> --js
>=20
> I've started to change interface and found a bug in bitmap_to_extents
> (patch sent
> https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg01804.html).
> So, next version will be based on this patch, which will go through
> Eric's tree..
>=20

OK, I spoke with Eric and if you resend and I R-B & ACK the patches,
he'll stage them through NBD.

Thanks,
--js
