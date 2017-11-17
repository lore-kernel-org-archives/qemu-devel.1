Received: from eggs.gnu.org ([2001:4830:134:3::10]:42167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFlAl-0008NZ-09
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:15:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFlAk-00014M-5F
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:15:26 -0500
References: <20171023092945.54532-1-vsementsov@virtuozzo.com>
	<20171117123059.GB4795@localhost.localdomain>
	<b95aaa97-39d0-fdc1-21a1-2e0ea7acac17@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <79f2607f-d4f9-8f92-76df-c99ae48b9936@redhat.com>
Date: Fri, 17 Nov 2017 13:15:11 -0500
MIME-Version: 1.0
In-Reply-To: <b95aaa97-39d0-fdc1-21a1-2e0ea7acac17@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/snapshot: dirty all dirty bitmaps on
 snapshot-switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com



On 11/17/2017 10:01 AM, Max Reitz wrote:
> On 2017-11-17 13:30, Kevin Wolf wrote:
>> Am 23.10.2017 um 11:29 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> Snapshot-switch actually changes active state of disk so it should
>>> reflect on dirty bitmaps. Otherwise next incremental backup using
>>> these bitmaps will be invalid.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> We discussed this quite a while ago, and I'm still not convinced that
>> this approach makes sense.
> 
> I think it at least makes more sense than not handling this case at all.
> 
>> Can you give just one example of a use case where dirtying the whole
>> bitmap while loading a snapshot is the desired behaviour?
>>
>> I think the most useful behaviour would be something where the bitmaps
>> themselves are snapshotted, too.
> 
> Agreed.
> 
>>                                  But for the time being, the easiest and
>> safest solution might just be to error out in any snapshot operations
>> if any bitmaps are in use.
> 
> Sounds OK, too.  I personally don't have an opinion either way.
> 
> But in any case, what we did before this patch was definitely wrong so I
> consider it an improvement.
> 

This is how I feel about it too. Erroring out entirely is an option, but
code-wise just dirtying everything is at least verifiably not-wrong and
pretty simple to implement.

It's an improvement... Don't do it, but at least you won't get something
wrong after, just something heinously unoptimal.

> Max
> 
