Received: from eggs.gnu.org ([2001:4830:134:3::10]:41450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gUJ2m-0002DC-Ft
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 17:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gUJ2h-0003yx-Ik
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 17:19:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gUJ2h-0003ws-A8
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 17:19:47 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB4MIkZI122493
	for <qemu-devel@nongnu.org>; Tue, 4 Dec 2018 17:19:44 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p5yg2ey8h-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 17:19:43 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 4 Dec 2018 22:19:42 -0000
From: Collin Walling <walling@linux.ibm.com>
Date: Tue,  4 Dec 2018 17:18:59 -0500
Message-Id: <1543961939-2419-1-git-send-email-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v1] s390: guest support for diagnose 318 and
 limit max VCPUs to 247
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, cotte@de.ibm.com, david@redhat.com, mimu@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: thuth@redhat.com

Add migration and reset support for diagnose 318. This is a new z14 GA2 
hardware feature, but we can provide guest support starting with the 
zEC12-full CPU model.

Because new hardware introduces a new facility-availability byte in 
the Read SCP Info block, we lose one byte in the CPU entries list 
and must limit the maximum VCPUs to 247 (down from 248).

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---

Changelog

    RFC -> v1
        - introduced kvm stubs for set/get cpc
        - s/fac134/byte_134
        - moved diag318 vmstate description to diag.c
        - reduced S390_VCPU_MAX to 247

 hw/s390x/ipl.c                  |  3 +++
 hw/s390x/s390-virtio-ccw.c      |  3 +++
 hw/s390x/sclp.c                 |  2 ++
 include/hw/s390x/sclp.h         |  2 ++
 linux-headers/asm-s390/kvm.h    |  5 ++++
 target/s390x/cpu.h              |  2 +-
 target/s390x/cpu_features.c     |  3 +++
 target/s390x/cpu_features.h     |  1 +
 target/s390x/cpu_features_def.h |  3 +++
 target/s390x/diag.c             | 53 +++++++++++++++++++++++++++++++++++++++++
 target/s390x/gen-features.c     |  1 +
 target/s390x/internal.h         |  4 +++-
 target/s390x/kvm-stub.c         | 10 ++++++++
 target/s390x/kvm.c              | 23 ++++++++++++++++++
 target/s390x/kvm_s390x.h        |  3 +++
 15 files changed, 116 insertions(+), 2 deletions(-)

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
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 4510a80..183c627 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -73,6 +73,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
                          read_info->conf_char);
     s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
                          read_info->conf_char_ext);
+    /* Read Info byte 134 */
+    s390_get_feat_block(S390_FEAT_TYPE_SCLP_BYTE_134, read_info->byte_134);
 
     read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
                                         SCLP_HAS_IOA_RECONFIG);
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index f9db243..eb12ba2 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -133,6 +133,8 @@ typedef struct ReadInfo {
     uint16_t highest_cpu;
     uint8_t  _reserved5[124 - 122];     /* 122-123 */
     uint32_t hmfai;
+    uint8_t  _reserved7[134 - 128];     /* 128-133 */
+    uint8_t  byte_134[1];
     struct CPUEntry entries[0];
 } QEMU_PACKED ReadInfo;
 
diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 0265482..8c206d2 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -74,6 +74,7 @@ struct kvm_s390_io_adapter_req {
 #define KVM_S390_VM_CRYPTO		2
 #define KVM_S390_VM_CPU_MODEL		3
 #define KVM_S390_VM_MIGRATION		4
+#define KVM_S390_VM_MISC		5
 
 /* kvm attributes for mem_ctrl */
 #define KVM_S390_VM_MEM_ENABLE_CMMA	0
@@ -130,6 +131,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 #define KVM_S390_VM_CPU_FEAT_KSS	13
+#define KVM_S390_VM_CPU_FEAT_DIAG318	14
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
@@ -168,6 +170,9 @@ struct kvm_s390_vm_cpu_subfunc {
 #define KVM_S390_VM_MIGRATION_START	1
 #define KVM_S390_VM_MIGRATION_STATUS	2
 
+/* kvm attributes for KVM_S390_VM_MISC */
+#define KVM_S390_VM_MISC_CPC		0
+
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 	/* general purpose regs for s390 */
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 8c2320e..594b4a4 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -52,7 +52,7 @@
 
 #define MMU_USER_IDX 0
 
-#define S390_MAX_CPUS 248
+#define S390_MAX_CPUS 247
 
 typedef struct PSW {
     uint64_t mask;
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 60cfeba..d05afa5 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -121,6 +121,9 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("pfmfi", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 9, "SIE: PFMF interpretation facility"),
     FEAT_INIT("ibs", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-suppression facility"),
 
+    /* SCLP SCCB Byte 134 */
+    FEAT_INIT("diag318", S390_FEAT_TYPE_SCLP_BYTE_134, 0, "SIE: Diagnose 318"),
+
     FEAT_INIT("sief2", S390_FEAT_TYPE_SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)"),
     FEAT_INIT("skey", S390_FEAT_TYPE_SCLP_CPU, 5, "SIE: Storage-key facility"),
     FEAT_INIT("gpereh", S390_FEAT_TYPE_SCLP_CPU, 10, "SIE: Guest-PER enhancement facility"),
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index effe790..e7248df 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -23,6 +23,7 @@ typedef enum {
     S390_FEAT_TYPE_STFL,
     S390_FEAT_TYPE_SCLP_CONF_CHAR,
     S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
+    S390_FEAT_TYPE_SCLP_BYTE_134,
     S390_FEAT_TYPE_SCLP_CPU,
     S390_FEAT_TYPE_MISC,
     S390_FEAT_TYPE_PLO,
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index 5fc7e7b..d99da1d 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -109,6 +109,9 @@ typedef enum {
     S390_FEAT_SIE_PFMFI,
     S390_FEAT_SIE_IBS,
 
+    /* Read Info Byte 134 */
+    S390_FEAT_DIAG318,
+
     /* Sclp Cpu */
     S390_FEAT_SIE_F2,
     S390_FEAT_SIE_SKEY,
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index acb0f3d..2207c08 100644
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
@@ -134,3 +136,54 @@ out:
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
\ No newline at end of file
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 70015ea..a3d1457 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -450,6 +450,7 @@ static uint16_t full_GEN12_GA1[] = {
     S390_FEAT_AP_QUERY_CONFIG_INFO,
     S390_FEAT_AP_FACILITIES_TEST,
     S390_FEAT_AP,
+    S390_FEAT_DIAG318,
 };
 
 static uint16_t full_GEN12_GA2[] = {
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
index 2ebf26a..9ed4cea 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -749,6 +749,28 @@ int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_low)
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
 /**
  * kvm_s390_mem_op:
  * @addr:      the logical start address in guest memory
@@ -2142,6 +2164,7 @@ static int kvm_to_feat[][2] = {
     { KVM_S390_VM_CPU_FEAT_PFMFI, S390_FEAT_SIE_PFMFI},
     { KVM_S390_VM_CPU_FEAT_SIGPIF, S390_FEAT_SIE_SIGPIF},
     { KVM_S390_VM_CPU_FEAT_KSS, S390_FEAT_SIE_KSS},
+    { KVM_S390_VM_CPU_FEAT_DIAG318, S390_FEAT_DIAG318},
 };
 
 static int query_cpu_feat(S390FeatBitmap features)
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 6e52287..53f165f 100644
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
2.7.4
