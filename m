Received: from eggs.gnu.org ([2001:4830:134:3::10]:47142)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dv0or-0001iZ-Q3
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dv0ol-0000pm-Rm
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:43:05 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:59292 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dv0ol-0000oY-Ib
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:42:59 -0400
References: <6cc4a99c-0212-6b7b-4a12-3e898215bea9@kamp.de>
	<20170919143829.GH2107@work-vm>
	<48cdd8ff-4940-9aa1-9aba-1acf8ce74ebe@kamp.de>
	<20170919144130.GI2107@work-vm>
	<a271a2f8-173e-45c8-bd64-16f4963b3518@kamp.de>
	<20170921123625.GE2717@work-vm>
From: Peter Lieven <pl@kamp.de>
Message-ID: <3ce38800-9189-a5af-5de0-90ad9692b16b@kamp.de>
Date: Thu, 21 Sep 2017 14:42:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170921123625.GE2717@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Block Migration and CPU throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu block <qemu-block@nongnu.org>, jjherne@linux.vnet.ibm.com

Am 21.09.2017 um 14:36 schrieb Dr. David Alan Gilbert:
> * Peter Lieven (pl@kamp.de) wrote:
>> Am 19.09.2017 um 16:41 schrieb Dr. David Alan Gilbert:
>>> * Peter Lieven (pl@kamp.de) wrote:
>>>> Am 19.09.2017 um 16:38 schrieb Dr. David Alan Gilbert:
>>>>> * Peter Lieven (pl@kamp.de) wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I just noticed that CPU throttling and Block Migration don't work together very well.
>>>>>> During block migration the throttling heuristic detects that we obviously make no progress
>>>>>> in ram transfer. But the reason is the running block migration and not a too high dirty pages rate.
>>>>>>
>>>>>> The result is that any VM is throttled by 99% during block migration.
>>>>> Hmm that's unfortunate; do you have a bandwidth set lower than your
>>>>> actual network connection? I'm just wondering if it's actually going
>>>>> between the block and RAM iterative sections or getting stuck in ne.
>>>> It happens also if source and dest are on the same machine and speed is set to 100G.
>>> But does it happen if they're not and the speed is set low?
>> Yes, it does. I noticed it in our test environment between different nodes with a 10G
>> link in between. But its totally clear why it happens. During block migration we transfer
>> all dirty memory pages in each round (if there is moderate memory load), but all dirty
>> pages are obviously more than 50% of the transferred ram in that round.
>> It is more exactly 100%. But the current logic triggers on this condition.
>>
>> I think I will go forward and send a patch which disables auto converge during
>> block migration bulk stage.
> Yes, that's fair;  it probably would also make sense to throttle the RAM
> migration during the block migration bulk stage, since the chances are
> it's not going to get far.  (I think in the nbd setup, the main
> migration process isn't started until the end of bulk).

Exactly, but I would move this to a different patch. I would not start ram migration at all before
the bulk phase has completed.

Peter
