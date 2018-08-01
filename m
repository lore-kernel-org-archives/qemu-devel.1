Received: from eggs.gnu.org ([2001:4830:134:3::10]:33627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1fky22-0002VI-Hg
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 16:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1fky21-0008Nm-Ct
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 16:47:42 -0400
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
	<20180626135035.133432-5-vsementsov@virtuozzo.com>
	<700dffe4-f3a8-8f70-052c-9f6f8ffbe3d3@redhat.com>
	<20180801102031.GC2691@work-vm>
	<64aad02b-3d5c-70d6-0f5a-93dd5b88e4bc@redhat.com>
	<20180801174005.GD2691@work-vm>
	<cbdecba1-925c-5f6e-bf3c-a27cc4d944da@openvz.org>
	<e200102e-f5ae-3dae-42b1-b9f98d92fc46@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <30c90ae6-b747-7da8-9f9c-93511fd95a7b@openvz.org>
Date: Wed, 1 Aug 2018 23:47:31 +0300
MIME-Version: 1.0
In-Reply-To: <e200102e-f5ae-3dae-42b1-b9f98d92fc46@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 4/6] dirty-bitmaps: clean-up bitmaps
 loading and migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, quintela@redhat.com, stefanha@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, Eric Blake <eblake@redhat.com>

On 08/01/2018 09:56 PM, John Snow wrote:
>
> On 08/01/2018 02:42 PM, Denis V. Lunev wrote:
>> On 08/01/2018 08:40 PM, Dr. David Alan Gilbert wrote:
>>> * John Snow (jsnow@redhat.com) wrote:
>>>> On 08/01/2018 06:20 AM, Dr. David Alan Gilbert wrote:
>>>>> * John Snow (jsnow@redhat.com) wrote:
>>>>>
>>>>> <snip>
>>>>>
>>>>>> I'd rather do something like this:
>>>>>> - Always flush bitmaps to disk on inactivate.
>>>>> Does that increase the time taken by the inactivate measurably?
>>>>> If it's small relative to everything else that's fine; it's just I
>>>>> always worry a little since I think this happens after we've stopped =
the
>>>>> CPU on the source, so is part of the 'downtime'.
>>>>>
>>>>> Dave
>>>>> --
>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>>>
>>>> I'm worried that if we don't, we're leaving behind unusable, partially
>>>> complete files behind us. That's a bad design and we shouldn't push fo=
r
>>>> it just because it's theoretically faster.
>>> Oh I don't care about theoretical speed; but if it's actually unusably
>>> slow in practice then it needs fixing.
>>>
>>> Dave
>> This is not "theoretical" speed. This is real practical speed and
>> instability.
> It's theoretical until I see performance testing numbers; do you have
> any? How much faster does the pivot happen by avoiding making the qcow2
> consistent on close?
>
> I don't argue that it's faster to just simply not write data, but what's
> not obvious is how much time it actually saves in practice and if that's
> worth doing unintuitive and undocumented things like "the source file
> loses bitmaps after a migration because it was faster."

Also, frankly speaking, I do not understand the goal of this purism.

There 2 main cases - shared and non-shared storage. On shared
storage:
- normally migration is finished successfully. Source is shut down,
=C2=A0 target is started. The data in the file on shared storage would be
=C2=A0 __IMMEDIATELY__ marked as stale on target, i.e. you will save CBT
=C2=A0on source (with IO over networked fs), load CBT on target (with IO
=C2=A0over networked FS), mark CBT as stale (IO again). CBT data written
=C2=A0is marked as lost
- failed migration. OK, we have CBT data written on source, CBT
=C2=A0 data read on source, CBT data marked stale. Thus any CBT on
=C2=A0 disk while VM is running is pure overhead.

The same situation is when we use non-shared migration. In this
case the situation is even worse. You save CBT and put it to trash
upon migration complete.

Please also note, that CBT saving almost does not protect us
from powerlosses as the power should be lost at the very
specific moment to allow data to survive and most likely
we will have to drop CBT completely.

Den

Normally migration is executed as follows:
- source is gently shutdowned, all da
