Received: from eggs.gnu.org ([2001:4830:134:3::10]:38357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJLzn-0001gL-BF
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJLzm-0000iV-DX
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:43:15 -0400
References: <20180512012537.22478-1-jsnow@redhat.com>
	<20180512012537.22478-7-jsnow@redhat.com>
	<7e72e02f-856b-520e-4499-fb4978dfa22b@virtuozzo.com>
	<0cf72eca-78bf-a20c-ad2c-e093f5b7936a@redhat.com>
	<b8c86fd5-3dfe-a298-e581-835014718e0c@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <20def908-c84a-c2be-89f8-b9f75c5bfd4c@redhat.com>
Date: Thu, 17 May 2018 12:43:08 -0400
MIME-Version: 1.0
In-Reply-To: <b8c86fd5-3dfe-a298-e581-835014718e0c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 06/12] qapi: add bitmap info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 05/17/2018 06:01 AM, Vladimir Sementsov-Ogievskiy wrote:
> 17.05.2018 00:15, John Snow wrote:
>>
>> On 05/14/2018 10:30 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 12.05.2018 04:25, John Snow wrote:
>>>> Add some of the necessary scaffolding for reporting bitmap informati=
on.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>> =C2=A0=C2=A0 qapi/block-core.json | 60
>>>> +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>> =C2=A0=C2=A0 1 file changed, 59 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index c50517bff3..8f33f41ce7 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -33,6 +33,61 @@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 'date-sec': 'int', 'date-nsec': 'int',
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 'vm-clock-sec': 'int', 'vm-clock-nsec': 'int' } }
>>>> =C2=A0=C2=A0 +##
>>>> +# @BitmapTypeEnum:
>>>> +#
>>>> +# An enumeration of possible serialized bitmap types.
>>>> +#
>>>> +# @dirty-tracking: This bitmap records information on dirty
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 segments within the file.
>>>> +#
>>>> +# @unknown: This bitmap is of an unknown or reserved type.
>>>> +#
>>>> +# Since: 2.13
>>>> +##
>>>> +{ 'enum': 'BitmapTypeEnum', 'data': [ 'dirty-tracking', 'unknown' ]=
 }
>>>> +
>>>> +##
>>>> +# @BitmapFlagEnum:
>>>> +#
>>>> +# An enumeration of possible flags for serialized bitmaps.
>>>> +#
>>>> +# @in-use: This bitmap is considered to be in-use, and may now be
>>>> inconsistent.
>>>> +#
>>>> +# @auto: This bitmap must reflect any and all changes to the file i=
t
>>>> describes.
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The type of this bitmap=
 must be @DirtyTrackingBitmap.
>>> logical, but I don't see this restriction in the spec. May be we need=
 to
>>> update the spec
>>>
>> 1: auto
>>
>> "The bitmap must reflect all changes of the virtual disk by any
>> application that would write to this qcow2 file (including writes,
>> snapshot switching, etc.). The type of this bitmap must be 'dirty
>> tracking bitmap'."
>>
>> Actually, this looks correct now that I'm looking at the spec again.
>> I've used a terser phrasing but I think it's correct.
>=20
> another thought: why must? We know nothing about other types.. May be
> for other type this flag will have similar or other meaning.. For me,
> this flag looks like a property of dirty-tracking bitmap, not the thing
> which dictates only that type.
>=20

Yeah, there may be other kinds that want this behavior. The restriction
can probably be eliminated from the spec, I think, but that's to be
handled outside of this series.

I'll remove the restriction from the QAPI flag, because what "should" or
"must" happen is not relevant to what _is_ happening. :)

--js
