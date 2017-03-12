Received: from eggs.gnu.org ([2001:4830:134:3::10]:40836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cn14Y-00005h-KW
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 06:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cn14X-0007Jm-9e
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 06:49:58 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <16ea2d8e-7d41-e323-4df2-cd082080e3db@ilande.co.uk>
Date: Sun, 12 Mar 2017 10:49:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] qemu-system-ppc regression booting MacOS 9.2.1 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: nikunj@linux.vnet.ibm.com
Cc: qemu-devel <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

Hi Nikunj,

Testing git master locally I see the following segfault when trying to
boot my test MacOS 9.2.1 image:


$ gdb --args ./qemu-system-ppc -bios
/home/build/src/openbios/openbios.git/openbios/obj-ppc/openbios-qemu.elf.nostrip
-cdrom /home/build/src/qemu/image/ppc/MacOS921.iso -boot d -m 512 -M mac99
GNU gdb (GDB) 7.4.1-debian
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from /home/build/rel-qemu-git/bin/qemu-system-ppc...done.
(gdb) r
Starting program: /home/build/rel-qemu-git/bin/qemu-system-ppc -bios
/home/build/src/openbios/openbios.git/openbios/obj-ppc/openbios-qemu.elf.nostrip
-cdrom /home/build/src/qemu/image/ppc/MacOS921.iso -boot d -m 512 -M mac99
warning: no loadable sections found in added symbol-file system-supplied
DSO at 0x7ffff7ffa000
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[New Thread 0x7fffe9eee700 (LWP 29713)]
[New Thread 0x7fffe6bf5700 (LWP 29714)]
[New Thread 0x7fffe63f4700 (LWP 29715)]
Trying to write invalid spr 0 (0x000) at 00f113c0
Trying to read invalid spr 0 (0x000) at 00f113c8
Trying to write privileged spr 955 (0x3bb) at 00f164b8
Trying to write invalid spr 959 (0x3bf) at 00f16520
Trying to read invalid spr 959 (0x3bf) at 00f16528
Trying to write privileged spr 955 (0x3bb) at 00f164b8
Trying to write invalid spr 959 (0x3bf) at 00f16520
Trying to read invalid spr 959 (0x3bf) at 00f16528

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffe63f4700 (LWP 29715)]
0x00007ffff7e20010 in ?? ()
(gdb) bt
#0  0x00007ffff7e20010 in ?? ()
#1  0x0000000000000002 in ?? ()
#2  0x0000000068090040 in ?? ()
#3  0x0000000000000002 in ?? ()
#4  0x6b67829c063b8d00 in ?? ()
#5  0x6b67829c063b8d00 in ?? ()
#6  0x000000000043986d in tcg_temp_new_internal_i32
(temp_local=temp_local@entry=0) at
/home/build/src/qemu/git/qemu/tcg/tcg.c:632
#7  0x00000000004434a5 in tcg_temp_new_i32 () at
/home/build/src/qemu/git/qemu/tcg/tcg.h:807
#8  tcg_gen_andc_i32 (ret=0xa, arg1=0x7fffe63f3848, arg2=0x3f) at
/home/build/src/qemu/git/qemu/tcg/tcg-op.c:411
#9  0x00000000005099ad in gen_op_arith_compute_ov (arg0=arg0@entry=0xd7,
arg1=arg1@entry=0x6a, arg2=0xd8, arg2@entry=0xa, sub=sub@entry=0,
ctx=<error reading variable: Unhandled dwarf expression opcode 0xfa>)
    at /home/build/src/qemu/git/qemu/target/ppc/translate.c:821
#10 0x00000000005631b1 in gen_op_arith_add (compute_rc0=true,
compute_ov=true, compute_ca=true, add_ca=false, arg2=0xa, arg1=0x6a,
ret=0x3a, ctx=0x7fffe63f3800) at
/home/build/src/qemu/git/qemu/target/ppc/translate.c:895
#11 gen_addco (ctx=0x7fffe63f3800) at
/home/build/src/qemu/git/qemu/target/ppc/translate.c:931
#12 0x00000000005796ba in gen_intermediate_code
(env=env@entry=0x7ffff7e282a0, tb=tb@entry=0x7fffe6db6a80) at
/home/build/src/qemu/git/qemu/target/ppc/translate.c:7287
#13 0x000000000043381a in tb_gen_code (cpu=cpu@entry=0x7ffff7e20010,
pc=pc@entry=1745420352, cs_base=cs_base@entry=0, flags=16432,
cflags=cflags@entry=0) at /home/build/src/qemu/git/qemu/translate-all.c:1281
#14 0x0000000000435a32 in tb_find (tb_exit=0, last_tb=0x0,
cpu=0x7ffff7e20010) at /home/build/src/qemu/git/qemu/cpu-exec.c:370
#15 cpu_exec (cpu=cpu@entry=0x7ffff7e20010) at
/home/build/src/qemu/git/qemu/cpu-exec.c:685
#16 0x000000000047457e in tcg_cpu_exec (cpu=0x7ffff7e20010) at
/home/build/src/qemu/git/qemu/cpus.c:1251
#17 0x00000000004748b4 in qemu_tcg_rr_cpu_thread_fn (arg=<optimized
out>) at /home/build/src/qemu/git/qemu/cpus.c:1347
#18 0x00007ffff2a50b50 in start_thread (arg=<optimized out>) at
pthread_create.c:304
#19 0x00007ffff279afbd in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:112
#20 0x0000000000000000 in ?? ()
(gdb)

git bisect points to the following commit:

commit dc0ad84449a4e2f28d2cc055998cb10c1a4d89a9
Author: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date:   Mon Feb 27 10:27:57 2017 +0530

    target/ppc: update overflow flags for add/sub

    * SO and OV reflects overflow of the 64-bit result in 64-bit mode
      and overflow of the low-order 32-bit result in 32-bit mode

    * OV32 reflects overflow of the low-order 32-bit independent of
      the mode

    Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Interestingly enough if I recompile with CFLAGS="-O0 -g" to try and get
a full backtrace then the segfault goes away which suggests this could
be tickling a compiler bug somewhere - although even in this
configuration, I am seeing video artifacts during OS 9 boot which
suggests something still isn't quite right.

This is on a Debian wheezy x86_64 system with gcc 4.7.2.


ATB,

Mark.
