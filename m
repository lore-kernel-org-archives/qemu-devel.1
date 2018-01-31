Received: from eggs.gnu.org ([2001:4830:134:3::10]:55599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egwx3-0005xJ-Lz
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1egwx2-0002Jd-OQ
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:17:41 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1egwx2-0002IK-G3
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:17:40 -0500
Received: by mail-lf0-x243.google.com with SMTP id 63so22144391lfv.4
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 10:17:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8942a41a-a924-f626-3613-3c74b9db0da6@redhat.com>
References: <CAKmqyKPZ3AUwGFwp6zK+aFSd6R3p8c+pP-i-W-g=t6ZfR5GVaA@mail.gmail.com>
	<8942a41a-a924-f626-3613-3c74b9db0da6@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 31 Jan 2018 10:17:08 -0800
Message-ID: <CAKmqyKN+VD9NV6oy0USJ0ChLXodw3k7J4uRqyW41+iSRzr4G_A@mail.gmail.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>

On Wed, Jan 31, 2018 at 9:13 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 03/01/2018 17:10, Alistair Francis wrote:
>> Hey guys, I'm super stuck with an ugly MTTCG issue and was wondering
>> if anyone had any ideas.
>>
>> In the Xilinx fork of QEMU (based on 2.11) we have a way for CPUs to
>> halt other CPUs. This is used for example when the power control unit
>> halts the ARM A53s. To do this we have internal GPIO signals that end
>> up calling a function that basically does this:
>>
>> To halt:
>>     cpu->halted = true;
>>     cpu_interrupt(cpu, CPU_INTERRUPT_HALT);
>
> cpu->halted = true should not be needed here.  It will be set by
> cpu_handle_interrupt when processing CPU_INTERRUPT_HALT.
>
>> To un-halt
>>     cpu->halted = false;
>>     cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
>
> cpu->halted = false likewise should not be needed here, but you cannot
> just clear CPU_INTERRUPT_HALT either.  You need to set a *different*
> interrupt request bit (the dummy CPU_INTERRUPT_EXITTB will do) and
> cpu_handle_halt will clear cpu->halted.

The problem with that is that I hit this assert for ARM CPUs:

qemu-system-aarch64: ./target/arm/cpu.h:1446: arm_el_is_aa64:
Assertion `el >= 1 && el <= 3' failed.

Alistair

>
> Paolo
>
>> We also have the standard ARM WFI (Wait For Interrupt) implementation
>> in op_helper.c:
>>     cs->halted = 1;
>>     cs->exception_index = EXCP_HLT;
>>     cpu_loop_exit(cs);
>>
>> Before MTTCG this used to work great, but now either we end up with
>> the guest Linux complaining about CPU stalls or we hit:
>> ERROR:/scratch/alistai/master-qemu/cpus.c:1516:qemu_tcg_cpu_thread_fn:
>> assertion failed: (cpu->halted)
>>
>> If I remove the instances of manually setting cpu->halted then I don't
>> see the asserts(), but the the WFI instruction doesn't work correctly.
>> So it seems like setting the halted status externally from the CPU
>> causes the issue. I have tried setting it inside a lock, using atomic
>> operations and running the setter async on the CPU, but nothing works.
>>
>> Any chance any one has some insight into a way to externally set a
>> vCPU as halted/un-halted?
>>
>> Thanks,
>> Alistair
>>
>
