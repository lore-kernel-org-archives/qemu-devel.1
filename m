Received: from eggs.gnu.org ([2001:4830:134:3::10]:40918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fELfS-00055J-Vl
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fELfR-0004d8-7P
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:21:35 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fELfQ-0004b4-Q0
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:21:33 -0400
Received: by mail-lf0-x242.google.com with SMTP id w8-v6so28089508lfe.3
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 14:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-30-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-30-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 21:21:05 +0000
Message-ID: <CAKmqyKOYb6GbpxMYTJ2NQ-yDNC7PTWDLDZjg5k9SMswVS559rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 29/35] RISC-V: Implement existential
 predicates for CSRs
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

On Wed, Apr 25, 2018 at 5:05 PM Michael Clark <mjc@sifive.com> wrote:

> CSR predicate functions are added to the CSR table.
> mstatus.FS and counter enable checks are moved
> to predicate functions and two new predicates are
> added to check misa.S for s* CSRs and a new PMP
> CPU feature for pmp* CSRs.

> Processors that don't implement S-mode will trap
> on access to s* CSRs and processors that don't
> implement PMP will trap on accesses to pmp* CSRs.

> PMP checks are disabled in riscv_cpu_handle_mmu_fault
> when the PMP CPU feature is not present.

> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>   target/riscv/cpu.c        |   6 ++
>   target/riscv/cpu.h        |   5 +-
>   target/riscv/cpu_helper.c |   3 +-
>   target/riscv/csr.c        | 172
++++++++++++++++++++++++++--------------------
>   4 files changed, 107 insertions(+), 79 deletions(-)

> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4e5a56d..26741d0 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -124,6 +124,7 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
>       set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_09_1);
>       set_resetvec(env, DEFAULT_RSTVEC);
>       set_feature(env, RISCV_FEATURE_MMU);
> +    set_feature(env, RISCV_FEATURE_PMP);
>   }

>   static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
> @@ -133,6 +134,7 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
>       set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
>       set_resetvec(env, DEFAULT_RSTVEC);
>       set_feature(env, RISCV_FEATURE_MMU);
> +    set_feature(env, RISCV_FEATURE_PMP);
>   }

>   static void rv32imacu_nommu_cpu_init(Object *obj)
> @@ -141,6 +143,7 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
>       set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
>       set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
>       set_resetvec(env, DEFAULT_RSTVEC);
> +    set_feature(env, RISCV_FEATURE_PMP);
>   }

>   #elif defined(TARGET_RISCV64)
> @@ -152,6 +155,7 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
>       set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_09_1);
>       set_resetvec(env, DEFAULT_RSTVEC);
>       set_feature(env, RISCV_FEATURE_MMU);
> +    set_feature(env, RISCV_FEATURE_PMP);
>   }

>   static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
> @@ -161,6 +165,7 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
>       set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
>       set_resetvec(env, DEFAULT_RSTVEC);
>       set_feature(env, RISCV_FEATURE_MMU);
> +    set_feature(env, RISCV_FEATURE_PMP);
>   }

>   static void rv64imacu_nommu_cpu_init(Object *obj)
> @@ -169,6 +174,7 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
>       set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
>       set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
>       set_resetvec(env, DEFAULT_RSTVEC);
> +    set_feature(env, RISCV_FEATURE_PMP);
>   }

>   #endif
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index dc79f7c..3fed92d 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -83,9 +83,10 @@
>   /* S extension denotes that Supervisor mode exists, however it is
possible
>      to have a core that support S mode but does not have an MMU and there
>      is currently no bit in misa to indicate whether an MMU exists or not
> -   so a cpu features bitfield is required */
> +   so a cpu features bitfield is required, likewise for optional PMP
support */
>   enum {
> -    RISCV_FEATURE_MMU
> +    RISCV_FEATURE_MMU,
> +    RISCV_FEATURE_PMP
>   };

>   #define USER_VERSION_2_02_0 0x00020200
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 2937da0..5d33f7b 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -403,7 +403,8 @@ int riscv_cpu_handle_mmu_fault(CPUState *cs, vaddr
address, int size,
>       qemu_log_mask(CPU_LOG_MMU,
>               "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
>                " prot %d\n", __func__, address, ret, pa, prot);
> -    if (!pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << rw)) {
> +    if (riscv_feature(env, RISCV_FEATURE_PMP) &&
> +        !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << rw)) {
>           ret = TRANSLATE_FAIL;
>       }
>       if (ret == TRANSLATE_SUCCESS) {
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index c704545..ecf74a0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -26,6 +26,7 @@

>   /* Control and Status Register function table forward declaration */

> +typedef int (*riscv_csr_predicate_fn)(CPURISCVState *env, int csrno);
>   typedef int (*riscv_csr_read_fn)(CPURISCVState *env, int csrno,
>       target_ulong *ret_value);
>   typedef int (*riscv_csr_write_fn)(CPURISCVState *env, int csrno,
> @@ -34,6 +35,7 @@ typedef int (*riscv_csr_op_fn)(CPURISCVState *env, int
csrno,
>       target_ulong *ret_value, target_ulong new_value, target_ulong
write_mask);

>   typedef struct {
> +    riscv_csr_predicate_fn predicate;
>       riscv_csr_read_fn read;
>       riscv_csr_write_fn write;
>       riscv_csr_op_fn op;
> @@ -42,6 +44,47 @@ typedef struct {
>   static const riscv_csr_operations csr_ops[];


> +/* Predicates */
> +
> +static int fs(CPURISCVState *env, int csrno)
> +{
> +#if !defined(CONFIG_USER_ONLY)

I find it's easier to read if defined instead of if not defined. In general
it would be nicer if these could be if defined SOFTMMU.

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair


> +    if (!(env->mstatus & MSTATUS_FS)) {
> +        return -1;
> +    }
> +#endif
> +    return 0;
> +}
> +
> +static int ctr(CPURISCVState *env, int csrno)
> +{
> +#if !defined(CONFIG_USER_ONLY)
> +    target_ulong ctr_en = env->priv == PRV_U ? env->scounteren :
> +                          env->priv == PRV_S ? env->mcounteren : -1U;
> +    if (!(ctr_en & (1 << (csrno & 31)))) {
> +        return -1;
> +    }
> +#endif
> +    return 0;
> +}
> +
> +#if !defined(CONFIG_USER_ONLY)
> +static int any(CPURISCVState *env, int csrno)
> +{
> +    return 0;
> +}
> +
> +static int smode(CPURISCVState *env, int csrno)
> +{
> +    return -!riscv_has_ext(env, RVS);
> +}
> +
> +static int pmp(CPURISCVState *env, int csrno)
> +{
> +    return -!riscv_feature(env, RISCV_FEATURE_PMP);
> +}
> +#endif
> +
>   /* User Floating-Point CSRs */

>   static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
> @@ -117,33 +160,8 @@ static int write_fcsr(CPURISCVState *env, int csrno,
target_ulong val)

>   /* User Timers and Counters */

> -static int counter_enabled(CPURISCVState *env, int csrno)
> -{
> -#ifndef CONFIG_USER_ONLY
> -    target_ulong ctr_en = env->priv == PRV_U ? env->scounteren :
> -                          env->priv == PRV_S ? env->mcounteren : -1U;
> -#else
> -    target_ulong ctr_en = -1;
> -#endif
> -    return (ctr_en >> (csrno & 31)) & 1;
> -}
> -
> -#if !defined(CONFIG_USER_ONLY)
> -static int read_zero_counter(CPURISCVState *env, int csrno, target_ulong
*val)
> -{
> -    if (!counter_enabled(env, csrno)) {
> -        return -1;
> -    }
> -    *val = 0;
> -    return 0;
> -}
> -#endif
> -
>   static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
>   {
> -    if (!counter_enabled(env, csrno)) {
> -        return -1;
> -    }
>   #if !defined(CONFIG_USER_ONLY)
>       if (use_icount) {
>           *val = cpu_get_icount();
> @@ -159,9 +177,6 @@ static int read_instret(CPURISCVState *env, int
csrno, target_ulong *val)
>   #if defined(TARGET_RISCV32)
>   static int read_instreth(CPURISCVState *env, int csrno, target_ulong
*val)
>   {
> -    if (!counter_enabled(env, csrno)) {
> -        return -1;
> -    }
>   #if !defined(CONFIG_USER_ONLY)
>       if (use_icount) {
>           *val = cpu_get_icount() >> 32;
> @@ -726,6 +741,11 @@ int riscv_csrrw(CPURISCVState *env, int csrno,
target_ulong *ret_value,
>       }
>   #endif

> +    /* check predicate */
> +    if (!csr_ops[csrno].predicate || csr_ops[csrno].predicate(env,
csrno) < 0) {
> +        return -1;
> +    }
> +
>       /* execute combined read/write operation if it exists */
>       if (csr_ops[csrno].op) {
>           return csr_ops[csrno].op(env, csrno, ret_value, new_value,
write_mask);
> @@ -765,89 +785,89 @@ int riscv_csrrw(CPURISCVState *env, int csrno,
target_ulong *ret_value,

>   static const riscv_csr_operations csr_ops[0xfff] = {
>       /* User Floating-Point CSRs */
> -    [CSR_FFLAGS] =              { read_fflags,      write_fflags      },
> -    [CSR_FRM] =                 { read_frm,         write_frm         },
> -    [CSR_FCSR] =                { read_fcsr,        write_fcsr        },
> +    [CSR_FFLAGS] =              { fs,   read_fflags,      write_fflags
    },
> +    [CSR_FRM] =                 { fs,   read_frm,         write_frm
     },
> +    [CSR_FCSR] =                { fs,   read_fcsr,        write_fcsr
    },

>       /* User Timers and Counters */
> -    [CSR_CYCLE] =               { read_instret                        },
> -    [CSR_INSTRET] =             { read_instret                        },
> +    [CSR_CYCLE] =               { ctr,  read_instret
    },
> +    [CSR_INSTRET] =             { ctr,  read_instret
    },
>   #if defined(TARGET_RISCV32)
> -    [CSR_CYCLEH] =              { read_instreth                       },
> -    [CSR_INSTRETH] =            { read_instreth                       },
> +    [CSR_CYCLEH] =              { ctr,  read_instreth
     },
> +    [CSR_INSTRETH] =            { ctr,  read_instreth
     },
>   #endif

>       /* User-level time CSRs are only available in linux-user
>        * In privileged mode, the monitor emulates these CSRs */
>   #if defined(CONFIG_USER_ONLY)
> -    [CSR_TIME] =                { read_time                           },
> +    [CSR_TIME] =                { ctr,  read_time
     },
>   #if defined(TARGET_RISCV32)
> -    [CSR_TIMEH] =               { read_timeh                          },
> +    [CSR_TIMEH] =               { ctr,  read_timeh
    },
>   #endif
>   #endif

>   #if !defined(CONFIG_USER_ONLY)
>       /* Machine Timers and Counters */
> -    [CSR_MCYCLE] =              { read_instret                        },
> -    [CSR_MINSTRET] =            { read_instret                        },
> +    [CSR_MCYCLE] =              { any,  read_instret
    },
> +    [CSR_MINSTRET] =            { any,  read_instret
    },
>   #if defined(TARGET_RISCV32)
> -    [CSR_MCYCLEH] =             { read_instreth                       },
> -    [CSR_MINSTRETH] =           { read_instreth                       },
> +    [CSR_MCYCLEH] =             { any,  read_instreth
     },
> +    [CSR_MINSTRETH] =           { any,  read_instreth
     },
>   #endif

>       /* Machine Information Registers */
> -    [CSR_MVENDORID] =           { read_zero                           },
> -    [CSR_MARCHID] =             { read_zero                           },
> -    [CSR_MIMPID] =              { read_zero                           },
> -    [CSR_MHARTID] =             { read_mhartid                        },
> +    [CSR_MVENDORID] =           { any,  read_zero
     },
> +    [CSR_MARCHID] =             { any,  read_zero
     },
> +    [CSR_MIMPID] =              { any,  read_zero
     },
> +    [CSR_MHARTID] =             { any,  read_mhartid
    },

>       /* Machine Trap Setup */
> -    [CSR_MSTATUS] =             { read_mstatus,     write_mstatus     },
> -    [CSR_MISA] =                { read_misa                           },
> -    [CSR_MIDELEG] =             { read_mideleg,     write_mideleg     },
> -    [CSR_MEDELEG] =             { read_medeleg,     write_medeleg     },
> -    [CSR_MIE] =                 { read_mie,         write_mie         },
> -    [CSR_MTVEC] =               { read_mtvec,       write_mtvec       },
> -    [CSR_MCOUNTEREN] =          { read_mcounteren,  write_mcounteren  },
> +    [CSR_MSTATUS] =             { any,  read_mstatus,     write_mstatus
     },
> +    [CSR_MISA] =                { any,  read_misa
     },
> +    [CSR_MIDELEG] =             { any,  read_mideleg,     write_mideleg
     },
> +    [CSR_MEDELEG] =             { any,  read_medeleg,     write_medeleg
     },
> +    [CSR_MIE] =                 { any,  read_mie,         write_mie
     },
> +    [CSR_MTVEC] =               { any,  read_mtvec,       write_mtvec
     },
> +    [CSR_MCOUNTEREN] =          { any,  read_mcounteren,
  write_mcounteren  },

>       /* Legacy Counter Setup (priv v1.9.1) */
> -    [CSR_MUCOUNTEREN] =         { read_mucounteren, write_mucounteren },
> -    [CSR_MSCOUNTEREN] =         { read_mscounteren, write_mscounteren },
> +    [CSR_MUCOUNTEREN] =         { any,  read_mucounteren,
write_mucounteren },
> +    [CSR_MSCOUNTEREN] =         { any,  read_mscounteren,
write_mscounteren },

>       /* Machine Trap Handling */
> -    [CSR_MSCRATCH] =            { read_mscratch,    write_mscratch    },
> -    [CSR_MEPC] =                { read_mepc,        write_mepc        },
> -    [CSR_MCAUSE] =              { read_mcause,      write_mcause      },
> -    [CSR_MBADADDR] =            { read_mbadaddr,    write_mbadaddr    },
> -    [CSR_MIP] =                 { NULL,     NULL,     rmw_mip         },
> +    [CSR_MSCRATCH] =            { any,  read_mscratch,    write_mscratch
    },
> +    [CSR_MEPC] =                { any,  read_mepc,        write_mepc
    },
> +    [CSR_MCAUSE] =              { any,  read_mcause,      write_mcause
    },
> +    [CSR_MBADADDR] =            { any,  read_mbadaddr,    write_mbadaddr
    },
> +    [CSR_MIP] =                 { any,  NULL,     NULL,     rmw_mip
     },

>       /* Supervisor Trap Setup */
> -    [CSR_SSTATUS] =             { read_sstatus,     write_sstatus     },
> -    [CSR_SIE] =                 { read_sie,         write_sie         },
> -    [CSR_STVEC] =               { read_stvec,       write_stvec       },
> -    [CSR_SCOUNTEREN] =          { read_scounteren,  write_scounteren  },
> +    [CSR_SSTATUS] =             { smode, read_sstatus,     write_sstatus
     },
> +    [CSR_SIE] =                 { smode, read_sie,         write_sie
     },
> +    [CSR_STVEC] =               { smode, read_stvec,       write_stvec
     },
> +    [CSR_SCOUNTEREN] =          { smode, read_scounteren,
  write_scounteren  },

>       /* Supervisor Trap Handling */
> -    [CSR_SSCRATCH] =            { read_sscratch,    write_sscratch    },
> -    [CSR_SEPC] =                { read_sepc,        write_sepc        },
> -    [CSR_SCAUSE] =              { read_scause,      write_scause      },
> -    [CSR_SBADADDR] =            { read_sbadaddr,    write_sbadaddr    },
> -    [CSR_SIP] =                 { NULL,     NULL,     rmw_sip         },
> +    [CSR_SSCRATCH] =            { smode, read_sscratch,
  write_sscratch    },
> +    [CSR_SEPC] =                { smode, read_sepc,        write_sepc
      },
> +    [CSR_SCAUSE] =              { smode, read_scause,      write_scause
      },
> +    [CSR_SBADADDR] =            { smode, read_sbadaddr,
  write_sbadaddr    },
> +    [CSR_SIP] =                 { smode, NULL,     NULL,     rmw_sip
     },

>       /* Supervisor Protection and Translation */
> -    [CSR_SATP] =                { read_satp,        write_satp        },
> +    [CSR_SATP] =                { smode, read_satp,        write_satp
      },

>       /* Physical Memory Protection */
> -    [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { read_pmpcfg,  write_pmpcfg   },
> -    [CSR_PMPADDR0 ... CSR_PMPADDR15] = { read_pmpaddr, write_pmpaddr  },
> +    [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,
  write_pmpcfg   },
> +    [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr,
write_pmpaddr  },

>       /* Performance Counters */
> -    [CSR_HPMCOUNTER3   ... CSR_HPMCOUNTER31] =    { read_zero_counter },
> -    [CSR_MHPMCOUNTER3  ... CSR_MHPMCOUNTER31] =   { read_zero         },
> -    [CSR_MHPMEVENT3    ... CSR_MHPMEVENT31] =     { read_zero         },
> +    [CSR_HPMCOUNTER3   ... CSR_HPMCOUNTER31] =    { ctr,  read_zero
      },
> +    [CSR_MHPMCOUNTER3  ... CSR_MHPMCOUNTER31] =   { any,  read_zero
      },
> +    [CSR_MHPMEVENT3    ... CSR_MHPMEVENT31] =     { any,  read_zero
      },
>   #if defined(TARGET_RISCV32)
> -    [CSR_HPMCOUNTER3H  ... CSR_HPMCOUNTER31H] =   { read_zero_counter },
> -    [CSR_MHPMCOUNTER3H ... CSR_MHPMCOUNTER31H] =  { read_zero         },
> +    [CSR_HPMCOUNTER3H  ... CSR_HPMCOUNTER31H] =   { ctr,  read_zero
      },
> +    [CSR_MHPMCOUNTER3H ... CSR_MHPMCOUNTER31H] =  { any,  read_zero
      },
>   #endif
>   #endif
>   };
> --
> 2.7.0
