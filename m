Received: from eggs.gnu.org ([209.51.188.92]:41689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMai1-0005UF-SF
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMahz-0001wk-Uf
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:06:49 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMahz-0001vc-Lh
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:06:47 -0400
Received: by mail-wr1-x444.google.com with SMTP id l2so8530911wrb.9
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 09:06:46 -0700 (PDT)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-6-ysato@users.sourceforge.jp>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190502143409.59600-6-ysato@users.sourceforge.jp>
Date: Fri, 03 May 2019 17:06:44 +0100
Message-ID: <87ftpv4j57.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v8 05/12] target/rx: Miscellaneous files
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
>  target/rx/gdbstub.c     | 112 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  target/rx/monitor.c     |  38 ++++++++++++++++
>  target/rx/Makefile.objs |  11 +++++
>  3 files changed, 161 insertions(+)
>  create mode 100644 target/rx/gdbstub.c
>  create mode 100644 target/rx/monitor.c
>  create mode 100644 target/rx/Makefile.objs
>
> diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
> new file mode 100644
> index 0000000000..d76ca52e82
> --- /dev/null
> +++ b/target/rx/gdbstub.c
> @@ -0,0 +1,112 @@
> +/*
> + * RX gdb server stub
> + *
> + * Copyright (c) 2019 Yoshinori Sato
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
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "exec/gdbstub.h"
> +
> +int rx_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    RXCPU *cpu =3D RXCPU(cs);
> +    CPURXState *env =3D &cpu->env;
> +
> +    switch (n) {
> +    case 0 ... 15:
> +        return gdb_get_regl(mem_buf, env->regs[n]);
> +    case 16:
> +        return gdb_get_regl(mem_buf, (env->psw_u) ? env->regs[0] : env->=
usp);
> +    case 17:
> +        return gdb_get_regl(mem_buf, (!env->psw_u) ? env->regs[0] : env-=
>isp);
> +    case 18:
> +        return gdb_get_regl(mem_buf, rx_cpu_pack_psw(env));
> +    case 19:
> +        return gdb_get_regl(mem_buf, env->pc);
> +    case 20:
> +        return gdb_get_regl(mem_buf, env->intb);
> +    case 21:
> +        return gdb_get_regl(mem_buf, env->bpsw);
> +    case 22:
> +        return gdb_get_regl(mem_buf, env->bpc);
> +    case 23:
> +        return gdb_get_regl(mem_buf, env->fintv);
> +    case 24:
> +        return gdb_get_regl(mem_buf, env->fpsw);
> +    case 25:
> +        return 0;
> +    }
> +    return 0;
> +}
> +
> +int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    RXCPU *cpu =3D RXCPU(cs);
> +    CPURXState *env =3D &cpu->env;
> +    uint32_t psw;
> +    switch (n) {
> +    case 0 ... 15:
> +        env->regs[n] =3D ldl_p(mem_buf);
> +        if (n =3D=3D 0) {
> +            if (env->psw_u) {
> +                env->usp =3D env->regs[0];
> +            } else {
> +                env->isp =3D env->regs[0];
> +            }
> +        }
> +        break;
> +    case 16:
> +        env->usp =3D ldl_p(mem_buf);
> +        if (env->psw_u) {
> +            env->regs[0] =3D ldl_p(mem_buf);
> +        }
> +        break;
> +    case 17:
> +        env->isp =3D ldl_p(mem_buf);
> +        if (!env->psw_u) {
> +            env->regs[0] =3D ldl_p(mem_buf);
> +        }
> +        break;
> +    case 18:
> +        psw =3D ldl_p(mem_buf);
> +        rx_cpu_unpack_psw(env, psw, 1);
> +        break;
> +    case 19:
> +        env->pc =3D ldl_p(mem_buf);
> +        break;
> +    case 20:
> +        env->intb =3D ldl_p(mem_buf);
> +        break;
> +    case 21:
> +        env->bpsw =3D ldl_p(mem_buf);
> +        break;
> +    case 22:
> +        env->bpc =3D ldl_p(mem_buf);
> +        break;
> +    case 23:
> +        env->fintv =3D ldl_p(mem_buf);
> +        break;
> +    case 24:
> +        env->fpsw =3D ldl_p(mem_buf);
> +        break;
> +    case 25:
> +        return 8;
> +    default:
> +        return 0;
> +    }
> +
> +    return 4;
> +}
> diff --git a/target/rx/monitor.c b/target/rx/monitor.c
> new file mode 100644
> index 0000000000..5d7a1e58b5
> --- /dev/null
> +++ b/target/rx/monitor.c
> @@ -0,0 +1,38 @@
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
> +#include "monitor/monitor.h"
> +#include "monitor/hmp-target.h"
> +#include "hmp.h"
> +
> +void hmp_info_tlb(Monitor *mon, const QDict *qdict)
> +{
> +    CPUArchState *env =3D mon_get_cpu_env();
> +
> +    if (!env) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +}
> diff --git a/target/rx/Makefile.objs b/target/rx/Makefile.objs
> new file mode 100644
> index 0000000000..f63e1ca43f
> --- /dev/null
> +++ b/target/rx/Makefile.objs
> @@ -0,0 +1,11 @@
> +obj-y +=3D translate.o op_helper.o helper.o cpu.o gdbstub.o disas.o
> +obj-$(CONFIG_SOFTMMU) +=3D monitor.o
> +
> +DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
> +
> +target/rx/decode.inc.c: \
> +  $(SRC_PATH)/target/rx/insns.decode $(DECODETREE)
> +	$(call quiet-command,\
> +	  $(PYTHON) $(DECODETREE) --varinsnwidth 32 -o $@ $<, "GEN",
> $(TARGET_DIR)$@)

This doesn't work for me:

  GEN     rx-softmmu/target/rx/decode.inc.c
error: (GetoptError('option --varinsnwidth not recognized', 'varinsnwidth')=
,)

So are you decode.inc.c stale from some work in progress version of
decodetree?

Also this stanza will be need to be introduced in patch 04 as the
disassembler needs its files.

> +
> +target/rx/translate.o: target/rx/decode.inc.c


--
Alex Benn=C3=A9e
