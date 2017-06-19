Received: from eggs.gnu.org ([2001:4830:134:3::10]:33384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GJ-0008Q3-4o
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GH-0002HI-8k
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:55 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:32770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN1GH-0002H7-2l
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:53 -0400
Received: by mail-pf0-x244.google.com with SMTP id w12so18591893pfk.0
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 11:18:53 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 11:18:36 -0700
Message-Id: <20170619181839.25249-10-rth@twiddle.net>
In-Reply-To: <20170619181839.25249-1-rth@twiddle.net>
References: <20170619181839.25249-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/12] tcg: Increase hit rate of lookup_tb_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G . Cota" <cota@braap.org>

We can call tb_htable_lookup even when the tb_jmp_cache is completely
empty.  Therefore, un-nest most of the code dependent on tb != NULL
from the read from the cache.

This improves the hit rate of lookup_tb_ptr; for instance, when booting
and immediately shutting down debian-arm, the hit rate improves from
93.2% to 99.4%.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg-runtime.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tcg-runtime.c b/tcg-runtime.c
index 7fa90ce..ec3a34e 100644
--- a/tcg-runtime.c
+++ b/tcg-runtime.c
@@ -149,23 +149,23 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
     CPUState *cpu = ENV_GET_CPU(env);
     TranslationBlock *tb;
     target_ulong cs_base, pc;
-    uint32_t flags;
-
-    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
-    if (likely(tb)) {
-        cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
-        if (likely(tb->pc == addr && tb->cs_base == cs_base &&
-                   tb->flags == flags)) {
-            goto found;
-        }
+    uint32_t flags, addr_hash;
+
+    addr_hash = tb_jmp_cache_hash_func(addr);
+    tb = atomic_rcu_read(&cpu->tb_jmp_cache[addr_hash]);
+    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
+
+    if (unlikely(!(tb
+                   && tb->pc == addr
+                   && tb->cs_base == cs_base
+                   && tb->flags == flags))) {
         tb = tb_htable_lookup(cpu, addr, cs_base, flags);
-        if (likely(tb)) {
-            atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)], tb);
-            goto found;
+        if (!tb) {
+            return tcg_ctx.code_gen_epilogue;
         }
+        atomic_set(&cpu->tb_jmp_cache[addr_hash], tb);
     }
-    return tcg_ctx.code_gen_epilogue;
- found:
+
     qemu_log_mask_and_addr(CPU_LOG_EXEC, addr,
                            "Chain %p [%d: " TARGET_FMT_lx "] %s\n",
                            tb->tc_ptr, cpu->cpu_index, addr,
-- 
2.9.4
