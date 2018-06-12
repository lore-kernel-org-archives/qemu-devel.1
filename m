Received: from eggs.gnu.org ([2001:4830:134:3::10]:55871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fSZqD-0004bE-CY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 23:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fSZq8-0006gm-D9
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 23:19:29 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:41672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fSZq8-0006g2-3A
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 23:19:24 -0400
Received: by mail-pf0-x244.google.com with SMTP id a11-v6so11313266pff.8
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 20:19:23 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180611080042.GK7736@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <9127095c-dff2-a963-d9d1-3d1fe22b7937@gmail.com>
Date: Tue, 12 Jun 2018 11:19:14 +0800
MIME-Version: 1.0
In-Reply-To: <20180611080042.GK7736@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/12] migration: improve multithreads for
 compression and decompression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 06/11/2018 04:00 PM, Peter Xu wrote:
> On Mon, Jun 04, 2018 at 05:55:08PM +0800, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Background
>> ----------
>> Current implementation of compression and decompression are very
>> hard to be enabled on productions. We noticed that too many wait-wakes
>> go to kernel space and CPU usages are very low even if the system
>> is really free
>>
>> The reasons are:
>> 1) there are two many locks used to do synchronous，there
>> 　　is a global lock and each single thread has its own lock,
>> 　　migration thread and work threads need to go to sleep if
>> 　　these locks are busy
>>
>> 2) migration thread separately submits request to the thread
>>     however, only one request can be pended, that means, the
>>     thread has to go to sleep after finishing the request
>>
>> Our Ideas
>> ---------
>> To make it work better, we introduce a new multithread model,
>> the user, currently it is the migration thread, submits request
>> to each thread with round-robin manner, the thread has its own
>> ring whose capacity is 4 and puts the result to a global ring
>> which is lockless for multiple producers, the user fetches result
>> out from the global ring and do remaining operations for the
>> request, e.g, posting the compressed data out for migration on
>> the source QEMU
>>
>> Other works in this patchset is offering some statistics to see
>> if compression works as we expected and making the migration thread
>> work fast so it can feed more requests to the threads
> 
> Hi, Guangrong,
> 
> I'm not sure whether my understanding is correct, but AFAIU the old
> code has a major defect that it depends too much on the big lock.  The
> critial section of the small lock seems to be very short always, and
> also that's per-thread.  However we use the big lock in lots of
> places: flush compress data, queue every page, or send the notifies in
> the compression thread.
> 

The lock is one issue, however, another issue is that, the thread has
to go to sleep after finishing one request and the main thread (live
migration thread) needs to go to kernel space and wake the thread up
for every single request.

And we also observed that linearly scan the threads one by one to
see which is free is not cache-friendly...

> I haven't yet read the whole work, this work seems to be quite nice
> according to your test results.  However have you thought about
> firstly remove the big lock without touching much of other part of the
> code, then continue to improve it?  Or have you ever tried to do so?
> I don't think you need to do extra work for this, but I would
> appreciate if you have existing test results to share.
> 

If you really want the performance result, i will try it...

Actually, the first version we used on our production is that we
use a lockless multi-thread model (only one atomic operation is needed
for both producer and consumer) but only one request can be fed to the
thread. It's comparable to your suggestion (and should far more faster
than your suggestion).

We observed the shortcoming of this solutions is that too many waits and
wakeups trapped to kernel, so CPU is idle and bandwidth is low.

> In other words, would it be nicer to separate the work into two
> pieces?
> 
> - one to refactor the existing locks, to see what we can gain by
>    simplify the locks to minimum.  AFAIU now the locking used is still
>    not ideal, my thinking is that _maybe_ we can start by removing the
>    big lock, and use a semaphore or something to replace the "done"
>    notification while still keep the small lock?  Even some busy
>    looping?
> 

Note: no lock is used after this patchset...

> - one to introduce the lockless ring buffer, to demostrate how the
>    lockless data structure helps comparing to the locking ways
> 
> Then we can know which item contributed how much to the performance
> numbers.  After all the new ring and thread model seems to be a big
> chunk of work (sorry I haven't read them yet, but I will).

It is really a huge burden that refactor old code and later completely
remove old code.

We redesigned the data struct and algorithm completely and abstract the
model to clean up the code used for compression and decompression, it's
not easy to modify the old code part by part... :(

But... if you really it is really needed, i will try to figure out a way
to address your suggestion. :)

Thanks!
