Received: from eggs.gnu.org ([209.51.188.92]:33426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gtodD-0003SP-Sm
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gtodC-0008Mu-0z
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:06:55 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60331
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gtodB-0008Ai-6d
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:06:53 -0500
References: <20190211040434.1C98674569F@zero.eik.bme.hu>
	<8962bd1d-267d-2edf-b5ce-9b67896a2b2e@redhat.com>
	<alpine.BSF.2.21.9999.1902122354210.68636@zero.eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <4d82a8a2-8737-8e53-9959-cc31cd79f3e7@ilande.co.uk>
Date: Wed, 13 Feb 2019 07:06:29 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1902122354210.68636@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On 12/02/2019 23:59, BALATON Zoltan wrote:

> Hello,
> 
> On Tue, 12 Feb 2019, Philippe Mathieu-Daudé wrote:
>> Hi Zoltan,
> 
> Thanks for the quick review and testing. I'll use your suggestions for the other
> (mips) patches in a v2. For this one I'm not convinced.
> 
>> On 2/11/19 4:19 AM, BALATON Zoltan wrote:
> [...]
>>> +
>>> +static void ati_reg_write_offs(uint32_t *reg, int offs,
>>> +                               uint64_t data, unsigned int size)
>>> +{
>>> +    int shift, i;
>>> +    uint32_t mask;
>>> +
>>> +    for (i = 0; i < size; i++) {
>>> +        shift = (offs + i) * 8;
>>> +        mask = 0xffUL << shift;
>>> +        *reg &= ~mask;
>>> +        *reg |= (data & 0xff) << shift;
>>> +        data >>= 8;
>>
>> I'd have use a pair of extract32/deposit32 but this is probably easier
>> to singlestep.
> 
> You've told me that before but I have concerns about the asserts in those functions
> which to me seem like unnecessary overhead in such low level functions so unless
> these are removed or *_noassert versions introduced I'll stay away from them.
> 
> But I'm also not too happy about these *_offs functions but some registers support
> 8/16/32 bit access and guest code seems to actually do this to update bits in the
> middle of the register at an odd address. Best would be if I could just set .impl.min
> = 4, .impl.max = 4 and .valid.min = 1 .valid.max = 4 for the mem region ops but I'm
> not sure that would work or would it? If that's working maybe I should just go with
> that instead.
> 
> [...]
>>> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
>>> new file mode 100644
>>> index 0000000000..85d045517c
>>> --- /dev/null
>>> +++ b/hw/display/ati_int.h
>>> @@ -0,0 +1,67 @@
>>> +/*
>>> + * QEMU ATI SVGA emulation
>>> + *
>>> + * Copyright (c) 2019 BALATON Zoltan
>>> + *
>>> + * This work is licensed under the GNU GPL license version 2 or later.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "hw/pci/pci.h"
>>> +#include "vga_int.h"
>>> +
>>> +#undef DEBUG_ATI
>>> +
>>> +#ifdef DEBUG_ATI
>>> +#define DPRINTF(fmt, ...) printf("%s: " fmt, __func__, ## __VA_ARGS__)
>>> +#else
>>> +#define DPRINTF(fmt, ...) do {} while (0)
>>
>> Please use tracepoints (you already add some!).
> 
> I won't and here's why: This is not a finished device model and I expect to need to
> add debug logs and change them frequently during further development and for such
> ad-hoc debugging DPRINF is still easier to use because I don't have to define the
> format string at one file and use them somewhere else. With DPRINTF I can just add a
> debug log at one place and change it easily without editing it at two unrelated
> places so it's easier to work with. Once development is finished those that we intend
> to leave in for later tracing can be converted to trace points (for which trace point
> is better) and at that point remove the DPRINTF macro. We still have enough DPRINTFs
> in QEMU so this should be OK. I've already added trace points to two such places but
> even for those I almost considered ditching them when checkpatch insisted I have to
> add 0x prefix to hex numbers (I don't like this because I know these are hex and
> printing e.g. 0x8 instead of 8 is just distracting from the actual important value
> which is what counts when I'm looking at a lot of these during debugging. Anything
> that distracts from actual values and makes it harder to read (such as timestamps and
> pids added by trace) is bad so I've considered going back to DPRINTF even for those
> trace points but will see if I can live with these for now.) But those that are still
> DPRINTFs won't be converted to trace but supposed to be removed when no longer needed.
> 
> [...]
>> I don't understand well the display code, but the result works very
>> well, nice work :)
>>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Thanks, it's a start and currently only targeting Linux console with a lot more to do
> for it to be more useful. But I have limited time for this so since it's already
> useful to get mips_fulong2e working I thought that justifies including it now so
> others have a chance to look at it and maybe even help to improve it which can't
> happen if it's only sitting on my machine.

This looks interesting, however I never received the original via the mailing list.
Did it get held somewhere because its size?

Also it's probably worth pushing it to a suitable git repo since then it's easier for
people to pull and update as required.


ATB,

Mark.
