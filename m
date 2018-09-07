Received: from eggs.gnu.org ([2001:4830:134:3::10]:44470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fyGz9-00068B-QU
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fyGz5-0005eX-DO
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:39:41 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:56122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1fyGz4-0005bB-Po
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:39:39 -0400
From: Fei Li <fli@suse.com>
Date: Fri,  7 Sep 2018 21:39:01 +0800
Message-Id: <20180907133902.28462-4-fli@suse.com>
In-Reply-To: <20180907133902.28462-1-fli@suse.com>
References: <20180907133902.28462-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH v2 3/4] qemu_init_vcpu: add a new Error
 parameter to propagate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, armbru@redhat.com, eblake@redhat.com, fli@suse.com

The caller of qemu_init_vcpu() already passed the **errp to handle
errors. In view of this, add a new Error parameter to the following
call trace to propagate the error and let the further caller check it.

Besides, make qemu_init_vcpu() return a Boolean value to let its
callers know whether it succeeds.

Signed-off-by: Fei Li <fli@suse.com>
---
 accel/tcg/user-exec-stub.c      |  2 +-
 cpus.c                          | 34 +++++++++++++++++++++-------------
 include/qom/cpu.h               |  2 +-
 target/alpha/cpu.c              |  4 +++-
 target/arm/cpu.c                |  4 +++-
 target/cris/cpu.c               |  4 +++-
 target/hppa/cpu.c               |  4 +++-
 target/i386/cpu.c               |  4 +++-
 target/lm32/cpu.c               |  4 +++-
 target/m68k/cpu.c               |  4 +++-
 target/microblaze/cpu.c         |  4 +++-
 target/mips/cpu.c               |  4 +++-
 target/moxie/cpu.c              |  4 +++-
 target/nios2/cpu.c              |  4 +++-
 target/openrisc/cpu.c           |  4 +++-
 target/ppc/translate_init.inc.c |  4 +++-
 target/riscv/cpu.c              |  4 +++-
 target/s390x/cpu.c              |  4 +++-
 target/sh4/cpu.c                |  4 +++-
 target/sparc/cpu.c              |  4 +++-
 target/tilegx/cpu.c             |  4 +++-
 target/tricore/cpu.c            |  4 +++-
 target/unicore32/cpu.c          |  4 +++-
 target/xtensa/cpu.c             |  4 +++-
 24 files changed, 86 insertions(+), 36 deletions(-)

diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index a32b4496af..38f6b928d4 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -10,7 +10,7 @@ void cpu_resume(CPUState *cpu)
 {
 }
 
-void qemu_init_vcpu(CPUState *cpu)
+bool qemu_init_vcpu(CPUState *cpu, Error **errp)
 {
 }
 
diff --git a/cpus.c b/cpus.c
index 8ee6e5db93..1feb308123 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1898,7 +1898,7 @@ void cpu_remove_sync(CPUState *cpu)
 /* For temporary buffers for forming a name */
 #define VCPU_THREAD_NAME_SIZE 16
 
-static void qemu_tcg_init_vcpu(CPUState *cpu)
+static void qemu_tcg_init_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
     static QemuCond *single_tcg_halt_cond;
@@ -1954,7 +1954,7 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
     }
 }
 
-static void qemu_hax_start_vcpu(CPUState *cpu)
+static void qemu_hax_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -1971,7 +1971,7 @@ static void qemu_hax_start_vcpu(CPUState *cpu)
 #endif
 }
 
-static void qemu_kvm_start_vcpu(CPUState *cpu)
+static void qemu_kvm_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -1984,7 +1984,7 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
                        cpu, QEMU_THREAD_JOINABLE);
 }
 
-static void qemu_hvf_start_vcpu(CPUState *cpu)
+static void qemu_hvf_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -2002,7 +2002,7 @@ static void qemu_hvf_start_vcpu(CPUState *cpu)
                        cpu, QEMU_THREAD_JOINABLE);
 }
 
-static void qemu_whpx_start_vcpu(CPUState *cpu)
+static void qemu_whpx_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -2018,7 +2018,7 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
 #endif
 }
 
-static void qemu_dummy_start_vcpu(CPUState *cpu)
+static void qemu_dummy_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
@@ -2031,11 +2031,12 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
                        QEMU_THREAD_JOINABLE);
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
@@ -2046,22 +2047,29 @@ void qemu_init_vcpu(CPUState *cpu)
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
index dc130cd307..4d85dda175 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -1012,7 +1012,7 @@ void end_exclusive(void);
  *
  * Initializes a vCPU.
  */
-void qemu_init_vcpu(CPUState *cpu);
+bool qemu_init_vcpu(CPUState *cpu, Error **errp);
 
 #define SSTEP_ENABLE  0x1  /* Enable simulated HW single stepping */
 #define SSTEP_NOIRQ   0x2  /* Do not use IRQ while single stepping */
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index b08078e7fc..d531bd4f7e 100644
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
index 258ba6dcaa..d2ad17fbca 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1028,7 +1028,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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
index f24295e6e4..fad65766a4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5112,7 +5112,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
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
index 9b546a2c18..3906c864a3 100644
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
index 497706b669..62be84af76 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -136,7 +136,9 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
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
index d920d3e538..7b47066599 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9707,7 +9707,9 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
                                  32, "power-vsx.xml", 0);
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        goto unrealize;
+    }
 
     pcc->parent_realize(dev, errp);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d630e8fd6c..ef56215e92 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -303,7 +303,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    if (!qemu_init_vcpu(cs, errp)) {
+        return;
+    }
     cpu_reset(cs);
 
     mcc->parent_realize(dev, errp);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 8ed4823d6e..3a665c4df8 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -217,7 +217,9 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
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
index 0f090ece54..9c22f6a7df 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -773,7 +773,9 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
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
index 68f978d80b..1f6a33b6f3 100644
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
index 590813d4f7..177694454f 100644
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
2.13.7
