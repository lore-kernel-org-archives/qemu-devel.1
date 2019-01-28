Received: from eggs.gnu.org ([209.51.188.92]:40281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7hh-0007UI-Ei
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7hd-0007Hr-QM
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:16:00 -0500
Received: from m15-113.126.com ([220.181.15.113]:49511)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1go7hc-00075I-0I
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:15:57 -0500
From: Fei Li <lifei1214@126.com>
Date: Mon, 28 Jan 2019 22:14:45 +0800
Message-Id: <20190128141506.12731-3-lifei1214@126.com>
In-Reply-To: <20190128141506.12731-1-lifei1214@126.com>
References: <20190128141506.12731-1-lifei1214@126.com>
Subject: [Qemu-devel] [PATCH for-4.0 02/11] qemu_thread: supplement error
 handling for qemu_X_start_vcpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: Markus Armbruster <armbru@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Fei Li <fli@suse.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Fei Li <fli@suse.com>

The callers of qemu_init_vcpu() already passed the **errp to handle
errors. In view of this, add a new Error parameter to qemu_init_vcpu()
and all qemu_X_start_vcpu() functions called by qemu_init_vcpu() to
propagate the error and let the further callers check it.

Besides, make qemu_init_vcpu() return a Boolean value to let its
callers know whether it succeeds.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 accel/tcg/user-exec-stub.c      |  3 +-
 cpus.c                          | 74 +++++++++++++++++++--------------
 include/qom/cpu.h               |  2 +-
 target/alpha/cpu.c              |  4 +-
 target/arm/cpu.c                |  4 +-
 target/cris/cpu.c               |  4 +-
 target/hppa/cpu.c               |  4 +-
 target/i386/cpu.c               |  4 +-
 target/lm32/cpu.c               |  4 +-
 target/m68k/cpu.c               |  4 +-
 target/microblaze/cpu.c         |  4 +-
 target/mips/cpu.c               |  4 +-
 target/moxie/cpu.c              |  4 +-
 target/nios2/cpu.c              |  4 +-
 target/openrisc/cpu.c           |  4 +-
 target/ppc/translate_init.inc.c |  4 +-
 target/riscv/cpu.c              |  4 +-
 target/s390x/cpu.c              |  4 +-
 target/sh4/cpu.c                |  4 +-
 target/sparc/cpu.c              |  4 +-
 target/tilegx/cpu.c             |  4 +-
 target/tricore/cpu.c            |  4 +-
 target/unicore32/cpu.c          |  4 +-
 target/xtensa/cpu.c             |  4 +-
 24 files changed, 108 insertions(+), 55 deletions(-)

diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index a32b4496af..f8c38a375c 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -10,8 +10,9 @@ void cpu_resume(CPUState *cpu)
 {
 }
 
-void qemu_init_vcpu(CPUState *cpu)
+bool qemu_init_vcpu(CPUState *cpu, Error **errp)
 {
+    return true;
 }
 
 /* User mode emulation does not support record/replay yet.  */
diff --git a/cpus.c b/cpus.c
index 843a0f06a2..4ed7d62e58 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1931,7 +1931,7 @@ void cpu_remove_sync(CPUState *cpu)
 /* For temporary buffers for forming a name */
 #define VCPU_THREAD_NAME_SIZE 16
 
-static void qemu_tcg_init_vcpu(CPUState *cpu)
+static void qemu_tcg_init_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
     static QemuCond *single_tcg_halt_cond;
@@ -1961,17 +1961,20 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
                  cpu->cpu_index);
 
-            /* TODO: let the callers handle the error instead of abort() here */
-            qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE, &error_abort);
+            if (qemu_thread_create(cpu->thread, thread_name,
+                                   qemu_tcg_cpu_thread_fn, cpu,
+                                   QEMU_THREAD_JOINABLE, errp) < 0) {
+                return;
+            }
 
         } else {
             /* share a single thread for all cpus with TCG */
             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
-            /* TODO: let the callers handle the error instead of abort() here */
-            qemu_thread_create(cpu->thread, thread_name,
-                               qemu_tcg_rr_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE, &error_abort);
+            if (qemu_thread_create(cpu->thread, thread_name,
+                                   qemu_tcg_rr_cpu_thread_fn, cpu,
+                                   QEMU_THREAD_JOINABLE, errp) < 0) {
+                return;
+            }
 
             single_tcg_halt_cond = cpu->halt_cond;
             single_tcg_cpu_thread = cpu->thread;
@@ -1989,7 +1992,7 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
     }
 }
 
-static void qemu_hax_start_vcpu(CPUState *cpu)
+static void qemu_hax_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -1999,15 +2002,16 @@ static void qemu_hax_start_vcpu(CPUState *cpu)
 
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HAX",
              cpu->cpu_index);
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(cpu->thread, thread_name, qemu_hax_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
+    if (qemu_thread_create(cpu->thread, thread_name, qemu_hax_cpu_thread_fn,
+                           cpu, QEMU_THREAD_JOINABLE, errp) < 0) {
+        return;
+    }
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
 }
 
-static void qemu_kvm_start_vcpu(CPUState *cpu)
+static void qemu_kvm_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -2016,12 +2020,11 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
              cpu->cpu_index);
-    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(cpu->thread, thread_name, qemu_kvm_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
+                       cpu, QEMU_THREAD_JOINABLE, errp);
 }
 
-static void qemu_hvf_start_vcpu(CPUState *cpu)
+static void qemu_hvf_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -2035,12 +2038,11 @@ static void qemu_hvf_start_vcpu(CPUState *cpu)
 
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
              cpu->cpu_index);
-    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
+                       cpu, QEMU_THREAD_JOINABLE, errp);
 }
 
-static void qemu_whpx_start_vcpu(CPUState *cpu)
+static void qemu_whpx_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -2049,15 +2051,16 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
              cpu->cpu_index);
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(cpu->thread, thread_name, qemu_whpx_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
+    if (qemu_thread_create(cpu->thread, thread_name, qemu_whpx_cpu_thread_fn,
+                           cpu, QEMU_THREAD_JOINABLE, errp) < 0) {
+        return;
+    }
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
 }
 
-static void qemu_dummy_start_vcpu(CPUState *cpu)
+static void qemu_dummy_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -2066,16 +2069,16 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
              cpu->cpu_index);
-    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(cpu->thread, thread_name, qemu_dummy_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
+                       cpu, QEMU_THREAD_JOINABLE, errp);
 }
 
-void qemu_init_vcpu(CPUState *cpu)
+bool qemu_init_vcpu(CPUState *cpu, Error **errp)
 {
     cpu->nr_cores = smp_cores;
     cpu->nr_threads = smp_threads;
     cpu->stopped = true;
+    Error *local_err = NULL;
 
     if (!cpu->as) {
         /* If the target cpu hasn't set up any address spaces itself,
@@ -2086,22 +2089,29 @@ void qemu_init_vcpu(CPUState *cpu)
     }
 
     if (kvm_enabled()) {
-        qemu_kvm_start_vcpu(cpu);
+        qemu_kvm_start_vcpu(cpu, &local_err);
     } else if (hax_enabled()) {
-        qemu_hax_start_vcpu(cpu);
+        qemu_hax_start_vcpu(cpu, &local_err);
     } else if (hvf_enabled()) {
-        qemu_hvf_start_vcpu(cpu);
+        qemu_hvf_start_vcpu(cpu, &local_err);
     } else if (tcg_enabled()) {
-        qemu_tcg_init_vcpu(cpu);
+        qemu_tcg_init_vcpu(cpu, &local_err);
     } else if (whpx_enabled()) {
-        qemu_whpx_start_vcpu(cpu);
+        qemu_whpx_start_vcpu(cpu, &local_err);
     } else {
-        qemu_dummy_start_vcpu(cpu);
+        qemu_dummy_start_vcpu(cpu, &local_err);
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return false;
     }
 
     while (!cpu->created) {
         qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
     }
+
+    return true;
 }
 
 void cpu_stop_current(void)
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 16bbed1ae0..446e1072b8 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -1008,7 +1008,7 @@ void end_exclusive(void);
  *
  * Initializes a vCPU.
  */
-void qemu_init_vcpu(CPUState *cpu);
+bool qemu_init_vcpu(CPUState *cpu, Error **errp);
 
 #define SSTEP_ENABLE  0x1  /* Enable simulated HW single stepping */
 #define SSTEP_NOIRQ   0x2  /* Do not use IRQ while single stepping */
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 1fd95d6c0f..7d24ee1f31 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -66,7 +66,9 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     acc->parent_realize(dev, errp);
 }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7e1f3dd637..6b912dc346 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1140,7 +1140,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
     cpu_reset(cs);
 
     acc->parent_realize(dev, errp);
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index a23aba2688..ec92d69781 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -140,7 +140,9 @@ static void cris_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     ccc->parent_realize(dev, errp);
 }
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 00bf444620..08f600ced9 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -98,7 +98,9 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
     acc->parent_realize(dev, errp);
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2f5412592d..5545841df4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5316,7 +5316,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     /*
      * Most Intel and certain AMD CPUs support hyperthreading. Even though QEMU
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index b7499cb627..d50b1e4a43 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -139,7 +139,9 @@ static void lm32_cpu_realizefn(DeviceState *dev, Error **errp)
 
     cpu_reset(cs);
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     lcc->parent_realize(dev, errp);
 }
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 582e3a73b3..4ab53f2d58 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -231,7 +231,9 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
     m68k_cpu_init_gdb(cpu);
 
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     mcc->parent_realize(dev, errp);
 }
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 5596cd5485..310e3d8fd5 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -161,7 +161,9 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     env->pvr.regs[0] = PVR0_USE_EXC_MASK \
                        | PVR0_USE_ICACHE_MASK \
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index e217fb3e36..1e5aa69c57 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -145,7 +145,9 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     cpu_mips_realize_env(&cpu->env);
 
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     mcc->parent_realize(dev, errp);
 }
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 8d67eb6727..8581a6d922 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -66,7 +66,9 @@ static void moxie_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
     cpu_reset(cs);
 
     mcc->parent_realize(dev, errp);
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index fbfaa2ce26..5c7b4b486e 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -94,7 +94,9 @@ static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
     cpu_reset(cs);
 
     ncc->parent_realize(dev, errp);
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index fb7cb5c507..a6dcdb9df9 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -83,7 +83,9 @@ static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
     cpu_reset(cs);
 
     occ->parent_realize(dev, errp);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 59e0b86762..cfd7777479 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9705,7 +9705,9 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
                                  32, "power-vsx.xml", 0);
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        goto unrealize;
+    }
 
     pcc->parent_realize(dev, errp);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 28d7e5302f..a4cd7428dd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -311,7 +311,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
     cpu_reset(cs);
 
     mcc->parent_realize(dev, errp);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 18ba7f85a5..2a3eac9761 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -222,7 +222,9 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     qemu_register_reset(s390_cpu_machine_reset_cb, cpu);
 #endif
     s390_cpu_gdb_init(cs);
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     /*
      * KVM requires the initial CPU reset ioctl to be executed on the target
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index b9f393b7c7..d32ef2e1cb 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -196,7 +196,9 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     scc->parent_realize(dev, errp);
 }
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 4a4445bdf5..a511c90dab 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -772,7 +772,9 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     scc->parent_realize(dev, errp);
 }
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index bfe9be59b5..234148fabd 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -92,7 +92,9 @@ static void tilegx_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     tcc->parent_realize(dev, errp);
 }
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 2edaef1aef..5482d6ea3f 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -96,7 +96,9 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
         set_feature(env, TRICORE_FEATURE_13);
     }
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     tcc->parent_realize(dev, errp);
 }
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 2b49d1ca40..0c737c3187 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -96,7 +96,9 @@ static void uc32_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     ucc->parent_realize(dev, errp);
 }
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index a54dbe4260..d2351c9b20 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -131,7 +131,9 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 
     cs->gdb_num_regs = xcc->config->gdb_regmap.num_regs;
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
 
     xcc->parent_realize(dev, errp);
 }
-- 
2.17.2 (Apple Git-113)
