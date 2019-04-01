Received: from eggs.gnu.org ([209.51.188.92]:49694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hAvoz-0003FW-2j
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hAvoy-0003E2-1Q
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:13:49 -0400
References: <20190401102911.8685-1-richard.henderson@linaro.org>
	<20190401102911.8685-2-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <643efe1a-e6a5-a882-8469-47001d879591@redhat.com>
Date: Mon, 1 Apr 2019 14:13:42 +0200
MIME-Version: 1.0
In-Reply-To: <20190401102911.8685-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 1/6] target/s390x: Truncate 32-bit
 psw_addr before creating TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, qemu-s390x@nongnu.org

On 01.04.19 12:29, Richard Henderson wrote:
> If, somehow, the psw_addr is out of range, truncate early
> rather than after we get into gen_intermediate_code.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/cpu.h       | 26 +++++++++++++++++++-------
>  target/s390x/translate.c |  6 ------
>  2 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index cb6d77053a..6ccf41fc45 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -368,18 +368,30 @@ static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
>      }
>  }
>  
> -static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
> -                                        target_ulong *cs_base, uint32_t *flags)
> +static inline void cpu_get_tb_cpu_state(CPUS390XState* env,
> +                                        target_ulong *p_pc,
> +                                        target_ulong *cs_base,
> +                                        uint32_t *p_flags)
>  {
> -    *pc = env->psw.addr;
> -    *cs_base = env->ex_value;
> -    *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
> +    uint32_t flags;
> +    uint64_t pc;
> +
> +    flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
>      if (env->cregs[0] & CR0_AFP) {
> -        *flags |= FLAG_MASK_AFP;
> +        flags |= FLAG_MASK_AFP;
>      }
>      if (env->cregs[0] & CR0_VECTOR) {
> -        *flags |= FLAG_MASK_VECTOR;
> +        flags |= FLAG_MASK_VECTOR;
>      }
> +
> +    pc = env->psw.addr;
> +    if (!(flags & FLAG_MASK_64)) {
> +        pc &= 0x7fffffff;
> +    }
> +
> +    *p_pc = pc;
> +    *cs_base = env->ex_value;
> +    *p_flags = flags;
>  }
>  
>  /* PER bits from control register 9 */
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 0afa8f7ca5..d22d0f7643 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -6442,12 +6442,6 @@ static void s390x_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>  {
>      DisasContext *dc = container_of(dcbase, DisasContext, base);
>  
> -    /* 31-bit mode */
> -    if (!(dc->base.tb->flags & FLAG_MASK_64)) {
> -        dc->base.pc_first &= 0x7fffffff;
> -        dc->base.pc_next = dc->base.pc_first;
> -    }
> -
>      dc->cc_op = CC_OP_DYNAMIC;
>      dc->ex_value = dc->base.tb->cs_base;
>      dc->do_debug = dc->base.singlestep_enabled;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
