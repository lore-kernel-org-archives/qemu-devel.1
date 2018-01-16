Received: from eggs.gnu.org ([2001:4830:134:3::10]:38012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ebSoS-0001iL-BG
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ebSoR-0006l3-6U
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:06:08 -0500
MIME-Version: 1.0
In-Reply-To: <ebab631b-7d14-dd9a-8e81-e76830bfda02@amsat.org>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-9-andrew.smirnov@gmail.com>
	<ebab631b-7d14-dd9a-8e81-e76830bfda02@amsat.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 16 Jan 2018 07:05:58 -0800
Message-ID: <CAHQ1cqFKMoearUuvpEciu8ZnNbWQF1A8CR9KXL=sxRy0MVxGLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 08/14] i.MX: Add implementation of i.MX7
 GPR IP block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "open list:ARM" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Mon, Jan 15, 2018 at 8:45 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 01/15/2018 10:37 PM, Andrey Smirnov wrote:
>> Add minimal code needed to allow upstream Linux guest to boot.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  hw/misc/Makefile.objs      |   1 +
>>  hw/misc/imx7_gpr.c         | 119 ++++++++++++++++++++++++++++++++++++++=
+++++++
>>  include/hw/misc/imx7_gpr.h |  28 +++++++++++
>>  3 files changed, 148 insertions(+)
>>  create mode 100644 hw/misc/imx7_gpr.c
>>  create mode 100644 include/hw/misc/imx7_gpr.h
>>
>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> index 019886912c..fce426eb75 100644
>> --- a/hw/misc/Makefile.objs
>> +++ b/hw/misc/Makefile.objs
>> @@ -36,6 +36,7 @@ obj-$(CONFIG_IMX) +=3D imx6_src.o
>>  obj-$(CONFIG_IMX) +=3D imx7_ccm.o
>>  obj-$(CONFIG_IMX) +=3D imx2_wdt.o
>>  obj-$(CONFIG_IMX) +=3D imx7_snvs.o
>> +obj-$(CONFIG_IMX) +=3D imx7_gpr.o
>>  obj-$(CONFIG_MILKYMIST) +=3D milkymist-hpdmc.o
>>  obj-$(CONFIG_MILKYMIST) +=3D milkymist-pfpu.o
>>  obj-$(CONFIG_MAINSTONE) +=3D mst_fpga.o
>> diff --git a/hw/misc/imx7_gpr.c b/hw/misc/imx7_gpr.c
>> new file mode 100644
>> index 0000000000..9e8ccea9e8
>> --- /dev/null
>> +++ b/hw/misc/imx7_gpr.c
>> @@ -0,0 +1,119 @@
>> +/*
>> + * Copyright (c) 2017, Impinj, Inc.
>> + *
>> + * i.MX7 GPR IP block emulation code
>> + *
>> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + * Bare minimum emulation code needed to support being able to shut
>> + * down linux guest gracefully.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/misc/imx7_gpr.h"
>> +#include "qemu/log.h"
>> +#include "sysemu/sysemu.h"
>> +
>> +enum IMX7GPRRegisters {
>> +    IOMUXC_GPR0  =3D 0x00,
>> +    IOMUXC_GPR1  =3D 0x04,
>> +    IOMUXC_GPR2  =3D 0x08,
>> +    IOMUXC_GPR3  =3D 0x0c,
>> +    IOMUXC_GPR4  =3D 0x10,
>> +    IOMUXC_GPR5  =3D 0x14,
>> +    IOMUXC_GPR6  =3D 0x18,
>> +    IOMUXC_GPR7  =3D 0x1c,
>> +    IOMUXC_GPR8  =3D 0x20,
>> +    IOMUXC_GPR9  =3D 0x24,
>> +    IOMUXC_GPR10 =3D 0x28,
>> +    IOMUXC_GPR11 =3D 0x2c,
>> +    IOMUXC_GPR12 =3D 0x30,
>> +    IOMUXC_GPR13 =3D 0x34,
>> +    IOMUXC_GPR14 =3D 0x38,
>> +    IOMUXC_GPR15 =3D 0x3c,
>> +    IOMUXC_GPR16 =3D 0x40,
>> +    IOMUXC_GPR17 =3D 0x44,
>> +    IOMUXC_GPR18 =3D 0x48,
>> +    IOMUXC_GPR19 =3D 0x4c,
>> +    IOMUXC_GPR20 =3D 0x50,
>> +    IOMUXC_GPR21 =3D 0x54,
>> +    IOMUXC_GPR22 =3D 0x58,
>> +};
>> +
>> +#define IMX7D_GPR1_IRQ_MASK                 BIT(12)
>> +#define IMX7D_GPR1_ENET1_TX_CLK_SEL_MASK    BIT(13)
>> +#define IMX7D_GPR1_ENET2_TX_CLK_SEL_MASK    BIT(14)
>> +#define IMX7D_GPR1_ENET_TX_CLK_SEL_MASK     (0x3 << 13)
>> +#define IMX7D_GPR1_ENET1_CLK_DIR_MASK       BIT(17)
>> +#define IMX7D_GPR1_ENET2_CLK_DIR_MASK       BIT(18)
>> +#define IMX7D_GPR1_ENET_CLK_DIR_MASK        (0x3 << 17)
>> +
>> +#define IMX7D_GPR5_CSI_MUX_CONTROL_MIPI     BIT(4)
>> +#define IMX7D_GPR12_PCIE_PHY_REFCLK_SEL     BIT(5)
>> +#define IMX7D_GPR22_PCIE_PHY_PLL_LOCKED     BIT(31)
>> +
>> +
>> +static uint64_t imx7_gpr_read(void *opaque, hwaddr offset, unsigned siz=
e)
>> +{
>> +    if (offset =3D=3D IOMUXC_GPR22) {
>> +        return IMX7D_GPR22_PCIE_PHY_PLL_LOCKED;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void imx7_gpr_write(void *opaque, hwaddr offset,
>> +                           uint64_t v, unsigned size)
>> +{
>
> If you ever respin, please add a trace point here (just copy/paste from
> another file from the same directory), and in the read() function.
>
> Linux will evolve and use more registers from this device (and the other
> devices you are modelling), and a Linux driver busy loop is likely to
> hang QEMU. A trace event will ease your board next user soon :)
>

Sure, will do.

Thanks,
Andrey Smirnov
