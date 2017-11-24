Received: from eggs.gnu.org ([2001:4830:134:3::10]:41049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eIFU0-0007YZ-Kb
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eIFTu-0000Ng-F7
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:01:36 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<01108daa-fed3-c142-bbd6-0ecc4c8b795d@redhat.com>
	<cd0a2e5e-f788-0e5a-dec7-f428479f3b89@virtuozzo.com>
	<8c61f43c-5f56-8c1b-a2fe-f954d34dc687@redhat.com>
	<ef42121a-fe94-adef-2bda-7c5db14de0c7@openvz.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <eafb7aee-d378-420e-6405-1a863b317723@virtuozzo.com>
Date: Fri, 24 Nov 2017 18:01:14 +0300
MIME-Version: 1.0
In-Reply-To: <ef42121a-fe94-adef-2bda-7c5db14de0c7@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, pbonzini@redhat.com

John, Kevin, do we reach a consensus? Can we go on with this?

20.11.2017 19:00, Denis V. Lunev wrote:
> On 11/17/2017 06:10 AM, John Snow wrote:
>> On 11/16/2017 03:17 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 16.11.2017 00:20, John Snow wrote:
>>>> On 11/13/2017 11:20 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Hi all.
>>>>>
>>>>> There are three qmp commands, needed to implement external backup API=
.
>>>>>
>>>>> Using these three commands, client may do all needed bitmap
>>>>> management by
>>>>> hand:
>>>>>
>>>>> on backup start we need to do a transaction:
>>>>>  =C2=A0 {disable old bitmap, create new bitmap}
>>>>>
>>>>> on backup success:
>>>>>  =C2=A0 drop old bitmap
>>>>>
>>>>> on backup fail:
>>>>>  =C2=A0 enable old bitmap
>>>>>  =C2=A0 merge new bitmap to old bitmap
>>>>>  =C2=A0 drop new bitmap
>>>>>
>>>> Can you give me an example of how you expect these commands to be used=
,
>>>> and why they're required?
>>>>
>>>> I'm a little weary about how error-prone these commands might be and t=
he
>>>> potential for incorrect usage seems... high. Why do we require them?
>>> It is needed for incremental backup. It looks like bad idea to export
>>> abdicate/reclaim functionality, it is simpler
>>> and clearer to allow user to merge/enable/disable bitmaps by hand.
>>>
>>> usage is like this:
>>>
>>> 1. we have dirty bitmap bitmap0 for incremental backup.
>>>
>>> 2. prepare image fleecing (create temporary image with backing=3Dour_di=
sk)
>>> 3. in qmp transaction:
>>>  =C2=A0=C2=A0=C2=A0 - disable bitmap0
>>>  =C2=A0=C2=A0=C2=A0 - create bitmap1
>>>  =C2=A0=C2=A0=C2=A0 - start image fleecing (backup sync=3Dnone our_disk=
 -> temp_disk)
>> This could probably just be its own command, though:
>>
>> block-job-fleece node=3Dfoobar bitmap=3Dbitmap0 etc=3Detera etc=3Detera
>>
>> Could handle forking the bitmap. I'm not sure what the arguments would
>> look like, but we could name the NBD export here, too. (Assuming the
>> server is already started and we just need to create the share.)
>>
>> Then, we can basically do what mirror does:
>>
>> (1) Cancel
>> (2) Complete
>>
>> Cancel would instruct QEMU to keep the bitmap changes (i.e. roll back),
>> and Complete would instruct QEMU to discard the changes.
>>
>> This way we don't need to expose commands like split or merge that will
>> almost always be dangerous to use over QMP.
>>
>> In fact, a fleecing job would be really convenient even without a
>> bitmap, because it'd still be nice to have a convenience command for it.
>> Using an existing infrastructure and understood paradigm is just a bonus=
.
>>
> actually this is a very good question about safety/simplicity...
>
> We actually have spent a bit of time on design and have not
> come to a good solution. Yes, technically for now we can put
> all into fleecing command and rely on its semantics. Though
> I am not convinced with that approach. We can think that this
> can be reused on snapshot operations (may be, may be not).
> Also technically there are other cases.
>
> This is actually a matter that QEMU should provide low level
> API while management software should make decisions.
> Providing merge etc operations is done using exactly that
> approach. We can also consider this in a similar way we have
> recently fixed "revert to snapshot" operation. Management
> can make and should make a decision.
>
> Den
>


--=20
Best regards,
Vladimir
