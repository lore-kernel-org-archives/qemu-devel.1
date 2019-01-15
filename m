Received: from eggs.gnu.org ([209.51.188.92]:49386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gjEnd-0005By-G7
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 21:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gjEnc-0007Kh-Fm
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 21:49:57 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30]:45087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gjEnc-0007KV-Bi
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 21:49:56 -0500
Received: by mail-yb1-xb30.google.com with SMTP id n78so473162yba.12
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 18:49:56 -0800 (PST)
MIME-Version: 1.0
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 14 Jan 2019 18:49:43 -0800
Message-ID: <CAMo8BfKWwT13TkBJ-C_kwYCkTcYY_Tq1vvGzanCzeDBRgTUzeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] MTTCG qemu-softmmu aborted on watchpoint hit by atomic
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: "Emilio G . Cota" <cota@braap.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

Hello,

I tried to debug guest application on SMP xtensa softmmu QEMU
through the gdbserver and found that QEMU aborts when guest
uses atomic operation to modify memory location watched by the
debugger. It exits with the following message:

ERROR: cpus.c:1848:qemu_mutex_lock_iothread_impl: assertion failed:
(!qemu_mutex_iothread_locked())

and the reason is that io_writex invoked from the atomic operation
calls qemu_mutex_lock_iothread but doesn't have a chance to call
qemu_mutex_unlock_iothread, because it exits the cpu loop at the
following place:

#0  __libc_siglongjmp (env=0x55555628c720, val=1) at longjmp.c:28
#1  0x000055555577ef24 in cpu_loop_exit (cpu=0x55555628c660) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/accel/tcg/cpu-exec-common.c:68
#2  0x00005555556e23dd in check_watchpoint (offset=3700, len=4,
attrs=..., flags=2) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/exec.c:2762
#3  0x00005555556e2603 in watch_mem_write (opaque=0x0, addr=14687860,
val=1, size=4, attrs=...) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/exec.c:2815
#4  0x0000555555744f8e in memory_region_write_with_attrs_accessor
(mr=0x5555561c6c00 <io_mem_watch>, addr=14687860,
value=0x7fffecfcb348, size=4, shift=0, mask=4294967295, attrs=...) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/memory.c:529
#5  0x00005555557450ad in access_with_adjusted_size (addr=14687860,
value=0x7fffecfcb348, size=4, access_size_min=1, access_size_max=8,
access_fn=0x555555744ea1 <memory_region_write_with_attrs_accessor>,
mr=0x5555561c6c00 <io_mem_watch>, attrs=...)
    at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/memory.c:570
#6  0x0000555555747d2c in memory_region_dispatch_write
(mr=0x5555561c6c00 <io_mem_watch>, addr=14687860, data=1, size=4,
attrs=...) at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/memory.c:1459
#7  0x000055555576075e in io_writex (env=0x555556294910,
iotlbentry=0x55555629de50, mmu_idx=0, val=1, addr=3504348788,
retaddr=140737170398881, recheck=false, size=4) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/accel/tcg/cputlb.c:795
#8  0x0000555555762652 in io_writel (env=0x555556294910, mmu_idx=0,
index=1, val=1, addr=3504348788, retaddr=140737170398881,
recheck=false) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/accel/tcg/softmmu_template.h:273
#9  0x00005555557627fe in helper_le_stl_mmu (env=0x555556294910,
addr=3504348788, val=1, oi=32, retaddr=140737170398881) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/accel/tcg/softmmu_template.h:310
#10 0x00007fffed0c5ea1 in code_gen_buffer ()
#11 0x000055555577dc59 in cpu_tb_exec (cpu=0x55555628c660,
itb=0x7fffed0c5d40 <code_gen_buffer+1019155>) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/accel/tcg/cpu-exec.c:171
#12 0x000055555577dfa1 in cpu_exec_step_atomic (cpu=0x55555628c660) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/accel/tcg/cpu-exec.c:259
#13 0x000055555572ab43 in qemu_tcg_cpu_thread_fn (arg=0x55555628c660)
at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpus.c:1751
#14 0x0000555555a6052e in qemu_thread_start (args=0x5555562ad9f0) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/util/qemu-thread-posix.c:498
#15 0x00007ffff52f5494 in start_thread (arg=0x7fffecfcc700) at
pthread_create.c:333
#16 0x00007ffff5037acf in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:97


It doesn't look like an xtensa-specific issue, any idea how to fix it?

-- 
Thanks.
-- Max
