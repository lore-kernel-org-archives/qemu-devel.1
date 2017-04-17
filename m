Received: from eggs.gnu.org ([2001:4830:134:3::10]:59248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1czxxk-0007SB-En
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 00:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1czxxg-00074D-8k
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 00:08:28 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
	<1487604965-23220-10-git-send-email-peter.maydell@linaro.org>
	<b13702b2-44be-563b-5743-33c773a6e037@amsat.org>
	<CAFEAcA_KnJPrKU2gWCkPJELkU3QtbTOu+_fMrHWwkPcwS+NE2w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <93f5df04-c4a3-7c21-0035-a9a9a711a792@amsat.org>
Date: Mon, 17 Apr 2017 01:08:19 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_KnJPrKU2gWCkPJELkU3QtbTOu+_fMrHWwkPcwS+NE2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 09/11] armv7m: Split systick out
 from NVIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Michael Davidsaver <mdavidsaver@gmail.com>, "patches@linaro.org" <patches@linaro.org>

On 02/20/2017 03:51 PM, Peter Maydell wrote:
> On 20 February 2017 at 17:43, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 02/20/2017 12:36 PM, Peter Maydell wrote:
>>> +/* Conversion factor from qemu timer to SysTick frequencies.  */
>>> +static inline int64_t systick_scale(SysTickState *s)
>>> +{
>>> +    if (s->control & SYSTICK_CLKSOURCE) {
>>> +        return system_clock_scale;
>>> +    } else {
>>> +        return 1000;
>>
>>
>> this magic seems to be SYSTICK_SCALE
>> (Paul Brook's commit 9ee6e8bb85)
>
> This patch is just copying this function from one file to the other...
> at some point we might want to try to improve the handling of
> the clock scale factors but that leads into complication, because
> the external-clocksource scale factor should really be board
> level configurable. (Slightly confusingly the leg of this if/else
> which is board-configurable is the one for the internal clock,
> because we're modelling the ability of the stellaris board to
> configure the PLLs so as to downclock the whole CPU, which
> incidentally affects the timing of the internal systick clock.
> Modelling this properly needs to wait on Fred Konrad's clocktree
> patches getting in, I think.) For the moment I chose to just
> leave the existing source alone, mostly.

Fine!

I didn't know about those clocktree patches, I'll eventually use them 
for MIPS.

>>> +static void systick_instance_init(Object *obj)
>>> +{
>>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>>> +    SysTickState *s = SYSTICK(obj);
>>> +
>>> +    memory_region_init_io(&s->iomem, obj, &systick_ops, s, "systick",
>>> 0xe0);
>>
>>
>> It seems to me the correct size is 0x10. The manual describes the range
>> 0x20-0xFF as _reserved_. This _reserved_ description is at the end of the
>> 'SysTick' chapter which seems weird to me... I rather think this range
>> belong to the 'Interrupt Controller'@'System Control Space'.
>
> The table of the System Control Space (B3-3 in the v7M ARM ARM
> rev E.b) defines the Systick space as 0xE000E010 - 0xE000E0FF,
> which makes it 0xE0 bytes in size. The NVIC doesn't start
> until 0xE000E100 in this table.

I still think it's weird from an electronic design point of view, but 
since I don't have access to ARM internals I'll believe the datasheet 
blindly :S

> The table of the SysTick registers (B3-7) agrees, in that
> it defines the registers as covering 0xE000E010 to 0xE000E0FF.
> In the current architecture everything from 0x20..0xFF is
> reserved, which just means there's nothing there, but if
> there was ever a need for systick to get another register
> for some reason then it would go into that space (and if
> we then implemented the new register in QEMU we wouldn't need
> to change the NVIC code, only the systick code).
>
> I think the way this patch has modelled things matches the
> architecture -- it's a guest error to access the gap between
> 0XE000E020 and 0xE000E0FF, but we should report it as an
> attempt to access an invalid systick register rather than
> an access to an invalid NVIC register.

I agree.

> thanks
> -- PMM
>

Regards,

Phil.
