Received: from eggs.gnu.org ([2001:4830:134:3::10]:52195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dtw3C-00050w-Q3
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dtw3A-0007B8-QO
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:25:26 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9vydmYr81oMazziyi409S+DpQf+RGaCTHfRxXhPj-aYw@mail.gmail.com>
References: <1505494753-10837-1-git-send-email-sundeep.lkml@gmail.com>
	<1505494753-10837-3-git-send-email-sundeep.lkml@gmail.com>
	<2c6a4136-fb80-2000-940c-1df5e718cbf1@amsat.org>
	<CALHRZurRLysJCRwvm+SbJUn8YBAst_Q38RCzJkmT4z=mfnYuiQ@mail.gmail.com>
	<CAFEAcA9vydmYr81oMazziyi409S+DpQf+RGaCTHfRxXhPj-aYw@mail.gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Mon, 18 Sep 2017 18:55:23 +0530
Message-ID: <CALHRZuoMibZoUf5BSqMDyY9zknui-6Jc507-c=EJ03XoV0fibQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu devel v9 PATCH 2/5] msf2: Microsemi
 Smartfusion2 System Register block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair23@gmail.com>

H Peter,

On Mon, Sep 18, 2017 at 4:05 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 18 September 2017 at 11:17, sundeep subbaraya <sundeep.lkml@gmail.com>
> wrote:
> > Hi Philippe,
> >
> > On Mon, Sep 18, 2017 at 6:31 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@ams=
at.org
> >
> > wrote:
> >>
> >> Hi Sundeep, Peter,
> >>
> >>
> >> On 09/15/2017 01:59 PM, Subbaraya Sundeep wrote:
> >>>
> >>> Added Sytem register block of Smartfusion2.
> >>> This block has PLL registers which are accessed by guest.
> >>>
> >>> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> >>> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
> >>> ---
> >>>   hw/misc/Makefile.objs         |   1 +
> >>>   hw/misc/msf2-sysreg.c         | 168
> >>> ++++++++++++++++++++++++++++++++++++++++++
> >>>   hw/misc/trace-events          |   5 ++
> >>>   include/hw/misc/msf2-sysreg.h |  77 +++++++++++++++++++
> >>>   4 files changed, 251 insertions(+)
> >>>   create mode 100644 hw/misc/msf2-sysreg.c
> >>>   create mode 100644 include/hw/misc/msf2-sysreg.h
> >>>
> >>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> >>> index 29fb922..e8f0a02 100644
> >>> --- a/hw/misc/Makefile.objs
> >>> +++ b/hw/misc/Makefile.objs
> >>> @@ -59,3 +59,4 @@ obj-$(CONFIG_HYPERV_TESTDEV) +=3D hyperv_testdev.o
> >>>   obj-$(CONFIG_AUX) +=3D auxbus.o
> >>>   obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o
> >>>   obj-y +=3D mmio_interface.o
> >>> +obj-$(CONFIG_MSF2) +=3D msf2-sysreg.o
> >>> diff --git a/hw/misc/msf2-sysreg.c b/hw/misc/msf2-sysreg.c
> >>> new file mode 100644
> >>> index 0000000..dc3597b
> >>> --- /dev/null
> >>> +++ b/hw/misc/msf2-sysreg.c
> >>> @@ -0,0 +1,168 @@
> >>> +/*
> >>> + * System Register block model of Microsemi SmartFusion2.
> >>> + *
> >>> + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or
> >>> + * modify it under the terms of the GNU General Public License
> >>> + * as published by the Free Software Foundation; either version
> >>> + * 2 of the License, or (at your option) any later version.
> >>> + *
> >>> + * You should have received a copy of the GNU General Public License
> >>> along
> >>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> >>> + */
> >>> +
> >>> +#include "qemu/osdep.h"
> >>> +#include "qemu/log.h"
> >>> +#include "hw/misc/msf2-sysreg.h"
> >>> +#include "trace.h"
> >>> +
> >>> +static inline int msf2_divbits(uint32_t div)
> >>> +{
> >>> +    int ret =3D 0;
> >>> +
> >>> +    switch (div) {
> >>> +    case 1:
> >>> +        ret =3D 0;
> >>> +        break;
> >>> +    case 2:
> >>> +        ret =3D 1;
> >>> +        break;
> >>> +    case 4:
> >>> +        ret =3D 2;
> >>> +        break;
> >>> +    case 8:
> >>> +        ret =3D 4;
> >>> +        break;
> >>> +    case 16:
> >>> +        ret =3D 5;
> >>> +        break;
> >>> +    case 32:
> >>> +        ret =3D 6;
> >>> +        break;
> >>> +    default:
> >>> +        break;
> >>
> >>
> >> eh?
> >>
> >>> +    }
> >>> +
> >>> +    return ret;
> >>> +}
> >>> +
> >>> +static void msf2_sysreg_reset(DeviceState *d)
> >>> +{
> >>> +    MSF2SysregState *s =3D MSF2_SYSREG(d);
> >>> +
> >>> +    s->regs[MSSDDR_PLL_STATUS_LOW_CR] =3D 0x021A2358;
> >>> +    s->regs[MSSDDR_PLL_STATUS] =3D 0x3;
> >>> +    s->regs[MSSDDR_FACC1_CR] =3D msf2_divbits(s->apb0div) << 5 |
> >>
> >>
> >> ctz32(s->apb0div) << 5 ...
> >
> >
> > I will modify like below:
> > div0 =3D s->apb0div < 8 ? ctz32(s->apb0div) : ctz32(s->apb0div) + 1;
> > div1 =3D s->apb1div < 8 ? ctz32(s->apb1div) : ctz32(s->apb1div) + 1;
>
> I think you should keep an msf2_divbits() function for that,
> even if it's only
>
> static inline int msf2_divbits(uint32_t div)
> {
>     int r =3D ctz32(div);
>
>     return (div < 8) ? r : r + 1;
> }
>
> Ok will change like this.

Thanks,
Sundeep


> thanks
> -- PMM
>
