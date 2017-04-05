Received: from eggs.gnu.org ([2001:4830:134:3::10]:47054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cvm0L-0004Z4-Rj
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cvm0I-0006xm-NV
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:33:49 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:49917)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1cvm0I-0006tS-C0
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:33:46 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ONX00CY6XS70B30@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:33:43 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <067f6c31-ad7e-6ae9-22ad-1a8f9cc43584@samsung.com>
Date: Wed, 05 Apr 2017 17:33:40 +0300
MIME-version: 1.0
In-reply-to: <20170404190648.GN2147@work-vm>
Content-type: text/plain; charset=windows-1252; format=flowed
Content-transfer-encoding: 7bit
References: <CGME20170318151328eucas1p24d754940723a0e777a2096a678a2094d@eucas1p2.samsung.com>
	<1489850003-5652-1-git-send-email-a.perevalov@samsung.com>
	<20170404190648.GN2147@work-vm>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Calcuate downtime for postcopy
 live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com

On 04/04/2017 10:06 PM, Dr. David Alan Gilbert wrote:
> * Alexey Perevalov (a.perevalov@samsung.com) wrote:
>> Hi David,
>>
>> I already asked you about downtime calculation for postcopy live migration.
>> As I remember you said it's worth not to calculate it per vCPU or maybe I
>> understood you incorrectly. I decided to proof it could be useful.
> Thanks - apologies for taking so long to look at it.
> Some higher level thoughts:
>     a) It needs to be switchable - the tree etc look like they could use a fair
>        amount of RAM.
Are you worry about memory overhead when downtime will be calculated?
I chose tree due to lookup performance, but as an alternative it
could be a hash table. The tree population is on hot path, but the
final calculation is not. Do you want to enable it by demand,
as capability (such as compress)?
>     b) The cpu bitmask is a problem given we can have more than 64 CPUs
Here I agree it's not so scalable, I thought about straightforward
char/bool array, or invent bit operation for memory region.

>     c) Tracing the pages that took the longest can be interesting - I've done
>        graphs of latencies before - you get fun things like watching messes
>        where you lose requests and the page eventually arrives anyway after
>        a few seconds.
>        
>> This patch set is based on commit 272d7dee5951f926fad1911f2f072e5915cdcba0
>> of QEMU master branch. It requires commit into Andreas git repository
>> "userfaultfd: provide pid in userfault uffd_msg"
>>
>> When I tested it I found following moments are strange:
>> 1. First userfault always occurs due to access to ram in vapic_map_rom_writable,
>> all vCPU are sleeping in this time
> That's probably not too surprising - I bet the vapic device load code does that?
> I've sometimes wondered about preloading the queue on the source with some that we know
> will need to be loaded early.
Yes, it's vapic device initialization, do your mean earlier than discard ram
blocks? I think vapic configuration on destination is the same as on source
machine, so maybe it's not necessary to request it and wait.

>
>> 2. Latest half of all userfault was initiated by kworkers, that's why I had a doubt
>> about current in handle_userfault inside kernel as a proper task_struct for pagefault
>> initiator. All vCPU was sleeping at that moment.
> When you say kworkers - which ones?  I wonder what they are - perhaps incoming network
> packets using vhost?
No, in that scenario I used tap network device. Unfortunately, I didn't 
track down
who it was, but I will.
>
>> 3. Also there is a discrepancy, of vCPU state and real vCPU thread state.
> What do you mean by that?
I mean /proc's status and internal qemu's vCPU status for pagefaulted vCPU
thread.

>
>> This patch is just for showing and idea, if you ok with this idea none RFC patch will not
>> include proc access && a lot of traces.
>> Also I think it worth to guard postcopy_downtime in MigrationIncomingState and
>> return calculated downtime into src, where qeury-migration will be invocked.
> I don't think it's worth it, we can always ask the destination and sending stuff
> back to the source is probably messy - especially at the end.
>
> Dave
>
>> Alexey Perevalov (2):
>>    userfault: add pid into uffd_msg
>>    migration: calculate downtime on dst side
>>
>>   include/migration/migration.h     |  11 ++
>>   linux-headers/linux/userfaultfd.h |   1 +
>>   migration/migration.c             | 238 +++++++++++++++++++++++++++++++++++++-
>>   migration/postcopy-ram.c          |  61 +++++++++-
>>   migration/savevm.c                |   2 +
>>   migration/trace-events            |  10 +-
>>   6 files changed, 319 insertions(+), 4 deletions(-)
>>
>> -- 
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
>


-- 
Best regards,
Alexey Perevalov
