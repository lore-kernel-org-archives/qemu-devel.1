Received: from eggs.gnu.org ([2001:4830:134:3::10]:54810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cbkP1-0005jq-Pm
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 03:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cbkOx-00005I-Ou
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 03:48:31 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:42692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1cbkOx-0008W8-Er
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 03:48:27 -0500
References: <1486595166-34097-1-git-send-email-juro.bystricky@intel.com>
	<1486595166-34097-2-git-send-email-juro.bystricky@intel.com>
	<4c51c959-fe9c-b27f-552a-84d8a2fe68c1@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FB1B4@ORSMSX112.amr.corp.intel.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <ad0b171b-ae9d-11f9-15e8-c500cd4ef5c2@denx.de>
Date: Thu, 9 Feb 2017 09:46:40 +0100
MIME-Version: 1.0
In-Reply-To: <6E51916E4A1F32428260031F4C7CD2B6118FB1B4@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] nios2: Add Altera JTAG UART
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Bystricky, Juro" <juro.bystricky@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "crwulff@gmail.com" <crwulff@gmail.com>, "jurobystricky@hotmail.com" <jurobystricky@hotmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>

On 02/09/2017 01:54 AM, Bystricky, Juro wrote:

[...]

>>> +static uint64_t altera_juart_read(void *opaque, hwaddr addr, unsigned
>> int size)
>>> +{
>>> +    AlteraJUARTState *s = opaque;
>>> +    uint32_t r;
>>> +
>>> +    addr >>= 2;
>>
>> Hmmmmm, how will unaligned read from one of these registers be handled
>> on real HW ? ie. read from address 0x3 ? What about writes ?
>>
> 
> there is no reading/writing going on via "addr". 
> This just maps the hw address into register number, where registers are at
> 4 bytes boundaries (so they are aligned as needed) but indexed as 1,2,3.... 
> (Pretty common code in other drivers.)
> But will redo the code anyway so there are no shifts.

This doesn't answer my question at all. How does real hardware behave if
you read from unaligned address in the register space , ie. offset 0x3 ?

[...]

>>> +static void altera_juart_receive(void *opaque, const uint8_t *buf, int
>> size)
>>> +{
>>> +    int i;
>>> +    AlteraJUARTState *s = opaque;
>>> +
>>> +    if (s->rx_fifo_len >= FIFO_LENGTH) {
>>> +        fprintf(stderr, "WARNING: UART dropped char.\n");
>>
>> Can this ever happen ? can_receive will IMO prevent this case.
>>
> 
> Fair question. I did not go through all QEMU code to see when/where
> in the bowels of QEMU can_receive is actually called. If it is always called prior "receive", then this check may be redundant. Again, there are
> other serial drivers that do this check as well (etraxfs, Xilinx,...)
> But most don't, so I'll follow the majority and remove it.

Maybe you can check the core code or someone else can jump in an answer
this.

>>> diff --git a/include/hw/char/altera_juart.h
>> b/include/hw/char/altera_juart.h
>>> new file mode 100644
>>> index 0000000..8a9c892
>>> --- /dev/null
>>> +++ b/include/hw/char/altera_juart.h
>>> @@ -0,0 +1,44 @@
>>> +/*
>>> + * Altera JTAG UART emulation
>>> + *
>>> + * Copyright (c) 2016-2017 Intel Corporation.
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License
>>> + * as published by the Free Software Foundation; either version
>>> + * 2 of the License, or (at your option) any later version.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>> along
>>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#ifndef ALTERA_JUART_H
>>> +#define ALTERA_JUART_H
>>> +
>>> +#include "hw/sysbus.h"
>>> +#include "sysemu/char.h"
>>> +
>>> +/*
>>> + * The read and write FIFO depths can be set from 8 to 32,768 bytes.
>>> + * Only powers of two are allowed. A depth of 64 is generally optimal
>> for
>>> + * performance, and larger values are rarely necessary.
>>> + */
>>> +
>>> +#define FIFO_LENGTH 64
>>
>> Should probably be a QOM property, no ?
> 
> Did not want to mess with dynamic FIFO buffer allocation.

You probably should, since this is configurable at the FPGA level (in
QSys), right ?

>>> +typedef struct AlteraJUARTState {
>>> +    SysBusDevice busdev;
>>> +    MemoryRegion mmio;
>>> +    CharBackend chr;
>>> +    qemu_irq irq;
>>> +
>>> +    unsigned int rx_fifo_pos;
>>> +    unsigned int rx_fifo_len;
>>> +    uint32_t jdata;
>>> +    uint32_t jcontrol;
>>> +    uint8_t rx_fifo[FIFO_LENGTH];
>>> +} AlteraJUARTState;
>>> +
>>> +void altera_juart_create(int channel, const hwaddr addr, qemu_irq irq);
>>> +
>>> +#endif /* ALTERA_JUART_H */
>>>
>> btw for trivial patches like this, cover letter is not necessary .
> 
> Thanks, good to know, makes life easier
> Juro
> 


-- 
Best regards,
Marek Vasut
