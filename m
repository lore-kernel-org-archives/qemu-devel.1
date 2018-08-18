Received: from eggs.gnu.org ([2001:4830:134:3::10]:40892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqyAF-0007V2-4G
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqy6F-0005ua-Rx
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:04:53 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqy6F-0005r9-Dz
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:04:51 -0400
Received: by mail-oi0-x243.google.com with SMTP id b15-v6so18126636oib.10
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 03:04:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <34fd5e4b-4b39-65be-d1e9-a655f656dbc9@amsat.org>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
	<20180809130115.28951-6-peter.maydell@linaro.org>
	<34fd5e4b-4b39-65be-d1e9-a655f656dbc9@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Aug 2018 11:04:30 +0100
Message-ID: <CAFEAcA-NEBa3cyHAMsSJ6o45-KO1oHewRc9QEApFCt0SX+8AkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 05/16] hw/misc/iotkit-sysctl:
 Implement IoTKit system control element
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 18 August 2018 at 01:23, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> Hi Peter,
>
> On 08/09/2018 10:01 AM, Peter Maydell wrote:
>> The Arm IoTKit includes a system control element which
>> provides a block of read-only ID registers and a block
>> of read-write control registers. Implement a minimal
>> version of this.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  hw/misc/Makefile.objs           |   1 +
>>  include/hw/misc/iotkit-sysctl.h |  50 +++++
>>  hw/misc/iotkit-sysctl.c         | 324 ++++++++++++++++++++++++++++++++
>>  MAINTAINERS                     |   2 +
>>  default-configs/arm-softmmu.mak |   1 +
>>  hw/misc/trace-events            |   7 +
>>  6 files changed, 385 insertions(+)
>>  create mode 100644 include/hw/misc/iotkit-sysctl.h
>>  create mode 100644 hw/misc/iotkit-sysctl.c
>>
>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> index 93509008451..dbadb41d57a 100644
>> --- a/hw/misc/Makefile.objs
>> +++ b/hw/misc/Makefile.objs
>> @@ -65,6 +65,7 @@ obj-$(CONFIG_MPS2_SCC) +=3D mps2-scc.o
>>  obj-$(CONFIG_TZ_MPC) +=3D tz-mpc.o
>>  obj-$(CONFIG_TZ_PPC) +=3D tz-ppc.o
>>  obj-$(CONFIG_IOTKIT_SECCTL) +=3D iotkit-secctl.o
>> +obj-$(CONFIG_IOTKIT_SYSCTL) +=3D iotkit-sysctl.o
>>
>>  obj-$(CONFIG_PVPANIC) +=3D pvpanic.o
>>  obj-$(CONFIG_HYPERV_TESTDEV) +=3D hyperv_testdev.o
>> diff --git a/include/hw/misc/iotkit-sysctl.h b/include/hw/misc/iotkit-sy=
sctl.h
>> new file mode 100644
>> index 00000000000..c3b14ccee4c
>> --- /dev/null
>> +++ b/include/hw/misc/iotkit-sysctl.h
>> @@ -0,0 +1,50 @@
>> +/*
>> + * ARM IoTKit system control element
>> + *
>> + * Copyright (c) 2018 Linaro Limited
>> + * Written by Peter Maydell
>> + *
>> + *  This program is free software; you can redistribute it and/or modif=
y
>> + *  it under the terms of the GNU General Public License version 2 or
>> + *  (at your option) any later version.
>> + */
>> +
>> +/*
>> + * This is a model of the "system control element" which is part of the
>> + * Arm IoTKit and documented in
>> + * http://infocenter.arm.com/help/index.jsp?topic=3D/com.arm.doc.ecm060=
1256/index.html
>> + * Specifically, it implements the "system information block" and
>> + * "system control register" blocks.
>> + *
>> + * QEMU interface:
>> + *  + sysbus MMIO region 0: the system information register bank
>> + *  + sysbus MMIO region 1: the system control register bank
>> + */
>> +
>> +#ifndef HW_MISC_IOTKIT_SYSCTL_H
>> +#define HW_MISC_IOTKIT_SYSCTL_H
>> +
>> +#include "hw/sysbus.h"
>> +
>> +#define TYPE_IOTKIT_SYSCTL "iotkit-sysctl"
>> +#define IOTKIT_SYSCTL(obj) OBJECT_CHECK(IoTKitSysCtl, (obj), \
>> +                                        TYPE_IOTKIT_SYSCTL)
>> +
>> +typedef struct IoTKitSysCtl {
>> +    /*< private >*/
>> +    SysBusDevice parent_obj;
>> +
>> +    /*< public >*/
>> +    MemoryRegion sysinfo_iomem;
>> +    MemoryRegion sysctl_iomem;
>> +
>> +    uint32_t secure_debug;
>> +    uint32_t reset_syndrome;
>> +    uint32_t reset_mask;
>> +    uint32_t gretreg;
>> +    uint32_t initsvrtor0;
>> +    uint32_t cpuwait;
>> +    uint32_t wicctrl;
>> +} IoTKitSysCtl;
>> +
>> +#endif
>> diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
>> new file mode 100644
>> index 00000000000..9445500be76
>> --- /dev/null
>> +++ b/hw/misc/iotkit-sysctl.c
>> @@ -0,0 +1,324 @@
>> +/*
>> + * ARM IoTKit system control element
>> + *
>> + * Copyright (c) 2018 Linaro Limited
>> + * Written by Peter Maydell
>> + *
>> + *  This program is free software; you can redistribute it and/or modif=
y
>> + *  it under the terms of the GNU General Public License version 2 or
>> + *  (at your option) any later version.
>> + */
>> +
>> +/*
>> + * This is a model of the "system control element" which is part of the
>> + * Arm IoTKit and documented in
>> + * http://infocenter.arm.com/help/index.jsp?topic=3D/com.arm.doc.ecm060=
1256/index.html
>> + * Specifically, it implements the "system information block" and
>> + * "system control register" blocks.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "trace.h"
>> +#include "qapi/error.h"
>> +#include "sysemu/sysemu.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/registerfields.h"
>> +#include "hw/misc/iotkit-sysctl.h"
>> +
>> +/* sysinfo block registers */
>> +REG32(SYS_VERSION, 0x0)
>> +REG32(SYS_CONFIG, 0x4)
>
> I find it a bit confuse to have the both SYSINFO/SYSCONTROL in the same
> "iotkit-sysctl" device. They share the same state but there is no
> particular need for it, then you need connect them as 2 different
> devices in iotkit_realize but they have the same name "iotkit-sysctl".
>
> Why not declare 2 different TypeInfo? I am probably missing what state
> they need to share.

You're right, they don't share anything internally. It just
seemed a bit unnecessary to have a device that implements
2 read-only registers and nothing else. It probably is better
to split them up, though.

>> +    /*
>> +     * Most of the state here has to do with control of reset and
>> +     * similar kinds of power up -- for instance the guest can ask
>> +     * what the reason for the last reset was, or forbid reset for
>> +     * some causes (like the non-secure watchdog). Most of this is
>> +     * not relevant to QEMU, which doesn't really model anything other
>> +     * than a full power-on reset.
>> +     * We just model the registers as reads-as-written.
>> +     */
>> +
>> +    switch (offset) {
>> +    case A_RESET_SYNDROME:
>> +        qemu_log_mask(LOG_UNIMP,
>> +                      "IoTKit SysCtl RESET_SYNDROME unimplemented\n");
>
> Maybe warn_report() or warn_once() is more appropriate than UNIMP?

LOG_UNIMP is what we generally use for warning about accesses
to unimplemented registers.


>> +    case A_SWRESET:
>> +        /* One w/o bit to request a reset; all other bits reserved */
>> +        if (value & R_SWRESET_SWRESETREQ_MASK) {
>> +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>> +        }
>
> Shouldn't this be:
>
>            } else {
>                cpu_reset(...);
>            }

Why? The register function is "write 1 to request a system reset".
Writing a zero does nothing.


>> +        break;
>> +    case A_BUSWAIT:        /* In IoTKit BUSWAIT is reserved, R/O, zero =
*/
>> +    case A_SECDBGSTAT:
>> +    case A_PID4 ... A_CID3:
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "IoTKit SysCtl write: write of RO offset %x\n",
>> +                      (int)offset);
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "IoTKit SysCtl write: bad offset %x\n", (int)offs=
et);
>> +        break;
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps iotkit_sysctl_ops =3D {
>> +    .read =3D iotkit_sysctl_read,
>> +    .write =3D iotkit_sysctl_write,
>> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>> +    /* byte/halfword accesses are just zero-padded on reads and writes =
*/
>> +    .impl.min_access_size =3D 4,
>> +    .impl.max_access_size =3D 4,
>> +    .valid.min_access_size =3D 1,
>> +    .valid.max_access_size =3D 4,
>> +};
>> +
>> +static void iotkit_sysctl_reset(DeviceState *dev)
>> +{
>> +    IoTKitSysCtl *s =3D IOTKIT_SYSCTL(dev);
>> +
>> +    trace_iotkit_sysctl_reset();
>> +    s->secure_debug =3D 0;
>> +    s->reset_syndrome =3D 1;
>> +    s->reset_mask =3D 0;
>> +    s->gretreg =3D 0;
>> +    s->initsvrtor0 =3D 0x10000000;
>
> This one could be a property (now now ;) ).

It could be, but given that we don't actually support letting
the guest change the SVRTOR reset value on the CPU for the
next reset I think that would be overkill.

>> +    s->cpuwait =3D 0;
>> +    s->wicctrl =3D 0;
>> +}

thanks
-- PMM
