Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F151C47420
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 302B320706
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGWG6kC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302B320706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNcZh-0003yF-9D
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 09:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcMd-0006MT-Az
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcMa-0005e5-Rm
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:41:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601473298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=arb4Vkg/IiXovO0rnzjC19MaVYDKE+UhYIRempQ0NyI=;
 b=fGWG6kC3QefPnHzLXta6yQzLmYE0lHdlHow3TXOh8Qv/dSD4JGE5WnZfmYWVAbgEZL+dZO
 srckXbW6wYmWCAvUxfXRj4ixZWy55FuOzQ1rdHTCFbwaPaU0yP4oyaq//5It/i/McgkFWy
 /2jI0M8lbIHsyX0danOX3oxyB1cBrsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-vOhb1neXOmqMT-h6bUHhvA-1; Wed, 30 Sep 2020 09:41:36 -0400
X-MC-Unique: vOhb1neXOmqMT-h6bUHhvA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AA341007285
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:41:35 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6C3060C05;
 Wed, 30 Sep 2020 13:41:33 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 15/19] i386: switch hyperv_expand_features() to using
 error_setg()
Date: Wed, 30 Sep 2020 15:40:23 +0200
Message-Id: <20200930134027.1348021-16-vkuznets@redhat.com>
In-Reply-To: <20200930134027.1348021-1-vkuznets@redhat.com>
References: <20200930134027.1348021-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use standard error_setg() mechanism in hyperv_expand_features().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 101 ++++++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 40 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 181e034da701..32678154837f 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1149,7 +1149,7 @@ static bool hyperv_feature_supported(CPUState *cs, int feature)
     return true;
 }
 
-static int hv_cpuid_check_and_set(CPUState *cs, int feature)
+static int hv_cpuid_check_and_set(CPUState *cs, int feature, Error **errp)
 {
     X86CPU *cpu = X86_CPU(cs);
     uint64_t deps;
@@ -1163,20 +1163,18 @@ static int hv_cpuid_check_and_set(CPUState *cs, int feature)
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
 
     if (!hyperv_feature_supported(cs, feature)) {
         if (hyperv_feat_enabled(cpu, feature)) {
-            fprintf(stderr,
-                    "Hyper-V %s is not supported by kernel\n",
-                    kvm_hyperv_properties[feature].desc);
+            error_setg(errp, "Hyper-V %s is not supported by kernel",
+                       kvm_hyperv_properties[feature].desc);
             return 1;
         } else {
             return 0;
@@ -1223,13 +1221,12 @@ static uint32_t hv_build_cpuid_leaf(CPUState *cs, uint32_t func, int reg)
  * of 'hv_passthrough' mode and fills the environment with all supported
  * Hyper-V features.
  */
-static int hyperv_expand_features(CPUState *cs)
+static void hyperv_expand_features(CPUState *cs, Error **errp)
 {
     X86CPU *cpu = X86_CPU(cs);
-    int r;
 
     if (!hyperv_enabled(cpu))
-        return 0;
+        return;
 
     if (cpu->hyperv_passthrough) {
         cpu->hyperv_vendor_id[0] =
@@ -1275,37 +1272,60 @@ static int hyperv_expand_features(CPUState *cs)
     }
 
     /* Features */
-    r = hv_cpuid_check_and_set(cs, HYPERV_FEAT_RELAXED);
-    r |= hv_cpuid_check_and_set(cs, HYPERV_FEAT_VAPIC);
-    r |= hv_cpuid_check_and_set(cs, HYPERV_FEAT_TIME);
-    r |= hv_cpuid_check_and_set(cs, HYPERV_FEAT_CRASH);
-    r |= hv_cpuid_check_and_set(cs, HYPERV_FEAT_RESET);
-    r |= hv_cpuid_check_and_set(cs, HYPERV_FEAT_VPINDEX);
-    r |= hv_cpuid_check_and_set(cs, HYPERV_FEAT_RUNTIME);
-    r |= hv_cpuid_check_and_set(cs, HYPERV_FEAT_SYNIC);
-    r |= hv_cpuid_check_and_set(cs, HYPERV_FEAT_STIMER);
-    r |= hv_cpuid_check_and_set(cs, HYPERV_FEAT_FREQUENCIES);
-    r |= hv_cpuid_check_and_set(cs, HYPERV_FEAT_REENLIGHTENMENT);
-    r |= hv_cpuid_check_and_set(cs, HYPERV_FEAT_TLBFLUSH);
-    r |= hv_cpuid_check_and_set(cs, HYPERV_FEAT_EVMCS);
-    r |= hv_cpuid_check_and_set(cs, HYPERV_FEAT_IPI);
-    r |= hv_cpuid_check_and_set(cs, HYPERV_FEAT_STIMER_DIRECT);
+    if (hv_cpuid_check_and_set(cs, HYPERV_FEAT_RELAXED, errp)) {
+        return;
+    }
+    if (hv_cpuid_check_and_set(cs, HYPERV_FEAT_VAPIC, errp)) {
+        return;
+    }
+    if (hv_cpuid_check_and_set(cs, HYPERV_FEAT_TIME, errp)) {
+        return;
+    }
+    if (hv_cpuid_check_and_set(cs, HYPERV_FEAT_CRASH, errp)) {
+        return;
+    }
+    if (hv_cpuid_check_and_set(cs, HYPERV_FEAT_RESET, errp)) {
+        return;
+    }
+    if (hv_cpuid_check_and_set(cs, HYPERV_FEAT_VPINDEX, errp)) {
+        return;
+    }
+    if (hv_cpuid_check_and_set(cs, HYPERV_FEAT_RUNTIME, errp)) {
+        return;
+    }
+    if (hv_cpuid_check_and_set(cs, HYPERV_FEAT_SYNIC, errp)) {
+        return;
+    }
+    if (hv_cpuid_check_and_set(cs, HYPERV_FEAT_STIMER, errp)) {
+        return;
+    }
+    if (hv_cpuid_check_and_set(cs, HYPERV_FEAT_FREQUENCIES, errp)) {
+        return;
+    }
+    if (hv_cpuid_check_and_set(cs, HYPERV_FEAT_REENLIGHTENMENT, errp)) {
+        return;
+    }
+    if (hv_cpuid_check_and_set(cs, HYPERV_FEAT_TLBFLUSH, errp)) {
+        return;
+    }
+    if (hv_cpuid_check_and_set(cs, HYPERV_FEAT_EVMCS, errp)) {
+        return;
+    }
+    if (hv_cpuid_check_and_set(cs, HYPERV_FEAT_IPI, errp)) {
+        return;
+    }
+    if (hv_cpuid_check_and_set(cs, HYPERV_FEAT_STIMER_DIRECT, errp)) {
+        return;
+    }
 
     /* Additional dependencies not covered by kvm_hyperv_properties[] */
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
         !cpu->hyperv_synic_kvm_only &&
         !hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
-        fprintf(stderr, "Hyper-V %s requires Hyper-V %s\n",
-                kvm_hyperv_properties[HYPERV_FEAT_SYNIC].desc,
-                kvm_hyperv_properties[HYPERV_FEAT_VPINDEX].desc);
-        r |= 1;
-    }
-
-    if (r) {
-        return -ENOSYS;
+        error_setg(errp, "Hyper-V %s requires Hyper-V %s",
+                   kvm_hyperv_properties[HYPERV_FEAT_SYNIC].desc,
+                   kvm_hyperv_properties[HYPERV_FEAT_VPINDEX].desc);
     }
-
-    return 0;
 }
 
 /*
@@ -1540,9 +1560,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
     env->apic_bus_freq = KVM_APIC_BUS_FREQUENCY;
 
     /* Paravirtualization CPUIDs */
-    r = hyperv_expand_features(cs);
-    if (r < 0) {
-        return r;
+    hyperv_expand_features(cs, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return -ENOSYS;
     }
 
     if (hyperv_enabled(cpu)) {
-- 
2.25.4


