Received: from eggs.gnu.org ([2001:4830:134:3::10]:44260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chMKX-0004BJ-Ld
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chMKT-0000qA-JO
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:19:05 -0500
Date: Fri, 24 Feb 2017 21:18:52 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA9oWpaG98KT+zSBE11-vzs-Cs6bgBT_VGQVvm4RVUO7pA@mail.gmail.com>
Message-ID: <alpine.BSF.2.20.1702242114480.76443@zero.eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
	<84d7cdceac575c23bd4ee4bdcb80a03966b96db8.1487522123.git.balaton@eik.bme.hu>
	<CAFEAcA9oWpaG98KT+zSBE11-vzs-Cs6bgBT_VGQVvm4RVUO7pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 02/10] sm501: Use defines instead of
 constants where available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, 24 Feb 2017, Peter Maydell wrote:
> On 19 February 2017 at 16:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/display/sm501.c          | 8 ++++----
>>  hw/display/sm501_template.h | 2 +-
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>> index 4f40dee..4eb085c 100644
>> --- a/hw/display/sm501.c
>> +++ b/hw/display/sm501.c
>> @@ -555,7 +555,7 @@ static uint32_t get_local_mem_size_index(uint32_t size)
>>  static inline int is_hwc_enabled(SM501State *state, int crt)
>>  {
>>      uint32_t addr = crt ? state->dc_crt_hwc_addr : state->dc_panel_hwc_addr;
>> -    return addr & 0x80000000;
>> +    return addr & SM501_HWC_EN;
>>  }
>>
>>  /**
>> @@ -1411,9 +1411,9 @@ void sm501_init(MemoryRegion *address_space_mem, uint32_t base,
>>      s->local_mem_size_index = get_local_mem_size_index(local_mem_bytes);
>>      SM501_DPRINTF("local mem size=%x. index=%d\n", get_local_mem_size(s),
>>                    s->local_mem_size_index);
>> -    s->system_control = 0x00100000;
>> -    s->misc_control = 0x00001000; /* assumes SH, active=low */
>> -    s->dc_panel_control = 0x00010000;
>> +    s->system_control = 0x00100000; /* 2D engine FIFO empty */
>> +    s->misc_control = SM501_MISC_IRQ_INVERT; /* assumes SH, active=low */
>> +    s->dc_panel_control = 0x00010000; /* FIFO level 3 */
>
> s->misc_control was set to 0x1000, but is now set to
> SM501_MISC_IRQ_INVERT, which is (1 << 16), which is not the
> same value... 0x1000 would be SM501_MISC_DAC_POWER.

Thanks for reviewing these patches.

The comment suggests that the intended bit was the IRQ invert bit so the 
constant used before may have been a bug. (In my understanding nothing 
really uses this bit so I could set it either way you prefer but I think 
this is the correct one.) What should I do?
1. Leave it as it is
2. Set it to the old constant contradicting the comment
3. Make it a separate patch?
