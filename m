Received: from eggs.gnu.org ([2001:4830:134:3::10]:40204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL8rh-0005sB-Dh
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL8rb-0008GM-He
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:01:45 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dL8rb-0008Fy-Bw
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:01:39 -0400
Received: by mail-wr0-x22d.google.com with SMTP id 36so1938933wry.3
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:01:39 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 14 Jun 2017 15:02:09 +0100
Message-Id: <20170614140209.29847-4-alex.bennee@linaro.org>
In-Reply-To: <20170614140209.29847-1-alex.bennee@linaro.org>
References: <20170614140209.29847-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 3/3] tcg-runtime: short-circuit
 lookup_tb_ptr on IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, pbonzini@redhat.com, rth@twiddle.net, cota@braap.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

While the next TB would detect the exit flag has been set there is no
point if we can exit sooner. We also check cpu->interrupt_request as
some front-ends can set it rather than using the cpu_interrupt() API
call and would normally be expecting the IRQ to get picked up on the
previously fairly regular exits from the run loop.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tcg-runtime.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/tcg-runtime.c b/tcg-runtime.c
index f4bfa9cea6..a025a6f194 100644
--- a/tcg-runtime.c
+++ b/tcg-runtime.c
@@ -147,28 +147,35 @@ uint64_t HELPER(ctpop_i64)(uint64_t arg)
 void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
 {
     CPUState *cpu = ENV_GET_CPU(env);
-    unsigned int addr_hash = tb_jmp_cache_hash_func(addr);
     void *code_ptr = NULL;
-    TranslationBlock *tb;
-
-    tb = atomic_rcu_read(&cpu->tb_jmp_cache[addr_hash]);
-    if (likely(tb)) {
-        target_ulong cs_base, pc;
-        uint32_t flags;
-
-        cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
-
-        if (likely(tb->pc == addr && tb->cs_base == cs_base &&
-                   tb->flags == flags)) {
-            code_ptr = tb->tc_ptr;
-        } else {
-            /* If we didn't find it in the jmp_cache we still might
-             * find it in the global tb_htable
-             */
-            tb = tb_htable_lookup(cpu, addr, cs_base, flags);
-            if (likely(tb)) {
-                atomic_set(&cpu->tb_jmp_cache[addr_hash], tb);
+
+    /* If there is an interrupt pending request or the TCG exit flag
+     * has been set we might as well stop here and return to the main
+     * loop.
+     */
+    if (!cpu->icount_decr.u16.high && !cpu->interrupt_request) {
+        unsigned int addr_hash = tb_jmp_cache_hash_func(addr);
+        TranslationBlock *tb;
+
+        tb = atomic_rcu_read(&cpu->tb_jmp_cache[addr_hash]);
+        if (likely(tb)) {
+            target_ulong cs_base, pc;
+            uint32_t flags;
+
+            cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
+
+            if (likely(tb->pc == addr && tb->cs_base == cs_base &&
+                       tb->flags == flags)) {
                 code_ptr = tb->tc_ptr;
+            } else {
+                /* If we didn't find it in the jmp_cache we still might
+                 * find it in the global tb_htable
+                 */
+                tb = tb_htable_lookup(cpu, addr, cs_base, flags);
+                if (likely(tb)) {
+                    atomic_set(&cpu->tb_jmp_cache[addr_hash], tb);
+                    code_ptr = tb->tc_ptr;
+                }
             }
         }
     }
-- 
2.13.0
