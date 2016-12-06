Received: from eggs.gnu.org ([2001:4830:134:3::10]:59810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cEAWR-0006OB-Kr
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 02:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cEAWO-0007zq-Gf
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 02:50:43 -0500
Received: from [59.151.112.132] (port=21205 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cEAWN-0007yz-O1
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 02:50:40 -0500
References: <a503e0f2-79ad-b8c5-9418-ac0502514581@cn.fujitsu.com>
	<20161205115339.GG22443@stefanha-x1.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <e4e0f3ee-7668-7bf3-8bf1-270a14a00c6a@cn.fujitsu.com>
Date: Tue, 6 Dec 2016 15:50:29 +0800
MIME-Version: 1.0
In-Reply-To: <20161205115339.GG22443@stefanha-x1.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] a suggestion to extend the query block stats
 commands for multi-disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, armbru@redhat.com, stefanha@redhat.com, danpb@redhat.com

Hi stefan,

At 12/05/2016 07:53 PM, Stefan Hajnoczi wrote:
> On Mon, Dec 05, 2016 at 04:56:38PM +0800, Dou Liyang wrote:
>> Hi all,
>>
>> Currently, in Qemu, we query the block states by using “info blockstats”.
>> For each disk, the command calls “bdrv_query_stats” function to get the
>> info of block states in “qmp_query_blockstats” .
>> Since commit 13344f3a, Stefan added mutex to ensures that the dataplane
>> IOThread and the main loop's monitor code do not race.
>> These are very useful to us.
>>
>> Recently, we fount that when the guest in qemu had a lot of disks, the
>> I/O performance might be degraded if we used the command above.
>>
>> So, we consider whether the following optimization can be carried out:
>>
>> 1. Add an optional parameter to identify a block, If this parameter is
>> not empty, only the states of the identified block is acquired.
>>
>>  BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
>>                                       bool query_nodes,
>> +                                     BlockBackend *query_blk,
>>                                       Error **errp)
>>  {
>>      BlockStatsList *head = NULL, **p_next = &head;
>>
>> 2. Just use the mutex when we set the 'x-data-plane=on' feature.
>>
>>
>> The following is the reason:
>>
>> 1. background:
>>
>> we have some guests which have more than 450 disks. And we use
>> “qmp_query_blockstats” to monitor their disks states in real time( 2
>> times/s).
>>
>> we found that, in the monitor situation, the I/O performance of the
>> guests might be degraded. We tested(used “dd”):
>>
>>  disk number |  degraded    |
>>      10      |  1.4%   |
>>      100     |  3.4%   |
>>      200     |  5.5%   |
>>      500     |  13.6%  |
>>
>>
>> 2. In the description above, a comparison was made on the number of 500
>> disks:
>>
>>   2.1. Adds the specified parameter： degraded 2.1%
>>
>>   2.2. Turn off the lock protection(for test)： degraded 1.6%
>>
>> 3. Guess
>>
>> We stamped the time-stamps before and after the method named
>> “qmp_query_blockstats”, found that in our host:
>>
>> 3.1 the time to acquire a disk states is about 4637ns (without
>> considering the time of searching the linked list).
>> 3.2  the time to get 500 disks states is about 901583ns.
>> 3.3  if we don't consider the mutex,  the time to acquire a disk states
>> is about 2302ns.
>>
>> The operation consumes the running resources of I/O . As the number of
>> disks increases, it becomes apparent.
>>
>> We think that the performance degradation is inevitable, but if we can
>> configure the parameters, allowing users to balance between the number
>> of disks states and the performance of I/O, that may be also a good
>> thing.
>>
>> And, we searched in the mail-list archive, did not find the relevant
>> discussion. We are not sure if anyone has ever experienced this
>> problem, or if anyone ever mentioned it before.
>>
>> So, we boldly put forward, and hope to get everyone's advices.
>
> Adding the BlockBackend *query_blk parameter is a reasonable short-term
> workaround.  I wonder if the polling stats APIs need to be rethought in
> the longer term.
>

Thank you very much. Now I can confirm my idea.

For the APIs, I'm sorry, I have no idea yet.
I will try the short-term and simple way first, maybe I could find 
something.


Thanks,

   Liyang.
