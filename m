Received: from eggs.gnu.org ([2001:4830:134:3::10]:35821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eyEPY-0001y3-9C
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eyEPU-00020n-AO
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:22:32 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:41327)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eyEPU-00020L-3c
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:22:28 -0400
Received: from player771.ha.ovh.net (unknown [10.109.105.149])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 11727A76DF
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 11:22:25 +0100 (CET)
Date: Tue, 20 Mar 2018 11:22:19 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180320112219.0546d56c@bahia.lan>
In-Reply-To: <20180320020345.24930-1-david@gibson.dropbear.id.au>
References: <20180320020345.24930-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: thuth@redhat.com, peter.maydell@linaro.org, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 20 Mar 2018 13:03:45 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

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

Reviewed-by: Greg Kurz <groug@kaod.org>

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
