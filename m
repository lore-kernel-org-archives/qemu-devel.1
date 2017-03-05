Received: from eggs.gnu.org ([2001:4830:134:3::10]:48631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ckdlv-0000oh-2K
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ckdlc-0000h6-8m
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:32:54 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ckdlb-0000fb-Ux
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:32:36 -0500
Received: by mail-wm0-x236.google.com with SMTP id n11so50743515wma.0
	for <qemu-devel@nongnu.org>; Sun, 05 Mar 2017 13:32:34 -0800 (PST)
References: <49fcb3c4-df9d-ec64-2927-71c02fc2524b@genode-labs.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <49fcb3c4-df9d-ec64-2927-71c02fc2524b@genode-labs.com>
Date: Sun, 05 Mar 2017 21:32:38 +0000
Message-ID: <87r32bif49.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Qemu deadlocks in tb_lock when using SVM+SoftMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, fred.konrad@greensocs.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com


Alexander Boettcher <alexander.boettcher@genode-labs.com> writes:

> Hello,
>
> beginning with commit 3bd1d74576bacb120949e13cdeded7a0c792c685
>
> "cputlb: introduce tlb_flush_* async work"
>
> using Qemu with SoftMMU+SVM virtualization deadlocks because tb_lock is
> taken second time in cputlb.c tlb_flush_nocheck() function. The first
> time tb_lock is taken, according to my debugging, in cpu-exex.c
> tb_find() line 361.

<inlining the backtrace>
> (gdb) info threads
>   Id   Target Id         Frame
> * 1    Thread 0x7ffbc19d3c00 (LWP 8396) "qemu-system-x86"
> 0x00007ffbbfd2ac21 in __GI_ppoll (fds=0x273a330, nfds=6,
>     timeout=<optimized out>, sigmask=0x0) at
> ../sysdeps/unix/sysv/linux/ppoll.c:50
>   2    Thread 0x7ffbbb970700 (LWP 8397) "qemu-system-x86" syscall () at
> ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
>   3    Thread 0x7ffbb8206700 (LWP 8399) "qemu-system-x86" __lll_lock_wait ()
>     at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
> (gdb) thread 3
> [Switching to thread 3 (Thread 0x7ffbb8206700 (LWP 8399))]
> #0  __lll_lock_wait () at
> ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
> 135	../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S: No such file or
> directory.
> (gdb) bt
> #0  __lll_lock_wait () at
> ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
> #1  0x00007ffbc0002dbd in __GI___pthread_mutex_lock (mutex=0xf6ea18
> <tcg_ctx+280>) at ../nptl/pthread_mutex_lock.c:80
> #2  0x000000000089852c in qemu_mutex_lock (mutex=0xf6ea18 <tcg_ctx+280>)
> at util/qemu-thread-posix.c:60
> #3  0x0000000000416103 in tb_lock () at qemu.git/translate-all.c:166
> #4  0x000000000046e8d7 in tlb_flush_nocheck (cpu=0x164a360) at
> qemu.git/cputlb.c:93
> #5  0x000000000046ea2e in tlb_flush (cpu=0x164a360) at qemu.git/cputlb.c:121
> #6  0x0000000000538987 in cpu_x86_update_cr4 (env=0x16525f0, new_cr4=1784)
>     at qemu.git/target/i386/helper.c:660
> #7  0x000000000055e318 in cpu_vmexit (env=0x16525f0, exit_code=78,
> exit_info_1=4, retaddr=0)
>     at qemu.git/target/i386/svm_helper.c:689
> #8  0x000000000055d9b7 in cpu_svm_check_intercept_param (env=0x16525f0,
> type=78, param=4, retaddr=0)
>     at qemu.git/target/i386/svm_helper.c:511
> #9  0x0000000000541acf in raise_interrupt2 (env=0x16525f0, intno=14,
> is_int=0, error_code=4, next_eip_addend=0, retaddr=0)
>     at qemu.git/target/i386/excp_helper.c:96
> #10 0x0000000000541c0d in raise_exception_err_ra (env=0x16525f0,
> exception_index=14, error_code=4, retaddr=0)
>     at qemu.git/target/i386/excp_helper.c:127
> #11 0x00000000005621a9 in tlb_fill (cs=0x164a360, addr=1245184,
> access_type=MMU_INST_FETCH, mmu_idx=1, retaddr=0)
>     at qemu.git/target/i386/mem_helper.c:212

Richard,

So this looks like another path through the SoftMMU code during
code-generation (which is why tb_lock() is held in the first place). I'm
not sure if the correct thing to do is bug out earlier or to defer the
exception raising part to async work and exit the loop.


> #12 0x0000000000476c15 in helper_ret_ldb_cmmu (env=0x16525f0,
> addr=1245184, oi=1, retaddr=0)
>     at qemu.git/softmmu_template.h:127
> #13 0x000000000051c86e in cpu_ldub_code_ra (env=0x16525f0, ptr=1245184,
> retaddr=0)
>     at qemu.git/include/exec/cpu_ldst_template.h:102
> #14 0x000000000051c8e4 in cpu_ldub_code (env=0x16525f0, ptr=1245184)
>     at qemu.git/include/exec/cpu_ldst_template.h:114
> #15 0x0000000000522182 in insn_get (env=0x16525f0, s=0x7ffbb82057e0,
> ot=MO_8)
>     at qemu.git/target/i386/translate.c:2107
> #16 0x000000000052ff3c in disas_insn (env=0x16525f0, s=0x7ffbb82057e0,
> pc_start=1245183)
>     at qemu.git/target/i386/translate.c:6520
> #17 0x0000000000536458 in gen_intermediate_code (env=0x16525f0,
> tb=0x7ffbb9ce3a38)
>     at qemu.git/target/i386/translate.c:8449
> ---Type <return> to continue, or q <return> to quit---
> #18 0x0000000000417616 in tb_gen_code (cpu=0x164a360, pc=1245179,
> cs_base=0, flags=7342771, cflags=0)
>     at qemu.git/translate-all.c:1281
> #19 0x000000000041993c in tb_find (cpu=0x164a360, last_tb=0x0,
> tb_exit=0) at qemu.git/cpu-exec.c:370
> #20 0x000000000041a25b in cpu_exec (cpu=0x164a360) at
> qemu.git/cpu-exec.c:685
> #21 0x000000000044b078 in tcg_cpu_exec (cpu=0x164a360) at
> qemu.git/cpus.c:1251
> #22 0x000000000044b2e7 in qemu_tcg_rr_cpu_thread_fn (arg=0x164a360) at
> qemu.git/cpus.c:1347
> #23 0x00007ffbc00006ba in start_thread (arg=0x7ffbb8206700) at
> pthread_create.c:333
> #24 0x00007ffbbfd3682d in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:109
>

>
> I'm using Qemu with:
>
> qemu-system-x86_64 -s -no-kvm -display sdl -m 512 -cpu phenom -nographic
> -cdrom genode.iso
>
> When building with
> ./configure --target-list=x86_64-softmmu --enable-debug --disable-pie
> --enable-debug-tcg
>
> I get also a
>
> translate-all.c:165: tb_lock: Assertion `!have_tb_lock' failed.
>
> beginning with commit 3bd1d74576bacb120949e13cdeded7a0c792c685. Before
> the commit all is fine.
>
> Since I'm not very familiar with Qemu internals, it is not clear to me
> whether this commit breaks things or whether something must be
> handled/added special somewhere else. I attached below the backtrace of
> Qemu when it hangs in tb_lock.
>
> In [0] my branch based on 3bd1d74576bacb120949e13cdeded7a0c792c685 is
> used and [1] contains the iso image, if somebody wants try to reproduce it.
>
> [0] https://github.com/alex-ab/qemu/commits/genode_svm_issue
> [1]
> https://github.com/alex-ab/qemu/commit/1130fee3b04dd2bee576241de9a5771d6855b327
>
> Thanks in advance,
>
> Alex.


--
Alex Bennée
