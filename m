Received: from eggs.gnu.org ([2001:4830:134:3::10]:41851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gWHRw-0002o8-Du
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gWHRq-0008Hz-Fi
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 04:02:00 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAErn8fQO8cwNC8KjkczGwh6L3sTgxyzPX48fVkUdihXW9gHBSg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ecb955dd-2312-ca7c-6f7f-37ca024d918e@amsat.org>
Date: Mon, 10 Dec 2018 10:01:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAErn8fQO8cwNC8KjkczGwh6L3sTgxyzPX48fVkUdihXW9gHBSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] possible bug hw/adc/stm32f2xx_adc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Seth K <skintigh@gmail.com>, Alistair Francis <alistair23@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>

Hi Seth,

On 12/10/18 4:39 AM, Seth K wrote:
> Thank you all for help with my last patch. I found one more entry in my
> notes that could be a bug, or could be a misunderstanding on my part.
> 
> The memory map in DocID15818 (Rev 15) datasheet says:
>     ADC1 - ADC2 - ADC3:  0x40012000-0x400123FF
> 
> That suggests a size of 0x400 (they share that range?)

This datasheet is more about how the chip interracts with the external
world. There is another document about how to use it (internally) which
is the "Technical Reference Manual" (RM0033 Rev 8):
https://www.st.com/resource/en/reference_manual/cd00225773.pdf

See Section 10.13.18 "ADC register map": There are 3 ADCs indeed, each
mapped at a 0x100 base. Each ADC can be addressed in a 0x50 bytes range.

> 
> Line 279/280 of hw/adc/stm32f2xx_adc.c seems to use 0xFF
> memory_region_init_io(&s->mmio,obj,&stm32f2xx_adc_ops,s,
> 	TYPE_STM32F2XX_ADC,0xFF);

This code define a single ADC and looks correct.

The consumer of this ADC is the SoC object, defined in the file
hw/arm/stm32f205_soc.c. You can see lines 70:

 for (i = 0; i < STM_NUM_ADCS; i++) {
     sysbus_init_child_obj(obj, "adc[*]", &s->adc[i], sizeof(s->adc[i]),
                           TYPE_STM32F2XX_ADC);
 }

Having in include/hw/arm/stm32f205_soc.h:42:#define STM_NUM_ADCS 3
and:
static const uint32_t adc_addr[STM_NUM_ADCS] = { 0x40012000, 0x40012100,
    0x40012200 };

So the SoC code instanciates 3 ADCs, each at the correct address.
(You can check the SoC Memory Map at Section 2.3 "Memory map" p. 53).

An easy way to figure out the memory map in QEMU is using the 'info
mtree' in the QEMU Monitor:

qemu-system-arm -M netduino2 -kernel /dev/null -S -monitor stdio
QEMU 3.0.94 monitor - type 'help' for more information
(qemu) info mtree
address-space: memory
  0000000000000000-ffffffffffffffff (prio -1, i/o): system
    0000000000000000-00000000000fffff (prio 0, i/o): alias flash
    0000000008000000-00000000080fffff (prio 0, rom): STM32F205.flash
    0000000020000000-000000002001ffff (prio 0, ram): STM32F205.sram
    0000000040000000-00000000400003ff (prio 0, i/o): stm32f2xx_timer
    0000000040000400-00000000400007ff (prio 0, i/o): stm32f2xx_timer
    0000000040000800-0000000040000bff (prio 0, i/o): stm32f2xx_timer
    0000000040000c00-0000000040000fff (prio 0, i/o): stm32f2xx_timer
    0000000040003800-0000000040003bff (prio 0, i/o): stm32f2xx-spi
    0000000040003c00-0000000040003fff (prio 0, i/o): stm32f2xx-spi
    0000000040004400-00000000400047ff (prio 0, i/o): stm32f2xx-usart
    0000000040004800-0000000040004bff (prio 0, i/o): stm32f2xx-usart
    0000000040004c00-0000000040004fff (prio 0, i/o): stm32f2xx-usart
    0000000040005000-00000000400053ff (prio 0, i/o): stm32f2xx-usart
    0000000040011000-00000000400113ff (prio 0, i/o): stm32f2xx-usart
    0000000040011400-00000000400117ff (prio 0, i/o): stm32f2xx-usart
    0000000040012000-00000000400120fe (prio 0, i/o): stm32f2xx-adc
    0000000040012100-00000000400121fe (prio 0, i/o): stm32f2xx-adc
    0000000040012200-00000000400122fe (prio 0, i/o): stm32f2xx-adc
    0000000040013000-00000000400133ff (prio 0, i/o): stm32f2xx-spi
    0000000040013800-0000000040013bff (prio 0, i/o): stm32f2xx-syscfg

You are correct we should declare a 0x100 region rather than 0xff.

> 
> Probably just confusion on my part, but thought I would mention it just
> in case.
> Thanks,
> Seth
> 
> PS: Sorry if you are all the wrong people to email about this ADC...

You did well :)

You can also use this script:

./scripts/get_maintainer.pl -f hw/adc/stm32f2xx_adc.c
Alistair Francis <alistair@alistair23.me> (maintainer:STM32F205)
Peter Maydell <peter.maydell@linaro.org> (maintainer:STM32F205)
qemu-devel@nongnu.org (open list:All patches CC here)

But for this particular case, using the SoC file is more complete (you
get the ARM list):

./scripts/get_maintainer.pl -f hw/arm/stm32f205_soc.c
Alistair Francis <alistair@alistair23.me> (maintainer:STM32F205)
Peter Maydell <peter.maydell@linaro.org> (maintainer:STM32F205)
qemu-arm@nongnu.org (open list:ARM)
qemu-devel@nongnu.org (open list:All patches CC here)

Regards,

Phil.
