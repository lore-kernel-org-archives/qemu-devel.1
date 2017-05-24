Received: from eggs.gnu.org ([2001:4830:134:3::10]:54935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDOe4-0007g1-4y
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDOe0-0005a6-B1
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:15:40 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170520002653.20213-1-andrew@aj.id.au>
	<20170520002653.20213-2-andrew@aj.id.au>
	<59538b3b-2936-cdc7-f582-9d473c72ce09@amsat.org>
	<1495412633.23485.3.camel@aj.id.au>
	<660ee5968bc04bc7a318835d53f331ba@TWMBX01.aspeed.com>
	<1495430041.22806.1.camel@aj.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <041887dc-c613-2bf3-e927-0381a7221b54@amsat.org>
Date: Wed, 24 May 2017 02:15:32 -0300
MIME-Version: 1.0
In-Reply-To: <1495430041.22806.1.camel@aj.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/2] hw/adc: Add basic Aspeed
 ADC model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jeffery <andrew@aj.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Joel Stanley <joel@jms.id.au>

Hi Andrew,

On 05/22/2017 02:14 AM, Andrew Jeffery wrote:
> On Mon, 2017-05-22 at 03:15 +0000, Ryan Chen wrote:
>> In ASPEED SoC chip, all register access have following rule.
>> Most of controller write access is only support 32bit access.
>> Read is support 8bits/16bits/32bits.

This makes sens thinking about how a DMA controller can take advantage 
of the ADC.

>
> Thanks for clearing that up Ryan.
>
> Phil: I'll rework the model so the reads are 16-bits.

This shouldn't be necessary, QEMU is supposed to supports different 
access size for different implemented size, so you can declare your 
implementation as 32-bit and valid accesses from 8 to 32:

  static const MemoryRegionOps aspeed_adc_ops = {
      .read = aspeed_adc_read,
      .write = aspeed_adc_write,
      .endianness = DEVICE_LITTLE_ENDIAN,
      .valid.min_access_size = 1,
      .valid.max_access_size = 4,
      .valid.unaligned = false,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
  };

This way an I/O access from the CPU or a DMA could use 8/16-bit while 
you keep a 32-bit implementation. The adjustment is done by 
access_with_adjusted_size() from memory.c.

Afaik there is, however, no distinction between read/write different 
access size in current QEMU MemoryRegionOps model.

>
> Thanks,
>
> Andrew
>
>>
>>
>>
>> Best Regards,
>> Ryan
>>
>> 信驊科技股份有限公司
>> ASPEED Technology Inc.
>> 2F,No.15,Industry East Road 4.,Hsinchu Science Park, Hsinchu City 30077, Taiwan
>> Tel: 886-3-578-9568  #857
>> Fax: 886-3-578-9586
>> ************* Email Confidentiality Notice ********************
>> DISCLAIMER:
>> This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
>>
>> -----Original Message-----
>>> From: Andrew Jeffery [mailto:andrew@aj.id.au]
>> Sent: Monday, May 22, 2017 8:24 AM
>>> To: Philippe Mathieu-Daudé <f4bug@amsat.org>; qemu-arm@nongnu.org
>>>>> Cc: Peter Maydell <peter.maydell@linaro.org>; Ryan Chen <ryan_chen@aspeedtech.com>; Alistair Francis <alistair@alistair23.me>; qemu-devel@nongnu.org; Cédric Le Goater <clg@kaod.org>; Joel Stanley <joel@jms.id.au>
>> Subject: Re: [Qemu-arm] [PATCH 1/2] hw/adc: Add basic Aspeed ADC model
>>
>> Hi Phil,
>>
>> On Sat, 2017-05-20 at 00:21 -0300, Philippe Mathieu-Daudé wrote:
>>> Hi Andrew,
>>>
>>> On 05/19/2017 09:26 PM, Andrew Jeffery wrote:
>>>> This model implements enough behaviour to do basic functionality
>>>> tests such as device initialisation and read out of dummy sample
>>>> values. The sample value generation strategy is similar to the STM
>>>> ADC already in the tree.
>>>>
>>>>>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>>>>
>>>> ---
>>>>  hw/adc/Makefile.objs        |   1 +
>>>>  hw/adc/aspeed_adc.c         | 246
>>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>>  include/hw/adc/aspeed_adc.h |  33 ++++++
>>>>  3 files changed, 280 insertions(+)
>>>>  create mode 100644 hw/adc/aspeed_adc.c
>>>>  create mode 100644 include/hw/adc/aspeed_adc.h
>>>>
>>>> diff --git a/hw/adc/Makefile.objs b/hw/adc/Makefile.objs index
>>>> 3f6dfdedaec7..2bf9362ba3c4 100644
>>>> --- a/hw/adc/Makefile.objs
>>>> +++ b/hw/adc/Makefile.objs
>>>> @@ -1 +1,2 @@
>>>>  obj-$(CONFIG_STM32F2XX_ADC) += stm32f2xx_adc.o
>>>> +obj-$(CONFIG_ASPEED_SOC) += aspeed_adc.o
>>>> diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c new file mode
>>>> 100644 index 000000000000..d08f1684f7bc
>>>> --- /dev/null
>>>> +++ b/hw/adc/aspeed_adc.c
>>>> @@ -0,0 +1,246 @@
>>>> +/*
>>>> + * Aspeed ADC
>>>> + *
>>>>>> + * Andrew Jeffery <andrew@aj.id.au>
>>>>
>>>> + *
>>>> + * Copyright 2017 IBM Corp.
>>>> + *
>>>> + * This code is licensed under the GPL version 2 or later.  See
>>>> + * the COPYING file in the top-level directory.
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "hw/adc/aspeed_adc.h"
>>>> +#include "qapi/error.h"
>>>> +#include "qemu/log.h"
>>>> +
>>>> +#define ASPEED_ADC_ENGINE_CTRL                  0x00 #define
>>>> +ASPEED_ADC_ENGINE_CH_EN_MASK           0xffff0000 #define
>>>> +ASPEED_ADC_ENGINE_CH_EN(x)            ((BIT(x)) << 16) #define
>>>> +ASPEED_ADC_ENGINE_INIT                 BIT(8) #define
>>>> +ASPEED_ADC_ENGINE_AUTO_COMP            BIT(5) #define
>>>> +ASPEED_ADC_ENGINE_COMP                 BIT(4) #define
>>>> +ASPEED_ADC_ENGINE_MODE_MASK            0x0000000e #define
>>>> +ASPEED_ADC_ENGINE_MODE_OFF            (0b000 << 1) #define
>>>> +ASPEED_ADC_ENGINE_MODE_STANDBY        (0b001 << 1) #define
>>>> +ASPEED_ADC_ENGINE_MODE_NORMAL         (0b111 << 1) #define
>>>> +ASPEED_ADC_ENGINE_EN                   BIT(0)
>>>> +
>>>> +#define ASPEED_ADC_L_MASK       ((1 << 10) - 1) #define
>>>> +ASPEED_ADC_L(x)         ((x) & ASPEED_ADC_L_MASK) #define
>>>> +ASPEED_ADC_H(x)         (((x) >> 16) & ASPEED_ADC_L_MASK) #define
>>>> +ASPEED_ADC_LH_MASK      (ASPEED_ADC_L_MASK << 16 |
>>>> +ASPEED_ADC_L_MASK)
>>>> +
>>>> +static inline uint32_t update_channels(uint32_t current) {
>>>> +    const uint32_t next = (current + 7) & 0x3ff;
>>>> +
>>>> +    return (next << 16) | next;
>>>> +}
>>>> +
>>>> +static bool breaks_threshold(AspeedADCState *s, int ch_off) {
>>>> +    const uint32_t a = ASPEED_ADC_L(s->channels[ch_off]);
>>>> +    const uint32_t a_lower = ASPEED_ADC_L(s->bounds[2 * ch_off]);
>>>> +    const uint32_t a_upper = ASPEED_ADC_H(s->bounds[2 * ch_off]);
>>>> +    const uint32_t b = ASPEED_ADC_H(s->channels[ch_off]);
>>>> +    const uint32_t b_lower = ASPEED_ADC_L(s->bounds[2 * ch_off +
>>>> +1]);
>>>> +    const uint32_t b_upper = ASPEED_ADC_H(s->bounds[2 * ch_off +
>>>> +1]);
>>>> +
>>>> +    return ((a < a_lower || a > a_upper)) ||
>>>> +           ((b < b_lower || b > b_upper)); }
>>>> +
>>>> +static uint32_t read_channel_sample(AspeedADCState *s, int ch_off)
>>>> +{
>>>> +    uint32_t ret;
>>>> +
>>>> +    /* Poor man's sampling */
>>>> +    ret = s->channels[ch_off];
>>>> +    s->channels[ch_off] = update_channels(s->channels[ch_off]);
>>>> +
>>>> +    if (breaks_threshold(s, ch_off)) {
>>>> +        qemu_irq_raise(s->irq);
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +#define TO_INDEX(addr, base) (((addr) - (base)) >> 2)
>>>> +
>>>> +static uint64_t aspeed_adc_read(void *opaque, hwaddr addr,
>>>> +                                     unsigned int size) {
>>>> +    AspeedADCState *s = ASPEED_ADC(opaque);
>>>> +    uint64_t ret;
>>>> +
>>>> +    switch (addr) {
>>>> +    case 0x00:
>>>> +        ret = s->engine_ctrl;
>>>> +        break;
>>>> +    case 0x04:
>>>> +        ret = s->irq_ctrl;
>>>> +        break;
>>>> +    case 0x08:
>>>> +        ret = s->vga_detect_ctrl;
>>>> +        break;
>>>> +    case 0x0c:
>>>> +        ret = s->adc_clk_ctrl;
>>>> +        break;
>>>> +    case 0x10 ... 0x2e:
>>>> +        ret = read_channel_sample(s, TO_INDEX(addr, 0x10));
>>>> +        break;
>>>> +    case 0x30 ... 0x6e:
>>>> +        ret = s->bounds[TO_INDEX(addr, 0x30)];
>>>> +        break;
>>>> +    case 0x70 ... 0xae:
>>>> +        ret = s->hysteresis[TO_INDEX(addr, 0x70)];
>>>> +        break;
>>>> +    case 0xc0:
>>>> +        ret = s->irq_src;
>>>> +        break;
>>>> +    case 0xc4:
>>>> +        ret = s->comp_trim;
>>>> +        break;
>>>> +    default:
>>>> +        qemu_log_mask(LOG_UNIMP, "%s: addr: 0x%lx, size: %u\n",
>>>> +__func__, addr,
>>>> +                size);
>>>> +        ret = 0;
>>>> +        break;
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static void aspeed_adc_write(void *opaque, hwaddr addr,
>>>> +                       uint64_t val, unsigned int size) {
>>>> +    AspeedADCState *s = ASPEED_ADC(opaque);
>>>> +
>>>> +    switch (addr) {
>>>> +    case 0x00:
>>>> +        {
>>>> +            uint32_t init;
>>>> +
>>>> +            init = !!(val & ASPEED_ADC_ENGINE_EN);
>>>> +            init *= ASPEED_ADC_ENGINE_INIT;
>>>> +
>>>> +            val &= ~ASPEED_ADC_ENGINE_INIT;
>>>> +            val |= init;
>>>> +        }
>>>> +
>>>> +        val &= ~ASPEED_ADC_ENGINE_AUTO_COMP;
>>>> +        s->engine_ctrl = val;
>>>> +
>>>> +        break;
>>>> +    case 0x04:
>>>> +        s->irq_ctrl = val;
>>>> +        break;
>>>> +    case 0x08:
>>>> +        s->vga_detect_ctrl = val;
>>>> +        break;
>>>> +    case 0x0c:
>>>> +        s->adc_clk_ctrl = val;
>>>> +        break;
>>>> +    case 0x10 ... 0x2e:
>>>> +        s->channels[TO_INDEX(addr, 0x10)] = val;
>>>> +        break;
>>>> +    case 0x30 ... 0x6e:
>>>> +        s->bounds[TO_INDEX(addr, 0x30)] = (val &
>>>> +ASPEED_ADC_LH_MASK);
>>>> +        break;
>>>> +    case 0x70 ... 0xae:
>>>> +        s->hysteresis[TO_INDEX(addr, 0x70)] =
>>>> +            (val & (BIT(31) | ASPEED_ADC_LH_MASK));
>>>
>>> Can you add a #define for this BIT(31)?
>>
>> Sorry, that was an oversight!
>>
>>>
>>>> +        break;
>>>> +    case 0xc0:
>>>> +        s->irq_src = (val & 0xffff);
>>>> +        break;
>>>> +    case 0xc4:
>>>> +        s->comp_trim = (val & 0xf);
>>>> +        break;
>>>> +    default:
>>>> +        qemu_log_mask(LOG_UNIMP, "%s: %lu\n", __func__, addr);
>>>> +        break;
>>>> +    }
>>>> +}
>>>> +
>>>> +static const MemoryRegionOps aspeed_adc_ops = {
>>>> +    .read = aspeed_adc_read,
>>>> +    .write = aspeed_adc_write,
>>>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>>>> +    .valid.min_access_size = 4,
>>>
>>> You sure about that? How the registers are aligned it seems this
>>> device can also be accessed 2-byte wide.
>>
>> I'll address this below.
>>
>>>
>>>> +    .valid.max_access_size = 4,
>>>> +    .valid.unaligned = false,
>>>> +};
>>>> +
>>>> +static void aspeed_adc_reset(DeviceState *dev) {
>>>> +    struct AspeedADCState *s = ASPEED_ADC(dev);
>>>> +
>>>> +    s->engine_ctrl = 0;
>>>> +    s->irq_ctrl = 0;
>>>> +    s->vga_detect_ctrl = 0x0000000f;
>>>> +    s->adc_clk_ctrl = 0x0000000f;
>>>> +    memset(s->channels, 0, sizeof(s->channels));
>>>> +    memset(s->bounds, 0, sizeof(s->bounds));
>>>> +    memset(s->hysteresis, 0, sizeof(s->hysteresis));
>>>> +    s->irq_src = 0;
>>>> +    s->comp_trim = 0;
>>>> +}
>>>> +
>>>> +static void aspeed_adc_realize(DeviceState *dev, Error **errp) {
>>>> +    AspeedADCState *s = ASPEED_ADC(dev);
>>>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>>>> +
>>>> +    sysbus_init_irq(sbd, &s->irq);
>>>> +
>>>> +    memory_region_init_io(&s->mmio, OBJECT(s), &aspeed_adc_ops, s,
>>>> +            TYPE_ASPEED_ADC, 0x1000);
>>>> +
>>>> +    sysbus_init_mmio(sbd, &s->mmio); }
>>>> +
>>>> +static const VMStateDescription vmstate_aspeed_adc = {
>>>> +    .name = TYPE_ASPEED_ADC,
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .fields = (VMStateField[]) {
>>>> +        VMSTATE_UINT32(engine_ctrl, AspeedADCState),
>>>> +        VMSTATE_UINT32(irq_ctrl, AspeedADCState),
>>>> +        VMSTATE_UINT32(vga_detect_ctrl, AspeedADCState),
>>>> +        VMSTATE_UINT32(adc_clk_ctrl, AspeedADCState),
>>>> +        VMSTATE_UINT32_ARRAY(channels, AspeedADCState,
>>>> +                ASPEED_ADC_NR_CHANNELS / 2),
>>>> +        VMSTATE_UINT32_ARRAY(bounds, AspeedADCState,
>>>> +ASPEED_ADC_NR_CHANNELS),
>>>> +        VMSTATE_UINT32_ARRAY(hysteresis, AspeedADCState,
>>>> +                ASPEED_ADC_NR_CHANNELS),
>>>> +        VMSTATE_UINT32(irq_src, AspeedADCState),
>>>> +        VMSTATE_UINT32(comp_trim, AspeedADCState),
>>>> +        VMSTATE_END_OF_LIST(),
>>>> +    }
>>>> +};
>>>> +
>>>> +static void aspeed_adc_class_init(ObjectClass *klass, void *data) {
>>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>>> +
>>>> +    dc->realize = aspeed_adc_realize;
>>>> +    dc->reset = aspeed_adc_reset;
>>>> +    dc->desc = "Aspeed Analog-to-Digital Converter",
>>>> +    dc->vmsd = &vmstate_aspeed_adc; }
>>>> +
>>>> +static const TypeInfo aspeed_adc_info = {
>>>> +    .name = TYPE_ASPEED_ADC,
>>>> +    .parent = TYPE_SYS_BUS_DEVICE,
>>>> +    .instance_size = sizeof(AspeedADCState),
>>>> +    .class_init = aspeed_adc_class_init, };
>>>> +
>>>> +static void aspeed_adc_register_types(void) {
>>>> +    type_register_static(&aspeed_adc_info);
>>>> +}
>>>> +
>>>> +type_init(aspeed_adc_register_types);
>>>> diff --git a/include/hw/adc/aspeed_adc.h
>>>> b/include/hw/adc/aspeed_adc.h new file mode 100644 index
>>>> 000000000000..ae2089ac62ca
>>>> --- /dev/null
>>>> +++ b/include/hw/adc/aspeed_adc.h
>>>> @@ -0,0 +1,33 @@
>>>> +#ifndef _ASPEED_ADC_H_
>>>> +#define _ASPEED_ADC_H_
>>>> +
>>>
>>> You missed the license.
>>
>> Whoops.
>>
>>>
>>> Can you also add a comment about which ADC are modeled (2400/2500 no
>>> difference) as you explain in your cover letter?
>>
>> Yes, will add this.
>>
>>>
>>>> +#include <stdint.h>
>>>> +
>>>> +#include "hw/hw.h"
>>>> +#include "hw/irq.h"
>>>> +#include "hw/sysbus.h"
>>>> +
>>>> +#define TYPE_ASPEED_ADC "aspeed.adc"
>>>> +#define ASPEED_ADC(obj) OBJECT_CHECK(AspeedADCState, (obj),
>>>> +TYPE_ASPEED_ADC)
>>>> +
>>>> +#define ASPEED_ADC_NR_CHANNELS 16
>>>> +
>>>> +typedef struct AspeedADCState {
>>>> +    /* <private> */
>>>> +    SysBusDevice parent;
>>>> +
>>>> +    MemoryRegion mmio;
>>>> +    qemu_irq irq;
>>>> +
>>>> +    uint32_t engine_ctrl;
>>>> +    uint32_t irq_ctrl;
>>>> +    uint32_t vga_detect_ctrl;
>>>> +    uint32_t adc_clk_ctrl;
>>>> +    uint32_t channels[ASPEED_ADC_NR_CHANNELS / 2];
>>>
>>> I can't find the datasheet
>>
>> Unfortunately the datasheet isn't publicly available. However, Ryan
>> (Cc'ed) can help answer specific hardware questions.
>>
>>> , but it seems this ADC has a 10-bit
>>> resolution, so a channel sample can fit into a uint16_t.
>>
>> Indeed. I think I'll add a bit of a blurb about the device to cover this off.
>>
>>> It sounds weird to read ASPEED_ADC_NR_CHANNELS=16 then use
>>> ASPEED_ADC_NR_CHANNELS/2 channels.
>>> I think using an uint16_t array you can get rid of the ASPEED_ADC_L/H
>>> macros.
>>
>> This is something I tried to clarify with Ryan on Friday. I am under the impression the hardware only supports 32-bit accesses. In the datasheet the registers are defined in 32-bit quantities, which drove this approach. The driver from the SDK's kernel also uses 32-bit accesses and shifts.
>>
>> Ryan: So to clarify here, can we do 16-bit (aligned) MMIO accesses on the hardware? Or are we restricted to 32-bit MMIO access as I've specified above?
>>
>> Cheers,
>>
>> Andrew
>>
>>>
>>>> +    uint32_t bounds[ASPEED_ADC_NR_CHANNELS];
>>>> +    uint32_t hysteresis[ASPEED_ADC_NR_CHANNELS];
>>>> +    uint32_t irq_src;
>>>> +    uint32_t comp_trim;
>>>> +} AspeedADCState;
>>>> +
>>>> +#endif /* _ASPEED_ADC_H_ */
>>>>
>>>
>>> Regards,
>>>
>>> Phil.
