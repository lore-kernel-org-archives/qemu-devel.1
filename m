Received: from eggs.gnu.org ([2001:4830:134:3::10]:59040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cK0US-0004gW-U8
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cK0UN-0000NP-VU
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:20:48 -0500
Received: from [59.151.112.132] (port=58523 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cK0UN-0000HF-9Q
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:20:43 -0500
References: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20161219150230.GA20757@stefanha-x1.localdomain>
	<20161219163214.GA9801@lemon>
	<20161220093938.GB5602@stefanha-x1.localdomain>
	<d6502c6d-616c-66dc-9c49-0fff7f1ee28c@cn.fujitsu.com>
	<20161221110657.GD9482@stefanha-x1.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <4b7fa12f-7c6d-7a84-37e8-b4cb393059d9@cn.fujitsu.com>
Date: Thu, 22 Dec 2016 18:20:14 +0800
MIME-Version: 1.0
In-Reply-To: <20161221110657.GD9482@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 0/4] block/qapi: refactor and
 optimize the qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, eblake@redhat.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, qemu-devel@nongnu.org



At 12/21/2016 07:06 PM, Stefan Hajnoczi wrote:
> On Wed, Dec 21, 2016 at 05:13:39PM +0800, Dou Liyang wrote:
>> Hi Stefan,
>>
>> At 12/20/2016 05:39 PM, Stefan Hajnoczi wrote:
>>> On Tue, Dec 20, 2016 at 12:32:40AM +0800, Fam Zheng wrote:
>>>> On Mon, 12/19 15:02, Stefan Hajnoczi wrote:
>>>>> On Mon, Dec 19, 2016 at 04:51:22PM +0800, Dou Liyang wrote:
>>>>>> These patches aim to refactor the qmp_query_blockstats() and
>>>>>> improve the performance by reducing the running time of it.
>>>>>>
>>>>>> qmp_query_blockstats() is used to monitor the blockstats, it
>>>>>> querys all the graph_bdrv_states or monitor_block_backends.
>>>>>>
>>>>>> There are the two jobs:
>>>>>>
>>>>>> 1 For the performance:
>>>>>>
>>>>>> 1.1 the time it takes(ns) in each time:
>>>>>> the disk numbers     | 10    | 500
>>>>>> -------------------------------------
>>>>>> before these patches | 19429 | 667722
>>>>>> after these patches  | 17516 | 557044
>>>>>>
>>>>>> 1.2 the I/O performance is degraded(%) during the monitor:
>>>>>>
>>>>>> the disk numbers     | 10    | 500
>>>>>> -------------------------------------
>>>>>> before these patches | 1.3   | 14.2
>>>>>> after these patches  | 0.8   | 9.1
>>>>>
>>>>> Do you know what is consuming the remaining 9.1%?
>>>>>
>>>>> I'm surprised to see such a high performance impact caused by a QMP
>>>>> command.
>>>>
>>>> If it's "performance is 9.1% worse only during the 557044 ns when the QMP
>>>> command is being processed", it's probably becaues the main loop is stalled a
>>>> bit, and it's not a big problem. I'd be very surprised if the degradation is
>>>> more longer than that.
>>>
>>> It would be interesting to compare against virtio-blk dataplane.  That
>>> way the QMP command can execute without interfering with disk I/O activity.
>>>
>>> qemu-system-x86_64 ... \
>>>     -object iothread,id=iothread0 \
>>>     -drive if=none,id=drive0,file=vm.img,format=raw,aio=native,cache=none \
>>>     -device virtio-blk-pci,drive=drive0,iothread=iothread0
>>
>> Here is the result in the guest with 500 disks:
>>
>> QMP command     | not execute | execute in each 0.5s |
>> -------------------------------------------------------
>> Average Times/s | 102.34675   | 103.128              |
>>
>> the degradation is 0.76%, that can be ignored.
>>
>> the dd command:
>> dd if=date_1.dat of=date_2.dat conv=fsync oflag=direct bs=1k count=400k
>
> Excellent.  It's good to know that dataplane is a solution to this
> problem.
>

Yes, Thanks very much.

now, I am not sure if these patches are needed. the patches just shorten 
the QMP command time.

No matter how, I will clarify their real purpose in the next version.

Thanks,

   Liyang
