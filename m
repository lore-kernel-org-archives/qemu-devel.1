Received: from eggs.gnu.org ([2001:4830:134:3::10]:33206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ej4vg-0004P1-6U
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:13:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ej4va-00034X-Lf
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:13:04 -0500
MIME-Version: 1.0
In-Reply-To: <24dcdefa-51f6-c3c1-61a2-c0f3eff7a800@amsat.org>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-6-andrew.smirnov@gmail.com>
	<24dcdefa-51f6-c3c1-61a2-c0f3eff7a800@amsat.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 6 Feb 2018 07:12:48 -0800
Message-ID: <CAHQ1cqG6x8wNm8_B0X_OsE--KPAwPcxbBVc1cJYP9PHHLdZsbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 05/14] i.MX: Add code to emulate i.MX7
 SNVS IP-block
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

On Wed, Jan 31, 2018 at 9:10 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 01/15/2018 10:37 PM, Andrey Smirnov wrote:
>> Add code to emulate SNVS IP-block. Currently only the bits needed to
>> be able to emulate machine shutdown are implemented.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  hw/misc/Makefile.objs       |  1 +
>>  hw/misc/imx7_snvs.c         | 83 ++++++++++++++++++++++++++++++++++++++=
+++++++
>>  include/hw/misc/imx7_snvs.h | 35 +++++++++++++++++++
>>  3 files changed, 119 insertions(+)
>>  create mode 100644 hw/misc/imx7_snvs.c
>>  create mode 100644 include/hw/misc/imx7_snvs.h
>>
>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> index 4b2b705a6c..019886912c 100644
>> --- a/hw/misc/Makefile.objs
>> +++ b/hw/misc/Makefile.objs
>> @@ -35,6 +35,7 @@ obj-$(CONFIG_IMX) +=3D imx6_ccm.o
>>  obj-$(CONFIG_IMX) +=3D imx6_src.o
>>  obj-$(CONFIG_IMX) +=3D imx7_ccm.o
>>  obj-$(CONFIG_IMX) +=3D imx2_wdt.o
>> +obj-$(CONFIG_IMX) +=3D imx7_snvs.o
>>  obj-$(CONFIG_MILKYMIST) +=3D milkymist-hpdmc.o
>>  obj-$(CONFIG_MILKYMIST) +=3D milkymist-pfpu.o
>>  obj-$(CONFIG_MAINSTONE) +=3D mst_fpga.o
>> diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c
>> new file mode 100644
>> index 0000000000..670b9f4639
>> --- /dev/null
>> +++ b/hw/misc/imx7_snvs.c
>> @@ -0,0 +1,83 @@
>> +/*
>> + * IMX7 Secure Non-Volatile Storage
>> + *
>> + * Copyright (c) 2017, Impinj, Inc.
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
>> +#include "hw/misc/imx7_snvs.h"
>> +#include "qemu/log.h"
>> +#include "sysemu/sysemu.h"
>> +
>> +static uint64_t imx7_snvs_read(void *opaque, hwaddr offset, unsigned si=
ze)
>> +{
>> +    return 0;
>> +}
>> +
>> +static void imx7_snvs_write(void *opaque, hwaddr offset,
>> +                            uint64_t v, unsigned size)
>> +{
>> +    const uint32_t value =3D v;
>> +    const uint32_t mask  =3D SNVS_LPCR_TOP | SNVS_LPCR_DP_EN;
>> +
>> +    if (offset =3D=3D SNVS_LPCR && ((value & mask) =3D=3D mask)) {
>> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>> +    }
>> +}
>> +
>> +static const struct MemoryRegionOps imx7_snvs_ops =3D {
>> +    .read =3D imx7_snvs_read,
>
> Same here, you can remove the imx7_snvs_read() function since
> memory_region_dispatch_read() takes care of this and return 0.
>

Hmm, I don't think I agree both from reading code and trying this out.
Without .read callback the call chain ends up being the following
memory_region_dispatch_read() -> memory_region_dispatch_read1() ->
access_with_adjusted_size(..., memory_region_oldmmio_read_accessor,
...) -> memory_region_oldmmio_read_accessor() ->
mr->ops->old_mmio.read[ctz32(size)]() -> SEGFAULT

As much as I'd love to get rid of dummy .read callback, I don't see a
way to do that, unfortunately.

Thanks,
Andrey Smirnov
