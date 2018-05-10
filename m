Received: from eggs.gnu.org ([2001:4830:134:3::10]:46315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGlYi-00078j-6a
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGlYh-0002io-4b
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:24:36 -0400
References: <20180508135436.30140-1-stefanha@redhat.com>
	<20180508135436.30140-2-stefanha@redhat.com>
	<aa220f7d-9aa1-f32d-14f0-35d6a8161032@redhat.com>
	<20180510100537.GP1296@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fd86c6a9-998d-cb22-bfa6-e33113fa13b0@redhat.com>
Date: Thu, 10 May 2018 08:24:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180510100537.GP1296@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qemu-iotests: reduce chance of
 races in 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

On 05/10/2018 05:05 AM, Stefan Hajnoczi wrote:

>>> Add sleep 0.5 to reduce the chance of races.  This is not a real fix but
>>> appears to reduce spurious failures in practice.
>>>
>>> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>    tests/qemu-iotests/185 | 12 ++++++++++++
>>>    1 file changed, 12 insertions(+)
>>
>> I'm not opposed to this patch, but is there any way to write the test to
>> take both events in either order, without logging the events as they arrive,
>> but instead summarizing in a deterministic order which events were received
>> after the fact?  That way, no matter which way the race is won, we merely
>> log that we got two expected events, and could avoid the extra sleep.
> 
> I don't think there is a practical way of doing that without big changes
> to the test.  It could be rewritten in Python to make filtering the QMP
> events easier.
> 
> Hiding the race doesn't solve the deeper problem though: the test case
> doesn't exercise the same code path each time.  The test should really
> cover all cancellation points in the block job lifecycle instead of just
> one at random.  If we solve this problem then we don't need to filter
> the QMP event sequence.
> 
> Maybe it can be done with blkdebug.  If not then maybe a blockjobdbg
> interface is necessary to perform deterministic tests (eliminating the
> need for the ratelimiting trick used by this test!).

So trying to restate your question - can blkdebug be used to pause I/O, 
or does it just cause an error?  If the rate limiting is in effect, then 
we expect that the job will only write to the first half of a 
destination, so a blkdebug injected error for writes to the second half 
would either not trigger (the normal cancel won the race) or does 
trigger (the job advanced before the normal cancel, but blkdebug's 
injected error also serves as a means of cancelling the job, so while 
we'd have to filter things, we at least have a deterministic way of 
ending the job before it runs to completion). Except that I'm writing 
that without even re-reading the test in question to see how it would 
all fit in.  It may or may not be worth pursuing.

> 
> Please share ideas, but I think this is a long-term item that shouldn't
> block this series.

I agree that any further improvements don't need to hold up this patch 
from making things at least more reliable, even if not perfect.  So:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
