Received: from eggs.gnu.org ([209.51.188.92]:60058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1hB4oD-0003to-AI
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1hB4oB-0002Lf-7V
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:49:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1hB4o9-0002J5-5b
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:49:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31Li3MT055073
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:49:29 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkqrc20nb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:49:29 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Mon, 1 Apr 2019 22:49:28 +0100
From: Collin Walling <walling@linux.ibm.com>
Date: Mon,  1 Apr 2019 17:48:47 -0400
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190401214847.27600-1-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3] s390: diagnose 318 info reset and migration
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, pbonzini@redhat.com

DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
be intercepted by SIE and handled via KVM. Let's introduce some
functions to communicate between QEMU and KVM via ioctls. These
will be used to get/set the diag318 related information (also known
as the "Control Program Code" or "CPC"), as well as check the system
if KVM supports handling this instruction.

Diag318 must also be reset on a load normal and modified clear, so
we use the set function (wrapped in a reset function) to explicitly
set the diag318 info to 0 for these cases.

Lastly, we want to ensure the diag318 info is migrated. The diag318
info migration is handled via a VMStateDescription. This feature is
only supported on QEMU machines 4.0 and later.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---

This version is posted in tandem with a new kernel patch that changes
how the execution of the diag 0x318 instruction is handled. A link to
this series will be attached as a reply to this series for convenience.

Changelog:

    v3
        - removed CPU model code
        - removed RSCPI and SCLP code
        - reverted max cpus back to 248 (previous patches limited this
            to 247)
        - introduced VMStateDescription handlers for migration
        - disabled migration of diag318 info for machines 3.1 and older
            - a warning is printed if migration is disabled and KVM
              supports handling this instruction

---
 hw/s390x/s390-virtio-ccw.c   |  6 ++++
 linux-headers/asm-s390/kvm.h |  4 +++
 target/s390x/diag.c          | 63 ++++++++++++++++++++++++++++++++++++
 target/s390x/internal.h      |  5 ++-
 target/s390x/kvm-stub.c      | 15 +++++++++
 target/s390x/kvm.c           | 32 ++++++++++++++++++
 target/s390x/kvm_s390x.h     |  3 ++
 7 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d11069b860..2a50868496 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -36,6 +36,7 @@
 #include "cpu_models.h"
 #include "hw/nmi.h"
 #include "hw/s390x/tod.h"
+#include "internal.h"
 
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
@@ -302,6 +303,8 @@ static void ccw_init(MachineState *machine)
 
     /* init the TOD clock */
     s390_init_tod();
+
+    diag318_register_migration();
 }
 
 static void s390_cpu_plug(HotplugHandler *hotplug_dev,
@@ -352,6 +355,7 @@ static void s390_machine_reset(void)
         }
         subsystem_reset();
         s390_crypto_reset();
+        diag318_reset();
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
         break;
     case S390_RESET_LOAD_NORMAL:
@@ -359,6 +363,7 @@ static void s390_machine_reset(void)
             run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
         }
         subsystem_reset();
+        diag318_reset();
         run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
         break;
@@ -662,6 +667,7 @@ static void ccw_machine_3_1_instance_options(MachineState *machine)
     s390_cpudef_featoff_greater(14, 1, S390_FEAT_MULTIPLE_EPOCH);
     s390_cpudef_group_featoff_greater(14, 1, S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF);
     s390_set_qemu_cpu_model(0x2827, 12, 2, qemu_cpu_feat);
+    diag318_disable_migration();
 }
 
 static void ccw_machine_3_1_class_options(MachineClass *mc)
diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 0265482f8f..735f5a46e8 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -74,6 +74,7 @@ struct kvm_s390_io_adapter_req {
 #define KVM_S390_VM_CRYPTO		2
 #define KVM_S390_VM_CPU_MODEL		3
 #define KVM_S390_VM_MIGRATION		4
+#define KVM_S390_VM_MISC		5
 
 /* kvm attributes for mem_ctrl */
 #define KVM_S390_VM_MEM_ENABLE_CMMA	0
@@ -168,6 +169,9 @@ struct kvm_s390_vm_cpu_subfunc {
 #define KVM_S390_VM_MIGRATION_START	1
 #define KVM_S390_VM_MIGRATION_STATUS	2
 
+/* kvm attributes for KVM_S390_VM_MISC */
+#define KVM_S390_VM_MISC_CPC		0
+
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 	/* general purpose regs for s390 */
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index aafa740f61..bbb151e3eb 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -20,6 +20,8 @@
 #include "sysemu/cpus.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
+#include "kvm_s390x.h"
+#include "sysemu/kvm.h"
 
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 {
@@ -134,3 +136,64 @@ out:
         break;
     }
 }
+
+typedef struct Diag318Data {
+    uint64_t cpc;
+} Diag318Data;
+static Diag318Data diag318data;
+
+void diag318_reset(void)
+{
+    if (kvm_s390_has_diag318()) {
+        kvm_s390_set_cpc(0);
+    }
+}
+
+static int diag318_post_load(void *opaque, int version_id)
+{
+    Diag318Data *d = opaque;
+
+    kvm_s390_set_cpc(d->cpc);
+    return 0;
+}
+
+static int diag318_pre_save(void *opaque)
+{
+    Diag318Data *d = opaque;
+
+    kvm_s390_get_cpc(&d->cpc);
+    return 0;
+}
+
+static bool diag318_needed(void *opaque)
+{
+    return kvm_s390_has_diag318();
+}
+
+VMStateDescription vmstate_diag318 = {
+    .name = "diag318",
+    .post_load = diag318_post_load,
+    .pre_save = diag318_pre_save,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .unmigratable = 0,
+    .needed = diag318_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(cpc, Diag318Data),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+void diag318_register_migration(void)
+{
+    if (!vmstate_diag318.unmigratable)
+        vmstate_register(NULL, 0, &vmstate_diag318, &diag318data);
+    else if (kvm_s390_has_diag318())
+        printf("warning: diag318 info lacks migration support, this data "
+               "will be lost if migrated.\n");
+}
+
+void diag318_disable_migration(void)
+{
+    vmstate_diag318.unmigratable = 1;
+}
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 3b4855c175..8ce8cf5be4 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -360,10 +360,13 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
                        target_ulong *addr, int *flags);
 
 
-/* misc_helper.c */
+/* diag.c */
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
                      uintptr_t ra);
+void diag318_register_migration(void);
+void diag318_disable_migration(void);
+void diag318_reset(void);
 
 
 /* translate.c */
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index bf7795e47a..7861ccdf9b 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -104,3 +104,18 @@ void kvm_s390_stop_interrupt(S390CPU *cpu)
 void kvm_s390_restart_interrupt(S390CPU *cpu)
 {
 }
+
+int kvm_s390_get_cpc(uint64_t *cpc)
+{
+    return 0;
+}
+
+int kvm_s390_set_cpc(uint64_t cpc)
+{
+    return 0;
+}
+
+bool kvm_s390_has_diag318(void)
+{
+    return false;
+}
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 19530fb94e..225e5160c9 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -747,6 +747,38 @@ int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_low)
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
+int kvm_s390_get_cpc(uint64_t *cpc)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_MISC,
+        .attr = KVM_S390_VM_MISC_CPC,
+        .addr = (uint64_t)cpc,
+    };
+
+    return kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
+}
+
+int kvm_s390_set_cpc(uint64_t cpc)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_MISC,
+        .attr = KVM_S390_VM_MISC_CPC,
+        .addr = (uint64_t)&cpc,
+    };
+
+    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
+}
+
+bool kvm_s390_has_diag318(void)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_MISC,
+        .attr = KVM_S390_VM_MISC_CPC,
+    };
+
+    return kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr) == 0;
+}
+
 /**
  * kvm_s390_mem_op:
  * @addr:      the logical start address in guest memory
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 6e52287da3..53f165ff9e 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -29,6 +29,9 @@ int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
 int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_clock);
 int kvm_s390_set_clock(uint8_t tod_high, uint64_t tod_clock);
 int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_clock);
+int kvm_s390_get_cpc(uint64_t *cpc);
+int kvm_s390_set_cpc(uint64_t cpc);
+bool kvm_s390_has_diag318(void);
 void kvm_s390_enable_css_support(S390CPU *cpu);
 int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
                                     int vq, bool assign);
-- 
2.20.1
