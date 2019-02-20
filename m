Received: from eggs.gnu.org ([209.51.188.92]:46975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwPAX-0003wJ-NJ
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwPAW-0002CW-7Q
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:32:01 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwPAV-0002AN-Pc
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:32:00 -0500
Received: by mail-wr1-x442.google.com with SMTP id w17so25300188wrn.12
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 02:31:59 -0800 (PST)
References: <20190219233421.388-1-richard.henderson@linaro.org>
	<20190219233421.388-3-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190219233421.388-3-richard.henderson@linaro.org>
Date: Wed, 20 Feb 2019 10:31:56 +0000
Message-ID: <871s42699f.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] target/arm: Rebuild hflags at el
 changes and MSR writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, cota@braap.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Now setting, but not relying upon, env->hflags.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v2: Fixed partial conversion to assignment to env->hflags.
> ---
>  target/arm/internals.h     |  1 +
>  linux-user/syscall.c       |  1 +
>  target/arm/cpu.c           |  1 +
>  target/arm/helper-a64.c    |  3 +++
>  target/arm/helper.c        |  2 ++
>  target/arm/machine.c       |  1 +
>  target/arm/op_helper.c     |  1 +
>  target/arm/translate-a64.c |  6 +++++-
>  target/arm/translate.c     | 14 ++++++++++++--
>  9 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 8c1b813364..235f4fafec 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -970,5 +970,6 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, =
uint64_t va,
>
>  uint32_t rebuild_hflags_a32(CPUARMState *env, int el);
>  uint32_t rebuild_hflags_a64(CPUARMState *env, int el);
> +void rebuild_hflags_any(CPUARMState *env);
>
>  #endif
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 5bbb72f3d5..123f342bdc 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -9691,6 +9691,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>                      aarch64_sve_narrow_vq(env, vq);
>                  }
>                  env->vfp.zcr_el[1] =3D vq - 1;
> +                arm_rebuild_hflags(env);
>                  ret =3D vq * 16;
>              }
>              return ret;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index edf6e0e1f1..e4da513eb3 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -390,6 +390,7 @@ static void arm_cpu_reset(CPUState *s)
>
>      hw_breakpoint_update_all(cpu);
>      hw_watchpoint_update_all(cpu);
> +    arm_rebuild_hflags(env);
>  }
>
>  bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index 70850e564d..17200f1288 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -995,6 +995,7 @@ void HELPER(exception_return)(CPUARMState *env, uint6=
4_t new_pc)
>          } else {
>              env->regs[15] =3D new_pc & ~0x3;
>          }
> +        env->hflags =3D rebuild_hflags_a32(env, new_el);
>          qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d t=
o "
>                        "AArch32 EL%d PC 0x%" PRIx32 "\n",
>                        cur_el, new_el, env->regs[15]);
> @@ -1006,10 +1007,12 @@ void HELPER(exception_return)(CPUARMState *env, u=
int64_t new_pc)
>          }
>          aarch64_restore_sp(env, new_el);
>          env->pc =3D new_pc;
> +        env->hflags =3D rebuild_hflags_a64(env, new_el);
>          qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d t=
o "
>                        "AArch64 EL%d PC 0x%" PRIx64 "\n",
>                        cur_el, new_el, env->pc);
>      }
> +
>      /*
>       * Note that cur_el can never be 0.  If new_el is 0, then
>       * el0_a64 is return_to_aa64, else el0_a64 is ignored.
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 189e97a083..909535a3e3 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -9201,6 +9201,7 @@ static void take_aarch32_exception(CPUARMState *env=
, int new_mode,
>          env->regs[14] =3D env->regs[15] + offset;
>      }
>      env->regs[15] =3D newpc;
> +    env->hflags =3D rebuild_hflags_a32(env, arm_current_el(env));
>  }
>
>  static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
> @@ -9546,6 +9547,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *=
cs)
>
>      pstate_write(env, PSTATE_DAIF | new_mode);
>      env->aarch64 =3D 1;
> +    env->hflags =3D rebuild_hflags_a64(env, new_el);
>      aarch64_restore_sp(env, new_el);
>
>      env->pc =3D addr;
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 124192bfc2..e944d6b736 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -743,6 +743,7 @@ static int cpu_post_load(void *opaque, int version_id)
>      if (!kvm_enabled()) {
>          pmu_op_finish(&cpu->env);
>      }
> +    arm_rebuild_hflags(&cpu->env);
>
>      return 0;
>  }
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index c998eadfaa..f82eeae7e4 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -571,6 +571,7 @@ void HELPER(cpsr_write_eret)(CPUARMState *env, uint32=
_t val)
>       */
>      env->regs[15] &=3D (env->thumb ? ~1 : ~3);
>
> +    env->hflags =3D rebuild_hflags_a32(env, arm_current_el(env));
>      qemu_mutex_lock_iothread();
>      arm_call_el_change_hook(arm_env_get_cpu(env));
>      qemu_mutex_unlock_iothread();
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index af8e4fd4be..a786c7ef5f 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1841,11 +1841,15 @@ static void handle_sys(DisasContext *s, uint32_t =
insn, bool isread,
>          /* I/O operations must end the TB here (whether read or write) */
>          gen_io_end();
>          s->base.is_jmp =3D DISAS_UPDATE;
> -    } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
> +    }
> +    if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
>          /* We default to ending the TB on a coprocessor register write,
>           * but allow this to be suppressed by the register definition
>           * (usually only necessary to work around guest bugs).
>           */
> +        TCGv_i32 tcg_el =3D tcg_const_i32(s->current_el);
> +        gen_helper_rebuild_hflags_a64(cpu_env, tcg_el);
> +        tcg_temp_free_i32(tcg_el);
>          s->base.is_jmp =3D DISAS_UPDATE;
>      }
>  }
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index dac737f6ca..1cdb575ccd 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8563,6 +8563,8 @@ static int disas_coproc_insn(DisasContext *s, uint3=
2_t insn)
>      ri =3D get_arm_cp_reginfo(s->cp_regs,
>              ENCODE_CP_REG(cpnum, is64, s->ns, crn, crm, opc1, opc2));
>      if (ri) {
> +        bool need_exit_tb;
> +
>          /* Check access permissions */
>          if (!cp_access_ok(s->current_el, ri, isread)) {
>              return 1;
> @@ -8735,15 +8737,23 @@ static int disas_coproc_insn(DisasContext *s, uin=
t32_t insn)
>              }
>          }
>
> +        need_exit_tb =3D false;
>          if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_C=
P_IO)) {
>              /* I/O operations must end the TB here (whether read or writ=
e) */
>              gen_io_end();
> -            gen_lookup_tb(s);
> -        } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
> +            need_exit_tb =3D true;
> +        }
> +        if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
>              /* We default to ending the TB on a coprocessor register wri=
te,
>               * but allow this to be suppressed by the register definition
>               * (usually only necessary to work around guest bugs).
>               */
> +            TCGv_i32 tcg_el =3D tcg_const_i32(s->current_el);
> +            gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
> +            tcg_temp_free_i32(tcg_el);
> +            need_exit_tb =3D true;
> +        }
> +        if (need_exit_tb) {
>              gen_lookup_tb(s);
>          }


--
Alex Benn=C3=A9e
