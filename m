Received: from eggs.gnu.org ([2001:4830:134:3::10]:60402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dekPJ-0003ZN-Bh
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dekPE-0000pu-Fd
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:57:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20170807141630.105066-1-vsementsov@virtuozzo.com>
	<9a27b8cf-f149-cb7c-681d-f4f7249bfbd5@redhat.com>
	<5eca1bca-59cc-2d63-1413-0e3b87ebcb80@virtuozzo.com>
Message-ID: <eedd0b75-c651-3902-4ba2-b8079da1b1a9@virtuozzo.com>
Date: Mon, 7 Aug 2017 18:57:20 +0300
MIME-Version: 1.0
In-Reply-To: <5eca1bca-59cc-2d63-1413-0e3b87ebcb80@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-2.10] iotests: fix 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com

07.08.2017 18:46, Vladimir Sementsov-Ogievskiy wrote:
> 07.08.2017 17:29, Eric Blake wrote:
>> On 08/07/2017 09:16 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 185 iotest is broken.
>>>
>>> How to test:
>>>> i=0; while ./check -qcow2 -nocache 185; do ((i+=1)); echo N = $i; \
>>>    done; echo N = $i
>>>
>>> finished for me like this:
>>>
>>> 185 2s ... - output mismatch (see 185.out.bad)
>>> --- /work/src/qemu/master/tests/qemu-iotests/185.out 2017-07-14 \
>>>      15:14:29.520343805 +0300
>>> +++ 185.out.bad 2017-08-07 16:51:02.231922900 +0300
>>> @@ -37,7 +37,7 @@
>>>   {"return": {}}
>>>   {"return": {}}
>>>   {"timestamp": {"seconds":  TIMESTAMP, "microseconds": TIMESTAMP}, \
>>>       "event": "SHUTDOWN", "data": {"guest": false}}
>>> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds": TIMESTAMP}, \
>>>      "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", \
>>>          "len": 4194304, "offset": 4194304, "speed": 65536, "type": \
>>>              "mirror"}}
>>> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds": TIMESTAMP}, \
>>>      "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", \
>>>          "len": 0, "offset": 0, "speed": 65536, "type": "mirror"}}
>> This diff says both 'len' and 'offset' differ...
>>
>>>   === Start backup job and exit qemu ===
>>>
>>> Failures: 185
>>> Failed 1 of 1 tests
>>> N = 8
>>>
>>> It doesn't seems logical to expect the constant offset on cancel,
>>> so let filter it out.
>> s/let/let's/
>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   tests/qemu-iotests/185     | 2 +-
>>>   tests/qemu-iotests/185.out | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds": TIMESTAMP}, 
>>> "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 
>>> 4194304, "offset": 4194304, "speed": 65536, "type": "mirror"}}
>>> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds": TIMESTAMP}, 
>>> "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 
>>> 4194304, "offset": OFFSET, "speed": 65536, "type": "mirror"}}
>> ...while this diff only touched 'offset'.  Did you copy-and-paste
>> incorrectly in the commit message?  If so, then with the commit message
>> fixed, I'm okay with:
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
> Hmm, I can't reproduce with "len = 0", and it looks impossible. But 
> I've scrolled up in one of my terminals and found this reproduce, 
> really, '"len": 0', so, that is possible.
>
> And, after looking through the code it looks like it really possible - 
> s->common.len is set not in the very beginning, but after for ex. call 
> to block_job_pause_point().
>
> So, the reproduction that I've copied into commit message was very 
> good match.
>
> But, I'm not sure, that len should be fixed in the same way. May be it 
> would be better to set earlier and don't update on each iteration (why 
> is it updated??)
>
>

So, IMHO, this patch is good (with s/"len": 0/"len": 4194304/ and 
s/let/let's/ in commit message)


-- 
Best regards,
Vladimir
