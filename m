Received: from eggs.gnu.org ([2001:4830:134:3::10]:43106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYw61-0002sm-AE
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:45:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYw60-0003ja-DD
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:45:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eYw60-0003j8-44
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:45:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4012CC070E0E
	for <qemu-devel@nongnu.org>; Tue,  9 Jan 2018 15:45:47 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  9 Jan 2018 13:45:14 -0200
Message-Id: <20180109154519.25634-3-ehabkost@redhat.com>
In-Reply-To: <20180109154519.25634-1-ehabkost@redhat.com>
References: <20180109154519.25634-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/7] i386: Add support for SPEC_CTRL MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h     |  3 +++
 target/i386/kvm.c     | 14 ++++++++++++++
 target/i386/machine.c | 20 ++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 62c4742703..07f47997d6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -353,6 +353,7 @@ typedef enum X86Seg {
 #define MSR_IA32_APICBASE_BASE          (0xfffffU<<12)
 #define MSR_IA32_FEATURE_CONTROL        0x0000003a
 #define MSR_TSC_ADJUST                  0x0000003b
+#define MSR_IA32_SPEC_CTRL              0x48
 #define MSR_IA32_TSCDEADLINE            0x6e0
 
 #define FEATURE_CONTROL_LOCKED                    (1<<0)
@@ -1125,6 +1126,8 @@ typedef struct CPUX86State {
 
     uint32_t pkru;
 
+    uint64_t spec_ctrl;
+
     /* End of state preserved by INIT (dummy marker).  */
     struct {} end_init_save;
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6f69e2fcfd..7afce330be 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -91,6 +91,7 @@ static bool has_msr_hv_synic;
 static bool has_msr_hv_stimer;
 static bool has_msr_hv_frequencies;
 static bool has_msr_xss;
+static bool has_msr_spec_ctrl;
 
 static bool has_msr_architectural_pmu;
 static uint32_t num_architectural_pmu_counters;
@@ -1143,6 +1144,9 @@ static int kvm_get_supported_msrs(KVMState *s)
                 case HV_X64_MSR_TSC_FREQUENCY:
                     has_msr_hv_frequencies = true;
                     break;
+                case MSR_IA32_SPEC_CTRL:
+                    has_msr_spec_ctrl = true;
+                    break;
                 }
             }
         }
@@ -1625,6 +1629,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     if (has_msr_xss) {
         kvm_msr_entry_add(cpu, MSR_IA32_XSS, env->xss);
     }
+    if (has_msr_spec_ctrl) {
+        kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, env->spec_ctrl);
+    }
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
         kvm_msr_entry_add(cpu, MSR_CSTAR, env->cstar);
@@ -1633,6 +1640,7 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         kvm_msr_entry_add(cpu, MSR_LSTAR, env->lstar);
     }
 #endif
+
     /*
      * The following MSRs have side effects on the guest or are too heavy
      * for normal writeback. Limit them to reset or full state updates.
@@ -2004,6 +2012,9 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (has_msr_xss) {
         kvm_msr_entry_add(cpu, MSR_IA32_XSS, 0);
     }
+    if (has_msr_spec_ctrl) {
+        kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, 0);
+    }
 
 
     if (!env->tsc_valid) {
@@ -2349,6 +2360,9 @@ static int kvm_get_msrs(X86CPU *cpu)
                 env->mtrr_var[MSR_MTRRphysIndex(index)].base = msrs[i].data;
             }
             break;
+        case MSR_IA32_SPEC_CTRL:
+            env->spec_ctrl = msrs[i].data;
+            break;
         }
     }
 
diff --git a/target/i386/machine.c b/target/i386/machine.c
index df5ec359eb..361c05aedf 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -818,6 +818,25 @@ static const VMStateDescription vmstate_mcg_ext_ctl = {
     }
 };
 
+static bool spec_ctrl_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->spec_ctrl != 0;
+}
+
+static const VMStateDescription vmstate_spec_ctrl = {
+    .name = "cpu/spec_ctrl",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spec_ctrl_needed,
+    .fields = (VMStateField[]){
+        VMSTATE_UINT64(env.spec_ctrl, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
@@ -936,6 +955,7 @@ VMStateDescription vmstate_x86_cpu = {
 #ifdef TARGET_X86_64
         &vmstate_pkru,
 #endif
+        &vmstate_spec_ctrl,
         &vmstate_mcg_ext_ctl,
         NULL
     }
-- 
2.14.3
