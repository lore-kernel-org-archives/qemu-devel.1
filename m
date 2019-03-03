Received: from eggs.gnu.org ([209.51.188.92]:59113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0QjA-0004Ph-SS
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 08:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0Qj9-0001M6-IG
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 08:00:24 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:44671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0Qj9-0001KC-8i
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 08:00:23 -0500
Received: by mail-wr1-f45.google.com with SMTP id w2so2515827wrt.11
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 05:00:22 -0800 (PST)
References: <20190303000025.3496D7456A0@zero.eik.bme.hu>
	<0ba3b4c7-c0bc-f8d8-66d5-1f3b15eed6ce@redhat.com>
	<alpine.BSF.2.21.9999.1903031316220.1059@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2586687c-9f69-1c26-6f7f-841c5300ee0e@redhat.com>
Date: Sun, 3 Mar 2019 14:00:20 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1903031316220.1059@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 3/3/19 1:46 PM, BALATON Zoltan wrote:
> On Sun, 3 Mar 2019, Philippe Mathieu-Daudé wrote:
>> Hi Zoltan,
>>
>> On 3/3/19 12:34 AM, BALATON Zoltan wrote:
>>> At least two machines, the PPC mac99 and MIPS fulong2e, have an ATI
>>> gfx chip by default (Rage 128 Pro and M6/RV100 respectively) and
>>> guests running on these and the PMON2000 firmware of the fulong2e
>>> expect this to be available. Fortunately these are very similar chips
>>> so they can be mostly emulated in the same device model. This patch
>>> adds basic emulation of these ATI VGA chips.
>>>
>>> While this is incomplete and currently only enough to run the MIPS
>>> firmware and get framebuffer output with Linux, it allows the fulong2e
>>> board to work more like the real hardware and having it in QEMU in
>>> this state provides a way to experiment with it and allows others to
>>> contribute to improve it. It is compiled for all archs but only the
>>> fulong2e (which currently has no display output at all) is set to use
>>> it by default (in a patch sent separately).
>>
>> Patch looks good, trivial comment inlined.
> 
> Hello,
> Thanks for yhe review. I took what I liked, replies for the rest below.
> 
>>>  default-configs/pci.mak  |   1 +
>>>  hw/display/Makefile.objs |   2 +
>>>  hw/display/ati.c         | 686
>>> +++++++++++++++++++++++++++++++++++++++++++++++
>>>  hw/display/ati_2d.c      | 134 +++++++++
>>>  hw/display/ati_dbg.c     | 254 ++++++++++++++++++
>>>  hw/display/ati_int.h     |  87 ++++++
>>>  hw/display/ati_regs.h    | 456 +++++++++++++++++++++++++++++++
>>
>> Please have a look at scripts/git.orderfile :)
> 
> Actually in this case I think that would make it less readable by
> putting headers with a lot of defines before actual code.
> 
>>> +                qemu_log_mask(LOG_UNIMP, "Unsupported bpp value");
>>
>> qemu_log_mask() requires trailing '\n' :(
> 
> Yes, it's hard to remember which of these QEMU functions need '\n' and
> which don't. Fixed.
> 
>>> +static inline uint64_t ati_reg_read_offs(uint32_t reg, int offs,
>>> +                                         unsigned int size)
>>
>> I doubt inlining help here.
> 
> Should not hurt either and it shows this is supposed to be a light
> helper function that's only split off for readability. I could also turn
> it to a macro with a ( ? : ) conditional expression now but it's
> probably more readable this way.
> 
>>> +    case RBBM_STATUS:
>>
>>           /* fall through */
>>
>>> +    case GUI_STAT:
>>> +        val = 64; /* free CMDFIFO entries */
>>> +        break;
> 
> Obviously fall through because there are no statements between case
> labels. I only use /* fall thorugh */ comment where there are some
> statements and a missing break but not in this case which should be
> clear without comment.

Apparently not enough obvious to me since I stopped here, since I don't
know the difference/relation between RBBM_STATUS/GUI_STAT registers.

> 
>>> +    default:
>>
>>           qemu_log(UNIMP)?
>>
>>> +        break;
>>> +    }
>>> +    trace_ati_mm_read(size, addr, ati_reg_name(addr & ~3ULL), val);
> 
> No log yet as most of the registers are currently unimplemented so that
> would generate too much logs. The trace should log all register accesses
> including unimplemented ones, that's enough currently.

As you wish :)

> 
>>> +    if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_QY &&
>>> +        s->vga.vram_size_mb < 16) {
>>> +        warn_report("Too small video memory for device id");
>>> +        s->vga.vram_size_mb = 16;
>>
>> I'd rather use error_setg() and return.
> 
> Correcting the error if possible is friendlier IMO but this can be
> debated what's the preferred behaviour. I'll leave it as it is for now.

Well we are somehow lying to the user... modifying his hardware without
his consent.

> 
>>> diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
>>> new file mode 100644
>>> index 0000000000..5b6fdb299d
>>> --- /dev/null
>>> +++ b/hw/display/ati_dbg.c
>>> @@ -0,0 +1,254 @@
>>> +#include "ati_int.h"
>>> +
>>> +#ifdef DEBUG_ATI
>>> +struct ati_regdesc {
>>> +    const char *name;
>>> +    int num;
>>
>> uint16_t?
> 
> uint16_t would be enough but int should be simpler for current CPUs and
> won't need possible padding to struct so I did not bother with
> restricting type here.
> 
>> I'd have inverted the structure member for nicer align ;)
> 
> It was easier to generate it with a simple sed command from ati_regs.h
> and update when new regs are added this way. I guess reversing the
> values could be done the same way. Maybe I should automate this so it
> will be updated automatically when new reg definitions are added but for
> now I left it to do by hand.

Fair enough.

> 
>>> +};
>>> +
>>> +static struct ati_regdesc ati_reg_names[] = {
>>
>> static 'const' struct ...
>>
>>> +    {"MM_INDEX", 0x0000},
> [...]
>>> +    {"RAGE128_MPP_TB_CONFIG", 0x01c0},
>>> +    {NULL, -1}
>>> +};
>>> +
>>> +const char *ati_reg_name(int num)
>>
>> I'd use reg_addr instead of num.
>>
>>> +{
>>> +    int i;
>>> +
>>> +    num &= ~3;
>>> +    for (i = 0; ati_reg_names[i].name; i++) {
>>
>> Well since it is const you can iterate until ARRAY_SIZE(ati_reg_names)
>> and drop the {NULL, -1} entry.
> 
> I could do any of the above but all this file is temporary for
> development and meant to be removed once enough functions of the device
> are implemented so for now I don't bother unless there's a strong
> argument other than style preference to change it.

I'd definitively keep it, and I now believe you should drop the
DEBUG_ATI around. It is only used by tracing right? And tracing is
already optimized. If it becomes someday unuseful to you, it can still
be useful for the next one wanting to improve/fix your device.

> 
>>> diff --git a/hw/display/trace-events b/hw/display/trace-events
>>> index 37d3264bb2..6aed33eeaa 100644
>>> --- a/hw/display/trace-events
>>> +++ b/hw/display/trace-events
>>> @@ -138,3 +138,7 @@ vga_cirrus_write_blt(uint32_t offset, uint32_t
>>> val) "offset 0x%x, val 0x%x"
>>>  sii9022_read_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"
>>>  sii9022_write_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"
>>>  sii9022_switch_mode(const char *mode) "mode: %s"
>>> +
>>> +# hw/display/ati*.c
>>> +ati_mm_read(unsigned int size, uint64_t addr, const char *name,
>>> uint64_t val) "%d 0x%"HWADDR_PRIx " %s -> 0x%"PRIx64
>>> +ati_mm_write(unsigned int size, uint64_t addr, const char *name,
>>> uint64_t val) "%d 0x%"HWADDR_PRIx " %s <- 0x%"PRIx64
>>
>> "%u ...
> 
> Should not matter as size that can only be 1 to 4 but %u is more correct
> to print unsigned variable so I'll change this.

The argument is unsigned, so the correct format is %u.

This help reducing the thousands of warnings in QEMU about incorrect
formatstring.

> 
> Thanks,
> BALATON Zoltan
