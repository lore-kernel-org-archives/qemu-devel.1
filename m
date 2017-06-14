Received: from eggs.gnu.org ([2001:4830:134:3::10]:52946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dL8A0-0000B8-RR
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dL89z-0008AL-8h
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:16:36 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
References: <20170522135704.842-1-stefanha@redhat.com>
	<20170522135704.842-4-stefanha@redhat.com>
	<add32dd6-f842-9d66-0f7f-6e0e2b7c8100@virtuozzo.com>
Message-ID: <99f414f1-7a0f-b659-be81-d6f38fd04ff4@virtuozzo.com>
Date: Wed, 14 Jun 2017 16:15:52 +0300
MIME-Version: 1.0
In-Reply-To: <add32dd6-f842-9d66-0f7f-6e0e2b7c8100@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/4] migration: avoid recursive
 AioContext locking in save_vmstate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org

On 14.06.2017 13:10, Pavel Butsykin wrote:
> 
> On 22.05.2017 16:57, Stefan Hajnoczi wrote:
>> AioContext was designed to allow nested acquire/release calls.  It uses
>> a recursive mutex so callers don't need to worry about nesting...or so
>> we thought.
>>
>> BDRV_POLL_WHILE() is used to wait for block I/O requests.  It releases
>> the AioContext temporarily around aio_poll().  This gives IOThreads a
>> chance to acquire the AioContext to process I/O completions.
>>
>> It turns out that recursive locking and BDRV_POLL_WHILE() don't mix.
>> BDRV_POLL_WHILE() only releases the AioContext once, so the IOThread
>> will not be able to acquire the AioContext if it was acquired
>> multiple times.
>>
>> Instead of trying to release AioContext n times in BDRV_POLL_WHILE(),
>> this patch simply avoids nested locking in save_vmstate().  It's the
>> simplest fix and we should step back to consider the big picture with
>> all the recent changes to block layer threading.
>>
>> This patch is the final fix to solve 'savevm' hanging with -object
>> iothread.
> 
> The same I see in external_snapshot_prepare():
>      /* Acquire AioContext now so any threads operating on old_bs stop */
>      state->aio_context = bdrv_get_aio_context(state->old_bs);
>      aio_context_acquire(state->aio_context);
>      bdrv_drained_begin(state->old_bs);
> 
>      if (!bdrv_is_inserted(state->old_bs)) {
>          error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, device);
>          return;
>      }
> 
>      if (bdrv_op_is_blocked(state->old_bs,
>                             BLOCK_OP_TYPE_EXTERNAL_SNAPSHOT, errp)) {
>          return;
>      }
> 
>      if (!bdrv_is_read_only(state->old_bs)) {
>          if (bdrv_flush(state->old_bs)) {      <---!!!
> 
> and at the moment BDRV_POLL_WHILE(bs, flush_co.ret == NOT_DONE),
> we have at least two locks.. So here is another deadlock.

Sorry, here different kind of deadlock. In external_snapshot case, the
deadlock can happen only if state->old_bs->aio_context == my_iothread->ctx,
because in this case the aio_co_enter() always calls aio_co_schedule():

void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co)
{
     aio_co_enter(bdrv_get_aio_context(bs), co);
}
...
void aio_co_enter(AioContext *ctx, struct Coroutine *co)
{
     if (ctx != qemu_get_current_aio_context()) {
         aio_co_schedule(ctx, co);
         return;
     }
...

But the iothread will not be able to perform coroutine, because the 
my_iothread->ctx is already under lock here:

static void external_snapshot_prepare(BlkActionState *common,
...
     /* Acquire AioContext now so any threads operating on old_bs stop */
     state->aio_context = bdrv_get_aio_context(state->old_bs);
     aio_context_acquire(state->aio_context);
     bdrv_drained_begin(state->old_bs);
...

As a result, we can see the following deadlock:

Thread 1 (Thread 0x7f0da6af9bc0 (LWP 973294)):
#0  0x00007f0da49b5ebf in __GI_ppoll (fds=0x7f0da87434b0, nfds=1, 
timeout=<optimized out>, sigmask=0x0)
     at ../sysdeps/unix/sysv/linux/ppoll.c:56
#1  0x00007f0da71e8234 in qemu_poll_ns (fds=0x7f0da87434b0, nfds=1, 
timeout=-1) at util/qemu-timer.c:322
#2  0x00007f0da71eaf32 in aio_poll (ctx=0x7f0da870e7c0, blocking=true) 
at util/aio-posix.c:622
#3  0x00007f0da715ff9c in bdrv_flush (bs=0x7f0da876c270) at block/io.c:2397
#4  0x00007f0da6e98344 in external_snapshot_prepare 
(common=0x7f0da9d727b0, errp=0x7ffec3893f38)
     at blockdev.c:1686
#5  0x00007f0da6e99537 in qmp_transaction (dev_list=0x7f0da98abb40, 
has_props=false,
     props=0x7f0daa2788c0, errp=0x7ffec3893fc0) at blockdev.c:2205
#6  0x00007f0da6ebee21 in qmp_marshal_transaction (args=0x7f0da9e7b700, 
ret=0x7ffec3894030,
     errp=0x7ffec3894028) at qmp-marshal.c:5952
#7  0x00007f0da71d9783 in do_qmp_dispatch (cmds=0x7f0da785f940 
<qmp_commands>, request=0x7f0da87b8400,
     errp=0x7ffec3894090) at qapi/qmp-dispatch.c:104
#8  0x00007f0da71d98bb in qmp_dispatch (cmds=0x7f0da785f940 
<qmp_commands>, request=0x7f0da87b8400)
     at qapi/qmp-dispatch.c:131
#9  0x00007f0da6d6a0a1 in handle_qmp_command (parser=0x7f0da874c150, 
tokens=0x7f0da870e2e0)
     at /root/qemu/monitor.c:3834
#10 0x00007f0da71e0c62 in json_message_process_token 
(lexer=0x7f0da874c158, input=0x7f0da870e200,
     type=JSON_RCURLY, x=422, y=35) at qobject/json-streamer.c:105
#11 0x00007f0da720ba27 in json_lexer_feed_char (lexer=0x7f0da874c158, 
ch=125 '}', flush=false)
     at qobject/json-lexer.c:319
#12 0x00007f0da720bb67 in json_lexer_feed (lexer=0x7f0da874c158, 
buffer=0x7ffec3894320 "}", size=1)
     at qobject/json-lexer.c:369
#13 0x00007f0da71e0d02 in json_message_parser_feed 
(parser=0x7f0da874c150, buffer=0x7ffec3894320 "}",
     size=1) at qobject/json-streamer.c:124
---Type <return> to continue, or q <return> to quit---
#14 0x00007f0da6d6a263 in monitor_qmp_read (opaque=0x7f0da874c0d0, 
buf=0x7ffec3894320 "}", size=1)
     at /root/qemu/monitor.c:3876
#15 0x00007f0da717af53 in qemu_chr_be_write_impl (s=0x7f0da871c3f0, 
buf=0x7ffec3894320 "}", len=1)
     at chardev/char.c:167
#16 0x00007f0da717afbb in qemu_chr_be_write (s=0x7f0da871c3f0, 
buf=0x7ffec3894320 "}", len=1)
     at chardev/char.c:179
#17 0x00007f0da7183204 in tcp_chr_read (chan=0x7f0daa211680, 
cond=G_IO_IN, opaque=0x7f0da871c3f0)
     at chardev/char-socket.c:441
#18 0x00007f0da7196e93 in qio_channel_fd_source_dispatch 
(source=0x7f0da871cb80,
     callback=0x7f0da7183061 <tcp_chr_read>, user_data=0x7f0da871c3f0) 
at io/channel-watch.c:84
#19 0x00007f0da55fbd7a in g_main_dispatch (context=0x7f0da870eb90) at 
gmain.c:3152
#20 g_main_context_dispatch (context=0x7f0da870eb90) at gmain.c:3767
#21 0x00007f0da71e9224 in glib_pollfds_poll () at util/main-loop.c:213
#22 0x00007f0da71e9322 in os_host_main_loop_wait (timeout=811021610) at 
util/main-loop.c:261
#23 0x00007f0da71e93de in main_loop_wait (nonblocking=0) at 
util/main-loop.c:517
#24 0x00007f0da6ea6786 in main_loop () at vl.c:1918
#25 0x00007f0da6eae43d in main (argc=65, argv=0x7ffec38958b8, 
envp=0x7ffec3895ac8) at vl.c:4752

Thread 7 (Thread 0x7f0da04f6700 (LWP 973297)):
#0  __lll_lock_wait () at 
../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
#1  0x00007f0da4c93d1d in _L_lock_840 () from /lib64/libpthread.so.0
#2  0x00007f0da4c93c3a in __GI___pthread_mutex_lock 
(mutex=0x7f0da871dc80) at pthread_mutex_lock.c:85
#3  0x00007f0da71ed62a in qemu_mutex_lock (mutex=0x7f0da871dc80) at 
util/qemu-thread-posix.c:61
#4  0x00007f0da71e6d1d in aio_context_acquire (ctx=0x7f0da871dc20) at 
util/async.c:489
#5  0x00007f0da71e6945 in co_schedule_bh_cb (opaque=0x7f0da871dc20) at 
util/async.c:390
#6  0x00007f0da71e60ee in aio_bh_call (bh=0x7f0da871dd50) at util/async.c:90
#7  0x00007f0da71e6185 in aio_bh_poll (ctx=0x7f0da871dc20) at 
util/async.c:118
#8  0x00007f0da71eb212 in aio_poll (ctx=0x7f0da871dc20, blocking=true) 
at util/aio-posix.c:682
#9  0x00007f0da6e9e1ec in iothread_run (opaque=0x7f0da871da90) at 
iothread.c:59
#10 0x00007f0da4c91dc5 in start_thread (arg=0x7f0da04f6700) at 
pthread_create.c:308
#11 0x00007f0da49c073d in clone () at 
../sysdeps/unix/sysv/linux/x86_64/clone.S:113

Thread1 is waiting for that iothread(Thread7) will execute 
coroutine(bdrv_flush_co_entry),
but the iothread is locked in Thread1.

Maybe we should take the lock only if state->aio_context == 
qemu_get_current_aio_context

>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   migration/savevm.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index f5e8194..3ca319f 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2150,6 +2150,14 @@ int save_vmstate(const char *name, Error **errp)
>>           goto the_end;
>>       }
>> +    /* The bdrv_all_create_snapshot() call that follows acquires the 
>> AioContext
>> +     * for itself.  BDRV_POLL_WHILE() does not support nested locking 
>> because
>> +     * it only releases the lock once.  Therefore synchronous I/O 
>> will deadlock
>> +     * unless we release the AioContext before 
>> bdrv_all_create_snapshot().
>> +     */
>> +    aio_context_release(aio_context);
>> +    aio_context = NULL;
>> +
>>       ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, &bs);
>>       if (ret < 0) {
>>           error_setg(errp, "Error while creating snapshot on '%s'",
>> @@ -2160,7 +2168,9 @@ int save_vmstate(const char *name, Error **errp)
>>       ret = 0;
>>    the_end:
>> -    aio_context_release(aio_context);
>> +    if (aio_context) {
>> +        aio_context_release(aio_context);
>> +    }
>>       if (saved_vm_running) {
>>           vm_start();
>>       }
>>
> 
