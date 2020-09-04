Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8924CC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6682073B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6682073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDFw-0006cc-AV
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8O-0001BD-P3
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59165
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8M-0007FL-Mq
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:12 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-vNIoLyMIPk6mQxmVfq-9UA-1; Fri, 04 Sep 2020 10:55:03 -0400
X-MC-Unique: vNIoLyMIPk6mQxmVfq-9UA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C72588D327D
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 14:55:02 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF8647E416;
 Fri,  4 Sep 2020 14:55:00 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 15/22] i386: switch hyperv_expand_features() to using
 error_setg()
Date: Fri,  4 Sep 2020 16:54:24 +0200
Message-Id: <20200904145431.196885-16-vkuznets@redhat.com>
In-Reply-To: <20200904145431.196885-1-vkuznets@redhat.com>
References: <20200904145431.196885-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
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

Use standard error_setg() mechanism in hyperv_expand_features().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 96 +++++++++++++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 32 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 2e9ceafa2421..760b93091fea 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1139,7 +1139,7 @@ static int hv_cpuid_get_fw(struct kvm_cpuid2 *cpuid, int fw, uint32_t *r)
 }
 
 static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
-                                  int feature)
+                                  int feature, Error **errp)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -1155,11 +1155,10 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
     while (deps) {
         dep_feat = ctz64(deps);
         if (!(hyperv_feat_enabled(cpu, dep_feat))) {
-                fprintf(stderr,
-                        "Hyper-V %s requires Hyper-V %s\n",
-                        kvm_hyperv_properties[feature].desc,
-                        kvm_hyperv_properties[dep_feat].desc);
-                return 1;
+            error_setg(errp, "Hyper-V %s requires Hyper-V %s",
+                       kvm_hyperv_properties[feature].desc,
+                       kvm_hyperv_properties[dep_feat].desc);
+            return 1;
         }
         deps &= ~(1ull << dep_feat);
     }
@@ -1174,9 +1173,8 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
 
         if (hv_cpuid_get_fw(cpuid, fw, &r) || (r & bits) != bits) {
             if (hyperv_feat_enabled(cpu, feature)) {
-                fprintf(stderr,
-                        "Hyper-V %s is not supported by kernel\n",
-                        kvm_hyperv_properties[feature].desc);
+                error_setg(errp, "Hyper-V %s is not supported by kernel",
+                           kvm_hyperv_properties[feature].desc);
                 return 1;
             } else {
                 return 0;
@@ -1200,13 +1198,13 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
  * of 'hv_passthrough' mode and fills the environment with all supported
  * Hyper-V features.
  */
-static int hyperv_expand_features(CPUState *cs)
+static int hyperv_expand_features(CPUState *cs, Error **errp)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     struct kvm_cpuid2 *cpuid;
     struct kvm_cpuid_entry2 *c;
-    int r;
+    int r = 1;
 
     if (!hyperv_enabled(cpu))
         return 0;
@@ -1285,34 +1283,67 @@ static int hyperv_expand_features(CPUState *cs)
     }
 
     /* Features */
-    r = hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RELAXED);
-    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_VAPIC);
-    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_TIME);
-    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_CRASH);
-    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RESET);
-    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_VPINDEX);
-    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RUNTIME);
-    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_SYNIC);
-    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_STIMER);
-    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_FREQUENCIES);
-    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_REENLIGHTENMENT);
-    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_TLBFLUSH);
-    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_EVMCS);
-    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_IPI);
-    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_STIMER_DIRECT);
+    if (hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RELAXED, errp)) {
+        goto out;
+    }
+    if (hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_VAPIC, errp)) {
+        goto out;
+    }
+    if (hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_TIME, errp)) {
+        goto out;
+    }
+    if (hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_CRASH, errp)) {
+        goto out;
+    }
+    if (hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RESET, errp)) {
+        goto out;
+    }
+    if (hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_VPINDEX, errp)) {
+        goto out;
+    }
+    if (hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_RUNTIME, errp)) {
+        goto out;
+    }
+    if (hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_SYNIC, errp)) {
+        goto out;
+    }
+    if (hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_STIMER, errp)) {
+        goto out;
+    }
+    if (hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_FREQUENCIES, errp)) {
+        goto out;
+    }
+    if (hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_REENLIGHTENMENT, errp)) {
+        goto out;
+    }
+    if (hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_TLBFLUSH, errp)) {
+        goto out;
+    }
+    if (hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_EVMCS, errp)) {
+        goto out;
+    }
+    if (hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_IPI, errp)) {
+        goto out;
+    }
+    if (hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_STIMER_DIRECT, errp)) {
+        goto out;
+    }
 
     /* Additional dependencies not covered by kvm_hyperv_properties[] */
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
         !cpu->hyperv_synic_kvm_only &&
         !hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
-        fprintf(stderr, "Hyper-V %s requires Hyper-V %s\n",
-                kvm_hyperv_properties[HYPERV_FEAT_SYNIC].desc,
-                kvm_hyperv_properties[HYPERV_FEAT_VPINDEX].desc);
-        r |= 1;
+        error_setg(errp, "Hyper-V %s requires Hyper-V %s",
+                   kvm_hyperv_properties[HYPERV_FEAT_SYNIC].desc,
+                   kvm_hyperv_properties[HYPERV_FEAT_VPINDEX].desc);
+        goto out;
     }
 
     /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
     env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
+    r = 0;
+
+out:
 
     g_free(cpuid);
 
@@ -1553,8 +1584,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
     env->apic_bus_freq = KVM_APIC_BUS_FREQUENCY;
 
     /* Paravirtualization CPUIDs */
-    r = hyperv_expand_features(cs);
-    if (r < 0) {
+    r = hyperv_expand_features(cs, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
         return r;
     }
 
-- 
2.25.4


