Received: from eggs.gnu.org ([2001:4830:134:3::10]:53668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjAux-0007Qh-Oc
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 15:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjAuv-0003Ri-2C
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 15:32:11 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cjAuu-0003QH-Op
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 15:32:08 -0500
Received: by mail-wr0-x229.google.com with SMTP id l37so38374534wrc.1
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 12:32:08 -0800 (PST)
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
	<877f492ppx.fsf@linaro.org>
	<d3a039e7-77cc-f0de-2b9a-1779009bb7bb@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <d3a039e7-77cc-f0de-2b9a-1779009bb7bb@redhat.com>
Date: Wed, 01 Mar 2017 20:32:07 +0000
Message-ID: <87wpc820xk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] xtensa failure: "tcg_handle_interrupt: assertion
 failed: (qemu_mutex_iothread_locked())"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 01.03.2017 12:36, Alex Bennée wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> I got a make check failure on aarch64 host running a sparc64 test:
>>>
>>>
>>> TEST: tests/prom-env-test... (pid=13573)
>>>   /sparc64/prom-env/sun4u:                                             **
>>> ERROR:/home/pm215/qemu/translate-common.c:34:tcg_handle_interrupt:
>>> assertion failed: (qemu_mutex_iothread_locked())
> [...]
>> What will be useful for all these reports is the backtrace. Then it's
>> fairly simple to identify the thing triggering the interrupt and
>> identify the correct place for the locking.
>
> xtensa-softmmu crashes, too:
>
> #0  0x00007ffff18ef1d7 in raise () at /lib64/libc.so.6
> #1  0x00007ffff18f08c8 in abort () at /lib64/libc.so.6
> #2  0x00007ffff2f642a5 in g_assertion_message () at /lib64/libglib-2.0.so.0
> #3  0x00007ffff2f6433a in g_assertion_message_expr () at /lib64/libglib-2.0.so.0
> #4  0x00005555555e5411 in tcg_handle_interrupt (cpu=0x555555fec400, mask=2) at /home/thuth/devel/qemu/translate-common.c:34
> #5  0x000055555563d2e7 in check_interrupts (mask=2, cpu=0x555555fec400) at /home/thuth/devel/qemu/include/qom/cpu.h:801
> #6  0x000055555563d2e7 in check_interrupts (env=0x555555ff4690) at /home/thuth/devel/qemu/hw/xtensa/pic_cpu.c:44
> #7  0x00007fffe5ab66da in code_gen_buffer ()
> #8  0x00005555555e4a51 in cpu_exec (itb=<optimized out>, itb=<optimized out>, cpu=0x7fffe51bf3c0)
>     at /home/thuth/devel/qemu/cpu-exec.c:165
> #9  0x00005555555e4a51 in cpu_exec (sc=0x7fffe51bc9b0, tb_exit=<synthetic pointer>, last_tb=<synthetic pointer>, tb=<optimized out>, cpu=0x7fffe51bf3c0) at /home/thuth/devel/qemu/cpu-exec.c:584
> #10 0x00005555555e4a51 in cpu_exec (cpu=cpu@entry=0x555555fec400) at /home/thuth/devel/qemu/cpu-exec.c:686
> #11 0x000055555560e89a in tcg_cpu_exec (cpu=0x555555fec400) at /home/thuth/devel/qemu/cpus.c:1251
> #12 0x000055555560ebd4 in qemu_tcg_rr_cpu_thread_fn (arg=<optimized out>) at /home/thuth/devel/qemu/cpus.c:1347
> #13 0x00007ffff53b3dc5 in start_thread () at /lib64/libpthread.so.0
> #14 0x00007ffff19b173d in clone () at /lib64/libc.so.6
>
> IIRC I once downloaded that image from http://wiki.qemu-project.org/Testing/System_Images

Ok this is fixed with:

  https://github.com/stsquad/qemu/commit/dcce964cec4b9519d31a1791e1996c6bb3c186b8

However I ran into another problem. Code generation leads to a tlb_fill
which runs afoul of a nested tb_lock(). I'm pretty sure the front-end is
using the wrong thing to fetch code:

  #0  0x00007fffdf2c5428 in __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:54
  #1  0x00007fffdf2c702a in __GI_abort () at abort.c:89
  #2  0x00007fffdf2bdbd7 in __assert_fail_base (fmt=<optimised out>, assertion=assertion@entry=0x5555558b3256 "!have_tb_lock", file=file@entry=0x5555558b31e0 "/home/alex/lsrc/qemu/qemu.git/translate-all.c", line=line@entry=165, function=function@entry=0x5555558b3588 <__PRETTY_FUNCTION__.26299> "tb_lock") at assert.c:92
  #3  0x00007fffdf2bdc82 in __GI___assert_fail (assertion=0x5555558b3256 "!have_tb_lock", file=0x5555558b31e0 "/home/alex/lsrc/qemu/qemu.git/translate-all.c", line=165, function=0x5555558b3588 <__PRETTY_FUNCTION__.26299> "tb_lock") at assert.c:101
  #4  0x00005555555da9c7 in tb_lock () at /home/alex/lsrc/qemu/qemu.git/translate-all.c:165
  #5  0x00005555555daec0 in cpu_restore_state (cpu=0x5555560ff4f0, retaddr=0) at /home/alex/lsrc/qemu/qemu.git/translate-all.c:336
  #6  0x00005555556652d5 in tlb_fill (cs=0x5555560ff4f0, vaddr=537034752, access_type=MMU_INST_FETCH, mmu_idx=1, retaddr=0) at /home/alex/lsrc/qemu/qemu.git/target/xtensa/op_helper.c:73
  #7  0x0000555555636b21 in helper_ret_ldb_cmmu (env=0x555556107780, addr=537034752, oi=1, retaddr=0) at /home/alex/lsrc/qemu/qemu.git/softmmu_template.h:127
  #8  0x0000555555657638 in cpu_ldub_code_ra (env=0x555556107780, ptr=537034752, retaddr=0) at /home/alex/lsrc/qemu/qemu.git/include/exec/cpu_ldst_template.h:102
  #9  0x00005555556576aa in cpu_ldub_code (env=0x555556107780, ptr=537034752) at /home/alex/lsrc/qemu/qemu.git/include/exec/cpu_ldst_template.h:114
  #10 0x00005555556596c8 in disas_xtensa_insn (env=0x555556107780, dc=0x7fffcca0f4f0) at /home/alex/lsrc/qemu/qemu.git/target/xtensa/translate.c:1052
  #11 0x00005555556646d1 in gen_intermediate_code (env=0x555556107780, tb=0x7fffccc7d770) at /home/alex/lsrc/qemu/qemu.git/target/xtensa/translate.c:3214
  #12 0x00005555555dbf00 in tb_gen_code (cpu=0x5555560ff4f0, pc=537034751, cs_base=0, flags=229393, cflags=0) at /home/alex/lsrc/qemu/qemu.git/translate-all.c:1281
  #13 0x00005555555de436 in tb_find (cpu=0x5555560ff4f0, last_tb=0x0, tb_exit=0) at /home/alex/lsrc/qemu/qemu.git/cpu-exec.c:370
  #14 0x00005555555decaa in cpu_exec (cpu=0x5555560ff4f0) at /home/alex/lsrc/qemu/qemu.git/cpu-exec.c:685
  #15 0x0000555555610643 in tcg_cpu_exec (cpu=0x5555560ff4f0) at /home/alex/lsrc/qemu/qemu.git/cpus.c:1254
  #16 0x00005555556108b8 in qemu_tcg_rr_cpu_thread_fn (arg=0x5555560ff4f0) at /home/alex/lsrc/qemu/qemu.git/cpus.c:1350
  #17 0x00007fffdf6606ba in start_thread (arg=0x7fffcca12700) at pthread_create.c:333
  #18 0x00007fffdf39682d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:109


--
Alex Bennée
