Received: from eggs.gnu.org ([2001:4830:134:3::10]:43186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <debby83729@gmail.com>) id 1fLRGw-00053w-Ql
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <debby83729@gmail.com>) id 1fLRGv-0000ja-N1
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:45:34 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:40454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <debby83729@gmail.com>)
	id 1fLRGv-0000iJ-Be
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:45:33 -0400
Received: by mail-wm0-x236.google.com with SMTP id j5-v6so7813050wme.5
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 03:45:31 -0700 (PDT)
MIME-Version: 1.0
From: Eva Chen <debby83729@gmail.com>
Date: Wed, 23 May 2018 18:45:09 +0800
Message-ID: <CAG0V3WS2DemUdkP+HpZiYTOsPGRpAFCwZLNJ9CfA-VGv5bgKRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Questions about the flow of interrupt simulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I have added a new virtual device under qemu/hw, and a device driver in the
source code of guest OS (I use arm linux).
Since I want to add an interrupt to the virtual device, I am tracing the
flow of interrupt simulation of QEMU.
However, I have some questions about the flow of interrupt, and wondering
if I could ask here for some help.

I use $qemu-system-aarch64 -machine virt.
Take the flow of interrupt that generated from the UART pl011 device as
example.
First an interrupt, CPU_INTERRUPT_HARD, will be sent from device to GIC for
telling CPU that this device finished some job, then this interrupt wiil be
transformed into EXCP_IRQ in aarch64_cpu_do_interrupt() and interrupt
handled by CPU.

- Details of function call:
1. Device to GIC : pl011_write() => pl011_update() => gic_set_irq()
2. CPU handling : cpu_exec() => arm_cpu_exec_interrupt() =>
aarch64_cpu_do_interrupt()
Guest CPU's pc (env->pc) will be changed to the address of interrupt
service routine in aarch64_cpu_do_interrupt().

The question is:
Will CPU execute the ISR that env->pc assigned?
If yes, is the ISR defined in the guest OS (I use arm-linux kernel image)?
How can I see the code that handling the EXCP_IRQ? Is there any method I
can set some breakpoint in gdb or set some log flags to see the handler?
If not, then is that all guest ISR will not be called by using QEMU?

The reason that I have this question is that I look into the cpu_exec(),
find that tb_find() will be executed after handling an interrupt. At this
time, the ISR address in env->pc should be replaced by the TB that is going
to be executed. However, I don't know how to check my thought since I can't
debug of execution in the TB so I ask for some help here.

I will be grateful for any advice, thanks.

Sincerely,
Eva
