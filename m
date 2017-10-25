Received: from eggs.gnu.org ([2001:4830:134:3::10]:45893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6p-00008z-BA
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6o-0008Um-DO
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:23 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:46392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6o-0008UA-6Z
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:22 -0400
Received: by mail-wm0-x241.google.com with SMTP id m72so633548wmc.1
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:18 +0200
Message-Id: <20171025093535.10175-35-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 34/51] cpu-exec: lookup/generate TB outside
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Now that all code generation has been converted to check CF_PARALLEL, we can
generate !CF_PARALLEL code without having yet set !parallel_cpus --
and therefore without having to be in the exclusive region during
cpu_exec_step_atomic.

While at it, merge cpu_exec_step into cpu_exec_step_atomic.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 1c64977849..849b54d0b0 100644
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
2.13.6
