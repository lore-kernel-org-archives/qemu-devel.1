Received: from eggs.gnu.org ([2001:4830:134:3::10]:34953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiRB-0006EO-1J
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiR8-0004JF-9u
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:01 -0400
Received: from mail-eopbgr30111.outbound.protection.outlook.com
	([40.107.3.111]:29216
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiR7-0004IT-Qt
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:24:58 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:02 +0300
Message-Id: <20170621162424.10462-2-rkagan@virtuozzo.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 01/23] hyperv: add header with protocol
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Igor Mammedov <imammedo@redhat.com>

The definitions for Hyper-V emulation are currently taken from a header
imported from the Linux kernel.

However, as these describe a third-party protocol rather than a kernel
API, it probably wasn't a good idea to publish it in the kernel uapi.

This patch introduces a header that provides all the necessary
definitions, obsoleting the one coming from the kernel.

The new header supports (temporary) coexistence with the kernel one.
The constants explicitly named in the Hyper-V specification (e.g. msr
numbers) are defined in a non-conflicting way.  Other constants and
types have got new names.

While at this, the protocol data structures are defined in a more
conventional way, without bitfields, enums, and excessive unions.

The code using this stuff is adjusted, too; it can now be built both
with and without the kernel header in the tree.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/cpu.h          |  10 +-
 target/i386/hyperv_proto.h | 257 +++++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.c          |   4 +-
 target/i386/hyperv.c       |   6 +-
 target/i386/kvm.c          |  57 +++++-----
 target/i386/machine.c      |  15 ++-
 6 files changed, 301 insertions(+), 48 deletions(-)
 create mode 100644 target/i386/hyperv_proto.h

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index de0551f..464ed1e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -22,7 +22,7 @@
 
 #include "qemu-common.h"
 #include "cpu-qom.h"
-#include "standard-headers/asm-x86/hyperv.h"
+#include "hyperv_proto.h"
 
 #ifdef TARGET_X86_64
 #define TARGET_LONG_BITS 64
@@ -1093,15 +1093,15 @@ typedef struct CPUX86State {
     uint64_t msr_hv_guest_os_id;
     uint64_t msr_hv_vapic;
     uint64_t msr_hv_tsc;
-    uint64_t msr_hv_crash_params[HV_X64_MSR_CRASH_PARAMS];
+    uint64_t msr_hv_crash_params[HV_CRASH_PARAMS];
     uint64_t msr_hv_runtime;
     uint64_t msr_hv_synic_control;
     uint64_t msr_hv_synic_version;
     uint64_t msr_hv_synic_evt_page;
     uint64_t msr_hv_synic_msg_page;
-    uint64_t msr_hv_synic_sint[HV_SYNIC_SINT_COUNT];
-    uint64_t msr_hv_stimer_config[HV_SYNIC_STIMER_COUNT];
-    uint64_t msr_hv_stimer_count[HV_SYNIC_STIMER_COUNT];
+    uint64_t msr_hv_synic_sint[HV_SINT_COUNT];
+    uint64_t msr_hv_stimer_config[HV_STIMER_COUNT];
+    uint64_t msr_hv_stimer_count[HV_STIMER_COUNT];
 
     /* exception/interrupt handling */
     int error_code;
diff --git a/target/i386/hyperv_proto.h b/target/i386/hyperv_proto.h
new file mode 100644
index 0000000..1b3fa6e
--- /dev/null
+++ b/target/i386/hyperv_proto.h
@@ -0,0 +1,257 @@
+/*
+ * Definitions for Hyper-V guest/hypervisor interaction
+ *
+ * Copyright (C) 2017 Parallels International GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef TARGET_I386_HYPERV_PROTO_H
+#define TARGET_I386_HYPERV_PROTO_H
+
+#include "qemu/bitmap.h"
+
+#define HV_CPUID_VENDOR_AND_MAX_FUNCTIONS     0x40000000
+#define HV_CPUID_INTERFACE                    0x40000001
+#define HV_CPUID_VERSION                      0x40000002
+#define HV_CPUID_FEATURES                     0x40000003
+#define HV_CPUID_ENLIGHTMENT_INFO             0x40000004
+#define HV_CPUID_IMPLEMENT_LIMITS             0x40000005
+#define HV_CPUID_MIN                          0x40000005
+#define HV_CPUID_MAX                          0x4000ffff
+#define HV_HYPERVISOR_PRESENT_BIT             0x80000000
+
+/*
+ * HV_CPUID_FEATURES.EAX bits
+ */
+#define HV_VP_RUNTIME_AVAILABLE      (1u << 0)
+#define HV_TIME_REF_COUNT_AVAILABLE  (1u << 1)
+#define HV_SYNIC_AVAILABLE           (1u << 2)
+#define HV_SYNTIMERS_AVAILABLE       (1u << 3)
+#define HV_APIC_ACCESS_AVAILABLE     (1u << 4)
+#define HV_HYPERCALL_AVAILABLE       (1u << 5)
+#define HV_VP_INDEX_AVAILABLE        (1u << 6)
+#define HV_RESET_AVAILABLE           (1u << 7)
+#define HV_REFERENCE_TSC_AVAILABLE   (1u << 9)
+
+/*
+ * HV_CPUID_FEATURES.EDX bits
+ */
+#define HV_MWAIT_AVAILABLE                      (1u << 0)
+#define HV_GUEST_DEBUGGING_AVAILABLE            (1u << 1)
+#define HV_PERF_MONITOR_AVAILABLE               (1u << 2)
+#define HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE   (1u << 3)
+#define HV_HYPERCALL_PARAMS_XMM_AVAILABLE       (1u << 4)
+#define HV_GUEST_IDLE_STATE_AVAILABLE           (1u << 5)
+#define HV_GUEST_CRASH_MSR_AVAILABLE            (1u << 10)
+
+/*
+ * HV_CPUID_ENLIGHTMENT_INFO.EAX bits
+ */
+#define HV_AS_SWITCH_RECOMMENDED            (1u << 0)
+#define HV_LOCAL_TLB_FLUSH_RECOMMENDED      (1u << 1)
+#define HV_REMOTE_TLB_FLUSH_RECOMMENDED     (1u << 2)
+#define HV_APIC_ACCESS_RECOMMENDED          (1u << 3)
+#define HV_SYSTEM_RESET_RECOMMENDED         (1u << 4)
+#define HV_RELAXED_TIMING_RECOMMENDED       (1u << 5)
+
+/*
+ * Basic virtualized MSRs
+ */
+#define HV_X64_MSR_GUEST_OS_ID                0x40000000
+#define HV_X64_MSR_HYPERCALL                  0x40000001
+#define HV_X64_MSR_VP_INDEX                   0x40000002
+#define HV_X64_MSR_RESET                      0x40000003
+#define HV_X64_MSR_VP_RUNTIME                 0x40000010
+#define HV_X64_MSR_TIME_REF_COUNT             0x40000020
+#define HV_X64_MSR_REFERENCE_TSC              0x40000021
+#define HV_X64_MSR_TSC_FREQUENCY              0x40000022
+#define HV_X64_MSR_APIC_FREQUENCY             0x40000023
+
+/*
+ * Virtual APIC MSRs
+ */
+#define HV_X64_MSR_EOI                        0x40000070
+#define HV_X64_MSR_ICR                        0x40000071
+#define HV_X64_MSR_TPR                        0x40000072
+#define HV_X64_MSR_APIC_ASSIST_PAGE           0x40000073
+
+/*
+ * Synthetic interrupt controller MSRs
+ */
+#define HV_X64_MSR_SCONTROL                   0x40000080
+#define HV_X64_MSR_SVERSION                   0x40000081
+#define HV_X64_MSR_SIEFP                      0x40000082
+#define HV_X64_MSR_SIMP                       0x40000083
+#define HV_X64_MSR_EOM                        0x40000084
+#define HV_X64_MSR_SINT0                      0x40000090
+#define HV_X64_MSR_SINT1                      0x40000091
+#define HV_X64_MSR_SINT2                      0x40000092
+#define HV_X64_MSR_SINT3                      0x40000093
+#define HV_X64_MSR_SINT4                      0x40000094
+#define HV_X64_MSR_SINT5                      0x40000095
+#define HV_X64_MSR_SINT6                      0x40000096
+#define HV_X64_MSR_SINT7                      0x40000097
+#define HV_X64_MSR_SINT8                      0x40000098
+#define HV_X64_MSR_SINT9                      0x40000099
+#define HV_X64_MSR_SINT10                     0x4000009A
+#define HV_X64_MSR_SINT11                     0x4000009B
+#define HV_X64_MSR_SINT12                     0x4000009C
+#define HV_X64_MSR_SINT13                     0x4000009D
+#define HV_X64_MSR_SINT14                     0x4000009E
+#define HV_X64_MSR_SINT15                     0x4000009F
+
+/*
+ * Synthetic timer MSRs
+ */
+#define HV_X64_MSR_STIMER0_CONFIG               0x400000B0
+#define HV_X64_MSR_STIMER0_COUNT                0x400000B1
+#define HV_X64_MSR_STIMER1_CONFIG               0x400000B2
+#define HV_X64_MSR_STIMER1_COUNT                0x400000B3
+#define HV_X64_MSR_STIMER2_CONFIG               0x400000B4
+#define HV_X64_MSR_STIMER2_COUNT                0x400000B5
+#define HV_X64_MSR_STIMER3_CONFIG               0x400000B6
+#define HV_X64_MSR_STIMER3_COUNT                0x400000B7
+
+/*
+ * Guest crash notification MSRs
+ */
+#define HV_X64_MSR_CRASH_P0                     0x40000100
+#define HV_X64_MSR_CRASH_P1                     0x40000101
+#define HV_X64_MSR_CRASH_P2                     0x40000102
+#define HV_X64_MSR_CRASH_P3                     0x40000103
+#define HV_X64_MSR_CRASH_P4                     0x40000104
+#define HV_CRASH_PARAMS    (HV_X64_MSR_CRASH_P4 - HV_X64_MSR_CRASH_P0 + 1)
+#define HV_X64_MSR_CRASH_CTL                    0x40000105
+#define HV_CRASH_CTL_NOTIFY                     (1ull << 63)
+
+/*
+ * Hypercall status code
+ */
+#define HV_STATUS_SUCCESS                     0
+#define HV_STATUS_INVALID_HYPERCALL_CODE      2
+#define HV_STATUS_INVALID_HYPERCALL_INPUT     3
+#define HV_STATUS_INVALID_ALIGNMENT           4
+#define HV_STATUS_INVALID_PARAMETER           5
+#define HV_STATUS_INSUFFICIENT_MEMORY         11
+#define HV_STATUS_INVALID_CONNECTION_ID       18
+#define HV_STATUS_INSUFFICIENT_BUFFERS        19
+
+/*
+ * Hypercall numbers
+ */
+#define HV_POST_MESSAGE                       0x005c
+#define HV_SIGNAL_EVENT                       0x005d
+#define HV_HYPERCALL_FAST                     (1u << 16)
+
+/*
+ * Hypercall MSR bits
+ */
+#define HV_HYPERCALL_ENABLE                   (1u << 0)
+
+/*
+ * Synthetic interrupt controller definitions
+ */
+#define HV_SYNIC_VERSION                      1
+#define HV_SINT_COUNT                         16
+#define HV_SYNIC_ENABLE                       (1u << 0)
+#define HV_SIMP_ENABLE                        (1u << 0)
+#define HV_SIEFP_ENABLE                       (1u << 0)
+#define HV_SINT_MASKED                        (1u << 16)
+#define HV_SINT_AUTO_EOI                      (1u << 17)
+#define HV_SINT_VECTOR_MASK                   0xff
+
+#define HV_STIMER_COUNT                       4
+
+/*
+ * Message size
+ */
+#define HV_MESSAGE_PAYLOAD_SIZE               240
+
+/*
+ * Message types
+ */
+#define HV_MESSAGE_NONE                       0x00000000
+#define HV_MESSAGE_VMBUS                      0x00000001
+#define HV_MESSAGE_UNMAPPED_GPA               0x80000000
+#define HV_MESSAGE_GPA_INTERCEPT              0x80000001
+#define HV_MESSAGE_TIMER_EXPIRED              0x80000010
+#define HV_MESSAGE_INVALID_VP_REGISTER_VALUE  0x80000020
+#define HV_MESSAGE_UNRECOVERABLE_EXCEPTION    0x80000021
+#define HV_MESSAGE_UNSUPPORTED_FEATURE        0x80000022
+#define HV_MESSAGE_EVENTLOG_BUFFERCOMPLETE    0x80000040
+#define HV_MESSAGE_X64_IOPORT_INTERCEPT       0x80010000
+#define HV_MESSAGE_X64_MSR_INTERCEPT          0x80010001
+#define HV_MESSAGE_X64_CPUID_INTERCEPT        0x80010002
+#define HV_MESSAGE_X64_EXCEPTION_INTERCEPT    0x80010003
+#define HV_MESSAGE_X64_APIC_EOI               0x80010004
+#define HV_MESSAGE_X64_LEGACY_FP_ERROR        0x80010005
+
+/*
+ * Message flags
+ */
+#define HV_MESSAGE_FLAG_PENDING               0x1
+
+/*
+ * Event flags number per SINT
+ */
+#define HV_EVENT_FLAGS_COUNT                  (256 * 8)
+
+/*
+ * Connection id valid bits
+ */
+#define HV_CONNECTION_ID_MASK                 0x00ffffff
+
+/*
+ * Input structure for POST_MESSAGE hypercall
+ */
+struct hyperv_post_message_input {
+    uint32_t connection_id;
+    uint32_t _reserved;
+    uint32_t message_type;
+    uint32_t payload_size;
+    uint8_t  payload[HV_MESSAGE_PAYLOAD_SIZE];
+};
+
+/*
+ * Input structure for SIGNAL_EVENT hypercall
+ */
+struct hyperv_signal_event_input {
+    uint32_t connection_id;
+    uint16_t flag_number;
+    uint16_t _reserved_zero;
+};
+
+/*
+ * SynIC message structures
+ */
+struct hyperv_message_header {
+    uint32_t message_type;
+    uint8_t  payload_size;
+    uint8_t  message_flags; /* HV_MESSAGE_FLAG_XX */
+    uint8_t  _reserved[2];
+    uint64_t sender;
+};
+
+struct hyperv_message {
+    struct hyperv_message_header header;
+    uint8_t payload[HV_MESSAGE_PAYLOAD_SIZE];
+};
+
+struct hyperv_message_page {
+    struct hyperv_message slot[HV_SINT_COUNT];
+};
+
+/*
+ * SynIC event flags structures
+ */
+struct hyperv_event_flags {
+    DECLARE_BITMAP(flags, HV_EVENT_FLAGS_COUNT);
+};
+
+struct hyperv_event_flags_page {
+    struct hyperv_event_flags slot[HV_SINT_COUNT];
+};
+
+#endif
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b2b1d20..631c14d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3812,12 +3812,12 @@ static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
     CPUX86State *env = &cpu->env;
     GuestPanicInformation *panic_info = NULL;
 
-    if (env->features[FEAT_HYPERV_EDX] & HV_X64_GUEST_CRASH_MSR_AVAILABLE) {
+    if (env->features[FEAT_HYPERV_EDX] & HV_GUEST_CRASH_MSR_AVAILABLE) {
         panic_info = g_malloc0(sizeof(GuestPanicInformation));
 
         panic_info->type = GUEST_PANIC_INFORMATION_TYPE_HYPER_V;
 
-        assert(HV_X64_MSR_CRASH_PARAMS >= 5);
+        assert(HV_CRASH_PARAMS >= 5);
         panic_info->u.hyper_v.arg1 = env->msr_hv_crash_params[0];
         panic_info->u.hyper_v.arg2 = env->msr_hv_crash_params[1];
         panic_info->u.hyper_v.arg3 = env->msr_hv_crash_params[2];
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 8545574..227185c 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "hyperv.h"
-#include "standard-headers/asm-x86/hyperv.h"
+#include "hyperv_proto.h"
 
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
 {
@@ -50,8 +50,8 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
 
         code  = exit->u.hcall.input & 0xffff;
         switch (code) {
-        case HVCALL_POST_MESSAGE:
-        case HVCALL_SIGNAL_EVENT:
+        case HV_POST_MESSAGE:
+        case HV_SIGNAL_EVENT:
         default:
             exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
             return 0;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ee36502..1c619dc 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -27,6 +27,7 @@
 #include "sysemu/kvm_int.h"
 #include "kvm_i386.h"
 #include "hyperv.h"
+#include "hyperv_proto.h"
 
 #include "exec/gdbstub.h"
 #include "qemu/host-utils.h"
@@ -40,7 +41,6 @@
 #include "hw/i386/x86-iommu.h"
 
 #include "exec/ioport.h"
-#include "standard-headers/asm-x86/hyperv.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
@@ -622,29 +622,29 @@ static int hyperv_handle_properties(CPUState *cs)
     }
 
     if (cpu->hyperv_relaxed_timing) {
-        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_HYPERCALL_AVAILABLE;
+        env->features[FEAT_HYPERV_EAX] |= HV_HYPERCALL_AVAILABLE;
     }
     if (cpu->hyperv_vapic) {
-        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_HYPERCALL_AVAILABLE;
-        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_APIC_ACCESS_AVAILABLE;
+        env->features[FEAT_HYPERV_EAX] |= HV_HYPERCALL_AVAILABLE;
+        env->features[FEAT_HYPERV_EAX] |= HV_APIC_ACCESS_AVAILABLE;
     }
     if (cpu->hyperv_time) {
-        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_HYPERCALL_AVAILABLE;
-        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_TIME_REF_COUNT_AVAILABLE;
-        env->features[FEAT_HYPERV_EAX] |= 0x200;
+        env->features[FEAT_HYPERV_EAX] |= HV_HYPERCALL_AVAILABLE;
+        env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
+        env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
     }
     if (cpu->hyperv_crash && has_msr_hv_crash) {
-        env->features[FEAT_HYPERV_EDX] |= HV_X64_GUEST_CRASH_MSR_AVAILABLE;
+        env->features[FEAT_HYPERV_EDX] |= HV_GUEST_CRASH_MSR_AVAILABLE;
     }
-    env->features[FEAT_HYPERV_EDX] |= HV_X64_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
+    env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
     if (cpu->hyperv_reset && has_msr_hv_reset) {
-        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_RESET_AVAILABLE;
+        env->features[FEAT_HYPERV_EAX] |= HV_RESET_AVAILABLE;
     }
     if (cpu->hyperv_vpindex && has_msr_hv_vpindex) {
-        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_VP_INDEX_AVAILABLE;
+        env->features[FEAT_HYPERV_EAX] |= HV_VP_INDEX_AVAILABLE;
     }
     if (cpu->hyperv_runtime && has_msr_hv_runtime) {
-        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_VP_RUNTIME_AVAILABLE;
+        env->features[FEAT_HYPERV_EAX] |= HV_VP_RUNTIME_AVAILABLE;
     }
     if (cpu->hyperv_synic) {
         int sint;
@@ -655,10 +655,10 @@ static int hyperv_handle_properties(CPUState *cs)
             return -ENOSYS;
         }
 
-        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_SYNIC_AVAILABLE;
-        env->msr_hv_synic_version = HV_SYNIC_VERSION_1;
+        env->features[FEAT_HYPERV_EAX] |= HV_SYNIC_AVAILABLE;
+        env->msr_hv_synic_version = HV_SYNIC_VERSION;
         for (sint = 0; sint < ARRAY_SIZE(env->msr_hv_synic_sint); sint++) {
-            env->msr_hv_synic_sint[sint] = HV_SYNIC_SINT_MASKED;
+            env->msr_hv_synic_sint[sint] = HV_SINT_MASKED;
         }
     }
     if (cpu->hyperv_stimer) {
@@ -666,7 +666,7 @@ static int hyperv_handle_properties(CPUState *cs)
             fprintf(stderr, "Hyper-V timers aren't supported by kernel\n");
             return -ENOSYS;
         }
-        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_SYNTIMER_AVAILABLE;
+        env->features[FEAT_HYPERV_EAX] |= HV_SYNTIMERS_AVAILABLE;
     }
     return 0;
 }
@@ -698,7 +698,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     /* Paravirtualization CPUIDs */
     if (hyperv_enabled(cpu)) {
         c = &cpuid_data.entries[cpuid_i++];
-        c->function = HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
+        c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
         if (!cpu->hyperv_vendor_id) {
             memcpy(signature, "Microsoft Hv", 12);
         } else {
@@ -711,13 +711,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
             memset(signature, 0, 12);
             memcpy(signature, cpu->hyperv_vendor_id, len);
         }
-        c->eax = HYPERV_CPUID_MIN;
+        c->eax = HV_CPUID_MIN;
         c->ebx = signature[0];
         c->ecx = signature[1];
         c->edx = signature[2];
 
         c = &cpuid_data.entries[cpuid_i++];
-        c->function = HYPERV_CPUID_INTERFACE;
+        c->function = HV_CPUID_INTERFACE;
         memcpy(signature, "Hv#1\0\0\0\0\0\0\0\0", 12);
         c->eax = signature[0];
         c->ebx = 0;
@@ -725,12 +725,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
         c->edx = 0;
 
         c = &cpuid_data.entries[cpuid_i++];
-        c->function = HYPERV_CPUID_VERSION;
+        c->function = HV_CPUID_VERSION;
         c->eax = 0x00001bbc;
         c->ebx = 0x00060001;
 
         c = &cpuid_data.entries[cpuid_i++];
-        c->function = HYPERV_CPUID_FEATURES;
+        c->function = HV_CPUID_FEATURES;
         r = hyperv_handle_properties(cs);
         if (r) {
             return r;
@@ -740,17 +740,17 @@ int kvm_arch_init_vcpu(CPUState *cs)
         c->edx = env->features[FEAT_HYPERV_EDX];
 
         c = &cpuid_data.entries[cpuid_i++];
-        c->function = HYPERV_CPUID_ENLIGHTMENT_INFO;
+        c->function = HV_CPUID_ENLIGHTMENT_INFO;
         if (cpu->hyperv_relaxed_timing) {
-            c->eax |= HV_X64_RELAXED_TIMING_RECOMMENDED;
+            c->eax |= HV_RELAXED_TIMING_RECOMMENDED;
         }
         if (cpu->hyperv_vapic) {
-            c->eax |= HV_X64_APIC_ACCESS_RECOMMENDED;
+            c->eax |= HV_APIC_ACCESS_RECOMMENDED;
         }
         c->ebx = cpu->hyperv_spinlock_attempts;
 
         c = &cpuid_data.entries[cpuid_i++];
-        c->function = HYPERV_CPUID_IMPLEMENT_LIMITS;
+        c->function = HV_CPUID_IMPLEMENT_LIMITS;
         c->eax = 0x40;
         c->ebx = 0x40;
 
@@ -1734,12 +1734,11 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         if (has_msr_hv_crash) {
             int j;
 
-            for (j = 0; j < HV_X64_MSR_CRASH_PARAMS; j++)
+            for (j = 0; j < HV_CRASH_PARAMS; j++)
                 kvm_msr_entry_add(cpu, HV_X64_MSR_CRASH_P0 + j,
                                   env->msr_hv_crash_params[j]);
 
-            kvm_msr_entry_add(cpu, HV_X64_MSR_CRASH_CTL,
-                              HV_X64_MSR_CRASH_CTL_NOTIFY);
+            kvm_msr_entry_add(cpu, HV_X64_MSR_CRASH_CTL, HV_CRASH_CTL_NOTIFY);
         }
         if (has_msr_hv_runtime) {
             kvm_msr_entry_add(cpu, HV_X64_MSR_VP_RUNTIME, env->msr_hv_runtime);
@@ -2144,7 +2143,7 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (has_msr_hv_crash) {
         int j;
 
-        for (j = 0; j < HV_X64_MSR_CRASH_PARAMS; j++) {
+        for (j = 0; j < HV_CRASH_PARAMS; j++) {
             kvm_msr_entry_add(cpu, HV_X64_MSR_CRASH_P0 + j, 0);
         }
     }
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 8c7a822..ded5e34 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -566,7 +566,7 @@ static bool hyperv_crash_enable_needed(void *opaque)
     CPUX86State *env = &cpu->env;
     int i;
 
-    for (i = 0; i < HV_X64_MSR_CRASH_PARAMS; i++) {
+    for (i = 0; i < HV_CRASH_PARAMS; i++) {
         if (env->msr_hv_crash_params[i]) {
             return true;
         }
@@ -580,8 +580,7 @@ static const VMStateDescription vmstate_msr_hyperv_crash = {
     .minimum_version_id = 1,
     .needed = hyperv_crash_enable_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT64_ARRAY(env.msr_hv_crash_params,
-                             X86CPU, HV_X64_MSR_CRASH_PARAMS),
+        VMSTATE_UINT64_ARRAY(env.msr_hv_crash_params, X86CPU, HV_CRASH_PARAMS),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -639,8 +638,7 @@ static const VMStateDescription vmstate_msr_hyperv_synic = {
         VMSTATE_UINT64(env.msr_hv_synic_control, X86CPU),
         VMSTATE_UINT64(env.msr_hv_synic_evt_page, X86CPU),
         VMSTATE_UINT64(env.msr_hv_synic_msg_page, X86CPU),
-        VMSTATE_UINT64_ARRAY(env.msr_hv_synic_sint, X86CPU,
-                             HV_SYNIC_SINT_COUNT),
+        VMSTATE_UINT64_ARRAY(env.msr_hv_synic_sint, X86CPU, HV_SINT_COUNT),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -665,10 +663,9 @@ static const VMStateDescription vmstate_msr_hyperv_stimer = {
     .minimum_version_id = 1,
     .needed = hyperv_stimer_enable_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT64_ARRAY(env.msr_hv_stimer_config,
-                             X86CPU, HV_SYNIC_STIMER_COUNT),
-        VMSTATE_UINT64_ARRAY(env.msr_hv_stimer_count,
-                             X86CPU, HV_SYNIC_STIMER_COUNT),
+        VMSTATE_UINT64_ARRAY(env.msr_hv_stimer_config, X86CPU,
+                             HV_STIMER_COUNT),
+        VMSTATE_UINT64_ARRAY(env.msr_hv_stimer_count, X86CPU, HV_STIMER_COUNT),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.9.4
