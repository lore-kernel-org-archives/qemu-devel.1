Received: from eggs.gnu.org ([2001:4830:134:3::10]:54191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cbqnJ-0004cE-RJ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cbqnG-0006ig-NB
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:38:01 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:40275)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1cbqnG-0006h9-Dq
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:37:58 -0500
References: <1486595166-34097-1-git-send-email-juro.bystricky@intel.com>
	<1486595166-34097-2-git-send-email-juro.bystricky@intel.com>
	<4c51c959-fe9c-b27f-552a-84d8a2fe68c1@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FB1B4@ORSMSX112.amr.corp.intel.com>
	<ad0b171b-ae9d-11f9-15e8-c500cd4ef5c2@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FB84B@ORSMSX112.amr.corp.intel.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <8a5c3932-5ca6-6127-35b4-b8b8f57d923f@denx.de>
Date: Thu, 9 Feb 2017 16:37:31 +0100
MIME-Version: 1.0
In-Reply-To: <6E51916E4A1F32428260031F4C7CD2B6118FB84B@ORSMSX112.amr.corp.intel.com>
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

On 02/09/2017 04:22 PM, Bystricky, Juro wrote:
> 
> 
>> [...]
>>
>>>>> +static uint64_t altera_juart_read(void *opaque, hwaddr addr, unsigned
>>>> int size)
>>>>> +{
>>>>> +    AlteraJUARTState *s = opaque;
>>>>> +    uint32_t r;
>>>>> +
>>>>> +    addr >>= 2;
>>>>
>>>> Hmmmmm, how will unaligned read from one of these registers be handled
>>>> on real HW ? ie. read from address 0x3 ? What about writes ?
>>>>
>>>
>>> there is no reading/writing going on via "addr".
>>> This just maps the hw address into register number, where registers are
>> at
>>> 4 bytes boundaries (so they are aligned as needed) but indexed as
>> 1,2,3....
>>> (Pretty common code in other drivers.)
>>> But will redo the code anyway so there are no shifts.
>>
>> This doesn't answer my question at all. How does real hardware behave if
>> you read from unaligned address in the register space , ie. offset 0x3 ?
>>
> 
> Not sure I understand the question here. Which "real hardware" are we talking about?

By real hardware I mean real Nios2 system ...

> If "real hardware" contains MMU or MPU then an exception is generated on misalign access.

Is this handled here or not ?

>> [...]
>>
>>>>> +static void altera_juart_receive(void *opaque, const uint8_t *buf, int
>>>> size)
>>>>> +{
>>>>> +    int i;
>>>>> +    AlteraJUARTState *s = opaque;
>>>>> +
>>>>> +    if (s->rx_fifo_len >= FIFO_LENGTH) {
>>>>> +        fprintf(stderr, "WARNING: UART dropped char.\n");
>>>>
>>>> Can this ever happen ? can_receive will IMO prevent this case.
>>>>
>>>
>>> Fair question. I did not go through all QEMU code to see when/where
>>> in the bowels of QEMU can_receive is actually called. If it is always
>> called prior "receive", then this check may be redundant. Again, there are
>>> other serial drivers that do this check as well (etraxfs, Xilinx,...)
>>> But most don't, so I'll follow the majority and remove it.
>>
>> Maybe you can check the core code or someone else can jump in an answer
>> this.
> 
> OK, will look deeper
> 
> [...] 
> 
>>>>> +#ifndef ALTERA_JUART_H
>>>>> +#define ALTERA_JUART_H
>>>>> +
>>>>> +#include "hw/sysbus.h"
>>>>> +#include "sysemu/char.h"
>>>>> +
>>>>> +/*
>>>>> + * The read and write FIFO depths can be set from 8 to 32,768 bytes.
>>>>> + * Only powers of two are allowed. A depth of 64 is generally optimal
>>>> for
>>>>> + * performance, and larger values are rarely necessary.
>>>>> + */
>>>>> +
>>>>> +#define FIFO_LENGTH 64
>>>>
>>>> Should probably be a QOM property, no ?
>>>
>>> Did not want to mess with dynamic FIFO buffer allocation.
>>
>> You probably should, since this is configurable at the FPGA level (in
>> QSys), right ?
>>
> 
> OK, will implement fifo size as a property
> 
> 
> Thanks
> Juro
> 


-- 
Best regards,
Marek Vasut
