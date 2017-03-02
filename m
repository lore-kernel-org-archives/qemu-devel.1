Received: from eggs.gnu.org ([2001:4830:134:3::10]:37312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjQIH-00054c-Gp
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 07:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjQIC-0008QE-T4
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 07:57:17 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:38858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cjQIC-0008PS-Mg
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 07:57:12 -0500
Received: by mail-wm0-x22f.google.com with SMTP id t193so10717485wmt.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 04:57:12 -0800 (PST)
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
	<877f492ppx.fsf@linaro.org>
	<d3a039e7-77cc-f0de-2b9a-1779009bb7bb@redhat.com>
	<7d21bd42-db77-aa47-b0a4-fdeeaacf9d9d@imgtec.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <7d21bd42-db77-aa47-b0a4-fdeeaacf9d9d@imgtec.com>
Date: Thu, 02 Mar 2017 12:57:12 +0000
Message-ID: <87tw7b25w7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] mips failure: "tcg_handle_interrupt: assertion
 failed: (qemu_mutex_iothread_locked())"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


Yongbok Kim <yongbok.kim@imgtec.com> writes:

> On 01/03/2017 18:41, Thomas Huth wrote:
>> On 01.03.2017 12:36, Alex Bennée wrote:
>>>
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>>> I got a make check failure on aarch64 host running a sparc64 test:
>>>>
>>>>
>>>> TEST: tests/prom-env-test... (pid=13573)
>>>>   /sparc64/prom-env/sun4u:                                             **
>>>> ERROR:/home/pm215/qemu/translate-common.c:34:tcg_handle_interrupt:
>>>> assertion failed: (qemu_mutex_iothread_locked())
>> [...]
>>> What will be useful for all these reports is the backtrace. Then it's
>>> fairly simple to identify the thing triggering the interrupt and
>>> identify the correct place for the locking.
>>
>> xtensa-softmmu crashes, too:
>>
>
>
>
> Hi,
>
> mips softmmu crashes as well.
>
> **
> ERROR:/user/ygk/qemu/master/translate-common.c:34:tcg_handle_interrupt:
> assertion failed: (qemu_mutex_iothread_locked())

So in my next series I'm going to downgrade these assertions to
--enable-debug-tcg builds as otherwise its going to be a bit
whack-a-mole frontends that have yet to be converted to be MTTCG
capable.

That said:

>
> Program received signal SIGABRT, Aborted.
> [Switching to Thread 0x7fffc986d700 (LWP 17296)]
> 0x00007ffff5690635 in raise () from /lib64/libc.so.6
> Missing separate debuginfos, use: debuginfo-install
> bzip2-libs-1.0.5-7.el6_0.x86_64 glib2-2.28.8-4.el6.x86_64
> glibc-2.12-1.132.el6_5.4.x86_64 libgcc-4.4.7-11.el6.x86_64
> libstdc++-4.4.7-11.el6.x86_64 z
> lib-1.2.3-29.el6.x86_64
> (gdb) where
> #0  0x00007ffff5690635 in raise () from /lib64/libc.so.6
> #1  0x00007ffff5691e15 in abort () from /lib64/libc.so.6
> #2  0x00007ffff6416324 in g_assertion_message () from /lib64/libglib-2.0.so.0
> #3  0x00007ffff64168f0 in g_assertion_message_expr () from
> /lib64/libglib-2.0.so.0
> #4  0x00007ffff7578a6f in tcg_handle_interrupt (cpu=0x7ffff8aba600, mask=2)
> at /user/ygk/qemu/master/translate-common.c:34
> #5  0x00007ffff7659b2e in cpu_interrupt (cpu=0x7ffff8aba600, mask=2) at
> /user/ygk/qemu/master/include/qom/cpu.h:801
> #6  0x00007ffff7659c5c in cpu_mips_irq_request (opaque=0x7ffff8aba600,
> irq=7, level=1) at /user/ygk/qemu/master/hw/mips/mips_int.c:55
> #7  0x00007ffff77b9f3d in qemu_set_irq (irq=0x7ffff8aecc10, level=1) at
> /user/ygk/qemu/master/hw/core/irq.c:45
> #8  0x00007ffff765937c in qemu_irq_raise (irq=0x7ffff8aecc10) at
> /user/ygk/qemu/master/include/hw/irq.h:16
> #9  0x00007ffff76596ea in cpu_mips_timer_expire (env=0x7ffff8ac2890) at
> /user/ygk/qemu/master/hw/mips/cputimer.c:73
> #10 0x00007ffff7659789 in cpu_mips_get_count (env=0x7ffff8ac2890) at
> /user/ygk/qemu/master/hw/mips/cputimer.c:87

This is the division between cpu emulation and hw emulation where the
BQL should be taken. So I think helper_mfc0_count and helper_rdhwr_cc
should wrap their calls into the HW emulation with a BQL lock.

> #11 0x00007ffff76d2056 in helper_mfc0_count (env=0x7ffff8ac2890) at
> /user/ygk/qemu/master/target/mips/op_helper.c:830
> #12 0x00007fffd4e328b1 in code_gen_buffer ()
> #13 0x00007ffff75778f1 in cpu_tb_exec (cpu=0x7ffff8aba600,
> itb=0x7fffcb37d9f0) at /user/ygk/qemu/master/cpu-exec.c:165
> #14 0x00007ffff75786ca in cpu_loop_exec_tb (cpu=0x7ffff8aba600,
> tb=0x7fffcb37d9f0, last_tb=0x7fffc986caa0, tb_exit=0x7fffc986cab0,
> sc=0x7fffc986ca80) at /user/ygk/qemu/master/cpu-exec.c:584
> #15 0x00007ffff757899a in cpu_exec (cpu=0x7ffff8aba600) at
> /user/ygk/qemu/master/cpu-exec.c:686
> #16 0x00007ffff75b4495 in tcg_cpu_exec (cpu=0x7ffff8aba600) at
> /user/ygk/qemu/master/cpus.c:1251
> #17 0x00007ffff75b4769 in qemu_tcg_rr_cpu_thread_fn (arg=0x7ffff8aba600) at
> /user/ygk/qemu/master/cpus.c:1347
> #18 0x00007ffff59f99d1 in start_thread () from /lib64/libpthread.so.0
> #19 0x00007ffff574686d in clone () from /lib64/libc.so.6
> (gdb)
>
> Regards,
> Yongbok


--
Alex Bennée
