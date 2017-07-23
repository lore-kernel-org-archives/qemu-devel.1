Received: from eggs.gnu.org ([2001:4830:134:3::10]:57221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZGZw-00014W-J1
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 09:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZGZs-0003Kd-JL
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 09:05:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dZGZs-0003Id-9Q
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 09:05:44 -0400
References: <20170621132340.27686-1-kraxel@redhat.com>
	<20170621132340.27686-6-kraxel@redhat.com>
	<a69b1a3c-74b5-6aa2-6ae3-b80fd1a4f9e6@redhat.com>
	<b938fd45-d1c4-440c-ba3b-b84b6d659225@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b71f8ad-9e8c-39e6-8e83-f2d93c3c8d6f@redhat.com>
Date: Sun, 23 Jul 2017 15:05:42 +0200
MIME-Version: 1.0
In-Reply-To: <b938fd45-d1c4-440c-ba3b-b84b6d659225@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 5/6] console: remove do_safe_dpy_refresh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

On 18/07/2017 15:56, Laurent Vivier wrote:
> On 18/07/2017 15:07, Laurent Vivier wrote:
>> On 21/06/2017 15:23, Gerd Hoffmann wrote:
>>> Drop the temporary workaround for the broken display updates.
>>> All display adapters are updated, so this should be safe without
>>> causing regressions.
>>
>> It seems it breaks QMP command 'migrate "exec:cat>mig"'.
>>
>> The command hangs and doesn't create the file.
>>
>> It happens with qemu-system-ppc64 on x86 (so TCG mode).
>>
>> my command:
>>
>>    ./ppc64-softmmu/qemu-system-ppc64 -serial mon:stdio
>>
>> I wait SLOF fails to find an OS, and:
>>
>>     Ctrl-a c
>>     (qemu) migrate -d "exec:cat>mig"
>>
>> The file is not created and the command hangs:
>>
>> #0  in __lll_lock_wait
>> #1  in pthread_mutex_lock
>> #2  in qemu_mutex_lock
>> #3  in rcu_init_lock
>> #4  in fork
>> #5  in qemu_fork
>> #6  in qio_channel_command_new_spawn
>> #7  in exec_start_outgoing_migration
>> #8  in qmp_migrate
>> ...
>>
>> It looks like a deadlock.
> 
> I think this patch is not the cause of the problem, the one it removes
> just unlocks the deadlock by playing with locks.
> 
> We have a rcu_init_lock() on fork() because of:
> 
> utils/rcu.c:
> 
> static void __attribute__((__constructor__)) rcu_init(void)
> {
> #ifdef CONFIG_POSIX
>     pthread_atfork(rcu_init_lock, rcu_init_unlock, rcu_init_unlock);
> #endif
>     rcu_init_complete();
> }
> 
> The QMP thread hangs on:
> 
> (gdb) p rcu_sync_lock
> $1 = {lock = {__data = {__lock = 2, __count = 0, __owner = 23865,
>       __nusers = 1, __kind = 0, __spins = 0, __elision = 0, __list = {
>         __prev = 0x0, __next = 0x0}},
>     __size = "\002\000\000\000\000\000\000\000\071]\000\000\001", '\000'
> <repeats 26 times>, __align = 2}, initialized = true}
> 
> 
> The lock is already taken by thread 2:
> 
> (gdb) info thread
>   Id   Target Id         Frame
>   1    Thread 0x7f1cf02fdf00 (LWP 23864) "qemu-system-ppc"
> 0x00007f1cd914b37d in __lll_lock_wait () from /lib64/libpthread.so.0
> * 2    Thread 0x7f1cc9762700 (LWP 23865) "qemu-system-ppc"
> 0x00007f1cd410daa9 in syscall () from /lib64/libc.so.6
>   3    Thread 0x7f1cbf8d5700 (LWP 23866) "qemu-system-ppc"
> 0x00007f1cd914b37d in __lll_lock_wait () from /lib64/libpthread.so.0
> 
> (gdb) bt
> #0  0x00007f1cd410daa9 in syscall () at /lib64/libc.so.6
> #1  0x000055ab028ddda2 in qemu_futex_wait
> #2  0x000055ab028ddda2 in qemu_event_wait
> #3  0x000055ab028eda2b in wait_for_readers
> #4  0x000055ab028eda2b in synchronize_rcu
> #5  0x000055ab028edc5b in call_rcu_thread
> #6  0x00007f1cd914273a in start_thread ()
> #7  0x00007f1cd4113e0f in clone ()
> 
> So it seems we cannot fork() from QMP?
> [cc: Paolo]

There have been other similar bugs, as David reported.  The plan was to
disable pthread_atfork soon after daemonize (basically assuming that
after daemonize fork is immediately followed by exec), but I've been
lazy and never finished those patches.  Looks like it's time.

Paolo
