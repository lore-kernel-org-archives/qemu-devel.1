Received: from eggs.gnu.org ([2001:4830:134:3::10]:34158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSryt-0003Hw-Lc
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:04:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSryq-0001NO-Hi
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:04:51 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSryq-0001NJ-CU
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:04:48 -0500
Received: by mail-pg0-x244.google.com with SMTP id 75so3579217pgf.3
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:04:48 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:04:33 -0800
Message-Id: <1484514273-11666-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: implement RUNSTALL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

RUNSTALL signal stalls core execution while it's applied. It is widely
used in multicore configurations to control activity of additional
cores.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.c    |  3 ++-
 target/xtensa/cpu.h    |  3 ++-
 target/xtensa/helper.c | 13 +++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 09b53c7..1c18892 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -47,7 +47,7 @@ static bool xtensa_cpu_has_work(CPUState *cs)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
 
-    return cpu->env.pending_irq_level;
+    return !cpu->env.runstall && cpu->env.pending_irq_level;
 }
 
 /* CPUClass::reset() */
@@ -74,6 +74,7 @@ static void xtensa_cpu_reset(CPUState *s)
 
     env->pending_irq_level = 0;
     reset_mmu(env);
+    s->halted = env->runstall;
 }
 
 static ObjectClass *xtensa_cpu_class_by_name(const char *cpu_model)
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 6b044d3..77bd9d2 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -366,7 +366,7 @@ typedef struct CPUXtensaState {
     xtensa_tlb_entry itlb[7][MAX_TLB_WAY_SIZE];
     xtensa_tlb_entry dtlb[10][MAX_TLB_WAY_SIZE];
     unsigned autorefill_idx;
-
+    bool runstall;
     int pending_irq_level; /* level of last raised IRQ */
     void **irq_inputs;
     QEMUTimer *ccompare_timer;
@@ -469,6 +469,7 @@ static inline void xtensa_select_static_vectors(CPUXtensaState *env,
     assert(n < 2);
     env->static_vectors = n;
 }
+void xtensa_runstall(CPUXtensaState *env, bool runstall);
 
 #define XTENSA_OPTION_BIT(opt) (((uint64_t)1) << (opt))
 #define XTENSA_OPTION_ALL (~(uint64_t)0)
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 768b32c..c67d715 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -728,3 +728,16 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUXtensaState *env)
         cpu_fprintf(f, "No TLB for this CPU core\n");
     }
 }
+
+void xtensa_runstall(CPUXtensaState *env, bool runstall)
+{
+    CPUState *cpu = CPU(xtensa_env_get_cpu(env));
+
+    env->runstall = runstall;
+    cpu->halted = runstall;
+    if (runstall) {
+        cpu_interrupt(cpu, CPU_INTERRUPT_HALT);
+    } else {
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
+    }
+}
-- 
2.1.4
