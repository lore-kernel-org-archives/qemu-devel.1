Received: from eggs.gnu.org ([2001:4830:134:3::10]:33077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fELVw-0005od-6D
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fELVu-0002qk-Is
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:11:44 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:42876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fELVu-0002pO-6X
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:11:42 -0400
Received: by mail-lf0-x242.google.com with SMTP id u21-v6so28026146lfu.9
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 14:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-29-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-29-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 21:11:15 +0000
Message-ID: <CAKmqyKNe+CbGBJrQRTbc_1spe3w5X0cdmu-C44XW4K=vwKjzYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 28/35] RISC-V: Implement atomic mip/sip
 CSR updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, palmer@sifive.com, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On Wed, Apr 25, 2018 at 5:14 PM Michael Clark <mjc@sifive.com> wrote:

> Use the new CSR read/modify/write interface to implement
> atomic updates to mip/sip.

> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/riscv/csr.c | 56
+++++++++++++++++++++++++++---------------------------
>   1 file changed, 28 insertions(+), 28 deletions(-)

> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a424867..c704545 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -491,25 +491,31 @@ static int write_mbadaddr(CPURISCVState *env, int
csrno, target_ulong val)
>       return 0;
>   }

> -static int read_mip(CPURISCVState *env, int csrno, target_ulong *val)
> -{
> -    *val = atomic_read(&env->mip);
> -    return 0;
> -}
> -
> -static int write_mip(CPURISCVState *env, int csrno, target_ulong val)
> +static int rmw_mip(CPURISCVState *env, int csrno, target_ulong
*ret_value,
> +                   target_ulong new_value, target_ulong write_mask)
>   {
>       RISCVCPU *cpu = riscv_env_get_cpu(env);
> +    target_ulong mask = write_mask & delegable_ints;
> +    uint32_t old_mip;
> +
> +    /* We can't allow the supervisor to control SEIP as this would allow
the
> +     * supervisor to clear a pending external interrupt which will
result in
> +     * lost a interrupt in the case a PLIC is attached. The SEIP bit
must be
> +     * hardware controlled when a PLIC is attached. This should be an
option
> +     * for CPUs with software-delegated Supervisor External Interrupts.
*/
> +    mask &= ~MIP_SEIP;
> +
> +    if (mask) {
> +        qemu_mutex_lock_iothread();
> +        old_mip = riscv_cpu_update_mip(cpu, mask, (new_value & mask));
> +        qemu_mutex_unlock_iothread();
> +    } else {
> +        old_mip = atomic_read(&env->mip);
> +    }

> -    /*
> -     * csrs, csrc on mip.SEIP is not decomposable into separate read and
> -     * write steps, so a different implementation is needed
> -     */
> -
> -    qemu_mutex_lock_iothread();
> -    riscv_cpu_update_mip(cpu, MIP_SSIP | MIP_STIP,
> -                         (val & (MIP_SSIP | MIP_STIP)));
> -    qemu_mutex_unlock_iothread();
> +    if (ret_value) {
> +        *ret_value = old_mip;
> +    }

>       return 0;
>   }
> @@ -627,17 +633,11 @@ static int write_sbadaddr(CPURISCVState *env, int
csrno, target_ulong val)
>       return 0;
>   }

> -static int read_sip(CPURISCVState *env, int csrno, target_ulong *val)
> -{
> -    *val = atomic_read(&env->mip) & env->mideleg;
> -    return 0;
> -}
> -
> -static int write_sip(CPURISCVState *env, int csrno, target_ulong val)
> +static int rmw_sip(CPURISCVState *env, int csrno, target_ulong
*ret_value,
> +                   target_ulong new_value, target_ulong write_mask)
>   {
> -    target_ulong newval = (atomic_read(&env->mip) & ~env->mideleg)
> -                          | (val & env->mideleg);
> -    return write_mip(env, CSR_MIP, newval);
> +    return rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
> +                   write_mask & env->mideleg);
>   }

>   /* Supervisor Protection and Translation */
> @@ -819,7 +819,7 @@ static const riscv_csr_operations csr_ops[0xfff] = {
>       [CSR_MEPC] =                { read_mepc,        write_mepc        },
>       [CSR_MCAUSE] =              { read_mcause,      write_mcause      },
>       [CSR_MBADADDR] =            { read_mbadaddr,    write_mbadaddr    },
> -    [CSR_MIP] =                 { read_mip,         write_mip         },
> +    [CSR_MIP] =                 { NULL,     NULL,     rmw_mip         },

>       /* Supervisor Trap Setup */
>       [CSR_SSTATUS] =             { read_sstatus,     write_sstatus     },
> @@ -832,7 +832,7 @@ static const riscv_csr_operations csr_ops[0xfff] = {
>       [CSR_SEPC] =                { read_sepc,        write_sepc        },
>       [CSR_SCAUSE] =              { read_scause,      write_scause      },
>       [CSR_SBADADDR] =            { read_sbadaddr,    write_sbadaddr    },
> -    [CSR_SIP] =                 { read_sip,         write_sip         },
> +    [CSR_SIP] =                 { NULL,     NULL,     rmw_sip         },

>       /* Supervisor Protection and Translation */
>       [CSR_SATP] =                { read_satp,        write_satp        },
> --
> 2.7.0
