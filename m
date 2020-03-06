Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A44C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 02:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF2F207FD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 02:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF2F207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA2eg-0000iE-1Q
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 21:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luwei.kang@intel.com>) id 1jA2cW-0005KW-Lf
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 21:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luwei.kang@intel.com>) id 1jA2cU-0003QW-Vk
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 21:21:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:23297)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luwei.kang@intel.com>)
 id 1jA2cU-0003LI-MX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 21:21:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Mar 2020 18:21:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,520,1574150400"; d="scan'208";a="413742185"
Received: from snr.bj.intel.com ([10.240.193.90])
 by orsmga005.jf.intel.com with ESMTP; 05 Mar 2020 18:21:39 -0800
From: Luwei Kang <luwei.kang@intel.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Subject: [PATCH v1 1/3] i386: Add "pebs" parameter to enable PEBS feature
Date: Fri,  6 Mar 2020 18:20:03 +0800
Message-Id: <1583490005-27761-2-git-send-email-luwei.kang@intel.com>
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

The PEBS virtualization enabling in KVM guest will be supported start from
IceLake hardware. This patch introduce a new CPU parameter "pebs" to enable
PEBS feature. The paramter of "pebs" is false by default.

PDCM,DTES64,DTS are needed by PEBS feature. Expose these feature bits to
KVM guest when the KVM support PEBS virtualization and the "pebs" parameter
is true.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 hw/i386/pc.c      |  1 +
 target/i386/cpu.c | 14 ++++++++++++++
 target/i386/cpu.h |  7 +++++++
 3 files changed, 22 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 96715f8..aeb9fb9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -316,6 +316,7 @@ GlobalProperty pc_compat_1_5[] = {
     { "Nehalem-" TYPE_X86_CPU, "min-level", "2" },
     { "virtio-net-pci", "any_layout", "off" },
     { TYPE_X86_CPU, "pmu", "on" },
+    { TYPE_X86_CPU, "pebs", "on" },
     { "i440FX-pcihost", "short_root_bus", "0" },
     { "q35-pcihost", "short_root_bus", "0" },
 };
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cc586dc..1ca56de 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3306,6 +3306,7 @@ static void max_x86_cpu_initfn(Object *obj)
     }
 
     object_property_set_bool(OBJECT(cpu), true, "pmu", &error_abort);
+    object_property_set_bool(OBJECT(cpu), true, "pebs", &error_abort);
 }
 
 static const TypeInfo max_x86_cpu_type_info = {
@@ -4511,11 +4512,23 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if ((*ecx & CPUID_EXT_XSAVE) && (env->cr[4] & CR4_OSXSAVE_MASK)) {
             *ecx |= CPUID_EXT_OSXSAVE;
         }
+        if (kvm_enabled() && cpu->enable_pmu && cpu->enable_pebs) {
+            *ecx |= kvm_arch_get_supported_cpuid(cs->kvm_state, 0x1, 0, R_ECX) &
+                                            (CPUID_EXT_PDCM | CPUID_EXT_DTES64);
+        } else {
+            *ecx &= ~(CPUID_EXT_PDCM | CPUID_EXT_DTES64);
+        }
         *edx = env->features[FEAT_1_EDX];
         if (cs->nr_cores * cs->nr_threads > 1) {
             *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
             *edx |= CPUID_HT;
         }
+        if (kvm_enabled() && cpu->enable_pmu && cpu->enable_pebs) {
+            *edx |= kvm_arch_get_supported_cpuid(cs->kvm_state, 0x1, 0, R_EDX) &
+                                            CPUID_DTS;
+        } else {
+            *edx &= ~CPUID_DTS;
+        }
         break;
     case 2:
         /* cache info: needed for Pentium Pro compatibility */
@@ -6129,6 +6142,7 @@ static Property x86_cpu_properties[] = {
 #endif
     DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
+    DEFINE_PROP_BOOL("pebs", X86CPU, enable_pebs, false),
 
     DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
                        HYPERV_SPINLOCK_NEVER_RETRY),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5352c9f..398810f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1664,6 +1664,13 @@ struct X86CPU {
      */
     bool enable_pmu;
 
+    /* Enable PEBS CPUID bits. This can't be enabled by default yet because
+     * it doesn't have ABI stability guarantees, as it passes all PEBS CPUID
+     * bits returned by GET_SUPPORTED_CPUID (that depend on host CPU and kernel
+     * capabilities) directly to the guest.
+     */
+    bool enable_pebs;
+
     /* LMCE support can be enabled/disabled via cpu option 'lmce=on/off'. It is
      * disabled by default to avoid breaking migration between QEMU with
      * different LMCE configurations.
-- 
1.8.3.1


