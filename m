Received: from eggs.gnu.org ([2001:4830:134:3::10]:33984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eyEGA-0007Mq-1P
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eyEG5-0005wB-Om
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:12:49 -0400
References: <20180320020345.24930-1-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1c93e2e2-5c17-9bc3-7574-991ec7f7fbc9@redhat.com>
Date: Tue, 20 Mar 2018 11:12:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180320020345.24930-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Initialize lazy_tlb_flush
 correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, peter.maydell@linaro.org, balaton@eik.bme.hu
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 20.03.2018 03:03, David Gibson wrote:
> ppc_tr_init_disas_context() correctly sets lazy_tlb_flush to true on
> certain CPU models.  However, it leaves it uninitialized, instead of
> setting it to false on all others.
> 
> It wasn't caught before now because we didn't have examples in the tests
> that exercised this path.  However it can now be caught using clang's
> undefined behaviour sanitizer and the sam460ex board.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/translate.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 218665b408..3457d29f8e 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -7237,10 +7237,9 @@ static int ppc_tr_init_disas_context(DisasContextBase *dcbase,
>      ctx->sf_mode = msr_is_64bit(env, env->msr);
>      ctx->has_cfar = !!(env->flags & POWERPC_FLAG_CFAR);
>  #endif
> -    if (env->mmu_model == POWERPC_MMU_32B ||
> -        env->mmu_model == POWERPC_MMU_601 ||
> -        (env->mmu_model & POWERPC_MMU_64B))
> -            ctx->lazy_tlb_flush = true;
> +    ctx->lazy_tlb_flush = env->mmu_model == POWERPC_MMU_32B
> +        || env->mmu_model == POWERPC_MMU_601
> +        || (env->mmu_model & POWERPC_MMU_64B);
>  
>      ctx->fpu_enabled = !!msr_fp;
>      if ((env->flags & POWERPC_FLAG_SPE) && msr_spe)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
