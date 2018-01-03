Received: from eggs.gnu.org ([2001:4830:134:3::10]:35392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWrFk-0008VQ-08
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWrFj-0001ft-1Q
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:11:15 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eWrFi-0001ek-Ol
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:11:14 -0500
Received: by mail-wm0-x234.google.com with SMTP id 64so267002wme.3
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 14:11:14 -0800 (PST)
MIME-Version: 1.0
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jan 2018 14:10:42 -0800
Message-ID: <CAKmqyKPZ3AUwGFwp6zK+aFSd6R3p8c+pP-i-W-g=t6ZfR5GVaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] MTTCG External Halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>

Hey guys, I'm super stuck with an ugly MTTCG issue and was wondering
if anyone had any ideas.

In the Xilinx fork of QEMU (based on 2.11) we have a way for CPUs to
halt other CPUs. This is used for example when the power control unit
halts the ARM A53s. To do this we have internal GPIO signals that end
up calling a function that basically does this:

To halt:
    cpu->halted = true;
    cpu_interrupt(cpu, CPU_INTERRUPT_HALT);

To un-halt
    cpu->halted = false;
    cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);

We also have the standard ARM WFI (Wait For Interrupt) implementation
in op_helper.c:
    cs->halted = 1;
    cs->exception_index = EXCP_HLT;
    cpu_loop_exit(cs);

Before MTTCG this used to work great, but now either we end up with
the guest Linux complaining about CPU stalls or we hit:
ERROR:/scratch/alistai/master-qemu/cpus.c:1516:qemu_tcg_cpu_thread_fn:
assertion failed: (cpu->halted)

If I remove the instances of manually setting cpu->halted then I don't
see the asserts(), but the the WFI instruction doesn't work correctly.
So it seems like setting the halted status externally from the CPU
causes the issue. I have tried setting it inside a lock, using atomic
operations and running the setter async on the CPU, but nothing works.

Any chance any one has some insight into a way to externally set a
vCPU as halted/un-halted?

Thanks,
Alistair
