Received: from eggs.gnu.org ([2001:4830:134:3::10]:57562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eWfGs-0000QP-AI
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eWfGp-0002bb-4L
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:23:38 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1eWfGo-0002aU-UO
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:23:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Wed, 03 Jan 2018 10:23:32 +0100
From: jcd@tribudubois.net
In-Reply-To: <beb9b438-53b3-7c5f-7876-89168bf3caa1@adacore.com>
References: <4b0a136a-7017-0890-6dd9-33bd8ddf3e3d@tribudubois.net>
	<beb9b438-53b3-7c5f-7876-89168bf3caa1@adacore.com>
Message-ID: <d99a2a11422aa9859b521b4614f744ff@tribudubois.net>
Subject: Re: [Qemu-devel] [SPARC] question on LEON IRQMP interrupt
 controller.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabien Chouteau <chouteau@adacore.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, jcd@tribudubois.net

Le 2018-01-02 19:58, Fabien Chouteau a écrit :
> Hello Jean-Christophe,
> 
> I'm the original author of this patch and I add in copy my colleague
> Frederic.
> 
> On 02/01/2018 12:13, Jean-Christophe DUBOIS wrote:
>> I am wondering if the IRQMP code in hw/intc/grlib_irqmp.c is correct
>> when it comes to acknowledging interrupts.
>> 
>> With the actual code an interrupt can be lowered/acked only by an
>> "ack" from the processor which means that the trap handler related to
>> this external interrupt needs to be run for the ack to happen.
>> 
>> In particular this means that the interrupt cannot be acked only by
>> software. Even if the software clears the "pending" interrupts (by
>> writing to the CLEAR_OFFSET register before the interrupt handler is
>> run) this does not clear the interrupt to the processor (which is kept
>> asserted until the handler is run and the interrupt acked by the
>> processor). Do you know if this is indeed the intended behavior (I
>> understand that for most operating system the interrupt handler will
>> be run at last and this does not make a difference)?
>> 
>> I would expect that clearing interrupt through software (by writing to
>> the CLEAR_OFFSET register) would have the same effect as the processor
>> acknowledgment (and could avoid to run the interrupt handler if things
>> have already been taken care of by software).
>> 
>> Unfortunately the documentation I got (on the web) on the IRQMP is not
>> very clear on the topic.
>> 
> 
> I don't remember all the details of this CPU on top of my head, I 
> worked
> on this years ago.
> 
> If you have access to a real board the best would be to compare the
> behavior of the CPU on it.

Unfortunately I don't have a real board (yet).

> There's also a cycle accurate simulator of
> Leon3, you can download an evaluation version here:
> http://www.gaisler.com/index.php/downloads/simulators

OK, I will try the tsim simulator from Gaisler as a reference.

> 
>> Anyway you can find below the patch I'd like to provide for IRQMP.
>> 
> 
> Can you explain the reason for this change? Why can't you use the
> current interrupt handling?

I am working on a cooperative multitasking kernel (with no preemption). 
So the kernel is not handling interrupt related traps (actually the 
kernel is not handling the interrupt controller). All interrupts are 
masked at all time for all application or kernel so no interrupt trap 
handler is ever going to trigger (except for IRQ 15 which is not 
maskable).

When the tasks have nothing to do the kernel goes to sleep using ASR19 
on LEON. So the system is awaken by next interrupt and the kernel will 
schedule the task handling the interrupt controller.

On LEON, I can go to sleep until the first interrupt. Once the first 
interrupt has been raised the LEON will never be able to get to 
sleep/idle again through ASR19 (it exists immediately) even if the 
interrupt controller handling task clears the interrupt (writing to 
CLEAR_OFFSET register). And this is because, in the actual Qemu 
implementation, the interrupt can only be acknowledged in the interrupt 
controller by the CPU through the triggering of the related trap 
handler.

So I am wondering if this is indeed the expected behavior in real 
hardware/life (interrupts can only be acked by processor and not by 
software).

Note: On a related subject I am wondering if the system (put in 
idle/sleep through ASR19) would woke up on interrupt if the interrupts 
are all masked through PSR (PIL) (it does wake up in Qemu for now). I 
will also test this on tsim before trying it on real hardware someday.

> 
> Regards,
