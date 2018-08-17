Received: from eggs.gnu.org ([2001:4830:134:3::10]:58908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqiAT-0003YN-A0
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqiAM-0002w8-UQ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:04:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44773)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fqiAL-0002ur-M9
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:04:02 -0400
Date: Fri, 17 Aug 2018 13:03:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180817170359.GC7067@flamenco>
References: <20180816025452.21358-1-richard.henderson@linaro.org>
	<20180816025452.21358-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816025452.21358-4-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 3/5] target/s390x: Convert to
 HAVE_CMPXCHG128 and HAVE_ATOMIC128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Wed, Aug 15, 2018 at 19:54:50 -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/mem_helper.c | 87 +++++++++++++++++----------------------
>  1 file changed, 37 insertions(+), 50 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index e21a47fb4d..908b1254c8 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -25,6 +25,7 @@
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
>  #include "qemu/int128.h"
> +#include "qemu/atomic128.h"
>  
>  #if !defined(CONFIG_USER_ONLY)
>  #include "hw/s390x/storage-keys.h"
> @@ -1375,7 +1376,7 @@ static void do_cdsg(CPUS390XState *env, uint64_t addr,
>      bool fail;
>  
>      if (parallel) {
> -#ifndef CONFIG_ATOMIC128
> +#if !HAVE_CMPXCHG128
>          cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
>  #else
>          int mem_idx = cpu_mmu_index(env, false);
> @@ -1421,12 +1422,10 @@ void HELPER(cdsg_parallel)(CPUS390XState *env, uint64_t addr,
>  static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
>                          uint64_t a2, bool parallel)
>  {
> -#if !defined(CONFIG_USER_ONLY) || defined(CONFIG_ATOMIC128)
>      uint32_t mem_idx = cpu_mmu_index(env, false);
> -#endif
>      uintptr_t ra = GETPC();
> -    uint32_t fc = extract32(env->regs[0], 0, 8);
> -    uint32_t sc = extract32(env->regs[0], 8, 8);
> +    uint32_t fc = extract32(env->regs[0], 0, 8), fsize = 4 << fc;
> +    uint32_t sc = extract32(env->regs[0], 8, 8), ssize = 1 << sc;

Please put these in separate lines.

>      uint64_t pl = get_address(env, 1) & -16;
>      uint64_t svh, svl;
>      uint32_t cc;
> @@ -1442,7 +1441,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
>      }
>  
>      /* Sanity check the alignments.  */
> -    if (extract32(a1, 0, 4 << fc) || extract32(a2, 0, 1 << sc)) {
> +    if (extract32(a1, 0, fsize) || extract32(a2, 0, ssize)) {
>          goto spec_exception;
>      }
>  
> @@ -1456,13 +1455,12 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
>         context in order to implement this.  That said, restart early if we can't
>         support either operation that is supposed to be atomic.  */
>      if (parallel) {
> -        int mask = 0;
> -#if !defined(CONFIG_ATOMIC64)
> -        mask = -8;
> -#elif !defined(CONFIG_ATOMIC128)
> -        mask = -16;
> +        uint32_t max = 4;
> +#ifdef CONFIG_ATOMIC64
> +        max = 8;
>  #endif
> -        if (((4 << fc) | (1 << sc)) & mask) {
> +        if ((HAVE_CMPXCHG128 ? 0 : fsize > max) ||
> +            (HAVE_ATOMIC128  ? 0 : ssize > max)) {

I don't know what fsize/ssize are, so this is hard to review
for me--just opened the PoO for the first time ever, and I'm
even more confused :-)

The rest of the patch looks good though; the HAVE_ macros
really help keep the code neat.

		Emilio
