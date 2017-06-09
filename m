Received: from eggs.gnu.org ([2001:4830:134:3::10]:58504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dJNHD-00056z-Po
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 13:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dJNHC-0004id-Th
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 13:00:47 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dJNHC-0004iN-NR
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 13:00:46 -0400
Received: by mail-wr0-x22d.google.com with SMTP id v104so39319983wrb.0
	for <qemu-devel@nongnu.org>; Fri, 09 Jun 2017 10:00:46 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Jun 2017 18:00:59 +0100
Message-Id: <20170609170100.3599-3-alex.bennee@linaro.org>
In-Reply-To: <20170609170100.3599-1-alex.bennee@linaro.org>
References: <20170609170100.3599-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC DEBUG PATCH 2/3] tcg-runtime: light re-factor of
 lookup_tb_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, pbonzini@redhat.com, edgar.iglesias@xilinx.com, cota@braap.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Just a little precursor re-factoring before I was going to add a trace
point:

  - single return point, defaulting to tcg_ctx.code_gen_epilogue
  - move cs_base, pc and flags inside the jump cache hit scope
  - calculate the tb_jmp_cache hash once

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tcg-runtime.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/tcg-runtime.c b/tcg-runtime.c
index 7fa90ce508..e987c1f6bb 100644
--- a/tcg-runtime.c
+++ b/tcg-runtime.c
@@ -147,30 +147,33 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
 void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
 {
     CPUState *cpu = ENV_GET_CPU(env);
+    unsigned int addr_hash = tb_jmp_cache_hash_func(addr);
+    void * code_ptr = NULL;
     TranslationBlock *tb;
-    target_ulong cs_base, pc;
-    uint32_t flags;
 
-    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
+    tb = atomic_rcu_read(&cpu->tb_jmp_cache[addr_hash]);
     if (likely(tb)) {
+        target_ulong cs_base, pc;
+        uint32_t flags;
+
         cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
+
         if (likely(tb->pc == addr && tb->cs_base == cs_base &&
                    tb->flags == flags)) {
-            goto found;
-        }
-        tb = tb_htable_lookup(cpu, addr, cs_base, flags);
-        if (likely(tb)) {
-            atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)], tb);
-            goto found;
+            code_ptr = tb->tc_ptr;
+        } else {
+            /* If we didn't find it in the jmp_cache we still might
+             * find it in the global tb_htable
+             */
+            tb = tb_htable_lookup(cpu, addr, cs_base, flags);
+            if (likely(tb)) {
+                atomic_set(&cpu->tb_jmp_cache[addr_hash], tb);
+                code_ptr = tb->tc_ptr;
+            }
         }
     }
-    return tcg_ctx.code_gen_epilogue;
- found:
-    qemu_log_mask_and_addr(CPU_LOG_EXEC, addr,
-                           "Chain %p [%d: " TARGET_FMT_lx "] %s\n",
-                           tb->tc_ptr, cpu->cpu_index, addr,
-                           lookup_symbol(addr));
-    return tb->tc_ptr;
+
+    return code_ptr ? code_ptr : tcg_ctx.code_gen_epilogue;
 }
 
 void HELPER(exit_atomic)(CPUArchState *env)
-- 
2.13.0
