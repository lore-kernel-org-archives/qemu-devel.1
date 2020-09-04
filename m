Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A69C2BB84
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9372073B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9372073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDEG-0003rb-2C
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8K-000128-U1
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24060
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8I-0007EZ-RO
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:08 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-nhJe5k4SOZKr4CmO_P87GQ-1; Fri, 04 Sep 2020 10:54:59 -0400
X-MC-Unique: nhJe5k4SOZKr4CmO_P87GQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46CA78D327D
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 14:54:58 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E8F07A1F4;
 Fri,  4 Sep 2020 14:54:56 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 13/22] i386: split hyperv_handle_properties() into
 hyperv_expand_features()/hyperv_fill_cpuids()
Date: Fri,  4 Sep 2020 16:54:22 +0200
Message-Id: <20200904145431.196885-14-vkuznets@redhat.com>
In-Reply-To: <20200904145431.196885-1-vkuznets@redhat.com>
References: <20200904145431.196885-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The intention is to call hyperv_expand_features() early, before vCPUs
are created and use the acquired data later when we set guest visible
CPUID data.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b7f0e200a75f..c4bb147090a9 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1177,18 +1177,18 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
 }
 
 /*
- * Fill in Hyper-V CPUIDs. Returns the number of entries filled in cpuid_ent in
- * case of success, errno < 0 in case of failure and 0 when no Hyper-V
- * extentions are enabled.
+ * Expand Hyper-V CPU features. In partucular, check that all the requested
+ * features are supported by the host and the sanity of the configuration
+ * (that all the required dependencies are included). Also, this takes care
+ * of 'hv_passthrough' mode and fills the environment with all supported
+ * Hyper-V features.
  */
-static int hyperv_handle_properties(CPUState *cs,
-                                    struct kvm_cpuid_entry2 *cpuid_ent)
+static int hyperv_expand_features(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     struct kvm_cpuid2 *cpuid;
     struct kvm_cpuid_entry2 *c;
-    uint32_t cpuid_i = 0;
     int r;
 
     if (!hyperv_enabled(cpu))
@@ -1317,11 +1317,26 @@ static int hyperv_handle_properties(CPUState *cs,
     /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
     env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
 
+    g_free(cpuid);
+
     if (r) {
-        r = -ENOSYS;
-        goto free;
+        return -ENOSYS;
     }
 
+    return 0;
+}
+
+/*
+ * Fill in Hyper-V CPUIDs. Returns the number of entries filled in cpuid_ent.
+ */
+static int hyperv_fill_cpuids(CPUState *cs,
+                              struct kvm_cpuid_entry2 *cpuid_ent)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    struct kvm_cpuid_entry2 *c;
+    uint32_t cpuid_i = 0;
+
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
     c->eax = hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ?
@@ -1382,12 +1397,8 @@ static int hyperv_handle_properties(CPUState *cs,
         c->ecx = env->features[FEAT_HV_NESTED_ECX];
         c->edx = env->features[FEAT_HV_NESTED_EDX];
     }
-    r = cpuid_i;
 
-free:
-    g_free(cpuid);
-
-    return r;
+    return cpuid_i;
 }
 
 static Error *hv_passthrough_mig_blocker;
@@ -1529,11 +1540,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
     env->apic_bus_freq = KVM_APIC_BUS_FREQUENCY;
 
     /* Paravirtualization CPUIDs */
-    r = hyperv_handle_properties(cs, cpuid_data.entries);
+    r = hyperv_expand_features(cs);
     if (r < 0) {
         return r;
-    } else if (r > 0) {
-        cpuid_i = r;
+    }
+
+    if (hyperv_enabled(cpu)) {
+        cpuid_i = hyperv_fill_cpuids(cs, cpuid_data.entries);
         kvm_base = KVM_CPUID_SIGNATURE_NEXT;
         has_msr_hv_hypercall = true;
     }
-- 
2.25.4


