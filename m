Received: from eggs.gnu.org ([2001:4830:134:3::10]:56470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euGeJ-0006E2-4f
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euGeF-0006lK-8l
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:57:23 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euGeE-0006l2-Vg
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:57:19 -0500
Received: by mail-wm0-x242.google.com with SMTP id 188so3446536wme.1
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 03:57:18 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-18-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6dadb40f-3adc-a985-c355-8fb12efc482b@amsat.org>
Date: Fri, 9 Mar 2018 12:57:16 +0100
MIME-Version: 1.0
In-Reply-To: <1519998711-73430-18-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 17/23] SiFive RISC-V Test Finisher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 03/02/2018 02:51 PM, Michael Clark wrote:
> Test finisher memory mapped device used to exit simulation.
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  hw/riscv/sifive_test.c         | 93 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/sifive_test.h | 42 +++++++++++++++++++
>  2 files changed, 135 insertions(+)
>  create mode 100644 hw/riscv/sifive_test.c
>  create mode 100644 include/hw/riscv/sifive_test.h
> 
> diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> new file mode 100644
> index 0000000..8abd2cd
> --- /dev/null
> +++ b/hw/riscv/sifive_test.c
> @@ -0,0 +1,93 @@
> +/*
> + * QEMU SiFive Test Finisher
> + *
> + * Copyright (c) 2018 SiFive, Inc.
> + *
> + * Test finisher memory mapped device used to exit simulation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "target/riscv/cpu.h"
> +#include "hw/riscv/sifive_test.h"
> +
> +static uint64_t sifive_test_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    return 0;
> +}
> +
> +static void sifive_test_write(void *opaque, hwaddr addr,
> +           uint64_t val64, unsigned int size)
> +{
> +    if (addr == 0) {
> +        int status = val64 & 0xffff;
> +        int code = (val64 >> 16) & 0xffff;
> +        switch (status) {
> +        case FINISHER_FAIL:
> +            exit(code);
> +        case FINISHER_PASS:
> +            exit(0);
> +        default:
> +            break;
> +        }
> +    }
> +    hw_error("%s: write: addr=0x%x val=0x%016" PRIx64 "\n",
> +        __func__, (int)addr, val64);
> +}
> +
> +static const MemoryRegionOps sifive_test_ops = {
> +    .read = sifive_test_read,
> +    .write = sifive_test_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4
> +    }
> +};
> +
> +static void sifive_test_init(Object *obj)
> +{
> +    SiFiveTestState *s = SIFIVE_TEST(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &sifive_test_ops, s,
> +                          TYPE_SIFIVE_TEST, 0x1000);

0x1000? 0x8 is enough :)

> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +
> +static const TypeInfo sifive_test_info = {
> +    .name          = TYPE_SIFIVE_TEST,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(SiFiveTestState),
> +    .instance_init = sifive_test_init,
> +};
> +
> +static void sifive_test_register_types(void)
> +{
> +    type_register_static(&sifive_test_info);
> +}
> +
> +type_init(sifive_test_register_types)
> +
> +
> +/*
> + * Create Test device.
> + */
> +DeviceState *sifive_test_create(hwaddr addr)
> +{
> +    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_TEST);
> +    qdev_init_nofail(dev);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> +    return dev;
> +}
> diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_test.h
> new file mode 100644
> index 0000000..71d4c9f
> --- /dev/null
> +++ b/include/hw/riscv/sifive_test.h
> @@ -0,0 +1,42 @@
> +/*
> + * QEMU Test Finisher interface
> + *
> + * Copyright (c) 2018 SiFive, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_SIFIVE_TEST_H
> +#define HW_SIFIVE_TEST_H
> +
> +#define TYPE_SIFIVE_TEST "riscv.sifive.test"
> +
> +#define SIFIVE_TEST(obj) \
> +    OBJECT_CHECK(SiFiveTestState, (obj), TYPE_SIFIVE_TEST)
> +
> +typedef struct SiFiveTestState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion mmio;
> +} SiFiveTestState;
> +
> +enum {
> +    FINISHER_FAIL = 0x3333,
> +    FINISHER_PASS = 0x5555
> +};
> +
> +DeviceState *sifive_test_create(hwaddr addr);
> +
> +#endif
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
