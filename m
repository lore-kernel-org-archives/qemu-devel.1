Received: from eggs.gnu.org ([2001:4830:134:3::10]:60503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1enzj2-0000Ga-0h
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 23:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1enziy-0003kY-O5
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 23:40:19 -0500
References: <20180219181922.21586-1-mark.cave-ayland@ilande.co.uk>
	<20180219181922.21586-5-mark.cave-ayland@ilande.co.uk>
	<20180220042057.GL1109@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <78f5a679-b3eb-2188-d0d1-957a23cf44b0@ilande.co.uk>
Date: Tue, 20 Feb 2018 04:40:07 +0000
MIME-Version: 1.0
In-Reply-To: <20180220042057.GL1109@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/11] heathrow: convert to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 20/02/18 04:20, David Gibson wrote:

> On Mon, Feb 19, 2018 at 06:19:15PM +0000, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/intc/heathrow_pic.c         | 31 ++++++++++++-------------------
>>   hw/intc/trace-events           |  5 +++++
>>   include/hw/intc/heathrow_pic.h |  1 +
>>   3 files changed, 18 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
>> index 7bf44e0d86..afe0b08cbb 100644
>> --- a/hw/intc/heathrow_pic.c
>> +++ b/hw/intc/heathrow_pic.c
>> @@ -26,16 +26,7 @@
>>   #include "hw/hw.h"
>>   #include "hw/ppc/mac.h"
>>   #include "hw/intc/heathrow_pic.h"
>> -
>> -/* debug PIC */
>> -//#define DEBUG_PIC
>> -
>> -#ifdef DEBUG_PIC
>> -#define PIC_DPRINTF(fmt, ...)                                   \
>> -    do { printf("PIC: " fmt , ## __VA_ARGS__); } while (0)
>> -#else
>> -#define PIC_DPRINTF(fmt, ...)
>> -#endif
>> +#include "trace.h"
>>   
>>   static inline int heathrow_check_irq(HeathrowPICState *pic)
>>   {
>> @@ -61,7 +52,7 @@ static void heathrow_write(void *opaque, hwaddr addr,
>>       unsigned int n;
>>   
>>       n = ((addr & 0xfff) - 0x10) >> 4;
>> -    PIC_DPRINTF("writel: " TARGET_FMT_plx " %u: %08x\n", addr, n, value);
>> +    trace_heathrow_write(addr, n, value);
>>       if (n >= 2)
>>           return;
>>       pic = &s->pics[n];
>> @@ -109,7 +100,7 @@ static uint64_t heathrow_read(void *opaque, hwaddr addr,
>>               break;
>>           }
>>       }
>> -    PIC_DPRINTF("readl: " TARGET_FMT_plx " %u: %08x\n", addr, n, value);
>> +    trace_heathrow_read(addr, n, value);
>>       return value;
>>   }
>>   
>> @@ -124,16 +115,18 @@ static void heathrow_set_irq(void *opaque, int num, int level)
>>       HeathrowState *s = opaque;
>>       HeathrowPICState *pic;
>>       unsigned int irq_bit;
>> +    int last_level = (s->last_levels & (num << 1UL)) ? 1 : 0;
>>   
>> -#if defined(DEBUG)
>> -    {
>> -        static int last_level[64];
>> -        if (last_level[num] != level) {
>> -            PIC_DPRINTF("set_irq: num=0x%02x level=%d\n", num, level);
>> -            last_level[num] = level;
>> +    if (last_level != level) {
>> +        trace_heathrow_set_irq(num, level);
>> +
>> +        if (level) {
>> +            s->last_levels |= (num << 1UL);
>> +        } else {
>> +            s->last_levels &= ~(num << 1UL);
> 
> Cleaning up this last_level stuff is a good idea, but is a bit more
> involved than merely converting to trace-events.
> 
> It's also not really the "last" level - it's effectively maintaining
> the current level of the input irqs.  .. and isn't that information
> already within the HeathrowPICState structure?

Yeah actually you're right here - I was so focused on converting the 
code as-is that I didn't really look at what was happening at the end of 
heathrow_set_irq(). The motivation was that without this hack the trace 
output is always outputting the IRQ status, presumably because we have a 
level-triggered interrupt being asserted.

Let me rework this patch to use the last state information from 
HeathrowPICState instead.


ATB,

Mark.
