Received: from eggs.gnu.org ([2001:4830:134:3::10]:37619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1cYcUZ-0003uw-Ef
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 12:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1cYcUU-0003Pm-E9
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 12:45:19 -0500
Received: from mail-db5eur01on0110.outbound.protection.outlook.com
	([104.47.2.110]:17443
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1cYcUT-0003O5-Fe
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 12:45:14 -0500
References: <1485771730-19849-1-git-send-email-den@openvz.org>
	<33cf3518-bf30-88fa-5fb5-17d9ddff503d@redhat.com>
	<2cc9d5f9-9a3c-dc90-d377-8cc676f4f147@openvz.org>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <8d326fdc-3f45-afcd-3cbb-962eed9fd8c5@virtuozzo.com>
Date: Mon, 30 Jan 2017 21:10:08 +0300
MIME-Version: 1.0
In-Reply-To: <2cc9d5f9-9a3c-dc90-d377-8cc676f4f147@openvz.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] mirror: restore offset after zeroing
 out the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, eblake@redhat.com, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, mreitz@redhat.com

On 01/30/2017 08:33 PM, Denis V. Lunev wrote:
> On 01/30/2017 08:16 PM, Eric Blake wrote:
>> On 01/30/2017 04:22 AM, Denis V. Lunev wrote:
>>> If explicit zeroing out before mirroring is required for the target image,
>>> it moves the block job offset counter to EOF, then offset and len counters
>>> count the image size twice.
>>>
>>> There is no harm but confusing stats (e.g. for 1G image the completion
>>> counter starts from 1G and increases to 2G)
>>>
>>> The patch fixed that problem by resetting the offset counter.
>> Counters are explicitly documented NOT tied to disk length; they are
>> merely estimates of proportional completion.  I'm not sure if this makes
>> the numbers jump backwards from the observer's viewpoint, but if you can
>> ever spot 1g/1g right before rewinding to 0g/1g (where pre-patch could
>> see 1g/2g), then that is a reason to not take this patch.

FWIW you'll actually see 1g/0g first (if you happen to catch that tiny 
phase :)

>> On the other
>> hand, your argument that the pre-patch behavior progressing towards 2g
>> has a very fast progression from 0-1g/2g, and then a much slower
>> 1g-2g/2g, which makes the estimate of percent completion skewed, while a
>> newer progression of 0-1g/1g is more realistic, may have some merit.
>>
>> I'm not sold on this patch yet, but stronger arguments in the commit
>> message may sway me.
>>
>>> +++ b/tests/qemu-iotests/094.out
>>> @@ -3,9 +3,9 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>>>  Formatting 'TEST_DIR/source.IMGFMT', fmt=IMGFMT size=67108864
>>>  {"return": {}}
>>>  {"return": {}}
>>> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}}
>>> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 0, "offset": 0, "speed": 0, "type": "mirror"}}
>>>  {"return": {}}
>> This part of the change is scary - a ready event showing 0/0 HAS been
>> known to confuse libvirt in the past.  Qemu should NEVER advertise a
>> ready event with 0/0, it should at least be 1/1 (because of the number
>> of clients that have workarounds to deal with older qemu behavior on 0/0
>> and which might misbehave if we ever issue that again).

I think this 094.out modification is not needed and actually breaks the 
test; apologies

>>
>>> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}}
>>> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 0, "offset": 0, "speed": 0, "type": "mirror"}}
>> So NACK to the patch as currently written, but not necessarily to the
>> idea if you can give better progress numbers and never reach the state
>> of BLOCK_JOB_READY and BLOCK_JOB_COMPLETED with a 0/0 length/offset.
>>
> ok. fair enough. Thank you for the review.
>
> Will it be better to (somehow) skip progressing below using
> some condition during mirror_dirty_init() stage?
>
> static void mirror_iteration_done(MirrorOp *op, int ret)
> {
>     .....
>
>     if (ret >= 0) {
>         if (s->cow_bitmap) {
>             bitmap_set(s->cow_bitmap, chunk_num, nb_chunks);
>         }
>         s->common.offset += (uint64_t)op->nb_sectors * BDRV_SECTOR_SIZE;
> <---- specifically this progressing
>     }
>
Isn't this going to look quite too invasive for such cause

-- 
best regards,
Anton
