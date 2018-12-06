Received: from eggs.gnu.org ([2001:4830:134:3::10]:47969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gV259-0007rA-Lm
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 17:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gV256-0003EN-0Z
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 17:25:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46498
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gV252-0003BL-Dw
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 17:25:14 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB6MJ0xl023691
	for <qemu-devel@nongnu.org>; Thu, 6 Dec 2018 17:25:11 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p79gdg8cu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 17:25:10 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 6 Dec 2018 22:25:10 -0000
From: Collin Walling <walling@linux.ibm.com>
Date: Thu,  6 Dec 2018 17:24:18 -0500
In-Reply-To: <1544135058-21380-1-git-send-email-walling@linux.ibm.com>
References: <1544135058-21380-1-git-send-email-walling@linux.ibm.com>
Message-Id: <1544135058-21380-4-git-send-email-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 3/3] s390: migration and reset support for
 diagnose 318
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, borntraeger@de.ibm.com, thuth@redhat.com

Diagnose 318 contains data regarding the guest's name code
and version code (collectively called the cpc) and must be
captured for migration. Since this instruction is executed
in the kernel during IPL, we register the migration handlers
during IPL as well.

Also add a reset method for the diagnose 318 related data so
we can clear it during a machine reset.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/ipl.c             |  3 +++
 hw/s390x/s390-virtio-ccw.c |  3 +++
 target/s390x/diag.c        | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/internal.h    |  4 +++-
 target/s390x/kvm-stub.c    | 10 +++++++++
 target/s390x/kvm.c         | 22 ++++++++++++++++++++
 target/s390x/kvm_s390x.h   |  2 ++
 7 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 21f64ad..6e3af65 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -27,6 +27,7 @@
 #include "qemu/cutils.h"
 #include "qemu/option.h"
 #include "exec/exec-all.h"
+#include "internal.h"
 
 #define KERN_IMAGE_START                0x010000UL
 #define LINUX_MAGIC_ADDR                0x010008UL
@@ -230,6 +231,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
     ipl->compat_start_addr = ipl->start_addr;
     ipl->compat_bios_start_addr = ipl->bios_start_addr;
     qemu_register_reset(qdev_reset_all_fn, dev);
+
+    diag318_register();
 error:
     error_propagate(errp, err);
 }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a0615a8..2c670fc 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -37,6 +37,7 @@
 #include "cpu_models.h"
 #include "hw/nmi.h"
 #include "hw/s390x/tod.h"
+#include "internal.h"
 
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
@@ -357,6 +358,7 @@ static void s390_machine_reset(void)
         }
         subsystem_reset();
         s390_crypto_reset();
+        diag318_reset();
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
         break;
     case S390_RESET_LOAD_NORMAL:
@@ -364,6 +366,7 @@ static void s390_machine_reset(void)
             run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
         }
         subsystem_reset();
+        diag318_reset();
         run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
         break;
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index acb0f3d..935862d 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -20,6 +20,7 @@
 #include "sysemu/cpus.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
+#include "kvm_s390x.h"
 
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 {
@@ -134,3 +135,54 @@ out:
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
+    if (s390_has_feat(S390_FEAT_DIAG318)) {
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
+    return s390_has_feat(S390_FEAT_DIAG318);
+}
+
+const VMStateDescription vmstate_diag318 = {
+    .name = "diag318",
+    .post_load = diag318_post_load,
+    .pre_save = diag318_pre_save,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = diag318_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(cpc, Diag318Data),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+void diag318_register(void)
+{
+    vmstate_register(NULL, 0, &vmstate_diag318, &diag318data);
+}
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index f2a771e..d53b1d0 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -383,10 +383,12 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
                        target_ulong *addr, int *flags);
 
 
-/* misc_helper.c */
+/* diag.c */
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
                      uintptr_t ra);
+void diag318_register(void);
+void diag318_reset(void);
 
 
 /* translate.c */
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index bf7795e..1f0bee3 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -104,3 +104,13 @@ void kvm_s390_stop_interrupt(S390CPU *cpu)
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
\ No newline at end of file
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 3915e36..432f8ea 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -749,6 +749,28 @@ int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_low)
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
+int kvm_s390_get_cpc(uint64_t *cpc)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_MACHINE,
+        .attr = KVM_S390_VM_MACHINE_CPC,
+        .addr = (uint64_t)cpc,
+    };
+
+    return kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
+}
+
+int kvm_s390_set_cpc(uint64_t cpc)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_MACHINE,
+        .attr = KVM_S390_VM_MACHINE_CPC,
+        .addr = (uint64_t)&cpc,
+    };
+
+    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
+}
+
 /**
  * kvm_s390_mem_op:
  * @addr:      the logical start address in guest memory
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 6e52287..8c7b6a8 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -29,6 +29,8 @@ int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
 int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_clock);
 int kvm_s390_set_clock(uint8_t tod_high, uint64_t tod_clock);
 int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_clock);
+int kvm_s390_get_cpc(uint64_t *cpc);
+int kvm_s390_set_cpc(uint64_t cpc);
 void kvm_s390_enable_css_support(S390CPU *cpu);
 int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
                                     int vq, bool assign);
-- 
2.7.4
