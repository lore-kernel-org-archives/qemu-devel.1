Received: from eggs.gnu.org ([2001:4830:134:3::10]:33517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLEt8-0007Ea-60
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLEt4-0004e9-7L
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:27:38 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40741)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dLEt4-0004dq-0j
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:27:34 -0400
Date: Wed, 14 Jun 2017 16:27:33 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170614202733.GA8420@flamenco>
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-2-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170614194821.8754-2-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH] tcg-runtime: increase hit rate of lookup_tb_ptr
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
> We can call tb_htable_lookup even when the tb_jmp_cache
> is completely empty.  Therefore, un-nest most of the code
> dependent on tb != NULL from the read from the cache.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

I just wrote this alternative patch, which does the same thing
as yours. I also measured what the effect of this change
has on the hit rate of lookup_tb_ptr. Feel free to reuse parts
of the patch and/or the commit message!

Thanks,

		E.

--- 8< ---

Strangely, we do not look up the tb in the global hash table
when we get NULL from tb_jmp_cache.

Fix it, which improves the hit rate of lookup_tb_ptr; for instance,
when booting and immediately shutting down debian-arm, the hit
rate improves from
	93.150742% (before this patch)
to
	99.451323 % (after).

While at it, use a variable for the tb_jmp_cache hash and get rid
of the goto's.

Suggested-by: Richard Henderson <rth@twiddle.net>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg-runtime.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tcg-runtime.c b/tcg-runtime.c
index 7fa90ce..09324b9 100644
--- a/tcg-runtime.c
+++ b/tcg-runtime.c
@@ -149,23 +149,19 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
     CPUState *cpu = ENV_GET_CPU(env);
     TranslationBlock *tb;
     target_ulong cs_base, pc;
+    unsigned int hash = tb_jmp_cache_hash_func(addr);
     uint32_t flags;
 
-    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
-    if (likely(tb)) {
-        cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
-        if (likely(tb->pc == addr && tb->cs_base == cs_base &&
-                   tb->flags == flags)) {
-            goto found;
-        }
+    tb = atomic_rcu_read(&cpu->tb_jmp_cache[hash]);
+    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
+    if (unlikely(tb == NULL || tb->pc != addr || tb->cs_base != cs_base ||
+               tb->flags != flags)) {
         tb = tb_htable_lookup(cpu, addr, cs_base, flags);
-        if (likely(tb)) {
-            atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)], tb);
-            goto found;
+        if (unlikely(tb == NULL)) {
+            return tcg_ctx.code_gen_epilogue;
         }
+        atomic_set(&cpu->tb_jmp_cache[hash], tb);
     }
-    return tcg_ctx.code_gen_epilogue;
- found:
     qemu_log_mask_and_addr(CPU_LOG_EXEC, addr,
                            "Chain %p [%d: " TARGET_FMT_lx "] %s\n",
                            tb->tc_ptr, cpu->cpu_index, addr,
-- 
2.7.4
