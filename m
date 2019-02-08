Received: from eggs.gnu.org ([209.51.188.92]:55218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gsDGd-0005LM-0g
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gsDGb-0001iq-Sr
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:00:58 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31]:44340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gsDGb-0001i5-MM
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:00:57 -0500
Received: by mail-yb1-xb31.google.com with SMTP id k189so1952079yba.11
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 13:00:57 -0800 (PST)
MIME-Version: 1.0
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 8 Feb 2019 13:00:44 -0800
Message-ID: <CAMo8BfJ63PaA=0jJs4B03EK7idg8om7cyjud1hMUCRsBwBHrbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] segfault on the mainline qemu-softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

Hello,

after updating to the latest qemu mainline I get segfault with the following
backtrace when I run qemu-system-xtensa:

Thread 3 "qemu-system-xte" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffde9d3700 (LWP 13583)]
0x0000555555794252 in tlb_addr_write (entry=0x7fffdd0d7010) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/include/exec/cpu_ldst.h:134
134         return atomic_read(&entry->addr_write);
(gdb) bt
#0  0x0000555555794252 in tlb_addr_write (entry=0x7fffdd0d7010) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/include/exec/cpu_ldst.h:134
#1  0x00005555557987e7 in helper_le_stl_mmu (env=0x5555563cf6b8,
addr=2680160256, val=4853560, oi=32, retaddr=140736928419195) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/accel/tcg/softmmu_template.h:298
#2  0x00007fffdea00d7b in code_gen_buffer ()
#3  0x00005555557b486b in cpu_tb_exec (cpu=0x5555563c7400,
itb=0x7fffde9e0e40 <code_gen_buffer+52755>) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/accel/tcg/cpu-exec.c:171
#4  0x00005555557b5649 in cpu_loop_exec_tb (cpu=0x5555563c7400,
tb=0x7fffde9e0e40 <code_gen_buffer+52755>, last_tb=0x7fffde9d29d8,
tb_exit=0x7fffde9d29d0) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/accel/tcg/cpu-exec.c:618
#5  0x00005555557b5945 in cpu_exec (cpu=0x5555563c7400) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/accel/tcg/cpu-exec.c:728
#6  0x000055555575e58e in tcg_cpu_exec (cpu=0x5555563c7400) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpus.c:1429
#7  0x000055555575eda6 in qemu_tcg_cpu_thread_fn (arg=0x5555563c7400)
at /home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/cpus.c:1733
#8  0x0000555555ac7477 in qemu_thread_start (args=0x5555563c1180) at
/home/jcmvbkbc/ws/m/awt/emu/xtensa/qemu/util/qemu-thread-posix.c:502
#9  0x00007ffff54fc494 in start_thread (arg=0x7fffde9d3700) at
pthread_create.c:333
#10 0x00007ffff523eacf in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:97

Bisection points to the following commit:
54eaf40b8f8b ("tcg/i386: enable dynamic TLB sizing").

It can be reproduced with the following command line
(not very deterministic, you may need to log in/out, run
couple commands. root without password):

qemu-system-xtensa -cpu dc233c -monitor null -nographic -M lx60
-serial stdio -kernel Image.elf

The kernel is available here:
http://jcmvbkbc.spb.ru/~dumb/tmp/201902081257/Image.elf

Any idea what it can be?

-- 
Thanks.
-- Max
