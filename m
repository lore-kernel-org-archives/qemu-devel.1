Received: from eggs.gnu.org ([209.51.188.92]:52146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ghc8b-0005DL-Kk
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ghc8Z-00018m-Mj
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:20:53 -0500
References: <20190108163008.7006-1-peter.maydell@linaro.org>
	<20190108163008.7006-4-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <ba240a70-d51f-96d8-5edd-1178818978e4@greensocs.com>
Date: Thu, 10 Jan 2019 16:14:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190108163008.7006-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-classic
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] accel/tcg: Add cluster number to TCG
 TB hash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>, "Emilio G . Cota" <cota@braap.org>, patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 1/8/19 5:30 PM, Peter Maydell wrote:
> Include the cluster number in the hash we use to look
> up TBs. This is important because a TB that is valid
> for one cluster at a given physical address and set
> of CPU flags is not necessarily valid for another:
> the two clusters may have different views of physical
> memory, or may have different CPU features (eg FPU
> present or absent).
> 
> We put the cluster number in the high 8 bits of the
> TB cflags. This gives us up to 256 clusters, which should
> be enough for anybody. If we ever need more, or need
> more bits in cflags for other purposes, we could make
> tb_hash_func() take more data (and expand qemu_xxhash7()
> to qemu_xxhash8()).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  include/exec/exec-all.h   | 4 +++-
>  accel/tcg/cpu-exec.c      | 4 ++++
>  accel/tcg/translate-all.c | 3 +++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 815e5b1e838..aa7b81aaf01 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -351,9 +351,11 @@ struct TranslationBlock {
>  #define CF_USE_ICOUNT  0x00020000
>  #define CF_INVALID     0x00040000 /* TB is stale. Set with @jmp_lock held */
>  #define CF_PARALLEL    0x00080000 /* Generate code for a parallel context */
> +#define CF_CLUSTER_MASK 0xff000000 /* Top 8 bits are cluster ID */
> +#define CF_CLUSTER_SHIFT 24
>  /* cflags' mask for hashing/comparison */
>  #define CF_HASH_MASK   \
> -    (CF_COUNT_MASK | CF_LAST_IO | CF_USE_ICOUNT | CF_PARALLEL)
> +    (CF_COUNT_MASK | CF_LAST_IO | CF_USE_ICOUNT | CF_PARALLEL | CF_CLUSTER_MASK)
>  
>      /* Per-vCPU dynamic tracing state used to generate this TB */
>      uint32_t trace_vcpu_dstate;
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 870027d4359..e578a1a3aee 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -336,6 +336,10 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
>          return NULL;
>      }
>      desc.phys_page1 = phys_pc & TARGET_PAGE_MASK;
> +
> +    cf_mask &= ~CF_CLUSTER_MASK;
> +    cf_mask |= cpu->cluster_index << CF_CLUSTER_SHIFT;
> +
>      h = tb_hash_func(phys_pc, pc, flags, cf_mask, *cpu->trace_dstate);
>      return qht_lookup_custom(&tb_ctx.htable, &desc, h, tb_lookup_cmp);
>  }
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 639f0b27287..ba27f5acc8c 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1692,6 +1692,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>          cflags |= CF_NOCACHE | 1;
>      }
>  
> +    cflags &= ~CF_CLUSTER_MASK;
> +    cflags |= cpu->cluster_index << CF_CLUSTER_SHIFT;
> +
>   buffer_overflow:
>      tb = tb_alloc(pc);
>      if (unlikely(!tb)) {
> 
