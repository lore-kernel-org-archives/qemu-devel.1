Received: from eggs.gnu.org ([2001:4830:134:3::10]:42843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1df1bW-0005lQ-Dh
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1df1bS-0001fT-HH
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:19:14 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20170807141630.105066-1-vsementsov@virtuozzo.com>
	<20170807155717.GI6578@localhost.localdomain>
	<692a163e-acce-e594-896d-da96b7a099e9@virtuozzo.com>
	<20170808085352.GF4850@dhcp-200-186.str.redhat.com>
	<896f8482-6e3a-13e9-4cce-ca115a6c8881@virtuozzo.com>
	<645f5e9d-6a4b-1d7b-6907-6ab27e1ffa7e@virtuozzo.com>
Message-ID: <47c5f963-070d-b9a1-aaab-60dfbe484a66@virtuozzo.com>
Date: Tue, 8 Aug 2017 13:18:28 +0300
MIME-Version: 1.0
In-Reply-To: <645f5e9d-6a4b-1d7b-6907-6ab27e1ffa7e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com

08.08.2017 12:04, Vladimir Sementsov-Ogievskiy wrote:
> 08.08.2017 12:04, Vladimir Sementsov-Ogievskiy wrote:
>> 08.08.2017 11:53, Kevin Wolf wrote:
>>> Am 08.08.2017 um 10:42 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> 07.08.2017 18:57, Kevin Wolf wrote:
>>>>> Am 07.08.2017 um 16:16 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>>>> 185 iotest is broken.
>>>>>>
>>>>>> How to test:
>>>>>>> i=0; while ./check -qcow2 -nocache 185; do ((i+=1)); echo N = $i; \
>>>>>>     done; echo N = $i
>>>>>>
>>>>>> finished for me like this:
>>>>>>
>>>>>> 185 2s ... - output mismatch (see 185.out.bad)
>>>>>> --- /work/src/qemu/master/tests/qemu-iotests/185.out 2017-07-14 \
>>>>>>       15:14:29.520343805 +0300
>>>>>> +++ 185.out.bad 2017-08-07 16:51:02.231922900 +0300
>>>>>> @@ -37,7 +37,7 @@
>>>>>>    {"return": {}}
>>>>>>    {"return": {}}
>>>>>>    {"timestamp": {"seconds":  TIMESTAMP, "microseconds": 
>>>>>> TIMESTAMP}, \
>>>>>>        "event": "SHUTDOWN", "data": {"guest": false}}
>>>>>> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds": TIMESTAMP}, \
>>>>>>       "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", \
>>>>>>           "len": 4194304, "offset": 4194304, "speed": 65536, 
>>>>>> "type": \
>>>>>>               "mirror"}}
>>>>>> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds": TIMESTAMP}, \
>>>>>>       "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", \
>>>>>>           "len": 0, "offset": 0, "speed": 65536, "type": "mirror"}}
>>>>>>
>>>>>>    === Start backup job and exit qemu ===
>>>>>>
>>>>>> Failures: 185
>>>>>> Failed 1 of 1 tests
>>>>>> N = 8
>>>>>>
>>>>>> It doesn't seems logical to expect the constant offset on cancel,
>>>>>> so let filter it out.
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy 
>>>>>> <vsementsov@virtuozzo.com>
>>>>> I'm quoting 185:
>>>>>
>>>>> # Note that the reference output intentionally includes the 
>>>>> 'offset' field in
>>>>> # BLOCK_JOB_CANCELLED events for all of the following block jobs. 
>>>>> They are
>>>>> # predictable and any change in the offsets would hint at a bug in 
>>>>> the job
>>>>> # throttling code.
>>>>> #
>>>>> # In order to achieve these predictable offsets, all of the 
>>>>> following tests
>>>>> # use speed=65536. Each job will perform exactly one iteration 
>>>>> before it has
>>>>> # to sleep at least for a second, which is plenty of time for the 
>>>>> 'quit' QMP
>>>>> # command to be received (after receiving the command, the rest runs
>>>>> # synchronously, so jobs can arbitrarily continue or complete).
>>>>> #
>>>>> # The buffer size for commit and streaming is 512k (waiting for 8 
>>>>> seconds after
>>>>> # the first request), for active commit and mirror it's large 
>>>>> enough to cover
>>>>> # the full 4M, and for backup it's the qcow2 cluster size, which 
>>>>> we know is
>>>>> # 64k. As all of these are at least as large as the speed, we are 
>>>>> sure that the
>>>>> # offset doesn't advance after the first iteration before qemu exits.
>>>>>
>>>>> So before we change the expected output, can we explain why the 
>>>>> offsets
>>>>> aren't predictable, even if throttling is used and contrary to 
>>>>> what the
>>>>> comment says? Should we sleep a little before issuing 'quit'?
>>>> Throttling "guaranties" that there will not be more than one 
>>>> request. But
>>>> what prevent less than one, i.e. zero, like in my reproduction?
>>> Yes, I understand. Can we somehow make sure that at least one iteration
>>> is made? I'd really like to keep the functional test for block job
>>> throttling. I suppose a simple 'sleep 0.1' would do the trick, though
>>> it's not very clean.
>>>
>>> Kevin
>>
>>
>> I've started with 'sleep 0.5', now there are >100 successful 
>> iterations... The other way is to check in test that there was 0 or 1 
>> requests, but for this it looks better to rewrite it in python.
>>
>>
>
> is sleep for ms portable?
>
>
>
 >1500 successful iterations, so, 'sleep 0.5' is OK for me.


-- 
Best regards,
Vladimir
