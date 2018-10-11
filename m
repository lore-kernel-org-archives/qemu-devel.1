Received: from eggs.gnu.org ([2001:4830:134:3::10]:47241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAYcb-0006yZ-1C
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAYcV-00036d-8R
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:55:12 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAYcU-0002st-VT
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 06:55:07 -0400
Received: by mail-wr1-f41.google.com with SMTP id 63-v6so9146955wra.11
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 03:55:06 -0700 (PDT)
References: <20181003193931.18096-1-richard.henderson@linaro.org>
	<20181003193931.18096-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ad0f159b-0404-86de-5dac-d942ad20f91e@redhat.com>
Date: Thu, 11 Oct 2018 12:55:02 +0200
MIME-Version: 1.0
In-Reply-To: <20181003193931.18096-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 4/9] target/arm: Check HAVE_CMPXCHG128
 at translate time
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
>  target/arm/helper-a64.c    | 16 ++++------------
>  target/arm/translate-a64.c | 38 ++++++++++++++++++++++----------------
>  2 files changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index 6e4e1b8a19..61799d20e1 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -563,9 +563,7 @@ uint64_t HELPER(paired_cmpxchg64_le_parallel)(CPUARMState *env, uint64_t addr,
>      int mem_idx;
>      TCGMemOpIdx oi;
>  
> -    if (!HAVE_CMPXCHG128) {
> -        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
> -    }
> +    assert(HAVE_CMPXCHG128);
>  
>      mem_idx = cpu_mmu_index(env, false);
>      oi = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
> @@ -635,9 +633,7 @@ uint64_t HELPER(paired_cmpxchg64_be_parallel)(CPUARMState *env, uint64_t addr,
>      int mem_idx;
>      TCGMemOpIdx oi;
>  
> -    if (!HAVE_CMPXCHG128) {
> -        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
> -    }
> +    assert(HAVE_CMPXCHG128);
>  
>      mem_idx = cpu_mmu_index(env, false);
>      oi = make_memop_idx(MO_BEQ | MO_ALIGN_16, mem_idx);
> @@ -663,9 +659,7 @@ void HELPER(casp_le_parallel)(CPUARMState *env, uint32_t rs, uint64_t addr,
>      int mem_idx;
>      TCGMemOpIdx oi;
>  
> -    if (!HAVE_CMPXCHG128) {
> -        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
> -    }
> +    assert(HAVE_CMPXCHG128);
>  
>      mem_idx = cpu_mmu_index(env, false);
>      oi = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
> @@ -686,9 +680,7 @@ void HELPER(casp_be_parallel)(CPUARMState *env, uint32_t rs, uint64_t addr,
>      int mem_idx;
>      TCGMemOpIdx oi;
>  
> -    if (!HAVE_CMPXCHG128) {
> -        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
> -    }
> +    assert(HAVE_CMPXCHG128);
>  
>      mem_idx = cpu_mmu_index(env, false);
>      oi = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 8ca3876707..77ee8d9085 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -37,6 +37,7 @@
>  
>  #include "trace-tcg.h"
>  #include "translate-a64.h"
> +#include "qemu/atomic128.h"
>  
>  static TCGv_i64 cpu_X[32];
>  static TCGv_i64 cpu_pc;
> @@ -2082,26 +2083,27 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
>                                         get_mem_index(s),
>                                         MO_64 | MO_ALIGN | s->be_data);
>              tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, cpu_exclusive_val);
> -        } else if (s->be_data == MO_LE) {
> -            if (tb_cflags(s->base.tb) & CF_PARALLEL) {
> +        } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
> +            if (!HAVE_CMPXCHG128) {
> +                gen_helper_exit_atomic(cpu_env);
> +                s->base.is_jmp = DISAS_NORETURN;
> +            } else if (s->be_data == MO_LE) {
>                  gen_helper_paired_cmpxchg64_le_parallel(tmp, cpu_env,
>                                                          cpu_exclusive_addr,
>                                                          cpu_reg(s, rt),
>                                                          cpu_reg(s, rt2));
>              } else {
> -                gen_helper_paired_cmpxchg64_le(tmp, cpu_env, cpu_exclusive_addr,
> -                                               cpu_reg(s, rt), cpu_reg(s, rt2));
> -            }
> -        } else {
> -            if (tb_cflags(s->base.tb) & CF_PARALLEL) {
>                  gen_helper_paired_cmpxchg64_be_parallel(tmp, cpu_env,
>                                                          cpu_exclusive_addr,
>                                                          cpu_reg(s, rt),
>                                                          cpu_reg(s, rt2));
> -            } else {
> -                gen_helper_paired_cmpxchg64_be(tmp, cpu_env, cpu_exclusive_addr,
> -                                               cpu_reg(s, rt), cpu_reg(s, rt2));
>              }
> +        } else if (s->be_data == MO_LE) {
> +            gen_helper_paired_cmpxchg64_le(tmp, cpu_env, cpu_exclusive_addr,
> +                                           cpu_reg(s, rt), cpu_reg(s, rt2));
> +        } else {
> +            gen_helper_paired_cmpxchg64_be(tmp, cpu_env, cpu_exclusive_addr,
> +                                           cpu_reg(s, rt), cpu_reg(s, rt2));
>          }
>      } else {
>          tcg_gen_atomic_cmpxchg_i64(tmp, cpu_exclusive_addr, cpu_exclusive_val,
> @@ -2171,14 +2173,18 @@ static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
>          }
>          tcg_temp_free_i64(cmp);
>      } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
> -        TCGv_i32 tcg_rs = tcg_const_i32(rs);
> -
> -        if (s->be_data == MO_LE) {
> -            gen_helper_casp_le_parallel(cpu_env, tcg_rs, addr, t1, t2);
> +        if (HAVE_CMPXCHG128) {
> +            TCGv_i32 tcg_rs = tcg_const_i32(rs);
> +            if (s->be_data == MO_LE) {
> +                gen_helper_casp_le_parallel(cpu_env, tcg_rs, addr, t1, t2);
> +            } else {
> +                gen_helper_casp_be_parallel(cpu_env, tcg_rs, addr, t1, t2);
> +            }
> +            tcg_temp_free_i32(tcg_rs);
>          } else {
> -            gen_helper_casp_be_parallel(cpu_env, tcg_rs, addr, t1, t2);
> +            gen_helper_exit_atomic(cpu_env);
> +            s->base.is_jmp = DISAS_NORETURN;
>          }
> -        tcg_temp_free_i32(tcg_rs);
>      } else {
>          TCGv_i64 d1 = tcg_temp_new_i64();
>          TCGv_i64 d2 = tcg_temp_new_i64();
> 
