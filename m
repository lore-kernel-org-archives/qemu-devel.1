Received: from eggs.gnu.org ([209.51.188.92]:38324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaVk-00054c-CC
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaVi-0006Jz-P4
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:54:08 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMaVi-0006Hu-GD
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:54:06 -0400
Received: by mail-wr1-x442.google.com with SMTP id a9so8488846wrp.6
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:54:06 -0700 (PDT)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-5-ysato@users.sourceforge.jp>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190502143409.59600-5-ysato@users.sourceforge.jp>
Date: Fri, 03 May 2019 16:54:03 +0100
Message-ID: <87h8ab4jqc.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v8 04/12] target/rx: RX disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>


Yoshinori Sato <ysato@users.sourceforge.jp> writes:

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/disas/dis-asm.h |    5 +
>  target/rx/disas.c       | 1481 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 1486 insertions(+)
>  create mode 100644 target/rx/disas.c
>
> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
> index 9240ec32c2..de17792e88 100644
> --- a/include/disas/dis-asm.h
> +++ b/include/disas/dis-asm.h
> @@ -226,6 +226,10 @@ enum bfd_architecture
>  #define bfd_mach_nios2r2        2
>    bfd_arch_lm32,       /* Lattice Mico32 */
>  #define bfd_mach_lm32 1
> +  bfd_arch_rx,       /* Renesas RX */
> +#define bfd_mach_rx            0x75
> +#define bfd_mach_rx_v2         0x76
> +#define bfd_mach_rx_v3         0x77
>    bfd_arch_last
>    };
>  #define bfd_mach_s390_31 31
> @@ -433,6 +437,7 @@ int print_insn_little_nios2     (bfd_vma, disassemble=
_info*);
>  int print_insn_xtensa           (bfd_vma, disassemble_info*);
>  int print_insn_riscv32          (bfd_vma, disassemble_info*);
>  int print_insn_riscv64          (bfd_vma, disassemble_info*);
> +int print_insn_rx(bfd_vma, disassemble_info *);
>
>  #if 0
>  /* Fetch the disassembler for a given BFD, if that support is available.=
  */
> diff --git a/target/rx/disas.c b/target/rx/disas.c
> new file mode 100644
> index 0000000000..014fadfca3
> --- /dev/null
> +++ b/target/rx/disas.c
> @@ -0,0 +1,1481 @@
> +/*
> + * Renesas RX Disassembler
> + *
> + * Copyright (c) 2019 Yoshinori Sato <ysato@users.sourceforge.jp>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "disas/dis-asm.h"
> +#include "qemu/bitops.h"
> +#include "cpu.h"
> +
> +typedef struct DisasContext {
> +    disassemble_info *dis;
> +    uint32_t addr;
> +    uint32_t pc;
> +} DisasContext;
> +
> +
> +static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
> +                           int i, int n)
> +{
> +    bfd_byte buf;
> +    while (++i <=3D n) {
> +        ctx->dis->read_memory_func(ctx->addr++, &buf, 1, ctx->dis);
> +        insn |=3D buf << (32 - i * 8);
> +    }
> +    return insn;
> +}
> +
> +static int32_t li(DisasContext *ctx, int sz)
> +{
> +    int32_t addr;
> +    bfd_byte buf[4];
> +    addr =3D ctx->addr;
> +
> +    switch (sz) {
> +    case 1:
> +        ctx->addr +=3D 1;
> +        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
> +        return buf[0];
> +    case 2:
> +        ctx->addr +=3D 2;
> +        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
> +        return buf[1] << 8 | buf[0];
> +    case 3:
> +        ctx->addr +=3D 3;
> +        ctx->dis->read_memory_func(addr, buf, 3, ctx->dis);
> +        return buf[2] << 16 | buf[1] << 8 | buf[0];
> +    case 0:
> +        ctx->addr +=3D 4;
> +        ctx->dis->read_memory_func(addr, buf, 4, ctx->dis);
> +        return buf[3] << 24 | buf[2] << 16 | buf[1] << 8 | buf[0];
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static int bdsp_s(DisasContext *ctx, int d)
> +{
> +    /*
> +     * 0 -> 8
> +     * 1 -> 9
> +     * 2 -> 10
> +     * 3 -> 3
> +     * :
> +     * 7 -> 7
> +     */
> +    if (d < 3) {
> +        d +=3D 8;
> +    }
> +    return d;
> +}
> +
> +/* Include the auto-generated decoder.  */
> +#include "decode.inc.c"

This introduces a dependency on a generated file so you'll need:

target/rx/disas.o: target/rx/decode.inc.c

in Makefile.objs

--
Alex Benn=C3=A9e
