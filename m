Received: from eggs.gnu.org ([2001:4830:134:3::10]:51157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euUky-0005dk-I5
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 22:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euUkw-0004kI-6v
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 22:01:12 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:36557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1euUkv-0004k8-Un
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 22:01:10 -0500
Received: by mail-ot0-x243.google.com with SMTP id 108so10510854otv.3
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 19:01:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6dadb40f-3adc-a985-c355-8fb12efc482b@amsat.org>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-18-git-send-email-mjc@sifive.com>
	<6dadb40f-3adc-a985-c355-8fb12efc482b@amsat.org>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 10 Mar 2018 16:01:08 +1300
Message-ID: <CAHNT7NtdV=8MoCWKvsGts-7ZS7cqoXdAZkmAngiDJv-w0efcfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 17/23] SiFive RISC-V Test Finisher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Sat, Mar 10, 2018 at 12:57 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org>
wrote:

> On 03/02/2018 02:51 PM, Michael Clark wrote:
> > Test finisher memory mapped device used to exit simulation.
> >
> > Acked-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > ---
> >  hw/riscv/sifive_test.c         | 93 ++++++++++++++++++++++++++++++
> ++++++++++++
> >  include/hw/riscv/sifive_test.h | 42 +++++++++++++++++++
> >  2 files changed, 135 insertions(+)
> >  create mode 100644 hw/riscv/sifive_test.c
> >  create mode 100644 include/hw/riscv/sifive_test.h
> >
> > diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> > new file mode 100644
> > index 0000000..8abd2cd
> > --- /dev/null
> > +++ b/hw/riscv/sifive_test.c
> > @@ -0,0 +1,93 @@
> > +/*
> > + * QEMU SiFive Test Finisher
> > + *
> > + * Copyright (c) 2018 SiFive, Inc.
> > + *
> > + * Test finisher memory mapped device used to exit simulation
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2 or later, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but
> WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> along with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/sysbus.h"
> > +#include "target/riscv/cpu.h"
> > +#include "hw/riscv/sifive_test.h"
> > +
> > +static uint64_t sifive_test_read(void *opaque, hwaddr addr, unsigned
> int size)
> > +{
> > +    return 0;
> > +}
> > +
> > +static void sifive_test_write(void *opaque, hwaddr addr,
> > +           uint64_t val64, unsigned int size)
> > +{
> > +    if (addr =3D=3D 0) {
> > +        int status =3D val64 & 0xffff;
> > +        int code =3D (val64 >> 16) & 0xffff;
> > +        switch (status) {
> > +        case FINISHER_FAIL:
> > +            exit(code);
> > +        case FINISHER_PASS:
> > +            exit(0);
> > +        default:
> > +            break;
> > +        }
> > +    }
> > +    hw_error("%s: write: addr=3D0x%x val=3D0x%016" PRIx64 "\n",
> > +        __func__, (int)addr, val64);
> > +}
> > +
> > +static const MemoryRegionOps sifive_test_ops =3D {
> > +    .read =3D sifive_test_read,
> > +    .write =3D sifive_test_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4
> > +    }
> > +};
> > +
> > +static void sifive_test_init(Object *obj)
> > +{
> > +    SiFiveTestState *s =3D SIFIVE_TEST(obj);
> > +
> > +    memory_region_init_io(&s->mmio, obj, &sifive_test_ops, s,
> > +                          TYPE_SIFIVE_TEST, 0x1000);
>
> 0x1000? 0x8 is enough :)
>
>
In this case we were following the aperture size of SiFive's test finisher.
See the device tree here. 0x4000 is the offset, 0x1000 is the length.

L20: teststatus@4000 {
compatible =3D "sifive,test0";
reg =3D <0x0 0x4000 0x0 0x1000>;
reg-names =3D "control";
};

I can change it to 8 and it will still work. There should probably be a
SIFIVE_TEST_APERTURE_SIZE constant (perhaps something a little shorter).

BTW We used the test finisher because the firmware we have already knows
how to use it to shutdown a device in the SBI (Supervisor Binary Interface)
sbi_shutdown() method.

Apparently there is a generic device-tree mechanism of passing a reference
to a GPIO node for shutdown and a GPIO node for reset, that is recognised
by Linux Kernel device-tree code. When we have GPIOs we may change the
method to use the standard Linux mechanism.

> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> > +}
> > +
> > +static const TypeInfo sifive_test_info =3D {
> > +    .name          =3D TYPE_SIFIVE_TEST,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(SiFiveTestState),
> > +    .instance_init =3D sifive_test_init,
> > +};
> > +
> > +static void sifive_test_register_types(void)
> > +{
> > +    type_register_static(&sifive_test_info);
> > +}
> > +
> > +type_init(sifive_test_register_types)
> > +
> > +
> > +/*
> > + * Create Test device.
> > + */
> > +DeviceState *sifive_test_create(hwaddr addr)
> > +{
> > +    DeviceState *dev =3D qdev_create(NULL, TYPE_SIFIVE_TEST);
> > +    qdev_init_nofail(dev);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> > +    return dev;
> > +}
> > diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_
> test.h
> > new file mode 100644
> > index 0000000..71d4c9f
> > --- /dev/null
> > +++ b/include/hw/riscv/sifive_test.h
> > @@ -0,0 +1,42 @@
> > +/*
> > + * QEMU Test Finisher interface
> > + *
> > + * Copyright (c) 2018 SiFive, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2 or later, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but
> WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> along with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef HW_SIFIVE_TEST_H
> > +#define HW_SIFIVE_TEST_H
> > +
> > +#define TYPE_SIFIVE_TEST "riscv.sifive.test"
> > +
> > +#define SIFIVE_TEST(obj) \
> > +    OBJECT_CHECK(SiFiveTestState, (obj), TYPE_SIFIVE_TEST)
> > +
> > +typedef struct SiFiveTestState {
> > +    /*< private >*/
> > +    SysBusDevice parent_obj;
> > +
> > +    /*< public >*/
> > +    MemoryRegion mmio;
> > +} SiFiveTestState;
> > +
> > +enum {
> > +    FINISHER_FAIL =3D 0x3333,
> > +    FINISHER_PASS =3D 0x5555
> > +};
> > +
> > +DeviceState *sifive_test_create(hwaddr addr);
> > +
> > +#endif
> >
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
