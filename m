Received: from eggs.gnu.org ([2001:4830:134:3::10]:52889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEdlu-0000QG-FF
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eEdlq-0004sQ-8t
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:09:10 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eEdlp-0004qE-Uo
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:09:06 -0500
Received: by mail-wm0-x242.google.com with SMTP id t139so23123398wmt.1
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 08:09:05 -0800 (PST)
References: <20171114094203.28030-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171114094203.28030-1-richard.henderson@linaro.org>
Date: Tue, 14 Nov 2017 16:09:02 +0000
Message-ID: <87inecallt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg: Record code_gen_buffer address for
 user-only memory helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> When we handle a signal from a fault within a user-only memory helper,
> we cannot cpu_restore_state with the PC found within the signal frame.
> Use a TLS variable, helper_retaddr, to record the unwind start point
> to find the faulting guest insn.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> Tested only with a silly test case --
>
> int main()
> {
>   int new =3D 1, old =3D 0;
>   __atomic_compare_exchange((int *)0, &old, &new, 0, 0, 0);
>   return old;
> }
>
> which even before the patch does not fail in the way Peter describes.
>
> As I post this, I remember in theory we should use __atomic_signal_fence
> after setting helper_retaddr, but as far as I know this is a no-op on all
> supported hosts.  It might still generate a compiler barrier though, so i=
t's
> worth considering.
>
>
> r~
> ---
>
>  accel/tcg/atomic_template.h               | 32 +++++++++++++----
>  include/exec/cpu_ldst.h                   |  2 ++
>  include/exec/cpu_ldst_useronly_template.h | 14 ++++++--
>  accel/tcg/cputlb.c                        |  1 +
>  accel/tcg/user-exec.c                     | 58 +++++++++++++++++++++++++=
------
>  5 files changed, 87 insertions(+), 20 deletions(-)
>
> diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
> index b400b2a3d3..1c7c17526c 100644
> --- a/accel/tcg/atomic_template.h
> +++ b/accel/tcg/atomic_template.h
> @@ -62,7 +62,9 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target=
_ulong addr,
>                                ABI_TYPE cmpv, ABI_TYPE newv EXTRA_ARGS)
>  {
>      DATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;
> -    return atomic_cmpxchg__nocheck(haddr, cmpv, newv);
> +    DATA_TYPE ret =3D atomic_cmpxchg__nocheck(haddr, cmpv, newv);
> +    ATOMIC_MMU_CLEANUP;
> +    return ret;
>  }
>
>  #if DATA_SIZE >=3D 16
> @@ -70,6 +72,7 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulon=
g addr EXTRA_ARGS)
>  {
>      DATA_TYPE val, *haddr =3D ATOMIC_MMU_LOOKUP;
>      __atomic_load(haddr, &val, __ATOMIC_RELAXED);
> +    ATOMIC_MMU_CLEANUP;
>      return val;
>  }
>
> @@ -78,13 +81,16 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong =
addr,
>  {
>      DATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;
>      __atomic_store(haddr, &val, __ATOMIC_RELAXED);
> +    ATOMIC_MMU_CLEANUP;
>  }
>  #else
>  ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
>                             ABI_TYPE val EXTRA_ARGS)
>  {
>      DATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;
> -    return atomic_xchg__nocheck(haddr, val);
> +    DATA_TYPE ret =3D atomic_xchg__nocheck(haddr, val);
> +    ATOMIC_MMU_CLEANUP;
> +    return ret;
>  }
>
>  #define GEN_ATOMIC_HELPER(X)                                        \
> @@ -92,8 +98,10 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulon=
g addr,       \
>                   ABI_TYPE val EXTRA_ARGS)                           \
>  {                                                                   \
>      DATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;                           \
> -    return atomic_##X(haddr, val);                                  \
> -}                                                                   \
> +    DATA_TYPE ret =3D atomic_##X(haddr, val);                         \
> +    ATOMIC_MMU_CLEANUP;                                             \
> +    return ret;                                                     \
> +}
>
>  GEN_ATOMIC_HELPER(fetch_add)
>  GEN_ATOMIC_HELPER(fetch_and)
> @@ -123,7 +131,9 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, targ=
et_ulong addr,
>                                ABI_TYPE cmpv, ABI_TYPE newv EXTRA_ARGS)
>  {
>      DATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;
> -    return BSWAP(atomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv)=
));
> +    DATA_TYPE ret =3D atomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(=
newv));
> +    ATOMIC_MMU_CLEANUP;
> +    return BSWAP(ret);
>  }
>
>  #if DATA_SIZE >=3D 16
> @@ -131,6 +141,7 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ul=
ong addr EXTRA_ARGS)
>  {
>      DATA_TYPE val, *haddr =3D ATOMIC_MMU_LOOKUP;
>      __atomic_load(haddr, &val, __ATOMIC_RELAXED);
> +    ATOMIC_MMU_CLEANUP;
>      return BSWAP(val);
>  }
>
> @@ -140,13 +151,16 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulon=
g addr,
>      DATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;
>      val =3D BSWAP(val);
>      __atomic_store(haddr, &val, __ATOMIC_RELAXED);
> +    ATOMIC_MMU_CLEANUP;
>  }
>  #else
>  ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
>                             ABI_TYPE val EXTRA_ARGS)
>  {
>      DATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;
> -    return BSWAP(atomic_xchg__nocheck(haddr, BSWAP(val)));
> +    ABI_TYPE ret =3D atomic_xchg__nocheck(haddr, BSWAP(val));
> +    ATOMIC_MMU_CLEANUP;
> +    return BSWAP(ret);
>  }
>
>  #define GEN_ATOMIC_HELPER(X)                                        \
> @@ -154,7 +168,9 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulo=
ng addr,       \
>                   ABI_TYPE val EXTRA_ARGS)                           \
>  {                                                                   \
>      DATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;                           \
> -    return BSWAP(atomic_##X(haddr, BSWAP(val)));                    \
> +    DATA_TYPE ret =3D atomic_##X(haddr, BSWAP(val));                  \
> +    ATOMIC_MMU_CLEANUP;                                             \
> +    return BSWAP(ret);                                              \
>  }
>
>  GEN_ATOMIC_HELPER(fetch_and)
> @@ -180,6 +196,7 @@ ABI_TYPE ATOMIC_NAME(fetch_add)(CPUArchState *env, ta=
rget_ulong addr,
>          sto =3D BSWAP(ret + val);
>          ldn =3D atomic_cmpxchg__nocheck(haddr, ldo, sto);
>          if (ldn =3D=3D ldo) {
> +            ATOMIC_MMU_CLEANUP;
>              return ret;
>          }
>          ldo =3D ldn;
> @@ -198,6 +215,7 @@ ABI_TYPE ATOMIC_NAME(add_fetch)(CPUArchState *env, ta=
rget_ulong addr,
>          sto =3D BSWAP(ret);
>          ldn =3D atomic_cmpxchg__nocheck(haddr, ldo, sto);
>          if (ldn =3D=3D ldo) {
> +            ATOMIC_MMU_CLEANUP;
>              return ret;
>          }
>          ldo =3D ldn;
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 6eb5fe80dc..191f2e962a 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -76,6 +76,8 @@
>
>  #if defined(CONFIG_USER_ONLY)
>
> +extern __thread uintptr_t helper_retaddr;
> +
>  /* In user-only mode we provide only the _code and _data accessors. */
>
>  #define MEMSUFFIX _data
> diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu=
_ldst_useronly_template.h
> index 7b8c7c506e..c168f31bba 100644
> --- a/include/exec/cpu_ldst_useronly_template.h
> +++ b/include/exec/cpu_ldst_useronly_template.h
> @@ -73,7 +73,11 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUA=
rchState *env,
>                                                    target_ulong ptr,
>                                                    uintptr_t retaddr)
>  {
> -    return glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(env, ptr);
> +    RES_TYPE ret;
> +    helper_retaddr =3D retaddr;
> +    ret =3D glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(env, ptr);
> +    helper_retaddr =3D 0;
> +    return ret;
>  }
>
>  #if DATA_SIZE <=3D 2
> @@ -93,7 +97,11 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUA=
rchState *env,
>                                                    target_ulong ptr,
>                                                    uintptr_t retaddr)
>  {
> -    return glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(env, ptr);
> +    int ret;
> +    helper_retaddr =3D retaddr;
> +    ret =3D glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(env, ptr);
> +    helper_retaddr =3D 0;
> +    return ret;
>  }
>  #endif
>
> @@ -116,7 +124,9 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUA=
rchState *env,
>                                                    RES_TYPE v,
>                                                    uintptr_t retaddr)
>  {
> +    helper_retaddr =3D retaddr;
>      glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(env, ptr, v);
> +    helper_retaddr =3D 0;
>  }
>  #endif
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index a23919c3a8..d071ca4d14 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1041,6 +1041,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, t=
arget_ulong addr,
>  #define ATOMIC_NAME(X) \
>      HELPER(glue(glue(glue(atomic_ ## X, SUFFIX), END), _mmu))
>  #define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, oi, retaddr)
> +#define ATOMIC_MMU_CLEANUP do { } while (0)
>
>  #define DATA_SIZE 1
>  #include "atomic_template.h"
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 492ea0826c..0324ba8ad1 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -39,6 +39,8 @@
>  #include <sys/ucontext.h>
>  #endif
>
> +__thread uintptr_t helper_retaddr;
> +
>  //#define DEBUG_SIGNAL
>
>  /* exit the current TB from a signal handler. The host registers are
> @@ -62,6 +64,27 @@ static inline int handle_cpu_signal(uintptr_t pc, unsi=
gned long address,
>      CPUClass *cc;
>      int ret;
>
> +    /* We must handle PC addresses from two different sources:
> +     * a call return address and a signal frame address.
> +     *
> +     * Within cpu_restore_state_from_tb we assume the former and adjust
> +     * the address by -GETPC_ADJ so that the address is within the call
> +     * insn so that addr does not accidentally match the beginning of the
> +     * next guest insn.
> +     *
> +     * However, when the PC comes from the signal frame, it points to
> +     * the actual faulting host insn and not a call insn.  Subtracting
> +     * GETPC_ADJ in that case may accidentally match the previous guest =
insn.
> +     *
> +     * So for the later case, adjust forward to compensate for what
> +     * will be done later by cpu_restore_state_from_tb.
> +     */
> +    if (helper_retaddr) {
> +        pc =3D helper_retaddr;
> +    } else {
> +        pc +=3D GETPC_ADJ;
> +    }
> +
>      /* For synchronous signals we expect to be coming from the vCPU
>       * thread (so current_cpu should be valid) and either from running
>       * code or during translation which can fault as we cross pages.
> @@ -84,21 +107,24 @@ static inline int handle_cpu_signal(uintptr_t pc, un=
signed long address,
>          switch (page_unprotect(h2g(address), pc)) {
>          case 0:
>              /* Fault not caused by a page marked unwritable to protect
> -             * cached translations, must be the guest binary's problem
> +             * cached translations, must be the guest binary's problem.
>               */
>              break;
>          case 1:
>              /* Fault caused by protection of cached translation; TBs
> -             * invalidated, so resume execution
> +             * invalidated, so resume execution.  Retain helper_retaddr
> +             * for a possible second fault.
>               */
>              return 1;
>          case 2:
>              /* Fault caused by protection of cached translation, and the
>               * currently executing TB was modified and must be exited
> -             * immediately.
> +             * immediately.  Clear helper_retaddr for next execution.
>               */
> +            helper_retaddr =3D 0;
>              cpu_exit_tb_from_sighandler(cpu, old_set);
> -            g_assert_not_reached();
> +            /* NORETURN */
> +
>          default:
>              g_assert_not_reached();
>          }
> @@ -112,17 +138,25 @@ static inline int handle_cpu_signal(uintptr_t pc, u=
nsigned long address,
>      /* see if it is an MMU fault */
>      g_assert(cc->handle_mmu_fault);
>      ret =3D cc->handle_mmu_fault(cpu, address, is_write, MMU_USER_IDX);
> +
> +    if (ret =3D=3D 0) {
> +        /* The MMU fault was handled without causing real CPU fault.
> +         *  Retain helper_retaddr for a possible second fault.
> +         */
> +        return 1;
> +    }
> +
> +    /* All other paths lead to cpu_exit; clear helper_retaddr
> +     * for next execution.
> +     */
> +    helper_retaddr =3D 0;
> +
>      if (ret < 0) {
>          return 0; /* not an MMU fault */
>      }
> -    if (ret =3D=3D 0) {
> -        return 1; /* the MMU fault was handled without causing real CPU =
fault */
> -    }
>
> -    /* Now we have a real cpu fault.  Since this is the exact location of
> -     * the exception, we must undo the adjustment done by cpu_restore_st=
ate
> -     * for handling call return addresses.  */
> -    cpu_restore_state(cpu, pc + GETPC_ADJ);
> +    /* Now we have a real cpu fault.  */
> +    cpu_restore_state(cpu, pc);

I can't help thinking when we get it wrong we should be doing something
here, maybe a LOG_UNIMP? Otherwise we silently fail or at least the
user-space falls off a cliff later.

Anyway, other than that minor nit:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
>      sigprocmask(SIG_SETMASK, old_set, NULL);
>      cpu_loop_exit(cpu);
> @@ -585,11 +619,13 @@ static void *atomic_mmu_lookup(CPUArchState *env, t=
arget_ulong addr,
>      if (unlikely(addr & (size - 1))) {
>          cpu_loop_exit_atomic(ENV_GET_CPU(env), retaddr);
>      }
> +    helper_retaddr =3D retaddr;
>      return g2h(addr);
>  }
>
>  /* Macro to call the above, with local variables from the use context.  =
*/
>  #define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, GETPC=
())
> +#define ATOMIC_MMU_CLEANUP do { helper_retaddr =3D 0; } while (0)
>
>  #define ATOMIC_NAME(X)   HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
>  #define EXTRA_ARGS


--
Alex Benn=C3=A9e
