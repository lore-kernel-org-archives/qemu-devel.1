Received: from eggs.gnu.org ([2001:4830:134:3::10]:37693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euHQQ-000322-7Y
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euHQN-0000Ic-3V
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:47:06 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euHQM-0000H4-SR
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 07:47:03 -0500
Received: by mail-wr0-x242.google.com with SMTP id z12so8897932wrg.4
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 04:47:02 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-8-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <588ce5d9-bce2-1703-3a83-50e8a2001ceb@amsat.org>
Date: Fri, 9 Mar 2018 13:46:59 +0100
MIME-Version: 1.0
In-Reply-To: <1519998711-73430-8-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 07/23] RISC-V GDB Stub
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
> GDB Register read and write routines.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/riscv/gdbstub.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 target/riscv/gdbstub.c
> 
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> new file mode 100644
> index 0000000..4f919b6
> --- /dev/null
> +++ b/target/riscv/gdbstub.c
> @@ -0,0 +1,62 @@
> +/*
> + * RISC-V GDB Server Stub
> + *
> + * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
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
> +#include "qemu-common.h"
> +#include "exec/gdbstub.h"
> +#include "cpu.h"
> +
> +int riscv_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +
> +    if (n < 32) {
> +        return gdb_get_regl(mem_buf, env->gpr[n]);
> +    } else if (n == 32) {
> +        return gdb_get_regl(mem_buf, env->pc);
> +    } else if (n < 65) {
> +        return gdb_get_reg64(mem_buf, env->fpr[n - 33]);
> +    } else if (n < 4096 + 65) {
> +        return gdb_get_regl(mem_buf, csr_read_helper(env, n - 65));
> +    }
> +    return 0;
> +}
> +
> +int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +
> +    if (n == 0) {
> +        /* discard writes to x0 */
> +        return sizeof(target_ulong);
> +    } else if (n < 32) {
> +        env->gpr[n] = ldtul_p(mem_buf);
> +        return sizeof(target_ulong);
> +    } else if (n == 32) {
> +        env->pc = ldtul_p(mem_buf);
> +        return sizeof(target_ulong);
> +    } else if (n < 65) {
> +        env->fpr[n - 33] = ldq_p(mem_buf); /* always 64-bit */
> +        return sizeof(uint64_t);
> +    } else if (n < 4096 + 65) {
> +        csr_write_helper(env, ldtul_p(mem_buf), n - 65);
> +    }
> +    return 0;
> +}
> 
