Received: from eggs.gnu.org ([2001:4830:134:3::10]:47937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1gEq5p-0004VG-Jl
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 02:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1gEq5h-0001uH-Ey
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 02:23:03 -0400
Received: from mout02.posteo.de ([185.67.36.66]:54641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <th.huth@posteo.de>) id 1gEq5c-0001kc-8Q
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 02:22:53 -0400
Received: from submission (posteo.de [89.146.220.130])
	by mout02.posteo.de (Postfix) with ESMTPS id A300B2400FD
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 08:22:49 +0200 (CEST)
References: <20181018182856.28001-1-mark.cave-ayland@ilande.co.uk>
	<20181018182856.28001-2-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <th.huth@posteo.de>
Message-ID: <06fc6b51-4989-658e-c525-8a30d8513d8e@posteo.de>
Date: Tue, 23 Oct 2018 07:22:46 +0100
MIME-Version: 1.0
In-Reply-To: <20181018182856.28001-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 01/11] hw/m68k: add via support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, laurent@vivier.eu
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, yongbok.kim@mips.com, aurelien@aurel32.net

On 2018-10-18 19:28, Mark Cave-Ayland wrote:
> From: Laurent Vivier <laurent@vivier.eu>
> 
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
[...]
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> new file mode 100644
> index 0000000000..084974a24d
> --- /dev/null
> +++ b/hw/misc/mac_via.c
> @@ -0,0 +1,668 @@
> +/*
> + * QEMU m68k Macintosh VIA device support
> + *
> + * Copyright (c) 2011-2018 Laurent Vivier

Should Mark be listed here, too? (since it has been co-developed?)

> + *
> + * Some parts from hw/cuda.c

That's hw/misc/macio/cuda.c now.

> + *
> + * Copyright (c) 2004-2007 Fabrice Bellard
> + * Copyright (c) 2007 Jocelyn Mayer
> + *
> + * some parts from linux-2.6.29, arch/m68k/include/asm/mac_via.h
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *

Maybe remove the empty line?

> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "qemu/timer.h"
> +#include "hw/misc/mac_via.h"
> +#include "hw/misc/mos6522.h"
> +#include "hw/input/adb.h"
> +#include "sysemu/sysemu.h"
> +#include "qapi/error.h"
> +#include "qemu/cutils.h"
> +
> +
> +/*
> + * VIAs: There are two in every machine,

Remove the comma at the end. And maybe add a very short description what
a "VIA" is (for those who don't know this chip)

> + */
> +
> +#define VIA_SIZE (0x2000)
> +
> +/*
> + * Not all of these are true post MacII I think.
> + * CSA: probably the ones CHRP marks as 'unused' change purposes

What is CSA?

> + * when the IWM becomes the SWIM.
> + * http://www.rs6000.ibm.com/resource/technology/chrpio/via5.mak.html
> + * ftp://ftp.austin.ibm.com/pub/technology/spec/chrp/inwork/CHRP_IORef_1.0.pdf
> + *
> + * also, http://developer.apple.com/technotes/hw/hw_09.html claims the

All three URLs seem to be dead. Use archive.org?

> + * following changes for IIfx:
> + * VIA1A_vSccWrReq not available and that VIA1A_vSync has moved to an IOP.
> + * Also, "All of the functionality of VIA2 has been moved to other chips".
> + */
> +
> +#define VIA1A_vSccWrReq 0x80   /* SCC write. (input)
> +                                * [CHRP] SCC WREQ: Reflects the state of the
> +                                * Wait/Request pins from the SCC.
> +                                * [Macintosh Family Hardware]
> +                                * as CHRP on SE/30,II,IIx,IIcx,IIci.
> +                                * on IIfx, "0 means an active request"
> +                                */
> +#define VIA1A_vRev8     0x40   /* Revision 8 board ???
> +                                * [CHRP] En WaitReqB: Lets the WaitReq_L
> +                                * signal from port B of the SCC appear on
> +                                * the PA7 input pin. Output.
> +                                * [Macintosh Family] On the SE/30, this
> +                                * is the bit to flip screen buffers.
> +                                * 0=alternate, 1=main.
> +                                * on II,IIx,IIcx,IIci,IIfx this is a bit
> +                                * for Rev ID. 0=II,IIx, 1=IIcx,IIci,IIfx
> +                                */
> +#define VIA1A_vHeadSel  0x20   /* Head select for IWM.
> +                                * [CHRP] unused.
> +                                * [Macintosh Family] "Floppy disk
> +                                * state-control line SEL" on all but IIfx
> +                                */
> +#define VIA1A_vOverlay  0x10   /* [Macintosh Family] On SE/30,II,IIx,IIcx
> +                                * this bit enables the "Overlay" address
> +                                * map in the address decoders as it is on
> +                                * reset for mapping the ROM over the reset
> +                                * vector. 1=use overlay map.
> +                                * On the IIci,IIfx it is another bit of the
> +                                * CPU ID: 0=normal IIci, 1=IIci with parity
> +                                * feature or IIfx.
> +                                * [CHRP] En WaitReqA: Lets the WaitReq_L
> +                                * signal from port A of the SCC appear
> +                                * on the PA7 input pin (CHRP). Output.
> +                                * [MkLinux] "Drive Select"
> +                                *  (with 0x20 being 'disk head select')
> +                                */
> +#define VIA1A_vSync     0x08   /* [CHRP] Sync Modem: modem clock select:
> +                                * 1: select the external serial clock to
> +                                *    drive the SCC's /RTxCA pin.
> +                                * 0: Select the 3.6864MHz clock to drive
> +                                *    the SCC cell.
> +                                * [Macintosh Family] Correct on all but IIfx
> +                                */
> +
> +/* Macintosh Family Hardware sez: bits 0-2 of VIA1A are volume control

sez?

> + * on Macs which had the PWM sound hardware.  Reserved on newer models.
> + * On IIci,IIfx, bits 1-2 are the rest of the CPU ID:
> + * bit 2: 1=IIci, 0=IIfx
> + * bit 1: 1 on both IIci and IIfx.
> + * MkLinux sez bit 0 is 'burnin flag' in this case.

sez?? sets?

> +/* common */
> +
> +#define VIA_IRQ_TIMER1      0x40
> +#define VIA_IRQ_TIMER2      0x20
> +
> +/* Apple sez: http://developer.apple.com/technotes/ov/ov_04.html

sez? ... and the URL does not work anymore.

> + * Another example of a valid function that has no ROM support is the use
> + * of the alternate video page for page-flipping animation. Since there
> + * is no ROM call to flip pages, it is necessary to go play with the
> + * right bit in the VIA chip (6522 Versatile Interface Adapter).
> + * [CSA: don't know which one this is, but it's one of 'em!]
> + */

Who is CSA? ... ah, now I've got it, this has been copied from the Linux
header. Do you want to keep it in the QEMU sources, or rather take the
opportunity to clean the comments up a little bit?

[...]
> +static void via2_irq_request(void *opaque, int irq, int level)
> +{
> +    MOS6522Q800VIA2State *v2s = opaque;
> +    MOS6522State *s = MOS6522(v2s);
> +    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(s);
> +
> +    if (level) {
> +        s->ifr |= 1 << irq;
> +    } else {
> +        s->ifr &= ~(1 << irq);
> +    }
> +
> +    mdc->update_irq(s);
> +}
> +
> +#define RTC_OFFSET 2082844800
> +static uint8_t PRAM[256];

Shouldn't that PRAM array rather be part of the MacVIAState or so?

> +
> +static void via1_rtc_update(MacVIAState *m)
> +{
> +    MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(&m->mos6522_via1);
> +    MOS6522State *s = MOS6522(v1s);
> +
> +    if (s->b & VIA1B_vRTCEnb) {
> +        return;
> +    }
> +
> +    if (s->dirb & VIA1B_vRTCData) {
> +        /* send bits to the RTC */
> +        if (!(v1s->last_b & VIA1B_vRTCClk) && (s->b & VIA1B_vRTCClk)) {
> +            m->data_out <<= 1;
> +            m->data_out |= s->b & VIA1B_vRTCData;
> +            m->data_out_cnt++;
> +        }
> +    } else {
> +        /* receive bits from the RTC */
> +        if ((v1s->last_b & VIA1B_vRTCClk) &&
> +            !(s->b & VIA1B_vRTCClk) &&
> +            m->data_in_cnt) {
> +            s->b = (s->b & ~VIA1B_vRTCData) |
> +                   ((m->data_in >> 7) & VIA1B_vRTCData);
> +            m->data_in <<= 1;
> +            m->data_in_cnt--;
> +        }
> +    }
> +
> +    if (m->data_out_cnt == 8) {
> +        m->data_out_cnt = 0;
> +
> +        if (m->cmd == 0) {
> +            if (m->data_out & 0x80) {
> +                /* this is a read command */
> +                uint32_t time = m->tick_offset +
> +                               (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
> +                               NANOSECONDS_PER_SECOND);
> +                if (m->data_out == 0x81) {        /* seconds register 0 */
> +                    m->data_in = time & 0xff;
> +                    m->data_in_cnt = 8;
> +                } else if (m->data_out == 0x85) { /* seconds register 1 */
> +                    m->data_in = (time >> 8) & 0xff;
> +                    m->data_in_cnt = 8;
> +                } else if (m->data_out == 0x89) { /* seconds register 2 */
> +                    m->data_in = (time >> 16) & 0xff;
> +                    m->data_in_cnt = 8;
> +                } else if (m->data_out == 0x8d) { /* seconds register 3 */
> +                    m->data_in = (time >> 24) & 0xff;
> +                    m->data_in_cnt = 8;
> +                } else if ((m->data_out & 0xf3) == 0xa1) {
> +                    /* PRAM address 0x10 -> 0x13 */
> +                    int addr = (m->data_out >> 2) & 0x03;
> +                    m->data_in = PRAM[addr];
> +                    m->data_in_cnt = 8;
> +                } else if ((m->data_out & 0xf3) == 0xa1) {
> +                    /* PRAM address 0x00 -> 0x0f */
> +                    int addr = (m->data_out >> 2) & 0x0f;
> +                    m->data_in = PRAM[addr];
> +                    m->data_in_cnt = 8;
> +                } else if ((m->data_out & 0xf8) == 0xb8) {
> +                    /* extended memory designator and sector number */
> +                    m->cmd = m->data_out;
> +                }
> +            } else {
> +                /* this is a write command */
> +                m->cmd = m->data_out;
> +            }
> +        } else {
> +            if (m->cmd & 0x80) {
> +                if ((m->cmd & 0xf8) == 0xb8) {
> +                    /* extended memory designator and sector number */
> +                    int sector = m->cmd & 0x07;
> +                    int addr = (m->data_out >> 2) & 0x1f;
> +
> +                    m->data_in = PRAM[sector * 8 + addr];
> +                    m->data_in_cnt = 8;
> +                }
> +            } else if (!m->wprotect) {
> +                /* this is a write command */
> +                if (m->alt != 0) {
> +                    /* extended memory designator and sector number */
> +                    int sector = m->cmd & 0x07;
> +                    int addr = (m->alt >> 2) & 0x1f;
> +
> +                    PRAM[sector * 8 + addr] = m->data_out;
> +
> +                    m->alt = 0;
> +                } else if (m->cmd == 0x01) { /* seconds register 0 */
> +                    /* FIXME */
> +                } else if (m->cmd == 0x05) { /* seconds register 1 */
> +                    /* FIXME */
> +                } else if (m->cmd == 0x09) { /* seconds register 2 */
> +                    /* FIXME */
> +                } else if (m->cmd == 0x0d) { /* seconds register 3 */
> +                    /* FIXME */
> +                } else if (m->cmd == 0x31) {
> +                    /* Test Register */
> +                } else if (m->cmd == 0x35) {
> +                    /* Write Protect register */
> +                    m->wprotect = m->data_out & 1;
> +                } else if ((m->cmd & 0xf3) == 0xa1) {
> +                    /* PRAM address 0x10 -> 0x13 */
> +                    int addr = (m->cmd >> 2) & 0x03;
> +                    PRAM[addr] = m->data_out;
> +                } else if ((m->cmd & 0xf3) == 0xa1) {
> +                    /* PRAM address 0x00 -> 0x0f */
> +                    int addr = (m->cmd >> 2) & 0x0f;
> +                    PRAM[addr] = m->data_out;
> +                } else if ((m->cmd & 0xf8) == 0xb8) {
> +                    /* extended memory designator and sector number */
> +                    m->alt = m->cmd;
> +                }
> +            }
> +        }
> +        m->data_out = 0;
> +    }
> +}
> +
> +static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    MOS6522Q800VIA1State *s = opaque;
> +    MOS6522State *ms = MOS6522(s);

Replace the above two lines with:

	MOS6522State *ms = MOS6522(opaque);

?

Or use MOS6522_Q800_VIA1() in the first line instead?

> +    addr = (addr >> 9) & 0xf;
> +    return mos6522_read(ms, addr, size);
> +}
> +
> +static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
> +                                    unsigned size)
> +{
> +    MOS6522Q800VIA1State *s = opaque;
> +    MOS6522State *ms = MOS6522(s);

dito.

> +    addr = (addr >> 9) & 0xf;
> +    mos6522_write(ms, addr, val, size);
> +}
> +
> +static const MemoryRegionOps mos6522_q800_via1_ops = {
> +    .read = mos6522_q800_via1_read,
> +    .write = mos6522_q800_via1_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,
> +    },
> +};
> +
> +static uint64_t mos6522_q800_via2_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    MOS6522Q800VIA2State *s = opaque;
> +    MOS6522State *ms = MOS6522(s);
> +
> +    addr = (addr >> 9) & 0xf;
> +    return mos6522_read(ms, addr, size);
> +}
> +
> +static void mos6522_q800_via2_write(void *opaque, hwaddr addr, uint64_t val,
> +                                    unsigned size)
> +{
> +    MOS6522Q800VIA2State *s = opaque;
> +    MOS6522State *ms = MOS6522(s);
> +
> +    addr = (addr >> 9) & 0xf;
> +    mos6522_write(ms, addr, val, size);
> +}
> +
> +static const MemoryRegionOps mos6522_q800_via2_ops = {
> +    .read = mos6522_q800_via2_read,
> +    .write = mos6522_q800_via2_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,
> +    },
> +};

Do you really need the separate via2_ops? The look pretty much the same
like the via1_ops? Isn't it enough to have the opaque parameter for
differentiation?

 Thomas
