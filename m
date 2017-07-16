Received: from eggs.gnu.org ([2001:4830:134:3::10]:46247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmc-0001Az-En
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmU-0008HY-S3
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53501)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmU-0008GE-Jj
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:03:56 -0400
Message-Id: <1500235468-15341-14-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 13/45] tcg: consolidate TB lookups in
 tb_lookup__cpu_state
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

This avoids duplicating code. cpu_exec_step will also use the
new common function once we integrate parallel_cpus into tb->cflags.

Performance-wise, I measured a small improvement when booting debian-arm.
Note that inlining pays off:

 Performance counter stats for 'taskset -c 0 qemu-system-arm \
	-machine type=virt -nographic -smp 1 -m 4096 \
	-netdev user,id=unet,hostfwd=tcp::2222-:22 \
	-device virtio-net-device,netdev=unet \
	-drive file=jessie.qcow2,id=myblock,index=0,if=none \
	-device virtio-blk-device,drive=myblock \
	-kernel kernel.img -append console=ttyAMA0 root=/dev/vda1 \
	-name arm,debug-threads=on -smp 1' (10 runs):

Before:
      18714.917392 task-clock                #    0.952 CPUs utilized            ( +-  0.95% )
            23,142 context-switches          #    0.001 M/sec                    ( +-  0.50% )
                 1 CPU-migrations            #    0.000 M/sec
            10,558 page-faults               #    0.001 M/sec                    ( +-  0.95% )
    53,957,727,252 cycles                    #    2.883 GHz                      ( +-  0.91% ) [83.33%]
    24,440,599,852 stalled-cycles-frontend   #   45.30% frontend cycles idle     ( +-  1.20% ) [83.33%]
    16,495,714,424 stalled-cycles-backend    #   30.57% backend  cycles idle     ( +-  0.95% ) [66.66%]
    76,267,572,582 instructions              #    1.41  insns per cycle
                                             #    0.32  stalled cycles per insn  ( +-  0.87% ) [83.34%]
    12,692,186,323 branches                  #  678.186 M/sec                    ( +-  0.92% ) [83.35%]
       263,486,879 branch-misses             #    2.08% of all branches          ( +-  0.73% ) [83.34%]

      19.648474449 seconds time elapsed                                          ( +-  0.82% )

After, w/ inline (this patch):
      18471.376627 task-clock                #    0.955 CPUs utilized            ( +-  0.96% )
            23,048 context-switches          #    0.001 M/sec                    ( +-  0.48% )
                 1 CPU-migrations            #    0.000 M/sec
            10,708 page-faults               #    0.001 M/sec                    ( +-  0.81% )
    53,208,990,796 cycles                    #    2.881 GHz                      ( +-  0.98% ) [83.34%]
    23,941,071,673 stalled-cycles-frontend   #   44.99% frontend cycles idle     ( +-  0.95% ) [83.34%]
    16,161,773,848 stalled-cycles-backend    #   30.37% backend  cycles idle     ( +-  0.76% ) [66.67%]
    75,786,269,766 instructions              #    1.42  insns per cycle
                                             #    0.32  stalled cycles per insn  ( +-  1.24% ) [83.34%]
    12,573,617,143 branches                  #  680.708 M/sec                    ( +-  1.34% ) [83.33%]
       260,235,550 branch-misses             #    2.07% of all branches          ( +-  0.66% ) [83.33%]

      19.340502161 seconds time elapsed                                          ( +-  0.56% )

After, w/o inline:
      18791.253967 task-clock                #    0.954 CPUs utilized            ( +-  0.78% )
            23,230 context-switches          #    0.001 M/sec                    ( +-  0.42% )
                 1 CPU-migrations            #    0.000 M/sec
            10,563 page-faults               #    0.001 M/sec                    ( +-  1.27% )
    54,168,674,622 cycles                    #    2.883 GHz                      ( +-  0.80% ) [83.34%]
    24,244,712,629 stalled-cycles-frontend   #   44.76% frontend cycles idle     ( +-  1.37% ) [83.33%]
    16,288,648,572 stalled-cycles-backend    #   30.07% backend  cycles idle     ( +-  0.95% ) [66.66%]
    77,659,755,503 instructions              #    1.43  insns per cycle
                                             #    0.31  stalled cycles per insn  ( +-  0.97% ) [83.34%]
    12,922,780,045 branches                  #  687.702 M/sec                    ( +-  1.06% ) [83.34%]
       261,962,386 branch-misses             #    2.03% of all branches          ( +-  0.71% ) [83.35%]

      19.700174670 seconds time elapsed                                          ( +-  0.56% )

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/tb-lookup.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 accel/tcg/cpu-exec.c     | 47 ++++++++++++++++++-----------------------------
 tcg/tcg-runtime.c        | 24 ++++++------------------
 3 files changed, 72 insertions(+), 47 deletions(-)
 create mode 100644 include/exec/tb-lookup.h

diff --git a/include/exec/tb-lookup.h b/include/exec/tb-lookup.h
new file mode 100644
index 0000000..5e3f104
--- /dev/null
+++ b/include/exec/tb-lookup.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#ifndef EXEC_TB_LOOKUP_H
+#define EXEC_TB_LOOKUP_H
+
+#include "qemu/osdep.h"
+
+#ifdef NEED_CPU_H
+#include "cpu.h"
+#else
+#include "exec/poison.h"
+#endif
+
+#include "exec/exec-all.h"
+#include "exec/tb-hash.h"
+
+/* Might cause an exception, so have a longjmp destination ready */
+static inline TranslationBlock *
+tb_lookup__cpu_state(CPUState *cpu, target_ulong *pc, target_ulong *cs_base,
+                     uint32_t *flags)
+{
+    CPUArchState *env = (CPUArchState *)cpu->env_ptr;
+    TranslationBlock *tb;
+    uint32_t hash;
+
+    cpu_get_tb_cpu_state(env, pc, cs_base, flags);
+    hash = tb_jmp_cache_hash_func(*pc);
+    tb = atomic_rcu_read(&cpu->tb_jmp_cache[hash]);
+    if (likely(tb &&
+               tb->pc == *pc &&
+               tb->cs_base == *cs_base &&
+               tb->flags == *flags &&
+               tb->trace_vcpu_dstate == *cpu->trace_dstate)) {
+        return tb;
+    }
+    tb = tb_htable_lookup(cpu, *pc, *cs_base, *flags);
+    if (tb == NULL) {
+        return NULL;
+    }
+    atomic_set(&cpu->tb_jmp_cache[hash], tb);
+    return tb;
+}
+
+#endif /* EXEC_TB_LOOKUP_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 34841cd..3a08ad0 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -28,6 +28,7 @@
 #include "exec/address-spaces.h"
 #include "qemu/rcu.h"
 #include "exec/tb-hash.h"
+#include "exec/tb-lookup.h"
 #include "exec/log.h"
 #include "qemu/main-loop.h"
 #if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
@@ -332,43 +333,31 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
                                         TranslationBlock *last_tb,
                                         int tb_exit)
 {
-    CPUArchState *env = (CPUArchState *)cpu->env_ptr;
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags;
     bool acquired_tb_lock = false;
 
-    /* we record a subset of the CPU state. It will
-       always be the same before a given translated block
-       is executed. */
-    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
-    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(pc)]);
-    if (unlikely(!tb || tb->pc != pc || tb->cs_base != cs_base ||
-                 tb->flags != flags ||
-                 tb->trace_vcpu_dstate != *cpu->trace_dstate)) {
-        tb = tb_htable_lookup(cpu, pc, cs_base, flags);
-        if (!tb) {
-
-            /* mmap_lock is needed by tb_gen_code, and mmap_lock must be
-             * taken outside tb_lock. As system emulation is currently
-             * single threaded the locks are NOPs.
-             */
-            mmap_lock();
-            tb_lock();
-            acquired_tb_lock = true;
-
-            /* There's a chance that our desired tb has been translated while
-             * taking the locks so we check again inside the lock.
-             */
-            tb = tb_htable_lookup(cpu, pc, cs_base, flags);
-            if (!tb) {
-                /* if no translated code available, then translate it now */
-                tb = tb_gen_code(cpu, pc, cs_base, flags, 0);
-            }
+    tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags);
+    if (tb == NULL) {
+        /* mmap_lock is needed by tb_gen_code, and mmap_lock must be
+         * taken outside tb_lock. As system emulation is currently
+         * single threaded the locks are NOPs.
+         */
+        mmap_lock();
+        tb_lock();
+        acquired_tb_lock = true;
 
-            mmap_unlock();
+        /* There's a chance that our desired tb has been translated while
+         * taking the locks so we check again inside the lock.
+         */
+        tb = tb_htable_lookup(cpu, pc, cs_base, flags);
+        if (likely(tb == NULL)) {
+            /* if no translated code available, then translate it now */
+            tb = tb_gen_code(cpu, pc, cs_base, flags, 0);
         }
 
+        mmap_unlock();
         /* We add the TB in the virtual pc hash table for the fast lookup */
         atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(pc)], tb);
     }
diff --git a/tcg/tcg-runtime.c b/tcg/tcg-runtime.c
index e85a042..7100339 100644
--- a/tcg/tcg-runtime.c
+++ b/tcg/tcg-runtime.c
@@ -27,7 +27,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
-#include "exec/tb-hash.h"
+#include "exec/tb-lookup.h"
 #include "disas/disas.h"
 #include "exec/log.h"
 
@@ -149,24 +149,12 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     CPUState *cpu = ENV_GET_CPU(env);
     TranslationBlock *tb;
     target_ulong cs_base, pc;
-    uint32_t flags, hash;
-
-    cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
-    hash = tb_jmp_cache_hash_func(pc);
-    tb = atomic_rcu_read(&cpu->tb_jmp_cache[hash]);
-
-    if (unlikely(!(tb
-                   && tb->pc == pc
-                   && tb->cs_base == cs_base
-                   && tb->flags == flags
-                   && tb->trace_vcpu_dstate == *cpu->trace_dstate))) {
-        tb = tb_htable_lookup(cpu, pc, cs_base, flags);
-        if (!tb) {
-            return tcg_ctx.code_gen_epilogue;
-        }
-        atomic_set(&cpu->tb_jmp_cache[hash], tb);
-    }
+    uint32_t flags;
 
+    tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags);
+    if (tb == NULL) {
+        return tcg_ctx.code_gen_epilogue;
+    }
     qemu_log_mask_and_addr(CPU_LOG_EXEC, pc,
                            "Chain %p [%d: " TARGET_FMT_lx "] %s\n",
                            tb->tc_ptr, cpu->cpu_index, pc,
-- 
2.7.4
