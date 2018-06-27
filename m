Received: from eggs.gnu.org ([2001:4830:134:3::10]:56263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fY8bp-0005oa-0T
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fY8bk-0007yH-Id
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:27:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:32714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fY8bk-0007vT-7U
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:27:32 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Wed, 27 Jun 2018 19:27:20 +0800
Message-Id: <1530098844-236851-2-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 1/5] i386: Add support for IA32_PRED_CMD and
 IA32_ARCH_CAPABILITIES MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: robert.hu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

IA32_PRED_CMD MSR gives software a way to issue commands that affect the state
of indirect branch predictors. Enumerated by CPUID.(EAX=7H,ECX=0):EDX[26].
IA32_ARCH_CAPABILITIES MSR enumerates architectural features of RDCL_NO and
IBRS_ALL. Enumerated by CPUID.(EAX=07H, ECX=0):EDX[29].

https://software.intel.com/sites/default/files/managed/c5/63/336996-Speculative-Execution-Side-Channel-Mitigations.pdf

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 target/i386/cpu.h |  4 ++++
 target/i386/kvm.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 89c82be..734a73e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -352,6 +352,8 @@ typedef enum X86Seg {
 #define MSR_TSC_ADJUST                  0x0000003b
 #define MSR_IA32_SPEC_CTRL              0x48
 #define MSR_VIRT_SSBD                   0xc001011f
+#define MSR_IA32_PRED_CMD               0x49
+#define MSR_IA32_ARCH_CAPABILITIES      0x10a
 #define MSR_IA32_TSCDEADLINE            0x6e0
 
 #define FEATURE_CONTROL_LOCKED                    (1<<0)
@@ -1210,6 +1212,8 @@ typedef struct CPUX86State {
 
     uint64_t spec_ctrl;
     uint64_t virt_ssbd;
+    uint64_t pred_cmd;
+    uint64_t arch_capabilities;
 
     /* End of state preserved by INIT (dummy marker).  */
     struct {} end_init_save;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 2d174f3..3aab182 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -93,6 +93,8 @@ static bool has_msr_hv_reenlightenment;
 static bool has_msr_xss;
 static bool has_msr_spec_ctrl;
 static bool has_msr_virt_ssbd;
+static bool has_msr_pred_cmd;
+static bool has_msr_arch_capabilities;
 static bool has_msr_smi_count;
 
 static uint32_t has_architectural_pmu_version;
@@ -1265,6 +1267,11 @@ static int kvm_get_supported_msrs(KVMState *s)
                     break;
                 case MSR_VIRT_SSBD:
                     has_msr_virt_ssbd = true;
+                case MSR_IA32_PRED_CMD:
+                    has_msr_pred_cmd = true;
+                    break;
+                case MSR_IA32_ARCH_CAPABILITIES:
+                    has_msr_arch_capabilities = true;
                     break;
                 }
             }
@@ -1757,7 +1764,13 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     if (has_msr_virt_ssbd) {
         kvm_msr_entry_add(cpu, MSR_VIRT_SSBD, env->virt_ssbd);
     }
-
+    if (has_msr_pred_cmd) {
+        kvm_msr_entry_add(cpu, MSR_IA32_PRED_CMD, env->pred_cmd);
+    }
+    if (has_msr_arch_capabilities) {
+        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
+            env->arch_capabilities);
+    }
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
         kvm_msr_entry_add(cpu, MSR_CSTAR, env->cstar);
@@ -2140,6 +2153,13 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (has_msr_virt_ssbd) {
         kvm_msr_entry_add(cpu, MSR_VIRT_SSBD, 0);
     }
+    if (has_msr_pred_cmd) {
+        kvm_msr_entry_add(cpu, MSR_IA32_PRED_CMD, 0);
+    }
+    if (has_msr_arch_capabilities) {
+        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES, 0);
+    }
+
     if (!env->tsc_valid) {
         kvm_msr_entry_add(cpu, MSR_IA32_TSC, 0);
         env->tsc_valid = !runstate_is_running();
@@ -2521,6 +2541,11 @@ static int kvm_get_msrs(X86CPU *cpu)
             break;
         case MSR_VIRT_SSBD:
             env->virt_ssbd = msrs[i].data;
+        case MSR_IA32_PRED_CMD:
+            env->pred_cmd = msrs[i].data;
+            break;
+        case MSR_IA32_ARCH_CAPABILITIES:
+            env->arch_capabilities = msrs[i].data;
             break;
         case MSR_IA32_RTIT_CTL:
             env->msr_rtit_ctrl = msrs[i].data;
-- 
1.8.3.1
