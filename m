Received: from eggs.gnu.org ([2001:4830:134:3::10]:40861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIFbQ-0000M7-5H
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIFbO-0007Yj-HF
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:41:32 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 14 May 2018 17:41:13 +0200
Message-Id: <20180514154114.2558-6-cohuck@redhat.com>
In-Reply-To: <20180514154114.2558-1-cohuck@redhat.com>
References: <20180514154114.2558-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] s390x: refactor reset/reipl handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Calling pause_all_vcpus()/resume_all_vcpus() from a VCPU thread might
not be the best idea. As pause_all_vcpus() temporarily drops the qemu
mutex, two parallel calls to pause_all_vcpus() can be active at a time,
resulting in a deadlock. (either by two VCPUs or by the main thread and a
VCPU)

Let's handle it via the main loop instead, as suggested by Paolo. If we
would have two parallel reset requests by two different VCPUs at the
same time, the last one would win.

We use the existing ipl device to handle it. The nice side effect is
that we can get rid of reipl_requested.

This change implies that all reset handling now goes via the common
path, so "no-reboot" handling is now active for all kinds of reboots.

Let's execute any CPU initialization code on the target CPU using
run_on_cpu.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180424101859.10239-1-david@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ipl.c                     | 43 +++++++++++++++++++++++----
 hw/s390x/ipl.h                     | 16 ++++++++--
 hw/s390x/s390-virtio-ccw.c         | 51 ++++++++++++++++++++++++++-----
 include/hw/s390x/s390-virtio-ccw.h |  2 --
 target/s390x/cpu.h                 | 26 ++++++++++++++++
 target/s390x/diag.c                | 61 +++-----------------------------------
 target/s390x/internal.h            |  6 ----
 target/s390x/kvm.c                 |  2 +-
 8 files changed, 127 insertions(+), 80 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 150f6c0582..04245b5258 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -26,6 +26,7 @@
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
+#include "exec/exec-all.h"
 
 #define KERN_IMAGE_START                0x010000UL
 #define KERN_PARM_AREA                  0x010480UL
@@ -488,12 +489,20 @@ IplParameterBlock *s390_ipl_get_iplb(void)
     return &ipl->iplb;
 }
 
-void s390_reipl_request(void)
+void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
 {
     S390IPLState *ipl = get_ipl_device();
 
-    ipl->reipl_requested = true;
-    if (ipl->iplb_valid &&
+    if (reset_type == S390_RESET_EXTERNAL || reset_type == S390_RESET_REIPL) {
+        /* use CPU 0 for full resets */
+        ipl->reset_cpu_index = 0;
+    } else {
+        ipl->reset_cpu_index = cs->cpu_index;
+    }
+    ipl->reset_type = reset_type;
+
+    if (reset_type == S390_RESET_REIPL &&
+        ipl->iplb_valid &&
         !ipl->netboot &&
         ipl->iplb.pbt == S390_IPL_TYPE_CCW &&
         is_virtio_scsi_device(&ipl->iplb)) {
@@ -510,6 +519,31 @@ void s390_reipl_request(void)
         }
     }
     qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    /* as this is triggered by a CPU, make sure to exit the loop */
+    if (tcg_enabled()) {
+        cpu_loop_exit(cs);
+    }
+}
+
+void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_type)
+{
+    S390IPLState *ipl = get_ipl_device();
+
+    *cs = qemu_get_cpu(ipl->reset_cpu_index);
+    if (!*cs) {
+        /* use any CPU */
+        *cs = first_cpu;
+    }
+    *reset_type = ipl->reset_type;
+}
+
+void s390_ipl_clear_reset_request(void)
+{
+    S390IPLState *ipl = get_ipl_device();
+
+    ipl->reset_type = S390_RESET_EXTERNAL;
+    /* use CPU 0 for full resets */
+    ipl->reset_cpu_index = 0;
 }
 
 static void s390_ipl_prepare_qipl(S390CPU *cpu)
@@ -556,11 +590,10 @@ static void s390_ipl_reset(DeviceState *dev)
 {
     S390IPLState *ipl = S390_IPL(dev);
 
-    if (!ipl->reipl_requested) {
+    if (ipl->reset_type != S390_RESET_REIPL) {
         ipl->iplb_valid = false;
         memset(&ipl->iplb, 0, sizeof(IplParameterBlock));
     }
-    ipl->reipl_requested = false;
 }
 
 static void s390_ipl_class_init(ObjectClass *klass, void *data)
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 0570d0ad75..4e87b89418 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -87,7 +87,17 @@ int s390_ipl_set_loadparm(uint8_t *loadparm);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
 void s390_ipl_prepare_cpu(S390CPU *cpu);
 IplParameterBlock *s390_ipl_get_iplb(void);
-void s390_reipl_request(void);
+
+enum s390_reset {
+    /* default is a reset not triggered by a CPU e.g. issued by QMP */
+    S390_RESET_EXTERNAL = 0,
+    S390_RESET_REIPL,
+    S390_RESET_MODIFIED_CLEAR,
+    S390_RESET_LOAD_NORMAL,
+};
+void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type);
+void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_type);
+void s390_ipl_clear_reset_request(void);
 
 #define QIPL_ADDRESS  0xcc
 
@@ -129,9 +139,11 @@ struct S390IPLState {
     bool enforce_bios;
     IplParameterBlock iplb;
     bool iplb_valid;
-    bool reipl_requested;
     bool netboot;
     QemuIplParameters qipl;
+    /* reset related properties don't have to be migrated or reset */
+    enum s390_reset reset_type;
+    int reset_cpu_index;
 
     /*< public >*/
     char *kernel;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5796e24bd8..e548d341a0 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -93,7 +93,7 @@ static const char *const reset_dev_types[] = {
     "diag288",
 };
 
-void subsystem_reset(void)
+static void subsystem_reset(void)
 {
     DeviceState *dev;
     int i;
@@ -381,17 +381,54 @@ static void s390_cpu_plug(HotplugHandler *hotplug_dev,
     }
 }
 
+static inline void s390_do_cpu_ipl(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPU *cpu = S390_CPU(cs);
+
+    s390_ipl_prepare_cpu(cpu);
+    s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
+}
+
 static void s390_machine_reset(void)
 {
-    S390CPU *ipl_cpu = S390_CPU(qemu_get_cpu(0));
+    enum s390_reset reset_type;
+    CPUState *cs, *t;
 
+    /* get the reset parameters, reset them once done */
+    s390_ipl_get_reset_request(&cs, &reset_type);
+
+    /* all CPUs are paused and synchronized at this point */
     s390_cmma_reset();
-    qemu_devices_reset();
-    s390_crypto_reset();
 
-    /* all cpus are stopped - configure and start the ipl cpu only */
-    s390_ipl_prepare_cpu(ipl_cpu);
-    s390_cpu_set_state(S390_CPU_STATE_OPERATING, ipl_cpu);
+    switch (reset_type) {
+    case S390_RESET_EXTERNAL:
+    case S390_RESET_REIPL:
+        qemu_devices_reset();
+        s390_crypto_reset();
+
+        /* configure and start the ipl CPU only */
+        run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
+        break;
+    case S390_RESET_MODIFIED_CLEAR:
+        CPU_FOREACH(t) {
+            run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
+        }
+        subsystem_reset();
+        s390_crypto_reset();
+        run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
+        break;
+    case S390_RESET_LOAD_NORMAL:
+        CPU_FOREACH(t) {
+            run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
+        }
+        subsystem_reset();
+        run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
+        run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    s390_ipl_clear_reset_request();
 }
 
 static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index ac896e31ea..ab88d49d10 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -53,6 +53,4 @@ bool cpu_model_allowed(void);
  */
 bool css_migration_enabled(void);
 
-void subsystem_reset(void);
-
 #endif
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 3ee40f08b7..6629a533f3 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -686,6 +686,32 @@ static inline uint64_t s390_build_validity_mcic(void)
     return mcic;
 }
 
+static inline void s390_do_cpu_full_reset(CPUState *cs, run_on_cpu_data arg)
+{
+    cpu_reset(cs);
+}
+
+static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
+
+    scc->cpu_reset(cs);
+}
+
+static inline void s390_do_cpu_initial_reset(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
+
+    scc->initial_cpu_reset(cs);
+}
+
+static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
+
+    scc->load_normal(cs);
+}
+
 
 /* cpu.c */
 int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low);
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index a755837ad5..ac2c40f363 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -22,51 +22,6 @@
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 
-static int modified_clear_reset(S390CPU *cpu)
-{
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
-    CPUState *t;
-
-    pause_all_vcpus();
-    cpu_synchronize_all_states();
-    CPU_FOREACH(t) {
-        run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
-    }
-    s390_cmma_reset();
-    subsystem_reset();
-    s390_crypto_reset();
-    scc->load_normal(CPU(cpu));
-    cpu_synchronize_all_post_reset();
-    resume_all_vcpus();
-    return 0;
-}
-
-static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
-{
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
-
-    scc->cpu_reset(cs);
-}
-
-static int load_normal_reset(S390CPU *cpu)
-{
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
-    CPUState *t;
-
-    pause_all_vcpus();
-    cpu_synchronize_all_states();
-    CPU_FOREACH(t) {
-        run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
-    }
-    s390_cmma_reset();
-    subsystem_reset();
-    scc->initial_cpu_reset(CPU(cpu));
-    scc->load_normal(CPU(cpu));
-    cpu_synchronize_all_post_reset();
-    resume_all_vcpus();
-    return 0;
-}
-
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 {
     uint64_t func = env->regs[r1];
@@ -101,6 +56,7 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
+    CPUState *cs = CPU(s390_env_get_cpu(env));
     uint64_t addr =  env->regs[r1];
     uint64_t subcode = env->regs[r3];
     IplParameterBlock *iplb;
@@ -117,22 +73,13 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
     switch (subcode) {
     case 0:
-        modified_clear_reset(s390_env_get_cpu(env));
-        if (tcg_enabled()) {
-            cpu_loop_exit(CPU(s390_env_get_cpu(env)));
-        }
+        s390_ipl_reset_request(cs, S390_RESET_MODIFIED_CLEAR);
         break;
     case 1:
-        load_normal_reset(s390_env_get_cpu(env));
-        if (tcg_enabled()) {
-            cpu_loop_exit(CPU(s390_env_get_cpu(env)));
-        }
+        s390_ipl_reset_request(cs, S390_RESET_LOAD_NORMAL);
         break;
     case 3:
-        s390_reipl_request();
-        if (tcg_enabled()) {
-            cpu_loop_exit(CPU(s390_env_get_cpu(env)));
-        }
+        s390_ipl_reset_request(cs, S390_RESET_REIPL);
         break;
     case 5:
         if ((r1 & 1) || (addr & 0x0fffULL)) {
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index d911e84958..e392a02d12 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -273,12 +273,6 @@ static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
 /* Base/displacement are at the same locations. */
 #define decode_basedisp_rs decode_basedisp_s
 
-static inline void s390_do_cpu_full_reset(CPUState *cs, run_on_cpu_data arg)
-{
-    cpu_reset(cs);
-}
-
-
 /* arch_dump.c */
 int s390_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                               int cpuid, void *opaque);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 12b90cf5c5..58e4380ae3 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1767,7 +1767,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             ret = handle_intercept(cpu);
             break;
         case KVM_EXIT_S390_RESET:
-            s390_reipl_request();
+            s390_ipl_reset_request(cs, S390_RESET_REIPL);
             break;
         case KVM_EXIT_S390_TSCH:
             ret = handle_tsch(cpu);
-- 
2.14.3
