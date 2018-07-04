Received: from eggs.gnu.org ([2001:4830:134:3::10]:54430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fahj0-0006DK-MI
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fahiv-0002bT-Qz
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:21:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:61547)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fahiv-0002ZL-Fr
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:21:33 -0400
From: Jingqi Liu <jingqi.liu@intel.com>
Date: Wed,  4 Jul 2018 21:21:06 +0800
Message-Id: <1530710466-88309-1-git-send-email-jingqi.liu@intel.com>
Subject: [Qemu-devel] [PATCH] i386: Add support to get/set/migrate MSR (33H)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, wei.w.wang@intel.com, Jingqi Liu <jingqi.liu@intel.com>

The MSR (33H) controls support for #AC exception
for split locked accesses. When bit 29 of the MSR (33H)
is set, the processor causes an #AC exception to
be issued instead of suppressing LOCK on bus
(during split lock access).

Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
---
 target/i386/cpu.h     |  2 ++
 target/i386/kvm.c     | 13 +++++++++++++
 target/i386/machine.c | 20 ++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8eaefee..9728552 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -348,6 +348,7 @@ typedef enum X86Seg {
 #define MSR_IA32_APICBASE_ENABLE        (1<<11)
 #define MSR_IA32_APICBASE_EXTD          (1 << 10)
 #define MSR_IA32_APICBASE_BASE          (0xfffffU<<12)
+#define MSR_SPLIT_LOCK_CTRL             0x00000033
 #define MSR_IA32_FEATURE_CONTROL        0x0000003a
 #define MSR_TSC_ADJUST                  0x0000003b
 #define MSR_IA32_SPEC_CTRL              0x48
@@ -1209,6 +1210,7 @@ typedef struct CPUX86State {
     uint32_t pkru;
 
     uint64_t spec_ctrl;
+    uint64_t split_lock_ctrl;
     uint64_t virt_ssbd;
 
     /* End of state preserved by INIT (dummy marker).  */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 032f0ad..043ca9b 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -92,6 +92,7 @@ static bool has_msr_hv_frequencies;
 static bool has_msr_hv_reenlightenment;
 static bool has_msr_xss;
 static bool has_msr_spec_ctrl;
+static bool has_msr_split_lock_ctrl;
 static bool has_msr_virt_ssbd;
 static bool has_msr_smi_count;
 
@@ -1272,6 +1273,9 @@ static int kvm_get_supported_msrs(KVMState *s)
                 case MSR_IA32_SPEC_CTRL:
                     has_msr_spec_ctrl = true;
                     break;
+                case MSR_SPLIT_LOCK_CTRL:
+                    has_msr_split_lock_ctrl = true;
+                    break;
                 case MSR_VIRT_SSBD:
                     has_msr_virt_ssbd = true;
                     break;
@@ -1786,6 +1790,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     if (has_msr_spec_ctrl) {
         kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, env->spec_ctrl);
     }
+    if (has_msr_split_lock_ctrl) {
+        kvm_msr_entry_add(cpu, MSR_SPLIT_LOCK_CTRL, env->split_lock_ctrl);
+    }
     if (has_msr_virt_ssbd) {
         kvm_msr_entry_add(cpu, MSR_VIRT_SSBD, env->virt_ssbd);
     }
@@ -2169,6 +2176,9 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (has_msr_spec_ctrl) {
         kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, 0);
     }
+    if (has_msr_split_lock_ctrl) {
+        kvm_msr_entry_add(cpu, MSR_SPLIT_LOCK_CTRL, 0);
+    }
     if (has_msr_virt_ssbd) {
         kvm_msr_entry_add(cpu, MSR_VIRT_SSBD, 0);
     }
@@ -2551,6 +2561,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_SPEC_CTRL:
             env->spec_ctrl = msrs[i].data;
             break;
+        case MSR_SPLIT_LOCK_CTRL:
+            env->split_lock_ctrl = msrs[i].data;
+            break;
         case MSR_VIRT_SSBD:
             env->virt_ssbd = msrs[i].data;
             break;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 4d98d36..c82dc0d 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -935,6 +935,25 @@ static const VMStateDescription vmstate_msr_virt_ssbd = {
     }
 };
 
+static bool split_lock_ctrl_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->split_lock_ctrl != 0;
+}
+
+static const VMStateDescription vmstate_split_lock_ctrl = {
+    .name = "cpu/split_lock_ctrl",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = split_lock_ctrl_needed,
+    .fields = (VMStateField[]){
+        VMSTATE_UINT64(env.split_lock_ctrl, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
@@ -1059,6 +1078,7 @@ VMStateDescription vmstate_x86_cpu = {
         &vmstate_mcg_ext_ctl,
         &vmstate_msr_intel_pt,
         &vmstate_msr_virt_ssbd,
+        &vmstate_split_lock_ctrl,
         NULL
     }
 };
-- 
1.8.3.1
