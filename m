Received: from eggs.gnu.org ([209.51.188.92]:36070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ncopa@alpinelinux.org>) id 1gyDat-0004rt-QW
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ncopa@alpinelinux.org>) id 1gyDar-0000Zt-DN
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:34:43 -0500
Received: from mx1.tetrasec.net ([74.117.190.25]:52992)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ncopa@alpinelinux.org>) id 1gyDar-00008z-2Q
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:34:41 -0500
Date: Mon, 25 Feb 2019 11:24:24 +0100
From: Natanael Copa <ncopa@alpinelinux.org>
Message-ID: <20190225112424.2dd535a1@ncopa-desktop.copa.dup.pw>
In-Reply-To: <CAFEAcA8kOEJe-Ax_SFOCa49og-N7gpO-ptsANdvXPhKthrpb8A@mail.gmail.com>
References: <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QVxaW3tezjBN9owJHsxzE9h8_qcaeRr5zHHKxKJOeFnkQ@mail.gmail.com>
	<CAJSP0QVXoZJ9MJ0qp4RM_m2fGJ8iFSyJMAU_X7mdiQvpOK59KA@mail.gmail.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB32454C17192EFA863E29CC49A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB324547F72DA9EDEB1613C888A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QUg=cq3tCSLidQ9BR2hxAo3K6gA6LKtpx5Rjb=_6XgJ6Q@mail.gmail.com>
	<28e6b4ed-9afd-3a79-6267-86c7385c23ce@redhat.com>
	<VI1PR0602MB324578F91F1AF9390D03022FA47F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QWouR43wVi0guTuASP9gc24_CPucbBvtfE5_htkDkmsrQ@mail.gmail.com>
	<20190223165523.1d674224@ncopa-desktop.copa.dup.pw>
	<CAFEAcA8kOEJe-Ax_SFOCa49og-N7gpO-ptsANdvXPhKthrpb8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Fernando Casas =?ISO-8859-1?B?U2No9nNzb3c=?= <casasfernando@outlook.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Sat, 23 Feb 2019 16:18:15 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Sat, 23 Feb 2019 at 16:05, Natanael Copa <ncopa@alpinelinux.org> wrote:
> > I was thinking of something in the lines of:
> >
> > typedef volatile uint16_t __attribute__((__may_alias__)) volatile_uint16_t;
> > static inline int lduw_he_p(const void *ptr)
> > {
> >      volatile_uint16_t r = *(volatile_uint16_t*)ptr;
> >      return r;
> > }  
> 
> This won't correctly handle accesses with unaligned pointers,
> I'm afraid. We rely on these functions correctly working
> with pointers that are potentially unaligned.

Well, current code does not even handle access with aligned pointers,
depending on FORTIFY_SOURCE implementation.

My thinking here is that we depend on assumption that compiler will
remove the memcpy call, so maybe find other way to generate same
assembly, while still depend on compiler optimization.

I did some tests and compared the assembly output. The compiler will
generate same assembly if volatile is not used. The attribute
__may_alias__ does not seem to make any difference. So the following
function generates exactly same assembly:

static inline int lduw_he_p(const void *ptr)
{
	uint16_t r = *(uint16_t*)ptr;
	return r;
}

I created a script to compare on different Linux distros and
architectures. My conclusion is:

- Alpine fortify implementation is non-optimal, but technically
  correct.
- `uint16_t r = *(uint16_t*)ptr;` generates the same assembly code,
  regardless of fortify implementation, and is clearer on the
  intention, than use of memcpy.


test.sh:
---[CUT HERE]---8<--------------------------------------------------
#!/bin/sh -x
cat > testcase.c <<EOF
#include <stdint.h>

#ifdef WITH_MEMCPY
#include <string.h>
static inline int lduw_he_p(const void *ptr)
{
	uint16_t r;
	memcpy(&r, ptr, sizeof(r));
	return r;
}
#else
static inline int lduw_he_p(const void *ptr)
{
	uint16_t r = *(uint16_t*)ptr;
	return r;
}
#endif

int main(int argc, char *argv[])
{
	void *p = argv;
	int i;
	p++; // make sure we are unaligned
	i=lduw_he_p(p);
	return i;
}
EOF

: ${CC:=gcc}
$CC --version
uname -m

for fortify in "-D_FORTIFY_SOURCE=2" "-U_FORTIFY_SOURCE"; do
	for cflag in "-DWITH_MEMCPY" "-DWITHOUT_MEMCPY"; do
		$CC $cflag $fortify $@ -o testcase$cflag testcase.c
		gdb --batch -ex "disas ${func:-main}" ./testcase$cflag
	done
done
---[CUT HERE]---8<--------------------------------------------------


Output on Alpine:

$ sh -x test.sh -O2
+ cat
+ : gcc
+ gcc --version
gcc (Alpine 8.2.0) 8.2.0
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

+ uname -m
x86_64
+ gcc -DWITH_MEMCPY '-D_FORTIFY_SOURCE=2' -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x0000000000001070 <+0>:	sub    $0x18,%rsp
   0x0000000000001074 <+4>:	mov    %fs:0x28,%rax
   0x000000000000107d <+13>:	mov    %rax,0x8(%rsp)
   0x0000000000001082 <+18>:	xor    %eax,%eax
   0x0000000000001084 <+20>:	lea    0x6(%rsp),%rdi
   0x0000000000001089 <+25>:	lea    0x1(%rsi),%rax
   0x000000000000108d <+29>:	lea    0x2(%rdi),%rdx
   0x0000000000001091 <+33>:	cmp    %rdx,%rax
   0x0000000000001094 <+36>:	jae    0x109b <main+43>
   0x0000000000001096 <+38>:	cmp    %rdi,%rax
   0x0000000000001099 <+41>:	ja     0x10d0 <main+96>
   0x000000000000109b <+43>:	cmp    %rdi,%rax
   0x000000000000109e <+46>:	jb     0x10c7 <main+87>
   0x00000000000010a0 <+48>:	mov    $0x2,%edx
   0x00000000000010a5 <+53>:	mov    %rax,%rsi
   0x00000000000010a8 <+56>:	callq  0x1020 <memcpy@plt>
   0x00000000000010ad <+61>:	movzwl 0x6(%rsp),%eax
   0x00000000000010b2 <+66>:	mov    0x8(%rsp),%rcx
   0x00000000000010b7 <+71>:	xor    %fs:0x28,%rcx
   0x00000000000010c0 <+80>:	jne    0x10d2 <main+98>
   0x00000000000010c2 <+82>:	add    $0x18,%rsp
   0x00000000000010c6 <+86>:	retq   
   0x00000000000010c7 <+87>:	add    $0x3,%rsi
   0x00000000000010cb <+91>:	cmp    %rsi,%rdi
   0x00000000000010ce <+94>:	jae    0x10a0 <main+48>
   0x00000000000010d0 <+96>:	ud2    
   0x00000000000010d2 <+98>:	callq  0x1030 <__stack_chk_fail@plt>
End of assembler dump.
+ gcc -DWITHOUT_MEMCPY '-D_FORTIFY_SOURCE=2' -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x0000000000001050 <+0>:	movzwl 0x1(%rsi),%eax
   0x0000000000001054 <+4>:	retq   
End of assembler dump.
+ gcc -DWITH_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x0000000000001050 <+0>:	movzwl 0x1(%rsi),%eax
   0x0000000000001054 <+4>:	retq   
End of assembler dump.
+ gcc -DWITHOUT_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x0000000000001050 <+0>:	movzwl 0x1(%rsi),%eax
   0x0000000000001054 <+4>:	retq   
End of assembler dump.




Output on Debian:

root@19c3f13c6023:~# sh -x test.sh -O2
+ cat
+ : gcc
+ gcc --version
gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
Copyright (C) 2016 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

+ uname -m
x86_64
+ gcc -DWITH_MEMCPY -D_FORTIFY_SOURCE=2 -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex disas main ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x0000000000000530 <+0>:	movzwl 0x1(%rsi),%eax
   0x0000000000000534 <+4>:	retq   
End of assembler dump.
+ gcc -DWITHOUT_MEMCPY -D_FORTIFY_SOURCE=2 -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex disas main ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x0000000000000530 <+0>:	movzwl 0x1(%rsi),%eax
   0x0000000000000534 <+4>:	retq   
End of assembler dump.
+ gcc -DWITH_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex disas main ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x0000000000000530 <+0>:	movzwl 0x1(%rsi),%eax
   0x0000000000000534 <+4>:	retq   
End of assembler dump.
+ gcc -DWITHOUT_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex disas main ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x0000000000000530 <+0>:	movzwl 0x1(%rsi),%eax
   0x0000000000000534 <+4>:	retq   
End of assembler dump.
root@19c3f13c6023:~# 



Output on Fedora:
[root@ac68847f5bb1 ~]# sh -x test.sh -O2
+ cat
+ : gcc
+ gcc --version
gcc (GCC) 8.2.1 20181215 (Red Hat 8.2.1-6)
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

+ uname -m
x86_64
+ for fortify in "-D_FORTIFY_SOURCE=2" "-U_FORTIFY_SOURCE"
+ for cflag in "-DWITH_MEMCPY" "-DWITHOUT_MEMCPY"
+ gcc -DWITH_MEMCPY -D_FORTIFY_SOURCE=2 -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x0000000000401020 <+0>:	movzwl 0x1(%rsi),%eax
   0x0000000000401024 <+4>:	retq   
End of assembler dump.
+ for cflag in "-DWITH_MEMCPY" "-DWITHOUT_MEMCPY"
+ gcc -DWITHOUT_MEMCPY -D_FORTIFY_SOURCE=2 -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x0000000000401020 <+0>:	movzwl 0x1(%rsi),%eax
   0x0000000000401024 <+4>:	retq   
End of assembler dump.
+ for fortify in "-D_FORTIFY_SOURCE=2" "-U_FORTIFY_SOURCE"
+ for cflag in "-DWITH_MEMCPY" "-DWITHOUT_MEMCPY"
+ gcc -DWITH_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x0000000000401020 <+0>:	movzwl 0x1(%rsi),%eax
   0x0000000000401024 <+4>:	retq   
End of assembler dump.
+ for cflag in "-DWITH_MEMCPY" "-DWITHOUT_MEMCPY"
+ gcc -DWITHOUT_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x0000000000401020 <+0>:	movzwl 0x1(%rsi),%eax
   0x0000000000401024 <+4>:	retq   
End of assembler dump.



Output on Alpine with clang:
$ CC=clang sh -x test.sh -O2
+ cat
+ : clang
+ clang --version
Alpine clang version 5.0.2 (tags/RELEASE_502/final) (based on LLVM 5.0.2)
Target: x86_64-alpine-linux-musl
Thread model: posix
InstalledDir: /usr/bin
+ uname -m
x86_64
+ clang -DWITH_MEMCPY '-D_FORTIFY_SOURCE=2' -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x00000000000011a0 <+0>:	movzwl 0x1(%rsi),%eax
   0x00000000000011a4 <+4>:	retq   
End of assembler dump.
+ clang -DWITHOUT_MEMCPY '-D_FORTIFY_SOURCE=2' -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x00000000000011a0 <+0>:	movzwl 0x1(%rsi),%eax
   0x00000000000011a4 <+4>:	retq   
End of assembler dump.
+ clang -DWITH_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x00000000000011a0 <+0>:	movzwl 0x1(%rsi),%eax
   0x00000000000011a4 <+4>:	retq   
End of assembler dump.
+ clang -DWITHOUT_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x00000000000011a0 <+0>:	movzwl 0x1(%rsi),%eax
   0x00000000000011a4 <+4>:	retq   
End of assembler dump.



Output on alpine armv7:
$ sh -x test.sh -O2
+ cat
+ : gcc
+ gcc --version
gcc (Alpine 8.2.0) 8.2.0
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

+ uname -m
armv8l
+ gcc -DWITH_MEMCPY '-D_FORTIFY_SOURCE=2' -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x000003f8 <+0>:     push    {r4, r5, lr}
   0x000003fa <+2>:     sub     sp, #12
   0x000003fc <+4>:     adds    r3, r1, #1
   0x000003fe <+6>:     add     r4, sp, #4
   0x00000400 <+8>:     cmp     r3, r4
   0x00000402 <+10>:    add.w   r0, sp, #2
   0x00000406 <+14>:    ite     cs
   0x00000408 <+16>:    movcs   r2, #0
   0x0000040a <+18>:    movcc   r2, #1
   0x0000040c <+20>:    cmp     r3, r0
   0x0000040e <+22>:    it      ls
   0x00000410 <+24>:    movls   r2, #0
   0x00000412 <+26>:    ldr     r4, [pc, #52]   ; (0x448 <main+80>)
   0x00000414 <+28>:    ldr     r5, [pc, #52]   ; (0x44c <main+84>)
   0x00000416 <+30>:    add     r4, pc
   0x00000418 <+32>:    ldr     r4, [r4, r5]
   0x0000041a <+34>:    ldr     r5, [r4, #0]
   0x0000041c <+36>:    str     r5, [sp, #4]
   0x0000041e <+38>:    cbnz    r2, 0x442 <main+74>
   0x00000420 <+40>:    cmp     r3, r0
   0x00000422 <+42>:    bcc.n   0x43c <main+68>
   0x00000424 <+44>:    mov     r1, r3
   0x00000426 <+46>:    movs    r2, #2
   0x00000428 <+48>:    blx     0x3b0 <memcpy@plt>
   0x0000042c <+52>:    ldr     r2, [sp, #4]
   0x0000042e <+54>:    ldr     r3, [r4, #0]
   0x00000430 <+56>:    ldrh.w  r0, [sp, #2]
   0x00000434 <+60>:    cmp     r2, r3
   0x00000436 <+62>:    bne.n   0x444 <main+76>
   0x00000438 <+64>:    add     sp, #12
   0x0000043a <+66>:    pop     {r4, r5, pc}
   0x0000043c <+68>:    adds    r1, #3
   0x0000043e <+70>:    cmp     r0, r1
   0x00000440 <+72>:    bcs.n   0x424 <main+44>
   0x00000442 <+74>:    udf     #255    ; 0xff
   0x00000444 <+76>:    blx     0x3c8 <__stack_chk_fail@plt>
   0x00000448 <+80>:    muleq   r1, lr, r11
   0x0000044c <+84>:    andeq   r0, r0, r4, lsr #32
End of assembler dump.
+ gcc -DWITHOUT_MEMCPY '-D_FORTIFY_SOURCE=2' -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x0000036c <+0>:     ldrh.w  r0, [r1, #1]
   0x00000370 <+4>:     bx      lr
End of assembler dump.
+ gcc -DWITH_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x0000036c <+0>:     ldrh.w  r0, [r1, #1]
   0x00000370 <+4>:     bx      lr
End of assembler dump.
+ gcc -DWITHOUT_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x0000036c <+0>:     ldrh.w  r0, [r1, #1]
   0x00000370 <+4>:     bx      lr
End of assembler dump.


Output on Alpine aarch64:
$ sh -x test.sh -O2
+ cat
+ : gcc
+ gcc --version
gcc (Alpine 8.2.0) 8.2.0
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

+ uname -m
aarch64
+ gcc -DWITH_MEMCPY '-D_FORTIFY_SOURCE=2' -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x00000000000006b0 <+0>:     stp     x29, x30, [sp, #-48]!
   0x00000000000006b4 <+4>:     add     x2, x1, #0x1
   0x00000000000006b8 <+8>:     mov     x29, sp
   0x00000000000006bc <+12>:    str     x19, [sp, #16]
   0x00000000000006c0 <+16>:    adrp    x19, 0x10000
   0x00000000000006c4 <+20>:    add     x0, sp, #0x26
   0x00000000000006c8 <+24>:    ldr     x3, [x19, #4024]
   0x00000000000006cc <+28>:    add     x4, x0, #0x2
   0x00000000000006d0 <+32>:    cmp     x4, x2
   0x00000000000006d4 <+36>:    ldr     x4, [x3]
   0x00000000000006d8 <+40>:    str     x4, [sp, #40]
   0x00000000000006dc <+44>:    mov     x4, #0x0                        // #0
   0x00000000000006e0 <+48>:    ccmp    x0, x2, #0x2, hi  // hi = pmore
   0x00000000000006e4 <+52>:    b.cc    0x72c <main+124>  // b.lo, b.ul, b.last
   0x00000000000006e8 <+56>:    cmp     x2, x0
   0x00000000000006ec <+60>:    b.cc    0x720 <main+112>  // b.lo, b.ul, b.last
   0x00000000000006f0 <+64>:    mov     x1, x2
   0x00000000000006f4 <+68>:    mov     x2, #0x2                        // #2
   0x00000000000006f8 <+72>:    bl      0x650 <memcpy@plt>
   0x00000000000006fc <+76>:    ldr     x19, [x19, #4024]
   0x0000000000000700 <+80>:    ldrh    w0, [sp, #38]
   0x0000000000000704 <+84>:    ldr     x2, [sp, #40]
   0x0000000000000708 <+88>:    ldr     x1, [x19]
   0x000000000000070c <+92>:    eor     x1, x2, x1
   0x0000000000000710 <+96>:    cbnz    x1, 0x730 <main+128>
   0x0000000000000714 <+100>:   ldr     x19, [sp, #16]
   0x0000000000000718 <+104>:   ldp     x29, x30, [sp], #48
   0x000000000000071c <+108>:   ret
   0x0000000000000720 <+112>:   add     x1, x1, #0x3
   0x0000000000000724 <+116>:   cmp     x0, x1
   0x0000000000000728 <+120>:   b.cs    0x6f0 <main+64>  // b.hs, b.nlast
   0x000000000000072c <+124>:   brk     #0x3e8
   0x0000000000000730 <+128>:   bl      0x670 <__stack_chk_fail@plt>
End of assembler dump.
+ gcc -DWITHOUT_MEMCPY '-D_FORTIFY_SOURCE=2' -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x00000000000005e0 <+0>:     ldurh   w0, [x1, #1]
   0x00000000000005e4 <+4>:     ret
End of assembler dump.
+ gcc -DWITH_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x00000000000005e0 <+0>:     ldurh   w0, [x1, #1]
   0x00000000000005e4 <+4>:     ret
End of assembler dump.
+ gcc -DWITHOUT_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x00000000000005e0 <+0>:     ldurh   w0, [x1, #1]
   0x00000000000005e4 <+4>:     ret
End of assembler dump.





Output on Alpine ppc64le:
$ sh -x test.sh -O2
+ cat
+ : gcc
+ gcc --version
gcc (Alpine 8.2.0) 8.2.0
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

+ uname -m
ppc64le
+ gcc -DWITH_MEMCPY '-D_FORTIFY_SOURCE=2' -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x00000000000005c0 <+0>:     lhz     r3,1(r4)
   0x00000000000005c4 <+4>:     blr
   0x00000000000005c8 <+8>:     .long 0x0
   0x00000000000005cc <+12>:    .long 0x0
   0x00000000000005d0 <+16>:    .long 0x0
End of assembler dump.
+ gcc -DWITHOUT_MEMCPY '-D_FORTIFY_SOURCE=2' -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x00000000000005c0 <+0>:     lhz     r3,1(r4)
   0x00000000000005c4 <+4>:     blr
   0x00000000000005c8 <+8>:     .long 0x0
   0x00000000000005cc <+12>:    .long 0x0
   0x00000000000005d0 <+16>:    .long 0x0
End of assembler dump.
+ gcc -DWITH_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x00000000000005c0 <+0>:     lhz     r3,1(r4)
   0x00000000000005c4 <+4>:     blr
   0x00000000000005c8 <+8>:     .long 0x0
   0x00000000000005cc <+12>:    .long 0x0
   0x00000000000005d0 <+16>:    .long 0x0
End of assembler dump.
+ gcc -DWITHOUT_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x00000000000005c0 <+0>:     lhz     r3,1(r4)
   0x00000000000005c4 <+4>:     blr
   0x00000000000005c8 <+8>:     .long 0x0
   0x00000000000005cc <+12>:    .long 0x0
   0x00000000000005d0 <+16>:    .long 0x0
End of assembler dump.



Output on Alpine s390x:
$ sh -x test.sh -O2
+ cat
+ : gcc
+ gcc --version
gcc (Alpine 8.2.0) 8.2.0
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

+ uname -m
s390x
+ gcc -DWITH_MEMCPY '-D_FORTIFY_SOURCE=2' -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x00000000000006b0 <+0>:	stmg	%r14,%r15,112(%r15)
   0x00000000000006b6 <+6>:	ear	%r1,%a0
   0x00000000000006ba <+10>:	lay	%r15,-176(%r15)
   0x00000000000006c0 <+16>:	sllg	%r1,%r1,32
   0x00000000000006c6 <+22>:	ear	%r1,%a1
   0x00000000000006ca <+26>:	la	%r2,166(%r15)
   0x00000000000006ce <+30>:	mvc	168(8,%r15),40(%r1)
   0x00000000000006d4 <+36>:	la	%r1,1(%r3)
   0x00000000000006d8 <+40>:	clgr	%r1,%r2
   0x00000000000006dc <+44>:	jle	0x6e8 <main+56>
   0x00000000000006e0 <+48>:	la	%r4,168(%r15)
   0x00000000000006e4 <+52>:	clgrtl	%r1,%r4
   0x00000000000006e8 <+56>:	clgr	%r1,%r2
   0x00000000000006ec <+60>:	jl	0x724 <main+116>
   0x00000000000006f0 <+64>:	lgr	%r3,%r1
   0x00000000000006f4 <+68>:	lghi	%r4,2
   0x00000000000006f8 <+72>:	brasl	%r14,0x5f0 <memcpy@plt>
   0x00000000000006fe <+78>:	ear	%r1,%a0
   0x0000000000000702 <+82>:	llgh	%r2,166(%r15)
   0x0000000000000708 <+88>:	sllg	%r1,%r1,32
   0x000000000000070e <+94>:	ear	%r1,%a1
   0x0000000000000712 <+98>:	clc	168(8,%r15),40(%r1)
   0x0000000000000718 <+104>:	jne	0x730 <main+128>
   0x000000000000071c <+108>:	lmg	%r14,%r15,288(%r15)
   0x0000000000000722 <+114>:	br	%r14
   0x0000000000000724 <+116>:	la	%r3,3(%r3)
   0x0000000000000728 <+120>:	clgrtl	%r2,%r3
   0x000000000000072c <+124>:	j	0x6f0 <main+64>
   0x0000000000000730 <+128>:	brasl	%r14,0x630 <__stack_chk_fail@plt>
End of assembler dump.
+ gcc -DWITHOUT_MEMCPY '-D_FORTIFY_SOURCE=2' -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x00000000000005f8 <+0>:	llgh	%r2,1(%r3)
   0x00000000000005fe <+6>:	br	%r14
End of assembler dump.
+ gcc -DWITH_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITH_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITH_MEMCPY
Dump of assembler code for function main:
   0x00000000000005f8 <+0>:	llgh	%r2,1(%r3)
   0x00000000000005fe <+6>:	br	%r14
End of assembler dump.
+ gcc -DWITHOUT_MEMCPY -U_FORTIFY_SOURCE -O2 -o testcase-DWITHOUT_MEMCPY testcase.c
+ gdb --batch -ex 'disas main' ./testcase-DWITHOUT_MEMCPY
Dump of assembler code for function main:
   0x00000000000005f8 <+0>:	llgh	%r2,1(%r3)
   0x00000000000005fe <+6>:	br	%r14
End of assembler dump.
