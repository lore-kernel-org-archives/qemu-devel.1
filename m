Received: from eggs.gnu.org ([2001:4830:134:3::10]:44409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gFmLv-0001U5-9v
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gFmEB-0005oK-QN
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:27:37 -0400
References: <20181018182856.28001-1-mark.cave-ayland@ilande.co.uk>
	<20181018182856.28001-5-mark.cave-ayland@ilande.co.uk>
	<33d70ccc-3653-ffe3-a9ae-dee99eb209cd@posteo.de>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <7c59ea36-73eb-cac7-4414-2b5e15e4c525@ilande.co.uk>
Date: Thu, 25 Oct 2018 21:27:00 +0100
MIME-Version: 1.0
In-Reply-To: <33d70ccc-3653-ffe3-a9ae-dee99eb209cd@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 04/11] hw/m68k: add macfb video card
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <th.huth@posteo.de>, qemu-devel@nongnu.org, kraxel@redhat.com, laurent@vivier.eu
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, pbonzini@redhat.com, yongbok.kim@mips.com, aurelien@aurel32.net

On 23/10/2018 08:13, Thomas Huth wrote:

> On 2018-10-18 19:28, Mark Cave-Ayland wrote:
>> From: Laurent Vivier <laurent@vivier.eu>
>>
>> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  arch_init.c                 |   4 +
>>  hw/display/Makefile.objs    |   1 +
>>  hw/display/macfb-template.h | 158 +++++++++++++++++++++++++++
>>  hw/display/macfb.c          | 252 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/display/macfb.h  |  42 ++++++++
>>  qemu-options.hx             |   2 +-
>>  vl.c                        |   3 +-
>>  7 files changed, 460 insertions(+), 2 deletions(-)
>>  create mode 100644 hw/display/macfb-template.h
>>  create mode 100644 hw/display/macfb.c
>>  create mode 100644 include/hw/display/macfb.h
> [...]
>> +typedef void (*macfb_draw_line_func_t)(MacfbState *, uint8_t *, uint8_t *, int);
>> +
>> +static macfb_draw_line_func_t macfb_draw_line[24][32] = {
>> +    [0] = { [7] = draw_line1_8, [15] = draw_line1_16,
>> +            [23] = draw_line1_24, [31] = draw_line1_32 },
>> +    [1] = { [7] = draw_line2_8, [15] = draw_line2_16,
>> +            [23] = draw_line2_24, [31] = draw_line2_32 },
>> +    [3] = { [7] = draw_line4_8, [15] = draw_line4_16,
>> +            [23] = draw_line4_24, [31] = draw_line4_32 },
>> +    [7] = { [7] = draw_line8_8, [15] = draw_line8_16,
>> +            [23] = draw_line8_24, [31] = draw_line8_32 },
>> +    [15] = { [7] = draw_line16_8, [15] = draw_line16_16,
>> +             [23] = draw_line16_24, [31] = draw_line16_32 },
>> +    [23] = { [7] = draw_line24_8, [15] = draw_line24_16,
>> +             [23] = draw_line24_24, [31] = draw_line24_32 },
>> +};
> 
> May I suggest to define the array as macfb_draw_line[24][4] instead of
> macfb_draw_line[24][32] here...

Indeed, this is an artefact from the original implementation that can now be removed
given that all host surfaces are now 32-bit.

>> diff --git a/hw/display/macfb.c b/hw/display/macfb.c
>> new file mode 100644
>> index 0000000000..54472c1cbb
>> --- /dev/null
>> +++ b/hw/display/macfb.c
>> @@ -0,0 +1,252 @@
>> +/*
>> + * QEMU Motorola 680x0 Macintosh Video Card Emulation
>> + *                 Copyright (c) 2012-2018 Laurent Vivier
>> + *
>> + * some parts from QEMU G364 framebuffer Emulator.
>> + *                 Copyright (c) 2007-2011 Herve Poussineau
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/sysbus.h"
>> +#include "ui/console.h"
>> +#include "ui/pixel_ops.h"
>> +#include "hw/display/macfb.h"
>> +
>> +#define VIDEO_BASE 0x00001000
>> +#define DAFB_BASE  0x00800000
>> +
>> +#define MACFB_PAGE_SIZE 4096
>> +#define MACFB_VRAM_SIZE (4 * 1024 * 1024)
>> +
>> +#define DAFB_RESET      0x200
>> +#define DAFB_LUT        0x213
>> +
>> +#include "macfb-template.h"
>> +
>> +static int macfb_check_dirty(MacfbState *s, DirtyBitmapSnapshot *snap,
>> +                             ram_addr_t addr, int len)
>> +{
>> +    return memory_region_snapshot_get_dirty(&s->mem_vram, snap, addr, len);
>> +}
>> +
>> +static void macfb_draw_graphic(MacfbState *s)
>> +{
>> +    DisplaySurface *surface = qemu_console_surface(s->con);
>> +    DirtyBitmapSnapshot *snap = NULL;
>> +    ram_addr_t page;
>> +    int y, ymin;
>> +    int macfb_stride = (s->depth * s->width + 7) / 8;
>> +    macfb_draw_line_func_t draw_line;
>> +
>> +    if (s->depth > 24) {
>> +        hw_error("macfb: unknown guest depth %d", s->depth);
> 
> I think this should be checked in the realize() function instead (and
> maybe only do an assert() here).

Yes indeed - fixed in the updated version.

>> +        return;
>> +    }
>> +    if (surface_bits_per_pixel(surface) > 32) {
>> +        hw_error("macfb: unknown host depth %d",
>> +                 surface_bits_per_pixel(surface));
> 
> Simply assert(surface_bits_per_pixel(surface) <= 32) ?

I had a look at a few other display implementations and it seems the easiest thing to
do here is move this to realize similar to above.

>> +        return;
>> +    }
>> +    draw_line = macfb_draw_line[s->depth - 1][surface_bits_per_pixel(surface)
>> +                                              - 1];
> 
> ... If you change func_t macfb_draw_line[24][32] to func_t
> macfb_draw_line[24][4], you could then use
> surface_bits_per_pixel(surface) / 8 - 1 here instead.
> 
> Also, do we have still to care about host bit depths < 32 at all these
> days? If not, I think the code could be simplified quite a bit.

Yes indeed. In fact, looking at the current VGA code the use of the template has now
been removed so I've expanded out the remaining functions within macfb.c and removed
macfb-template.h which is no longer required.

>> +    if (draw_line == NULL) {
>> +        hw_error("macfb: unknown guest/host depth combination %d/%d", s->depth,
>> +                 surface_bits_per_pixel(surface));
> 
> hw_error() is meant for CPU errors only (it prints out a CPU register
> dump), please don't use it in the framebuffer code.

I've replaced this with error_setg() in my latest version.


ATB,

Mark.
