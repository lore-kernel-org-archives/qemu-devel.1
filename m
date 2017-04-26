Received: from eggs.gnu.org ([2001:4830:134:3::10]:41738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3WBn-0007Oq-7t
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 19:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3WBm-0005vP-5b
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 19:17:39 -0400
Date: Wed, 26 Apr 2017 19:17:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170426231732.GA27379@flamenco>
References: <1493187803-4510-1-git-send-email-cota@braap.org>
	<1493187803-4510-2-git-send-email-cota@braap.org>
	<e206fe3e-5920-49c5-8f95-e4961aad5f89@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e206fe3e-5920-49c5-8f95-e4961aad5f89@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 01/10] tcg-runtime: add lookup_tb_ptr
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

On Wed, Apr 26, 2017 at 10:40:45 +0200, Richard Henderson wrote:
> On 04/26/2017 08:23 AM, Emilio G. Cota wrote:
> >This paves the way for upcoming work.
> >
> >Reviewed-by: Richard Henderson <rth@twiddle.net>
> >Signed-off-by: Emilio G. Cota <cota@braap.org>
> >---
> >  tcg-runtime.c     | 21 +++++++++++++++++++++
> >  tcg/tcg-runtime.h |  2 ++
> >  tcg/tcg.h         |  1 +
> >  3 files changed, 24 insertions(+)
> >
> >diff --git a/tcg-runtime.c b/tcg-runtime.c
> >index 4c60c96..90d2d4b 100644
> >--- a/tcg-runtime.c
> >+++ b/tcg-runtime.c
> >@@ -27,6 +27,7 @@
> >  #include "exec/helper-proto.h"
> >  #include "exec/cpu_ldst.h"
> >  #include "exec/exec-all.h"
> >+#include "exec/tb-hash.h"
> >  /* 32-bit helpers */
> >@@ -141,6 +142,26 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
> >      return ctpop64(arg);
> >  }
> >+    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
> >+    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
> >+    if (likely(tb && tb->pc == addr && tb->cs_base == cs_base &&
> >+               tb->flags == flags)) {
> 
> This comparison is wrong.  It will incorrectly reject a TB for i386 guest
> when CS_BASE != 0.  You really want
> 
>   tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
>   if (tb) {
>     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>     if (tb->pc == pc && tb->cs_base == cs_base && tb->flags == flags) {
>       return tb->tc_ptr;
>     }
>   }
>   return tcg_ctx.code_gen_epilogue;
> 
> where you don't even load the cpu state if there isn't a preliminary hit in
> the cache.

Yes, I like this.

> (Note to self: That minor optimization would also apply to tb_find.)

FWIW I looked at tb_find -- you need the pc though, which comes from
loading the CPU state:

    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
                               ^^
    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(pc)]);
                                                                   ^^

If we wanted to really avoid getting all the state I guess we'd have to add
another function that returned just the pc.

		E.
