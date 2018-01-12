Received: from eggs.gnu.org ([2001:4830:134:3::10]:37850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1eZw7u-0006BJ-E2
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1eZw7r-0001K5-By
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:59:54 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:43009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <antonynpavlov@gmail.com>)
	id 1eZw7q-0001IN-W7
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:59:51 -0500
Received: by mail-lf0-x242.google.com with SMTP id o89so1199234lfg.10
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 01:59:50 -0800 (PST)
Date: Fri, 12 Jan 2018 13:13:58 +0300
From: Antony Pavlov <antonynpavlov@gmail.com>
Message-Id: <20180112131358.e0583463b979a5e81f489fd5@gmail.com>
In-Reply-To: <1515637324-96034-20-git-send-email-mjc@sifive.com>
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
	<1515637324-96034-20-git-send-email-mjc@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 19/21] SiFive Freedom E300 RISC-V Machine
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

On Wed, 10 Jan 2018 18:22:02 -0800
Michael Clark <mjc@sifive.com> wrote:

> This provides a RISC-V Board compatible with the the SiFive E300 SDK.
> The following machine is implemented:
>=20
> - 'sifive_e300'; CLINT, PLIC, UART, AON, GPIO, QSPI, PWM
>=20
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  hw/riscv/sifive_e300.c         | 232 +++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/riscv/sifive_e300.h |  79 ++++++++++++++
>  2 files changed, 311 insertions(+)
>  create mode 100644 hw/riscv/sifive_e300.c
>  create mode 100644 include/hw/riscv/sifive_e300.h
>=20
> diff --git a/hw/riscv/sifive_e300.c b/hw/riscv/sifive_e300.c
> new file mode 100644
> index 0000000..bbea55a
> --- /dev/null
> +++ b/hw/riscv/sifive_e300.c
> @@ -0,0 +1,232 @@
> +/*
> + * QEMU RISC-V Board Compatible with SiFive E300 SDK
> + *
> + * Copyright (c) 2017 SiFive, Inc.
> + *
> + * Provides a board compatible with the bsp in the SiFive E300 SDK:
> + *
> + * 0) UART
> + * 1) CLINT (Core Level Interruptor)
> + * 2) PLIC (Platform Level Interrupt Controller)
> + * 3) PRCI (Power, Reset, Clock, Interrupt)
> + * 4) Registers emulated as RAM: AON, GPIO, QSPI, PWM
> + * 5) Flash memory emulated as RAM
> + *
> + * The Mask ROM reset vector jumps to the flash payload at 0x2040_0000.
> + * The OTP ROM and Flash boot code will be emulated in a future version.
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
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "hw/hw.h"
> +#include "hw/boards.h"
> +#include "hw/loader.h"
> +#include "hw/sysbus.h"
> +#include "hw/char/serial.h"
> +#include "target/riscv/cpu.h"
> +#include "hw/riscv/riscv_hart.h"
> +#include "hw/riscv/sifive_plic.h"
> +#include "hw/riscv/sifive_clint.h"
> +#include "hw/riscv/sifive_prci.h"
> +#include "hw/riscv/sifive_uart.h"
> +#include "hw/riscv/sifive_e300.h"
> +#include "chardev/char.h"
> +#include "sysemu/arch_init.h"
> +#include "exec/address-spaces.h"
> +#include "elf.h"
> +
> +static const struct MemmapEntry {
> +    hwaddr base;
> +    hwaddr size;
> +} sifive_e300_memmap[] =3D {
> +    [SIFIVE_E300_DEBUG] =3D    {        0x0,      0x100 },
> +    [SIFIVE_E300_MROM] =3D     {     0x1000,     0x2000 },
> +    [SIFIVE_E300_OTP] =3D      {    0x20000,     0x2000 },
> +    [SIFIVE_E300_CLINT] =3D    {  0x2000000,    0x10000 },
> +    [SIFIVE_E300_PLIC] =3D     {  0xc000000,  0x4000000 },
> +    [SIFIVE_E300_AON] =3D      { 0x10000000,     0x8000 },
> +    [SIFIVE_E300_PRCI] =3D     { 0x10008000,     0x8000 },
> +    [SIFIVE_E300_OTP_CTRL] =3D { 0x10010000,     0x1000 },
> +    [SIFIVE_E300_GPIO0] =3D    { 0x10012000,     0x1000 },
> +    [SIFIVE_E300_UART0] =3D    { 0x10013000,     0x1000 },
> +    [SIFIVE_E300_QSPI0] =3D    { 0x10014000,     0x1000 },
> +    [SIFIVE_E300_PWM0] =3D     { 0x10015000,     0x1000 },
> +    [SIFIVE_E300_UART1] =3D    { 0x10023000,     0x1000 },
> +    [SIFIVE_E300_QSPI1] =3D    { 0x10024000,     0x1000 },
> +    [SIFIVE_E300_PWM1] =3D     { 0x10025000,     0x1000 },
> +    [SIFIVE_E300_QSPI2] =3D    { 0x10034000,     0x1000 },
> +    [SIFIVE_E300_PWM2] =3D     { 0x10035000,     0x1000 },
> +    [SIFIVE_E300_XIP] =3D      { 0x20000000, 0x20000000 },
> +    [SIFIVE_E300_DTIM] =3D     { 0x80000000,     0x4000 }
> +};
> +
> +static uint64_t identity_translate(void *opaque, uint64_t addr)
> +{
> +    return addr;
> +}
> +
> +static uint64_t load_kernel(const char *kernel_filename)
> +{
> +    uint64_t kernel_entry, kernel_high;
> +
> +    if (load_elf(kernel_filename, identity_translate, NULL,
> +                 &kernel_entry, NULL, &kernel_high,
> +                 /* little_endian =3D */ 0, ELF_MACHINE, 1, 0) < 0) {

"little_endian =3D" is misleading.
Actually it's "big_endian =3D 0".

The same comment is present in the U500 code.


--=20
Best regards,
=A0 Antony Pavlov
