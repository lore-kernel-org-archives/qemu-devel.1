Received: from eggs.gnu.org ([209.51.188.92]:54949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0s-0005RD-My
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0j-0005TH-0c
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:52:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0g-0005Gg-Vr
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F20693082E4E
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 003C65D9CC
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 18 Apr 2019 22:51:32 +0200
Message-Id: <20190418205135.6686-34-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-4.1 33/36] qom/cpu: Simplify how
 CPUClass:cpu_dump_state() prints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

CPUClass method dump_statistics() takes an fprintf()-like callback and
a FILE * to pass to it.  Most callers pass fprintf() and stderr.
log_cpu_state() passes fprintf() and qemu_log_file.
hmp_info_registers() passes monitor_fprintf() and the current monitor
cast to FILE *.  monitor_fprintf() casts it right back, and is
otherwise identical to monitor_printf().

The callback gets passed around a lot, which is tiresome.  The
type-punning around monitor_fprintf() is ugly.

Drop the callback, and call qemu_fprintf() instead.  Also gets rid of
the type-punning, since qemu_fprintf() takes NULL instead of the
current monitor cast to FILE *.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190417191805.28198-15-armbru@redhat.com>
---
 accel/kvm/kvm-all.c              |   4 +-
 bsd-user/main.c                  |   2 +-
 cpus.c                           |   2 +-
 exec.c                           |   2 +-
 include/exec/log.h               |   2 +-
 include/qom/cpu.h                |  11 +-
 linux-user/alpha/cpu_loop.c      |   2 +-
 linux-user/cpu_loop-common.h     |   2 +-
 linux-user/cris/cpu_loop.c       |   2 +-
 linux-user/microblaze/cpu_loop.c |   4 +-
 linux-user/s390x/cpu_loop.c      |   4 +-
 linux-user/sh4/cpu_loop.c        |   2 +-
 linux-user/sparc/cpu_loop.c      |   2 +-
 monitor.c                        |   4 +-
 qom/cpu.c                        |   6 +-
 target/alpha/cpu.h               |   3 +-
 target/alpha/helper.c            |  24 +--
 target/arm/arm-semi.c            |   2 +-
 target/arm/cpu.h                 |   3 +-
 target/arm/translate-a64.c       |  82 ++++-----
 target/arm/translate.c           |  58 +++----
 target/arm/translate.h           |   7 +-
 target/cris/cpu.h                |   3 +-
 target/cris/helper.c             |   2 +-
 target/cris/translate.c          |  36 ++--
 target/hppa/cpu.h                |   2 +-
 target/hppa/helper.c             |  24 +--
 target/i386/cpu.h                |   3 +-
 target/i386/hax-all.c            |   4 +-
 target/i386/helper.c             | 277 +++++++++++++++----------------
 target/lm32/cpu.h                |   3 +-
 target/lm32/translate.c          |  36 ++--
 target/m68k/cpu.h                |   3 +-
 target/m68k/translate.c          |  86 +++++-----
 target/microblaze/cpu.h          |   3 +-
 target/microblaze/helper.c       |   2 +-
 target/microblaze/translate.c    |  39 ++---
 target/mips/internal.h           |   3 +-
 target/mips/translate.c          |  76 ++++-----
 target/moxie/cpu.h               |   3 +-
 target/moxie/helper.c            |   2 +-
 target/moxie/translate.c         |  22 +--
 target/nios2/cpu.h               |   3 +-
 target/nios2/helper.c            |   2 +-
 target/nios2/translate.c         |  24 +--
 target/openrisc/cpu.h            |   3 +-
 target/openrisc/translate.c      |  11 +-
 target/ppc/cpu.h                 |   3 +-
 target/ppc/translate.c           | 161 +++++++++---------
 target/riscv/cpu.c               |  37 ++---
 target/s390x/helper.c            |  42 ++---
 target/s390x/internal.h          |   3 +-
 target/sh4/cpu.h                 |   3 +-
 target/sh4/translate.c           |  27 +--
 target/sparc/cpu.c               |  84 +++++-----
 target/sparc/cpu.h               |   3 +-
 target/tilegx/cpu.c              |  14 +-
 target/tricore/cpu.h             |   3 +-
 target/tricore/translate.c       |  26 +--
 target/unicore32/cpu.h           |   3 +-
 target/unicore32/translate.c     |  39 +++--
 target/xtensa/cpu.h              |   3 +-
 target/xtensa/translate.c        |  40 ++---
 63 files changed, 682 insertions(+), 711 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 241db496c3..524c4ddfbd 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1798,7 +1798,7 @@ static int kvm_handle_internal_error(CPUState *cpu, struct kvm_run *run)
     if (run->internal.suberror == KVM_INTERNAL_ERROR_EMULATION) {
         fprintf(stderr, "emulation failure\n");
         if (!kvm_arch_stop_on_emulation_error(cpu)) {
-            cpu_dump_state(cpu, stderr, fprintf, CPU_DUMP_CODE);
+            cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
             return EXCP_INTERRUPT;
         }
     }
@@ -2089,7 +2089,7 @@ int kvm_cpu_exec(CPUState *cpu)
     qemu_mutex_lock_iothread();
 
     if (ret < 0) {
-        cpu_dump_state(cpu, stderr, fprintf, CPU_DUMP_CODE);
+        cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
         vm_stop(RUN_STATE_INTERNAL_ERROR);
     }
 
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 7657c6851d..a8c807e8df 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -640,7 +640,7 @@ void cpu_loop(CPUSPARCState *env)
         badtrap:
 #endif
             printf ("Unhandled trap: 0x%x\n", trapnr);
-            cpu_dump_state(cs, stderr, fprintf, 0);
+            cpu_dump_state(cs, stderr, 0);
             exit (1);
         }
         process_pending_signals (env);
diff --git a/cpus.c b/cpus.c
index b4eecf70f0..e58e7ab0f6 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1010,7 +1010,7 @@ void hw_error(const char *fmt, ...)
     fprintf(stderr, "\n");
     CPU_FOREACH(cpu) {
         fprintf(stderr, "CPU #%d:\n", cpu->cpu_index);
-        cpu_dump_state(cpu, stderr, fprintf, CPU_DUMP_FPU);
+        cpu_dump_state(cpu, stderr, CPU_DUMP_FPU);
     }
     va_end(ap);
     abort();
diff --git a/exec.c b/exec.c
index 85d15606f1..2646207661 100644
--- a/exec.c
+++ b/exec.c
@@ -1256,7 +1256,7 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
     fprintf(stderr, "qemu: fatal: ");
     vfprintf(stderr, fmt, ap);
     fprintf(stderr, "\n");
-    cpu_dump_state(cpu, stderr, fprintf, CPU_DUMP_FPU | CPU_DUMP_CCOP);
+    cpu_dump_state(cpu, stderr, CPU_DUMP_FPU | CPU_DUMP_CCOP);
     if (qemu_log_separate()) {
         qemu_log_lock();
         qemu_log("qemu: fatal: ");
diff --git a/include/exec/log.h b/include/exec/log.h
index c249307911..de067f173b 100644
--- a/include/exec/log.h
+++ b/include/exec/log.h
@@ -16,7 +16,7 @@
 static inline void log_cpu_state(CPUState *cpu, int flags)
 {
     if (qemu_log_enabled()) {
-        cpu_dump_state(cpu, qemu_logfile, fprintf, flags);
+        cpu_dump_state(cpu, qemu_logfile, flags);
     }
 }
 
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 31bafee2b1..9972e07786 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -26,7 +26,6 @@
 #include "exec/memattrs.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
-#include "qemu/fprintf-fn.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
@@ -181,8 +180,7 @@ typedef struct CPUClass {
     bool (*virtio_is_big_endian)(CPUState *cpu);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, int len, bool is_write);
-    void (*dump_state)(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
-                       int flags);
+    void (*dump_state)(CPUState *cpu, FILE *, int flags);
     GuestPanicInformation* (*get_crash_info)(CPUState *cpu);
     void (*dump_statistics)(CPUState *cpu, int flags);
     int64_t (*get_arch_id)(CPUState *cpu);
@@ -563,14 +561,11 @@ enum CPUDumpFlags {
 /**
  * cpu_dump_state:
  * @cpu: The CPU whose state is to be dumped.
- * @f: File to dump to.
- * @cpu_fprintf: Function to dump with.
- * @flags: Flags what to dump.
+ * @f: If non-null, dump to this stream, else to current print sink.
  *
  * Dumps CPU state.
  */
-void cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
-                    int flags);
+void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
 /**
  * cpu_dump_statistics:
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index 824b6d6658..61992571e1 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -193,7 +193,7 @@ void cpu_loop(CPUAlphaState *env)
             break;
         default:
             fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
-            cpu_dump_state(cs, stderr, fprintf, 0);
+            cpu_dump_state(cs, stderr, 0);
             exit(EXIT_FAILURE);
         }
         process_pending_signals (env);
diff --git a/linux-user/cpu_loop-common.h b/linux-user/cpu_loop-common.h
index ffe3fe9ad5..c1d554a249 100644
--- a/linux-user/cpu_loop-common.h
+++ b/linux-user/cpu_loop-common.h
@@ -26,7 +26,7 @@
 do {                                                                    \
     CPUState *cs = ENV_GET_CPU(env);                                    \
     fprintf(stderr, fmt , ## __VA_ARGS__);                              \
-    cpu_dump_state(cs, stderr, fprintf, 0);                             \
+    cpu_dump_state(cs, stderr, 0);                                      \
     if (qemu_log_separate()) {                                          \
         qemu_log(fmt, ## __VA_ARGS__);                                  \
         log_cpu_state(cs, 0);                                           \
diff --git a/linux-user/cris/cpu_loop.c b/linux-user/cris/cpu_loop.c
index dacf604c7d..af8c128bf8 100644
--- a/linux-user/cris/cpu_loop.c
+++ b/linux-user/cris/cpu_loop.c
@@ -74,7 +74,7 @@ void cpu_loop(CPUCRISState *env)
             break;
         default:
             fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
-            cpu_dump_state(cs, stderr, fprintf, 0);
+            cpu_dump_state(cs, stderr, 0);
             exit(EXIT_FAILURE);
         }
         process_pending_signals (env);
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index c2190e15fd..076bdb9a61 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -107,7 +107,7 @@ void cpu_loop(CPUMBState *env)
                 default:
                     fprintf(stderr, "Unhandled hw-exception: 0x%" PRIx64 "\n",
                             env->sregs[SR_ESR] & ESR_EC_MASK);
-                    cpu_dump_state(cs, stderr, fprintf, 0);
+                    cpu_dump_state(cs, stderr, 0);
                     exit(EXIT_FAILURE);
                     break;
             }
@@ -123,7 +123,7 @@ void cpu_loop(CPUMBState *env)
             break;
         default:
             fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
-            cpu_dump_state(cs, stderr, fprintf, 0);
+            cpu_dump_state(cs, stderr, 0);
             exit(EXIT_FAILURE);
         }
         process_pending_signals (env);
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 51b5412ea2..b8bd1c956c 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -124,7 +124,7 @@ void cpu_loop(CPUS390XState *env)
 
             default:
                 fprintf(stderr, "Unhandled program exception: %#x\n", n);
-                cpu_dump_state(cs, stderr, fprintf, 0);
+                cpu_dump_state(cs, stderr, 0);
                 exit(EXIT_FAILURE);
             }
             break;
@@ -144,7 +144,7 @@ void cpu_loop(CPUS390XState *env)
             break;
         default:
             fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
-            cpu_dump_state(cs, stderr, fprintf, 0);
+            cpu_dump_state(cs, stderr, 0);
             exit(EXIT_FAILURE);
         }
         process_pending_signals (env);
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index 47e54b9b61..59cbbeda7e 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -76,7 +76,7 @@ void cpu_loop(CPUSH4State *env)
             break;
         default:
             fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
-            cpu_dump_state(cs, stderr, fprintf, 0);
+            cpu_dump_state(cs, stderr, 0);
             exit(EXIT_FAILURE);
         }
         process_pending_signals (env);
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 7d5b337b97..9e357229c0 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -278,7 +278,7 @@ void cpu_loop (CPUSPARCState *env)
             break;
         default:
             fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
-            cpu_dump_state(cs, stderr, fprintf, 0);
+            cpu_dump_state(cs, stderr, 0);
             exit(EXIT_FAILURE);
         }
         process_pending_signals (env);
diff --git a/monitor.c b/monitor.c
index fb5b681099..ad6cec54a1 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1296,7 +1296,7 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
     if (all_cpus) {
         CPU_FOREACH(cs) {
             monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
-            cpu_dump_state(cs, (FILE *)mon, monitor_fprintf, CPU_DUMP_FPU);
+            cpu_dump_state(cs, NULL, CPU_DUMP_FPU);
         }
     } else {
         cs = mon_get_cpu();
@@ -1306,7 +1306,7 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
             return;
         }
 
-        cpu_dump_state(cs, (FILE *)mon, monitor_fprintf, CPU_DUMP_FPU);
+        cpu_dump_state(cs, NULL, CPU_DUMP_FPU);
     }
 }
 
diff --git a/qom/cpu.c b/qom/cpu.c
index 029e7fe9b0..3c5493c96c 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -28,6 +28,7 @@
 #include "exec/log.h"
 #include "exec/cpu-common.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
@@ -219,14 +220,13 @@ GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
     return res;
 }
 
-void cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
-                    int flags)
+void cpu_dump_state(CPUState *cpu, FILE *f, int flags)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (cc->dump_state) {
         cpu_synchronize_state(cpu);
-        cc->dump_state(cpu, f, cpu_fprintf, flags);
+        cc->dump_state(cpu, f, flags);
     }
 }
 
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 732764f23c..63bf3618ff 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -311,8 +311,7 @@ extern const struct VMStateDescription vmstate_alpha_cpu;
 
 void alpha_cpu_do_interrupt(CPUState *cpu);
 bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
-void alpha_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                          int flags);
+void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int alpha_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 57e2c212b3..7201576aae 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -23,6 +23,7 @@
 #include "exec/exec-all.h"
 #include "fpu/softfloat.h"
 #include "exec/helper-proto.h"
+#include "qemu/qemu-print.h"
 
 
 #define CONVERT_BIT(X, SRC, DST) \
@@ -426,8 +427,7 @@ bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
-void alpha_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                          int flags)
+void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     static const char *linux_reg_names[] = {
         "v0 ", "t0 ", "t1 ", "t2 ", "t3 ", "t4 ", "t5 ", "t6 ",
@@ -439,24 +439,24 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     CPUAlphaState *env = &cpu->env;
     int i;
 
-    cpu_fprintf(f, "     PC  " TARGET_FMT_lx "      PS  %02x\n",
-                env->pc, extract32(env->flags, ENV_FLAG_PS_SHIFT, 8));
+    qemu_fprintf(f, "     PC  " TARGET_FMT_lx "      PS  %02x\n",
+                 env->pc, extract32(env->flags, ENV_FLAG_PS_SHIFT, 8));
     for (i = 0; i < 31; i++) {
-        cpu_fprintf(f, "IR%02d %s " TARGET_FMT_lx "%c", i,
-                    linux_reg_names[i], cpu_alpha_load_gr(env, i),
-                    (i % 3) == 2 ? '\n' : ' ');
+        qemu_fprintf(f, "IR%02d %s " TARGET_FMT_lx "%c", i,
+                     linux_reg_names[i], cpu_alpha_load_gr(env, i),
+                     (i % 3) == 2 ? '\n' : ' ');
     }
 
-    cpu_fprintf(f, "lock_a   " TARGET_FMT_lx " lock_v   " TARGET_FMT_lx "\n",
-                env->lock_addr, env->lock_value);
+    qemu_fprintf(f, "lock_a   " TARGET_FMT_lx " lock_v   " TARGET_FMT_lx "\n",
+                 env->lock_addr, env->lock_value);
 
     if (flags & CPU_DUMP_FPU) {
         for (i = 0; i < 31; i++) {
-            cpu_fprintf(f, "FIR%02d    %016" PRIx64 "%c", i, env->fir[i],
-                        (i % 3) == 2 ? '\n' : ' ');
+            qemu_fprintf(f, "FIR%02d    %016" PRIx64 "%c", i, env->fir[i],
+                         (i % 3) == 2 ? '\n' : ' ');
         }
     }
-    cpu_fprintf(f, "\n");
+    qemu_fprintf(f, "\n");
 }
 
 /* This should only be called from translate, via gen_excp.
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index b2b22d231e..8b5fd7bc6e 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -650,7 +650,7 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         /* fall through -- invalid for A32/T32 */
     default:
         fprintf(stderr, "qemu: Unsupported SemiHosting SWI 0x%02x\n", nr);
-        cpu_dump_state(cs, stderr, fprintf, 0);
+        cpu_dump_state(cs, stderr, 0);
         abort();
     }
 }
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 85c3bd642a..f7f2f5a99c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -935,8 +935,7 @@ void arm_cpu_do_interrupt(CPUState *cpu);
 void arm_v7m_cpu_do_interrupt(CPUState *cpu);
 bool arm_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
-void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                        int flags);
+void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index dcdeb80176..9dcc5ff3a3 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -27,6 +27,7 @@
 #include "translate.h"
 #include "internals.h"
 #include "qemu/host-utils.h"
+#include "qemu/qemu-print.h"
 
 #include "exec/semihost.h"
 #include "exec/gen-icount.h"
@@ -151,8 +152,7 @@ static void set_btype(DisasContext *s, int val)
     s->btype = -1;
 }
 
-void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
-                            fprintf_function cpu_fprintf, int flags)
+void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -161,13 +161,13 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
     int el = arm_current_el(env);
     const char *ns_status;
 
-    cpu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
+    qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
     for (i = 0; i < 32; i++) {
         if (i == 31) {
-            cpu_fprintf(f, " SP=%016" PRIx64 "\n", env->xregs[i]);
+            qemu_fprintf(f, " SP=%016" PRIx64 "\n", env->xregs[i]);
         } else {
-            cpu_fprintf(f, "X%02d=%016" PRIx64 "%s", i, env->xregs[i],
-                        (i + 2) % 3 ? " " : "\n");
+            qemu_fprintf(f, "X%02d=%016" PRIx64 "%s", i, env->xregs[i],
+                         (i + 2) % 3 ? " " : "\n");
         }
     }
 
@@ -176,29 +176,29 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
     } else {
         ns_status = "";
     }
-    cpu_fprintf(f, "PSTATE=%08x %c%c%c%c %sEL%d%c",
-                psr,
-                psr & PSTATE_N ? 'N' : '-',
-                psr & PSTATE_Z ? 'Z' : '-',
-                psr & PSTATE_C ? 'C' : '-',
-                psr & PSTATE_V ? 'V' : '-',
-                ns_status,
-                el,
-                psr & PSTATE_SP ? 'h' : 't');
+    qemu_fprintf(f, "PSTATE=%08x %c%c%c%c %sEL%d%c",
+                 psr,
+                 psr & PSTATE_N ? 'N' : '-',
+                 psr & PSTATE_Z ? 'Z' : '-',
+                 psr & PSTATE_C ? 'C' : '-',
+                 psr & PSTATE_V ? 'V' : '-',
+                 ns_status,
+                 el,
+                 psr & PSTATE_SP ? 'h' : 't');
 
     if (cpu_isar_feature(aa64_bti, cpu)) {
-        cpu_fprintf(f, "  BTYPE=%d", (psr & PSTATE_BTYPE) >> 10);
+        qemu_fprintf(f, "  BTYPE=%d", (psr & PSTATE_BTYPE) >> 10);
     }
     if (!(flags & CPU_DUMP_FPU)) {
-        cpu_fprintf(f, "\n");
+        qemu_fprintf(f, "\n");
         return;
     }
     if (fp_exception_el(env, el) != 0) {
-        cpu_fprintf(f, "    FPU disabled\n");
+        qemu_fprintf(f, "    FPU disabled\n");
         return;
     }
-    cpu_fprintf(f, "     FPCR=%08x FPSR=%08x\n",
-                vfp_get_fpcr(env), vfp_get_fpsr(env));
+    qemu_fprintf(f, "     FPCR=%08x FPSR=%08x\n",
+                 vfp_get_fpcr(env), vfp_get_fpsr(env));
 
     if (cpu_isar_feature(aa64_sve, cpu) && sve_exception_el(env, el) == 0) {
         int j, zcr_len = sve_zcr_len_for_el(env, el);
@@ -206,11 +206,11 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
         for (i = 0; i <= FFR_PRED_NUM; i++) {
             bool eol;
             if (i == FFR_PRED_NUM) {
-                cpu_fprintf(f, "FFR=");
+                qemu_fprintf(f, "FFR=");
                 /* It's last, so end the line.  */
                 eol = true;
             } else {
-                cpu_fprintf(f, "P%02d=", i);
+                qemu_fprintf(f, "P%02d=", i);
                 switch (zcr_len) {
                 case 0:
                     eol = i % 8 == 7;
@@ -235,46 +235,46 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
                 } else {
                     digits = (zcr_len % 4 + 1) * 4;
                 }
-                cpu_fprintf(f, "%0*" PRIx64 "%s", digits,
-                            env->vfp.pregs[i].p[j],
-                            j ? ":" : eol ? "\n" : " ");
+                qemu_fprintf(f, "%0*" PRIx64 "%s", digits,
+                             env->vfp.pregs[i].p[j],
+                             j ? ":" : eol ? "\n" : " ");
             }
         }
 
         for (i = 0; i < 32; i++) {
             if (zcr_len == 0) {
-                cpu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64 "%s",
-                            i, env->vfp.zregs[i].d[1],
-                            env->vfp.zregs[i].d[0], i & 1 ? "\n" : " ");
+                qemu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64 "%s",
+                             i, env->vfp.zregs[i].d[1],
+                             env->vfp.zregs[i].d[0], i & 1 ? "\n" : " ");
             } else if (zcr_len == 1) {
-                cpu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64
-                            ":%016" PRIx64 ":%016" PRIx64 "\n",
-                            i, env->vfp.zregs[i].d[3], env->vfp.zregs[i].d[2],
-                            env->vfp.zregs[i].d[1], env->vfp.zregs[i].d[0]);
+                qemu_fprintf(f, "Z%02d=%016" PRIx64 ":%016" PRIx64
+                             ":%016" PRIx64 ":%016" PRIx64 "\n",
+                             i, env->vfp.zregs[i].d[3], env->vfp.zregs[i].d[2],
+                             env->vfp.zregs[i].d[1], env->vfp.zregs[i].d[0]);
             } else {
                 for (j = zcr_len; j >= 0; j--) {
                     bool odd = (zcr_len - j) % 2 != 0;
                     if (j == zcr_len) {
-                        cpu_fprintf(f, "Z%02d[%x-%x]=", i, j, j - 1);
+                        qemu_fprintf(f, "Z%02d[%x-%x]=", i, j, j - 1);
                     } else if (!odd) {
                         if (j > 0) {
-                            cpu_fprintf(f, "   [%x-%x]=", j, j - 1);
+                            qemu_fprintf(f, "   [%x-%x]=", j, j - 1);
                         } else {
-                            cpu_fprintf(f, "     [%x]=", j);
+                            qemu_fprintf(f, "     [%x]=", j);
                         }
                     }
-                    cpu_fprintf(f, "%016" PRIx64 ":%016" PRIx64 "%s",
-                                env->vfp.zregs[i].d[j * 2 + 1],
-                                env->vfp.zregs[i].d[j * 2],
-                                odd || j == 0 ? "\n" : ":");
+                    qemu_fprintf(f, "%016" PRIx64 ":%016" PRIx64 "%s",
+                                 env->vfp.zregs[i].d[j * 2 + 1],
+                                 env->vfp.zregs[i].d[j * 2],
+                                 odd || j == 0 ? "\n" : ":");
                 }
             }
         }
     } else {
         for (i = 0; i < 32; i++) {
             uint64_t *q = aa64_vfp_qreg(env, i);
-            cpu_fprintf(f, "Q%02d=%016" PRIx64 ":%016" PRIx64 "%s",
-                        i, q[1], q[0], (i & 1 ? "\n" : " "));
+            qemu_fprintf(f, "Q%02d=%016" PRIx64 ":%016" PRIx64 "%s",
+                         i, q[1], q[0], (i & 1 ? "\n" : " "));
         }
     }
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d408e4d7ef..d9e7bb737a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -28,6 +28,7 @@
 #include "tcg-op-gvec.h"
 #include "qemu/log.h"
 #include "qemu/bitops.h"
+#include "qemu/qemu-print.h"
 #include "arm_ldst.h"
 #include "exec/semihost.h"
 
@@ -13772,24 +13773,23 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
     translator_loop(ops, &dc.base, cpu, tb);
 }
 
-void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                        int flags)
+void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     int i;
 
     if (is_a64(env)) {
-        aarch64_cpu_dump_state(cs, f, cpu_fprintf, flags);
+        aarch64_cpu_dump_state(cs, f, flags);
         return;
     }
 
     for(i=0;i<16;i++) {
-        cpu_fprintf(f, "R%02d=%08x", i, env->regs[i]);
+        qemu_fprintf(f, "R%02d=%08x", i, env->regs[i]);
         if ((i % 4) == 3)
-            cpu_fprintf(f, "\n");
+            qemu_fprintf(f, "\n");
         else
-            cpu_fprintf(f, " ");
+            qemu_fprintf(f, " ");
     }
 
     if (arm_feature(env, ARM_FEATURE_M)) {
@@ -13811,15 +13811,15 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
             }
         }
 
-        cpu_fprintf(f, "XPSR=%08x %c%c%c%c %c %s%s\n",
-                    xpsr,
-                    xpsr & XPSR_N ? 'N' : '-',
-                    xpsr & XPSR_Z ? 'Z' : '-',
-                    xpsr & XPSR_C ? 'C' : '-',
-                    xpsr & XPSR_V ? 'V' : '-',
-                    xpsr & XPSR_T ? 'T' : 'A',
-                    ns_status,
-                    mode);
+        qemu_fprintf(f, "XPSR=%08x %c%c%c%c %c %s%s\n",
+                     xpsr,
+                     xpsr & XPSR_N ? 'N' : '-',
+                     xpsr & XPSR_Z ? 'Z' : '-',
+                     xpsr & XPSR_C ? 'C' : '-',
+                     xpsr & XPSR_V ? 'V' : '-',
+                     xpsr & XPSR_T ? 'T' : 'A',
+                     ns_status,
+                     mode);
     } else {
         uint32_t psr = cpsr_read(env);
         const char *ns_status = "";
@@ -13829,15 +13829,15 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
             ns_status = env->cp15.scr_el3 & SCR_NS ? "NS " : "S ";
         }
 
-        cpu_fprintf(f, "PSR=%08x %c%c%c%c %c %s%s%d\n",
-                    psr,
-                    psr & CPSR_N ? 'N' : '-',
-                    psr & CPSR_Z ? 'Z' : '-',
-                    psr & CPSR_C ? 'C' : '-',
-                    psr & CPSR_V ? 'V' : '-',
-                    psr & CPSR_T ? 'T' : 'A',
-                    ns_status,
-                    aarch32_mode_name(psr), (psr & 0x10) ? 32 : 26);
+        qemu_fprintf(f, "PSR=%08x %c%c%c%c %c %s%s%d\n",
+                     psr,
+                     psr & CPSR_N ? 'N' : '-',
+                     psr & CPSR_Z ? 'Z' : '-',
+                     psr & CPSR_C ? 'C' : '-',
+                     psr & CPSR_V ? 'V' : '-',
+                     psr & CPSR_T ? 'T' : 'A',
+                     ns_status,
+                     aarch32_mode_name(psr), (psr & 0x10) ? 32 : 26);
     }
 
     if (flags & CPU_DUMP_FPU) {
@@ -13850,12 +13850,12 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
         }
         for (i = 0; i < numvfpregs; i++) {
             uint64_t v = *aa32_vfp_dreg(env, i);
-            cpu_fprintf(f, "s%02d=%08x s%02d=%08x d%02d=%016" PRIx64 "\n",
-                        i * 2, (uint32_t)v,
-                        i * 2 + 1, (uint32_t)(v >> 32),
-                        i, v);
+            qemu_fprintf(f, "s%02d=%08x s%02d=%08x d%02d=%016" PRIx64 "\n",
+                         i * 2, (uint32_t)v,
+                         i * 2 + 1, (uint32_t)(v >> 32),
+                         i, v);
         }
-        cpu_fprintf(f, "FPSCR: %08x\n", vfp_get_fpscr(env));
+        qemu_fprintf(f, "FPSCR: %08x\n", vfp_get_fpscr(env));
     }
 }
 
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 912cc2a4a5..984617786d 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -166,8 +166,7 @@ static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
 void gen_a64_set_pc_im(uint64_t val);
-void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
-                            fprintf_function cpu_fprintf, int flags);
+void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 extern const TranslatorOps aarch64_translator_ops;
 #else
 static inline void a64_translate_init(void)
@@ -178,9 +177,7 @@ static inline void gen_a64_set_pc_im(uint64_t val)
 {
 }
 
-static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
-                                          fprintf_function cpu_fprintf,
-                                          int flags)
+static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
 }
 #endif
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 3d11922fb2..0fbe771639 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -207,8 +207,7 @@ void cris_cpu_do_interrupt(CPUState *cpu);
 void crisv10_cpu_do_interrupt(CPUState *cpu);
 bool cris_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
-void cris_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                         int flags);
+void cris_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
 hwaddr cris_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
diff --git a/target/cris/helper.c b/target/cris/helper.c
index b2dbb2075c..3939603c73 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -60,7 +60,7 @@ int cris_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
 
     cs->exception_index = 0xaa;
     cpu->env.pregs[PR_EDA] = address;
-    cpu_dump_state(cs, stderr, fprintf, 0);
+    cpu_dump_state(cs, stderr, 0);
     return 1;
 }
 
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 11b2c11174..96359c0d7d 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -33,6 +33,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 #include "crisv32-decode.h"
+#include "qemu/qemu-print.h"
 
 #include "exec/helper-gen.h"
 
@@ -3299,8 +3300,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 #endif
 }
 
-void cris_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                         int flags)
+void cris_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
     CPUCRISState *env = &cpu->env;
@@ -3308,7 +3308,7 @@ void cris_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     const char **pregnames;
     int i;
 
-    if (!env || !f) {
+    if (!env) {
         return;
     }
     if (env->pregs[PR_VR] < 32) {
@@ -3319,40 +3319,40 @@ void cris_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
         regnames = regnames_v32;
     }
 
-    cpu_fprintf(f, "PC=%x CCS=%x btaken=%d btarget=%x\n"
-            "cc_op=%d cc_src=%d cc_dest=%d cc_result=%x cc_mask=%x\n",
-            env->pc, env->pregs[PR_CCS], env->btaken, env->btarget,
-            env->cc_op,
-            env->cc_src, env->cc_dest, env->cc_result, env->cc_mask);
+    qemu_fprintf(f, "PC=%x CCS=%x btaken=%d btarget=%x\n"
+                 "cc_op=%d cc_src=%d cc_dest=%d cc_result=%x cc_mask=%x\n",
+                 env->pc, env->pregs[PR_CCS], env->btaken, env->btarget,
+                 env->cc_op,
+                 env->cc_src, env->cc_dest, env->cc_result, env->cc_mask);
 
 
     for (i = 0; i < 16; i++) {
-        cpu_fprintf(f, "%s=%8.8x ", regnames[i], env->regs[i]);
+        qemu_fprintf(f, "%s=%8.8x ", regnames[i], env->regs[i]);
         if ((i + 1) % 4 == 0) {
-            cpu_fprintf(f, "\n");
+            qemu_fprintf(f, "\n");
         }
     }
-    cpu_fprintf(f, "\nspecial regs:\n");
+    qemu_fprintf(f, "\nspecial regs:\n");
     for (i = 0; i < 16; i++) {
-        cpu_fprintf(f, "%s=%8.8x ", pregnames[i], env->pregs[i]);
+        qemu_fprintf(f, "%s=%8.8x ", pregnames[i], env->pregs[i]);
         if ((i + 1) % 4 == 0) {
-            cpu_fprintf(f, "\n");
+            qemu_fprintf(f, "\n");
         }
     }
     if (env->pregs[PR_VR] >= 32) {
         uint32_t srs = env->pregs[PR_SRS];
-        cpu_fprintf(f, "\nsupport function regs bank %x:\n", srs);
+        qemu_fprintf(f, "\nsupport function regs bank %x:\n", srs);
         if (srs < ARRAY_SIZE(env->sregs)) {
             for (i = 0; i < 16; i++) {
-                cpu_fprintf(f, "s%2.2d=%8.8x ",
-                        i, env->sregs[srs][i]);
+                qemu_fprintf(f, "s%2.2d=%8.8x ",
+                             i, env->sregs[srs][i]);
                 if ((i + 1) % 4 == 0) {
-                    cpu_fprintf(f, "\n");
+                    qemu_fprintf(f, "\n");
                 }
             }
         }
     }
-    cpu_fprintf(f, "\n\n");
+    qemu_fprintf(f, "\n\n");
 
 }
 
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index db8c9b812c..923346adb6 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -359,7 +359,7 @@ int hppa_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
-void hppa_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function, int);
+void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
 #ifdef CONFIG_USER_ONLY
 int hppa_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
                               int rw, int midx);
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index ac750b62ef..11c61b3ca2 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -23,6 +23,7 @@
 #include "fpu/softfloat.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "qemu/qemu-print.h"
 
 target_ureg cpu_hppa_get_psw(CPUHPPAState *env)
 {
@@ -76,8 +77,7 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
     }
 }
 
-void hppa_cpu_dump_state(CPUState *cs, FILE *f,
-                         fprintf_function cpu_fprintf, int flags)
+void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
@@ -86,9 +86,9 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f,
     char psw_c[20];
     int i;
 
-    cpu_fprintf(f, "IA_F " TARGET_FMT_lx " IA_B " TARGET_FMT_lx "\n",
-                hppa_form_gva_psw(psw, env->iasq_f, env->iaoq_f),
-                hppa_form_gva_psw(psw, env->iasq_b, env->iaoq_b));
+    qemu_fprintf(f, "IA_F " TARGET_FMT_lx " IA_B " TARGET_FMT_lx "\n",
+                 hppa_form_gva_psw(psw, env->iasq_f, env->iaoq_f),
+                 hppa_form_gva_psw(psw, env->iasq_b, env->iaoq_b));
 
     psw_c[0]  = (psw & PSW_W ? 'W' : '-');
     psw_c[1]  = (psw & PSW_E ? 'E' : '-');
@@ -111,20 +111,20 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f,
     psw_c[18] = '\0';
     psw_cb = ((env->psw_cb >> 4) & 0x01111111) | (env->psw_cb_msb << 28);
 
-    cpu_fprintf(f, "PSW  " TREG_FMT_lx " CB   " TREG_FMT_lx " %s\n",
-                psw, psw_cb, psw_c);
+    qemu_fprintf(f, "PSW  " TREG_FMT_lx " CB   " TREG_FMT_lx " %s\n",
+                 psw, psw_cb, psw_c);
 
     for (i = 0; i < 32; i++) {
-        cpu_fprintf(f, "GR%02d " TREG_FMT_lx "%c", i, env->gr[i],
-                    (i & 3) == 3 ? '\n' : ' ');
+        qemu_fprintf(f, "GR%02d " TREG_FMT_lx "%c", i, env->gr[i],
+                     (i & 3) == 3 ? '\n' : ' ');
     }
 #ifndef CONFIG_USER_ONLY
     for (i = 0; i < 8; i++) {
-        cpu_fprintf(f, "SR%02d %08x%c", i, (uint32_t)(env->sr[i] >> 32),
-                    (i & 3) == 3 ? '\n' : ' ');
+        qemu_fprintf(f, "SR%02d %08x%c", i, (uint32_t)(env->sr[i] >> 32),
+                     (i & 3) == 3 ? '\n' : ' ');
     }
 #endif
-     cpu_fprintf(f, "\n");
+     qemu_fprintf(f, "\n");
 
     /* ??? FR */
 }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 139fe30960..828067bd1c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1521,8 +1521,7 @@ int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
 void x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                                 Error **errp);
 
-void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                        int flags);
+void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
 hwaddr x86_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index b978a9b821..44b89c1d74 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -540,7 +540,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
                     ht->_exit_reason);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             hax_vcpu_sync_state(env, 0);
-            cpu_dump_state(cpu, stderr, fprintf, 0);
+            cpu_dump_state(cpu, stderr, 0);
             ret = -1;
             break;
         case HAX_EXIT_HLT:
@@ -571,7 +571,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
             fprintf(stderr, "Unknown exit %x from HAX\n", ht->_exit_status);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             hax_vcpu_sync_state(env, 0);
-            cpu_dump_state(cpu, stderr, fprintf, 0);
+            cpu_dump_state(cpu, stderr, 0);
             ret = 1;
             break;
         }
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 565391a9f6..96336055f3 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -156,38 +156,41 @@ static const char *cc_op_str[CC_OP_NB] = {
 };
 
 static void
-cpu_x86_dump_seg_cache(CPUX86State *env, FILE *f, fprintf_function cpu_fprintf,
+cpu_x86_dump_seg_cache(CPUX86State *env, FILE *f,
                        const char *name, struct SegmentCache *sc)
 {
 #ifdef TARGET_X86_64
     if (env->hflags & HF_CS64_MASK) {
-        cpu_fprintf(f, "%-3s=%04x %016" PRIx64 " %08x %08x", name,
-                    sc->selector, sc->base, sc->limit, sc->flags & 0x00ffff00);
+        qemu_fprintf(f, "%-3s=%04x %016" PRIx64 " %08x %08x", name,
+                     sc->selector, sc->base, sc->limit,
+                     sc->flags & 0x00ffff00);
     } else
 #endif
     {
-        cpu_fprintf(f, "%-3s=%04x %08x %08x %08x", name, sc->selector,
-                    (uint32_t)sc->base, sc->limit, sc->flags & 0x00ffff00);
+        qemu_fprintf(f, "%-3s=%04x %08x %08x %08x", name, sc->selector,
+                     (uint32_t)sc->base, sc->limit,
+                     sc->flags & 0x00ffff00);
     }
 
     if (!(env->hflags & HF_PE_MASK) || !(sc->flags & DESC_P_MASK))
         goto done;
 
-    cpu_fprintf(f, " DPL=%d ", (sc->flags & DESC_DPL_MASK) >> DESC_DPL_SHIFT);
+    qemu_fprintf(f, " DPL=%d ",
+                 (sc->flags & DESC_DPL_MASK) >> DESC_DPL_SHIFT);
     if (sc->flags & DESC_S_MASK) {
         if (sc->flags & DESC_CS_MASK) {
-            cpu_fprintf(f, (sc->flags & DESC_L_MASK) ? "CS64" :
-                           ((sc->flags & DESC_B_MASK) ? "CS32" : "CS16"));
-            cpu_fprintf(f, " [%c%c", (sc->flags & DESC_C_MASK) ? 'C' : '-',
-                        (sc->flags & DESC_R_MASK) ? 'R' : '-');
+            qemu_fprintf(f, (sc->flags & DESC_L_MASK) ? "CS64" :
+                         ((sc->flags & DESC_B_MASK) ? "CS32" : "CS16"));
+            qemu_fprintf(f, " [%c%c", (sc->flags & DESC_C_MASK) ? 'C' : '-',
+                         (sc->flags & DESC_R_MASK) ? 'R' : '-');
         } else {
-            cpu_fprintf(f,
-                        (sc->flags & DESC_B_MASK || env->hflags & HF_LMA_MASK)
-                        ? "DS  " : "DS16");
-            cpu_fprintf(f, " [%c%c", (sc->flags & DESC_E_MASK) ? 'E' : '-',
-                        (sc->flags & DESC_W_MASK) ? 'W' : '-');
+            qemu_fprintf(f, (sc->flags & DESC_B_MASK
+                             || env->hflags & HF_LMA_MASK)
+                         ? "DS  " : "DS16");
+            qemu_fprintf(f, " [%c%c", (sc->flags & DESC_E_MASK) ? 'E' : '-',
+                         (sc->flags & DESC_W_MASK) ? 'W' : '-');
         }
-        cpu_fprintf(f, "%c]", (sc->flags & DESC_A_MASK) ? 'A' : '-');
+        qemu_fprintf(f, "%c]", (sc->flags & DESC_A_MASK) ? 'A' : '-');
     } else {
         static const char *sys_type_name[2][16] = {
             { /* 32 bit mode */
@@ -203,13 +206,12 @@ cpu_x86_dump_seg_cache(CPUX86State *env, FILE *f, fprintf_function cpu_fprintf,
                 "Reserved", "IntGate64", "TrapGate64"
             }
         };
-        cpu_fprintf(f, "%s",
-                    sys_type_name[(env->hflags & HF_LMA_MASK) ? 1 : 0]
-                                 [(sc->flags & DESC_TYPE_MASK)
-                                  >> DESC_TYPE_SHIFT]);
+        qemu_fprintf(f, "%s",
+                     sys_type_name[(env->hflags & HF_LMA_MASK) ? 1 : 0]
+                     [(sc->flags & DESC_TYPE_MASK) >> DESC_TYPE_SHIFT]);
     }
 done:
-    cpu_fprintf(f, "\n");
+    qemu_fprintf(f, "\n");
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -403,8 +405,7 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, int flags)
 #define DUMP_CODE_BYTES_TOTAL    50
 #define DUMP_CODE_BYTES_BACKWARD 20
 
-void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                        int flags)
+void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -415,109 +416,107 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     eflags = cpu_compute_eflags(env);
 #ifdef TARGET_X86_64
     if (env->hflags & HF_CS64_MASK) {
-        cpu_fprintf(f,
-                    "RAX=%016" PRIx64 " RBX=%016" PRIx64 " RCX=%016" PRIx64 " RDX=%016" PRIx64 "\n"
-                    "RSI=%016" PRIx64 " RDI=%016" PRIx64 " RBP=%016" PRIx64 " RSP=%016" PRIx64 "\n"
-                    "R8 =%016" PRIx64 " R9 =%016" PRIx64 " R10=%016" PRIx64 " R11=%016" PRIx64 "\n"
-                    "R12=%016" PRIx64 " R13=%016" PRIx64 " R14=%016" PRIx64 " R15=%016" PRIx64 "\n"
-                    "RIP=%016" PRIx64 " RFL=%08x [%c%c%c%c%c%c%c] CPL=%d II=%d A20=%d SMM=%d HLT=%d\n",
-                    env->regs[R_EAX],
-                    env->regs[R_EBX],
-                    env->regs[R_ECX],
-                    env->regs[R_EDX],
-                    env->regs[R_ESI],
-                    env->regs[R_EDI],
-                    env->regs[R_EBP],
-                    env->regs[R_ESP],
-                    env->regs[8],
-                    env->regs[9],
-                    env->regs[10],
-                    env->regs[11],
-                    env->regs[12],
-                    env->regs[13],
-                    env->regs[14],
-                    env->regs[15],
-                    env->eip, eflags,
-                    eflags & DF_MASK ? 'D' : '-',
-                    eflags & CC_O ? 'O' : '-',
-                    eflags & CC_S ? 'S' : '-',
-                    eflags & CC_Z ? 'Z' : '-',
-                    eflags & CC_A ? 'A' : '-',
-                    eflags & CC_P ? 'P' : '-',
-                    eflags & CC_C ? 'C' : '-',
-                    env->hflags & HF_CPL_MASK,
-                    (env->hflags >> HF_INHIBIT_IRQ_SHIFT) & 1,
-                    (env->a20_mask >> 20) & 1,
-                    (env->hflags >> HF_SMM_SHIFT) & 1,
-                    cs->halted);
+        qemu_fprintf(f, "RAX=%016" PRIx64 " RBX=%016" PRIx64 " RCX=%016" PRIx64 " RDX=%016" PRIx64 "\n"
+                     "RSI=%016" PRIx64 " RDI=%016" PRIx64 " RBP=%016" PRIx64 " RSP=%016" PRIx64 "\n"
+                     "R8 =%016" PRIx64 " R9 =%016" PRIx64 " R10=%016" PRIx64 " R11=%016" PRIx64 "\n"
+                     "R12=%016" PRIx64 " R13=%016" PRIx64 " R14=%016" PRIx64 " R15=%016" PRIx64 "\n"
+                     "RIP=%016" PRIx64 " RFL=%08x [%c%c%c%c%c%c%c] CPL=%d II=%d A20=%d SMM=%d HLT=%d\n",
+                     env->regs[R_EAX],
+                     env->regs[R_EBX],
+                     env->regs[R_ECX],
+                     env->regs[R_EDX],
+                     env->regs[R_ESI],
+                     env->regs[R_EDI],
+                     env->regs[R_EBP],
+                     env->regs[R_ESP],
+                     env->regs[8],
+                     env->regs[9],
+                     env->regs[10],
+                     env->regs[11],
+                     env->regs[12],
+                     env->regs[13],
+                     env->regs[14],
+                     env->regs[15],
+                     env->eip, eflags,
+                     eflags & DF_MASK ? 'D' : '-',
+                     eflags & CC_O ? 'O' : '-',
+                     eflags & CC_S ? 'S' : '-',
+                     eflags & CC_Z ? 'Z' : '-',
+                     eflags & CC_A ? 'A' : '-',
+                     eflags & CC_P ? 'P' : '-',
+                     eflags & CC_C ? 'C' : '-',
+                     env->hflags & HF_CPL_MASK,
+                     (env->hflags >> HF_INHIBIT_IRQ_SHIFT) & 1,
+                     (env->a20_mask >> 20) & 1,
+                     (env->hflags >> HF_SMM_SHIFT) & 1,
+                     cs->halted);
     } else
 #endif
     {
-        cpu_fprintf(f, "EAX=%08x EBX=%08x ECX=%08x EDX=%08x\n"
-                    "ESI=%08x EDI=%08x EBP=%08x ESP=%08x\n"
-                    "EIP=%08x EFL=%08x [%c%c%c%c%c%c%c] CPL=%d II=%d A20=%d SMM=%d HLT=%d\n",
-                    (uint32_t)env->regs[R_EAX],
-                    (uint32_t)env->regs[R_EBX],
-                    (uint32_t)env->regs[R_ECX],
-                    (uint32_t)env->regs[R_EDX],
-                    (uint32_t)env->regs[R_ESI],
-                    (uint32_t)env->regs[R_EDI],
-                    (uint32_t)env->regs[R_EBP],
-                    (uint32_t)env->regs[R_ESP],
-                    (uint32_t)env->eip, eflags,
-                    eflags & DF_MASK ? 'D' : '-',
-                    eflags & CC_O ? 'O' : '-',
-                    eflags & CC_S ? 'S' : '-',
-                    eflags & CC_Z ? 'Z' : '-',
-                    eflags & CC_A ? 'A' : '-',
-                    eflags & CC_P ? 'P' : '-',
-                    eflags & CC_C ? 'C' : '-',
-                    env->hflags & HF_CPL_MASK,
-                    (env->hflags >> HF_INHIBIT_IRQ_SHIFT) & 1,
-                    (env->a20_mask >> 20) & 1,
-                    (env->hflags >> HF_SMM_SHIFT) & 1,
-                    cs->halted);
+        qemu_fprintf(f, "EAX=%08x EBX=%08x ECX=%08x EDX=%08x\n"
+                     "ESI=%08x EDI=%08x EBP=%08x ESP=%08x\n"
+                     "EIP=%08x EFL=%08x [%c%c%c%c%c%c%c] CPL=%d II=%d A20=%d SMM=%d HLT=%d\n",
+                     (uint32_t)env->regs[R_EAX],
+                     (uint32_t)env->regs[R_EBX],
+                     (uint32_t)env->regs[R_ECX],
+                     (uint32_t)env->regs[R_EDX],
+                     (uint32_t)env->regs[R_ESI],
+                     (uint32_t)env->regs[R_EDI],
+                     (uint32_t)env->regs[R_EBP],
+                     (uint32_t)env->regs[R_ESP],
+                     (uint32_t)env->eip, eflags,
+                     eflags & DF_MASK ? 'D' : '-',
+                     eflags & CC_O ? 'O' : '-',
+                     eflags & CC_S ? 'S' : '-',
+                     eflags & CC_Z ? 'Z' : '-',
+                     eflags & CC_A ? 'A' : '-',
+                     eflags & CC_P ? 'P' : '-',
+                     eflags & CC_C ? 'C' : '-',
+                     env->hflags & HF_CPL_MASK,
+                     (env->hflags >> HF_INHIBIT_IRQ_SHIFT) & 1,
+                     (env->a20_mask >> 20) & 1,
+                     (env->hflags >> HF_SMM_SHIFT) & 1,
+                     cs->halted);
     }
 
     for(i = 0; i < 6; i++) {
-        cpu_x86_dump_seg_cache(env, f, cpu_fprintf, seg_name[i],
-                               &env->segs[i]);
+        cpu_x86_dump_seg_cache(env, f, seg_name[i], &env->segs[i]);
     }
-    cpu_x86_dump_seg_cache(env, f, cpu_fprintf, "LDT", &env->ldt);
-    cpu_x86_dump_seg_cache(env, f, cpu_fprintf, "TR", &env->tr);
+    cpu_x86_dump_seg_cache(env, f, "LDT", &env->ldt);
+    cpu_x86_dump_seg_cache(env, f, "TR", &env->tr);
 
 #ifdef TARGET_X86_64
     if (env->hflags & HF_LMA_MASK) {
-        cpu_fprintf(f, "GDT=     %016" PRIx64 " %08x\n",
-                    env->gdt.base, env->gdt.limit);
-        cpu_fprintf(f, "IDT=     %016" PRIx64 " %08x\n",
-                    env->idt.base, env->idt.limit);
-        cpu_fprintf(f, "CR0=%08x CR2=%016" PRIx64 " CR3=%016" PRIx64 " CR4=%08x\n",
-                    (uint32_t)env->cr[0],
-                    env->cr[2],
-                    env->cr[3],
-                    (uint32_t)env->cr[4]);
+        qemu_fprintf(f, "GDT=     %016" PRIx64 " %08x\n",
+                     env->gdt.base, env->gdt.limit);
+        qemu_fprintf(f, "IDT=     %016" PRIx64 " %08x\n",
+                     env->idt.base, env->idt.limit);
+        qemu_fprintf(f, "CR0=%08x CR2=%016" PRIx64 " CR3=%016" PRIx64 " CR4=%08x\n",
+                     (uint32_t)env->cr[0],
+                     env->cr[2],
+                     env->cr[3],
+                     (uint32_t)env->cr[4]);
         for(i = 0; i < 4; i++)
-            cpu_fprintf(f, "DR%d=%016" PRIx64 " ", i, env->dr[i]);
-        cpu_fprintf(f, "\nDR6=%016" PRIx64 " DR7=%016" PRIx64 "\n",
-                    env->dr[6], env->dr[7]);
+            qemu_fprintf(f, "DR%d=%016" PRIx64 " ", i, env->dr[i]);
+        qemu_fprintf(f, "\nDR6=%016" PRIx64 " DR7=%016" PRIx64 "\n",
+                     env->dr[6], env->dr[7]);
     } else
 #endif
     {
-        cpu_fprintf(f, "GDT=     %08x %08x\n",
-                    (uint32_t)env->gdt.base, env->gdt.limit);
-        cpu_fprintf(f, "IDT=     %08x %08x\n",
-                    (uint32_t)env->idt.base, env->idt.limit);
-        cpu_fprintf(f, "CR0=%08x CR2=%08x CR3=%08x CR4=%08x\n",
-                    (uint32_t)env->cr[0],
-                    (uint32_t)env->cr[2],
-                    (uint32_t)env->cr[3],
-                    (uint32_t)env->cr[4]);
+        qemu_fprintf(f, "GDT=     %08x %08x\n",
+                     (uint32_t)env->gdt.base, env->gdt.limit);
+        qemu_fprintf(f, "IDT=     %08x %08x\n",
+                     (uint32_t)env->idt.base, env->idt.limit);
+        qemu_fprintf(f, "CR0=%08x CR2=%08x CR3=%08x CR4=%08x\n",
+                     (uint32_t)env->cr[0],
+                     (uint32_t)env->cr[2],
+                     (uint32_t)env->cr[3],
+                     (uint32_t)env->cr[4]);
         for(i = 0; i < 4; i++) {
-            cpu_fprintf(f, "DR%d=" TARGET_FMT_lx " ", i, env->dr[i]);
+            qemu_fprintf(f, "DR%d=" TARGET_FMT_lx " ", i, env->dr[i]);
         }
-        cpu_fprintf(f, "\nDR6=" TARGET_FMT_lx " DR7=" TARGET_FMT_lx "\n",
-                    env->dr[6], env->dr[7]);
+        qemu_fprintf(f, "\nDR6=" TARGET_FMT_lx " DR7=" TARGET_FMT_lx "\n",
+                     env->dr[6], env->dr[7]);
     }
     if (flags & CPU_DUMP_CCOP) {
         if ((unsigned)env->cc_op < CC_OP_NB)
@@ -526,55 +525,55 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
             snprintf(cc_op_name, sizeof(cc_op_name), "[%d]", env->cc_op);
 #ifdef TARGET_X86_64
         if (env->hflags & HF_CS64_MASK) {
-            cpu_fprintf(f, "CCS=%016" PRIx64 " CCD=%016" PRIx64 " CCO=%-8s\n",
-                        env->cc_src, env->cc_dst,
-                        cc_op_name);
+            qemu_fprintf(f, "CCS=%016" PRIx64 " CCD=%016" PRIx64 " CCO=%-8s\n",
+                         env->cc_src, env->cc_dst,
+                         cc_op_name);
         } else
 #endif
         {
-            cpu_fprintf(f, "CCS=%08x CCD=%08x CCO=%-8s\n",
-                        (uint32_t)env->cc_src, (uint32_t)env->cc_dst,
-                        cc_op_name);
+            qemu_fprintf(f, "CCS=%08x CCD=%08x CCO=%-8s\n",
+                         (uint32_t)env->cc_src, (uint32_t)env->cc_dst,
+                         cc_op_name);
         }
     }
-    cpu_fprintf(f, "EFER=%016" PRIx64 "\n", env->efer);
+    qemu_fprintf(f, "EFER=%016" PRIx64 "\n", env->efer);
     if (flags & CPU_DUMP_FPU) {
         int fptag;
         fptag = 0;
         for(i = 0; i < 8; i++) {
             fptag |= ((!env->fptags[i]) << i);
         }
-        cpu_fprintf(f, "FCW=%04x FSW=%04x [ST=%d] FTW=%02x MXCSR=%08x\n",
-                    env->fpuc,
-                    (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11,
-                    env->fpstt,
-                    fptag,
-                    env->mxcsr);
+        qemu_fprintf(f, "FCW=%04x FSW=%04x [ST=%d] FTW=%02x MXCSR=%08x\n",
+                     env->fpuc,
+                     (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11,
+                     env->fpstt,
+                     fptag,
+                     env->mxcsr);
         for(i=0;i<8;i++) {
             CPU_LDoubleU u;
             u.d = env->fpregs[i].d;
-            cpu_fprintf(f, "FPR%d=%016" PRIx64 " %04x",
-                        i, u.l.lower, u.l.upper);
+            qemu_fprintf(f, "FPR%d=%016" PRIx64 " %04x",
+                         i, u.l.lower, u.l.upper);
             if ((i & 1) == 1)
-                cpu_fprintf(f, "\n");
+                qemu_fprintf(f, "\n");
             else
-                cpu_fprintf(f, " ");
+                qemu_fprintf(f, " ");
         }
         if (env->hflags & HF_CS64_MASK)
             nb = 16;
         else
             nb = 8;
         for(i=0;i<nb;i++) {
-            cpu_fprintf(f, "XMM%02d=%08x%08x%08x%08x",
-                        i,
-                        env->xmm_regs[i].ZMM_L(3),
-                        env->xmm_regs[i].ZMM_L(2),
-                        env->xmm_regs[i].ZMM_L(1),
-                        env->xmm_regs[i].ZMM_L(0));
+            qemu_fprintf(f, "XMM%02d=%08x%08x%08x%08x",
+                         i,
+                         env->xmm_regs[i].ZMM_L(3),
+                         env->xmm_regs[i].ZMM_L(2),
+                         env->xmm_regs[i].ZMM_L(1),
+                         env->xmm_regs[i].ZMM_L(0));
             if ((i & 1) == 1)
-                cpu_fprintf(f, "\n");
+                qemu_fprintf(f, "\n");
             else
-                cpu_fprintf(f, " ");
+                qemu_fprintf(f, " ");
         }
     }
     if (flags & CPU_DUMP_CODE) {
@@ -583,17 +582,17 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
         uint8_t code;
         char codestr[3];
 
-        cpu_fprintf(f, "Code=");
+        qemu_fprintf(f, "Code=");
         for (i = 0; i < DUMP_CODE_BYTES_TOTAL; i++) {
             if (cpu_memory_rw_debug(cs, base - offs + i, &code, 1, 0) == 0) {
                 snprintf(codestr, sizeof(codestr), "%02x", code);
             } else {
                 snprintf(codestr, sizeof(codestr), "??");
             }
-            cpu_fprintf(f, "%s%s%s%s", i > 0 ? " " : "",
-                        i == offs ? "<" : "", codestr, i == offs ? ">" : "");
+            qemu_fprintf(f, "%s%s%s%s", i > 0 ? " " : "",
+                         i == offs ? "<" : "", codestr, i == offs ? ">" : "");
         }
-        cpu_fprintf(f, "\n");
+        qemu_fprintf(f, "\n");
     }
 }
 
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index b8d539ead8..9b1e6c2d58 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -219,8 +219,7 @@ extern const struct VMStateDescription vmstate_lm32_cpu;
 
 void lm32_cpu_do_interrupt(CPUState *cpu);
 bool lm32_cpu_exec_interrupt(CPUState *cs, int int_req);
-void lm32_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
-                         int flags);
+void lm32_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr lm32_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int lm32_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int lm32_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index b32feb7564..b8b5e12e63 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "exec/translator.h"
 #include "tcg-op.h"
+#include "qemu/qemu-print.h"
 
 #include "exec/cpu_ldst.h"
 #include "hw/lm32/lm32_pic.h"
@@ -1161,38 +1162,37 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 #endif
 }
 
-void lm32_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                         int flags)
+void lm32_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     LM32CPU *cpu = LM32_CPU(cs);
     CPULM32State *env = &cpu->env;
     int i;
 
-    if (!env || !f) {
+    if (!env) {
         return;
     }
 
-    cpu_fprintf(f, "IN: PC=%x %s\n",
-                env->pc, lookup_symbol(env->pc));
+    qemu_fprintf(f, "IN: PC=%x %s\n",
+                 env->pc, lookup_symbol(env->pc));
 
-    cpu_fprintf(f, "ie=%8.8x (IE=%x EIE=%x BIE=%x) im=%8.8x ip=%8.8x\n",
-             env->ie,
-             (env->ie & IE_IE) ? 1 : 0,
-             (env->ie & IE_EIE) ? 1 : 0,
-             (env->ie & IE_BIE) ? 1 : 0,
-             lm32_pic_get_im(env->pic_state),
-             lm32_pic_get_ip(env->pic_state));
-    cpu_fprintf(f, "eba=%8.8x deba=%8.8x\n",
-             env->eba,
-             env->deba);
+    qemu_fprintf(f, "ie=%8.8x (IE=%x EIE=%x BIE=%x) im=%8.8x ip=%8.8x\n",
+                 env->ie,
+                 (env->ie & IE_IE) ? 1 : 0,
+                 (env->ie & IE_EIE) ? 1 : 0,
+                 (env->ie & IE_BIE) ? 1 : 0,
+                 lm32_pic_get_im(env->pic_state),
+                 lm32_pic_get_ip(env->pic_state));
+    qemu_fprintf(f, "eba=%8.8x deba=%8.8x\n",
+                 env->eba,
+                 env->deba);
 
     for (i = 0; i < 32; i++) {
-        cpu_fprintf(f, "r%2.2d=%8.8x ", i, env->regs[i]);
+        qemu_fprintf(f, "r%2.2d=%8.8x ", i, env->regs[i]);
         if ((i + 1) % 4 == 0) {
-            cpu_fprintf(f, "\n");
+            qemu_fprintf(f, "\n");
         }
     }
-    cpu_fprintf(f, "\n\n");
+    qemu_fprintf(f, "\n\n");
 }
 
 void restore_state_to_opc(CPULM32State *env, TranslationBlock *tb,
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 73952f6ece..ad41608341 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -179,8 +179,7 @@ static inline M68kCPU *m68k_env_get_cpu(CPUM68KState *env)
 
 void m68k_cpu_do_interrupt(CPUState *cpu);
 bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
-void m68k_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
-                         int flags);
+void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int m68k_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int m68k_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 6217a683f1..3b2280b48b 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "tcg-op.h"
 #include "qemu/log.h"
+#include "qemu/qemu-print.h"
 #include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 
@@ -6187,76 +6188,75 @@ static double floatx80_to_double(CPUM68KState *env, uint16_t high, uint64_t low)
     return u.d;
 }
 
-void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                         int flags)
+void m68k_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     M68kCPU *cpu = M68K_CPU(cs);
     CPUM68KState *env = &cpu->env;
     int i;
     uint16_t sr;
     for (i = 0; i < 8; i++) {
-        cpu_fprintf(f, "D%d = %08x   A%d = %08x   "
-                    "F%d = %04x %016"PRIx64"  (%12g)\n",
-                    i, env->dregs[i], i, env->aregs[i],
-                    i, env->fregs[i].l.upper, env->fregs[i].l.lower,
-                    floatx80_to_double(env, env->fregs[i].l.upper,
-                                       env->fregs[i].l.lower));
+        qemu_fprintf(f, "D%d = %08x   A%d = %08x   "
+                     "F%d = %04x %016"PRIx64"  (%12g)\n",
+                     i, env->dregs[i], i, env->aregs[i],
+                     i, env->fregs[i].l.upper, env->fregs[i].l.lower,
+                     floatx80_to_double(env, env->fregs[i].l.upper,
+                                        env->fregs[i].l.lower));
     }
-    cpu_fprintf (f, "PC = %08x   ", env->pc);
+    qemu_fprintf(f, "PC = %08x   ", env->pc);
     sr = env->sr | cpu_m68k_get_ccr(env);
-    cpu_fprintf(f, "SR = %04x T:%x I:%x %c%c %c%c%c%c%c\n",
-                sr, (sr & SR_T) >> SR_T_SHIFT, (sr & SR_I) >> SR_I_SHIFT,
-                (sr & SR_S) ? 'S' : 'U', (sr & SR_M) ? '%' : 'I',
-                (sr & CCF_X) ? 'X' : '-', (sr & CCF_N) ? 'N' : '-',
-                (sr & CCF_Z) ? 'Z' : '-', (sr & CCF_V) ? 'V' : '-',
-                (sr & CCF_C) ? 'C' : '-');
-    cpu_fprintf(f, "FPSR = %08x %c%c%c%c ", env->fpsr,
-                (env->fpsr & FPSR_CC_A) ? 'A' : '-',
-                (env->fpsr & FPSR_CC_I) ? 'I' : '-',
-                (env->fpsr & FPSR_CC_Z) ? 'Z' : '-',
-                (env->fpsr & FPSR_CC_N) ? 'N' : '-');
-    cpu_fprintf(f, "\n                                "
-                   "FPCR =     %04x ", env->fpcr);
+    qemu_fprintf(f, "SR = %04x T:%x I:%x %c%c %c%c%c%c%c\n",
+                 sr, (sr & SR_T) >> SR_T_SHIFT, (sr & SR_I) >> SR_I_SHIFT,
+                 (sr & SR_S) ? 'S' : 'U', (sr & SR_M) ? '%' : 'I',
+                 (sr & CCF_X) ? 'X' : '-', (sr & CCF_N) ? 'N' : '-',
+                 (sr & CCF_Z) ? 'Z' : '-', (sr & CCF_V) ? 'V' : '-',
+                 (sr & CCF_C) ? 'C' : '-');
+    qemu_fprintf(f, "FPSR = %08x %c%c%c%c ", env->fpsr,
+                 (env->fpsr & FPSR_CC_A) ? 'A' : '-',
+                 (env->fpsr & FPSR_CC_I) ? 'I' : '-',
+                 (env->fpsr & FPSR_CC_Z) ? 'Z' : '-',
+                 (env->fpsr & FPSR_CC_N) ? 'N' : '-');
+    qemu_fprintf(f, "\n                                "
+                 "FPCR =     %04x ", env->fpcr);
     switch (env->fpcr & FPCR_PREC_MASK) {
     case FPCR_PREC_X:
-        cpu_fprintf(f, "X ");
+        qemu_fprintf(f, "X ");
         break;
     case FPCR_PREC_S:
-        cpu_fprintf(f, "S ");
+        qemu_fprintf(f, "S ");
         break;
     case FPCR_PREC_D:
-        cpu_fprintf(f, "D ");
+        qemu_fprintf(f, "D ");
         break;
     }
     switch (env->fpcr & FPCR_RND_MASK) {
     case FPCR_RND_N:
-        cpu_fprintf(f, "RN ");
+        qemu_fprintf(f, "RN ");
         break;
     case FPCR_RND_Z:
-        cpu_fprintf(f, "RZ ");
+        qemu_fprintf(f, "RZ ");
         break;
     case FPCR_RND_M:
-        cpu_fprintf(f, "RM ");
+        qemu_fprintf(f, "RM ");
         break;
     case FPCR_RND_P:
-        cpu_fprintf(f, "RP ");
+        qemu_fprintf(f, "RP ");
         break;
     }
-    cpu_fprintf(f, "\n");
+    qemu_fprintf(f, "\n");
 #ifdef CONFIG_SOFTMMU
-    cpu_fprintf(f, "%sA7(MSP) = %08x %sA7(USP) = %08x %sA7(ISP) = %08x\n",
-               env->current_sp == M68K_SSP ? "->" : "  ", env->sp[M68K_SSP],
-               env->current_sp == M68K_USP ? "->" : "  ", env->sp[M68K_USP],
-               env->current_sp == M68K_ISP ? "->" : "  ", env->sp[M68K_ISP]);
-    cpu_fprintf(f, "VBR = 0x%08x\n", env->vbr);
-    cpu_fprintf(f, "SFC = %x DFC %x\n", env->sfc, env->dfc);
-    cpu_fprintf(f, "SSW %08x TCR %08x URP %08x SRP %08x\n",
-                env->mmu.ssw, env->mmu.tcr, env->mmu.urp, env->mmu.srp);
-    cpu_fprintf(f, "DTTR0/1: %08x/%08x ITTR0/1: %08x/%08x\n",
-                env->mmu.ttr[M68K_DTTR0], env->mmu.ttr[M68K_DTTR1],
-                env->mmu.ttr[M68K_ITTR0], env->mmu.ttr[M68K_ITTR1]);
-    cpu_fprintf(f, "MMUSR %08x, fault at %08x\n",
-                env->mmu.mmusr, env->mmu.ar);
+    qemu_fprintf(f, "%sA7(MSP) = %08x %sA7(USP) = %08x %sA7(ISP) = %08x\n",
+                 env->current_sp == M68K_SSP ? "->" : "  ", env->sp[M68K_SSP],
+                 env->current_sp == M68K_USP ? "->" : "  ", env->sp[M68K_USP],
+                 env->current_sp == M68K_ISP ? "->" : "  ", env->sp[M68K_ISP]);
+    qemu_fprintf(f, "VBR = 0x%08x\n", env->vbr);
+    qemu_fprintf(f, "SFC = %x DFC %x\n", env->sfc, env->dfc);
+    qemu_fprintf(f, "SSW %08x TCR %08x URP %08x SRP %08x\n",
+                 env->mmu.ssw, env->mmu.tcr, env->mmu.urp, env->mmu.srp);
+    qemu_fprintf(f, "DTTR0/1: %08x/%08x ITTR0/1: %08x/%08x\n",
+                 env->mmu.ttr[M68K_DTTR0], env->mmu.ttr[M68K_DTTR1],
+                 env->mmu.ttr[M68K_ITTR0], env->mmu.ttr[M68K_ITTR1]);
+    qemu_fprintf(f, "MMUSR %08x, fault at %08x\n",
+                 env->mmu.mmusr, env->mmu.ar);
 #endif
 }
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 792bbc97c7..f20e796865 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -328,8 +328,7 @@ static inline MicroBlazeCPU *mb_env_get_cpu(CPUMBState *env)
 
 void mb_cpu_do_interrupt(CPUState *cs);
 bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
-void mb_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
-                       int flags);
+void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int mb_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index bc753793ec..9848e31d7f 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -42,7 +42,7 @@ int mb_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                             int mmu_idx)
 {
     cs->exception_index = 0xaa;
-    cpu_dump_state(cs, stderr, fprintf, 0);
+    cpu_dump_state(cs, stderr, 0);
     return 1;
 }
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 78ca265b04..bc2712ddbd 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -28,6 +28,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
+#include "qemu/qemu-print.h"
 
 #include "trace-tcg.h"
 #include "exec/log.h"
@@ -1785,36 +1786,36 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     assert(!dc->abort_at_next_insn);
 }
 
-void mb_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                       int flags)
+void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
     int i;
 
-    if (!env || !f)
+    if (!env) {
         return;
+    }
 
-    cpu_fprintf(f, "IN: PC=%" PRIx64 " %s\n",
-                env->sregs[SR_PC], lookup_symbol(env->sregs[SR_PC]));
-    cpu_fprintf(f, "rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
-                   "debug=%x imm=%x iflags=%x fsr=%" PRIx64 "\n",
-             env->sregs[SR_MSR], env->sregs[SR_ESR], env->sregs[SR_EAR],
-             env->debug, env->imm, env->iflags, env->sregs[SR_FSR]);
-    cpu_fprintf(f, "btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) "
-                   "eip=%d ie=%d\n",
-             env->btaken, env->btarget,
-             (env->sregs[SR_MSR] & MSR_UM) ? "user" : "kernel",
-             (env->sregs[SR_MSR] & MSR_UMS) ? "user" : "kernel",
-             (bool)(env->sregs[SR_MSR] & MSR_EIP),
-             (bool)(env->sregs[SR_MSR] & MSR_IE));
+    qemu_fprintf(f, "IN: PC=%" PRIx64 " %s\n",
+                 env->sregs[SR_PC], lookup_symbol(env->sregs[SR_PC]));
+    qemu_fprintf(f, "rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
+                 "debug=%x imm=%x iflags=%x fsr=%" PRIx64 "\n",
+                 env->sregs[SR_MSR], env->sregs[SR_ESR], env->sregs[SR_EAR],
+                 env->debug, env->imm, env->iflags, env->sregs[SR_FSR]);
+    qemu_fprintf(f, "btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) "
+                 "eip=%d ie=%d\n",
+                 env->btaken, env->btarget,
+                 (env->sregs[SR_MSR] & MSR_UM) ? "user" : "kernel",
+                 (env->sregs[SR_MSR] & MSR_UMS) ? "user" : "kernel",
+                 (bool)(env->sregs[SR_MSR] & MSR_EIP),
+                 (bool)(env->sregs[SR_MSR] & MSR_IE));
 
     for (i = 0; i < 32; i++) {
-        cpu_fprintf(f, "r%2.2d=%8.8x ", i, env->regs[i]);
+        qemu_fprintf(f, "r%2.2d=%8.8x ", i, env->regs[i]);
         if ((i + 1) % 4 == 0)
-            cpu_fprintf(f, "\n");
+            qemu_fprintf(f, "\n");
         }
-    cpu_fprintf(f, "\n\n");
+    qemu_fprintf(f, "\n\n");
 }
 
 void mb_tcg_init(void)
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 8f6fc919d5..286e3888ab 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -76,8 +76,7 @@ enum CPUMIPSMSADataFormat {
 
 void mips_cpu_do_interrupt(CPUState *cpu);
 bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
-void mips_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
-                         int flags);
+void mips_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int mips_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int mips_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/mips/translate.c b/target/mips/translate.c
index d886a0c9b2..7849d53977 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -29728,8 +29728,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     translator_loop(&mips_tr_ops, &ctx.base, cs, tb);
 }
 
-static void fpu_dump_state(CPUMIPSState *env, FILE *f, fprintf_function fpu_fprintf,
-                           int flags)
+static void fpu_dump_state(CPUMIPSState *env, FILE *f, int flags)
 {
     int i;
     int is_fpu64 = !!(env->hflags & MIPS_HFLAG_F64);
@@ -29737,68 +29736,69 @@ static void fpu_dump_state(CPUMIPSState *env, FILE *f, fprintf_function fpu_fpri
 #define printfpr(fp)                                                    \
     do {                                                                \
         if (is_fpu64)                                                   \
-            fpu_fprintf(f, "w:%08x d:%016" PRIx64                       \
-                        " fd:%13g fs:%13g psu: %13g\n",                 \
-                        (fp)->w[FP_ENDIAN_IDX], (fp)->d,                \
-                        (double)(fp)->fd,                               \
-                        (double)(fp)->fs[FP_ENDIAN_IDX],                \
-                        (double)(fp)->fs[!FP_ENDIAN_IDX]);              \
+            qemu_fprintf(f, "w:%08x d:%016" PRIx64                      \
+                         " fd:%13g fs:%13g psu: %13g\n",                \
+                         (fp)->w[FP_ENDIAN_IDX], (fp)->d,               \
+                         (double)(fp)->fd,                              \
+                         (double)(fp)->fs[FP_ENDIAN_IDX],               \
+                         (double)(fp)->fs[!FP_ENDIAN_IDX]);             \
         else {                                                          \
             fpr_t tmp;                                                  \
             tmp.w[FP_ENDIAN_IDX] = (fp)->w[FP_ENDIAN_IDX];              \
             tmp.w[!FP_ENDIAN_IDX] = ((fp) + 1)->w[FP_ENDIAN_IDX];       \
-            fpu_fprintf(f, "w:%08x d:%016" PRIx64                       \
-                        " fd:%13g fs:%13g psu:%13g\n",                  \
-                        tmp.w[FP_ENDIAN_IDX], tmp.d,                    \
-                        (double)tmp.fd,                                 \
-                        (double)tmp.fs[FP_ENDIAN_IDX],                  \
-                        (double)tmp.fs[!FP_ENDIAN_IDX]);                \
+            qemu_fprintf(f, "w:%08x d:%016" PRIx64                      \
+                         " fd:%13g fs:%13g psu:%13g\n",                 \
+                         tmp.w[FP_ENDIAN_IDX], tmp.d,                   \
+                         (double)tmp.fd,                                \
+                         (double)tmp.fs[FP_ENDIAN_IDX],                 \
+                         (double)tmp.fs[!FP_ENDIAN_IDX]);               \
         }                                                               \
     } while(0)
 
 
-    fpu_fprintf(f, "CP1 FCR0 0x%08x  FCR31 0x%08x  SR.FR %d  fp_status 0x%02x\n",
-                env->active_fpu.fcr0, env->active_fpu.fcr31, is_fpu64,
-                get_float_exception_flags(&env->active_fpu.fp_status));
+    qemu_fprintf(f,
+                 "CP1 FCR0 0x%08x  FCR31 0x%08x  SR.FR %d  fp_status 0x%02x\n",
+                 env->active_fpu.fcr0, env->active_fpu.fcr31, is_fpu64,
+                 get_float_exception_flags(&env->active_fpu.fp_status));
     for (i = 0; i < 32; (is_fpu64) ? i++ : (i += 2)) {
-        fpu_fprintf(f, "%3s: ", fregnames[i]);
+        qemu_fprintf(f, "%3s: ", fregnames[i]);
         printfpr(&env->active_fpu.fpr[i]);
     }
 
 #undef printfpr
 }
 
-void mips_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                         int flags)
+void mips_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     MIPSCPU *cpu = MIPS_CPU(cs);
     CPUMIPSState *env = &cpu->env;
     int i;
 
-    cpu_fprintf(f, "pc=0x" TARGET_FMT_lx " HI=0x" TARGET_FMT_lx
-                " LO=0x" TARGET_FMT_lx " ds %04x "
-                TARGET_FMT_lx " " TARGET_FMT_ld "\n",
-                env->active_tc.PC, env->active_tc.HI[0], env->active_tc.LO[0],
-                env->hflags, env->btarget, env->bcond);
+    qemu_fprintf(f, "pc=0x" TARGET_FMT_lx " HI=0x" TARGET_FMT_lx
+                 " LO=0x" TARGET_FMT_lx " ds %04x "
+                 TARGET_FMT_lx " " TARGET_FMT_ld "\n",
+                 env->active_tc.PC, env->active_tc.HI[0], env->active_tc.LO[0],
+                 env->hflags, env->btarget, env->bcond);
     for (i = 0; i < 32; i++) {
         if ((i & 3) == 0)
-            cpu_fprintf(f, "GPR%02d:", i);
-        cpu_fprintf(f, " %s " TARGET_FMT_lx, regnames[i], env->active_tc.gpr[i]);
+            qemu_fprintf(f, "GPR%02d:", i);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx,
+                     regnames[i], env->active_tc.gpr[i]);
         if ((i & 3) == 3)
-            cpu_fprintf(f, "\n");
+            qemu_fprintf(f, "\n");
     }
 
-    cpu_fprintf(f, "CP0 Status  0x%08x Cause   0x%08x EPC    0x" TARGET_FMT_lx "\n",
-                env->CP0_Status, env->CP0_Cause, env->CP0_EPC);
-    cpu_fprintf(f, "    Config0 0x%08x Config1 0x%08x LLAddr 0x%016"
-                PRIx64 "\n",
-                env->CP0_Config0, env->CP0_Config1, env->CP0_LLAddr);
-    cpu_fprintf(f, "    Config2 0x%08x Config3 0x%08x\n",
-                env->CP0_Config2, env->CP0_Config3);
-    cpu_fprintf(f, "    Config4 0x%08x Config5 0x%08x\n",
-                env->CP0_Config4, env->CP0_Config5);
+    qemu_fprintf(f, "CP0 Status  0x%08x Cause   0x%08x EPC    0x" TARGET_FMT_lx "\n",
+                 env->CP0_Status, env->CP0_Cause, env->CP0_EPC);
+    qemu_fprintf(f, "    Config0 0x%08x Config1 0x%08x LLAddr 0x%016"
+                 PRIx64 "\n",
+                 env->CP0_Config0, env->CP0_Config1, env->CP0_LLAddr);
+    qemu_fprintf(f, "    Config2 0x%08x Config3 0x%08x\n",
+                 env->CP0_Config2, env->CP0_Config3);
+    qemu_fprintf(f, "    Config4 0x%08x Config5 0x%08x\n",
+                 env->CP0_Config4, env->CP0_Config5);
     if ((flags & CPU_DUMP_FPU) && (env->hflags & MIPS_HFLAG_FPU)) {
-        fpu_dump_state(env, f, cpu_fprintf, flags);
+        fpu_dump_state(env, f, flags);
     }
 }
 
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 080df4ee6f..f3b6d83ae7 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -112,8 +112,7 @@ static inline MoxieCPU *moxie_env_get_cpu(CPUMoxieState *env)
 #define ENV_OFFSET offsetof(MoxieCPU, env)
 
 void moxie_cpu_do_interrupt(CPUState *cs);
-void moxie_cpu_dump_state(CPUState *cpu, FILE *f,
-                          fprintf_function cpu_fprintf, int flags);
+void moxie_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr moxie_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void moxie_translate_init(void);
 int cpu_moxie_signal_handler(int host_signum, void *pinfo,
diff --git a/target/moxie/helper.c b/target/moxie/helper.c
index f3d8ee7d6b..287a45232c 100644
--- a/target/moxie/helper.c
+++ b/target/moxie/helper.c
@@ -101,7 +101,7 @@ int moxie_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
 
     cs->exception_index = 0xaa;
     cpu->env.debug1 = address;
-    cpu_dump_state(cs, stderr, fprintf, 0);
+    cpu_dump_state(cs, stderr, 0);
     return 1;
 }
 
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index 68ca223e22..dd055c4ca5 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -28,6 +28,7 @@
 #include "disas/disas.h"
 #include "tcg-op.h"
 #include "exec/cpu_ldst.h"
+#include "qemu/qemu-print.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -69,24 +70,23 @@ static int extract_branch_offset(int opcode)
   return (((signed short)((opcode & ((1 << 10) - 1)) << 6)) >> 6) << 1;
 }
 
-void moxie_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                          int flags)
+void moxie_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     MoxieCPU *cpu = MOXIE_CPU(cs);
     CPUMoxieState *env = &cpu->env;
     int i;
-    cpu_fprintf(f, "pc=0x%08x\n", env->pc);
-    cpu_fprintf(f, "$fp=0x%08x $sp=0x%08x $r0=0x%08x $r1=0x%08x\n",
-                env->gregs[0], env->gregs[1], env->gregs[2], env->gregs[3]);
+    qemu_fprintf(f, "pc=0x%08x\n", env->pc);
+    qemu_fprintf(f, "$fp=0x%08x $sp=0x%08x $r0=0x%08x $r1=0x%08x\n",
+                 env->gregs[0], env->gregs[1], env->gregs[2], env->gregs[3]);
     for (i = 4; i < 16; i += 4) {
-        cpu_fprintf(f, "$r%d=0x%08x $r%d=0x%08x $r%d=0x%08x $r%d=0x%08x\n",
-                    i-2, env->gregs[i], i-1, env->gregs[i + 1],
-                    i, env->gregs[i + 2], i+1, env->gregs[i + 3]);
+        qemu_fprintf(f, "$r%d=0x%08x $r%d=0x%08x $r%d=0x%08x $r%d=0x%08x\n",
+                     i - 2, env->gregs[i], i - 1, env->gregs[i + 1],
+                     i, env->gregs[i + 2], i + 1, env->gregs[i + 3]);
     }
     for (i = 4; i < 16; i += 4) {
-        cpu_fprintf(f, "sr%d=0x%08x sr%d=0x%08x sr%d=0x%08x sr%d=0x%08x\n",
-                    i-2, env->sregs[i], i-1, env->sregs[i + 1],
-                    i, env->sregs[i + 2], i+1, env->sregs[i + 3]);
+        qemu_fprintf(f, "sr%d=0x%08x sr%d=0x%08x sr%d=0x%08x sr%d=0x%08x\n",
+                     i - 2, env->sregs[i], i - 1, env->sregs[i + 1],
+                     i, env->sregs[i + 2], i + 1, env->sregs[i + 3]);
     }
 }
 
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 6fa993bb0d..4e8eb7d2ca 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -213,8 +213,7 @@ void nios2_tcg_init(void);
 void nios2_cpu_do_interrupt(CPUState *cs);
 int cpu_nios2_signal_handler(int host_signum, void *pinfo, void *puc);
 void dump_mmu(CPUNios2State *env);
-void nios2_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
-                          int flags);
+void nios2_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr nios2_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void nios2_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                    MMUAccessType access_type,
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
index a8b8ec662a..a633fa03ee 100644
--- a/target/nios2/helper.c
+++ b/target/nios2/helper.c
@@ -42,7 +42,7 @@ int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
     cs->exception_index = 0xaa;
     /* Page 0x1000 is kuser helper */
     if (address < 0x1000 || address >= 0x2000) {
-        cpu_dump_state(cs, stderr, fprintf, 0);
+        cpu_dump_state(cs, stderr, 0);
     }
     return 1;
 }
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 7fa03ed05a..f0bbf78a32 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -31,6 +31,7 @@
 #include "exec/log.h"
 #include "exec/cpu_ldst.h"
 #include "exec/translator.h"
+#include "qemu/qemu-print.h"
 
 /* is_jmp field values */
 #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
@@ -914,33 +915,32 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 #endif
 }
 
-void nios2_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                          int flags)
+void nios2_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
     CPUNios2State *env = &cpu->env;
     int i;
 
-    if (!env || !f) {
+    if (!env) {
         return;
     }
 
-    cpu_fprintf(f, "IN: PC=%x %s\n",
-                env->regs[R_PC], lookup_symbol(env->regs[R_PC]));
+    qemu_fprintf(f, "IN: PC=%x %s\n",
+                 env->regs[R_PC], lookup_symbol(env->regs[R_PC]));
 
     for (i = 0; i < NUM_CORE_REGS; i++) {
-        cpu_fprintf(f, "%9s=%8.8x ", regnames[i], env->regs[i]);
+        qemu_fprintf(f, "%9s=%8.8x ", regnames[i], env->regs[i]);
         if ((i + 1) % 4 == 0) {
-            cpu_fprintf(f, "\n");
+            qemu_fprintf(f, "\n");
         }
     }
 #if !defined(CONFIG_USER_ONLY)
-    cpu_fprintf(f, " mmu write: VPN=%05X PID %02X TLBACC %08X\n",
-                env->mmu.pteaddr_wr & CR_PTEADDR_VPN_MASK,
-                (env->mmu.tlbmisc_wr & CR_TLBMISC_PID_MASK) >> 4,
-                env->mmu.tlbacc_wr);
+    qemu_fprintf(f, " mmu write: VPN=%05X PID %02X TLBACC %08X\n",
+                 env->mmu.pteaddr_wr & CR_PTEADDR_VPN_MASK,
+                 (env->mmu.tlbmisc_wr & CR_TLBMISC_PID_MASK) >> 4,
+                 env->mmu.tlbacc_wr);
 #endif
-    cpu_fprintf(f, "\n\n");
+    qemu_fprintf(f, "\n\n");
 }
 
 void nios2_tcg_init(void)
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 9d2d49631e..a50861955a 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -339,8 +339,7 @@ static inline OpenRISCCPU *openrisc_env_get_cpu(CPUOpenRISCState *env)
 void cpu_openrisc_list(void);
 void openrisc_cpu_do_interrupt(CPUState *cpu);
 bool openrisc_cpu_exec_interrupt(CPUState *cpu, int int_req);
-void openrisc_cpu_dump_state(CPUState *cpu, FILE *f,
-                             fprintf_function cpu_fprintf, int flags);
+void openrisc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int openrisc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int openrisc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 89680f882d..a88502fdc1 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -26,6 +26,7 @@
 #include "qemu-common.h"
 #include "qemu/log.h"
 #include "qemu/bitops.h"
+#include "qemu/qemu-print.h"
 #include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 
@@ -1415,18 +1416,16 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
     translator_loop(&openrisc_tr_ops, &ctx.base, cs, tb);
 }
 
-void openrisc_cpu_dump_state(CPUState *cs, FILE *f,
-                             fprintf_function cpu_fprintf,
-                             int flags)
+void openrisc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     CPUOpenRISCState *env = &cpu->env;
     int i;
 
-    cpu_fprintf(f, "PC=%08x\n", env->pc);
+    qemu_fprintf(f, "PC=%08x\n", env->pc);
     for (i = 0; i < 32; ++i) {
-        cpu_fprintf(f, "R%02d=%08x%c", i, cpu_get_gpr(env, i),
-                    (i % 4) == 3 ? '\n' : ' ');
+        qemu_fprintf(f, "R%02d=%08x%c", i, cpu_get_gpr(env, i),
+                     (i % 4) == 3 ? '\n' : ' ');
     }
 }
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 27a36b9605..d5259f7dd3 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1268,8 +1268,7 @@ struct PPCVirtualHypervisorClass {
 
 void ppc_cpu_do_interrupt(CPUState *cpu);
 bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
-void ppc_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
-                        int flags);
+void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 void ppc_cpu_dump_statistics(CPUState *cpu, int flags);
 hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int ppc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index f99f27a134..93d77a2626 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7414,8 +7414,7 @@ GEN_HANDLER2_E(trechkpt, "trechkpt", 0x1F, 0x0E, 0x1F, 0x03FFF800, \
 
 /*****************************************************************************/
 /* Misc PowerPC helpers */
-void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                        int flags)
+void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
 #define RGPL  4
 #define RFPL  4
@@ -7424,37 +7423,37 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     CPUPPCState *env = &cpu->env;
     int i;
 
-    cpu_fprintf(f, "NIP " TARGET_FMT_lx "   LR " TARGET_FMT_lx " CTR "
-                TARGET_FMT_lx " XER " TARGET_FMT_lx " CPU#%d\n",
-                env->nip, env->lr, env->ctr, cpu_read_xer(env),
-                cs->cpu_index);
-    cpu_fprintf(f, "MSR " TARGET_FMT_lx " HID0 " TARGET_FMT_lx "  HF "
-                TARGET_FMT_lx " iidx %d didx %d\n",
-                env->msr, env->spr[SPR_HID0],
-                env->hflags, env->immu_idx, env->dmmu_idx);
+    qemu_fprintf(f, "NIP " TARGET_FMT_lx "   LR " TARGET_FMT_lx " CTR "
+                 TARGET_FMT_lx " XER " TARGET_FMT_lx " CPU#%d\n",
+                 env->nip, env->lr, env->ctr, cpu_read_xer(env),
+                 cs->cpu_index);
+    qemu_fprintf(f, "MSR " TARGET_FMT_lx " HID0 " TARGET_FMT_lx "  HF "
+                 TARGET_FMT_lx " iidx %d didx %d\n",
+                 env->msr, env->spr[SPR_HID0],
+                 env->hflags, env->immu_idx, env->dmmu_idx);
 #if !defined(NO_TIMER_DUMP)
-    cpu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64
+    qemu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64
 #if !defined(CONFIG_USER_ONLY)
-                " DECR " TARGET_FMT_lu
+                 " DECR " TARGET_FMT_lu
 #endif
-                "\n",
-                cpu_ppc_load_tbu(env), cpu_ppc_load_tbl(env)
+                 "\n",
+                 cpu_ppc_load_tbu(env), cpu_ppc_load_tbl(env)
 #if !defined(CONFIG_USER_ONLY)
-                , cpu_ppc_load_decr(env)
+                 , cpu_ppc_load_decr(env)
 #endif
-                );
+        );
 #endif
     for (i = 0; i < 32; i++) {
         if ((i & (RGPL - 1)) == 0)
-            cpu_fprintf(f, "GPR%02d", i);
-        cpu_fprintf(f, " %016" PRIx64, ppc_dump_gpr(env, i));
+            qemu_fprintf(f, "GPR%02d", i);
+        qemu_fprintf(f, " %016" PRIx64, ppc_dump_gpr(env, i));
         if ((i & (RGPL - 1)) == (RGPL - 1))
-            cpu_fprintf(f, "\n");
+            qemu_fprintf(f, "\n");
     }
-    cpu_fprintf(f, "CR ");
+    qemu_fprintf(f, "CR ");
     for (i = 0; i < 8; i++)
-        cpu_fprintf(f, "%01x", env->crf[i]);
-    cpu_fprintf(f, "  [");
+        qemu_fprintf(f, "%01x", env->crf[i]);
+    qemu_fprintf(f, "  [");
     for (i = 0; i < 8; i++) {
         char a = '-';
         if (env->crf[i] & 0x08)
@@ -7463,74 +7462,74 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
             a = 'G';
         else if (env->crf[i] & 0x02)
             a = 'E';
-        cpu_fprintf(f, " %c%c", a, env->crf[i] & 0x01 ? 'O' : ' ');
+        qemu_fprintf(f, " %c%c", a, env->crf[i] & 0x01 ? 'O' : ' ');
     }
-    cpu_fprintf(f, " ]             RES " TARGET_FMT_lx "\n",
-                env->reserve_addr);
+    qemu_fprintf(f, " ]             RES " TARGET_FMT_lx "\n",
+                 env->reserve_addr);
 
     if (flags & CPU_DUMP_FPU) {
         for (i = 0; i < 32; i++) {
             if ((i & (RFPL - 1)) == 0) {
-                cpu_fprintf(f, "FPR%02d", i);
+                qemu_fprintf(f, "FPR%02d", i);
             }
-            cpu_fprintf(f, " %016" PRIx64, *cpu_fpr_ptr(env, i));
+            qemu_fprintf(f, " %016" PRIx64, *cpu_fpr_ptr(env, i));
             if ((i & (RFPL - 1)) == (RFPL - 1)) {
-                cpu_fprintf(f, "\n");
+                qemu_fprintf(f, "\n");
             }
         }
-        cpu_fprintf(f, "FPSCR " TARGET_FMT_lx "\n", env->fpscr);
+        qemu_fprintf(f, "FPSCR " TARGET_FMT_lx "\n", env->fpscr);
     }
 
 #if !defined(CONFIG_USER_ONLY)
-    cpu_fprintf(f, " SRR0 " TARGET_FMT_lx "  SRR1 " TARGET_FMT_lx
-                   "    PVR " TARGET_FMT_lx " VRSAVE " TARGET_FMT_lx "\n",
-                env->spr[SPR_SRR0], env->spr[SPR_SRR1],
-                env->spr[SPR_PVR], env->spr[SPR_VRSAVE]);
+    qemu_fprintf(f, " SRR0 " TARGET_FMT_lx "  SRR1 " TARGET_FMT_lx
+                 "    PVR " TARGET_FMT_lx " VRSAVE " TARGET_FMT_lx "\n",
+                 env->spr[SPR_SRR0], env->spr[SPR_SRR1],
+                 env->spr[SPR_PVR], env->spr[SPR_VRSAVE]);
 
-    cpu_fprintf(f, "SPRG0 " TARGET_FMT_lx " SPRG1 " TARGET_FMT_lx
-                   "  SPRG2 " TARGET_FMT_lx "  SPRG3 " TARGET_FMT_lx "\n",
-                env->spr[SPR_SPRG0], env->spr[SPR_SPRG1],
-                env->spr[SPR_SPRG2], env->spr[SPR_SPRG3]);
+    qemu_fprintf(f, "SPRG0 " TARGET_FMT_lx " SPRG1 " TARGET_FMT_lx
+                 "  SPRG2 " TARGET_FMT_lx "  SPRG3 " TARGET_FMT_lx "\n",
+                 env->spr[SPR_SPRG0], env->spr[SPR_SPRG1],
+                 env->spr[SPR_SPRG2], env->spr[SPR_SPRG3]);
 
-    cpu_fprintf(f, "SPRG4 " TARGET_FMT_lx " SPRG5 " TARGET_FMT_lx
-                   "  SPRG6 " TARGET_FMT_lx "  SPRG7 " TARGET_FMT_lx "\n",
-                env->spr[SPR_SPRG4], env->spr[SPR_SPRG5],
-                env->spr[SPR_SPRG6], env->spr[SPR_SPRG7]);
+    qemu_fprintf(f, "SPRG4 " TARGET_FMT_lx " SPRG5 " TARGET_FMT_lx
+                 "  SPRG6 " TARGET_FMT_lx "  SPRG7 " TARGET_FMT_lx "\n",
+                 env->spr[SPR_SPRG4], env->spr[SPR_SPRG5],
+                 env->spr[SPR_SPRG6], env->spr[SPR_SPRG7]);
 
 #if defined(TARGET_PPC64)
     if (env->excp_model == POWERPC_EXCP_POWER7 ||
         env->excp_model == POWERPC_EXCP_POWER8 ||
         env->excp_model == POWERPC_EXCP_POWER9)  {
-        cpu_fprintf(f, "HSRR0 " TARGET_FMT_lx " HSRR1 " TARGET_FMT_lx "\n",
-                    env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
+        qemu_fprintf(f, "HSRR0 " TARGET_FMT_lx " HSRR1 " TARGET_FMT_lx "\n",
+                     env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
     }
 #endif
     if (env->excp_model == POWERPC_EXCP_BOOKE) {
-        cpu_fprintf(f, "CSRR0 " TARGET_FMT_lx " CSRR1 " TARGET_FMT_lx
-                       " MCSRR0 " TARGET_FMT_lx " MCSRR1 " TARGET_FMT_lx "\n",
-                    env->spr[SPR_BOOKE_CSRR0], env->spr[SPR_BOOKE_CSRR1],
-                    env->spr[SPR_BOOKE_MCSRR0], env->spr[SPR_BOOKE_MCSRR1]);
+        qemu_fprintf(f, "CSRR0 " TARGET_FMT_lx " CSRR1 " TARGET_FMT_lx
+                     " MCSRR0 " TARGET_FMT_lx " MCSRR1 " TARGET_FMT_lx "\n",
+                     env->spr[SPR_BOOKE_CSRR0], env->spr[SPR_BOOKE_CSRR1],
+                     env->spr[SPR_BOOKE_MCSRR0], env->spr[SPR_BOOKE_MCSRR1]);
 
-        cpu_fprintf(f, "  TCR " TARGET_FMT_lx "   TSR " TARGET_FMT_lx
-                       "    ESR " TARGET_FMT_lx "   DEAR " TARGET_FMT_lx "\n",
-                    env->spr[SPR_BOOKE_TCR], env->spr[SPR_BOOKE_TSR],
-                    env->spr[SPR_BOOKE_ESR], env->spr[SPR_BOOKE_DEAR]);
+        qemu_fprintf(f, "  TCR " TARGET_FMT_lx "   TSR " TARGET_FMT_lx
+                     "    ESR " TARGET_FMT_lx "   DEAR " TARGET_FMT_lx "\n",
+                     env->spr[SPR_BOOKE_TCR], env->spr[SPR_BOOKE_TSR],
+                     env->spr[SPR_BOOKE_ESR], env->spr[SPR_BOOKE_DEAR]);
 
-        cpu_fprintf(f, "  PIR " TARGET_FMT_lx " DECAR " TARGET_FMT_lx
-                       "   IVPR " TARGET_FMT_lx "   EPCR " TARGET_FMT_lx "\n",
-                    env->spr[SPR_BOOKE_PIR], env->spr[SPR_BOOKE_DECAR],
-                    env->spr[SPR_BOOKE_IVPR], env->spr[SPR_BOOKE_EPCR]);
+        qemu_fprintf(f, "  PIR " TARGET_FMT_lx " DECAR " TARGET_FMT_lx
+                     "   IVPR " TARGET_FMT_lx "   EPCR " TARGET_FMT_lx "\n",
+                     env->spr[SPR_BOOKE_PIR], env->spr[SPR_BOOKE_DECAR],
+                     env->spr[SPR_BOOKE_IVPR], env->spr[SPR_BOOKE_EPCR]);
 
-        cpu_fprintf(f, " MCSR " TARGET_FMT_lx " SPRG8 " TARGET_FMT_lx
-                       "    EPR " TARGET_FMT_lx "\n",
-                    env->spr[SPR_BOOKE_MCSR], env->spr[SPR_BOOKE_SPRG8],
-                    env->spr[SPR_BOOKE_EPR]);
+        qemu_fprintf(f, " MCSR " TARGET_FMT_lx " SPRG8 " TARGET_FMT_lx
+                     "    EPR " TARGET_FMT_lx "\n",
+                     env->spr[SPR_BOOKE_MCSR], env->spr[SPR_BOOKE_SPRG8],
+                     env->spr[SPR_BOOKE_EPR]);
 
         /* FSL-specific */
-        cpu_fprintf(f, " MCAR " TARGET_FMT_lx "  PID1 " TARGET_FMT_lx
-                       "   PID2 " TARGET_FMT_lx "    SVR " TARGET_FMT_lx "\n",
-                    env->spr[SPR_Exxx_MCAR], env->spr[SPR_BOOKE_PID1],
-                    env->spr[SPR_BOOKE_PID2], env->spr[SPR_E500_SVR]);
+        qemu_fprintf(f, " MCAR " TARGET_FMT_lx "  PID1 " TARGET_FMT_lx
+                     "   PID2 " TARGET_FMT_lx "    SVR " TARGET_FMT_lx "\n",
+                     env->spr[SPR_Exxx_MCAR], env->spr[SPR_BOOKE_PID1],
+                     env->spr[SPR_BOOKE_PID2], env->spr[SPR_E500_SVR]);
 
         /*
          * IVORs are left out as they are large and do not change often --
@@ -7540,12 +7539,12 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
 
 #if defined(TARGET_PPC64)
     if (env->flags & POWERPC_FLAG_CFAR) {
-        cpu_fprintf(f, " CFAR " TARGET_FMT_lx"\n", env->cfar);
+        qemu_fprintf(f, " CFAR " TARGET_FMT_lx"\n", env->cfar);
     }
 #endif
 
     if (env->spr_cb[SPR_LPCR].name)
-        cpu_fprintf(f, " LPCR " TARGET_FMT_lx "\n", env->spr[SPR_LPCR]);
+        qemu_fprintf(f, " LPCR " TARGET_FMT_lx "\n", env->spr[SPR_LPCR]);
 
     switch (env->mmu_model) {
     case POWERPC_MMU_32B:
@@ -7560,29 +7559,29 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     case POWERPC_MMU_3_00:
 #endif
         if (env->spr_cb[SPR_SDR1].name) { /* SDR1 Exists */
-            cpu_fprintf(f, " SDR1 " TARGET_FMT_lx " ", env->spr[SPR_SDR1]);
+            qemu_fprintf(f, " SDR1 " TARGET_FMT_lx " ", env->spr[SPR_SDR1]);
         }
         if (env->spr_cb[SPR_PTCR].name) { /* PTCR Exists */
-            cpu_fprintf(f, " PTCR " TARGET_FMT_lx " ", env->spr[SPR_PTCR]);
+            qemu_fprintf(f, " PTCR " TARGET_FMT_lx " ", env->spr[SPR_PTCR]);
         }
-        cpu_fprintf(f, "  DAR " TARGET_FMT_lx "  DSISR " TARGET_FMT_lx "\n",
-                    env->spr[SPR_DAR], env->spr[SPR_DSISR]);
+        qemu_fprintf(f, "  DAR " TARGET_FMT_lx "  DSISR " TARGET_FMT_lx "\n",
+                     env->spr[SPR_DAR], env->spr[SPR_DSISR]);
         break;
     case POWERPC_MMU_BOOKE206:
-        cpu_fprintf(f, " MAS0 " TARGET_FMT_lx "  MAS1 " TARGET_FMT_lx
-                       "   MAS2 " TARGET_FMT_lx "   MAS3 " TARGET_FMT_lx "\n",
-                    env->spr[SPR_BOOKE_MAS0], env->spr[SPR_BOOKE_MAS1],
-                    env->spr[SPR_BOOKE_MAS2], env->spr[SPR_BOOKE_MAS3]);
+        qemu_fprintf(f, " MAS0 " TARGET_FMT_lx "  MAS1 " TARGET_FMT_lx
+                     "   MAS2 " TARGET_FMT_lx "   MAS3 " TARGET_FMT_lx "\n",
+                     env->spr[SPR_BOOKE_MAS0], env->spr[SPR_BOOKE_MAS1],
+                     env->spr[SPR_BOOKE_MAS2], env->spr[SPR_BOOKE_MAS3]);
 
-        cpu_fprintf(f, " MAS4 " TARGET_FMT_lx "  MAS6 " TARGET_FMT_lx
-                       "   MAS7 " TARGET_FMT_lx "    PID " TARGET_FMT_lx "\n",
-                    env->spr[SPR_BOOKE_MAS4], env->spr[SPR_BOOKE_MAS6],
-                    env->spr[SPR_BOOKE_MAS7], env->spr[SPR_BOOKE_PID]);
+        qemu_fprintf(f, " MAS4 " TARGET_FMT_lx "  MAS6 " TARGET_FMT_lx
+                     "   MAS7 " TARGET_FMT_lx "    PID " TARGET_FMT_lx "\n",
+                     env->spr[SPR_BOOKE_MAS4], env->spr[SPR_BOOKE_MAS6],
+                     env->spr[SPR_BOOKE_MAS7], env->spr[SPR_BOOKE_PID]);
 
-        cpu_fprintf(f, "MMUCFG " TARGET_FMT_lx " TLB0CFG " TARGET_FMT_lx
-                       " TLB1CFG " TARGET_FMT_lx "\n",
-                    env->spr[SPR_MMUCFG], env->spr[SPR_BOOKE_TLB0CFG],
-                    env->spr[SPR_BOOKE_TLB1CFG]);
+        qemu_fprintf(f, "MMUCFG " TARGET_FMT_lx " TLB0CFG " TARGET_FMT_lx
+                     " TLB1CFG " TARGET_FMT_lx "\n",
+                     env->spr[SPR_MMUCFG], env->spr[SPR_BOOKE_TLB0CFG],
+                     env->spr[SPR_BOOKE_TLB1CFG]);
         break;
     default:
         break;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 104e676ab0..1bcf4eaeb8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -194,40 +194,39 @@ static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
-static void riscv_cpu_dump_state(CPUState *cs, FILE *f,
-    fprintf_function cpu_fprintf, int flags)
+static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     int i;
 
-    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
 #ifndef CONFIG_USER_ONLY
-    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
-    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
-    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ",
-        (target_ulong)atomic_read(&env->mip));
-    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
-    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
-    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
-    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mtvec   ", env->mtvec);
-    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mepc    ", env->mepc);
-    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mcause  ", env->mcause);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ",
+                 (target_ulong)atomic_read(&env->mip));
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mtvec   ", env->mtvec);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mepc    ", env->mepc);
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mcause  ", env->mcause);
 #endif
 
     for (i = 0; i < 32; i++) {
-        cpu_fprintf(f, " %s " TARGET_FMT_lx,
-            riscv_int_regnames[i], env->gpr[i]);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx,
+                     riscv_int_regnames[i], env->gpr[i]);
         if ((i & 3) == 3) {
-            cpu_fprintf(f, "\n");
+            qemu_fprintf(f, "\n");
         }
     }
     if (flags & CPU_DUMP_FPU) {
         for (i = 0; i < 32; i++) {
-            cpu_fprintf(f, " %s %016" PRIx64,
-                riscv_fpr_regnames[i], env->fpr[i]);
+            qemu_fprintf(f, " %s %016" PRIx64,
+                         riscv_fpr_regnames[i], env->fpr[i]);
             if ((i & 3) == 3) {
-                cpu_fprintf(f, "\n");
+                qemu_fprintf(f, "\n");
             }
         }
     }
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 8e9573221c..f957a2c830 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -23,6 +23,7 @@
 #include "internal.h"
 #include "exec/gdbstub.h"
 #include "qemu/timer.h"
+#include "qemu/qemu-print.h"
 #include "hw/s390x/ioinst.h"
 #include "sysemu/hw_accel.h"
 #ifndef CONFIG_USER_ONLY
@@ -313,65 +314,64 @@ int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
 }
 #endif /* CONFIG_USER_ONLY */
 
-void s390_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                         int flags)
+void s390_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
     int i;
 
     if (env->cc_op > 3) {
-        cpu_fprintf(f, "PSW=mask %016" PRIx64 " addr %016" PRIx64 " cc %15s\n",
-                    env->psw.mask, env->psw.addr, cc_name(env->cc_op));
+        qemu_fprintf(f, "PSW=mask %016" PRIx64 " addr %016" PRIx64 " cc %15s\n",
+                     env->psw.mask, env->psw.addr, cc_name(env->cc_op));
     } else {
-        cpu_fprintf(f, "PSW=mask %016" PRIx64 " addr %016" PRIx64 " cc %02x\n",
-                    env->psw.mask, env->psw.addr, env->cc_op);
+        qemu_fprintf(f, "PSW=mask %016" PRIx64 " addr %016" PRIx64 " cc %02x\n",
+                     env->psw.mask, env->psw.addr, env->cc_op);
     }
 
     for (i = 0; i < 16; i++) {
-        cpu_fprintf(f, "R%02d=%016" PRIx64, i, env->regs[i]);
+        qemu_fprintf(f, "R%02d=%016" PRIx64, i, env->regs[i]);
         if ((i % 4) == 3) {
-            cpu_fprintf(f, "\n");
+            qemu_fprintf(f, "\n");
         } else {
-            cpu_fprintf(f, " ");
+            qemu_fprintf(f, " ");
         }
     }
 
     if (flags & CPU_DUMP_FPU) {
         if (s390_has_feat(S390_FEAT_VECTOR)) {
             for (i = 0; i < 32; i++) {
-                cpu_fprintf(f, "V%02d=%016" PRIx64 "%016" PRIx64 "%c",
-                            i, env->vregs[i][0].ll, env->vregs[i][1].ll,
-                            i % 2 ? '\n' : ' ');
+                qemu_fprintf(f, "V%02d=%016" PRIx64 "%016" PRIx64 "%c",
+                             i, env->vregs[i][0].ll, env->vregs[i][1].ll,
+                             i % 2 ? '\n' : ' ');
             }
         } else {
             for (i = 0; i < 16; i++) {
-                cpu_fprintf(f, "F%02d=%016" PRIx64 "%c",
-                            i, get_freg(env, i)->ll,
-                            (i % 4) == 3 ? '\n' : ' ');
+                qemu_fprintf(f, "F%02d=%016" PRIx64 "%c",
+                             i, get_freg(env, i)->ll,
+                             (i % 4) == 3 ? '\n' : ' ');
             }
         }
     }
 
 #ifndef CONFIG_USER_ONLY
     for (i = 0; i < 16; i++) {
-        cpu_fprintf(f, "C%02d=%016" PRIx64, i, env->cregs[i]);
+        qemu_fprintf(f, "C%02d=%016" PRIx64, i, env->cregs[i]);
         if ((i % 4) == 3) {
-            cpu_fprintf(f, "\n");
+            qemu_fprintf(f, "\n");
         } else {
-            cpu_fprintf(f, " ");
+            qemu_fprintf(f, " ");
         }
     }
 #endif
 
 #ifdef DEBUG_INLINE_BRANCHES
     for (i = 0; i < CC_OP_MAX; i++) {
-        cpu_fprintf(f, "  %15s = %10ld\t%10ld\n", cc_name(i),
-                    inline_branch_miss[i], inline_branch_hit[i]);
+        qemu_fprintf(f, "  %15s = %10ld\t%10ld\n", cc_name(i),
+                     inline_branch_miss[i], inline_branch_hit[i]);
     }
 #endif
 
-    cpu_fprintf(f, "\n");
+    qemu_fprintf(f, "\n");
 }
 
 const char *cc_name(enum cc_op cc_op)
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 3b4855c175..26575f2130 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -292,8 +292,7 @@ void s390_cpu_gdb_init(CPUState *cs);
 
 
 /* helper.c */
-void s390_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
-                         int flags);
+void s390_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 uint64_t get_psw_mask(CPUS390XState *env);
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 3e43f0a1a5..84b08ff640 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -232,8 +232,7 @@ static inline SuperHCPU *sh_env_get_cpu(CPUSH4State *env)
 
 void superh_cpu_do_interrupt(CPUState *cpu);
 bool superh_cpu_exec_interrupt(CPUState *cpu, int int_req);
-void superh_cpu_dump_state(CPUState *cpu, FILE *f,
-                           fprintf_function cpu_fprintf, int flags);
+void superh_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int superh_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int superh_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index ab254b0e8d..cffc6919d0 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -30,6 +30,7 @@
 #include "exec/translator.h"
 #include "trace-tcg.h"
 #include "exec/log.h"
+#include "qemu/qemu-print.h"
 
 
 typedef struct DisasContext {
@@ -156,32 +157,32 @@ void sh4_translate_init(void)
                                               fregnames[i]);
 }
 
-void superh_cpu_dump_state(CPUState *cs, FILE *f,
-                           fprintf_function cpu_fprintf, int flags)
+void superh_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
     CPUSH4State *env = &cpu->env;
     int i;
-    cpu_fprintf(f, "pc=0x%08x sr=0x%08x pr=0x%08x fpscr=0x%08x\n",
-                env->pc, cpu_read_sr(env), env->pr, env->fpscr);
-    cpu_fprintf(f, "spc=0x%08x ssr=0x%08x gbr=0x%08x vbr=0x%08x\n",
-		env->spc, env->ssr, env->gbr, env->vbr);
-    cpu_fprintf(f, "sgr=0x%08x dbr=0x%08x delayed_pc=0x%08x fpul=0x%08x\n",
-		env->sgr, env->dbr, env->delayed_pc, env->fpul);
+
+    qemu_fprintf(f, "pc=0x%08x sr=0x%08x pr=0x%08x fpscr=0x%08x\n",
+                 env->pc, cpu_read_sr(env), env->pr, env->fpscr);
+    qemu_fprintf(f, "spc=0x%08x ssr=0x%08x gbr=0x%08x vbr=0x%08x\n",
+                 env->spc, env->ssr, env->gbr, env->vbr);
+    qemu_fprintf(f, "sgr=0x%08x dbr=0x%08x delayed_pc=0x%08x fpul=0x%08x\n",
+                 env->sgr, env->dbr, env->delayed_pc, env->fpul);
     for (i = 0; i < 24; i += 4) {
-	cpu_fprintf(f, "r%d=0x%08x r%d=0x%08x r%d=0x%08x r%d=0x%08x\n",
+        qemu_printf("r%d=0x%08x r%d=0x%08x r%d=0x%08x r%d=0x%08x\n",
 		    i, env->gregs[i], i + 1, env->gregs[i + 1],
 		    i + 2, env->gregs[i + 2], i + 3, env->gregs[i + 3]);
     }
     if (env->flags & DELAY_SLOT) {
-	cpu_fprintf(f, "in delay slot (delayed_pc=0x%08x)\n",
+        qemu_printf("in delay slot (delayed_pc=0x%08x)\n",
 		    env->delayed_pc);
     } else if (env->flags & DELAY_SLOT_CONDITIONAL) {
-	cpu_fprintf(f, "in conditional delay slot (delayed_pc=0x%08x)\n",
+        qemu_printf("in conditional delay slot (delayed_pc=0x%08x)\n",
 		    env->delayed_pc);
     } else if (env->flags & DELAY_SLOT_RTE) {
-        cpu_fprintf(f, "in rte delay slot (delayed_pc=0x%08x)\n",
-                    env->delayed_pc);
+        qemu_fprintf(f, "in rte delay slot (delayed_pc=0x%08x)\n",
+                     env->delayed_pc);
     }
 }
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index fd88a31806..4654c2a6a0 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -596,12 +596,11 @@ void sparc_cpu_list(void)
                 "fpu_version mmu_version nwindows\n");
 }
 
-static void cpu_print_cc(FILE *f, fprintf_function cpu_fprintf,
-                         uint32_t cc)
+static void cpu_print_cc(FILE *f, uint32_t cc)
 {
-    cpu_fprintf(f, "%c%c%c%c", cc & PSR_NEG ? 'N' : '-',
-                cc & PSR_ZERO ? 'Z' : '-', cc & PSR_OVF ? 'V' : '-',
-                cc & PSR_CARRY ? 'C' : '-');
+    qemu_fprintf(f, "%c%c%c%c", cc & PSR_NEG ? 'N' : '-',
+                 cc & PSR_ZERO ? 'Z' : '-', cc & PSR_OVF ? 'V' : '-',
+                 cc & PSR_CARRY ? 'C' : '-');
 }
 
 #ifdef TARGET_SPARC64
@@ -610,35 +609,34 @@ static void cpu_print_cc(FILE *f, fprintf_function cpu_fprintf,
 #define REGS_PER_LINE 8
 #endif
 
-void sparc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
-                          int flags)
+void sparc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
     int i, x;
 
-    cpu_fprintf(f, "pc: " TARGET_FMT_lx "  npc: " TARGET_FMT_lx "\n", env->pc,
-                env->npc);
+    qemu_fprintf(f, "pc: " TARGET_FMT_lx "  npc: " TARGET_FMT_lx "\n", env->pc,
+                 env->npc);
 
     for (i = 0; i < 8; i++) {
         if (i % REGS_PER_LINE == 0) {
-            cpu_fprintf(f, "%%g%d-%d:", i, i + REGS_PER_LINE - 1);
+            qemu_fprintf(f, "%%g%d-%d:", i, i + REGS_PER_LINE - 1);
         }
-        cpu_fprintf(f, " " TARGET_FMT_lx, env->gregs[i]);
+        qemu_fprintf(f, " " TARGET_FMT_lx, env->gregs[i]);
         if (i % REGS_PER_LINE == REGS_PER_LINE - 1) {
-            cpu_fprintf(f, "\n");
+            qemu_fprintf(f, "\n");
         }
     }
     for (x = 0; x < 3; x++) {
         for (i = 0; i < 8; i++) {
             if (i % REGS_PER_LINE == 0) {
-                cpu_fprintf(f, "%%%c%d-%d: ",
-                            x == 0 ? 'o' : (x == 1 ? 'l' : 'i'),
-                            i, i + REGS_PER_LINE - 1);
+                qemu_fprintf(f, "%%%c%d-%d: ",
+                             x == 0 ? 'o' : (x == 1 ? 'l' : 'i'),
+                             i, i + REGS_PER_LINE - 1);
             }
-            cpu_fprintf(f, TARGET_FMT_lx " ", env->regwptr[i + x * 8]);
+            qemu_fprintf(f, TARGET_FMT_lx " ", env->regwptr[i + x * 8]);
             if (i % REGS_PER_LINE == REGS_PER_LINE - 1) {
-                cpu_fprintf(f, "\n");
+                qemu_fprintf(f, "\n");
             }
         }
     }
@@ -646,42 +644,42 @@ void sparc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     if (flags & CPU_DUMP_FPU) {
         for (i = 0; i < TARGET_DPREGS; i++) {
             if ((i & 3) == 0) {
-                cpu_fprintf(f, "%%f%02d: ", i * 2);
+                qemu_fprintf(f, "%%f%02d: ", i * 2);
             }
-            cpu_fprintf(f, " %016" PRIx64, env->fpr[i].ll);
+            qemu_fprintf(f, " %016" PRIx64, env->fpr[i].ll);
             if ((i & 3) == 3) {
-                cpu_fprintf(f, "\n");
+                qemu_fprintf(f, "\n");
             }
         }
     }
 
 #ifdef TARGET_SPARC64
-    cpu_fprintf(f, "pstate: %08x ccr: %02x (icc: ", env->pstate,
-                (unsigned)cpu_get_ccr(env));
-    cpu_print_cc(f, cpu_fprintf, cpu_get_ccr(env) << PSR_CARRY_SHIFT);
-    cpu_fprintf(f, " xcc: ");
-    cpu_print_cc(f, cpu_fprintf, cpu_get_ccr(env) << (PSR_CARRY_SHIFT - 4));
-    cpu_fprintf(f, ") asi: %02x tl: %d pil: %x gl: %d\n", env->asi, env->tl,
-                env->psrpil, env->gl);
-    cpu_fprintf(f, "tbr: " TARGET_FMT_lx " hpstate: " TARGET_FMT_lx " htba: "
-                TARGET_FMT_lx "\n", env->tbr, env->hpstate, env->htba);
-    cpu_fprintf(f, "cansave: %d canrestore: %d otherwin: %d wstate: %d "
-                "cleanwin: %d cwp: %d\n",
-                env->cansave, env->canrestore, env->otherwin, env->wstate,
-                env->cleanwin, env->nwindows - 1 - env->cwp);
-    cpu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx " fprs: "
-                TARGET_FMT_lx "\n", env->fsr, env->y, env->fprs);
+    qemu_fprintf(f, "pstate: %08x ccr: %02x (icc: ", env->pstate,
+                 (unsigned)cpu_get_ccr(env));
+    cpu_print_cc(f, cpu_get_ccr(env) << PSR_CARRY_SHIFT);
+    qemu_fprintf(f, " xcc: ");
+    cpu_print_cc(f, cpu_get_ccr(env) << (PSR_CARRY_SHIFT - 4));
+    qemu_fprintf(f, ") asi: %02x tl: %d pil: %x gl: %d\n", env->asi, env->tl,
+                 env->psrpil, env->gl);
+    qemu_fprintf(f, "tbr: " TARGET_FMT_lx " hpstate: " TARGET_FMT_lx " htba: "
+                 TARGET_FMT_lx "\n", env->tbr, env->hpstate, env->htba);
+    qemu_fprintf(f, "cansave: %d canrestore: %d otherwin: %d wstate: %d "
+                 "cleanwin: %d cwp: %d\n",
+                 env->cansave, env->canrestore, env->otherwin, env->wstate,
+                 env->cleanwin, env->nwindows - 1 - env->cwp);
+    qemu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx " fprs: "
+                 TARGET_FMT_lx "\n", env->fsr, env->y, env->fprs);
 
 #else
-    cpu_fprintf(f, "psr: %08x (icc: ", cpu_get_psr(env));
-    cpu_print_cc(f, cpu_fprintf, cpu_get_psr(env));
-    cpu_fprintf(f, " SPE: %c%c%c) wim: %08x\n", env->psrs ? 'S' : '-',
-                env->psrps ? 'P' : '-', env->psret ? 'E' : '-',
-                env->wim);
-    cpu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx "\n",
-                env->fsr, env->y);
+    qemu_fprintf(f, "psr: %08x (icc: ", cpu_get_psr(env));
+    cpu_print_cc(f, cpu_get_psr(env));
+    qemu_fprintf(f, " SPE: %c%c%c) wim: %08x\n", env->psrs ? 'S' : '-',
+                 env->psrps ? 'P' : '-', env->psret ? 'E' : '-',
+                 env->wim);
+    qemu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx "\n",
+                 env->fsr, env->y);
 #endif
-    cpu_fprintf(f, "\n");
+    qemu_fprintf(f, "\n");
 }
 
 static void sparc_cpu_set_pc(CPUState *cs, vaddr value)
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index b298bd9c29..85b9665ccc 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -564,8 +564,7 @@ extern const struct VMStateDescription vmstate_sparc_cpu;
 #endif
 
 void sparc_cpu_do_interrupt(CPUState *cpu);
-void sparc_cpu_dump_state(CPUState *cpu, FILE *f,
-                          fprintf_function cpu_fprintf, int flags);
+void sparc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr sparc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int sparc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int sparc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index bfe9be59b5..b9d37105fa 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -24,9 +24,9 @@
 #include "qemu-common.h"
 #include "hw/qdev-properties.h"
 #include "linux-user/syscall_defs.h"
+#include "qemu/qemu-print.h"
 
-static void tilegx_cpu_dump_state(CPUState *cs, FILE *f,
-                                  fprintf_function cpu_fprintf, int flags)
+static void tilegx_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     static const char * const reg_names[TILEGX_R_COUNT] = {
          "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
@@ -43,12 +43,12 @@ static void tilegx_cpu_dump_state(CPUState *cs, FILE *f,
     int i;
 
     for (i = 0; i < TILEGX_R_COUNT; i++) {
-        cpu_fprintf(f, "%-4s" TARGET_FMT_lx "%s",
-                    reg_names[i], env->regs[i],
-                    (i % 4) == 3 ? "\n" : " ");
+        qemu_fprintf(f, "%-4s" TARGET_FMT_lx "%s",
+                     reg_names[i], env->regs[i],
+                     (i % 4) == 3 ? "\n" : " ");
     }
-    cpu_fprintf(f, "PC  " TARGET_FMT_lx " CEX " TARGET_FMT_lx "\n\n",
-                env->pc, env->spregs[TILEGX_SPR_CMPEXCH]);
+    qemu_fprintf(f, "PC  " TARGET_FMT_lx " CEX " TARGET_FMT_lx "\n\n",
+                 env->pc, env->spregs[TILEGX_SPR_CMPEXCH]);
 }
 
 static ObjectClass *tilegx_cpu_class_by_name(const char *cpu_model)
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 43d577ce8e..64d1a9c75e 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -224,8 +224,7 @@ static inline TriCoreCPU *tricore_env_get_cpu(CPUTriCoreState *env)
 #define ENV_OFFSET offsetof(TriCoreCPU, env)
 
 hwaddr tricore_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-void tricore_cpu_dump_state(CPUState *cpu, FILE *f,
-                            fprintf_function cpu_fprintf, int flags);
+void tricore_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
 
 #define MASK_PCXI_PCPN 0xff000000
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index b12c391be5..352f52bb4a 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "tcg-op.h"
 #include "exec/cpu_ldst.h"
+#include "qemu/qemu-print.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -88,8 +89,7 @@ enum {
     MODE_UU = 3,
 };
 
-void tricore_cpu_dump_state(CPUState *cs, FILE *f,
-                            fprintf_function cpu_fprintf, int flags)
+void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     TriCoreCPU *cpu = TRICORE_CPU(cs);
     CPUTriCoreState *env = &cpu->env;
@@ -98,26 +98,26 @@ void tricore_cpu_dump_state(CPUState *cs, FILE *f,
 
     psw = psw_read(env);
 
-    cpu_fprintf(f, "PC: " TARGET_FMT_lx, env->PC);
-    cpu_fprintf(f, " PSW: " TARGET_FMT_lx, psw);
-    cpu_fprintf(f, " ICR: " TARGET_FMT_lx, env->ICR);
-    cpu_fprintf(f, "\nPCXI: " TARGET_FMT_lx, env->PCXI);
-    cpu_fprintf(f, " FCX: " TARGET_FMT_lx, env->FCX);
-    cpu_fprintf(f, " LCX: " TARGET_FMT_lx, env->LCX);
+    qemu_fprintf(f, "PC: " TARGET_FMT_lx, env->PC);
+    qemu_fprintf(f, " PSW: " TARGET_FMT_lx, psw);
+    qemu_fprintf(f, " ICR: " TARGET_FMT_lx, env->ICR);
+    qemu_fprintf(f, "\nPCXI: " TARGET_FMT_lx, env->PCXI);
+    qemu_fprintf(f, " FCX: " TARGET_FMT_lx, env->FCX);
+    qemu_fprintf(f, " LCX: " TARGET_FMT_lx, env->LCX);
 
     for (i = 0; i < 16; ++i) {
         if ((i & 3) == 0) {
-            cpu_fprintf(f, "\nGPR A%02d:", i);
+            qemu_fprintf(f, "\nGPR A%02d:", i);
         }
-        cpu_fprintf(f, " " TARGET_FMT_lx, env->gpr_a[i]);
+        qemu_fprintf(f, " " TARGET_FMT_lx, env->gpr_a[i]);
     }
     for (i = 0; i < 16; ++i) {
         if ((i & 3) == 0) {
-            cpu_fprintf(f, "\nGPR D%02d:", i);
+            qemu_fprintf(f, "\nGPR D%02d:", i);
         }
-        cpu_fprintf(f, " " TARGET_FMT_lx, env->gpr_d[i]);
+        qemu_fprintf(f, " " TARGET_FMT_lx, env->gpr_d[i]);
     }
-    cpu_fprintf(f, "\n");
+    qemu_fprintf(f, "\n");
 }
 
 /*
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 735d3ae9dc..24abe5e5c0 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -97,8 +97,7 @@ static inline UniCore32CPU *uc32_env_get_cpu(CPUUniCore32State *env)
 
 void uc32_cpu_do_interrupt(CPUState *cpu);
 bool uc32_cpu_exec_interrupt(CPUState *cpu, int int_req);
-void uc32_cpu_dump_state(CPUState *cpu, FILE *f,
-                         fprintf_function cpu_fprintf, int flags);
+void uc32_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr uc32_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
 #define ASR_M                   (0x1f)
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 002569ff3b..dfe41c9069 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -17,6 +17,7 @@
 #include "qemu/log.h"
 #include "exec/cpu_ldst.h"
 #include "exec/translator.h"
+#include "qemu/qemu-print.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
@@ -2043,8 +2044,7 @@ static const char *cpu_mode_names[16] = {
 
 #undef UCF64_DUMP_STATE
 #ifdef UCF64_DUMP_STATE
-static void cpu_dump_state_ucf64(CPUUniCore32State *env, FILE *f,
-        fprintf_function cpu_fprintf, int flags)
+static void cpu_dump_state_ucf64(CPUUniCore32State *env, int flags)
 {
     int i;
     union {
@@ -2064,20 +2064,19 @@ static void cpu_dump_state_ucf64(CPUUniCore32State *env, FILE *f,
         s0.i = d.l.lower;
         s1.i = d.l.upper;
         d0.f64 = d.d;
-        cpu_fprintf(f, "s%02d=%08x(%8g) s%02d=%08x(%8g)",
-                    i * 2, (int)s0.i, s0.s,
-                    i * 2 + 1, (int)s1.i, s1.s);
-        cpu_fprintf(f, " d%02d=%" PRIx64 "(%8g)\n",
-                    i, (uint64_t)d0.f64, d0.d);
+        qemu_fprintf(f, "s%02d=%08x(%8g) s%02d=%08x(%8g)",
+                     i * 2, (int)s0.i, s0.s,
+                     i * 2 + 1, (int)s1.i, s1.s);
+        qemu_fprintf(f, " d%02d=%" PRIx64 "(%8g)\n",
+                     i, (uint64_t)d0.f64, d0.d);
     }
-    cpu_fprintf(f, "FPSCR: %08x\n", (int)env->ucf64.xregs[UC32_UCF64_FPSCR]);
+    qemu_fprintf(f, "FPSCR: %08x\n", (int)env->ucf64.xregs[UC32_UCF64_FPSCR]);
 }
 #else
 #define cpu_dump_state_ucf64(env, file, pr, flags)      do { } while (0)
 #endif
 
-void uc32_cpu_dump_state(CPUState *cs, FILE *f,
-                         fprintf_function cpu_fprintf, int flags)
+void uc32_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     UniCore32CPU *cpu = UNICORE32_CPU(cs);
     CPUUniCore32State *env = &cpu->env;
@@ -2085,21 +2084,21 @@ void uc32_cpu_dump_state(CPUState *cs, FILE *f,
     uint32_t psr;
 
     for (i = 0; i < 32; i++) {
-        cpu_fprintf(f, "R%02d=%08x", i, env->regs[i]);
+        qemu_fprintf(f, "R%02d=%08x", i, env->regs[i]);
         if ((i % 4) == 3) {
-            cpu_fprintf(f, "\n");
+            qemu_fprintf(f, "\n");
         } else {
-            cpu_fprintf(f, " ");
+            qemu_fprintf(f, " ");
         }
     }
     psr = cpu_asr_read(env);
-    cpu_fprintf(f, "PSR=%08x %c%c%c%c %s\n",
-                psr,
-                psr & (1 << 31) ? 'N' : '-',
-                psr & (1 << 30) ? 'Z' : '-',
-                psr & (1 << 29) ? 'C' : '-',
-                psr & (1 << 28) ? 'V' : '-',
-                cpu_mode_names[psr & 0xf]);
+    qemu_fprintf(f, "PSR=%08x %c%c%c%c %s\n",
+                 psr,
+                 psr & (1 << 31) ? 'N' : '-',
+                 psr & (1 << 30) ? 'Z' : '-',
+                 psr & (1 << 29) ? 'C' : '-',
+                 psr & (1 << 28) ? 'V' : '-',
+                 cpu_mode_names[psr & 0xf]);
 
     if (flags & CPU_DUMP_FPU) {
         cpu_dump_state_ucf64(env, f, cpu_fprintf, flags);
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 86f6d6d72c..5d23e1345b 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -560,8 +560,7 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       unsigned size, MMUAccessType access_type,
                                       int mmu_idx, MemTxAttrs attrs,
                                       MemTxResult response, uintptr_t retaddr);
-void xtensa_cpu_dump_state(CPUState *cpu, FILE *f,
-                           fprintf_function cpu_fprintf, int flags);
+void xtensa_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void xtensa_count_regs(const XtensaConfig *config,
                        unsigned *n_regs, unsigned *n_core_regs);
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 65561d2c49..43a5e94daa 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -35,6 +35,7 @@
 #include "disas/disas.h"
 #include "tcg-op.h"
 #include "qemu/log.h"
+#include "qemu/qemu-print.h"
 #include "sysemu/sysemu.h"
 #include "exec/cpu_ldst.h"
 #include "exec/semihost.h"
@@ -1640,60 +1641,61 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
     translator_loop(&xtensa_translator_ops, &dc.base, cpu, tb);
 }
 
-void xtensa_cpu_dump_state(CPUState *cs, FILE *f,
-                           fprintf_function cpu_fprintf, int flags)
+void xtensa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
     CPUXtensaState *env = &cpu->env;
     int i, j;
 
-    cpu_fprintf(f, "PC=%08x\n\n", env->pc);
+    qemu_fprintf(f, "PC=%08x\n\n", env->pc);
 
     for (i = j = 0; i < 256; ++i) {
         if (xtensa_option_bits_enabled(env->config, sregnames[i].opt_bits)) {
-            cpu_fprintf(f, "%12s=%08x%c", sregnames[i].name, env->sregs[i],
-                    (j++ % 4) == 3 ? '\n' : ' ');
+            qemu_fprintf(f, "%12s=%08x%c",
+                         sregnames[i].name, env->sregs[i],
+                         (j++ % 4) == 3 ? '\n' : ' ');
         }
     }
 
-    cpu_fprintf(f, (j % 4) == 0 ? "\n" : "\n\n");
+    qemu_fprintf(f, (j % 4) == 0 ? "\n" : "\n\n");
 
     for (i = j = 0; i < 256; ++i) {
         if (xtensa_option_bits_enabled(env->config, uregnames[i].opt_bits)) {
-            cpu_fprintf(f, "%s=%08x%c", uregnames[i].name, env->uregs[i],
-                    (j++ % 4) == 3 ? '\n' : ' ');
+            qemu_fprintf(f, "%s=%08x%c",
+                         uregnames[i].name, env->uregs[i],
+                         (j++ % 4) == 3 ? '\n' : ' ');
         }
     }
 
-    cpu_fprintf(f, (j % 4) == 0 ? "\n" : "\n\n");
+    qemu_fprintf(f, (j % 4) == 0 ? "\n" : "\n\n");
 
     for (i = 0; i < 16; ++i) {
-        cpu_fprintf(f, " A%02d=%08x%c", i, env->regs[i],
-                (i % 4) == 3 ? '\n' : ' ');
+        qemu_fprintf(f, " A%02d=%08x%c",
+                     i, env->regs[i], (i % 4) == 3 ? '\n' : ' ');
     }
 
     xtensa_sync_phys_from_window(env);
-    cpu_fprintf(f, "\n");
+    qemu_fprintf(f, "\n");
 
     for (i = 0; i < env->config->nareg; ++i) {
-        cpu_fprintf(f, "AR%02d=%08x ", i, env->phys_regs[i]);
+        qemu_fprintf(f, "AR%02d=%08x ", i, env->phys_regs[i]);
         if (i % 4 == 3) {
             bool ws = (env->sregs[WINDOW_START] & (1 << (i / 4))) != 0;
             bool cw = env->sregs[WINDOW_BASE] == i / 4;
 
-            cpu_fprintf(f, "%c%c\n", ws ? '<' : ' ', cw ? '=' : ' ');
+            qemu_fprintf(f, "%c%c\n", ws ? '<' : ' ', cw ? '=' : ' ');
         }
     }
 
     if ((flags & CPU_DUMP_FPU) &&
         xtensa_option_enabled(env->config, XTENSA_OPTION_FP_COPROCESSOR)) {
-        cpu_fprintf(f, "\n");
+        qemu_fprintf(f, "\n");
 
         for (i = 0; i < 16; ++i) {
-            cpu_fprintf(f, "F%02d=%08x (%+10.8e)%c", i,
-                    float32_val(env->fregs[i].f32[FP_F32_LOW]),
-                    *(float *)(env->fregs[i].f32 + FP_F32_LOW),
-                    (i % 2) == 1 ? '\n' : ' ');
+            qemu_fprintf(f, "F%02d=%08x (%+10.8e)%c", i,
+                         float32_val(env->fregs[i].f32[FP_F32_LOW]),
+                         *(float *)(env->fregs[i].f32 + FP_F32_LOW),
+                         (i % 2) == 1 ? '\n' : ' ');
         }
     }
 }
-- 
2.17.2
