Received: from eggs.gnu.org ([209.51.188.92]:60010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gm3tL-0003mY-Ge
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gm3tC-0004YF-Ge
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:47:26 -0500
MIME-Version: 1.0
References: <CAFyWVaai=5K7j8w+Abpk9jxGyKuo4v9w2BgmDbY=_29+Q++Jyw@mail.gmail.com>
	<20181228221018.5022-1-jimw@sifive.com>
In-Reply-To: <20181228221018.5022-1-jimw@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 22 Jan 2019 13:46:53 -0800
Message-ID: <CAKmqyKM8z+dTZPa8FdXkS44GeR6dFtWggjMpvkZPyw2NUi1cmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/5 v2] RISC-V: Add debug support for
 accessing CSRs.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jim Wilson <jimw@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On Fri, Dec 28, 2018 at 2:23 PM Jim Wilson <jimw@sifive.com> wrote:
>
> Adds a debugger parameter to csr_read_helper and csr_write_helper.  When
> this is true, we disable illegal instruction checks.
>
> Signed-off-by: Jim Wilson <jimw@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  linux-user/riscv/signal.c |  5 ++-
>  target/riscv/cpu.h        |  7 +++-
>  target/riscv/cpu_helper.c |  4 +-
>  target/riscv/gdbstub.c    |  4 +-
>  target/riscv/op_helper.c  | 93 ++++++++++++++++++++++++++++++++---------------
>  5 files changed, 76 insertions(+), 37 deletions(-)
>
> diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
> index f598d41..ed76f23 100644
> --- a/linux-user/riscv/signal.c
> +++ b/linux-user/riscv/signal.c
> @@ -83,7 +83,8 @@ static void setup_sigcontext(struct target_sigcontext *sc, CPURISCVState *env)
>          __put_user(env->fpr[i], &sc->fpr[i]);
>      }
>
> -    uint32_t fcsr = csr_read_helper(env, CSR_FCSR); /*riscv_get_fcsr(env);*/
> +    /*riscv_get_fcsr(env);*/
> +    uint32_t fcsr = csr_read_helper(env, CSR_FCSR, false);
>      __put_user(fcsr, &sc->fcsr);
>  }
>
> @@ -159,7 +160,7 @@ static void restore_sigcontext(CPURISCVState *env, struct target_sigcontext *sc)
>
>      uint32_t fcsr;
>      __get_user(fcsr, &sc->fcsr);
> -    csr_write_helper(env, fcsr, CSR_FCSR);
> +    csr_write_helper(env, fcsr, CSR_FCSR, false);
>  }
>
>  static void restore_ucontext(CPURISCVState *env, struct target_ucontext *uc)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4ee09b9..29361ca 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -290,8 +290,11 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
>  }
>
>  void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
> -        target_ulong csrno);
> -target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno);
> +                      target_ulong csrno, bool debugger);
> +target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno,
> +                             bool debugger);
> +
> +void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
>
>  #include "exec/cpu-all.h"
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 86f9f47..1abad94 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -526,7 +526,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>              get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->priv));
>          s = set_field(s, MSTATUS_SPP, env->priv);
>          s = set_field(s, MSTATUS_SIE, 0);
> -        csr_write_helper(env, s, CSR_MSTATUS);
> +        csr_write_helper(env, s, CSR_MSTATUS, false);
>          riscv_set_mode(env, PRV_S);
>      } else {
>          /* No need to check MTVEC for misaligned - lower 2 bits cannot be set */
> @@ -551,7 +551,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>              get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->priv));
>          s = set_field(s, MSTATUS_MPP, env->priv);
>          s = set_field(s, MSTATUS_MIE, 0);
> -        csr_write_helper(env, s, CSR_MSTATUS);
> +        csr_write_helper(env, s, CSR_MSTATUS, false);
>          riscv_set_mode(env, PRV_M);
>      }
>      /* TODO yield load reservation  */
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 71c3eb1..b06f0fa 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -34,7 +34,7 @@ int riscv_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
>      } else if (n < 65) {
>          return gdb_get_reg64(mem_buf, env->fpr[n - 33]);
>      } else if (n < 4096 + 65) {
> -        return gdb_get_regl(mem_buf, csr_read_helper(env, n - 65));
> +        return gdb_get_regl(mem_buf, csr_read_helper(env, n - 65, true));
>      }
>      return 0;
>  }
> @@ -57,7 +57,7 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>          env->fpr[n - 33] = ldq_p(mem_buf); /* always 64-bit */
>          return sizeof(uint64_t);
>      } else if (n < 4096 + 65) {
> -        csr_write_helper(env, ldtul_p(mem_buf), n - 65);
> +        csr_write_helper(env, ldtul_p(mem_buf), n - 65, true);
>      }
>      return 0;
>  }
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 3726299..3c5641e 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -87,7 +87,7 @@ static void validate_mstatus_fs(CPURISCVState *env, uintptr_t ra)
>   * Adapted from Spike's processor_t::set_csr
>   */
>  void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
> -        target_ulong csrno)
> +                      target_ulong csrno, bool debugger)
>  {
>  #ifndef CONFIG_USER_ONLY
>      uint64_t delegable_ints = MIP_SSIP | MIP_STIP | MIP_SEIP;
> @@ -96,15 +96,21 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
>
>      switch (csrno) {
>      case CSR_FFLAGS:
> -        validate_mstatus_fs(env, GETPC());
> +        if (!debugger) {
> +            validate_mstatus_fs(env, GETPC());
> +        }
>          cpu_riscv_set_fflags(env, val_to_write & (FSR_AEXC >> FSR_AEXC_SHIFT));
>          break;
>      case CSR_FRM:
> -        validate_mstatus_fs(env, GETPC());
> +        if (!debugger) {
> +            validate_mstatus_fs(env, GETPC());
> +        }
>          env->frm = val_to_write & (FSR_RD >> FSR_RD_SHIFT);
>          break;
>      case CSR_FCSR:
> -        validate_mstatus_fs(env, GETPC());
> +        if (!debugger) {
> +            validate_mstatus_fs(env, GETPC());
> +        }
>          env->frm = (val_to_write & FSR_RD) >> FSR_RD_SHIFT;
>          cpu_riscv_set_fflags(env, (val_to_write & FSR_AEXC) >> FSR_AEXC_SHIFT);
>          break;
> @@ -169,7 +175,9 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
>           * CLINT, no additional locking is needed for read-modifiy-write
>           * CSR operations
>           */
> -        qemu_mutex_lock_iothread();
> +        if (!debugger) {
> +            qemu_mutex_lock_iothread();
> +        }
>          RISCVCPU *cpu = riscv_env_get_cpu(env);
>          riscv_cpu_update_mip(cpu, MIP_SSIP | MIP_STIP,
>                                    (val_to_write & (MIP_SSIP | MIP_STIP)));
> @@ -177,7 +185,9 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
>           * csrs, csrc on mip.SEIP is not decomposable into separate read and
>           * write steps, so a different implementation is needed
>           */
> -        qemu_mutex_unlock_iothread();
> +        if (!debugger) {
> +            qemu_mutex_unlock_iothread();
> +        }
>          break;
>      }
>      case CSR_MIE: {
> @@ -247,21 +257,25 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
>              mask |= SSTATUS_MXR;
>          }
>          ms = (ms & ~mask) | (val_to_write & mask);
> -        csr_write_helper(env, ms, CSR_MSTATUS);
> +        csr_write_helper(env, ms, CSR_MSTATUS, debugger);
>          break;
>      }
>      case CSR_SIP: {
> -        qemu_mutex_lock_iothread();
> +        if (!debugger) {
> +            qemu_mutex_lock_iothread();
> +        }
>          target_ulong next_mip = (env->mip & ~env->mideleg)
>                                  | (val_to_write & env->mideleg);
> -        qemu_mutex_unlock_iothread();
> -        csr_write_helper(env, next_mip, CSR_MIP);
> +        if (!debugger) {
> +            qemu_mutex_unlock_iothread();
> +        }
> +        csr_write_helper(env, next_mip, CSR_MIP, debugger);
>          break;
>      }
>      case CSR_SIE: {
>          target_ulong next_mie = (env->mie & ~env->mideleg)
>                                  | (val_to_write & env->mideleg);
> -        csr_write_helper(env, next_mie, CSR_MIE);
> +        csr_write_helper(env, next_mie, CSR_MIE, debugger);
>          break;
>      }
>      case CSR_SATP: /* CSR_SPTBR */ {
> @@ -371,7 +385,9 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
>      do_illegal:
>  #endif
>      default:
> -        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        if (!debugger) {
> +            do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        }
>      }
>  }
>
> @@ -380,7 +396,8 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
>   *
>   * Adapted from Spike's processor_t::get_csr
>   */
> -target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
> +target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno,
> +                             bool debugger)
>  {
>  #ifndef CONFIG_USER_ONLY
>      target_ulong ctr_en = env->priv == PRV_U ? env->scounteren :
> @@ -416,13 +433,19 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
>
>      switch (csrno) {
>      case CSR_FFLAGS:
> -        validate_mstatus_fs(env, GETPC());
> +        if (!debugger) {
> +            validate_mstatus_fs(env, GETPC());
> +        }
>          return cpu_riscv_get_fflags(env);
>      case CSR_FRM:
> -        validate_mstatus_fs(env, GETPC());
> +        if (!debugger) {
> +            validate_mstatus_fs(env, GETPC());
> +        }
>          return env->frm;
>      case CSR_FCSR:
> -        validate_mstatus_fs(env, GETPC());
> +        if (!debugger) {
> +            validate_mstatus_fs(env, GETPC());
> +        }
>          return (cpu_riscv_get_fflags(env) << FSR_AEXC_SHIFT)
>                  | (env->frm << FSR_RD_SHIFT);
>      /* rdtime/rdtimeh is trapped and emulated by bbl in system mode */
> @@ -504,9 +527,13 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
>          return env->mstatus & mask;
>      }
>      case CSR_SIP: {
> -        qemu_mutex_lock_iothread();
> +        if (!debugger) {
> +            qemu_mutex_lock_iothread();
> +        }
>          target_ulong tmp = env->mip & env->mideleg;
> -        qemu_mutex_unlock_iothread();
> +        if (!debugger) {
> +            qemu_mutex_unlock_iothread();
> +        }
>          return tmp;
>      }
>      case CSR_SIE:
> @@ -539,9 +566,13 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
>      case CSR_MSTATUS:
>          return env->mstatus;
>      case CSR_MIP: {
> -        qemu_mutex_lock_iothread();
> +        if (!debugger) {
> +            qemu_mutex_lock_iothread();
> +        }
>          target_ulong tmp = env->mip;
> -        qemu_mutex_unlock_iothread();
> +        if (!debugger) {
> +            qemu_mutex_unlock_iothread();
> +        }
>          return tmp;
>      }
>      case CSR_MIE:
> @@ -601,7 +632,11 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
>  #endif
>      }
>      /* used by e.g. MTIME read */
> -    do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    if (!debugger) {
> +        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    } else {
> +        return 0;
> +    }
>  }
>
>  /*
> @@ -625,8 +660,8 @@ target_ulong helper_csrrw(CPURISCVState *env, target_ulong src,
>          target_ulong csr)
>  {
>      validate_csr(env, csr, 1, GETPC());
> -    uint64_t csr_backup = csr_read_helper(env, csr);
> -    csr_write_helper(env, src, csr);
> +    uint64_t csr_backup = csr_read_helper(env, csr, false);
> +    csr_write_helper(env, src, csr, false);
>      return csr_backup;
>  }
>
> @@ -634,9 +669,9 @@ target_ulong helper_csrrs(CPURISCVState *env, target_ulong src,
>          target_ulong csr, target_ulong rs1_pass)
>  {
>      validate_csr(env, csr, rs1_pass != 0, GETPC());
> -    uint64_t csr_backup = csr_read_helper(env, csr);
> +    uint64_t csr_backup = csr_read_helper(env, csr, false);
>      if (rs1_pass != 0) {
> -        csr_write_helper(env, src | csr_backup, csr);
> +        csr_write_helper(env, src | csr_backup, csr, false);
>      }
>      return csr_backup;
>  }
> @@ -645,9 +680,9 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
>          target_ulong csr, target_ulong rs1_pass)
>  {
>      validate_csr(env, csr, rs1_pass != 0, GETPC());
> -    uint64_t csr_backup = csr_read_helper(env, csr);
> +    uint64_t csr_backup = csr_read_helper(env, csr, false);
>      if (rs1_pass != 0) {
> -        csr_write_helper(env, (~src) & csr_backup, csr);
> +        csr_write_helper(env, (~src) & csr_backup, csr, false);
>      }
>      return csr_backup;
>  }
> @@ -674,7 +709,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
>      mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
>      mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
>      riscv_set_mode(env, prev_priv);
> -    csr_write_helper(env, mstatus, CSR_MSTATUS);
> +    csr_write_helper(env, mstatus, CSR_MSTATUS, false);
>
>      return retpc;
>  }
> @@ -699,7 +734,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
>      mstatus = set_field(mstatus, MSTATUS_MPIE, 0);
>      mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
>      riscv_set_mode(env, prev_priv);
> -    csr_write_helper(env, mstatus, CSR_MSTATUS);
> +    csr_write_helper(env, mstatus, CSR_MSTATUS, false);
>
>      return retpc;
>  }
> --
> 2.7.4
>
>
