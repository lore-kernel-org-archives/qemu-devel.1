Received: from eggs.gnu.org ([209.51.188.92]:42043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL75g-0001AS-24
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL75e-0005kS-ME
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:17:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL75e-0005iK-Fy
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:17:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so16087098wmd.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:17:06 -0700 (PDT)
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-24-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <008ae301-bac4-c89b-2317-5466937ae426@redhat.com>
Date: Mon, 29 Apr 2019 16:17:03 +0200
MIME-Version: 1.0
In-Reply-To: <20190328230404.12909-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 23/36] target/sh4: Use env_cpu,
 env_archcpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 3/29/19 12:03 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/sh4/cpu.h          |  5 -----
>  linux-user/sh4/cpu_loop.c |  2 +-
>  target/sh4/helper.c       | 26 ++++++++++++--------------
>  target/sh4/op_helper.c    |  9 +++------
>  4 files changed, 16 insertions(+), 26 deletions(-)
> 
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index 95094a517a..1f94e7bf7b 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -207,11 +207,6 @@ struct SuperHCPU {
>      CPUSH4State env;
>  };
>  
> -static inline SuperHCPU *sh_env_get_cpu(CPUSH4State *env)
> -{
> -    return container_of(env, SuperHCPU, env);
> -}
> -
>  #define ENV_OFFSET offsetof(SuperHCPU, env)
>  
>  void superh_cpu_do_interrupt(CPUState *cpu);
> diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
> index 47e54b9b61..677c5a461c 100644
> --- a/linux-user/sh4/cpu_loop.c
> +++ b/linux-user/sh4/cpu_loop.c
> @@ -23,7 +23,7 @@
>  
>  void cpu_loop(CPUSH4State *env)
>  {
> -    CPUState *cs = CPU(sh_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>      int trapnr, ret;
>      target_siginfo_t info;
>  
> diff --git a/target/sh4/helper.c b/target/sh4/helper.c
> index 2ff0cf4060..5240da715e 100644
> --- a/target/sh4/helper.c
> +++ b/target/sh4/helper.c
> @@ -238,8 +238,6 @@ static void update_itlb_use(CPUSH4State * env, int itlbnb)
>  
>  static int itlb_replacement(CPUSH4State * env)
>  {
> -    SuperHCPU *cpu = sh_env_get_cpu(env);
> -
>      if ((env->mmucr & 0xe0000000) == 0xe0000000) {
>  	return 0;
>      }
> @@ -252,7 +250,7 @@ static int itlb_replacement(CPUSH4State * env)
>      if ((env->mmucr & 0x2c000000) == 0x00000000) {
>  	return 3;
>      }
> -    cpu_abort(CPU(cpu), "Unhandled itlb_replacement");
> +    cpu_abort(env_cpu(env), "Unhandled itlb_replacement");
>  }
>  
>  /* Find the corresponding entry in the right TLB
> @@ -308,7 +306,7 @@ static int copy_utlb_entry_itlb(CPUSH4State *env, int utlb)
>      itlb = itlb_replacement(env);
>      ientry = &env->itlb[itlb];
>      if (ientry->v) {
> -        tlb_flush_page(CPU(sh_env_get_cpu(env)), ientry->vpn << 10);
> +        tlb_flush_page(env_cpu(env), ientry->vpn << 10);
>      }
>      *ientry = env->utlb[utlb];
>      update_itlb_use(env, itlb);
> @@ -533,14 +531,14 @@ hwaddr superh_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>  
>  void cpu_load_tlb(CPUSH4State * env)
>  {
> -    SuperHCPU *cpu = sh_env_get_cpu(env);
> +    CPUState *cs = env_cpu(env);
>      int n = cpu_mmucr_urc(env->mmucr);
>      tlb_t * entry = &env->utlb[n];
>  
>      if (entry->v) {
>          /* Overwriting valid entry in utlb. */
>          target_ulong address = entry->vpn << 10;
> -        tlb_flush_page(CPU(cpu), address);
> +        tlb_flush_page(cs, address);
>      }
>  
>      /* Take values into cpu status from registers. */
> @@ -563,7 +561,7 @@ void cpu_load_tlb(CPUSH4State * env)
>          entry->size = 1024 * 1024; /* 1M */
>          break;
>      default:
> -        cpu_abort(CPU(cpu), "Unhandled load_tlb");
> +        cpu_abort(cs, "Unhandled load_tlb");
>          break;
>      }
>      entry->sh   = (uint8_t)cpu_ptel_sh(env->ptel);
> @@ -590,7 +588,7 @@ void cpu_load_tlb(CPUSH4State * env)
>          entry->v = 0;
>      }
>  
> -    tlb_flush(CPU(sh_env_get_cpu(s)));
> +    tlb_flush(env_cpu(s));
>  }
>  
>  uint32_t cpu_sh4_read_mmaped_itlb_addr(CPUSH4State *s,
> @@ -616,7 +614,7 @@ void cpu_sh4_write_mmaped_itlb_addr(CPUSH4State *s, hwaddr addr,
>      if (entry->v) {
>          /* Overwriting valid entry in itlb. */
>          target_ulong address = entry->vpn << 10;
> -        tlb_flush_page(CPU(sh_env_get_cpu(s)), address);
> +        tlb_flush_page(env_cpu(s), address);
>      }
>      entry->asid = asid;
>      entry->vpn = vpn;
> @@ -658,7 +656,7 @@ void cpu_sh4_write_mmaped_itlb_data(CPUSH4State *s, hwaddr addr,
>          if (entry->v) {
>              /* Overwriting valid entry in utlb. */
>              target_ulong address = entry->vpn << 10;
> -            tlb_flush_page(CPU(sh_env_get_cpu(s)), address);
> +            tlb_flush_page(env_cpu(s), address);
>          }
>          entry->ppn = (mem_value & 0x1ffffc00) >> 10;
>          entry->v   = (mem_value & 0x00000100) >> 8;
> @@ -711,7 +709,7 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
>              if (entry->vpn == vpn
>                  && (!use_asid || entry->asid == asid || entry->sh)) {
>  	        if (utlb_match_entry) {
> -                    CPUState *cs = CPU(sh_env_get_cpu(s));
> +                    CPUState *cs = env_cpu(s);
>  
>  		    /* Multiple TLB Exception */
>                      cs->exception_index = 0x140;
> @@ -743,14 +741,14 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
>  	}
>  
>          if (needs_tlb_flush) {
> -            tlb_flush_page(CPU(sh_env_get_cpu(s)), vpn << 10);
> +            tlb_flush_page(env_cpu(s), vpn << 10);
>          }
>          
>      } else {
>          int index = (addr & 0x00003f00) >> 8;
>          tlb_t * entry = &s->utlb[index];
>  	if (entry->v) {
> -            CPUState *cs = CPU(sh_env_get_cpu(s));
> +            CPUState *cs = env_cpu(s);
>  
>  	    /* Overwriting valid entry in utlb. */
>              target_ulong address = entry->vpn << 10;
> @@ -805,7 +803,7 @@ void cpu_sh4_write_mmaped_utlb_data(CPUSH4State *s, hwaddr addr,
>          if (entry->v) {
>              /* Overwriting valid entry in utlb. */
>              target_ulong address = entry->vpn << 10;
> -            tlb_flush_page(CPU(sh_env_get_cpu(s)), address);
> +            tlb_flush_page(env_cpu(s), address);
>          }
>          entry->ppn = (mem_value & 0x1ffffc00) >> 10;
>          entry->v   = (mem_value & 0x00000100) >> 8;
> diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
> index 12fba6fc78..11cb68cc1c 100644
> --- a/target/sh4/op_helper.c
> +++ b/target/sh4/op_helper.c
> @@ -58,10 +58,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
>  void helper_ldtlb(CPUSH4State *env)
>  {
>  #ifdef CONFIG_USER_ONLY
> -    SuperHCPU *cpu = sh_env_get_cpu(env);
> -
> -    /* XXXXX */

Left-over from commit 43dc2a645e0, OK.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> -    cpu_abort(CPU(cpu), "Unhandled ldtlb");
> +    cpu_abort(env_cpu(env), "Unhandled ldtlb");
>  #else
>      cpu_load_tlb(env);
>  #endif
> @@ -70,7 +67,7 @@ void helper_ldtlb(CPUSH4State *env)
>  static inline void QEMU_NORETURN raise_exception(CPUSH4State *env, int index,
>                                                   uintptr_t retaddr)
>  {
> -    CPUState *cs = CPU(sh_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>  
>      cs->exception_index = index;
>      cpu_loop_exit_restore(cs, retaddr);
> @@ -103,7 +100,7 @@ void helper_debug(CPUSH4State *env)
>  
>  void helper_sleep(CPUSH4State *env)
>  {
> -    CPUState *cs = CPU(sh_env_get_cpu(env));
> +    CPUState *cs = env_cpu(env);
>  
>      cs->halted = 1;
>      env->in_sleep = 1;
> 
