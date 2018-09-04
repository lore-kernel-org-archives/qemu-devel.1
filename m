Received: from eggs.gnu.org ([2001:4830:134:3::10]:50301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fx9DJ-0001PW-T3
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fx9DI-0006Qo-9B
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:41 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:58927)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1fx9DH-0006P7-S1
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:40 -0400
From: Fei Li <fli@suse.com>
Date: Tue,  4 Sep 2018 19:08:20 +0800
Message-Id: <20180904110822.12863-4-fli@suse.com>
In-Reply-To: <20180904110822.12863-1-fli@suse.com>
References: <20180904110822.12863-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH 3/5] qemu_init_vcpu: add a new Error paramater
 to propagate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fli@suse.com

The caller of qemu_init_vcpu() already passed the **errp to handle
errors. In view of this, add a new Error parameter to the following
call trace to propagate the error and let the final caller check it.

Signed-off-by: Fei Li <fli@suse.com>
---
 cpus.c                          | 32 +++++++++++++++++++-------------
 include/qom/cpu.h               |  2 +-
 target/alpha/cpu.c              |  6 +++++-
 target/arm/cpu.c                |  6 +++++-
 target/cris/cpu.c               |  6 +++++-
 target/hppa/cpu.c               |  6 +++++-
 target/i386/cpu.c               |  6 +++++-
 target/lm32/cpu.c               |  6 +++++-
 target/m68k/cpu.c               |  6 +++++-
 target/microblaze/cpu.c         |  6 +++++-
 target/mips/cpu.c               |  6 +++++-
 target/moxie/cpu.c              |  6 +++++-
 target/nios2/cpu.c              |  6 +++++-
 target/openrisc/cpu.c           |  6 +++++-
 target/ppc/translate_init.inc.c |  6 +++++-
 target/riscv/cpu.c              |  6 +++++-
 target/s390x/cpu.c              |  5 ++++-
 target/sh4/cpu.c                |  6 +++++-
 target/sparc/cpu.c              |  6 +++++-
 target/tilegx/cpu.c             |  6 +++++-
 target/tricore/cpu.c            |  6 +++++-
 target/unicore32/cpu.c          |  6 +++++-
 target/xtensa/cpu.c             |  6 +++++-
 23 files changed, 124 insertions(+), 35 deletions(-)

diff --git a/cpus.c b/cpus.c
index 8ee6e5db93..41efddc218 100644
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
+void qemu_init_vcpu(CPUState *cpu, Error **errp)
 {
     cpu->nr_cores = smp_cores;
     cpu->nr_threads = smp_threads;
     cpu->stopped = true;
+    Error *local_err = NULL;
 
     if (!cpu->as) {
         /* If the target cpu hasn't set up any address spaces itself,
@@ -2046,17 +2047,22 @@ void qemu_init_vcpu(CPUState *cpu)
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
+        return;
     }
 
     while (!cpu->created) {
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index dc130cd307..0766e694df 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -1012,7 +1012,7 @@ void end_exclusive(void);
  *
  * Initializes a vCPU.
  */
-void qemu_init_vcpu(CPUState *cpu);
+void qemu_init_vcpu(CPUState *cpu, Error **errp);
 
 #define SSTEP_ENABLE  0x1  /* Enable simulated HW single stepping */
 #define SSTEP_NOIRQ   0x2  /* Do not use IRQ while single stepping */
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index b08078e7fc..5b0b4892f2 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -66,7 +66,11 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     acc->parent_realize(dev, errp);
 }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 258ba6dcaa..a06a5629cd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1028,7 +1028,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     cpu_reset(cs);
 
     acc->parent_realize(dev, errp);
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index a23aba2688..707ef63293 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -140,7 +140,11 @@ static void cris_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     ccc->parent_realize(dev, errp);
 }
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 00bf444620..45249a505a 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -98,7 +98,11 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     acc->parent_realize(dev, errp);
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f24295e6e4..768039c65b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5112,7 +5112,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     /*
      * Most Intel and certain AMD CPUs support hyperthreading. Even though QEMU
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index b7499cb627..7c4e4c4d88 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -139,7 +139,11 @@ static void lm32_cpu_realizefn(DeviceState *dev, Error **errp)
 
     cpu_reset(cs);
 
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     lcc->parent_realize(dev, errp);
 }
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 582e3a73b3..ed5c340242 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -231,7 +231,11 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
     m68k_cpu_init_gdb(cpu);
 
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     mcc->parent_realize(dev, errp);
 }
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 9b546a2c18..2d82a5885a 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -161,7 +161,11 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     env->pvr.regs[0] = PVR0_USE_EXC_MASK \
                        | PVR0_USE_ICACHE_MASK \
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 497706b669..3e21067f7a 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -136,7 +136,11 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     cpu_mips_realize_env(&cpu->env);
 
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     mcc->parent_realize(dev, errp);
 }
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 8d67eb6727..c9e91d7e53 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -66,7 +66,11 @@ static void moxie_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     cpu_reset(cs);
 
     mcc->parent_realize(dev, errp);
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index fbfaa2ce26..be6601fc92 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -94,7 +94,11 @@ static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     cpu_reset(cs);
 
     ncc->parent_realize(dev, errp);
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index fb7cb5c507..ee4c931280 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -83,7 +83,11 @@ static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     cpu_reset(cs);
 
     occ->parent_realize(dev, errp);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index d920d3e538..50980dec9a 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9707,7 +9707,11 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
                                  32, "power-vsx.xml", 0);
     }
 
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     pcc->parent_realize(dev, errp);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d630e8fd6c..5416cf86c2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -303,7 +303,11 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     cpu_reset(cs);
 
     mcc->parent_realize(dev, errp);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 8ed4823d6e..bd362e3775 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -217,7 +217,10 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     qemu_register_reset(s390_cpu_machine_reset_cb, cpu);
 #endif
     s390_cpu_gdb_init(cs);
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        goto out;
+    }
 
     /*
      * KVM requires the initial CPU reset ioctl to be executed on the target
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index b9f393b7c7..2ad3a8f09e 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -196,7 +196,11 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     scc->parent_realize(dev, errp);
 }
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 0f090ece54..b3616f8d59 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -773,7 +773,11 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     scc->parent_realize(dev, errp);
 }
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index bfe9be59b5..59c0850a7c 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -92,7 +92,11 @@ static void tilegx_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     tcc->parent_realize(dev, errp);
 }
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 2edaef1aef..c95d8e9856 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -96,7 +96,11 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
         set_feature(env, TRICORE_FEATURE_13);
     }
     cpu_reset(cs);
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     tcc->parent_realize(dev, errp);
 }
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 68f978d80b..0102f4ea79 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -96,7 +96,11 @@ static void uc32_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     ucc->parent_realize(dev, errp);
 }
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 590813d4f7..b6740c0d66 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -131,7 +131,11 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 
     cs->gdb_num_regs = xcc->config->gdb_regmap.num_regs;
 
-    qemu_init_vcpu(cs);
+    qemu_init_vcpu(cs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     xcc->parent_realize(dev, errp);
 }
-- 
2.13.7
