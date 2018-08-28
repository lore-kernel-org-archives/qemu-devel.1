Received: from eggs.gnu.org ([2001:4830:134:3::10]:50090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fukhs-0006Xy-Dd
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 16:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fukYf-0002U8-Da
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 16:25:50 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-6-jsnow@redhat.com>
	<553da197-ebd0-1eda-909c-aa0740332737@redhat.com>
	<0b63f8aa-16eb-b719-b903-dff693753e8b@redhat.com>
	<70d6a96e-ac23-101c-bf10-d9855fe2ec9e@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1920b33f-6773-b224-23b6-74874641f639@redhat.com>
Date: Tue, 28 Aug 2018 16:25:40 -0400
MIME-Version: 1.0
In-Reply-To: <70d6a96e-ac23-101c-bf10-d9855fe2ec9e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/7] block/mirror: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com, Fam Zheng <famz@redhat.com>



On 08/25/2018 11:02 AM, Max Reitz wrote:
> If you say so...  I have to admit I don't really understand.  The
> comment doesn't explain why it's so important to keep src around until
> job_completed(), so I don't know.  I thought AioContexts are recursive
> so it doesn't matter whether you take them recursively or not.

bdrv_flush has troubles under a recursive lock if it is invoked from a
different thread. It tries to poll for flush completion but the
coroutine which gets scheduled (instead of entered) can't actually run
if we hold the lock twice from, say, the main thread -- which is where
we're doing the graph manipulation from.

>        co = qemu_coroutine_create(bdrv_flush_co_entry, &flush_co);
>        bdrv_coroutine_enter(bs, co);
>        BDRV_POLL_WHILE(bs, flush_co.ret == NOT_DONE);

BDRV_POLL_WHILE there causes us the grief via AIO_WAIT_WHILE, which only
puts down one reference, so we deadlock in bdrv_flush in a recursive
context.

Kevin helped me figure it out; I CC'd him off-list on a mail that you
were also CC'd on ("hang in mirror_exit") that's probably pretty helpful:

> Took a little more than five minutes, but I think I've got it now. The
> important thing is that the test case is for dataplane, i.e. the job
> runs in an I/O thread AioContext. Job completion, however, happens in
> the main loop thread.
> 
> Therefore, when bdrv_delete() wants to flush the node first, it needs to
> run bdrv_co_flush() in a foreign AioContext, so the coroutine is
> scheduled. The I/O thread backtrace shows that it's waiting for the
> AioContext lock before it can actually enter the bdrv_co_flush()
> coroutine, so we must have deadlocked:

--js
