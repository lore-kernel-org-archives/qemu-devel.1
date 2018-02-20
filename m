Received: from eggs.gnu.org ([2001:4830:134:3::10]:57566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1enzNk-0003xL-Ew
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 23:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1enzNj-0002dB-7S
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 23:18:20 -0500
References: <20180219181922.21586-1-mark.cave-ayland@ilande.co.uk>
	<20180219181922.21586-4-mark.cave-ayland@ilande.co.uk>
	<20180220032819.GI1109@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ecb06770-1401-4d97-5bf8-9249b1d904d8@ilande.co.uk>
Date: Tue, 20 Feb 2018 04:18:01 +0000
MIME-Version: 1.0
In-Reply-To: <20180220032819.GI1109@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/11] heathrow: QOMify heathrow PIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 20/02/18 03:28, David Gibson wrote:

> On Mon, Feb 19, 2018 at 06:19:14PM +0000, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/intc/heathrow_pic.c         | 126 +++++++++++++++++++++++------------------
>>   include/hw/intc/heathrow_pic.h |  49 ++++++++++++++++
>>   2 files changed, 119 insertions(+), 56 deletions(-)
>>   create mode 100644 include/hw/intc/heathrow_pic.h
>>
>> diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
>> index 171f5ed814..7bf44e0d86 100644
>> --- a/hw/intc/heathrow_pic.c
>> +++ b/hw/intc/heathrow_pic.c
>> @@ -25,6 +25,7 @@
>>   #include "qemu/osdep.h"
>>   #include "hw/hw.h"
>>   #include "hw/ppc/mac.h"
>> +#include "hw/intc/heathrow_pic.h"
>>   
>>   /* debug PIC */
>>   //#define DEBUG_PIC
>> @@ -36,39 +37,27 @@
>>   #define PIC_DPRINTF(fmt, ...)
>>   #endif
>>   
>> -typedef struct HeathrowPIC {
>> -    uint32_t events;
>> -    uint32_t mask;
>> -    uint32_t levels;
>> -    uint32_t level_triggered;
>> -} HeathrowPIC;
>> -
>> -typedef struct HeathrowPICS {
>> -    MemoryRegion mem;
>> -    HeathrowPIC pics[2];
>> -    qemu_irq *irqs;
>> -} HeathrowPICS;
>> -
>> -static inline int check_irq(HeathrowPIC *pic)
>> +static inline int heathrow_check_irq(HeathrowPICState *pic)
>>   {
>>       return (pic->events | (pic->levels & pic->level_triggered)) & pic->mask;
>>   }
>>   
>>   /* update the CPU irq state */
>> -static void heathrow_pic_update(HeathrowPICS *s)
>> +static void heathrow_update_irq(HeathrowState *s)
>>   {
>> -    if (check_irq(&s->pics[0]) || check_irq(&s->pics[1])) {
>> +    if (heathrow_check_irq(&s->pics[0]) ||
>> +            heathrow_check_irq(&s->pics[1])) {
>>           qemu_irq_raise(s->irqs[0]);
>>       } else {
>>           qemu_irq_lower(s->irqs[0]);
>>       }
>>   }
>>   
>> -static void pic_write(void *opaque, hwaddr addr,
>> -                      uint64_t value, unsigned size)
>> +static void heathrow_write(void *opaque, hwaddr addr,
>> +                           uint64_t value, unsigned size)
>>   {
>> -    HeathrowPICS *s = opaque;
>> -    HeathrowPIC *pic;
>> +    HeathrowState *s = opaque;
>> +    HeathrowPICState *pic;
>>       unsigned int n;
>>   
>>       n = ((addr & 0xfff) - 0x10) >> 4;
>> @@ -79,24 +68,24 @@ static void pic_write(void *opaque, hwaddr addr,
>>       switch(addr & 0xf) {
>>       case 0x04:
>>           pic->mask = value;
>> -        heathrow_pic_update(s);
>> +        heathrow_update_irq(s);
>>           break;
>>       case 0x08:
>>           /* do not reset level triggered IRQs */
>>           value &= ~pic->level_triggered;
>>           pic->events &= ~value;
>> -        heathrow_pic_update(s);
>> +        heathrow_update_irq(s);
>>           break;
>>       default:
>>           break;
>>       }
>>   }
>>   
>> -static uint64_t pic_read(void *opaque, hwaddr addr,
>> -                         unsigned size)
>> +static uint64_t heathrow_read(void *opaque, hwaddr addr,
>> +                              unsigned size)
>>   {
>> -    HeathrowPICS *s = opaque;
>> -    HeathrowPIC *pic;
>> +    HeathrowState *s = opaque;
>> +    HeathrowPICState *pic;
>>       unsigned int n;
>>       uint32_t value;
>>   
>> @@ -124,16 +113,16 @@ static uint64_t pic_read(void *opaque, hwaddr addr,
>>       return value;
>>   }
>>   
>> -static const MemoryRegionOps heathrow_pic_ops = {
>> -    .read = pic_read,
>> -    .write = pic_write,
>> +static const MemoryRegionOps heathrow_ops = {
>> +    .read = heathrow_read,
>> +    .write = heathrow_write,
>>       .endianness = DEVICE_LITTLE_ENDIAN,
>>   };
>>   
>> -static void heathrow_pic_set_irq(void *opaque, int num, int level)
>> +static void heathrow_set_irq(void *opaque, int num, int level)
>>   {
>> -    HeathrowPICS *s = opaque;
>> -    HeathrowPIC *pic;
>> +    HeathrowState *s = opaque;
>> +    HeathrowPICState *pic;
>>       unsigned int irq_bit;
>>   
>>   #if defined(DEBUG)
>> @@ -153,7 +142,7 @@ static void heathrow_pic_set_irq(void *opaque, int num, int level)
>>       } else {
>>           pic->levels &= ~irq_bit;
>>       }
>> -    heathrow_pic_update(s);
>> +    heathrow_update_irq(s);
>>   }
>>   
>>   static const VMStateDescription vmstate_heathrow_pic_one = {
>> @@ -161,54 +150,79 @@ static const VMStateDescription vmstate_heathrow_pic_one = {
>>       .version_id = 0,
>>       .minimum_version_id = 0,
>>       .fields = (VMStateField[]) {
>> -        VMSTATE_UINT32(events, HeathrowPIC),
>> -        VMSTATE_UINT32(mask, HeathrowPIC),
>> -        VMSTATE_UINT32(levels, HeathrowPIC),
>> -        VMSTATE_UINT32(level_triggered, HeathrowPIC),
>> +        VMSTATE_UINT32(events, HeathrowPICState),
>> +        VMSTATE_UINT32(mask, HeathrowPICState),
>> +        VMSTATE_UINT32(levels, HeathrowPICState),
>> +        VMSTATE_UINT32(level_triggered, HeathrowPICState),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
>>   
>> -static const VMStateDescription vmstate_heathrow_pic = {
>> +static const VMStateDescription vmstate_heathrow = {
>>       .name = "heathrow_pic",
>>       .version_id = 1,
>>       .minimum_version_id = 1,
>>       .fields = (VMStateField[]) {
>> -        VMSTATE_STRUCT_ARRAY(pics, HeathrowPICS, 2, 1,
>> -                             vmstate_heathrow_pic_one, HeathrowPIC),
>> +        VMSTATE_STRUCT_ARRAY(pics, HeathrowState, 2, 1,
>> +                             vmstate_heathrow_pic_one, HeathrowPICState),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
>>   
>> -static void heathrow_pic_reset_one(HeathrowPIC *s)
>> +static void heathrow_reset(DeviceState *d)
>>   {
>> -    memset(s, '\0', sizeof(HeathrowPIC));
>> +    HeathrowState *s = HEATHROW(d);
>> +
>> +    s->pics[0].level_triggered = 0;
>> +    s->pics[1].level_triggered = 0x1ff00000;
>>   }
>>   
>> -static void heathrow_pic_reset(void *opaque)
>> +static void heathrow_init(Object *obj)
>>   {
>> -    HeathrowPICS *s = opaque;
>> -
>> -    heathrow_pic_reset_one(&s->pics[0]);
>> -    heathrow_pic_reset_one(&s->pics[1]);
>> +    HeathrowState *s = HEATHROW(obj);
>>   
>> -    s->pics[0].level_triggered = 0;
>> -    s->pics[1].level_triggered = 0x1ff00000;
>> +    memory_region_init_io(&s->mem, OBJECT(s), &heathrow_ops, s,
>> +                          "heathrow-pic", 0x1000);
> 
> IIRC, you generally don't want to create memory regions at instance
> init time, but only at realize time.

I'm not sure that this is still the case? The last time it was explained 
to me, my understanding was that initialisation should generally be done 
at init() at time, except when it depends upon a qdev property at which 
point it should be deferred until realize().

When I ask these questions I tend to get pointed towards the ARM 
boards/devices for examples of the current best practices for devices, 
and there are definitely multiple examples of this in hw/arm.


ATB,

Mark.
