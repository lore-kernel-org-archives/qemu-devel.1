Received: from eggs.gnu.org ([2001:4830:134:3::10]:54735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dW3ZI-0001s8-NW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dW3ZF-0003xF-KM
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:35:52 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dW3ZF-0003wb-Cf
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:35:49 -0400
Received: by mail-wm0-x229.google.com with SMTP id f67so27837249wmh.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 09:35:49 -0700 (PDT)
References: <1500029487-14822-1-git-send-email-peter.maydell@linaro.org>
	<1500029487-14822-4-git-send-email-peter.maydell@linaro.org>
	<87lgnruibx.fsf@linaro.org>
	<CAFEAcA--sxG2rOdeTvD=uNsOj=RFW8wFVALSaE1QU92Xzow1wA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA--sxG2rOdeTvD=uNsOj=RFW8wFVALSaE1QU92Xzow1wA@mail.gmail.com>
Date: Fri, 14 Jul 2017 17:35:46 +0100
Message-ID: <87fudzugbh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 3/9] hw/arm/mps2: Add UARTs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Philippe =?utf-8?Q?Mathie?= =?utf-8?Q?u-Daud=C3=A9?= <f4bug@amsat.org>, "patches@linaro.org" <patches@linaro.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 14 July 2017 at 16:52, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> Add the UARTs to the MPS2 board models.
>>>
>>> Unfortunately the details of the wiring of the interrupts through
>>> various OR gates differ between AN511 and AN385 so this can't
>>> be purely a data-driven difference.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>>> ---
>>>  hw/arm/mps2.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 86 insertions(+)
>>>
>>> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
>>> index 3dad02d..180c5d2 100644
>>> --- a/hw/arm/mps2.c
>>> +++ b/hw/arm/mps2.c
>>> @@ -27,9 +27,12 @@
>>>  #include "qemu/error-report.h"
>>>  #include "hw/arm/arm.h"
>>>  #include "hw/arm/armv7m.h"
>>> +#include "hw/or-irq.h"
>>>  #include "hw/boards.h"
>>>  #include "exec/address-spaces.h"
>>> +#include "sysemu/sysemu.h"
>>>  #include "hw/misc/unimp.h"
>>> +#include "hw/char/cmsdk-apb-uart.h"
>>>
>>>  typedef enum MPS2FPGAType {
>>>      FPGA_AN385,
>>> @@ -206,6 +209,89 @@ static void mps2_common_init(MachineState *machine)
>>>      create_unimplemented_device("Ethernet", 0x40200000, 0x00100000);
>>>      create_unimplemented_device("VGA", 0x41000000, 0x0200000);
>>>
>>> +    switch (mmc->fpga_type) {
>>> +    case FPGA_AN385:
>>> +    {
>>> +        /* The overflow IRQs for UARTs 0, 1 and 2 are ORed together.
>>> +         * Overflow for UARTs 4 and 5 doesn't trigger any interrupt.
>>> +         */
>>> +        Object *orgate;
>>> +        DeviceState *orgate_dev;
>>> +        int i;
>>> +
>>> +        orgate = object_new(TYPE_OR_IRQ);
>>> +        object_property_set_int(orgate, 6, "num-lines", &error_fatal);
>>> +        object_property_set_bool(orgate, true, "realized", &error_fatal);
>>> +        orgate_dev = DEVICE(orgate);
>>> +        qdev_connect_gpio_out(orgate_dev, 0, qdev_get_gpio_in(armv7m, 12));
>>> +
>>> +        for (i = 0; i < 5; i++) {
>>> +            hwaddr uartbase[] = {0x40004000, 0x40005000, 0x40006000,
>>> +                                 0x40007000, 0x40009000};
>>
>> I would expect these to be something like:
>>
>>   static hwaddr an385_uartbase[] = {0x40004000, 0x40005000, 0x40006000,
>>                                     0x40007000, 0x40009000};
>>   static hwaddr an511_uartbase[] = {0x40004000, 0x40005000, 0x4002c000,
>>                                     0x4002d000, 0x4002e000};
>>
>> to save the compiler from filling in the table every loop. Not that it
>> makes much different for an init routine.
>
> I'm slightly surprised the compiler can't tell that these
> are never written and emit the same code for all of them,
> but yeah, let's just 'static const' all of them.

I was just curious so I objdumped - maybe we should poke our TCWG
friends ;-)

--
Alex Bennée
