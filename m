Received: from eggs.gnu.org ([2001:4830:134:3::10]:57921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <debby83729@gmail.com>) id 1fIOjj-0001zE-QP
	for qemu-devel@nongnu.org; Mon, 14 May 2018 21:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <debby83729@gmail.com>) id 1fIOji-0005g3-9b
	for qemu-devel@nongnu.org; Mon, 14 May 2018 21:26:43 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:33436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <debby83729@gmail.com>)
	id 1fIOjh-0005a6-UF
	for qemu-devel@nongnu.org; Mon, 14 May 2018 21:26:42 -0400
Received: by mail-wm0-x22c.google.com with SMTP id x12-v6so13863308wmc.0
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 18:26:41 -0700 (PDT)
MIME-Version: 1.0
From: Eva Chen <debby83729@gmail.com>
Date: Tue, 15 May 2018 09:26:19 +0800
Message-ID: <CAG0V3WQCJ-ttZNo3A4tLy3Y=QADhfk8VaDFRRbrLjNBRWYw63w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Question about io_writex()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

I want to know the flow of how devices read/write function be called by
code_gen_buffer().
Take pl110_write() for example, I set a breakpoint in  pl110_write(), and
the backtrace shows bellow.

(gdb)
#0 * pl110_write* (opaque=0x555556e8f3f0, offset=28, val=0, size=4) at
hw/display/pl110.c:378
#1  0x00005555557e398b in memory_region_write_accessor (mr=0x555556e8f6f0,
addr=28, value=<optimized out>, size=4, shift=<optimized out>,
mask=<optimized out>,
    attrs=...) at
/home/jerry/qemu_new-2.10.0-rc4/qemu-2.10.0-rc4/memory.c:529
#2  0x00005555557e031b in access_with_adjusted_size (addr=addr@entry=28,
value=value@entry=0x7fffe821b3f8, size=size@entry=4,
access_size_min=<optimized out>,
    access_size_max=<optimized out>, access=access@entry=0x5555557e3910
<memory_region_write_accessor>, mr=mr@entry=0x555556e8f6f0,
attrs=attrs@entry=...)
    at /home/jerry/qemu_new-2.10.0-rc4/qemu-2.10.0-rc4/memory.c:595
#3  0x00005555557e4d0b in memory_region_dispatch_write (mr=<optimized out>,
addr=28, data=data@entry=0, size=size@entry=4, attrs=...)
    at /home/jerry/qemu_new-2.10.0-rc4/qemu-2.10.0-rc4/memory.c:1337
#4  0x0000555555776eae in* io_writex* (env=0x5555568294f0,
iotlbentry=0x555556839a18, val=0, addr=3498860572, retaddr=<optimized out>,
size=4)
    at
/home/jerry/qemu_new-2.10.0-rc4/qemu-2.10.0-rc4/accel/tcg/cputlb.c:798
#5  0x00007fffe95609fc in code_gen_buffer ()
#6  0x00005555557fe0d5 in cpu_tb_exec (itb=<optimized out>, itb=<optimized
out>, cpu=0x7fffe95608c0 <code_gen_buffer+9767062>)
    at
/home/jerry/qemu_new-2.10.0-rc4/qemu-2.10.0-rc4/accel/tcg/cpu-exec.c:166
#7  cpu_loop_exec_tb (tb_exit=<synthetic pointer>, last_tb=<synthetic
pointer>, tb=<optimized out>, cpu=0x7fffe95608c0 <code_gen_buffer+9767062>)
    at
/home/jerry/qemu_new-2.10.0-rc4/qemu-2.10.0-rc4/accel/tcg/cpu-exec.c:578
#8  cpu_exec (cpu=cpu@entry=0x555556821260) at
/home/jerry/qemu_new-2.10.0-rc4/qemu-2.10.0-rc4/accel/tcg/cpu-exec.c:676
#9  0x00005555557cf527 in tcg_cpu_exec (cpu=0x555556821260) at
/home/jerry/qemu_new-2.10.0-rc4/qemu-2.10.0-rc4/cpus.c:1270
#10 qemu_tcg_cpu_thread_fn (arg=0x555556821260) at
/home/jerry/qemu_new-2.10.0-rc4/qemu-2.10.0-rc4/cpus.c:1473
#11 0x00007ffff46b0184 in start_thread (arg=0x7fffe821c700) at
pthread_create.c:312
#12 0x00007ffff43dcffd in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

This backtrace shows that pl110_write() is called by io_wrtex(), but I
can't find who call the io_writex().
code_gen_buffer() is the part that QEMU execute the TB, I think maybe
io_writex() is called by the helper function but I only find io_writex() in
softmmu_template.h (*static inline void glue(io_write, SUFFIX)), *which is
not related to the helper function.
Could I bother you to explain more about how io_writex() to be called and
any method that recommended for others that want to trace the flow of
device read/write()?

I will be grateful for any advice, thanks.


Sincerely,
Eva
