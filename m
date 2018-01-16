Received: from eggs.gnu.org ([2001:4830:134:3::10]:37624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ebSn4-0000MR-4i
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:04:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ebSmy-0005xO-9W
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:04:42 -0500
MIME-Version: 1.0
In-Reply-To: <b085a18b-84f4-6695-f664-c146ece47eee@amsat.org>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-12-andrew.smirnov@gmail.com>
	<b085a18b-84f4-6695-f664-c146ece47eee@amsat.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 16 Jan 2018 07:04:20 -0800
Message-ID: <CAHQ1cqGtN+dvSP_q2QXRJ7wAwBZNGzVkpG3Zd9KS87OHkL7n5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 11/14] ARM: Add basic code to emulate
 A7MPCore DAP block
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

On Mon, Jan 15, 2018 at 8:32 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Hi Andrey,
>
> On 01/15/2018 10:37 PM, Andrey Smirnov wrote:
>> Add minimal code to emulate A7MPCore DAP block needed to boot Linux
>> guest.
>
> I was not aware the DAP is accessed by upstream Linux...
>
> You sure this isn't rather part of some bootloader built-in self-test?
>

Yes, I am positive:

a) I don't run any bootloader and boot directly into Linux, so it's
just physically impossible
b) Here's the code:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/hwtracing/coresight?h=3Dv4.15-rc8


>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  hw/arm/Makefile.objs       |   2 +-
>>  hw/arm/coresight.c         | 120 ++++++++++++++++++++++++++++++++++++++=
+++++++
>>  include/hw/arm/coresight.h |  24 +++++++++
>>  3 files changed, 145 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/arm/coresight.c
>>  create mode 100644 include/hw/arm/coresight.h
>>
>> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
>> index 2794e086d6..692216e0cf 100644
>> --- a/hw/arm/Makefile.objs
>> +++ b/hw/arm/Makefile.objs
>> @@ -1,4 +1,4 @@
>> -obj-y +=3D boot.o collie.o exynos4_boards.o gumstix.o highbank.o
>> +obj-y +=3D boot.o collie.o exynos4_boards.o gumstix.o highbank.o coresi=
ght.o
>>  obj-$(CONFIG_DIGIC) +=3D digic_boards.o
>>  obj-y +=3D integratorcp.o mainstone.o musicpal.o nseries.o
>>  obj-y +=3D omap_sx1.o palm.o realview.o spitz.o stellaris.o
>> diff --git a/hw/arm/coresight.c b/hw/arm/coresight.c
>> new file mode 100644
>> index 0000000000..d0a8c1b005
>> --- /dev/null
>> +++ b/hw/arm/coresight.c
>> @@ -0,0 +1,120 @@
>> +/*
>> + * Copyright (c) 2017, Impinj, Inc.
>> + *
>> + * CoreSight block emulation code
>> + *
>> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/arm/coresight.h"
>> +#include "qemu/log.h"
>> +
>> +static uint64_t coresight_read(void *opaque, hwaddr offset,
>> +                               unsigned size)
>> +{
>> +    return 0;
>> +}
>> +
>> +static void coresight_write(void *opaque, hwaddr offset,
>> +                            uint64_t value, unsigned size)
>> +{
>> +}
>
> I assume you had to add this to bypass the memory_transaction_failures
> check.
>
>> +
>> +static const struct MemoryRegionOps coresight_ops =3D {
>> +    .read =3D coresight_read,
>> +    .write =3D coresight_write,
>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +    .impl =3D {
>> +        /*
>> +         * Our device would not work correctly if the guest was doing
>> +         * unaligned access. This might not be a limitation on the real
>> +         * device but in practice there is no reason for a guest to acc=
ess
>> +         * this device unaligned.
>> +         */
>> +        .min_access_size =3D 4,
>> +        .max_access_size =3D 4,
>> +        .unaligned =3D false,
>> +    },
>> +};
>> +
>> +static void a7mpcore_dap_init(Object *obj)
>> +{
>> +    SysBusDevice *sd =3D SYS_BUS_DEVICE(obj);
>> +    A7MPCoreDAPState *s =3D A7MPCORE_DAP(obj);
>> +
>> +    memory_region_init(&s->container, obj, "a7mpcore-dap-container", 0x=
100000);
>
> You can just use add this in fsl_imx7_realize():
>
>   create_unimplemented_device("a7mpcore-dap-container",
>                               FSL_IMX7_A7MPCORE_DAP_ADDR,
>                               0x100000);
>
> to register a background region for the DAP (see "hw/misc/unimp.h")
>
> as a bonus, running with "-d unimp" you can trace the DAP access.
>
> So this model and those files are not necessary.
>

I am aware of create_unimplemented_device(), my reasoning for keeping
this code as a standalone class was to make it reusable for other
systems while providing more granular mapping (not just covering the
whole 0x100000 bytes of memory). I'll convert the code to use
create_unimplemented_device() since we now have two votes in favor of
it.

Thanks,
Andrey Smirnov
