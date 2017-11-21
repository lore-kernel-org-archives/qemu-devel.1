Received: from eggs.gnu.org ([2001:4830:134:3::10]:41910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eH3Ko-0008FV-SQ
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 02:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eH3Kl-000133-37
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 02:51:10 -0500
References: <1511222455.862.5.camel@linuxfoundation.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <e1b4faed-60f1-bfe3-2231-e357718dda1f@ilande.co.uk>
Date: Tue, 21 Nov 2017 07:50:48 +0000
MIME-Version: 1.0
In-Reply-To: <1511222455.862.5.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] qemu-system-ppc hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel <qemu-devel@nongnu.org>

On 21/11/17 00:00, Richard Purdie wrote:

> Hi,
> 
> I work on the Yocto Project and we use qemu to test boot our Linux
> images and run tests against them. We've been noticing some instability
> for ppc where the images sometimes hang, usually around udevd bring up
> time so just after booting into userspace.
> 
> To cut a long story short, I've tracked down what I think is the
> problem. I believe the decrementer timer stops receiving interrupts so
> tasks in our images hang indefinitely as the timer stopped. 
> 
> It can be summed up with this line of debug:
> 
> ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 => pending 00000100req 00000004
> 
> It should normally read:
> 
> ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 => pending 00000100req 00000002
> 
> The question is why CPU_INTERRUPT_EXITTB ends up being set when the
> lines above this log message clearly sets CPU_INTERRUPT_HARD (via 
> cpu_interrupt() ).
> 
> I note in cpu.h:
> 
>     /* updates protected by BQL */
>     uint32_t interrupt_request;
> 
> (for struct CPUState)
> 
> The ppc code does "cs->interrupt_request |= CPU_INTERRUPT_EXITTB" in 5
> places, 3 in excp_helper.c and 2 in helper_regs.h. In all cases,  
> g_assert(qemu_mutex_iothread_locked()); fails. If I do something like:
> 
> if (!qemu_mutex_iothread_locked()) {
>     qemu_mutex_lock_iothread();
>     cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
>     qemu_mutex_unlock_iothread();
> } else {
>     cpu_interrupt(cs, CPU_INTERRUPT_EXITTB);
> }
> 
> in these call sites then I can no longer lock qemu up with my test
> case.
> 
> I suspect the _HARD setting gets overwritten which stops the 
> decrementer interrupts being delivered.
> 
> I don't know if taking this lock in these situations is going to be bad
> for performance and whether such a patch would be right/wrong.
> 
> At this point I therefore wanted to seek advice on what the real issue
> is here and how to fix it!

Thanks for the report - given that a lot of work has been done on MTTCG
and iothread over the past few releases, it wouldn't be a complete
surprise if something had crept in here.

Firstly let's start off with some basics: what is your host
architecture, QEMU version and full command line being used to launch QEMU?

Would it also be possible for you to make your test image available for
other people to see if they can recreate the same issue?


ATB,

Mark.
