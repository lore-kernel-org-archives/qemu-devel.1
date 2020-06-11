Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A919EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D25720720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cyWq9nbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D25720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTp8-0004Eh-NE
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAA-0001QV-2x
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57275
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTA7-0001M9-NY
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eOCmrAmGxQCiphXmXYzrnQMo7oAMTlydx7QpNksXJw0=;
 b=cyWq9nbEm7XMnvZakHwchi5cRv7rGK3ImBZK2Ji0gDiKzV17i6Wab1PadG482KdM2i5G1P
 +U6Yk+svcOpfOdMgn4vgjT9qR7jteCHkzFOFMAQg9JBmh+yJr/6IL3JufeHUo9QxLbjmSg
 oFSYp71Xr2FCkbL7/y0F++BuGYOUrmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-Sff3GHm-NzWV7pti8d8OLw-1; Thu, 11 Jun 2020 15:46:53 -0400
X-MC-Unique: Sff3GHm-NzWV7pti8d8OLw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16E4C91165;
 Thu, 11 Jun 2020 19:46:48 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F45860CC0;
 Thu, 11 Jun 2020 19:46:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 075/115] target/i386: define a new MSR based feature word -
 FEAT_PERF_CAPABILITIES
Date: Thu, 11 Jun 2020 15:44:09 -0400
Message-Id: <20200611194449.31468-76-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Like Xu <like.xu@linux.intel.com>

The Perfmon and Debug Capability MSR named IA32_PERF_CAPABILITIES is
a feature-enumerating MSR, which only enumerates the feature full-width
write (via bit 13) by now which indicates the processor supports IA32_A_PMCx
interface for updating bits 32 and above of IA32_PMCx.

The existence of MSR IA32_PERF_CAPABILITIES is enumerated by CPUID.1:ECX[15].

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org
Signed-off-by: Like Xu <like.xu@linux.intel.com>
Message-Id: <20200529074347.124619-5-like.xu@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 23 +++++++++++++++++++++++
 target/i386/cpu.h |  3 +++
 target/i386/kvm.c | 20 ++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e89d9fa894..2d3b8d5dea 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1139,6 +1139,22 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .index = MSR_IA32_CORE_CAPABILITY,
         },
     },
+    [FEAT_PERF_CAPABILITIES] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, "full-width-write", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_PERF_CAPABILITIES,
+        },
+    },
 
     [FEAT_VMX_PROCBASED_CTLS] = {
         .type = MSR_FEATURE_WORD,
@@ -1316,6 +1332,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_CORE_CAPABILITY },
         .to = { FEAT_CORE_CAPABILITY,       ~0ull },
     },
+    {
+        .from = { FEAT_1_ECX,             CPUID_EXT_PDCM },
+        .to = { FEAT_PERF_CAPABILITIES,       ~0ull },
+    },
     {
         .from = { FEAT_1_ECX,               CPUID_EXT_VMX },
         .to = { FEAT_VMX_PROCBASED_CTLS,    ~0ull },
@@ -5488,6 +5508,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
             *edx |= CPUID_HT;
         }
+        if (!cpu->enable_pmu) {
+            *ecx &= ~CPUID_EXT_PDCM;
+        }
         break;
     case 2:
         /* cache info: needed for Pentium Pro compatibility */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 100476ee89..c2b8bdcbde 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -356,6 +356,8 @@ typedef enum X86Seg {
 #define MSR_IA32_ARCH_CAPABILITIES      0x10a
 #define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
 
+#define MSR_IA32_PERF_CAPABILITIES      0x345
+
 #define MSR_IA32_TSX_CTRL		0x122
 #define MSR_IA32_TSCDEADLINE            0x6e0
 
@@ -529,6 +531,7 @@ typedef enum FeatureWord {
     FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
     FEAT_ARCH_CAPABILITIES,
     FEAT_CORE_CAPABILITY,
+    FEAT_PERF_CAPABILITIES,
     FEAT_VMX_PROCBASED_CTLS,
     FEAT_VMX_SECONDARY_CTLS,
     FEAT_VMX_PINBASED_CTLS,
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ef2e0a81dd..b3c13cb898 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -110,6 +110,7 @@ static bool has_msr_core_capabs;
 static bool has_msr_vmx_vmfunc;
 static bool has_msr_ucode_rev;
 static bool has_msr_vmx_procbased_ctls2;
+static bool has_msr_perf_capabs;
 
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -2033,6 +2034,9 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_CORE_CAPABILITY:
                 has_msr_core_capabs = true;
                 break;
+            case MSR_IA32_PERF_CAPABILITIES:
+                has_msr_perf_capabs = true;
+                break;
             case MSR_IA32_VMX_VMFUNC:
                 has_msr_vmx_vmfunc = true;
                 break;
@@ -2649,6 +2653,18 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
                       VMCS12_MAX_FIELD_INDEX << 1);
 }
 
+static void kvm_msr_entry_add_perf(X86CPU *cpu, FeatureWordArray f)
+{
+    uint64_t kvm_perf_cap =
+        kvm_arch_get_supported_msr_feature(kvm_state,
+                                           MSR_IA32_PERF_CAPABILITIES);
+
+    if (kvm_perf_cap) {
+        kvm_msr_entry_add(cpu, MSR_IA32_PERF_CAPABILITIES,
+                        kvm_perf_cap & f[FEAT_PERF_CAPABILITIES]);
+    }
+}
+
 static int kvm_buf_set_msrs(X86CPU *cpu)
 {
     int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, cpu->kvm_msr_buf);
@@ -2681,6 +2697,10 @@ static void kvm_init_msrs(X86CPU *cpu)
                           env->features[FEAT_CORE_CAPABILITY]);
     }
 
+    if (has_msr_perf_capabs && cpu->enable_pmu) {
+        kvm_msr_entry_add_perf(cpu, env->features);
+    }
+
     if (has_msr_ucode_rev) {
         kvm_msr_entry_add(cpu, MSR_IA32_UCODE_REV, cpu->ucode_rev);
     }
-- 
2.26.2



