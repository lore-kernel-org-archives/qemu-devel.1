Received: from eggs.gnu.org ([2001:4830:134:3::10]:47313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAYd8-0007G8-1b
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAYd4-0003en-2K
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:55:45 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAYd3-0003dq-Rw
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:55:41 -0400
Received: by mail-wr1-f54.google.com with SMTP id n1-v6so9146810wrt.10
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 03:55:41 -0700 (PDT)
References: <20181003193931.18096-1-richard.henderson@linaro.org>
	<20181003193931.18096-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1c54d6f2-a485-3468-77bc-da7b0690c8d5@redhat.com>
Date: Thu, 11 Oct 2018 12:55:39 +0200
MIME-Version: 1.0
In-Reply-To: <20181003193931.18096-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/9] target/i386: Convert to
 HAVE_CMPXCHG128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 03/10/2018 21:39, Richard Henderson wrote:
> Reviewed-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/i386/mem_helper.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/target/i386/mem_helper.c b/target/i386/mem_helper.c
> index 30c26b9d9c..6cc53bcb40 100644
> --- a/target/i386/mem_helper.c
> +++ b/target/i386/mem_helper.c
> @@ -23,6 +23,7 @@
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
>  #include "qemu/int128.h"
> +#include "qemu/atomic128.h"
>  #include "tcg.h"
>  
>  void helper_cmpxchg8b_unlocked(CPUX86State *env, target_ulong a0)
> @@ -137,10 +138,7 @@ void helper_cmpxchg16b(CPUX86State *env, target_ulong a0)
>  
>      if ((a0 & 0xf) != 0) {
>          raise_exception_ra(env, EXCP0D_GPF, ra);
> -    } else {
> -#ifndef CONFIG_ATOMIC128
> -        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
> -#else
> +    } else if (HAVE_CMPXCHG128) {
>          int eflags = cpu_cc_compute_all(env, CC_OP);
>  
>          Int128 cmpv = int128_make128(env->regs[R_EAX], env->regs[R_EDX]);
> @@ -159,7 +157,8 @@ void helper_cmpxchg16b(CPUX86State *env, target_ulong a0)
>              eflags &= ~CC_Z;
>          }
>          CC_SRC = eflags;
> -#endif
> +    } else {
> +        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
>      }
>  }
>  #endif
> 
