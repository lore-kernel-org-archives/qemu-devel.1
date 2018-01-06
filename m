Received: from eggs.gnu.org ([2001:4830:134:3::10]:47968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eXqmH-0001wQ-A4
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 10:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eXqmE-0004TL-M4
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 10:52:57 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50059)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1eXqmE-0004Rb-Fj
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 10:52:54 -0500
References: <4b0a136a-7017-0890-6dd9-33bd8ddf3e3d@tribudubois.net>
	<beb9b438-53b3-7c5f-7876-89168bf3caa1@adacore.com>
	<d99a2a11422aa9859b521b4614f744ff@tribudubois.net>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <1cf163ce-81c3-80a1-3c99-4f79b7b88e18@tribudubois.net>
Date: Sat, 6 Jan 2018 16:52:48 +0100
MIME-Version: 1.0
In-Reply-To: <d99a2a11422aa9859b521b4614f744ff@tribudubois.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>

Hi,

So after trying my code on tsim, I can confirm that the software is 
indeed able to clear/ack the interrupt without requiring the ack from 
the processor.

Things are a bit strange with tsim as the simulator doesn't seem to 
respect time delay when the processor is in sleep/idle mode and jump 
straight to the next timer expiration/interrupt (incrementing the 
required clock cycles in the process) ...

And as the evaluation version of tsim stops the program after 2^32 clock 
cycles the program could not run more than 86 seconds (with the LEON 
clock @ 50 MHz).

But still the interrupts are acknowledged by software only without 
requiring the trap handler to run or the processor to ack the interrupt 
on a hardware way.

So I believe that my proposed modification is correct.

On a related note, tsim is using different interrupts (than Qemu) for 
timer and all. So what is the reference LEON3 platform that Qemu is 
emulating with leon3_generic?

JC

Le 03/01/2018 à 10:23, jcd@tribudubois.net a écrit :
> Le 2018-01-02 19:58, Fabien Chouteau a écrit :
>> Hello Jean-Christophe,
>>
>> I'm the original author of this patch and I add in copy my colleague
>> Frederic.
>>
>> On 02/01/2018 12:13, Jean-Christophe DUBOIS wrote:
>>> I am wondering if the IRQMP code in hw/intc/grlib_irqmp.c is correct
>>> when it comes to acknowledging interrupts.
>>>
>>> With the actual code an interrupt can be lowered/acked only by an
>>> "ack" from the processor which means that the trap handler related to
>>> this external interrupt needs to be run for the ack to happen.
>>>
>>> In particular this means that the interrupt cannot be acked only by
>>> software. Even if the software clears the "pending" interrupts (by
>>> writing to the CLEAR_OFFSET register before the interrupt handler is
>>> run) this does not clear the interrupt to the processor (which is kept
>>> asserted until the handler is run and the interrupt acked by the
>>> processor). Do you know if this is indeed the intended behavior (I
>>> understand that for most operating system the interrupt handler will
>>> be run at last and this does not make a difference)?
>>>
>>> I would expect that clearing interrupt through software (by writing to
>>> the CLEAR_OFFSET register) would have the same effect as the processor
>>> acknowledgment (and could avoid to run the interrupt handler if things
>>> have already been taken care of by software).
>>>
>>> Unfortunately the documentation I got (on the web) on the IRQMP is not
>>> very clear on the topic.
>>>
>>
>> I don't remember all the details of this CPU on top of my head, I worked
>> on this years ago.
>>
>> If you have access to a real board the best would be to compare the
>> behavior of the CPU on it.
>
> Unfortunately I don't have a real board (yet).
>
>> There's also a cycle accurate simulator of
>> Leon3, you can download an evaluation version here:
>> http://www.gaisler.com/index.php/downloads/simulators
>
> OK, I will try the tsim simulator from Gaisler as a reference.
>
>>
>>> Anyway you can find below the patch I'd like to provide for IRQMP.
>>>
>>
>> Can you explain the reason for this change? Why can't you use the
>> current interrupt handling?
>
> I am working on a cooperative multitasking kernel (with no 
> preemption). So the kernel is not handling interrupt related traps 
> (actually the kernel is not handling the interrupt controller). All 
> interrupts are masked at all time for all application or kernel so no 
> interrupt trap handler is ever going to trigger (except for IRQ 15 
> which is not maskable).
>
> When the tasks have nothing to do the kernel goes to sleep using ASR19 
> on LEON. So the system is awaken by next interrupt and the kernel will 
> schedule the task handling the interrupt controller.
>
> On LEON, I can go to sleep until the first interrupt. Once the first 
> interrupt has been raised the LEON will never be able to get to 
> sleep/idle again through ASR19 (it exists immediately) even if the 
> interrupt controller handling task clears the interrupt (writing to 
> CLEAR_OFFSET register). And this is because, in the actual Qemu 
> implementation, the interrupt can only be acknowledged in the 
> interrupt controller by the CPU through the triggering of the related 
> trap handler.
>
> So I am wondering if this is indeed the expected behavior in real 
> hardware/life (interrupts can only be acked by processor and not by 
> software).
>
> Note: On a related subject I am wondering if the system (put in 
> idle/sleep through ASR19) would woke up on interrupt if the interrupts 
> are all masked through PSR (PIL) (it does wake up in Qemu for now). I 
> will also test this on tsim before trying it on real hardware someday.
>
>>
>> Regards,
>
>
>
