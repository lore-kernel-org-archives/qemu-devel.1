Received: from eggs.gnu.org ([2001:4830:134:3::10]:35405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXTdU-0001nk-6R
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXTdS-0004Ir-9D
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:38:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dXTdR-0004ID-Vo
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:38:02 -0400
Date: Tue, 18 Jul 2017 15:37:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170718143756.GA2669@work-vm>
References: <20170621132340.27686-1-kraxel@redhat.com>
	<20170621132340.27686-6-kraxel@redhat.com>
	<a69b1a3c-74b5-6aa2-6ae3-b80fd1a4f9e6@redhat.com>
	<b938fd45-d1c4-440c-ba3b-b84b6d659225@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b938fd45-d1c4-440c-ba3b-b84b6d659225@redhat.com>
Subject: Re: [Qemu-devel] [PULL 5/6] console: remove do_safe_dpy_refresh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

* Laurent Vivier (lvivier@redhat.com) wrote:
> On 18/07/2017 15:07, Laurent Vivier wrote:
> > On 21/06/2017 15:23, Gerd Hoffmann wrote:
> >> Drop the temporary workaround for the broken display updates.
> >> All display adapters are updated, so this should be safe without
> >> causing regressions.
> > 
> > It seems it breaks QMP command 'migrate "exec:cat>mig"'.
> > 
> > The command hangs and doesn't create the file.
> > 
> > It happens with qemu-system-ppc64 on x86 (so TCG mode).
> > 
> > my command:
> > 
> >    ./ppc64-softmmu/qemu-system-ppc64 -serial mon:stdio
> > 
> > I wait SLOF fails to find an OS, and:
> > 
> >     Ctrl-a c
> >     (qemu) migrate -d "exec:cat>mig"
> > 
> > The file is not created and the command hangs:
> > 
> > #0  in __lll_lock_wait
> > #1  in pthread_mutex_lock
> > #2  in qemu_mutex_lock
> > #3  in rcu_init_lock
> > #4  in fork
> > #5  in qemu_fork
> > #6  in qio_channel_command_new_spawn
> > #7  in exec_start_outgoing_migration
> > #8  in qmp_migrate
> > ...
> > 
> > It looks like a deadlock.
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
> 
> Any comments?

I remembered hitting this in the past - but I can only
trigger it rarely for me on x86;  the following script triggers it
after ~100 iterations on my laptop:

#!/bin/bash

while true
do
  OURPIPE=/tmp/delaystop.$$
  mknod $OURPIPE p

  ./try/x86_64-softmmu/qemu-system-x86_64 -nographic -M pc,accel=kvm -smp 8 < $OURPIPE &
  QEMUPID=$!
  exec 10> "$OURPIPE"

  # Flip the mon to hmp
  echo -e '\001c' >&10
  # just a test
  echo 'migrate  -d "exec: cat > /dev/null"' >&10
  sleep $(printf ".%05d" $RANDOM)
  echo "info status" >&10
  echo "q" >&10

  rm $OURPIPE
  wait $QEMUPID || break
done

(From my notes I mentioned that to Paolo about 18months ago after
he nailed a different case)

Dave

> Laurent
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
