Received: from eggs.gnu.org ([209.51.188.92]:54602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1h1VxH-0002Vh-CH
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:47:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1h1VxG-0001Y4-FC
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:47:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1h1VxG-0001WY-6x
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:47:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id o10so4359124wmc.1
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 04:47:22 -0800 (PST)
References: <20190227165212.34901-1-slp@redhat.com>
	<20190227173714.GA6276@localhost.localdomain>
	<20190228150119.c77xcmrp4ogg32eu@dritchie>
	<20190228155053.GB5563@linux.fritz.box>
	<20190228170436.mifnzx6agowzxyq3@dritchie>
	<20190228172202.GC5563@linux.fritz.box>
	<20190228183637.f7v6phv3kqtin3ps@dritchie>
	<20190301114426.GA5861@localhost.localdomain>
	<87lg1yogej.fsf@redhat.com>
	<20190301155002.GE5861@localhost.localdomain>
From: Sergio Lopez <slp@redhat.com>
In-reply-to: <20190301155002.GE5861@localhost.localdomain>
Date: Wed, 06 Mar 2019 13:47:19 +0100
Message-ID: <87imwwdvag.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: dataplane: release AioContext
 before blk_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


Kevin Wolf writes:

> Am 01.03.2019 um 14:47 hat Sergio Lopez geschrieben:
>> >> Otherwise, we can simply add an extra condition at
>> >> child_job_drained_poll(), before the drv->drained_poll(), to return
>> >> true if the job isn't yet paused.
>> >
>> > Yes, I think something like this is this right fix.
>> 
>> Fixing this has uncovered another issue also triggered by issuing
>> 'block_commit' and 'device_del' consecutively. At the end, mirror_run()
>> calls to bdrv_drained_begin(), which is scheduled of later (via
>> bdrv_co_yield_to_drain()) as the mirror job is running in a coroutine.
>> 
>> At the same time, the Guest requests the device to be unplugged, which
>> leads to blk_unref()->blk_drain()->bdrv_do_drained_begin(). When the
>> latter reaches BDRV_POLL_WHILE, the bdrv_drained_begin scheduled above
>> is run, which also runs BDRV_POLL_WHILE, leading to the thread getting
>> stuck in aio_poll().
>> 
>> Is it really safe scheduling a bdrv_drained_begin() with poll == true?
>
> I don't see what the problem would be with it in theory. Once the node
> becomes idle, both the inner and the outer BDRV_POLL_WHILE() should
> return.
>
> The question with such hangs is usually, what is the condition that made
> bdrv_drain_poll() return true, and why aren't we making progress so that
> is would become false. With iothreads, it could also be that the
> condition has actually already changed, but aio_wait_kick() wasn't
> called, so aio_poll() isn't woken up.

Turns out we can't restrict child_job_drained_poll() to signal
completion only if the job has already been effectively paused or
cancelled, as we may reach this point from job_finish_sync().

Do you think it's worth to keep trying that bdrv_drained_begin() only
returns when the related jobs are completely paused, or should we just
use AIO_WAIT_WHILE at block_job_detach_aio_context() as previously
suggested?

Thanks,
Sergio (slp).
