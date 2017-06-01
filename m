Received: from eggs.gnu.org ([2001:4830:134:3::10]:42758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dGVqU-0004F6-OL
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dGVqS-0004C4-3e
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:33:22 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37033)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dGVqR-00046w-Ti
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:33:20 -0400
Date: Thu, 1 Jun 2017 15:33:17 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170601193317.GA10517@flamenco>
References: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
	<148434051502.31446.15856830123123961768.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <148434051502.31446.15856830123123961768.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v7 4/7] exec: [tcg] Use different TBs
 according to the vCPU's dynamic tracing state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jan 13, 2017 at 21:48:35 +0100, Lluís Vilanova wrote:
>  9 files changed, 54 insertions(+), 11 deletions(-)
> 
> diff --git a/cpu-exec.c b/cpu-exec.c
> index 4188fed3c6..36709cba1f 100644
> --- a/cpu-exec.c
> +++ b/cpu-exec.c
> @@ -261,6 +261,7 @@ struct tb_desc {
>      CPUArchState *env;
>      tb_page_addr_t phys_page1;
>      uint32_t flags;
> +    TRACE_QHT_VCPU_DSTATE_TYPE trace_vcpu_dstate;
(snip)
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 57cd978578..ae74f61ea2 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -200,6 +200,10 @@ static inline void tlb_flush_by_mmuidx(CPUState *cpu, ...)
>  #define USE_DIRECT_JUMP
>  #endif
>  
> +/**
> + * TranslationBlock:
> + * @trace_vcpu_dstate: Per-vCPU dynamic tracing state used to generate this TB.
> + */
>  struct TranslationBlock {
>      target_ulong pc;   /* simulated PC corresponding to this block (EIP + CS base) */
>      target_ulong cs_base; /* CS base for this block */
> @@ -215,6 +219,7 @@ struct TranslationBlock {
>  #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
>  
>      uint16_t invalid;
> +    TRACE_QHT_VCPU_DSTATE_TYPE trace_vcpu_dstate;
(snip)
> --- a/include/exec/tb-hash-xx.h
> +++ b/include/exec/tb-hash-xx.h
> @@ -35,6 +35,7 @@
>  #define EXEC_TB_HASH_XX_H
>  
>  #include "qemu/bitops.h"
> +#include "qemu-common.h"
>  
>  #define PRIME32_1   2654435761U
>  #define PRIME32_2   2246822519U
> @@ -49,7 +50,8 @@
>   * contiguous in memory.
>   */
>  static inline
> -uint32_t tb_hash_func5(uint64_t a0, uint64_t b0, uint32_t e)
> +uint32_t tb_hash_func6(uint64_t a0, uint64_t b0, uint32_t e,
> +                       TRACE_QHT_VCPU_DSTATE_TYPE f)

I find this typedef unnecessary. Why not use u32 everywhere?
If ever we need more bits, then we'll add additional u32's here
as well.

Also, including above qemu-common.h goes against the spirit of
keeping this file (as well as tb-hash.h) free of external
dependences. (originally tb-hash.h's contents were in exec-all.h)

If we're worried about forgetting to update the hash function,
we could have a compile-time check + a comment elsewhere
(e.g. translate-all.c).

>  {
>      uint32_t v1 = TB_HASH_XX_SEED + PRIME32_1 + PRIME32_2;
>      uint32_t v2 = TB_HASH_XX_SEED + PRIME32_2;
> @@ -83,6 +85,10 @@ uint32_t tb_hash_func5(uint64_t a0, uint64_t b0, uint32_t e)
Right here you should also do:

@@ -78,7 +78,7 @@ uint32_t tb_hash_func5(uint64_t a0, uint64_t b0, uint32_t e)
     v4 *= PRIME32_1;

     h32 = rol32(v1, 1) + rol32(v2, 7) + rol32(v3, 12) + rol32(v4, 18);
-    h32 += 20;
+    h32 += 24;

to take into account the newly added parameter.

>      h32 += e * PRIME32_3;
>      h32  = rol32(h32, 17) * PRIME32_4;
>  
> +    QEMU_BUILD_BUG_ON(sizeof(TRACE_QHT_VCPU_DSTATE_TYPE) != sizeof(uint32_t));
> +    h32 += f * PRIME32_3;
> +    h32  = rol32(h32, 17) * PRIME32_4;

If we get rid of the typedef, this compile-time check will go away too.

(snip)
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index 1430390eb6..aaaa73a6fe 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -151,4 +151,7 @@ void page_size_init(void);
>   * returned. */
>  bool dump_in_progress(void);
>  
> +/* Use a macro to allow safe changes to its size in the future */
> +#define TRACE_QHT_VCPU_DSTATE_TYPE uint32_t
> +
(snip)
> diff --git a/translate-all.c b/translate-all.c
> index 29ccb9e546..6e1b1d474c 100644
> --- a/translate-all.c
> +++ b/translate-all.c
> @@ -54,6 +54,7 @@
>  #include "exec/tb-hash.h"
>  #include "translate-all.h"
>  #include "qemu/bitmap.h"
> +#include "qemu/error-report.h"
>  #include "qemu/timer.h"
>  #include "exec/log.h"
>  
> @@ -813,6 +814,12 @@ static void tb_htable_init(void)
>  {
>      unsigned int mode = QHT_MODE_AUTO_RESIZE;
>  
> +    /* Ensure TB hash function covers the bitmap size */
> +    if (DIV_ROUND_UP(trace_get_vcpu_event_count(), BITS_PER_BYTE) >
> +        sizeof(TRACE_QHT_VCPU_DSTATE_TYPE)) {
> +        error_report("too many 'vcpu' events for the TB hash function");
> +    }
> +

This is a better place to do the above check, I think.

Thanks,

		Emilio
