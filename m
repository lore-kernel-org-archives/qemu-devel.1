Received: from eggs.gnu.org ([2001:4830:134:3::10]:53776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJIIb-0004F1-Ay
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 06:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJIIa-0005g0-53
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 06:09:37 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:35012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cJIIZ-0005f2-VB
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 06:09:36 -0500
Received: by mail-it0-x243.google.com with SMTP id b123so13546290itb.2
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 03:09:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d488df1c-c028-4550-41fa-816524981c97@cn.fujitsu.com>
References: <1482137486-9843-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20161219150230.GA20757@stefanha-x1.localdomain>
	<20161219163214.GA9801@lemon>
	<20161220093938.GB5602@stefanha-x1.localdomain>
	<52737ee8-f456-038a-5d21-8fe163057450@cn.fujitsu.com>
	<CAJSP0QVagNKS5wq5Q=pLduTQJ9PLD9EmJfqdVSPyQ5oMfFzkgg@mail.gmail.com>
	<d488df1c-c028-4550-41fa-816524981c97@cn.fujitsu.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 20 Dec 2016 11:09:33 +0000
Message-ID: <CAJSP0QXye7RpFNm_ka6D5s+3WnJh9jroTv7wYkhMDgeZYUvnFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, izumi.taku@jp.fujitsu.com, Cao jin <caoj.fnst@cn.fujitsu.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, qemu-devel <qemu-devel@nongnu.org>

On Tue, Dec 20, 2016 at 10:26 AM, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> At 12/20/2016 06:01 PM, Stefan Hajnoczi wrote:
>>
>> On Tue, Dec 20, 2016 at 9:54 AM, Dou Liyang <douly.fnst@cn.fujitsu.com>
>> wrote:
>>>
>>> At 12/20/2016 05:39 PM, Stefan Hajnoczi wrote:
>>>>
>>>>
>>>> On Tue, Dec 20, 2016 at 12:32:40AM +0800, Fam Zheng wrote:
>>>>>
>>>>>
>>>>> On Mon, 12/19 15:02, Stefan Hajnoczi wrote:
>>>>>>
>>>>>>
>>>>>> On Mon, Dec 19, 2016 at 04:51:22PM +0800, Dou Liyang wrote:
>>>>>>>
>>>>>>>
>>>>>>> These patches aim to refactor the qmp_query_blockstats() and
>>>>>>> improve the performance by reducing the running time of it.
>>>>>>>
>>>>>>> qmp_query_blockstats() is used to monitor the blockstats, it
>>>>>>> querys all the graph_bdrv_states or monitor_block_backends.
>>>>>>>
>>>>>>> There are the two jobs:
>>>>>>>
>>>>>>> 1 For the performance:
>>>>>>>
>>>>>>> 1.1 the time it takes(ns) in each time:
>>>>>>> the disk numbers     | 10    | 500
>>>>>>> -------------------------------------
>>>>>>> before these patches | 19429 | 667722
>>>>>>> after these patches  | 17516 | 557044
>>>>>>>
>>>>>>> 1.2 the I/O performance is degraded(%) during the monitor:
>>>>>>>
>>>>>>> the disk numbers     | 10    | 500
>>>>>>> -------------------------------------
>>>>>>> before these patches | 1.3   | 14.2
>>>>>>> after these patches  | 0.8   | 9.1
>>>>>>
>>>>>>
>>>>>>
>>>>>> Do you know what is consuming the remaining 9.1%?
>>>>>>
>>>>>> I'm surprised to see such a high performance impact caused by a QMP
>>>>>> command.
>>>>>
>>>>>
>>>>>
>>>>> If it's "performance is 9.1% worse only during the 557044 ns when the
>>>>> QMP
>>>>> command is being processed", it's probably becaues the main loop is
>>>>> stalled a
>>>>> bit, and it's not a big problem. I'd be very surprised if the
>>>>> degradation
>>>>> is
>>>>> more longer than that.
>>>>
>>>>
>>>>
>>>> It would be interesting to compare against virtio-blk dataplane.  That
>>>> way the QMP command can execute without interfering with disk I/O
>>>> activity.
>>>>
>>>
>>> Yes, I will try to do it for you.
>>>
>>> I have compared against the disk of IDE/SATA, I think the I/O requests
>>> is handled by the vcpu threads. it isn't be disturbed like virtio-blk
>>> dataplane. but its performance also degraded.
>>
>>
>> IDE/SATA does I/O request *submission* in the vcpu thread.  Completion
>> is processed by the main loop.  Therefore it is also affected by slow
>> monitor commands.
>>
>
> Can you tell me one of the completion method in Qemu? I want to learn
> more.

How completion works depends on the -drive aio= option.

With aio=threads you need to look at thread-pool.c and block/raw-posix.c.

With aio=native you need to look at block/linux-aio.c

Since disk I/O is asynchronous there will be a completion event in the
AioContext to check the result of a completed I/O request and let the
device model (e.g. virtio-blk) process it.

Stefan
