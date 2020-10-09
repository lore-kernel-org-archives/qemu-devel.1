Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8EDC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE7E222B9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eelj5Gbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE7E222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQraJ-0005BB-OT
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMs-00009N-Up
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kQrMn-0007x8-2L
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602245951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T+0fz2uGSQ7OjlZNo5B48kZSDXEhLyUAOhbl5mRPg7w=;
 b=eelj5Gbmft2f76do4N2NcCtMjXDS7hgzXq4MmV3/AB2LNZ1iXWFSS+jun9odjkZAyvW46+
 OSEXfYfmN40ejmgo80joOHYddr1UVJpkSNzFPtPsYidPJnUj4d03lJmp5BfR0v4NYPR8MY
 AqeC/Q/twgdwnuKaUYZjp6P2lzRcfm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-KQO4nCVyN3uGtz1RWuRk3Q-1; Fri, 09 Oct 2020 08:19:09 -0400
X-MC-Unique: KQO4nCVyN3uGtz1RWuRk3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF982AFD08
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 12:19:08 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEC3B5C1BB;
 Fri,  9 Oct 2020 12:19:06 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 11/23] i386: stop using env->features[] for filling
 Hyper-V CPUIDs
Date: Fri,  9 Oct 2020 14:18:30 +0200
Message-Id: <20201009121842.1938010-12-vkuznets@redhat.com>
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

As a preparatory patch to dropping Hyper-V CPUID leaves from
feature_word_info[] stop using env->features[] as a temporary
storage of Hyper-V CPUIDs, just build Hyper-V CPUID leaves directly
from kvm_hyperv_properties[] data.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.h |  1 +
 target/i386/kvm.c | 80 +++++++++++++++++++++++++----------------------
 2 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4a4f88f24d78..67985e7c0951 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1664,6 +1664,7 @@ struct X86CPU {
     uint32_t hyperv_interface_id[4];
     uint32_t hyperv_version_id[4];
     uint32_t hyperv_limits[3];
+    uint32_t hyperv_nested[4];
 
     bool check_cpuid;
     bool enforce_cpuid;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 56bfc8da85d0..2c14d45b40bf 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1110,7 +1110,6 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
                                   int feature)
 {
     X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
     uint32_t r, fw, bits;
     uint64_t deps;
     int i, dep_feat;
@@ -1150,8 +1149,6 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
                 return 0;
             }
         }
-
-        env->features[fw] |= bits;
     }
 
     if (cpu->hyperv_passthrough) {
@@ -1161,6 +1158,29 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
     return 0;
 }
 
+static uint32_t hv_build_cpuid_leaf(CPUState *cs, uint32_t fw)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    uint32_t r = 0;
+    int i, j;
+
+    for (i = 0; i < ARRAY_SIZE(kvm_hyperv_properties); i++) {
+        if (!hyperv_feat_enabled(cpu, i)) {
+            continue;
+        }
+
+        for (j = 0; j < ARRAY_SIZE(kvm_hyperv_properties[i].flags); j++) {
+            if (kvm_hyperv_properties[i].flags[j].fw != fw) {
+                continue;
+            }
+
+            r |= kvm_hyperv_properties[i].flags[j].bits;
+        }
+    }
+
+    return r;
+}
+
 /*
  * Fill in Hyper-V CPUIDs. Returns the number of entries filled in cpuid_ent in
  * case of success, errno < 0 in case of failure and 0 when no Hyper-V
@@ -1170,9 +1190,8 @@ static int hyperv_handle_properties(CPUState *cs,
                                     struct kvm_cpuid_entry2 *cpuid_ent)
 {
     X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
     struct kvm_cpuid2 *cpuid;
-    struct kvm_cpuid_entry2 *c;
+    struct kvm_cpuid_entry2 *c, *c2;
     uint32_t cpuid_i = 0;
     int r;
 
@@ -1193,9 +1212,7 @@ static int hyperv_handle_properties(CPUState *cs,
         }
 
         if (!r) {
-            env->features[FEAT_HV_RECOMM_EAX] |=
-                HV_ENLIGHTENED_VMCS_RECOMMENDED;
-            env->features[FEAT_HV_NESTED_EAX] = evmcs_version;
+            cpu->hyperv_nested[0] = evmcs_version;
         }
     }
 
@@ -1233,13 +1250,6 @@ static int hyperv_handle_properties(CPUState *cs,
             cpu->hyperv_version_id[3] = c->edx;
         }
 
-        c = cpuid_find_entry(cpuid, HV_CPUID_FEATURES, 0);
-        if (c) {
-            env->features[FEAT_HYPERV_EAX] = c->eax;
-            env->features[FEAT_HYPERV_EBX] = c->ebx;
-            env->features[FEAT_HYPERV_EDX] = c->edx;
-        }
-
         c = cpuid_find_entry(cpuid, HV_CPUID_IMPLEMENT_LIMITS, 0);
         if (c) {
             cpu->hv_max_vps = c->eax;
@@ -1250,23 +1260,8 @@ static int hyperv_handle_properties(CPUState *cs,
 
         c = cpuid_find_entry(cpuid, HV_CPUID_ENLIGHTMENT_INFO, 0);
         if (c) {
-            env->features[FEAT_HV_RECOMM_EAX] = c->eax;
             cpu->hyperv_spinlock_attempts = c->ebx;
         }
-        c = cpuid_find_entry(cpuid, HV_CPUID_NESTED_FEATURES, 0);
-        if (c) {
-            env->features[FEAT_HV_NESTED_EAX] = c->eax;
-        }
-    }
-
-    if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_ON) {
-        env->features[FEAT_HV_RECOMM_EAX] |= HV_NO_NONARCH_CORESHARING;
-    } else if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_AUTO) {
-        c = cpuid_find_entry(cpuid, HV_CPUID_ENLIGHTMENT_INFO, 0);
-        if (c) {
-            env->features[FEAT_HV_RECOMM_EAX] |=
-                c->eax & HV_NO_NONARCH_CORESHARING;
-        }
     }
 
     /* Features */
@@ -1296,9 +1291,6 @@ static int hyperv_handle_properties(CPUState *cs,
         r |= 1;
     }
 
-    /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
-    env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
-
     if (r) {
         r = -ENOSYS;
         goto free;
@@ -1328,15 +1320,27 @@ static int hyperv_handle_properties(CPUState *cs,
 
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_FEATURES;
-    c->eax = env->features[FEAT_HYPERV_EAX];
-    c->ebx = env->features[FEAT_HYPERV_EBX];
-    c->edx = env->features[FEAT_HYPERV_EDX];
+    c->eax = hv_build_cpuid_leaf(cs, FEAT_HYPERV_EAX);
+    c->ebx = hv_build_cpuid_leaf(cs, FEAT_HYPERV_EBX);
+    c->edx = hv_build_cpuid_leaf(cs, FEAT_HYPERV_EDX);
+
+    /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
+    c->edx |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
 
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_ENLIGHTMENT_INFO;
-    c->eax = env->features[FEAT_HV_RECOMM_EAX];
+    c->eax = hv_build_cpuid_leaf(cs, FEAT_HV_RECOMM_EAX);
     c->ebx = cpu->hyperv_spinlock_attempts;
 
+    if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_ON) {
+        c->eax |= HV_NO_NONARCH_CORESHARING;
+    } else if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_AUTO) {
+        c2 = cpuid_find_entry(cpuid, HV_CPUID_ENLIGHTMENT_INFO, 0);
+        if (c2) {
+            c->eax |= c2->eax & HV_NO_NONARCH_CORESHARING;
+        }
+    }
+
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_IMPLEMENT_LIMITS;
     c->eax = cpu->hv_max_vps;
@@ -1356,7 +1360,7 @@ static int hyperv_handle_properties(CPUState *cs,
 
         c = &cpuid_ent[cpuid_i++];
         c->function = HV_CPUID_NESTED_FEATURES;
-        c->eax = env->features[FEAT_HV_NESTED_EAX];
+        c->eax = cpu->hyperv_nested[0];
     }
     r = cpuid_i;
 
-- 
2.25.4


