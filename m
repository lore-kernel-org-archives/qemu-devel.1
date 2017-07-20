Received: from eggs.gnu.org ([2001:4830:134:3::10]:60235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qO-00016Y-AP
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qJ-0005r4-Sx
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33885)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dY1qJ-0005pk-Nv
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:35 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 19 Jul 2017 23:09:07 -0400
Message-Id: <1500520169-23367-22-git-send-email-cota@braap.org>
In-Reply-To: <1500520169-23367-1-git-send-email-cota@braap.org>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 21/43] cpu-exec: lookup/generate TB outside
 exclusive region during step_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Now that all code generation has been converted to check CF_PARALLEL, we can
generate !CF_PARALLEL code without having yet set !parallel_cpus --
and therefore without having to be in the exclusive region during
cpu_exec_step_atomic.

While at it, merge cpu_exec_step into cpu_exec_step_atomic.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cpu-exec.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index b71e015..526cab3 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -223,30 +223,40 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
 }
 #endif
 
-static void cpu_exec_step(CPUState *cpu)
+void cpu_exec_step_atomic(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags;
     uint32_t cflags = 1 | CF_IGNORE_ICOUNT;
+    uint32_t cf_mask = cflags & CF_HASH_MASK;
 
     if (sigsetjmp(cpu->jmp_env, 0) == 0) {
-        tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags,
-                                  cflags & CF_HASH_MASK);
+        tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
         if (tb == NULL) {
             mmap_lock();
             tb_lock();
-            tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
+            tb = tb_htable_lookup(cpu, pc, cs_base, flags, cf_mask);
+            if (likely(tb == NULL)) {
+                tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
+            }
             tb_unlock();
             mmap_unlock();
         }
 
+        start_exclusive();
+
+        /* Since we got here, we know that parallel_cpus must be true.  */
+        parallel_cpus = false;
         cc->cpu_exec_enter(cpu);
         /* execute the generated code */
         trace_exec_tb(tb, pc);
         cpu_tb_exec(cpu, tb);
         cc->cpu_exec_exit(cpu);
+        parallel_cpus = true;
+
+        end_exclusive();
     } else {
         /* We may have exited due to another problem here, so we need
          * to reset any tb_locks we may have taken but didn't release.
@@ -260,18 +270,6 @@ static void cpu_exec_step(CPUState *cpu)
     }
 }
 
-void cpu_exec_step_atomic(CPUState *cpu)
-{
-    start_exclusive();
-
-    /* Since we got here, we know that parallel_cpus must be true.  */
-    parallel_cpus = false;
-    cpu_exec_step(cpu);
-    parallel_cpus = true;
-
-    end_exclusive();
-}
-
 struct tb_desc {
     target_ulong pc;
     target_ulong cs_base;
-- 
2.7.4
