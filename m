Received: from eggs.gnu.org ([2001:4830:134:3::10]:34324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cthDE-0004ZF-Hy
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 17:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cthDA-0002Iu-Gp
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 17:02:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cthDA-0002IQ-8v
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 17:02:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A73E80464
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 21:02:27 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 30 Mar 2017 18:01:05 -0300
Message-Id: <20170330210105.32434-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RHEL-7.4 qemu-kvm PATCH] target-i386: get/set/migrate
 XSAVES state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>, plai@redhat.com

From: Wanpeng Li <wanpeng.li@linux.intel.com>

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1327593
Brew: https://brewweb.engineering.redhat.com/brew/taskinfo?taskID=12913269

Add xsaves related definition, it also adds corresponding part
to kvm_get/put, and vmstate.

Backport notes:
* As we didn't have unmigratable_flags yet, our backport
  of upstream commit 0bb0b2d2fe7f645ddaf1f0ff40ac669c9feb4aa1
  (commit 5fcaf5176d7545518c76f3aa8ea7ce6fb063c62d) didn't
  include "xsaves" cpuid_xsave_feature_name[]. This patch now
  adds "xsave" to cpuid_xsave_feature_name[].

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 18cd2c17b5370369a886155c001da0a7f54bbcca)
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target-i386/cpu.h     |  2 ++
 target-i386/cpu.c     |  2 +-
 target-i386/kvm.c     | 15 +++++++++++++++
 target-i386/machine.c | 21 +++++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/target-i386/cpu.h b/target-i386/cpu.h
index f04deb411d..ac60309b25 100644
--- a/target-i386/cpu.h
+++ b/target-i386/cpu.h
@@ -384,6 +384,7 @@
 #define MSR_VM_HSAVE_PA                 0xc0010117
 
 #define MSR_IA32_BNDCFGS                0x00000d90
+#define MSR_IA32_XSS                    0x00000da0
 
 #define XSTATE_FP                       (1ULL << 0)
 #define XSTATE_SSE                      (1ULL << 1)
@@ -1026,6 +1027,7 @@ typedef struct CPUX86State {
     uint64_t xstate_bv;
 
     uint64_t xcr0;
+    uint64_t xss;
 
     TPRAccess tpr_access_type;
 } CPUX86State;
diff --git a/target-i386/cpu.c b/target-i386/cpu.c
index 33f0997c49..ae56995beb 100644
--- a/target-i386/cpu.c
+++ b/target-i386/cpu.c
@@ -177,7 +177,7 @@ static const char *cpuid_7_0_edx_feature_name[] = {
 };
 
 static const char *cpuid_xsave_feature_name[] = {
-    "xsaveopt", "xsavec", "xgetbv1", NULL,
+    "xsaveopt", "xsavec", "xgetbv1", "xsaves",
     NULL, NULL, NULL, NULL,
     NULL, NULL, NULL, NULL,
     NULL, NULL, NULL, NULL,
diff --git a/target-i386/kvm.c b/target-i386/kvm.c
index e1b0ca2f6d..6a479f46c3 100644
--- a/target-i386/kvm.c
+++ b/target-i386/kvm.c
@@ -76,6 +76,7 @@ static bool has_msr_hv_hypercall;
 static bool has_msr_hv_vapic;
 static bool has_msr_hv_tsc;
 static bool has_msr_mtrr;
+static bool has_msr_xss;
 
 static bool has_msr_architectural_pmu;
 static uint32_t num_architectural_pmu_counters;
@@ -795,6 +796,10 @@ static int kvm_get_supported_msrs(KVMState *s)
                     has_msr_bndcfgs = true;
                     continue;
                 }
+                if (kvm_msr_list->indices[i] == MSR_IA32_XSS) {
+                    has_msr_xss = true;
+                    continue;
+                }
             }
         }
 
@@ -1177,6 +1182,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     if (has_msr_bndcfgs) {
         kvm_msr_entry_set(&msrs[n++], MSR_IA32_BNDCFGS, env->msr_bndcfgs);
     }
+    if (has_msr_xss) {
+        kvm_msr_entry_set(&msrs[n++], MSR_IA32_XSS, env->xss);
+    }
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
         kvm_msr_entry_set(&msrs[n++], MSR_CSTAR, env->cstar);
@@ -1530,6 +1538,10 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (has_msr_bndcfgs) {
         msrs[n++].index = MSR_IA32_BNDCFGS;
     }
+    if (has_msr_xss) {
+        msrs[n++].index = MSR_IA32_XSS;
+    }
+
 
     if (!env->tsc_valid) {
         msrs[n++].index = MSR_IA32_TSC;
@@ -1677,6 +1689,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_BNDCFGS:
             env->msr_bndcfgs = msrs[i].data;
             break;
+        case MSR_IA32_XSS:
+            env->xss = msrs[i].data;
+            break;
         default:
             if (msrs[i].index >= MSR_MC0_CTL &&
                 msrs[i].index < MSR_MC0_CTL + (env->mcg_cap & 0xff) * 4) {
diff --git a/target-i386/machine.c b/target-i386/machine.c
index 2c970024ac..ce7fcd3996 100644
--- a/target-i386/machine.c
+++ b/target-i386/machine.c
@@ -704,6 +704,24 @@ static const VMStateDescription vmstate_avx512 = {
     }
 };
 
+static bool xss_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->xss != 0;
+}
+
+static const VMStateDescription vmstate_xss = {
+    .name = "cpu/xss",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.xss, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
@@ -850,6 +868,9 @@ const VMStateDescription vmstate_x86_cpu = {
         }, {
             .vmsd = &vmstate_avx512,
             .needed = avx512_needed,
+         }, {
+            .vmsd = &vmstate_xss,
+            .needed = xss_needed,
         } , {
             /* empty */
         }
-- 
2.11.0.259.g40922b1
