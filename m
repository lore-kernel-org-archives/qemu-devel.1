Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0335C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AFA920706
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYeJ/Waz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFA920706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNcWC-0000TK-G9
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 09:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcMb-0006LT-5p
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:41:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kNcMT-0005di-BG
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:41:43 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601473296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UpZKa7lGV2ZXbfTkflmLPamKfI5j5q26s1sGK0a6/WY=;
 b=TYeJ/WazOcH5ifth8D2MfiJVIJFAe4od5JA/Kmsqt9T/0bY2ueTL9t9P3DCKXycujJZOIu
 IFo2pHgs0AR/DDLEFMZaxPOd9+MhlVEpd2oAnyyA56qI/ubdCw5+jw8La/QbEm0cPAF3ZH
 TpcHet6CDLD67laW8yWHli+Zvq7ySbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-jJiteyeqOvmiBNCv3sXPkg-1; Wed, 30 Sep 2020 09:41:34 -0400
X-MC-Unique: jJiteyeqOvmiBNCv3sXPkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48AE0873157
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:41:33 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C490760C05;
 Wed, 30 Sep 2020 13:41:31 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 14/19] i386: move eVMCS enablement to hyperv_init_vcpu()
Date: Wed, 30 Sep 2020 15:40:22 +0200
Message-Id: <20200930134027.1348021-15-vkuznets@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
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

hyperv_expand_features() will be called before we create vCPU so
evmcs enablement should go away. hyperv_init_vcpu() looks like the
right place.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/kvm.c | 60 +++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 0808355bfcfd..181e034da701 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -976,6 +976,7 @@ static struct kvm_cpuid2 *get_supported_hv_cpuid(CPUState *cs)
 {
     struct kvm_cpuid2 *cpuid;
     int max = 7; /* 0x40000000..0x40000005, 0x4000000A */
+    int i;
 
     /*
      * When the buffer is too small, KVM_GET_SUPPORTED_HV_CPUID fails with
@@ -985,6 +986,22 @@ static struct kvm_cpuid2 *get_supported_hv_cpuid(CPUState *cs)
     while ((cpuid = try_get_hv_cpuid(cs, max)) == NULL) {
         max++;
     }
+
+    /*
+     * KVM_GET_SUPPORTED_HV_CPUID does not set EVMCS CPUID bit before
+     * KVM_CAP_HYPERV_ENLIGHTENED_VMCS is enabled but we want to get the
+     * information early, just check for the capability and set the bit
+     * manually.
+     */
+    if (kvm_check_extension(cs->kvm_state,
+                            KVM_CAP_HYPERV_ENLIGHTENED_VMCS) > 0) {
+        for (i = 0; i < cpuid->nent; i++) {
+            if (cpuid->entries[i].function == HV_CPUID_ENLIGHTMENT_INFO) {
+                cpuid->entries[i].eax |= HV_ENLIGHTENED_VMCS_RECOMMENDED;
+            }
+        }
+    }
+
     return cpuid;
 }
 
@@ -1214,24 +1231,6 @@ static int hyperv_expand_features(CPUState *cs)
     if (!hyperv_enabled(cpu))
         return 0;
 
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ||
-        cpu->hyperv_passthrough) {
-        uint16_t evmcs_version;
-
-        r = kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_ENLIGHTENED_VMCS, 0,
-                                (uintptr_t)&evmcs_version);
-
-        if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) && r) {
-            fprintf(stderr, "Hyper-V %s is not supported by kernel\n",
-                    kvm_hyperv_properties[HYPERV_FEAT_EVMCS].desc);
-            return -ENOSYS;
-        }
-
-        if (!r) {
-            cpu->hyperv_nested[0] = evmcs_version;
-        }
-    }
-
     if (cpu->hyperv_passthrough) {
         cpu->hyperv_vendor_id[0] =
             hv_cpuid_get_host(cs, HV_CPUID_VENDOR_AND_MAX_FUNCTIONS, R_EBX);
@@ -1468,6 +1467,21 @@ static int hyperv_init_vcpu(X86CPU *cpu)
         }
     }
 
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
+        uint16_t evmcs_version;
+
+        ret = kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_ENLIGHTENED_VMCS, 0,
+                                  (uintptr_t)&evmcs_version);
+
+        if (ret < 0) {
+            fprintf(stderr, "Hyper-V %s is not supported by kernel\n",
+                    kvm_hyperv_properties[HYPERV_FEAT_EVMCS].desc);
+            return ret;
+        }
+
+        cpu->hyperv_nested[0] = evmcs_version;
+    }
+
     return 0;
 }
 
@@ -1532,6 +1546,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     if (hyperv_enabled(cpu)) {
+        r = hyperv_init_vcpu(cpu);
+        if (r) {
+            return r;
+        }
+
         cpuid_i = hyperv_fill_cpuids(cs, cpuid_data.entries);
         kvm_base = KVM_CPUID_SIGNATURE_NEXT;
         has_msr_hv_hypercall = true;
@@ -1879,11 +1898,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     kvm_init_msrs(cpu);
 
-    r = hyperv_init_vcpu(cpu);
-    if (r) {
-        goto fail;
-    }
-
     return 0;
 
  fail:
-- 
2.25.4


