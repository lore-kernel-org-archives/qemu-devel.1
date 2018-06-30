Received: from eggs.gnu.org ([2001:4830:134:3::10]:55133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZIad-0005p5-EX
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZIac-0005GJ-09
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:19:11 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:41047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZIab-0005Ed-Hz
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:19:09 -0400
Received: by mail-ot0-x242.google.com with SMTP id d19-v6so13109941oti.8
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 09:19:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180630083357.23489-3-huth@tuxfamily.org>
References: <20180630083357.23489-1-huth@tuxfamily.org>
	<20180630083357.23489-3-huth@tuxfamily.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 30 Jun 2018 17:18:46 +0100
Message-ID: <CAFEAcA-uVfJ+XaP84Urzrz=PfxfZmPV1fRwV8TMGqxsZvKyo+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/4] m68k: Add NeXTcube keyboard device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Natalia Portillo <claunia@claunia.com>, Laurent Vivier <laurent@vivier.eu>, Bryce Lanham <blanham@gmail.com>

On 30 June 2018 at 09:33, Thomas Huth <huth@tuxfamily.org> wrote:
> It is likely still quite incomplete (e.g. mouse and interrupts are not
> implemented yet), but it is good enough for keyboard input at the firmware
> monitor.
> This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch at
>
>  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-kbd.c
>
> and altered to fit the latest interface of the current QEMU (e.g. to use
> memory_region_init_io() instead of cpu_register_physical_memory()).
>
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>  hw/m68k/Makefile.objs       |   5 +-
>  hw/m68k/next-kbd.c          | 289 ++++++++++++++++++++++++++++++++++++
>  include/hw/m68k/next-cube.h |   3 +
>  3 files changed, 295 insertions(+), 2 deletions(-)
>  create mode 100644 hw/m68k/next-kbd.c
>
> diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
> index d1f089c08a..5852fd2500 100644
> --- a/hw/m68k/Makefile.objs
> +++ b/hw/m68k/Makefile.objs
> @@ -1,2 +1,3 @@
> -obj-y += an5206.o mcf5208.o
> -obj-y += mcf5206.o mcf_intc.o
> +obj-$(CONFIG_COLDFIRE) += an5206.o mcf5208.o
> +obj-$(CONFIG_COLDFIRE) += mcf5206.o mcf_intc.o
> +obj-$(CONFIG_NEXTCUBE) += next-kbd.o
> diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
> new file mode 100644
> index 0000000000..0c4655f586
> --- /dev/null
> +++ b/hw/m68k/next-kbd.c
> @@ -0,0 +1,289 @@
> +/*
> + * QEMU NeXT Keyboard/Mouse emulation
> + *
> + * Copyright (c) 2011 Bryce Lanham
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +/*
> + * This is admittedly hackish, but works well enough for basic input. Mouse
> + * support will be added once we can boot something that needs the mouse.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/address-spaces.h"
> +#include "hw/hw.h"
> +#include "hw/m68k/next-cube.h"
> +#include "ui/console.h"
> +#include "sysemu/sysemu.h"
> +
> +/* debug NeXT keyboard */
> +//#define DEBUG_KBD
> +
> +#ifdef DEBUG_KBD
> +#define DPRINTF(fmt, ...) do { printf("KBD: " fmt , ## __VA_ARGS__); } while (0)
> +#else
> +#define DPRINTF(fmt, ...) do { } while (0)
> +#endif
> +
> +/* following defintions from next68k netbsd */
> +#define CSR_INT 0x00800000
> +#define CSR_DATA 0x00400000
> +
> +#define KD_KEYMASK    0x007f
> +#define KD_DIRECTION  0x0080 /* pressed or released */
> +#define KD_CNTL       0x0100
> +#define KD_LSHIFT     0x0200
> +#define KD_RSHIFT     0x0400
> +#define KD_LCOMM      0x0800
> +#define KD_RCOMM      0x1000
> +#define KD_LALT       0x2000
> +#define KD_RALT       0x4000
> +#define KD_VALID      0x8000 /* only set for scancode keys ? */
> +#define KD_MODS       0x4f00
> +
> +#define KBD_QUEUE_SIZE 256
> +
> +typedef struct {
> +    uint8_t data[KBD_QUEUE_SIZE];
> +    int rptr, wptr, count;
> +} KBDQueue;
> +
> +
> +typedef struct KBDState {
> +    KBDQueue queue;
> +    uint8_t blank;
> +    uint16_t shift;
> +} KBDState;

I'm sceptical that the real hardware has a 256 byte queue
like this...

> +KBDState *kbd_env;

What is this global for?

> +void nextkbd_init(void)
> +{
> +    KBDState *s = g_new0(KBDState, 1);
> +    MemoryRegion *kbdmem = g_new(MemoryRegion, 1);
> +
> +    s->shift = 0;
> +
> +    memory_region_init_io(kbdmem, NULL, &kbd_ops, s, "next.kbd", 0x1000);
> +    memory_region_add_subregion(get_system_memory(), 0x200e000, kbdmem);
> +
> +    qemu_add_kbd_event_handler(nextkbd_event, s);
> +}

This needs to be a proper QOM device (and this one does have
internal state so needs reset and vmstate).

thanks
-- PMM
