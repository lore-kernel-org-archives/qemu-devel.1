Received: from eggs.gnu.org ([2001:4830:134:3::10]:36480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1frlj8-0003GS-Gh
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1frlj4-0002yd-JB
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:04:18 -0400
References: <CABLmASE2HTZPBVFM=grds+9RmPyh2naJ2KwNjb81LD0+E+yrtA@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <c350ae62-2712-79cc-e7e6-b88ae3fbc044@weilnetz.de>
Date: Mon, 20 Aug 2018 17:04:09 +0200
MIME-Version: 1.0
In-Reply-To: <CABLmASE2HTZPBVFM=grds+9RmPyh2naJ2KwNjb81LD0+E+yrtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Bugs when cross-compiling qemu for Windows with
 mingw 8.1, executable doesn't run
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Am 18.07.2018 um 08:33 schrieb Howard Spoelstra:
[...]> Issue 2: once strncpy has been replaced with memcpy in these two
> instances, I can successfully compile, but the executable doesn't run
> in Windows.
> I tried to debug, and this is what gdb told me:
> 
> (gdb) run
> Starting program: c:\qemu-fedora29beta\qemu-system-ppc-debug.exe -L
> c:\qemu-fedora29beta\pc-bios -boot c -m 256 -M "mac99,via=pmu"
> -prom-env "boot-args=-v" -prom-env "auto-boot?=true" -prom-env
> "vga-ndrv?=true" -hda c:\Mac-disks\9.2.qcow2 -netdev
> "user,id=network01" -device "sungem,netdev=network01" -sdl -d int
> [New Thread 948.0x6d8]
> [New Thread 948.0x2778]
> [New Thread 948.0x286c]
> [New Thread 948.0x3d0]
> 
> Program received signal SIGSEGV, Segmentation fault.
> getpagesize () at util/oslib-win32.c:535
> 535     util/oslib-win32.c: No such file or directory.
> (gdb) bt full
> #0  getpagesize () at util/oslib-win32.c:535
>         system_info = {{dwOemId = 56491488, {wProcessorArchitecture =
> 64992, wReserved = 861}}, dwPageSize = 0,
>           lpMinimumApplicationAddress = 0x99cca4
> <register_module_init+60>, lpMaximumApplicationAddress = 0x3,
>           dwActiveProcessorMask = 11102192, dwNumberOfProcessors =
> 56584576, dwProcessorType = 0,
>           dwAllocationGranularity = 200, wProcessorLevel = 0,
> wProcessorRevision = 0}
> #1  0x00000000009b7fcd in init_real_host_page_size () at util/pagesize.c:16
> No locals.
> #2  0x00000000009bc5f2 in __do_global_ctors ()
> No symbol table info available.


It looks like all functions with local variables crash when they are
called from a global constructor (__do_global_ctors). Such functions
contain this opcode near the function start:

mov    %fs:0x0,%rax

Maybe %fs has an illegal value (see example below, called from rcu_init).

Replacing the local variable by a static one avoids the problem, but
would have to be done for any function which is called from a global
constructor (I stopped after I had changed some of them).

Stefan

(gdb) disas
Dump of assembler code for function _nocheck__trace_qemu_mutex_lock:
   0x00000000009896e5 <+0>:     push   %rbp
   0x00000000009896e6 <+1>:     push   %rsi
   0x00000000009896e7 <+2>:     push   %rbx
   0x00000000009896e8 <+3>:     mov    %rsp,%rbp
   0x00000000009896eb <+6>:     sub    $0x60,%rsp
   0x00000000009896ef <+10>:    mov    %rcx,-0x18(%rbp)
   0x00000000009896f3 <+14>:    mov    %rdx,-0x20(%rbp)
   0x00000000009896f7 <+18>:    mov    %r8d,0x30(%rbp)
=> 0x00000000009896fb <+22>:    mov    %fs:0x0,%rax
   0x0000000000989704 <+31>:    mov    %rax,-0x8(%rbp)

(gdb) i reg
rax            0xe633a0 15086496
rbx            0xa85120 11030816
rcx            0x10fabd0        17804240
rdx            0xe633a0 15086496
rsi            0xa83de0 11025888
rdi            0x5536c10        89353232
rbp            0x22fcc0 0x22fcc0
rsp            0x22fc60 0x22fc60
r8             0x12e    302
r9             0x5538e18        89361944
r10            0x21     33
r11            0x21     33
r12            0xc0     192
r13            0xb8     184
r14            0x0      0
r15            0x0      0
rip            0x9896fb 0x9896fb <_nocheck__trace_qemu_mutex_lock+22>
eflags         0x10206  [ PF IF RF ]
cs             0x33     51
ss             0x2b     43
ds             0x2b     43
es             0x2b     43
fs             0x53     83
gs             0x2b     43
