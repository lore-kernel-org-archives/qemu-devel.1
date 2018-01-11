Received: from eggs.gnu.org ([2001:4830:134:3::10]:38609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1eZYei-00074D-Ek
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1eZYee-0000ZO-41
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:56:12 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:42627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <antonynpavlov@gmail.com>)
	id 1eZYed-0000Y2-N9
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:56:07 -0500
Received: by mail-lf0-x242.google.com with SMTP id e27so1860745lfb.9
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 00:56:07 -0800 (PST)
Date: Thu, 11 Jan 2018 12:10:14 +0300
From: Antony Pavlov <antonynpavlov@gmail.com>
Message-Id: <20180111121014.6b01caadff7d5fd4028953a1@gmail.com>
In-Reply-To: <1515637324-96034-15-git-send-email-mjc@sifive.com>
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
	<1515637324-96034-15-git-send-email-mjc@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 14/21] SiFive RISC-V PLIC Block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Wed, 10 Jan 2018 18:21:57 -0800
Michael Clark <mjc@sifive.com> wrote:

> The PLIC (Platform Level Interrupt Controller) device provides a
> parameterizable interrupt controller based on SiFive's PLIC specification.
>=20
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  hw/riscv/sifive_plic.c         | 554 +++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/riscv/sifive_plic.h |  91 +++++++
>  2 files changed, 645 insertions(+)
>  create mode 100644 hw/riscv/sifive_plic.c
>  create mode 100644 include/hw/riscv/sifive_plic.h
>=20

...

> diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_pli=
c.h
> new file mode 100644
> index 0000000..e1be499
> --- /dev/null
> +++ b/include/hw/riscv/sifive_plic.h
> @@ -0,0 +1,91 @@
> +/*
> + * SiFive PLIC (Platform Level Interrupt Controller) interface
> + *
> + * Copyright (c) 2017 SiFive, Inc.
> + *
> + * This provides a RISC-V PLIC device
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_SIFIVE_PLIC_H
> +#define HW_SIFIVE_PLIC_H
> +
> +#include "hw/irq.h"
> +
> +#define TYPE_SIFIVE_PLIC "riscv.sifive.plic"
> +
> +#define SIFIVE_PLIC(obj) \
> +    OBJECT_CHECK(SiFivePLICState, (obj), TYPE_SIFIVE_PLIC)
> +
> +typedef enum PLICMode {
> +    PLICMode_U,
> +    PLICMode_S,
> +    PLICMode_H,
> +    PLICMode_M
> +} PLICMode;
> +
> +typedef struct PLICAddr {
> +    uint32_t addrid;
> +    uint32_t hartid;
> +    PLICMode mode;
> +} PLICAddr;
> +
> +typedef struct SiFivePLICState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion mmio;
> +    uint32_t num_addrs;
> +    uint32_t bitfield_words;
> +    PLICAddr *addr_config;
> +    uint32_t *source_priority;
> +    uint32_t *target_priority;
> +    uint32_t *pending;
> +    uint32_t *claimed;
> +    uint32_t *enable;
> +    QemuMutex lock;
> +    qemu_irq *irqs;
> +
> +    /* config */
> +    char *hart_config;
> +    uint32_t num_sources;
> +    uint32_t num_priorities;
> +    uint32_t priority_base;
> +    uint32_t pending_base;
> +    uint32_t enable_base;
> +    uint32_t enable_stride;
> +    uint32_t context_base;
> +    uint32_t context_stride;
> +    uint32_t aperture_size;
> +} SiFivePLICState;
> +
> +void sifive_plic_raise_irq(SiFivePLICState *plic, uint32_t irq);
> +void sifive_plic_lower_irq(SiFivePLICState *plic, uint32_t irq);
> +
> +DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
> +    uint32_t num_sources, uint32_t num_priorities,
> +    uint32_t priority_base, uint32_t pending_base,
> +    uint32_t enable_base, uint32_t enable_stride,
> +    uint32_t context_base, uint32_t context_stride,
> +    uint32_t aperture_size);
> +
> +#endif
> +
> --=20
> 2.7.0

'git am' reports on 'new blank line at EOF' here (include/hw/riscv/sifive_p=
lic.h):

  Applying: SiFive RISC-V PLIC Block
  .git/rebase-apply/patch:664: new blank line at EOF.
  +
  warning: 1 line adds whitespace errors.

--=20
Best regards,
=A0 Antony Pavlov
