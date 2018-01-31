Received: from eggs.gnu.org ([2001:4830:134:3::10]:34555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egvwv-0001kz-GE
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:13:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egvwq-00037Z-O3
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:13:29 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1egvwq-00035i-Gz
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:13:24 -0500
Received: by mail-wr0-f172.google.com with SMTP id 36so15835727wrh.1
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 09:13:23 -0800 (PST)
References: <CAKmqyKPZ3AUwGFwp6zK+aFSd6R3p8c+pP-i-W-g=t6ZfR5GVaA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8942a41a-a924-f626-3613-3c74b9db0da6@redhat.com>
Date: Wed, 31 Jan 2018 12:13:19 -0500
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPZ3AUwGFwp6zK+aFSd6R3p8c+pP-i-W-g=t6ZfR5GVaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] MTTCG External Halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>

On 03/01/2018 17:10, Alistair Francis wrote:
> Hey guys, I'm super stuck with an ugly MTTCG issue and was wondering
> if anyone had any ideas.
> 
> In the Xilinx fork of QEMU (based on 2.11) we have a way for CPUs to
> halt other CPUs. This is used for example when the power control unit
> halts the ARM A53s. To do this we have internal GPIO signals that end
> up calling a function that basically does this:
> 
> To halt:
>     cpu->halted = true;
>     cpu_interrupt(cpu, CPU_INTERRUPT_HALT);

cpu->halted = true should not be needed here.  It will be set by
cpu_handle_interrupt when processing CPU_INTERRUPT_HALT.

> To un-halt
>     cpu->halted = false;
>     cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);

cpu->halted = false likewise should not be needed here, but you cannot
just clear CPU_INTERRUPT_HALT either.  You need to set a *different*
interrupt request bit (the dummy CPU_INTERRUPT_EXITTB will do) and
cpu_handle_halt will clear cpu->halted.

Paolo

> We also have the standard ARM WFI (Wait For Interrupt) implementation
> in op_helper.c:
>     cs->halted = 1;
>     cs->exception_index = EXCP_HLT;
>     cpu_loop_exit(cs);
> 
> Before MTTCG this used to work great, but now either we end up with
> the guest Linux complaining about CPU stalls or we hit:
> ERROR:/scratch/alistai/master-qemu/cpus.c:1516:qemu_tcg_cpu_thread_fn:
> assertion failed: (cpu->halted)
> 
> If I remove the instances of manually setting cpu->halted then I don't
> see the asserts(), but the the WFI instruction doesn't work correctly.
> So it seems like setting the halted status externally from the CPU
> causes the issue. I have tried setting it inside a lock, using atomic
> operations and running the setter async on the CPU, but nothing works.
> 
> Any chance any one has some insight into a way to externally set a
> vCPU as halted/un-halted?
> 
> Thanks,
> Alistair
> 
