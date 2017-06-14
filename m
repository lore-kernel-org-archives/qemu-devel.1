Received: from eggs.gnu.org ([2001:4830:134:3::10]:45053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL0mA-0001ud-Ky
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL0m9-0007P3-PP
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:23:30 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dL0m9-0007Om-L4
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 01:23:29 -0400
Received: by mail-qt0-x242.google.com with SMTP id s33so39071596qtg.3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 22:23:29 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 13 Jun 2017 22:23:11 -0700
Message-Id: <20170614052311.13785-11-rth@twiddle.net>
In-Reply-To: <20170614052311.13785-1-rth@twiddle.net>
References: <20170614052311.13785-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 10/10] tcg: Remove tb_htable_lookup from
 helper_lookup_tb_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This appears to induce lockups, or maybe livelocks, while booting an
Alpha Linux kernel.  The assumption is that there is a bug elsewhere
within QEMU, but reverting the patch allows normal work to continue
in the meantime.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg-runtime.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/tcg-runtime.c b/tcg-runtime.c
index 7fa90ce..cc3bbaf 100644
--- a/tcg-runtime.c
+++ b/tcg-runtime.c
@@ -147,30 +147,24 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
 void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
 {
     CPUState *cpu = ENV_GET_CPU(env);
-    TranslationBlock *tb;
-    target_ulong cs_base, pc;
-    uint32_t flags;
+    unsigned int hash = tb_jmp_cache_hash_func(addr);
+    TranslationBlock *tb = atomic_rcu_read(&cpu->tb_jmp_cache[hash]);
+    void *ret = tcg_ctx.code_gen_epilogue;
 
-    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
     if (likely(tb)) {
+        target_ulong cs_base, pc;
+        uint32_t flags;
+
         cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
-        if (likely(tb->pc == addr && tb->cs_base == cs_base &&
-                   tb->flags == flags)) {
-            goto found;
-        }
-        tb = tb_htable_lookup(cpu, addr, cs_base, flags);
-        if (likely(tb)) {
-            atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)], tb);
-            goto found;
+        if (tb->pc == addr && tb->cs_base == cs_base && tb->flags == flags) {
+            ret = tb->tc_ptr;
+            qemu_log_mask_and_addr(CPU_LOG_EXEC, addr,
+                                   "Chain %p [%d: " TARGET_FMT_lx "] %s\n",
+                                   ret, cpu->cpu_index, addr,
+                                   lookup_symbol(addr));
         }
     }
-    return tcg_ctx.code_gen_epilogue;
- found:
-    qemu_log_mask_and_addr(CPU_LOG_EXEC, addr,
-                           "Chain %p [%d: " TARGET_FMT_lx "] %s\n",
-                           tb->tc_ptr, cpu->cpu_index, addr,
-                           lookup_symbol(addr));
-    return tb->tc_ptr;
+    return ret;
 }
 
 void HELPER(exit_atomic)(CPUArchState *env)
-- 
2.9.4
