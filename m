Received: from eggs.gnu.org ([2001:4830:134:3::10]:49164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ev2kP-0004Cd-D4
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 11:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ev2kO-0008PL-8j
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 11:18:53 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:41063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ev2kO-0008P9-36
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 11:18:52 -0400
Received: by mail-oi0-x233.google.com with SMTP id g5so10416830oiy.8
	for <qemu-devel@nongnu.org>; Sun, 11 Mar 2018 08:18:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG0V3WTKdkyxZE=pJ1Y=+DmLRD1Dv1qfJ3X8d8TJ=isMUcc-WA@mail.gmail.com>
References: <CAG0V3WTKdkyxZE=pJ1Y=+DmLRD1Dv1qfJ3X8d8TJ=isMUcc-WA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 11 Mar 2018 15:18:31 +0000
Message-ID: <CAFEAcA9BrKv4giRUcN2u73UzO7ohmyFEMKJ3ecyZUEQNMFHT1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu 2.10.2 : util/qemu-thread-posix.c: 64:
 qemu_mutex_lock: Assertion 'mutex->initialized' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eva Chen <debby83729@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 March 2018 at 06:58, Eva Chen <debby83729@gmail.com> wrote:
> Hello,
>
> I am working on compiling QEMU 2.10.2 to a static library.
>
> Everything works fine in compiling QEMU to an execution
> file(qemu-system-aarch64), but after I link all .o and .a file to create a
> QEMU library and write a c file to call qemu_main() in qemu/util/vl.c(I
> have changed the name "main()" into "qemu_main()"), then it shows this
> error message.

This isn't really supported, so you're kind of on your
own here, but I have a few debugging suggestions below:

> util/qemu-thread-posix.c: 64: qemu_mutex_lock: Assertion
> 'mutex->initialized' failed.
> Abort (core dumped)
>
>
> The information of gdb's backtrace is shown as bellow
> (gdb) bt
>
> *#o Ox00007ffff05b31f7 in raise () at /usr/lib64/libc.so.6
> #1 0x00007ffff05b48e8 in abort () at /usr/lib64/libc.s0.6
> #2 0x00007ffff05ac266 in assert fail base () at /usr/lib64/libc.so.6
> #3 0x00007ffff05ac312 in 0 at /usr/lib64/libc.so.6
> #4 0x00000000005c47e3 in qemu_mutex_lock (mutex=mutex@entry=0xd84be0 <rcu_registry lock>) at
> util/qemu-thread-posix.c:64
> #5 0x00000000005d5b46 in rcu_register_thread() at util/rcu.c:290
> #6 0x00007ffff5a790de in rcu_init_complete () at util/rcu.c:318,
> #7 Ox00007ffff7dea503 in _dl_init_internal () at /lib64/ld.linux-x86-64.50.2
> #8 0x00007ffff7ddclaa in _dl_start_user () at /lib64/ld.linux - x86-64.so.2
> #9 0x0000000000000014 in ()*
>
> I found out that it aborted before conducted to the main function in QEMU

This happens before main because this backtrace is from rcu_init()
in util/rcu.c, which is marked as __attribute__((__constructor__)),
so it is called before main().

(As an aside, you'll probably find your backtraces are more
helpful and debugging is easier if you configure QEMU with
--enable-debug, which will mean we compile with debug rather
than optimization. When you've got it working you can make the
final build a non-debug one.)

> Also,  I use si and n in gdb to see what happened in this QEMU library
> it showed  that the address and content of *rcu_registry_lock* would change
> when it executed qemu_thread_create() in util/rcu.c:315
>
> $ qemu_thread_create(&thread, "cal_rcu", call_rcu_thread, NULL,
> QEMU_THREAD_DETACHED)
>
> This change caused the failure of assert(mutex->initialized) in
> qemu_mutex_lock (which called by rcu_register_thread() in call_rcu_thread())

That's odd, because mutex->initialized is supposed to be
set by qemu_mutex_init() and then not written until something
calls qemu_mutex_destroy(). If I were you I'd try using debugger
watchpoints to find out where the code is that's overwriting
mutex->initialized.

thanks
-- PMM
