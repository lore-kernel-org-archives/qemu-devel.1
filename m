Received: from eggs.gnu.org ([2001:4830:134:3::10]:34614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ckZVv-0006py-TK
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 12:00:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ckZVs-0003lw-N7
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 12:00:08 -0500
Received: from mail.genode-labs.com ([88.198.56.169]:51667)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ckZVs-0003ka-Bc
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 12:00:04 -0500
From: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Message-ID: <49fcb3c4-df9d-ec64-2927-71c02fc2524b@genode-labs.com>
Date: Sun, 5 Mar 2017 17:59:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Qemu deadlocks in tb_lock when using SVM+SoftMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, rth@twiddle.net, fred.konrad@greensocs.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com

Hello,

beginning with commit 3bd1d74576bacb120949e13cdeded7a0c792c685

"cputlb: introduce tlb_flush_* async work"

using Qemu with SoftMMU+SVM virtualization deadlocks because tb_lock is
taken second time in cputlb.c tlb_flush_nocheck() function. The first
time tb_lock is taken, according to my debugging, in cpu-exex.c
tb_find() line 361.

I'm using Qemu with:

qemu-system-x86_64 -s -no-kvm -display sdl -m 512 -cpu phenom -nographic
-cdrom genode.iso

When building with
./configure --target-list=3Dx86_64-softmmu --enable-debug --disable-pie
--enable-debug-tcg

I get also a

translate-all.c:165: tb_lock: Assertion `!have_tb_lock' failed.

beginning with commit 3bd1d74576bacb120949e13cdeded7a0c792c685. Before
the commit all is fine.

Since I'm not very familiar with Qemu internals, it is not clear to me
whether this commit breaks things or whether something must be
handled/added special somewhere else. I attached below the backtrace of
Qemu when it hangs in tb_lock.

In [0] my branch based on 3bd1d74576bacb120949e13cdeded7a0c792c685 is
used and [1] contains the iso image, if somebody wants try to reproduce i=
t.

[0] https://github.com/alex-ab/qemu/commits/genode_svm_issue
[1]
https://github.com/alex-ab/qemu/commit/1130fee3b04dd2bee576241de9a5771d68=
55b327

Thanks in advance,

Alex.

--=20
Alexander Boettcher
Genode Labs

http://www.genode-labs.com - http://www.genode.org

Genode Labs GmbH - Amtsgericht Dresden - HRB 28424 - Sitz Dresden
Gesch=C3=A4ftsf=C3=BChrer: Dr.-Ing. Norman Feske, Christian Helmuth




[init -> log_terminal]
[init -> log_terminal] [ 0] CORE:0:0:0 10:2:3:0 [0] AMD Phenom(tm) 9550
Quad-Core Processor
qemu-system-x86_64: qemu.git/translate-all.c:165: tb_lock: Assertion
`!have_tb_lock' failed.




(gdb) info threads
  Id   Target Id         Frame
* 1    Thread 0x7ffbc19d3c00 (LWP 8396) "qemu-system-x86"
0x00007ffbbfd2ac21 in __GI_ppoll (fds=3D0x273a330, nfds=3D6,
    timeout=3D<optimized out>, sigmask=3D0x0) at
../sysdeps/unix/sysv/linux/ppoll.c:50
  2    Thread 0x7ffbbb970700 (LWP 8397) "qemu-system-x86" syscall () at
../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
  3    Thread 0x7ffbb8206700 (LWP 8399) "qemu-system-x86" __lll_lock_wait=
 ()
    at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
(gdb) thread 3
[Switching to thread 3 (Thread 0x7ffbb8206700 (LWP 8399))]
#0  __lll_lock_wait () at
../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
135	../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S: No such file or
directory.
(gdb) bt
#0  __lll_lock_wait () at
../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
#1  0x00007ffbc0002dbd in __GI___pthread_mutex_lock (mutex=3D0xf6ea18
<tcg_ctx+280>) at ../nptl/pthread_mutex_lock.c:80
#2  0x000000000089852c in qemu_mutex_lock (mutex=3D0xf6ea18 <tcg_ctx+280>=
)
at util/qemu-thread-posix.c:60
#3  0x0000000000416103 in tb_lock () at qemu.git/translate-all.c:166
#4  0x000000000046e8d7 in tlb_flush_nocheck (cpu=3D0x164a360) at
qemu.git/cputlb.c:93
#5  0x000000000046ea2e in tlb_flush (cpu=3D0x164a360) at qemu.git/cputlb.=
c:121
#6  0x0000000000538987 in cpu_x86_update_cr4 (env=3D0x16525f0, new_cr4=3D=
1784)
    at qemu.git/target/i386/helper.c:660
#7  0x000000000055e318 in cpu_vmexit (env=3D0x16525f0, exit_code=3D78,
exit_info_1=3D4, retaddr=3D0)
    at qemu.git/target/i386/svm_helper.c:689
#8  0x000000000055d9b7 in cpu_svm_check_intercept_param (env=3D0x16525f0,
type=3D78, param=3D4, retaddr=3D0)
    at qemu.git/target/i386/svm_helper.c:511
#9  0x0000000000541acf in raise_interrupt2 (env=3D0x16525f0, intno=3D14,
is_int=3D0, error_code=3D4, next_eip_addend=3D0, retaddr=3D0)
    at qemu.git/target/i386/excp_helper.c:96
#10 0x0000000000541c0d in raise_exception_err_ra (env=3D0x16525f0,
exception_index=3D14, error_code=3D4, retaddr=3D0)
    at qemu.git/target/i386/excp_helper.c:127
#11 0x00000000005621a9 in tlb_fill (cs=3D0x164a360, addr=3D1245184,
access_type=3DMMU_INST_FETCH, mmu_idx=3D1, retaddr=3D0)
    at qemu.git/target/i386/mem_helper.c:212
#12 0x0000000000476c15 in helper_ret_ldb_cmmu (env=3D0x16525f0,
addr=3D1245184, oi=3D1, retaddr=3D0)
    at qemu.git/softmmu_template.h:127
#13 0x000000000051c86e in cpu_ldub_code_ra (env=3D0x16525f0, ptr=3D124518=
4,
retaddr=3D0)
    at qemu.git/include/exec/cpu_ldst_template.h:102
#14 0x000000000051c8e4 in cpu_ldub_code (env=3D0x16525f0, ptr=3D1245184)
    at qemu.git/include/exec/cpu_ldst_template.h:114
#15 0x0000000000522182 in insn_get (env=3D0x16525f0, s=3D0x7ffbb82057e0,
ot=3DMO_8)
    at qemu.git/target/i386/translate.c:2107
#16 0x000000000052ff3c in disas_insn (env=3D0x16525f0, s=3D0x7ffbb82057e0=
,
pc_start=3D1245183)
    at qemu.git/target/i386/translate.c:6520
#17 0x0000000000536458 in gen_intermediate_code (env=3D0x16525f0,
tb=3D0x7ffbb9ce3a38)
    at qemu.git/target/i386/translate.c:8449
---Type <return> to continue, or q <return> to quit---
#18 0x0000000000417616 in tb_gen_code (cpu=3D0x164a360, pc=3D1245179,
cs_base=3D0, flags=3D7342771, cflags=3D0)
    at qemu.git/translate-all.c:1281
#19 0x000000000041993c in tb_find (cpu=3D0x164a360, last_tb=3D0x0,
tb_exit=3D0) at qemu.git/cpu-exec.c:370
#20 0x000000000041a25b in cpu_exec (cpu=3D0x164a360) at
qemu.git/cpu-exec.c:685
#21 0x000000000044b078 in tcg_cpu_exec (cpu=3D0x164a360) at
qemu.git/cpus.c:1251
#22 0x000000000044b2e7 in qemu_tcg_rr_cpu_thread_fn (arg=3D0x164a360) at
qemu.git/cpus.c:1347
#23 0x00007ffbc00006ba in start_thread (arg=3D0x7ffbb8206700) at
pthread_create.c:333
#24 0x00007ffbbfd3682d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109
