Received: from eggs.gnu.org ([2001:4830:134:3::10]:36816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egxTz-0006qK-6m
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:51:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egxTy-0006mb-7X
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:51:43 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:39595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1egxTx-0006lv-VX
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:51:42 -0500
Received: by mail-lf0-x243.google.com with SMTP id w27so22305442lfd.6
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 10:51:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_YWx9wsRjHuBXnfyXOKA34YR+bfgoLeP-y1AwgpEj6+Q@mail.gmail.com>
References: <CAKmqyKPZ3AUwGFwp6zK+aFSd6R3p8c+pP-i-W-g=t6ZfR5GVaA@mail.gmail.com>
	<8942a41a-a924-f626-3613-3c74b9db0da6@redhat.com>
	<CAKmqyKN+VD9NV6oy0USJ0ChLXodw3k7J4uRqyW41+iSRzr4G_A@mail.gmail.com>
	<CAFEAcA_YWx9wsRjHuBXnfyXOKA34YR+bfgoLeP-y1AwgpEj6+Q@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 31 Jan 2018 10:51:09 -0800
Message-ID: <CAKmqyKP+V+G8XrcdxHifhcCBSt5iquV=kUC=V=A6GQ1o==j8LA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] MTTCG External Halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On Wed, Jan 31, 2018 at 10:48 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 31 January 2018 at 18:17, Alistair Francis <alistair23@gmail.com> wrote:
>> On Wed, Jan 31, 2018 at 9:13 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> cpu->halted = false likewise should not be needed here, but you cannot
>>> just clear CPU_INTERRUPT_HALT either.  You need to set a *different*
>>> interrupt request bit (the dummy CPU_INTERRUPT_EXITTB will do) and
>>> cpu_handle_halt will clear cpu->halted.
>>
>> The problem with that is that I hit this assert for ARM CPUs:
>>
>> qemu-system-aarch64: ./target/arm/cpu.h:1446: arm_el_is_aa64:
>> Assertion `el >= 1 && el <= 3' failed.
>
> Backtrace from when you hit that might be useful...

Here it is:

(gdb) bt
#0  0x00007ffff1a030bb in __GI_raise (sig=sig@entry=6) at
../sysdeps/unix/sysv/linux/raise.c:51
#1  0x00007ffff1a04f5d in __GI_abort () at abort.c:90
#2  0x00007ffff19faf17 in __assert_fail_base (fmt=<optimized out>,
assertion=assertion@entry=0x555555cf86c4 "el >= 1 && el <= 3",
file=file@entry=0x555555cf8660
"/scratch/alistai/master-qemu/target/arm/cpu.h", line=line@entry=1446,
function=function@entry=0x555555d314e8 <__PRETTY_FUNCTION__.24916>
"arm_el_is_aa64") at assert.c:92
#3  0x00007ffff19fafc2 in __GI___assert_fail
(assertion=assertion@entry=0x555555cf86c4 "el >= 1 && el <= 3",
file=file@entry=0x555555cf8660
"/scratch/alistai/master-qemu/target/arm/cpu.h", line=line@entry=1446,
function=function@entry=0x555555d314e8 <__PRETTY_FUNCTION__.24916>
"arm_el_is_aa64") at assert.c:101
#4  0x00005555557eb872 in arm_el_is_aa64 (el=0, env=0x55555723c7f8) at
/scratch/alistai/master-qemu/target/arm/cpu.h:1446
#5  0x0000555555951233 in arm_el_is_aa64 (el=0, env=0x55555723c7f8) at
/scratch/alistai/master-qemu/target/arm/cpu.h:1838
#6  0x0000555555951233 in arm_cpu_do_interrupt (cs=0x555557234550) at
/scratch/alistai/master-qemu/target/arm/helper.c:8020
#7  0x000055555585e75b in cpu_handle_exception (ret=<synthetic
pointer>, cpu=0x555556c64200)
    at /scratch/alistai/master-qemu/accel/tcg/cpu-exec.c:532
#8  0x000055555585e75b in cpu_exec (cpu=cpu@entry=0x555557234550) at
/scratch/alistai/master-qemu/accel/tcg/cpu-exec.c:748
#9  0x000055555582d963 in tcg_cpu_exec (cpu=0x555557234550) at
/scratch/alistai/master-qemu/cpus.c:1297
#10 0x000055555582d963 in qemu_tcg_cpu_thread_fn (arg=0x555557234550)
at /scratch/alistai/master-qemu/cpus.c:1502
#11 0x00007ffff1db37fc in start_thread (arg=0x7ffef6b43700) at
pthread_create.c:465
#12 0x00007ffff1ae0b5f in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Alistair

>
> thanks
> -- PMM
