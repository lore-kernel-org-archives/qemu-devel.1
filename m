Received: from eggs.gnu.org ([2001:4830:134:3::10]:51735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1fkxh5-0003iT-DI
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 16:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1fkxh4-0007M9-74
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 16:26:03 -0400
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
	<20180626135035.133432-5-vsementsov@virtuozzo.com>
	<700dffe4-f3a8-8f70-052c-9f6f8ffbe3d3@redhat.com>
	<20180801102031.GC2691@work-vm>
	<64aad02b-3d5c-70d6-0f5a-93dd5b88e4bc@redhat.com>
	<20180801174005.GD2691@work-vm>
	<cbdecba1-925c-5f6e-bf3c-a27cc4d944da@openvz.org>
	<20180801185515.GE2691@work-vm>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <6bfdc952-fb17-feae-f367-be710853d829@openvz.org>
Date: Wed, 1 Aug 2018 23:25:47 +0300
MIME-Version: 1.0
In-Reply-To: <20180801185515.GE2691@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, quintela@redhat.com, stefanha@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, Eric Blake <eblake@redhat.com>

On 08/01/2018 09:55 PM, Dr. David Alan Gilbert wrote:
> * Denis V. Lunev (den@openvz.org) wrote:
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
>>>>> always worry a little since I think this happens after we've stopped the
>>>>> CPU on the source, so is part of the 'downtime'.
>>>>>
>>>>> Dave
>>>>> --
>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>>>
>>>> I'm worried that if we don't, we're leaving behind unusable, partially
>>>> complete files behind us. That's a bad design and we shouldn't push for
>>>> it just because it's theoretically faster.
>>> Oh I don't care about theoretical speed; but if it's actually unusably
>>> slow in practice then it needs fixing.
>>>
>>> Dave
>> This is not "theoretical" speed. This is real practical speed and
>> instability.
>> EACH IO operation can be performed unpredictably slow and thus with
>> IO operations in mind you can not even calculate or predict downtime,
>> which should be done according to the migration protocol.
> We end up doing some IO anyway, even ignoring these new bitmaps,
> at the end of the migration when we pause the CPU, we do a
> bdrv_inactivate_all to flush any outstanding writes; so we've already
> got that unpredictable slowness.
>
> So, not being a block person, but with some interest in making sure
> downtime doesn't increase, I just wanted to understand whether the
> amount of writes we're talking about here is comparable to that
> which already exists or a lot smaller or a lot larger.
> If the amount of IO you're talking about is much smaller than what
> we typically already do, then John has a point and you may as well
> do the write.
> If the amount of IO for the bitmap is much larger and would slow
> the downtime a lot then you've got a point and that would be unworkable.
>
> Dave
This is not theoretical difference.

For 1 Tb drive and 64 kb bitmap granularity the size of bitmap is
2 Mb + some metadata (64 Kb). Thus we will have to write
2 Mb of data per bitmap. For some case there are 2-3-5 bitmaps
this we will have 10 Mb of data. With 16 Tb drive the amount of
data to write will be multiplied by 16 which gives 160 Mb to
write. More disks and bigger the size - more data to write.

Above amount should be multiplied by 2 - x Mb to be written
on source, x Mb to be read on target which gives 320 Mb to
write.

That is why this is not good - we have linear increase with the
size and amount of disks.

There is also some thoughts on normal guest IO. Theoretically
we can think on replaying IO on the target closing the file
immediately or block writes to changed areas and notify
target upon IO completion or invent other fancy dances.
At least we think right now on these optimizations for regular
migration paths.

The problem right that such things are not needed now for CBT
but will become necessary and pretty much useless upon
introducing this stuff.

Den
