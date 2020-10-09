Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9FDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A81206BE
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eF18ksxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A81206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQreF-0001xR-Dy
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMr-00005k-LI
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMn-0007xs-5Q
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602245957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+64Vsvz3fwBAqJhY6+9UhKzkneu2g8ObPvxXx1Wpa28=;
 b=eF18ksxm+0S7OfEYOZqT5P97e9bozY0KrdXauB82p0fbAd3i4GBWzuLDaJ79uiMGZ42TlK
 +ro1u2/V2iYZqIXj6z4nZbi7bZ/L2plUlpZ3ybW9CZSA1NXVW4EXi8jO6xk9dTmNKzA4Eh
 5GhBGUDNiy5U9Mo9PNFuVyZHWlIPt3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-p734BOnDNPC2x8avMfp7KA-1; Fri, 09 Oct 2020 08:19:15 -0400
X-MC-Unique: p734BOnDNPC2x8avMfp7KA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F213C1029D20
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 12:19:14 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58B325C1BB;
 Fri,  9 Oct 2020 12:19:13 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 14/23] i386: drop FEAT_HYPERV feature leaves
Date: Fri,  9 Oct 2020 14:18:33 +0200
Message-Id: <20201009121842.1938010-15-vkuznets@redhat.com>
In-Reply-To: <20201009121842.1938010-1-vkuznets@redhat.com>
References: <20201009121842.1938010-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hyper-V feature leaves are weird. We have some of them in
feature_word_info[] array but we don't use feature_word_info
magic to enable them. Neither do we use feature_dependencies[]
mechanism to validate the configuration as it doesn't allign
well with Hyper-V's many-to-many dependency chains. Some of
the feature leaves hold not only feature bits, but also values.
E.g. FEAT_HV_NESTED_EAX contains both features and the supported
Enlightened VMCS range.

Hyper-V features are already represented in 'struct X86CPU' with
uint64_t hyperv_features so duplicating them in env->features adds
little (or zero) benefits. THe other half of Hyper-V emulation features
is also stored with values in hyperv_vendor_id[], hyperv_limits[],...
so env->features[] is already incomplete.

Remove Hyper-V feature leaves from env->features[] completely.
kvm_hyperv_properties[] is converted to using raw CPUID func/reg
pairs for features, this allows us to get rid of hv_cpuid_get_fw()
conversion.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c |  90 +-------------------------------------
 target/i386/cpu.h |   5 ---
 target/i386/kvm.c | 108 ++++++++++++++++------------------------------
 3 files changed, 37 insertions(+), 166 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c12d53938970..bfa3f5515aff 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -828,94 +828,6 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
          */
         .no_autoenable_flags = ~0U,
     },
-    /*
-     * .feat_names are commented out for Hyper-V enlightenments because we
-     * don't want to have two different ways for enabling them on QEMU command
-     * line. Some features (e.g. "hyperv_time", "hyperv_vapic", ...) require
-     * enabling several feature bits simultaneously, exposing these bits
-     * individually may just confuse guests.
-     */
-    [FEAT_HYPERV_EAX] = {
-        .type = CPUID_FEATURE_WORD,
-        .feat_names = {
-            NULL /* hv_msr_vp_runtime_access */, NULL /* hv_msr_time_refcount_access */,
-            NULL /* hv_msr_synic_access */, NULL /* hv_msr_stimer_access */,
-            NULL /* hv_msr_apic_access */, NULL /* hv_msr_hypercall_access */,
-            NULL /* hv_vpindex_access */, NULL /* hv_msr_reset_access */,
-            NULL /* hv_msr_stats_access */, NULL /* hv_reftsc_access */,
-            NULL /* hv_msr_idle_access */, NULL /* hv_msr_frequency_access */,
-            NULL /* hv_msr_debug_access */, NULL /* hv_msr_reenlightenment_access */,
-            NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-        },
-        .cpuid = { .eax = 0x40000003, .reg = R_EAX, },
-    },
-    [FEAT_HYPERV_EBX] = {
-        .type = CPUID_FEATURE_WORD,
-        .feat_names = {
-            NULL /* hv_create_partitions */, NULL /* hv_access_partition_id */,
-            NULL /* hv_access_memory_pool */, NULL /* hv_adjust_message_buffers */,
-            NULL /* hv_post_messages */, NULL /* hv_signal_events */,
-            NULL /* hv_create_port */, NULL /* hv_connect_port */,
-            NULL /* hv_access_stats */, NULL, NULL, NULL /* hv_debugging */,
-            NULL /* hv_cpu_power_management */, NULL /* hv_configure_profiler */,
-            NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-        },
-        .cpuid = { .eax = 0x40000003, .reg = R_EBX, },
-    },
-    [FEAT_HYPERV_EDX] = {
-        .type = CPUID_FEATURE_WORD,
-        .feat_names = {
-            NULL /* hv_mwait */, NULL /* hv_guest_debugging */,
-            NULL /* hv_perf_monitor */, NULL /* hv_cpu_dynamic_part */,
-            NULL /* hv_hypercall_params_xmm */, NULL /* hv_guest_idle_state */,
-            NULL, NULL,
-            NULL, NULL, NULL /* hv_guest_crash_msr */, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-        },
-        .cpuid = { .eax = 0x40000003, .reg = R_EDX, },
-    },
-    [FEAT_HV_RECOMM_EAX] = {
-        .type = CPUID_FEATURE_WORD,
-        .feat_names = {
-            NULL /* hv_recommend_pv_as_switch */,
-            NULL /* hv_recommend_pv_tlbflush_local */,
-            NULL /* hv_recommend_pv_tlbflush_remote */,
-            NULL /* hv_recommend_msr_apic_access */,
-            NULL /* hv_recommend_msr_reset */,
-            NULL /* hv_recommend_relaxed_timing */,
-            NULL /* hv_recommend_dma_remapping */,
-            NULL /* hv_recommend_int_remapping */,
-            NULL /* hv_recommend_x2apic_msrs */,
-            NULL /* hv_recommend_autoeoi_deprecation */,
-            NULL /* hv_recommend_pv_ipi */,
-            NULL /* hv_recommend_ex_hypercalls */,
-            NULL /* hv_hypervisor_is_nested */,
-            NULL /* hv_recommend_int_mbec */,
-            NULL /* hv_recommend_evmcs */,
-            NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-        },
-        .cpuid = { .eax = 0x40000004, .reg = R_EAX, },
-    },
-    [FEAT_HV_NESTED_EAX] = {
-        .type = CPUID_FEATURE_WORD,
-        .cpuid = { .eax = 0x4000000A, .reg = R_EAX, },
-    },
     [FEAT_SVM] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -6908,7 +6820,7 @@ static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
     CPUX86State *env = &cpu->env;
     GuestPanicInformation *panic_info = NULL;
 
-    if (env->features[FEAT_HYPERV_EDX] & HV_GUEST_CRASH_MSR_AVAILABLE) {
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_CRASH)) {
         panic_info = g_malloc0(sizeof(GuestPanicInformation));
 
         panic_info->type = GUEST_PANIC_INFORMATION_TYPE_HYPER_V;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 67985e7c0951..2100a9ded847 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -519,11 +519,6 @@ typedef enum FeatureWord {
     FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
     FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
     FEAT_KVM_HINTS,     /* CPUID[4000_0001].EDX */
-    FEAT_HYPERV_EAX,    /* CPUID[4000_0003].EAX */
-    FEAT_HYPERV_EBX,    /* CPUID[4000_0003].EBX */
-    FEAT_HYPERV_EDX,    /* CPUID[4000_0003].EDX */
-    FEAT_HV_RECOMM_EAX, /* CPUID[4000_0004].EAX */
-    FEAT_HV_NESTED_EAX, /* CPUID[4000_000A].EAX */
     FEAT_SVM,           /* CPUID[8000_000A].EDX */
     FEAT_XSAVE,         /* CPUID[EAX=0xd,ECX=1].EAX */
     FEAT_6_EAX,         /* CPUID[6].EAX */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 24636ce4bc69..a4f3ad2f7564 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -799,7 +799,8 @@ static bool tsc_is_stable_and_known(CPUX86State *env)
 static struct {
     const char *desc;
     struct {
-        uint32_t fw;
+        uint32_t func;
+        int reg;
         uint32_t bits;
     } flags[2];
     uint64_t dependencies;
@@ -807,25 +808,25 @@ static struct {
     [HYPERV_FEAT_RELAXED] = {
         .desc = "relaxed timing (hv-relaxed)",
         .flags = {
-            {.fw = FEAT_HYPERV_EAX,
+            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
              .bits = HV_HYPERCALL_AVAILABLE},
-            {.fw = FEAT_HV_RECOMM_EAX,
+            {.func = HV_CPUID_ENLIGHTMENT_INFO, .reg = R_EAX,
              .bits = HV_RELAXED_TIMING_RECOMMENDED}
         }
     },
     [HYPERV_FEAT_VAPIC] = {
         .desc = "virtual APIC (hv-vapic)",
         .flags = {
-            {.fw = FEAT_HYPERV_EAX,
+            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
              .bits = HV_HYPERCALL_AVAILABLE | HV_APIC_ACCESS_AVAILABLE},
-            {.fw = FEAT_HV_RECOMM_EAX,
+            {.func = HV_CPUID_ENLIGHTMENT_INFO, .reg = R_EAX,
              .bits = HV_APIC_ACCESS_RECOMMENDED}
         }
     },
     [HYPERV_FEAT_TIME] = {
         .desc = "clocksources (hv-time)",
         .flags = {
-            {.fw = FEAT_HYPERV_EAX,
+            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
              .bits = HV_HYPERCALL_AVAILABLE | HV_TIME_REF_COUNT_AVAILABLE |
              HV_REFERENCE_TSC_AVAILABLE}
         }
@@ -833,42 +834,42 @@ static struct {
     [HYPERV_FEAT_CRASH] = {
         .desc = "crash MSRs (hv-crash)",
         .flags = {
-            {.fw = FEAT_HYPERV_EDX,
+            {.func = HV_CPUID_FEATURES, .reg = R_EDX,
              .bits = HV_GUEST_CRASH_MSR_AVAILABLE}
         }
     },
     [HYPERV_FEAT_RESET] = {
         .desc = "reset MSR (hv-reset)",
         .flags = {
-            {.fw = FEAT_HYPERV_EAX,
+            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
              .bits = HV_RESET_AVAILABLE}
         }
     },
     [HYPERV_FEAT_VPINDEX] = {
         .desc = "VP_INDEX MSR (hv-vpindex)",
         .flags = {
-            {.fw = FEAT_HYPERV_EAX,
+            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
              .bits = HV_VP_INDEX_AVAILABLE}
         }
     },
     [HYPERV_FEAT_RUNTIME] = {
         .desc = "VP_RUNTIME MSR (hv-runtime)",
         .flags = {
-            {.fw = FEAT_HYPERV_EAX,
+            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
              .bits = HV_VP_RUNTIME_AVAILABLE}
         }
     },
     [HYPERV_FEAT_SYNIC] = {
         .desc = "synthetic interrupt controller (hv-synic)",
         .flags = {
-            {.fw = FEAT_HYPERV_EAX,
+            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
              .bits = HV_SYNIC_AVAILABLE}
         }
     },
     [HYPERV_FEAT_STIMER] = {
         .desc = "synthetic timers (hv-stimer)",
         .flags = {
-            {.fw = FEAT_HYPERV_EAX,
+            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
              .bits = HV_SYNTIMERS_AVAILABLE}
         },
         .dependencies = BIT(HYPERV_FEAT_SYNIC) | BIT(HYPERV_FEAT_TIME)
@@ -876,23 +877,23 @@ static struct {
     [HYPERV_FEAT_FREQUENCIES] = {
         .desc = "frequency MSRs (hv-frequencies)",
         .flags = {
-            {.fw = FEAT_HYPERV_EAX,
+            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
              .bits = HV_ACCESS_FREQUENCY_MSRS},
-            {.fw = FEAT_HYPERV_EDX,
+            {.func = HV_CPUID_FEATURES, .reg = R_EDX,
              .bits = HV_FREQUENCY_MSRS_AVAILABLE}
         }
     },
     [HYPERV_FEAT_REENLIGHTENMENT] = {
         .desc = "reenlightenment MSRs (hv-reenlightenment)",
         .flags = {
-            {.fw = FEAT_HYPERV_EAX,
+            {.func = HV_CPUID_FEATURES, .reg = R_EAX,
              .bits = HV_ACCESS_REENLIGHTENMENTS_CONTROL}
         }
     },
     [HYPERV_FEAT_TLBFLUSH] = {
         .desc = "paravirtualized TLB flush (hv-tlbflush)",
         .flags = {
-            {.fw = FEAT_HV_RECOMM_EAX,
+            {.func = HV_CPUID_ENLIGHTMENT_INFO, .reg = R_EAX,
              .bits = HV_REMOTE_TLB_FLUSH_RECOMMENDED |
              HV_EX_PROCESSOR_MASKS_RECOMMENDED}
         },
@@ -901,7 +902,7 @@ static struct {
     [HYPERV_FEAT_EVMCS] = {
         .desc = "enlightened VMCS (hv-evmcs)",
         .flags = {
-            {.fw = FEAT_HV_RECOMM_EAX,
+            {.func = HV_CPUID_ENLIGHTMENT_INFO, .reg = R_EAX,
              .bits = HV_ENLIGHTENED_VMCS_RECOMMENDED}
         },
         .dependencies = BIT(HYPERV_FEAT_VAPIC)
@@ -909,7 +910,7 @@ static struct {
     [HYPERV_FEAT_IPI] = {
         .desc = "paravirtualized IPI (hv-ipi)",
         .flags = {
-            {.fw = FEAT_HV_RECOMM_EAX,
+            {.func = HV_CPUID_ENLIGHTMENT_INFO, .reg = R_EAX,
              .bits = HV_CLUSTER_IPI_RECOMMENDED |
              HV_EX_PROCESSOR_MASKS_RECOMMENDED}
         },
@@ -918,7 +919,7 @@ static struct {
     [HYPERV_FEAT_STIMER_DIRECT] = {
         .desc = "direct mode synthetic timers (hv-stimer-direct)",
         .flags = {
-            {.fw = FEAT_HYPERV_EDX,
+            {.func = HV_CPUID_FEATURES, .reg = R_EDX,
              .bits = HV_STIMER_DIRECT_MODE_AVAILABLE}
         },
         .dependencies = BIT(HYPERV_FEAT_STIMER)
@@ -1064,48 +1065,6 @@ static struct kvm_cpuid2 *get_supported_hv_cpuid_legacy(CPUState *cs)
     return cpuid;
 }
 
-static int hv_cpuid_get_fw(struct kvm_cpuid2 *cpuid, int fw, uint32_t *r)
-{
-    struct kvm_cpuid_entry2 *entry;
-    uint32_t func;
-    int reg;
-
-    switch (fw) {
-    case FEAT_HYPERV_EAX:
-        reg = R_EAX;
-        func = HV_CPUID_FEATURES;
-        break;
-    case FEAT_HYPERV_EDX:
-        reg = R_EDX;
-        func = HV_CPUID_FEATURES;
-        break;
-    case FEAT_HV_RECOMM_EAX:
-        reg = R_EAX;
-        func = HV_CPUID_ENLIGHTMENT_INFO;
-        break;
-    default:
-        return -EINVAL;
-    }
-
-    entry = cpuid_find_entry(cpuid, func, 0);
-    if (!entry) {
-        return -ENOENT;
-    }
-
-    switch (reg) {
-    case R_EAX:
-        *r = entry->eax;
-        break;
-    case R_EDX:
-        *r = entry->edx;
-        break;
-    default:
-        return -EINVAL;
-    }
-
-    return 0;
-}
-
 static uint32_t hv_cpuid_get_host(struct kvm_cpuid2 *cpuid, uint32_t func,
                                   int reg)
 {
@@ -1121,18 +1080,20 @@ static uint32_t hv_cpuid_get_host(struct kvm_cpuid2 *cpuid, uint32_t func,
 
 static bool hyperv_feature_supported(struct kvm_cpuid2 *cpuid, int feature)
 {
-    uint32_t r, fw, bits;
-    int i;
+    uint32_t func, bits;
+    int i, reg;
 
     for (i = 0; i < ARRAY_SIZE(kvm_hyperv_properties[feature].flags); i++) {
-        fw = kvm_hyperv_properties[feature].flags[i].fw;
+
+        func = kvm_hyperv_properties[feature].flags[i].func;
+        reg = kvm_hyperv_properties[feature].flags[i].reg;
         bits = kvm_hyperv_properties[feature].flags[i].bits;
 
-        if (!fw) {
+        if (!func) {
             continue;
         }
 
-        if (hv_cpuid_get_fw(cpuid, fw, &r) || (r & bits) != bits) {
+        if ((hv_cpuid_get_host(cpuid, func, reg) & bits) != bits) {
             return false;
         }
     }
@@ -1182,7 +1143,7 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
     return 0;
 }
 
-static uint32_t hv_build_cpuid_leaf(CPUState *cs, uint32_t fw)
+static uint32_t hv_build_cpuid_leaf(CPUState *cs, uint32_t func, int reg)
 {
     X86CPU *cpu = X86_CPU(cs);
     uint32_t r = 0;
@@ -1194,7 +1155,10 @@ static uint32_t hv_build_cpuid_leaf(CPUState *cs, uint32_t fw)
         }
 
         for (j = 0; j < ARRAY_SIZE(kvm_hyperv_properties[i].flags); j++) {
-            if (kvm_hyperv_properties[i].flags[j].fw != fw) {
+            if (kvm_hyperv_properties[i].flags[j].func != func) {
+                continue;
+            }
+            if (kvm_hyperv_properties[i].flags[j].reg != reg) {
                 continue;
             }
 
@@ -1345,16 +1309,16 @@ static int hyperv_handle_properties(CPUState *cs,
 
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_FEATURES;
-    c->eax = hv_build_cpuid_leaf(cs, FEAT_HYPERV_EAX);
-    c->ebx = hv_build_cpuid_leaf(cs, FEAT_HYPERV_EBX);
-    c->edx = hv_build_cpuid_leaf(cs, FEAT_HYPERV_EDX);
+    c->eax = hv_build_cpuid_leaf(cs, HV_CPUID_FEATURES, R_EAX);
+    c->ebx = hv_build_cpuid_leaf(cs, HV_CPUID_FEATURES, R_EBX);
+    c->edx = hv_build_cpuid_leaf(cs, HV_CPUID_FEATURES, R_EDX);
 
     /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
     c->edx |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
 
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_ENLIGHTMENT_INFO;
-    c->eax = hv_build_cpuid_leaf(cs, FEAT_HV_RECOMM_EAX);
+    c->eax = hv_build_cpuid_leaf(cs, HV_CPUID_ENLIGHTMENT_INFO, R_EAX);
     c->ebx = cpu->hyperv_spinlock_attempts;
 
     if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_ON) {
-- 
2.25.4


