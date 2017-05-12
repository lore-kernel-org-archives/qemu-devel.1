Received: from eggs.gnu.org ([2001:4830:134:3::10]:56059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d92LY-0007hk-Uc
	for qemu-devel@nongnu.org; Fri, 12 May 2017 00:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d92LX-0003AZ-TI
	for qemu-devel@nongnu.org; Fri, 12 May 2017 00:38:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1494348286-10253-1-git-send-email-sundeep.lkml@gmail.com>
	<1494348286-10253-2-git-send-email-sundeep.lkml@gmail.com>
	<e87597ba-4759-76a5-7b0d-3297d2eb8f79@amsat.org>
	<CALHRZuqfqjEWszkvVQSWAKR5zVbhD36=+Qt_DsVykk41cihO1Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1dc2ee8a-be60-c276-5529-a666223bfc2b@amsat.org>
Date: Fri, 12 May 2017 01:38:22 -0300
MIME-Version: 1.0
In-Reply-To: <CALHRZuqfqjEWszkvVQSWAKR5zVbhD36=+Qt_DsVykk41cihO1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [Qemu-devel PATCH 1/5] msf2: Add
 Smartfusion2 System timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sundeep subbaraya <sundeep.lkml@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair23@gmail.com>

On 05/10/2017 09:37 AM, sundeep subbaraya wrote:
> Hi Phil,
>
> On Wed, May 10, 2017 at 3:11 PM, Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> wrote:
>> Hi Subbaraya, nice work!
>>
>> The timer you are modeling is the mss_timer, which is in particular
> used in
>> the smartfusion2, I'd rather name it mss_timer.c so it can be reused by
>> other SoC models.
>>
> Ok I will change all other file names also to mss. Do I need to change
> type names
> also to mss?

As you wish :) Actel/Microsemi keep changing how they name it, MSS, 
M2S... What I mean is this timer is valid for a Actel SmartFusion and 
for the MicroSemi SmartFusion2, naming it "msf2-timer" seems to restrict 
it to the SF2 only.

>> I added few comments.
>>
>>
>> On 05/09/2017 01:44 PM, Subbaraya Sundeep wrote:
>>>
>>> Modelled System Timer in Microsemi's Smartfusion2 Soc.
>>> Timer has two 32bit down counters and two interrupts.
>>>
>>> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com
> <mailto:sundeep.lkml@gmail.com>>
>>> ---
>>>  hw/timer/Makefile.objs        |   1 +
>>>  hw/timer/msf2-timer.c         | 252
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>  include/hw/timer/msf2-timer.h |  85 ++++++++++++++
>>>  3 files changed, 338 insertions(+)
>>>  create mode 100644 hw/timer/msf2-timer.c
>>>  create mode 100644 include/hw/timer/msf2-timer.h
>>>
[...]
>>> +        if (addr < ARRAY_SIZE(st->regs)) {
>>> +            st->regs[addr] = value;
>>> +        } else {
>>> +            qemu_log_mask(LOG_GUEST_ERROR,
>>> +                         "%s: Bad offset 0x%" HWADDR_PRIx "\n",
> __func__,
>>> +                         addr * 4);
>>> +        }
>>> +        break;
>>> +    }
>>> +    timer_update_irq(st);
>>
>>
>> Here if addr >= (NUM_TIMERS * R_TIM1_MAX) you still update Timer1 IRQ,
> while
>> this is unharmful right now this is likely to be break later.
>>
> As long as Interrupt status register and Interrupt enable register are not
> modified calling timer_update_irq will not harm. Am I missing something
> here?

Indeed, this is unharmful. It just surprised me when I follow the 
control flow.

>>> +}
>>> +
>>> +static const MemoryRegionOps timer_ops = {
>>> +    .read = timer_read,
>>> +    .write = timer_write,
>>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>>> +    .valid = {
>>> +        .min_access_size = 4,
>>
>>
>> I believe min_access_size = 1 is valid for any APB device.
>>
>>
> Ok. I followed Xilinx soft IP models while writing this. I am really not
> sure it is mandatory to put access_size. Can i remove it?

checking the datasheet "UG0331: SmartFusion2 Microcontroller Subsystem":

'''
CMSIS Data types:

The [Cortex-M3] processor:
* supports the following data types:
- 32-bit words
- 16-bit halfwords
- 8-bit bytes.
* manages all data memory accesses as little-endian or big-endian. 
Instruction memory and Private Peripheral Bus (PPB) accesses are always 
performed as little-endian. The Cortex-M3 processor configured for 
SmartFusion2 SoC FPGA MSS uses only little-endian.
'''

So Yes, ".min_access_size = 1" is correct for this Cortex-M3.

If you remove it memory_region_access_valid() will do:

     access_size_min = mr->ops->valid.min_access_size;
     if (!mr->ops->valid.min_access_size) {
         access_size_min = 1;
     }

So that is the same, personally I prefer it to be explicit (not removed).

>>> +        .max_access_size = 4
>>> +    }
>>> +};
>>> +
>>> +static void timer_hit(void *opaque)
>>> +{
>>> +    struct Msf2Timer *st = opaque;
>>> +
>>> +    st->regs[R_TIM_RIS] |= TIMER_RIS_ACK;
>>> +
>>> +    if (!(st->regs[R_TIM_CTRL] & TIMER_CTRL_ONESHOT)) {
>>> +        timer_update(st);
>>> +    }
>>> +    timer_update_irq(st);
>>> +}
[...]
>>> +/*
>>> + * There are two 32-bit down counting timers.
>>> + * Timers 1 and 2 can be concatenated into a single 64-bit Timer
>>> + * that operates either in Periodic mode or in One-shot mode.
>>> + * Writing 1 to the TIM64_MODE register bit 0 sets the Timers in 64-bit
>>> mode.
>>> + * In 64-bit mode, writing to the 32-bit registers has no effect.
>>> + * Similarly, in 32-bit mode, writing to the 64-bit mode registers
>>> + * has no effect. Only two 32-bit timers are supported currently.
>>> + */
>>> +#define NUM_TIMERS        2
>>> +
>>> +#define MSF2_TIMER_FREQ   (83 * 1000000)
>>
>>
>> I can not find this value, can you point me to the datasheet? It seems SoC
>> specific to me.
>>
> It is configured in Microsemi Libero. The SOM kit from Emcraft comes
> with this default setting.
> I guess this property should be set and passed from board file and not
> from SoC.
> Am I correct?

It seems an option configurable in Libero before synthesizing, so that 
would be SoM/bitfile specific?

What I mean here is I don't think this is a fixed value for a mss_timer 
and I'd rather have it configurable (but ok to default 83MHz in your SoM).

 > Can I attach the datasheet to this thread?

Isn't this datasheet publicly available?

Eventually can you upload a binary (like your Linux patches) somewhere? 
So it would be easier to test this patchset.

> Thank you,
> Sundeep

Good luck!

Phil.
