Received: from eggs.gnu.org ([2001:4830:134:3::10]:58806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXjbV-0006MA-Q7
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXjbT-0002Av-5d
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:45:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44568 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fXjbT-00029k-0F
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:45:35 -0400
References: <20180626081743.22097-1-contrib@steffen-goertz.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ebb85873-2440-5047-73a1-81c793a39f6d@redhat.com>
Date: Tue, 26 Jun 2018 10:45:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180626081743.22097-1-contrib@steffen-goertz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] arm: Add NRF51 SOC non-volatile memory
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>

On 26.06.2018 10:17, Steffen G=C3=B6rtz wrote:
[...]
> +static const MemoryRegionOps io_ops =3D { .read =3D io_read, .write =3D=
 io_write,
> +        .endianness =3D DEVICE_LITTLE_ENDIAN, };

Could you please put the entries on a separate line each? That would be
better readable.

> +static void nrf51_nvmc_init(Object *obj)
> +{
> +    Nrf51NVMCState *s =3D NRF51_NVMC(obj);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &io_ops, s,
> +    TYPE_NRF51_NVMC, NRF51_NVMC_SIZE);
Please indent the second line of the memory_region_init_io statement.

> +    sysbus_init_mmio(sbd, &s->mmio);
> +}
[...]
> diff --git a/include/hw/nvram/nrf51_nvmc.h b/include/hw/nvram/nrf51_nvm=
c.h
> new file mode 100644
> index 0000000000..dfd500b14e
> --- /dev/null
> +++ b/include/hw/nvram/nrf51_nvmc.h
> @@ -0,0 +1,52 @@
> +/*
> + * nrf51_nvmc.h
> + *
> + * Copyright 2018 Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + *
> + * See Nrf51 reference manual 6 Non-Volatile Memory Controller (NVMC)
> + * See Nrf51 product sheet 8.22 NVMC specifications
> + *
> + * QEMU interface:
> + * + sysbus MMIO regions 0: Memory Region with registers
> + *   to be mapped to the peripherals instance address by the SOC.
> + * + page_size property to set the page size in bytes.
> + * + code_size property to set the code size in number of pages.
> + *
> + * Accuracy of the peripheral model:
> + * + The NVMC is always ready, all requested erase operations succeed
> + *   immediately.
> + * + CONFIG.WEN and CONFIG.EEN flags can be written and read back
> + *   but are not evaluated to check whether a requested write/erase op=
eration
> + *   is legal.
> + * + Code regions (MPU configuration) are disregarded.
> + */
> +#ifndef NRF51_NVMC_H
> +#define NRF51_NVMC_H
> +
> +#include "hw/sysbus.h"
> +#include "qemu/timer.h"

Any reason for including timer.h here? If not, please drop that line.

> +#define TYPE_NRF51_NVMC "nrf51_soc.nvmc"
> +#define NRF51_NVMC(obj) OBJECT_CHECK(Nrf51NVMCState, (obj), TYPE_NRF51=
_NVMC)
> +
> +typedef struct Nrf51NVMCState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +
> +    uint32_t code_size;
> +    uint16_t page_size;
> +    uint8_t *empty_page;
> +    MemoryRegion *mr;
> +    AddressSpace as;
> +
> +    struct {
> +        uint32_t config:2;
> +    } state;
> +
> +} Nrf51NVMCState;
> +
> +
> +#endif

 Thomas
