Received: from eggs.gnu.org ([2001:4830:134:3::10]:41128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fnPWI-0007n6-AX
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fnPWC-0002o8-6Q
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:33:02 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
	<20180618164504.24488-22-kwolf@redhat.com>
	<fd4b2077-448f-2b62-8880-b2a3dcca586a@redhat.com>
	<28f44beb-e19b-3e26-254a-4678eacf30c2@redhat.com>
	<bfd7fd9e-11ad-3aa3-68b8-b9b46df36f1a@virtuozzo.com>
Message-ID: <20070601-f5e0-6433-e266-823341d09634@virtuozzo.com>
Date: Wed, 8 Aug 2018 17:32:23 +0300
MIME-Version: 1.0
In-Reply-To: <bfd7fd9e-11ad-3aa3-68b8-b9b46df36f1a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PULL 21/35] block: fix QEMU crash with scsi-hd
 and drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

08.08.2018 12:33, Vladimir Sementsov-Ogievskiy wrote:
> 07.08.2018 22:57, Eric Blake wrote:
>> On 08/06/2018 05:04 PM, Eric Blake wrote:
>>> On 06/18/2018 11:44 AM, Kevin Wolf wrote:
>>>> From: Greg Kurz <groug@kaod.org>
>>>>
>>>> Removing a drive with drive_del while it is being used to run an I/O
>>>> intensive workload can cause QEMU to crash.
>>>>
>>> ...
>>
>>>
>>> Test 83 sets up a client that intentionally disconnects at critical=20
>>> points in the NBD protocol exchange, to ensure that the server=20
>>> reacts sanely.
>>
>> Rather, nbd-fault-injector.py is a server that disconnects at=20
>> critical points, and the test is of client reaction.
>>
>>> =C2=A0 I suspect that somewhere in the NBD code, the server detects the=
=20
>>> disconnect and was somehow calling into blk_remove_bs() (although I=20
>>> could not quickly find the backtrace); and that prior to this patch,=20
>>> the 'Connection closed' message resulted from other NBD coroutines=20
>>> getting a shot at the (now-closed) connection, while after this=20
>>> patch, the additional blk_drain() somehow tweaks things in a way=20
>>> that prevents the other NBD coroutines from printing a message.=C2=A0 I=
f=20
>>> so, then the change in 83 reference output is probably intentional,=20
>>> and we should update it.
>>
>> It seems like this condition is racy, and that the race is more=20
>> likely to be lost prior to this patch than after. It's a question of=20
>> whether the client has time to start a request to the server prior to=20
>> the server hanging up, as the message is generated during=20
>> nbd_co_do_receive_one_chunk.=C2=A0 Here's a demonstration of the fact th=
at=20
>> things are racy:
>>
>> $ git revert f45280cbf
>> $ make
>> $ cd tests/qemu-iotests
>> $ cat fault.txt
>> [inject-error "a"]
>> event=3Dneg2
>> when=3Dafter
>> $ python nbd-fault-injector.py localhost:10809 ./fault.txt &
>> Listening on 127.0.0.1:10809
>> $ ../../qemu-io -f raw nbd://localhost:10809 -c 'r 0 512'
>> Closing connection on rule match inject-error "a"
>> Connection closed
>> read failed: Input/output error
>> $ python nbd-fault-injector.py localhost:10809 ./fault.txt &
>> Listening on 127.0.0.1:10809
>> $ ../../qemu-io -f raw nbd://localhost:10809
>> Closing connection on rule match inject-error "a"
>> qemu-io> r 0 512
>> read failed: Input/output error
>> qemu-io> q
>>
>> So, depending on whether the read command is kicked off quickly (via=20
>> -c) or slowly (via typing into qemu-io) determines whether the=20
>> message appears.
>>
>> What's more, in commit f140e300, we specifically called out in the=20
>> commit message that maybe it was better to trace when we detect=20
>> connection closed rather than log it to stdout, and in all cases in=20
>> that commit, the additional 'Connection closed' messages do not add=20
>> any information to the error message already displayed by the rest of=20
>> the code.
>>
>> I don't know how much the proposed NBD reconnect code will change=20
>> things in 3.1.=C2=A0 Meanwhile, we've missed any chance for 3.0 to fix=20
>> test 83.
>>
>>>
>>> But I'm having a hard time convincing myself that this is the case,=20
>>> particularly since I'm not even sure how to easily debug the=20
>>> assumptions I made above.
>>>
>>> Since I'm very weak on the whole notion of what blk_drain() vs.=20
>>> blk_remove_bs() is really supposed to be doing, and could easily be=20
>>> persuaded that the change in output is a regression instead of a fix.
>>
>> At this point, I don't think we have a regression, just merely a bad=20
>> iotests reference output. The extra blk_drain() merely adds more time=20
>> before the NBD code can send out its first request, and thus makes it=20
>> more likely that the fault injector has closed the connection before=20
>> the read request is issued rather than after (the message only=20
>> appears when read beats the race), but the NBD code shouldn't be=20
>> printing the error message in the first place, and 083 needs to be=20
>> tweaked to remove the noisy lines added in f140e300 (not just the=20
>> three lines that are reliably different due to this patch, but all=20
>> other such lines due to strategic server drops at other points in the=20
>> NBD protocol).
>>
>
> Ok, agree, I'll do it in reconnect series.
>


hmm, do what?

I was going to change these error messages to be traces, but now I'm not=20
sure that it's a good idea. We have generic errp returned from the=20
function, and why to drop it from logs? Fixing iotest is not a good=20
reason, better is to adjust iotest itself a bit (just commit changed=20
output) and forget about it. Is iotest racy itself, did you see=20
different output running 83 iotest, not testing by hand?

--=20
Best regards,
Vladimir
