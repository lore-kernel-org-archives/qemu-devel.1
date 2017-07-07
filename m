Received: from eggs.gnu.org ([2001:4830:134:3::10]:60438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dTWCl-0002DP-0G
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dTWCj-0007j2-Ha
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:34:07 -0400
MIME-Version: 1.0
In-Reply-To: <CALHRZuo7Y2RpS3EWnd55_Te_p2YSo03JcdTYB31MDz7p07bSGA@mail.gmail.com>
References: <1499057115-6773-1-git-send-email-sundeep.lkml@gmail.com>
	<1499057115-6773-3-git-send-email-sundeep.lkml@gmail.com>
	<CAKmqyKORKWWOUSAQ8_GtF6rOspE0mtJOEhJTvfuJ6h7JAru74A@mail.gmail.com>
	<CALHRZuo7Y2RpS3EWnd55_Te_p2YSo03JcdTYB31MDz7p07bSGA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 7 Jul 2017 09:33:33 -0700
Message-ID: <CAKmqyKM7WGg30=TNtPotC-Vr7uYFxZmAuYXWRDjXHDxMM1vhbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu devel v6 PATCH 2/5] msf2: Microsemi
 Smartfusion2 System Register block.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sundeep subbaraya <sundeep.lkml@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Fri, Jul 7, 2017 at 12:08 AM, sundeep subbaraya
<sundeep.lkml@gmail.com> wrote:
> Hi Alistair,
>
> On Wed, Jul 5, 2017 at 11:36 PM, Alistair Francis <alistair23@gmail.com>
> wrote:
>>
>> On Sun, Jul 2, 2017 at 9:45 PM, Subbaraya Sundeep
>> <sundeep.lkml@gmail.com> wrote:
>> > Added Sytem register block of Smartfusion2.
>> > This block has PLL registers which are accessed by guest.
>> >
>> > Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> > ---
>> >  hw/misc/Makefile.objs         |   1 +
>> >  hw/misc/msf2-sysreg.c         | 200
>> > ++++++++++++++++++++++++++++++++++++++++++
>> >  include/hw/misc/msf2-sysreg.h |  82 +++++++++++++++++
>> >  3 files changed, 283 insertions(+)
>> >  create mode 100644 hw/misc/msf2-sysreg.c
>> >  create mode 100644 include/hw/misc/msf2-sysreg.h
>> >
>> > diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> > index c8b4893..0f52354 100644
>> > --- a/hw/misc/Makefile.objs
>> > +++ b/hw/misc/Makefile.objs
>> > @@ -56,3 +56,4 @@ obj-$(CONFIG_EDU) += edu.o
>> >  obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
>> >  obj-$(CONFIG_AUX) += auxbus.o
>> >  obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
>> > +obj-$(CONFIG_MSF2) += msf2-sysreg.o
>> > diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
>> > new file mode 100644
>> > index 0000000..64ee141
>> > --- /dev/null
>> > +++ b/hw/misc/msf2-sysreg.c
>> > @@ -0,0 +1,200 @@
>> > +/*
>> > + * System Register block model of Microsemi SmartFusion2.
>> > + *
>> > + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> > + *
>> > + * This program is free software; you can redistribute it and/or
>> > + * modify it under the terms of the GNU General Public License
>> > + * as published by the Free Software Foundation; either version
>> > + * 2 of the License, or (at your option) any later version.
>> > + *
>> > + * You should have received a copy of the GNU General Public License
>> > along
>> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> > + */
>> > +
>> > +#include "hw/misc/msf2-sysreg.h"
>>
>> Same #include comment from patch 1.
>
>
> Ok will change.
>>
>>
>> > +
>> > +#ifndef MSF2_SYSREG_ERR_DEBUG
>> > +#define MSF2_SYSREG_ERR_DEBUG  0
>> > +#endif
>> > +
>> > +#define DB_PRINT_L(lvl, fmt, args...) do { \
>> > +    if (MSF2_SYSREG_ERR_DEBUG >= lvl) { \
>> > +        qemu_log("%s: " fmt "\n", __func__, ## args); \
>> > +    } \
>> > +} while (0);
>> > +
>> > +#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
>> > +
>> > +static inline int msf2_divbits(uint32_t div)
>> > +{
>> > +    int ret = 0;
>> > +
>> > +    switch (div) {
>> > +    case 1:
>> > +        ret = 0;
>> > +        break;
>> > +    case 2:
>> > +        ret = 1;
>> > +        break;
>> > +    case 4:
>> > +        ret = 2;
>> > +        break;
>> > +    case 8:
>> > +        ret = 4;
>> > +        break;
>> > +    case 16:
>> > +        ret = 5;
>> > +        break;
>> > +    case 32:
>> > +        ret = 6;
>> > +        break;
>> > +    default:
>> > +        break;
>> > +    }
>> > +
>> > +    return ret;
>> > +}
>> > +
>> > +static void msf2_sysreg_reset(DeviceState *d)
>> > +{
>> > +    MSF2SysregState *s = MSF2_SYSREG(d);
>> > +
>> > +    DB_PRINT("RESET");
>> > +
>> > +    s->regs[MSSDDR_PLL_STATUS_LOW_CR] = 0x021A2358;
>> > +    s->regs[MSSDDR_PLL_STATUS] = 0x3;
>> > +    s->regs[MSSDDR_FACC1_CR] = msf2_divbits(s->apb0div) << 5 |
>> > +                               msf2_divbits(s->apb1div) << 2;
>> > +}
>> > +
>> > +static uint64_t msf2_sysreg_read(void *opaque, hwaddr offset,
>> > +    unsigned size)
>> > +{
>> > +    MSF2SysregState *s = opaque;
>> > +    offset /= 4;
>>
>> Probably best to use a bitshift.
>
>
> Ok will change.
>>
>>
>> > +    uint32_t ret = 0;
>> > +
>> > +    if (offset < ARRAY_SIZE(s->regs)) {
>> > +        ret = s->regs[offset];
>> > +        DB_PRINT("addr: 0x%08" HWADDR_PRIx " data: 0x%08" PRIx32,
>> > +                    offset * 4, ret);
>>
>> Bitshift here as well.
>
>
> Ok will change.
>>
>>
>> > +    } else {
>> > +        qemu_log_mask(LOG_GUEST_ERROR,
>> > +                    "%s: Bad offset 0x%08" HWADDR_PRIx "\n", __func__,
>> > +                    offset * 4);
>> > +    }
>> > +
>> > +    return ret;
>> > +}
>> > +
>> > +static void msf2_sysreg_write(void *opaque, hwaddr offset,
>> > +                          uint64_t val, unsigned size)
>> > +{
>> > +    MSF2SysregState *s = (MSF2SysregState *)opaque;
>> > +    uint32_t newval = val;
>> > +    uint32_t oldval;
>> > +
>> > +    DB_PRINT("addr: 0x%08" HWADDR_PRIx " data: 0x%08" PRIx64,
>> > +            offset, val);
>> > +
>> > +    offset /= 4;
>>
>> Same here
>
>
> Ok will change
>>
>>
>> > +
>> > +    switch (offset) {
>> > +    case MSSDDR_PLL_STATUS:
>> > +        break;
>> > +
>> > +    case ESRAM_CR:
>> > +        oldval = s->regs[ESRAM_CR];
>> > +        if (oldval ^ newval) {
>> > +            qemu_log_mask(LOG_GUEST_ERROR,
>> > +                       TYPE_MSF2_SYSREG": eSRAM remapping not
>> > supported\n");
>> > +            abort();
>>
>> The guest should not be able to kill QEMU, a guest error should never
>> result in an abort.
>
>
> Philippe suggested to abort because:
> If guest tries to remap since firmware do a remap, the code flow will be
> completely wrong.
> Reporting a GUEST_ERROR here is not enough since code flow continuing would
> be
> pretty hard to understand/debug.

I don't see how it will be that hard to debug as QEMU will tell you
that the guest is doing something wrong.

You can't allow the guest to abort or exit QEMU. It's a security
liability issue and specifically mentioned as not allowed:
https://github.com/qemu/qemu/blob/master/HACKING#L230

Thanks,
Alistair

> We decided to abort for now.
