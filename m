Received: from eggs.gnu.org ([2001:4830:134:3::10]:38060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHadU-0002KY-7V
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 14:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHadS-0003m6-VZ
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 14:24:40 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8WbQobHPT8jZy6bnR9_wtmZ0ogJmmWo13_-StuDxXUWw@mail.gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-31-andrew.smirnov@gmail.com>
	<CAFEAcA8WbQobHPT8jZy6bnR9_wtmZ0ogJmmWo13_-StuDxXUWw@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 22 Nov 2017 11:24:34 -0800
Message-ID: <CAHQ1cqFJ=qGaLtHAp4cDYW_XBqJC5BUwZtOZmrYR9NiVKuxKow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 30/30] Implement support for i.MX7 Sabre
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Tue, Nov 21, 2017 at 10:22 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 6 November 2017 at 15:48, Andrey Smirnov <andrew.smirnov@gmail.com> wr=
ote:
>> Implement code needed to set up emulation of MCIMX7SABRE board from
>> NXP. For more info about the HW see:
>>
>> https://www.nxp.com/support/developer-resources/hardware-development-too=
ls/sabre-development-system/sabre-board-for-smart-devices-based-on-the-i.mx=
-7dual-applications-processors:MCIMX7SABRE
>
> You could put this URL in a comment in the code as well.
>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  hw/arm/Makefile.objs   |   2 +-
>>  hw/arm/mcimx7d-sabre.c | 101 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 102 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/arm/mcimx7d-sabre.c
>>
>> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
>> index f379ddc74b..eb6f6c5997 100644
>> --- a/hw/arm/Makefile.objs
>> +++ b/hw/arm/Makefile.objs
>> @@ -19,5 +19,5 @@ obj-$(CONFIG_FSL_IMX31) +=3D fsl-imx31.o kzm.o
>>  obj-$(CONFIG_FSL_IMX6) +=3D fsl-imx6.o sabrelite.o
>>  obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_soc.o aspeed.o
>>  obj-$(CONFIG_MPS2) +=3D mps2.o
>> -obj-$(CONFIG_FSL_IMX7) +=3D fsl-imx7.o
>> +obj-$(CONFIG_FSL_IMX7) +=3D fsl-imx7.o mcimx7d-sabre.o
>>
>> diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
>> new file mode 100644
>> index 0000000000..7ca8e668e8
>> --- /dev/null
>> +++ b/hw/arm/mcimx7d-sabre.c
>> @@ -0,0 +1,101 @@
>> +/*
>> + * Copyright (c) 2017, Impinj, Inc.
>> + *
>> + * MCIMX7D_SABRE Board System emulation.
>> + *
>> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
>> + *
>> + * This code is licensed under the GPL, version 2 or later.
>> + * See the file `COPYING' in the top level directory.
>> + *
>> + * It (partially) emulates a mcimx7d_sabre board, with a Freescale
>> + * i.MX7 SoC
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qemu-common.h"
>> +#include "hw/arm/fsl-imx7.h"
>> +#include "hw/boards.h"
>> +#include "sysemu/sysemu.h"
>> +#include "sysemu/device_tree.h"
>> +#include "qemu/error-report.h"
>> +#include "sysemu/qtest.h"
>> +#include "net/net.h"
>> +
>> +typedef struct {
>> +    FslIMX7State soc;
>> +    MemoryRegion ram;
>> +} MCIMX7Sabre;
>> +
>> +static void mcimx7d_add_psci_node(const struct arm_boot_info *boot_info=
,
>> +                                  void *fdt)
>> +{
>> +    const char comp[] =3D "arm,psci-0.2\0arm,psci";
>> +
>> +    qemu_fdt_add_subnode(fdt, "/psci");
>> +    qemu_fdt_setprop(fdt, "/psci", "compatible", comp, sizeof(comp));
>> +    qemu_fdt_setprop_string(fdt, "/psci", "method", "smc");
>> +}
>
> I'm still unconvinced by this (none of the other i.mx boards we have
> have anything like it).

None of the other boards are both SMP capable and support SMP in
upstream Linux only through PSCI (as it the case for i.MX7), so
comparing against the precedent is not very helpful.

> How does the real hardware boot SMP ?
>

Real hardware executes a bootloader which is expected to implement
PSCI and do the DTB fixup as I implemented above.

Thanks,
Andrey Smirnov
