Received: from eggs.gnu.org ([2001:4830:134:3::10]:60394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRlNY-0004Rf-LY
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 15:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRlNX-00047I-Jh
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 15:54:16 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:45083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRlNX-00046r-E5
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 15:54:15 -0500
Received: by mail-it0-x243.google.com with SMTP id z6so8239599iti.4
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 12:54:15 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20171220203528.21334-1-laurent@vivier.eu>
References: <20171220203528.21334-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 20 Dec 2017 17:54:13 -0300
Message-ID: <CAAdtpL73-1-vSqe+A59Tu_-tT-CSnVy0b1VbsAVSmGYVxBcALQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/m68k: add monitor.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Thomas Huth <huth@tuxfamily.org>

On Wed, Dec 20, 2017 at 5:35 PM, Laurent Vivier <laurent@vivier.eu> wrote:
> This allows to use registers content in the monitor.
>
> Example:
>
>  BEFORE:
>   (qemu) print $d0
>   unknown register
>
>  AFTER:
>   (qemu) print $d0
>   0
>   (qemu) print $sr
>   0x2000
>   (qemu) x/10i $pc
>   0x40010a2a:  movew %sr,%d0
>   0x40010a2c:  oril #1792,%d0
>   0x40010a32:  movew %d0,%sr
>   0x40010a34:  movel %a0@,%d0
>   0x40010a36:  btst #3,%d0
>   0x40010a3a:  beqs 0x40010a26
>   0x40010a3c:  movew %sr,%d0
>   0x40010a3e:  andil #63743,%d0
>   0x40010a44:  movew %d0,%sr
>   0x40010a46:  rts
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/Makefile.objs |  1 +
>  target/m68k/monitor.c     | 55 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 56 insertions(+)
>  create mode 100644 target/m68k/monitor.c
>
> diff --git a/target/m68k/Makefile.objs b/target/m68k/Makefile.objs
> index 39141ab93d..d143f20270 100644
> --- a/target/m68k/Makefile.objs
> +++ b/target/m68k/Makefile.objs
> @@ -1,3 +1,4 @@
>  obj-y +=3D m68k-semi.o
>  obj-y +=3D translate.o op_helper.o helper.o cpu.o fpu_helper.o
>  obj-y +=3D gdbstub.o
> +obj-$(CONFIG_SOFTMMU) +=3D monitor.o
> diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
> new file mode 100644
> index 0000000000..03d037ccab
> --- /dev/null
> +++ b/target/m68k/monitor.c
> @@ -0,0 +1,55 @@
> +/*
> + * QEMU monitor
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
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
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "monitor/hmp-target.h"
> +
> +const MonitorDef monitor_defs[] =3D {

adding 'static':
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> +    { "d0", offsetof(CPUM68KState, dregs[0]) },
> +    { "d1", offsetof(CPUM68KState, dregs[1]) },
> +    { "d2", offsetof(CPUM68KState, dregs[2]) },
> +    { "d3", offsetof(CPUM68KState, dregs[3]) },
> +    { "d4", offsetof(CPUM68KState, dregs[4]) },
> +    { "d5", offsetof(CPUM68KState, dregs[5]) },
> +    { "d6", offsetof(CPUM68KState, dregs[6]) },
> +    { "d7", offsetof(CPUM68KState, dregs[7]) },
> +    { "a0", offsetof(CPUM68KState, aregs[0]) },
> +    { "a1", offsetof(CPUM68KState, aregs[1]) },
> +    { "a2", offsetof(CPUM68KState, aregs[2]) },
> +    { "a3", offsetof(CPUM68KState, aregs[3]) },
> +    { "a4", offsetof(CPUM68KState, aregs[4]) },
> +    { "a5", offsetof(CPUM68KState, aregs[5]) },
> +    { "a6", offsetof(CPUM68KState, aregs[6]) },
> +    { "a7", offsetof(CPUM68KState, aregs[7]) },
> +    { "pc", offsetof(CPUM68KState, pc) },
> +    { "sr", offsetof(CPUM68KState, sr) },
> +    { "ssp", offsetof(CPUM68KState, sp[0]) },
> +    { "usp", offsetof(CPUM68KState, sp[1]) },
> +    { NULL },
> +};
> +
> +const MonitorDef *target_monitor_defs(void)
> +{
> +    return monitor_defs;
> +}
> --
> 2.14.3
>
