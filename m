Received: from eggs.gnu.org ([2001:4830:134:3::10]:57658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cJH7g-0004eE-85
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cJH7c-0002tY-7p
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:54:16 -0500
Received: from [59.151.112.132] (port=39586 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cJH7b-0002ra-S3
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:54:12 -0500
References: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20161219150230.GA20757@stefanha-x1.localdomain>
	<20161219163214.GA9801@lemon>
	<20161220093938.GB5602@stefanha-x1.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <52737ee8-f456-038a-5d21-8fe163057450@cn.fujitsu.com>
Date: Tue, 20 Dec 2016 17:54:06 +0800
MIME-Version: 1.0
In-Reply-To: <20161220093938.GB5602@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, eblake@redhat.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, qemu-devel@nongnu.org

Hi Stefan,

At 12/20/2016 05:39 PM, Stefan Hajnoczi wrote:
> On Tue, Dec 20, 2016 at 12:32:40AM +0800, Fam Zheng wrote:
>> On Mon, 12/19 15:02, Stefan Hajnoczi wrote:
>>> On Mon, Dec 19, 2016 at 04:51:22PM +0800, Dou Liyang wrote:
>>>> These patches aim to refactor the qmp_query_blockstats() and
>>>> improve the performance by reducing the running time of it.
>>>>
>>>> qmp_query_blockstats() is used to monitor the blockstats, it
>>>> querys all the graph_bdrv_states or monitor_block_backends.
>>>>
>>>> There are the two jobs:
>>>>
>>>> 1 For the performance:
>>>>
>>>> 1.1 the time it takes(ns) in each time:
>>>> the disk numbers     | 10    | 500
>>>> -------------------------------------
>>>> before these patches | 19429 | 667722
>>>> after these patches  | 17516 | 557044
>>>>
>>>> 1.2 the I/O performance is degraded(%) during the monitor:
>>>>
>>>> the disk numbers     | 10    | 500
>>>> -------------------------------------
>>>> before these patches | 1.3   | 14.2
>>>> after these patches  | 0.8   | 9.1
>>>
>>> Do you know what is consuming the remaining 9.1%?
>>>
>>> I'm surprised to see such a high performance impact caused by a QMP
>>> command.
>>
>> If it's "performance is 9.1% worse only during the 557044 ns when the QMP
>> command is being processed", it's probably becaues the main loop is stalled a
>> bit, and it's not a big problem. I'd be very surprised if the degradation is
>> more longer than that.
>
> It would be interesting to compare against virtio-blk dataplane.  That
> way the QMP command can execute without interfering with disk I/O activity.
>

Yes, I will try to do it for you.

I have compared against the disk of IDE/SATA, I think the I/O requests
is handled by the vcpu threads. it isn't be disturbed like virtio-blk
dataplane. but its performance also degraded.


Thanks,

	Liyang.


> qemu-system-x86_64 ... \
>     -object iothread,id=iothread0 \
>     -drive if=none,id=drive0,file=vm.img,format=raw,aio=native,cache=none \
>     -device virtio-blk-pci,drive=drive0,iothread=iothread0
>
> Stefan
>
