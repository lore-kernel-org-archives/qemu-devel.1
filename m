Received: from eggs.gnu.org ([2001:4830:134:3::10]:48884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eXe9y-0001DI-QJ
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 21:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eXe9u-0000JS-W3
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 21:24:34 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:43329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eXe9u-0000Im-Oi
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 21:24:30 -0500
Received: by mail-wr0-x232.google.com with SMTP id s13so3368507wra.10
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 18:24:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87lghd3mq6.fsf@linaro.org>
References: <CAKmqyKPZ3AUwGFwp6zK+aFSd6R3p8c+pP-i-W-g=t6ZfR5GVaA@mail.gmail.com>
	<87lghd3mq6.fsf@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 5 Jan 2018 18:23:59 -0800
Message-ID: <CAKmqyKMgrU+4ABijd0SgomyZriVjVFMYt=TXs5b9--w_kenZ+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] MTTCG External Halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On Thu, Jan 4, 2018 at 3:08 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
> Alistair Francis <alistair23@gmail.com> writes:
>
>> Hey guys, I'm super stuck with an ugly MTTCG issue and was wondering
>> if anyone had any ideas.
>>
>> In the Xilinx fork of QEMU (based on 2.11) we have a way for CPUs to
>> halt other CPUs. This is used for example when the power control unit
>> halts the ARM A53s. To do this we have internal GPIO signals that end
>> up calling a function that basically does this:
>>
>> To halt:
>>     cpu->halted =3D true;
>>     cpu_interrupt(cpu, CPU_INTERRUPT_HALT);
>
> Hmm I don't think you should be setting cpu->halted unless you know it
> is safe to do so. As the other CPUs free-run during BQL this isn't
> enough for a cross vCPU interaction. However you can schedule work to
> run in the target vCPUs context safely.

We actually pretty much only ever set it on reset.

>
> That said isn't the cpu_interrupt enough to trigger the target vCPU to
> halt?
>
>>
>> To un-halt
>>     cpu->halted =3D false;
>>     cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
>
> Again if cross vCPU context this needs to be scheduled against the
> target vCPU.
>
>>
>> We also have the standard ARM WFI (Wait For Interrupt) implementation
>> in op_helper.c:
>>     cs->halted =3D 1;
>>     cs->exception_index =3D EXCP_HLT;
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
>> causes the issue.
>
>   /* during start-up the vCPU is reset and the thread is
>    * kicked several times. If we don't ensure we go back
>    * to sleep in the halted state we won't cleanly
>    * start-up when the vCPU is enabled.
>    *
>    * cpu->halted should ensure we sleep in wait_io_event
>    */
>
> I think what I'm trying to say is we should never be halted without
> having gone via wait_io_event where we can sleep.
>
>
>> I have tried setting it inside a lock, using atomic
>> operations and running the setter async on the CPU, but nothing works.
>>
>> Any chance any one has some insight into a way to externally set a
>> vCPU as halted/un-halted?
>
> See the PSCI code which uses the async interface for exactly this.

Yeah, that and a fix to our weird double reset fixed it.

What I don't get is how a double reset would cause the assert() to be hit.

Alistair

>
>>
>> Thanks,
>> Alistair
>
>
> --
> Alex Benn=C3=A9e
