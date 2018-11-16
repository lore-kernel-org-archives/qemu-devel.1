Received: from eggs.gnu.org ([2001:4830:134:3::10]:36145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNgvK-0006en-I6
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:24:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNgvJ-0001Nr-5F
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:24:50 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNgvI-0001MC-EB
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:24:48 -0500
Received: by mail-oi1-x243.google.com with SMTP id c206so14546313oib.0
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 08:24:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181112214224.31560-6-contrib@steffen-goertz.de>
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
	<20181112214224.31560-6-contrib@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Nov 2018 16:24:24 +0000
Message-ID: <CAFEAcA_oxGQY6K4wQ3TTz1moa8rrXd=Hd3bcjE5NM2d=omn0YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 05/14] hw/nvram/nrf51_nvm: Add nRF51
 non-volatile memories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 12 November 2018 at 21:42, Steffen G=C3=B6rtz <contrib@steffen-goertz.de=
> wrote:
> The nRF51 contains three regions of non-volatile memory (NVM):
> - CODE (R/W): contains code
> - FICR (R): Factory information like code size, chip id etc.
> - UICR (R/W): Changeable configuration data. Lock bits, Code
>   protection configuration, Bootloader address, Nordic SoftRadio
>   configuration, Firmware configuration.
>
> Read and write access to the memories is managed by the
> Non-volatile memory controller.
>
> Memory schema:
>  [ CPU ] -+- [ NVM, either FICR, UICR or CODE ]
>           |      |
>           \- [ NVMC ]
>
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>

Hi; I have some comments on this patch, but they're mostly
fairly minor.

> ---
>  hw/nvram/Makefile.objs       |   1 +
>  hw/nvram/nrf51_nvm.c         | 378 +++++++++++++++++++++++++++++++++++
>  include/hw/nvram/nrf51_nvm.h |  64 ++++++
>  3 files changed, 443 insertions(+)
>  create mode 100644 hw/nvram/nrf51_nvm.c
>  create mode 100644 include/hw/nvram/nrf51_nvm.h
>
> diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
> index a912d25391..3f978e6212 100644
> --- a/hw/nvram/Makefile.objs
> +++ b/hw/nvram/Makefile.objs
> @@ -5,3 +5,4 @@ common-obj-y +=3D fw_cfg.o
>  common-obj-y +=3D chrp_nvram.o
>  common-obj-$(CONFIG_MAC_NVRAM) +=3D mac_nvram.o
>  obj-$(CONFIG_PSERIES) +=3D spapr_nvram.o
> +obj-$(CONFIG_NRF51_SOC) +=3D nrf51_nvm.o
> diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
> new file mode 100644
> index 0000000000..b3702ebe5e
> --- /dev/null
> +++ b/hw/nvram/nrf51_nvm.c
> @@ -0,0 +1,378 @@
> +/*
> + * Nordic Semiconductor nRF51 non-volatile memory
> + *
> + * It provides an interface to erase regions in flash memory.
> + * Furthermore it provides the user and factory information registers.
> + *
> + * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.=
pdf
> + *
> + * See nRF51 reference manual and product sheet sections:
> + * + Non-Volatile Memory Controller (NVMC)
> + * + Factory Information Configuration Registers (FICR)
> + * + User Information Configuration Registers (UICR)
> + *
> + * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "exec/address-spaces.h"
> +#include "hw/arm/nrf51.h"
> +#include "hw/nvram/nrf51_nvm.h"
> +
> +/*
> + * FICR Registers Assignments
> + * CODEPAGESIZE      0x010
> + * CODESIZE          0x014
> + * CLENR0            0x028
> + * PPFC              0x02C
> + * NUMRAMBLOCK       0x034
> + * SIZERAMBLOCKS     0x038
> + * SIZERAMBLOCK[0]   0x038
> + * SIZERAMBLOCK[1]   0x03C
> + * SIZERAMBLOCK[2]   0x040
> + * SIZERAMBLOCK[3]   0x044
> + * CONFIGID          0x05C
> + * DEVICEID[0]       0x060
> + * DEVICEID[1]       0x064
> + * ER[0]             0x080
> + * ER[1]             0x084
> + * ER[2]             0x088
> + * ER[3]             0x08C
> + * IR[0]             0x090
> + * IR[1]             0x094
> + * IR[2]             0x098
> + * IR[3]             0x09C
> + * DEVICEADDRTYPE    0x0A0
> + * DEVICEADDR[0]     0x0A4
> + * DEVICEADDR[1]     0x0A8
> + * OVERRIDEEN        0x0AC
> + * NRF_1MBIT[0]      0x0B0
> + * NRF_1MBIT[1]      0x0B4
> + * NRF_1MBIT[2]      0x0B8
> + * NRF_1MBIT[3]      0x0BC
> + * NRF_1MBIT[4]      0x0C0
> + * BLE_1MBIT[0]      0x0EC
> + * BLE_1MBIT[1]      0x0F0
> + * BLE_1MBIT[2]      0x0F4
> + * BLE_1MBIT[3]      0x0F8
> + * BLE_1MBIT[4]      0x0FC
> + */
> +static const uint32_t ficr_content[64] =3D {
> +    0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0x00000400,
> +    0x00000100, 0xFFFFFFFF, 0xFFFFFFFF, 0x00000002, 0x00002000,
> +    0x00002000, 0x00002000, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF,
> +    0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF,
> +    0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0x00000003,
> +    0x12345678, 0x9ABCDEF1, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF,
> +    0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF,
> +    0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF,
> +    0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF,
> +    0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF,
> +    0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF,
> +    0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF,
> +    0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF
> +};
> +
> +static uint64_t ficr_read(void *opaque, hwaddr offset, unsigned int size=
)
> +{
> +    assert(offset <=3D sizeof(ficr_content));

This should be "<", not "<=3D". If the offset is equal to
the size of the array then the access will be off the end.

> +    return ficr_content[offset / 4];
> +}
> +
> +static void ficr_write(void *opaque, hwaddr offset, uint64_t value,
> +        unsigned int size)
> +{
> +    /* Intentionally do nothing */
> +}

> +static uint64_t uicr_read(void *opaque, hwaddr offset, unsigned int size=
)
> +{
> +    NRF51NVMState *s =3D NRF51_NVM(opaque);
> +
> +    assert(offset <=3D sizeof(s->uicr_content));

Also "<".

> +    return s->uicr_content[offset / 4];
> +}
> +
> +static void uicr_write(void *opaque, hwaddr offset, uint64_t value,
> +        unsigned int size)
> +{
> +    NRF51NVMState *s =3D NRF51_NVM(opaque);
> +
> +    assert(offset <=3D sizeof(s->uicr_content));

Ditto.

> +    s->uicr_content[offset / 4] =3D value;
> +}
> +



> +static void io_write(void *opaque, hwaddr offset, uint64_t value,
> +        unsigned int size)
> +{
> +    NRF51NVMState *s =3D NRF51_NVM(opaque);
> +
> +    switch (offset) {
> +    case NRF51_NVMC_CONFIG:
> +        s->config =3D value & NRF51_NVMC_CONFIG_MASK;
> +        break;
> +    case NRF51_NVMC_ERASEPCR0:
> +    case NRF51_NVMC_ERASEPCR1:
> +        if (s->config & NRF51_NVMC_CONFIG_EEN) {
> +            /* Mask in-page sub address*/

Missing space before "*/".

> +            value &=3D ~(NRF51_PAGE_SIZE - 1);
> +            if (value < (s->flash_size - NRF51_PAGE_SIZE)) {
> +                memset(s->storage + value / 4, 0xFF, NRF51_PAGE_SIZE);

Can the guest try to execute from the flash storage? If so
then just updating the backing storage directly like this is
not sufficient to ensure that QEMU discards any now-stale
translated code blocks from the affected memory.

> +            }
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +            "%s: Flash erase at 0x%" HWADDR_PRIx" while flash not erasab=
le.\n",
> +            __func__, offset);
> +        }
> +        break;
> +    case NRF51_NVMC_ERASEALL:
> +        if (value =3D=3D NRF51_NVMC_ERASE) {
> +            if (s->config & NRF51_NVMC_CONFIG_EEN) {
> +                memset(s->storage, 0xFF, s->flash_size);
> +                memset(s->uicr_content, 0xFF, sizeof(s->uicr_content));
> +            } else {
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Flash not erasable.\=
n",
> +                              __func__);
> +            }
> +        }
> +        break;
> +    case NRF51_NVMC_ERASEUICR:
> +        if (value =3D=3D NRF51_NVMC_ERASE) {
> +            memset(s->uicr_content, 0xFF, sizeof(s->uicr_content));
> +        }
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "%s: bad write offset 0x%" HWADDR_PRIx "\n", __func__, o=
ffset);
> +    }
> +}
> +
> +static const MemoryRegionOps io_ops =3D {
> +        .read =3D io_read,
> +        .write =3D io_write,
> +        .impl.min_access_size =3D 4,
> +        .impl.max_access_size =3D 4,
> +        .endianness =3D DEVICE_LITTLE_ENDIAN,
> +};
> +
> +
> +static void flash_write(void *opaque, hwaddr offset, uint64_t value,
> +        unsigned int size)
> +{
> +    NRF51NVMState *s =3D NRF51_NVM(opaque);
> +
> +    if (s->config & NRF51_NVMC_CONFIG_WEN) {
> +        assert(offset <=3D s->flash_size);

"<".

> +        /* NOR Flash only allows bits to be flipped from 1's to 0's on w=
rite */
> +        s->storage[offset / 4] &=3D value;
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "%s: Flash write 0x%" HWADDR_PRIx" while flash not writa=
ble.\n",
> +                __func__, offset);
> +    }
> +}
> +
> +
> +
> +static const MemoryRegionOps flash_ops =3D {
> +    .write =3D flash_write,
> +    .valid.min_access_size =3D 4,
> +    .valid.max_access_size =3D 4,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void nrf51_nvm_init(Object *obj)
> +{
> +    NRF51NVMState *s =3D NRF51_NVM(obj);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &io_ops, s, "nrf51_soc.nvmc",
> +                          NRF51_NVMC_SIZE);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +
> +    memory_region_init_io(&s->ficr, NULL, &ficr_ops, s, "nrf51_soc.ficr"=
,
> +                          sizeof(ficr_content));

This call and the one below are the ones where the NULL second
argument should be "obj", as it is in the first call in
this function. This is what causes the "make check" failures
I mentioned in my reply to the series cover letter.

> +    sysbus_init_mmio(sbd, &s->ficr);
> +
> +    memset(s->uicr_content, 0xFF, sizeof(s->uicr_content));
> +    memory_region_init_io(&s->uicr, NULL, &uicr_ops, s, "nrf51_soc.uicr"=
,
> +                          sizeof(s->uicr_content));
> +    sysbus_init_mmio(sbd, &s->uicr);
> +}
> +
> +static void nrf51_nvm_realize(DeviceState *dev, Error **errp)
> +{
> +    NRF51NVMState *s =3D NRF51_NVM(dev);
> +    Error *err =3D NULL;
> +
> +    memory_region_init_rom_device(&s->flash, OBJECT(dev), &flash_ops, s,
> +        "nrf51_soc.flash", s->flash_size, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    s->storage =3D memory_region_get_ram_ptr(&s->flash);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->flash);
> +}
> +
> +static void nrf51_nvm_reset(DeviceState *dev)
> +{
> +    NRF51NVMState *s =3D NRF51_NVM(dev);
> +
> +    s->config =3D 0x00;

Shouldn't uicr_content[] and storage be reset too ?

> +}

thanks
-- PMM
