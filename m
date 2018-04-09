Received: from eggs.gnu.org ([2001:4830:134:3::10]:47617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ajaygargnsit@gmail.com>) id 1f5TCT-000231-6R
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ajaygargnsit@gmail.com>) id 1f5TCR-0006dw-Qs
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:34:57 -0400
MIME-Version: 1.0
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Mon, 9 Apr 2018 15:04:50 +0530
Message-ID: <CAHP4M8VnuS5KijfVw9eDz41KPwaT4rJ+4VEU==EbBgdwgFKJhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Crash when running hello-world unikernel for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, rumpkernel-users@freelists.org

Hi All.

We did the following :

a)
Cross-compile rumprun for ARM on a linux x86_64 :

ajay@latitude-3480:~/rumprun-arm-hw/rumprun$
CC=arm-linux-gnueabihf-gcc ./build-rr.sh hw

b)
Compile and bake the hello-world binary

ajay@latitude-3480:~/rumprun-arm-hw/rumprun$
arm-rumprun-netbsdelf-eabihf-gcc helloer.c -o helloer
ajay@latitude-3480:~/rumprun-arm-hw/rumprun$ rumprun-bake hw_virtio
helloer.bin helloer

The second step required changing

conf hw_virtio
    create      "virtio targets (e.g. QEMU/KVM)"
    assimilate  _miconf                      \
    _virtio
fnoc

to

conf hw_virtio
    create      "virtio targets (e.g. QEMU/KVM)"
    assimilate  _miconf
fnoc

in /home/ajay/rumprun-arm-hw/rumprun/./rumprun/etc/rumprun-bake.conf

c)
Tried running on x86_64, via qemu, but got the crash :

######################################################################
ajay@latitude-3480:~/rumprun-arm-hw/rumprun$ qemu-system-x86_64
-nographic -kernel helloer.bin
warning: TCG doesn't support requested feature: CPUID.01H:ECX.vmx [bit 5]
qemu: fatal: Trying to execute code outside RAM or ROM at 0x00000000000a01f1

EAX=00000000 EBX=00000000 ECX=00000000 EDX=00000001
ESI=00000000 EDI=00000000 EBP=00000000 ESP=00009fde
EIP=0000fff1 EFL=00000086 [--S--P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =9000 00090000 ffffffff 00cf9300
CS =9020 00090200 0000ffff 00009b00
SS =9000 00090000 0000ffff 00009300
DS =9000 00090000 0000ffff 00009300
FS =9000 00090000 0000ffff 00009300
GS =9000 00090000 0000ffff 00009300
LDT=0000 00000000 0000ffff 00008200
TR =0000 00000000 0000ffff 00008b00
GDT=     000cab0c 00000017
IDT=     00000000 000003ff
CR0=00000010 CR2=00000000 CR3=00000000 CR4=00000000
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
DR3=0000000000000000
DR6=00000000ffff0ff0 DR7=0000000000000400
CCS=00000044 CCD=000000b4 CCO=SUBB
EFER=0000000000000000
FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
XMM00=00000000000000000000000000000000 XMM01=00000000000000000000000000000000
XMM02=00000000000000000000000000000000 XMM03=00000000000000000000000000000000
XMM04=00000000000000000000000000000000 XMM05=00000000000000000000000000000000
XMM06=00000000000000000000000000000000 XMM07=00000000000000000000000000000000
Aborted (core dumped)
######################################################################


d)
Also find below when tried with gdb :

######################################################################
ajay@latitude-3480:~/rumprun-arm-hw/rumprun$ gdb --args
qemu-system-x86_64 -nographic -nographic -kernel helloer.bin
GNU gdb (Ubuntu 7.11.1-0ubuntu1~16.5) 7.11.1
Copyright (C) 2016 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from qemu-system-x86_64...(no debugging symbols found)...done.
(gdb) r
Starting program: /usr/bin/qemu-system-x86_64 -nographic -nographic
-kernel helloer.bin
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[New Thread 0x7fffecde1700 (LWP 30356)]
warning: TCG doesn't support requested feature: CPUID.01H:ECX.vmx [bit 5]
[New Thread 0x7fffd1f2f700 (LWP 30357)]
qemu: fatal: Trying to execute code outside RAM or ROM at 0x00000000000a01f1

EAX=00000000 EBX=00000000 ECX=00000000 EDX=00000001
ESI=00000000 EDI=00000000 EBP=00000000 ESP=00009fde
EIP=0000fff1 EFL=00000086 [--S--P-] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =9000 00090000 ffffffff 00cf9300
CS =9020 00090200 0000ffff 00009b00
SS =9000 00090000 0000ffff 00009300
DS =9000 00090000 0000ffff 00009300
FS =9000 00090000 0000ffff 00009300
GS =9000 00090000 0000ffff 00009300
LDT=0000 00000000 0000ffff 00008200
TR =0000 00000000 0000ffff 00008b00
GDT=     000cab0c 00000017
IDT=     00000000 000003ff
CR0=00000010 CR2=00000000 CR3=00000000 CR4=00000000
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
DR3=0000000000000000
DR6=00000000ffff0ff0 DR7=0000000000000400
CCS=00000044 CCD=000000b4 CCO=SUBB
EFER=0000000000000000
FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
XMM00=00000000000000000000000000000000 XMM01=00000000000000000000000000000000
XMM02=00000000000000000000000000000000 XMM03=00000000000000000000000000000000
XMM04=00000000000000000000000000000000 XMM05=00000000000000000000000000000000
XMM06=00000000000000000000000000000000 XMM07=00000000000000000000000000000000

Thread 3 "qemu-system-x86" received signal SIGABRT, Aborted.
[Switching to Thread 0x7fffd1f2f700 (LWP 30357)]
0x00007ffff2b74428 in __GI_raise (sig=sig@entry=6) at
../sysdeps/unix/sysv/linux/raise.c:54
54    ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) bt
#0  0x00007ffff2b74428 in __GI_raise (sig=sig@entry=6) at
../sysdeps/unix/sysv/linux/raise.c:54
#1  0x00007ffff2b7602a in __GI_abort () at abort.c:89
#2  0x000055555573d33d in cpu_abort ()
#3  0x0000555555781fdd in get_page_addr_code ()
#4  0x0000555555743d63 in ?? ()
#5  0x000055555574485b in cpu_x86_exec ()
#6  0x0000555555765fb2 in ?? ()
#7  0x00007ffff2f106ba in start_thread (arg=0x7fffd1f2f700) at
pthread_create.c:333
#8  0x00007ffff2c4641d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109
(gdb)
######################################################################


Where should we be looking to start to fix?



Thanks and Regards,
Ajay
