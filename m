Received: from eggs.gnu.org ([2001:4830:134:3::10]:36771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOmmn-0005Uk-Rf
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOmmk-0003O9-Lf
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:20:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1fOmmk-0003Ns-Aj
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:20:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id o13-v6so4039662wmf.4
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 09:20:14 -0700 (PDT)
Date: Fri, 1 Jun 2018 18:20:11 +0200
From: Sergio Lopez <slp@redhat.com>
Message-ID: <20180601162011.ez6ucoxbi77mq7o7@dritchie>
References: <20180531074601.10647-1-slp@redhat.com>
	<20180531074601.10647-4-slp@redhat.com>
	<CAJ+F1CKfpATgpFpHa85Esvv9k_T3FG_pY4rsz_C5a20CWfUgiQ@mail.gmail.com>
	<20180601115212.GU3458@redhat.com>
	<20180601120538.guwfrzojgabnpofb@dritchie>
	<c543d390-c034-ce60-5699-aa78186eb51d@redhat.com>
	<20180601122815.lh46wcg6rfpcooyk@dritchie>
	<CAFEAcA_eiyQ-eYV-9DZcfXC61L2V_tWhMtLG3gkiDyjoR22C_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_eiyQ-eYV-9DZcfXC61L2V_tWhMtLG3gkiDyjoR22C_w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/char/serial: Don't retry on
 serial_xmit if errno == EPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Jun 01, 2018 at 01:43:56PM +0100, Peter Maydell wrote:
> On 1 June 2018 at 13:28, Sergio Lopez <slp@redhat.com> wrote:
> > On Fri, Jun 01, 2018 at 02:16:59PM +0200, Paolo Bonzini wrote:
> >> On 01/06/2018 14:05, Sergio Lopez wrote:
> >> >>> Instead of adding explicit handling of EPIPE, shouldn't the code be
> >> >>> rewritten to treat -1 return && errno != EAGAIN as fatal?
> >> >> Yes, exactly this code is already broken for every single errno
> >> >> value, not simply EPIPE. It needs fixing to treat '-1' return code
> >> >> correctly instead of retrying everything.
> >> > Given that EAGAIN is already taken care of in
> >> > chardev/char.c:qemu_chr_write_buffer, in which cases should we retry? Or
> >> > should we just drop all the tsr_retry logic?
> >>
> >> It's not handled there, the call from qemu_chr_fe_write has write_all ==
> >> false.
> >
> > You're right. So should we just retry only for -1 && errno == EAGAIN and
> > just ignore the error otherwise?
> 
> I don't think we should make all of qemu_chr_fe_write()'s callers
> have to handle EAGAIN. That function already has a way to tell
> the caller that it didn't consume any data, which is to return 0.
> 
> (EAGAIN is a curse and we should strive to avoid it spreading its
> poison into areas of the codebase that we can keep it out of.)
> 
> In general there are three cases I think qemu_chr_fe_write() callers
> might care about:
>  * data was consumed (return >0)
>  * data wasn't consumed, try again later (return 0)
>  * data wasn't consumed, and a later attempt won't work either
>    (return -1)
> 
> NB that hw/char/serial.c is not the only serial device using
> this pattern and probably needing adjustment (though I think it's
> the only one with the complicated tsr_retry logic).
> 
> In the patch that started this thread the report is that we
> use lots of CPU. Can you explain why that happens? I was expecting
> that we would set up the qemu_chr_fe_add_watch() on the dead
> chr FE and it would just never fire since the FE can never
> accept further data...

The callback is indeed triggered (I haven't looked why yet), and both
the main thread and the vCPU that issued the write to the serial port
(which is now polling the device to see if the transmitter is empty) are
fighting for the qemu_global_mutex.

This issue is heavily amplified if both threads are sharing the same
pCPU (by chance or pinning).

Some debugging info from a simulation:


 - vCPU thread waiting to acquire qemu_global_mutex:

Thread 3 (Thread 0x7fb6c7fff700 (LWP 31641)):
#0  0x00007fb6e591c4cd in __lll_lock_wait () at ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
#1  0x00007fb6e5917dcb in _L_lock_812 () at /lib64/libpthread.so.0
#2  0x00007fb6e5917c98 in __GI___pthread_mutex_lock (mutex=mutex@entry=0x556dfb7b6420 <qemu_global_mutex>) at ../nptl/pthread_mutex_lock.c:79
#3  0x0000556dfaebcfd7 in qemu_mutex_lock_impl (mutex=mutex@entry=0x556dfb7b6420 <qemu_global_mutex>, file=file@entry=0x556dfaf57477 "/root/Projects/qemu/cpus.c", line=line@entry=1765)
    at util/qemu-thread-posix.c:67
#4  0x0000556dfaacfe58 in qemu_mutex_lock_iothread () at /root/Projects/qemu/cpus.c:1765
#5  0x0000556dfaa90bcd in prepare_mmio_access (mr=0x556dfe71c0e0, mr=0x556dfe71c0e0)
    at /root/Projects/qemu/exec.c:3068
#6  0x0000556dfaa95f98 in flatview_read_continue (fv=fv@entry=0x7fb6c028aa80, addr=addr@entry=1021, attrs=..., attrs@entry=..., buf=buf@entry=0x7fb6e739f000 "", len=len@entry=1, addr1=5, l=1, mr=0x556dfe71c0e0)
    at /root/Projects/qemu/exec.c:3189
---Type <return> to continue, or q <return> to quit---
#7  0x0000556dfaa9617c in flatview_read (fv=0x7fb6c028aa80, addr=1021, attrs=..., buf=0x7fb6e739f000 "", len=1) at /root/Projects/qemu/exec.c:3255
#8  0x0000556dfaa9629f in address_space_read_full (as=<optimized out>, addr=addr@entry=1021, attrs=..., buf=<optimized out>, len=len@entry=1) at /root/Projects/qemu/exec.c:3268
#9  0x0000556dfaa963fa in address_space_rw (as=<optimized out>, addr=addr@entry=1021, attrs=...,
    attrs@entry=..., buf=<optimized out>, len=len@entry=1, is_write=is_write@entry=false)
    at /root/Projects/qemu/exec.c:3298
#10 0x0000556dfaaf6536 in kvm_cpu_exec (count=1, size=1, direction=<optimized out>, data=<optimized out>, attrs=..., port=1021) at /root/Projects/qemu/accel/kvm/kvm-all.c:1730
#11 0x0000556dfaaf6536 in kvm_cpu_exec (cpu=cpu@entry=0x556dfd3d8020)
    at /root/Projects/qemu/accel/kvm/kvm-all.c:1970
#12 0x0000556dfaad0006 in qemu_kvm_cpu_thread_fn (arg=0x556dfd3d8020) at /root/Projects/qemu/cpus.c:1215
#13 0x00007fb6e5915dd5 in start_thread (arg=0x7fb6c7fff700) at pthread_create.c:308
#14 0x00007fb6d9e97b3d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:113


 - The owner is LWP 31634, the main thread

 (gdb) p qemu_global_mutex
$1 = {lock = {__data = {__lock = 2, __count = 0, __owner = 31634, __nusers = 1, __kind = 0, __spins = 0,
      __elision = 0, __list = {__prev = 0x0, __next = 0x0}},
    __size = "\002\000\000\000\000\000\000\000\222{\000\000\001", '\000' <repeats 26 times>,
    __align = 2}, initialized = true}


 - The main thead is in the callback

 Thread 1 (Thread 0x7fb6e7355cc0 (LWP 31634)):
---Type <return> to continue, or q <return> to quit---
#0  0x0000556dfac59420 in serial_watch_cb (chan=0x556dfd321400, cond=G_IO_OUT, opaque=0x556dfe71c000)
    at hw/char/serial.c:233
#1  0x00007fb6e68638f9 in g_main_context_dispatch (context=0x556dfd314210) at gmain.c:3146
#2  0x00007fb6e68638f9 in g_main_context_dispatch (context=context@entry=0x556dfd314210) at gmain.c:3811
#3  0x0000556dfaeba126 in main_loop_wait () at util/main-loop.c:215
#4  0x0000556dfaeba126 in main_loop_wait (timeout=<optimized out>) at util/main-loop.c:263
#5  0x0000556dfaeba126 in main_loop_wait (nonblocking=nonblocking@entry=0) at util/main-loop.c:522
#6  0x0000556dfaa89a2f in main () at vl.c:1943
#7  0x0000556dfaa89a2f in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>)
    at vl.c:4679


Given your question, I was wondering what would happen if the callback
never fired. The result is much, much worse, as QEMU doesn't set
UART_LSR_TEMT, and the Guest OS (RHEL7.5) keeps polling the serial
device for ~10 seconds. Of course this can be regarded as a issue if the
Guest's serial driver, but I'm pretty sure we don't want to break it ;-)

This is not the first time I'm fighting the retry logic in serial.c.
Some versions back, serial_xmit would happily add up watchers with no
limit, eventually exceeding FD_SETSIZE limit. I'm starting to thing that
tsr_retry logic does more harm than good.

In any case, I think the question on the table is when should
serial_xmit retry writing to the FE, and we seem to have two options:

 1. When ret != 1 and errno == EAGAIN.

 2. When ret == 0.

I'm good with either, so I leave the decision to you.

Sergio.
