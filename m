Received: from eggs.gnu.org ([209.51.188.92]:47411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWM7-0001gK-El
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWM6-0005I4-13
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:50:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWM5-0005Ho-K8
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:50:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so1783845wrx.10
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:50:49 -0700 (PDT)
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c807dc5a-14f0-0845-3d9d-f52d88a6f2ef@redhat.com>
Date: Thu, 11 Apr 2019 11:50:47 +0200
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 14/23] linux-user/aarch64: Use
 qemu_guest_getrandom for PAUTH keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> Use a better interface for random numbers than rand() * 3.
> 
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/target_syscall.h |  2 --
>  linux-user/aarch64/cpu_loop.c       | 29 ++++++---------------------
>  linux-user/syscall.c                | 31 ++++++++++++++++++++++++-----
>  3 files changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
> index b595e5da82..995e475c73 100644
> --- a/linux-user/aarch64/target_syscall.h
> +++ b/linux-user/aarch64/target_syscall.h
> @@ -29,6 +29,4 @@ struct target_pt_regs {
>  # define TARGET_PR_PAC_APDBKEY   (1 << 3)
>  # define TARGET_PR_PAC_APGAKEY   (1 << 4)
>  
> -void arm_init_pauth_key(ARMPACKey *key);
> -
>  #endif /* AARCH64_TARGET_SYSCALL_H */
> diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
> index d75fd9d3e2..cedad39ca0 100644
> --- a/linux-user/aarch64/cpu_loop.c
> +++ b/linux-user/aarch64/cpu_loop.c
> @@ -20,6 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu.h"
>  #include "cpu_loop-common.h"
> +#include "qemu/guest-random.h"
>  
>  #define get_user_code_u32(x, gaddr, env)                \
>      ({ abi_long __r = get_user_u32((x), (gaddr));       \
> @@ -147,24 +148,6 @@ void cpu_loop(CPUARMState *env)
>      }
>  }
>  
> -static uint64_t arm_rand64(void)
> -{
> -    int shift = 64 - clz64(RAND_MAX);
> -    int i, n = 64 / shift + (64 % shift != 0);
> -    uint64_t ret = 0;
> -
> -    for (i = 0; i < n; i++) {
> -        ret = (ret << shift) | rand();
> -    }
> -    return ret;
> -}
> -
> -void arm_init_pauth_key(ARMPACKey *key)
> -{
> -    key->lo = arm_rand64();
> -    key->hi = arm_rand64();
> -}
> -
>  void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
>  {
>      ARMCPU *cpu = arm_env_get_cpu(env);
> @@ -192,11 +175,11 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
>  #endif
>  
>      if (cpu_isar_feature(aa64_pauth, cpu)) {
> -        arm_init_pauth_key(&env->apia_key);
> -        arm_init_pauth_key(&env->apib_key);
> -        arm_init_pauth_key(&env->apda_key);
> -        arm_init_pauth_key(&env->apdb_key);
> -        arm_init_pauth_key(&env->apga_key);
> +        qemu_guest_getrandom_nofail(&env->apia_key, sizeof(ARMPACKey));
> +        qemu_guest_getrandom_nofail(&env->apib_key, sizeof(ARMPACKey));
> +        qemu_guest_getrandom_nofail(&env->apda_key, sizeof(ARMPACKey));
> +        qemu_guest_getrandom_nofail(&env->apdb_key, sizeof(ARMPACKey));
> +        qemu_guest_getrandom_nofail(&env->apga_key, sizeof(ARMPACKey));
>      }
>  
>      ts->stack_base = info->start_stack;
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8f7125cd67..c2168db1c8 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -111,6 +111,7 @@
>  
>  #include "qemu.h"
>  #include "qemu/guest-random.h"
> +#include "qapi/error.h"
>  #include "fd-trans.h"
>  
>  #ifndef CLONE_IO
> @@ -9731,25 +9732,45 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                      int all = (TARGET_PR_PAC_APIAKEY | TARGET_PR_PAC_APIBKEY |
>                                 TARGET_PR_PAC_APDAKEY | TARGET_PR_PAC_APDBKEY |
>                                 TARGET_PR_PAC_APGAKEY);
> +                    int ret = 0;
> +                    Error *err = NULL;
> +
>                      if (arg2 == 0) {
>                          arg2 = all;
>                      } else if (arg2 & ~all) {
>                          return -TARGET_EINVAL;
>                      }
>                      if (arg2 & TARGET_PR_PAC_APIAKEY) {
> -                        arm_init_pauth_key(&env->apia_key);
> +                        ret |= qemu_guest_getrandom(&env->apia_key,
> +                                                    sizeof(ARMPACKey), &err);
>                      }
>                      if (arg2 & TARGET_PR_PAC_APIBKEY) {
> -                        arm_init_pauth_key(&env->apib_key);
> +                        ret |= qemu_guest_getrandom(&env->apib_key,
> +                                                    sizeof(ARMPACKey), &err);
>                      }
>                      if (arg2 & TARGET_PR_PAC_APDAKEY) {
> -                        arm_init_pauth_key(&env->apda_key);
> +                        ret |= qemu_guest_getrandom(&env->apda_key,
> +                                                    sizeof(ARMPACKey), &err);
>                      }
>                      if (arg2 & TARGET_PR_PAC_APDBKEY) {
> -                        arm_init_pauth_key(&env->apdb_key);
> +                        ret |= qemu_guest_getrandom(&env->apdb_key,
> +                                                    sizeof(ARMPACKey), &err);
>                      }
>                      if (arg2 & TARGET_PR_PAC_APGAKEY) {
> -                        arm_init_pauth_key(&env->apga_key);
> +                        ret |= qemu_guest_getrandom(&env->apga_key,
> +                                                    sizeof(ARMPACKey), &err);
> +                    }
> +                    if (ret != 0) {
> +                        /*
> +                         * Some unknown failure in the crypto.  The best
> +                         * we can do is log it and fail the syscall.
> +                         * The real syscall cannot fail this way.
> +                         */
> +                        qemu_log_mask(LOG_UNIMP,
> +                                      "PR_PAC_RESET_KEYS: Crypto failure: %s",
> +                                      error_get_pretty(err));
> +                        error_free(err);
> +                        return -TARGET_EIO;

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>                      }
>                      return 0;
>                  }
> 
