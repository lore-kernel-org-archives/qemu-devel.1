Received: from eggs.gnu.org ([2001:4830:134:3::10]:41730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cz4jm-0007Kk-Vq
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 13:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cz4jl-00088h-MP
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 13:10:22 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170414080206.2301-1-famz@redhat.com>
	<CAJSP0QVbYRW0VD_1zUqU0T6V48wr_g3co8Dxs_ndpfA70d4TkQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <80449391-88a6-d517-0682-de555fe4c169@redhat.com>
Date: Sat, 15 Apr 2017 01:10:02 +0800
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVbYRW0VD_1zUqU0T6V48wr_g3co8Dxs_ndpfA70d4TkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9-rc5 v2] block: Drain
 BH in bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 14/04/2017 16:51, Stefan Hajnoczi wrote:
> On Fri, Apr 14, 2017 at 9:02 AM, Fam Zheng <famz@redhat.com> wrote:
>> @@ -398,11 +399,15 @@ void bdrv_drain_all(void);
>>           */                                                \
>>          assert(!bs_->wakeup);                              \
>>          bs_->wakeup = true;                                \
>> -        while ((cond)) {                                   \
>> -            aio_context_release(ctx_);                     \
>> -            aio_poll(qemu_get_aio_context(), true);        \
>> -            aio_context_acquire(ctx_);                     \
>> -            waited_ = true;                                \
>> +        while (busy_) {                                    \
>> +            if ((cond)) {                                  \
>> +                waited_ = busy_ = true;                    \
>> +                aio_context_release(ctx_);                 \
>> +                aio_poll(qemu_get_aio_context(), true);    \
>> +                aio_context_acquire(ctx_);                 \
>> +            } else {                                       \
>> +                busy_ = aio_poll(ctx_, false);             \
>> +            }                                              \
> 
> Wait, I'm confused.  The current thread is not in the BDS AioContext.
> We're not allowed to call aio_poll(ctx_, false).

It's pretty ugly indeed.  Strictly from a thread-safety point of view,
everything that aio_poll calls will acquire the AioContext, so that is
safe and in fact the release/acquire pair can beeven  hoisted outside
the "if".

If we did that for blocking=true in both I/O and main thread, then that
would be racy.  This is the scenario mentioned in the commit message for
c9d1a56, "block: only call aio_poll on the current thread's AioContext",
2016-10-28).

If only one thread has blocking=true, it's subject to races too.  In
this case, the I/O thread may fail to be woken by iothread_stop's
aio_notify.  However, by the time iothread_stop is called there should
be no BlockDriverStates (and thus no BDRV_POLL_WHILE running the above
code) for the I/O thread's AioContext.

The root cause of the bug is simple: due to the main thread having the
I/O thread's AioContext, the main thread is not letting the I/O thread
run.  This is what RFifoLock and the contention callbacks were designed
to fix, though they had other issues related to recursive locking (if
you acquired an AioContext twice, the contention callback failed to
release it).  The right way to fix it is just not to hold _any_ lock
across BDRV_POLL_WHILE.  This means getting rid of
aio_context_acquire/release, and being somewhat careful about
bdrv_drained_begin, but overall it's not hard.

But Fam's patch seems ugly but safe, making it the right thing to do for
the 2.9 branch---possibly with a FIXME comment explaining the above.
bdrv_coroutine_enter can be removed too once BDS can do fine-grained
locking.

So, the ramifications of the current partial conversion are pretty
complex (though many older QEMU releases had other similar
dataplane+blockjob bugs due to the above recursive locking issue), but
it looks like it is more or less manageable to fix them either now or in
a quick 2.9.1 release a few weeks after 2.9.0.  (Fam and I also tried
another way to fix it today, but it led to deadlocks not related at all
to the partial conversion, so it seemed like a dead end).

Regarding the other code path mentioned in the cover letter:

>> 
>>     qmp_block_commit
>>       commit_active_start
>>         bdrv_reopen
>>           bdrv_reopen_multiple
>>             bdrv_reopen_prepare
>>               bdrv_flush
>>                 aio_poll
>>                   aio_bh_poll
>>                     aio_bh_call
>>                       block_job_defer_to_main_loop_bh
>>                         stream_complete
>>                           bdrv_reopen

it's possible that it's just a missing bdrv_ref/unref pair, respectively
in bdrv_reopen_queue_child and bdrv_reopen_multiple, so not related to
this patch.  We didn't test adding the ref/unref though.

Thanks,

Paolo

> Did you mean aio_poll(qemu_get_aio_context(), false) in order to
> process defer to main loop BHs?
