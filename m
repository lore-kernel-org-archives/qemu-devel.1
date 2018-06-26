Received: from eggs.gnu.org ([2001:4830:134:3::10]:52618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fXlLy-0001kh-Og
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fXlLu-0004ta-Oj
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:37:42 -0400
Received: from steffen-goertz.de ([88.198.119.201]:51078)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fXlLu-0004tA-Ee
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:37:38 -0400
References: <20180619105451.29163-1-contrib@steffen-goertz.de>
	<CAJSP0QWx6wAV001uAwAh-BKFCGFiTH09yErZCoj=pyJCLNNv-Q@mail.gmail.com>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <02516177-0a76-1647-5b8e-c33a6061aff3@steffen-goertz.de>
Date: Tue, 26 Jun 2018 12:37:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWx6wAV001uAwAh-BKFCGFiTH09yErZCoj=pyJCLNNv-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] Add NRF51 RNG peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

Hi Stefan,>
>> +static void nrf51_rng_timer_expire(void *opaque) {
>> +    Nrf51RNGState *s = NRF51_RNG(opaque);
>> +
>> +    qcrypto_random_bytes(&s->value, 1, NULL);
>> +
>> +    s->state.event_valrdy = 1;
>> +    qemu_set_irq(s->eep_valrdy, 1);
>> +
>> +    if(s->state.interrupt_enabled) {
>> +        qemu_irq_pulse(s->irq);
>> +    }
>
> Why does eep_valrdy use qemu_set_irq() while s->irq uses
> qemu_irq_pulse()?  I don't see a many other qemu_irq_pulse() instances
> in hw/arm/ so I'm curious why it was necessary.
>
The "real" ARM armv7m NVIC supports both level and pulsed interrupt
lines from connected devices (see ARM TRM cortex-m 8.3. Level versus
pulse interrupts). Level interrupts require (both in "real" and modeled
devices) some kind of interrupt flag held in the context of the device,
which is reflected in the device interrupt line.

The Nrf51 RNG peripheral does not have a peripheral interrupt status
register neither does it have a interrupt status flag. Furthermore the
nature of the timer expire tick is of a pulsed rather then a stateful
nature.

The model of the ARM armv7m NVIC (armv7m_nvic.c) also supports pulsed
interrupts sources, see set_irq_level:

>/* The pending status of an external interrupt is
> * latched on rising edge and exception handler return.
> *
> * Pulsing the IRQ will always run the handler
> * once, and the handler will re-run until the
> * level is low when the handler completes.
>*/

I used the pulsed implementation because it was more straightforward to
use in this situation.

Best,
Steffen
