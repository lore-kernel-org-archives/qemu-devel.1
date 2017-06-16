Received: from eggs.gnu.org ([2001:4830:134:3::10]:35064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLxiJ-0000Lv-PZ
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 16:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLxiG-0003Np-L6
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 16:19:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46029)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dLxiG-0003Ni-Cg
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 16:19:24 -0400
Date: Fri, 16 Jun 2017 16:19:21 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170616201921.GB27617@flamenco>
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-2-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614194821.8754-2-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] tcg: Refactor helper_lookup_tb_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, pbonzini@redhat.com

On Wed, Jun 14, 2017 at 12:48:17 -0700, Richard Henderson wrote:
> --- a/tcg-runtime.c
> +++ b/tcg-runtime.c
(snip)
>          tb = tb_htable_lookup(cpu, addr, cs_base, flags);
> -        if (likely(tb)) {
> -            atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)], tb);
> -            goto found;
> +        if (!tb) {
> +            return ret;

While booting debian-arm I'm measuring (see below) a hit rate in the
high 90's for the htable lookups here, so adding an 'unlikely()'
hint would be a good idea.

[ I'm using the patch currently in your tcg-next branch, i.e. 0a2adf4e2 ]

		E.

The below prints during bootup+shutdown:

hit rate: 94.599500%
hit rate: 95.794100%
hit rate: 96.617900%
hit rate: 96.527275%
hit rate: 96.341320%
hit rate: 96.641883%


diff --git a/tcg-runtime.c b/tcg-runtime.c
index ec3a34e..addc3fa 100644
--- a/tcg-runtime.c
+++ b/tcg-runtime.c
@@ -150,6 +150,7 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags, addr_hash;
+    static unsigned long long accesses, found;

     addr_hash = tb_jmp_cache_hash_func(addr);
     tb = atomic_rcu_read(&cpu->tb_jmp_cache[addr_hash]);
@@ -159,11 +160,16 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
                    && tb->pc == addr
                    && tb->cs_base == cs_base
                    && tb->flags == flags))) {
+        accesses++;
+        if (!(accesses % 1000000)) {
+            fprintf(stderr, "hit rate: %f%%\n", (double)found * 100 / accesses);
+        }
         tb = tb_htable_lookup(cpu, addr, cs_base, flags);
         if (!tb) {
             return tcg_ctx.code_gen_epilogue;
         }
         atomic_set(&cpu->tb_jmp_cache[addr_hash], tb);
+        found++;
     }

     qemu_log_mask_and_addr(CPU_LOG_EXEC, addr,
