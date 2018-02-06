Received: from eggs.gnu.org ([2001:4830:134:3::10]:43886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ii-0005Ep-B3
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8if-0007ws-2D
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37162
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8ie-0007wL-QR
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:52 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEIvj131038
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:52 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fyfvm6yxg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:51 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:50 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:42 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-22-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 21/54] i386: Add support for SPEC_CTRL MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180109154519.25634-3-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit a33a2cfe2f771b360b3422f6cdf566a560860bfc)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/i386/cpu.h     |  3 +++
 target/i386/kvm.c     | 14 ++++++++++++++
 target/i386/machine.c | 20 ++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b086b1528b..03de74a8d3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -335,6 +335,7 @@
 #define MSR_IA32_APICBASE_BASE          (0xfffffU<<12)
 #define MSR_IA32_FEATURE_CONTROL        0x0000003a
 #define MSR_TSC_ADJUST                  0x0000003b
+#define MSR_IA32_SPEC_CTRL              0x48
 #define MSR_IA32_TSCDEADLINE            0x6e0
 
 #define FEATURE_CONTROL_LOCKED                    (1<<0)
@@ -1082,6 +1083,8 @@ typedef struct CPUX86State {
 
     uint32_t pkru;
 
+    uint64_t spec_ctrl;
+
     /* End of state preserved by INIT (dummy marker).  */
     struct {} end_init_save;
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b1e32e95d3..3ac5302bc5 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -91,6 +91,7 @@ static bool has_msr_hv_synic;
 static bool has_msr_hv_stimer;
 static bool has_msr_hv_frequencies;
 static bool has_msr_xss;
+static bool has_msr_spec_ctrl;
 
 static bool has_msr_architectural_pmu;
 static uint32_t num_architectural_pmu_counters;
@@ -1144,6 +1145,9 @@ static int kvm_get_supported_msrs(KVMState *s)
                 case HV_X64_MSR_TSC_FREQUENCY:
                     has_msr_hv_frequencies = true;
                     break;
+                case MSR_IA32_SPEC_CTRL:
+                    has_msr_spec_ctrl = true;
+                    break;
                 }
             }
         }
@@ -1626,6 +1630,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     if (has_msr_xss) {
         kvm_msr_entry_add(cpu, MSR_IA32_XSS, env->xss);
     }
+    if (has_msr_spec_ctrl) {
+        kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, env->spec_ctrl);
+    }
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
         kvm_msr_entry_add(cpu, MSR_CSTAR, env->cstar);
@@ -1634,6 +1641,7 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         kvm_msr_entry_add(cpu, MSR_LSTAR, env->lstar);
     }
 #endif
+
     /*
      * The following MSRs have side effects on the guest or are too heavy
      * for normal writeback. Limit them to reset or full state updates.
@@ -1998,6 +2006,9 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (has_msr_xss) {
         kvm_msr_entry_add(cpu, MSR_IA32_XSS, 0);
     }
+    if (has_msr_spec_ctrl) {
+        kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, 0);
+    }
 
 
     if (!env->tsc_valid) {
@@ -2347,6 +2358,9 @@ static int kvm_get_msrs(X86CPU *cpu)
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
2.11.0
