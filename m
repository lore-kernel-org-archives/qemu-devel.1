Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DAFC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 02:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37C82073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 02:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37C82073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA2dU-0006vB-06
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 21:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luwei.kang@intel.com>) id 1jA2cW-0005KY-LJ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 21:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luwei.kang@intel.com>) id 1jA2cV-0003Qj-0j
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 21:21:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:23298)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luwei.kang@intel.com>)
 id 1jA2cU-0003OY-NI
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 21:21:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Mar 2020 18:21:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,520,1574150400"; d="scan'208";a="413742198"
Received: from snr.bj.intel.com ([10.240.193.90])
 by orsmga005.jf.intel.com with ESMTP; 05 Mar 2020 18:21:42 -0800
From: Luwei Kang <luwei.kang@intel.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Subject: [PATCH v1 2/3] i386: Add support for save/load PEBS MSRs
Date: Fri,  6 Mar 2020 18:20:04 +0800
Message-Id: <1583490005-27761-3-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583490005-27761-1-git-send-email-luwei.kang@intel.com>
References: <1583490005-27761-1-git-send-email-luwei.kang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Luwei Kang <luwei.kang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PEBS feature virtualization required IA32_PEBS_ENABLE and
DS_AREA MSRs. This patch is to add the support of these MSRs
saved/loaded in guest.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 target/i386/cpu.h     |  6 ++++++
 target/i386/kvm.c     | 29 +++++++++++++++++++++++++++++
 target/i386/machine.c | 25 +++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 398810f..872a495 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -412,6 +412,9 @@ typedef enum X86Seg {
 #define MSR_CORE_PERF_GLOBAL_CTRL       0x38f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL   0x390
 
+#define MSR_IA32_PEBS_ENABLE            0x3f1
+#define MSR_IA32_DS_AREA                0x600
+
 #define MSR_MC0_CTL                     0x400
 #define MSR_MC0_STATUS                  0x401
 #define MSR_MC0_ADDR                    0x402
@@ -1444,6 +1447,9 @@ typedef struct CPUX86State {
     uint64_t msr_gp_counters[MAX_GP_COUNTERS];
     uint64_t msr_gp_evtsel[MAX_GP_COUNTERS];
 
+    uint64_t msr_pebs_enable;
+    uint64_t msr_ds_area;
+
     uint64_t pat;
     uint32_t smbase;
     uint64_t msr_smi_count;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index bfd09bd..1043961 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -102,6 +102,8 @@ static bool has_msr_smi_count;
 static bool has_msr_arch_capabs;
 static bool has_msr_core_capabs;
 static bool has_msr_vmx_vmfunc;
+static bool has_msr_pebs_enable;
+static bool has_msr_ds_area;
 
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -2048,6 +2050,12 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_VMX_VMFUNC:
                 has_msr_vmx_vmfunc = true;
                 break;
+            case MSR_IA32_PEBS_ENABLE:
+                has_msr_pebs_enable = true;
+                break;
+            case MSR_IA32_DS_AREA:
+                has_msr_ds_area = true;
+                break;
             }
         }
     }
@@ -2770,7 +2778,16 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL,
                                   env->msr_global_ctrl);
             }
+            if (has_msr_pebs_enable) {
+                kvm_msr_entry_add(cpu, MSR_IA32_PEBS_ENABLE,
+                                  env->msr_pebs_enable);
+            }
+            if (has_msr_ds_area) {
+                kvm_msr_entry_add(cpu, MSR_IA32_DS_AREA,
+                                  env->msr_ds_area);
+            }
         }
+
         /*
          * Hyper-V partition-wide MSRs: to avoid clearing them on cpu hot-add,
          * only sync them to KVM on the first cpu
@@ -3154,6 +3171,12 @@ static int kvm_get_msrs(X86CPU *cpu)
             kvm_msr_entry_add(cpu, MSR_P6_PERFCTR0 + i, 0);
             kvm_msr_entry_add(cpu, MSR_P6_EVNTSEL0 + i, 0);
         }
+        if (has_msr_pebs_enable) {
+            kvm_msr_entry_add(cpu, MSR_IA32_PEBS_ENABLE, 0);
+        }
+        if (has_msr_ds_area) {
+            kvm_msr_entry_add(cpu, MSR_IA32_DS_AREA, 0);
+        }
     }
 
     if (env->mcg_cap) {
@@ -3402,6 +3425,12 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
             env->msr_gp_evtsel[index - MSR_P6_EVNTSEL0] = msrs[i].data;
             break;
+        case MSR_IA32_PEBS_ENABLE:
+            env->msr_pebs_enable = msrs[i].data;
+            break;
+        case MSR_IA32_DS_AREA:
+            env->msr_ds_area = msrs[i].data;
+            break;
         case HV_X64_MSR_HYPERCALL:
             env->msr_hv_hypercall = msrs[i].data;
             break;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 6481f84..82a2101 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -646,6 +646,30 @@ static const VMStateDescription vmstate_msr_architectural_pmu = {
     }
 };
 
+static bool pebs_via_ds_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    if (env->msr_pebs_enable || env->msr_ds_area) {
+        return true;
+    }
+
+    return false;
+}
+
+static const VMStateDescription vmstate_msr_pebs_via_ds = {
+    .name = "cpu/msr_pebs_via_ds",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pebs_via_ds_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.msr_pebs_enable, X86CPU),
+        VMSTATE_UINT64(env.msr_ds_area, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool mpx_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -1399,6 +1423,7 @@ VMStateDescription vmstate_x86_cpu = {
         &vmstate_msr_ia32_misc_enable,
         &vmstate_msr_ia32_feature_control,
         &vmstate_msr_architectural_pmu,
+        &vmstate_msr_pebs_via_ds,
         &vmstate_mpx,
         &vmstate_msr_hypercall_hypercall,
         &vmstate_msr_hyperv_vapic,
-- 
1.8.3.1


