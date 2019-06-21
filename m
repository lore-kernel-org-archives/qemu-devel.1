Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65C8C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 01:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD532064B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 01:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwDjoxtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD532064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54040 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he8ek-0000ER-4Z
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 21:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40779)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8Zg-0006O9-8L
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8Zb-0006Dw-Lf
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:43 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53324)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1he8Zb-0006CS-Ai
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id x15so4781985wmj.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Qznel7g6fB8yvYmlOFOQWGexcJCqwQlz1eNoYvx8nfE=;
 b=uwDjoxtNwKWhkcDCmFCbjG47QdiGxto9pf0wfYY7d6Jwxd/4lVt4+QXpZ8GRsEOdKh
 /NlXcnZZ9p/I54EG6ecnSiBTw8Aeko64nvAEJsT+U8Zqp9nmGdGaDniVyguEUvWTifXT
 iYglC6cUIQpRN4Ls+RCoalWdVBirmBnSSKJJGW34vzKG0q1M6LrTx952RPoobAFuKxp4
 Ds8ez04g/k0KrEcXel7hL3uX/1FJNePU9maxO5Q+UBiYHydQ9ozOJKFSsNzYa/GWxX33
 tJwXviIHpmeo3FOl6Z0ub2KdUPqK5336LKKGbikZ/ZTR1HJIFypCciNj1f6Qbj/QRNEr
 +6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Qznel7g6fB8yvYmlOFOQWGexcJCqwQlz1eNoYvx8nfE=;
 b=Z0dnO3S9ZxRnqnEWnBoEYWFrYwgFOzt6sb839ig7QTwDikVY7jgT13GriWE1fiFci0
 hw3h53GhYocHmE8PjcO9iA3xn7i50/6RrF6214UOuDwxxE6ONe3wxM4hSUZLuDUQ9D7q
 jH2/wUK47dY0rfVlBu3xH1VhnAAhS3baQVM8Bpd+tu27PcywS+zqOtTPT+UOiRxWNWS5
 9FazKka79btUxcceTLKVQimqhV4WFTMaTbCL+n7mWeRFHJVJG7YNFrwcEycliarj7ocu
 yWdtI4lEWxCpU/tLbm3mEEqbo78MQD5YnBfgzkjKGwbb9ritWe+PkRva3LFi7r4tsygE
 xESA==
X-Gm-Message-State: APjAAAUA0ZOb/5eBdJtTMnnzJ1AE11ab3Kn9Z7PgDP2X+4ieHwGgRPDJ
 HvdCQZLC9qM7Qv+EAA5xKeWumqjK
X-Google-Smtp-Source: APXvYqzpBChMODW8bDQdh5hmaKOFNTwT1biw+8jIOlcW8q3rgaCygfUZT6UGlrEADf0ipOgVUner9g==
X-Received: by 2002:a7b:c933:: with SMTP id h19mr1621240wml.52.1561081358051; 
 Thu, 20 Jun 2019 18:42:38 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d1sm1123125wru.41.2019.06.20.18.42.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:42:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 03:42:10 +0200
Message-Id: <1561081350-3723-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
References: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 05/25] i386/kvm: move Hyper-V CPUID filling to
 hyperv_handle_properties()
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Let's consolidate Hyper-V features handling in hyperv_handle_properties().
The change is necessary to support 'hv-passthrough' mode as we'll be just
copying CPUIDs from KVM instead of filling them in.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20190517141924.19024-4-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 163 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 90 insertions(+), 73 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index cd492d4..a041b4d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1013,13 +1013,25 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
     return 0;
 }
 
-static int hyperv_handle_properties(CPUState *cs)
+/*
+ * Fill in Hyper-V CPUIDs. Returns the number of entries filled in cpuid_ent in
+ * case of success, errno < 0 in case of failure and 0 when no Hyper-V
+ * extentions are enabled.
+ */
+static int hyperv_handle_properties(CPUState *cs,
+                                    struct kvm_cpuid_entry2 *cpuid_ent)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     struct kvm_cpuid2 *cpuid;
+    struct kvm_cpuid_entry2 *c;
+    uint32_t signature[3];
+    uint32_t cpuid_i = 0;
     int r = 0;
 
+    if (!hyperv_enabled(cpu))
+        return 0;
+
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
         uint16_t evmcs_version;
 
@@ -1068,9 +1080,80 @@ static int hyperv_handle_properties(CPUState *cs)
     /* Not exposed by KVM but needed to make CPU hotplug in Windows work */
     env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
 
+    if (r) {
+        r = -ENOSYS;
+        goto free;
+    }
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
+    if (!cpu->hyperv_vendor_id) {
+        memcpy(signature, "Microsoft Hv", 12);
+    } else {
+        size_t len = strlen(cpu->hyperv_vendor_id);
+
+        if (len > 12) {
+            error_report("hv-vendor-id truncated to 12 characters");
+            len = 12;
+        }
+        memset(signature, 0, 12);
+        memcpy(signature, cpu->hyperv_vendor_id, len);
+    }
+    c->eax = hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ?
+        HV_CPUID_NESTED_FEATURES : HV_CPUID_IMPLEMENT_LIMITS;
+    c->ebx = signature[0];
+    c->ecx = signature[1];
+    c->edx = signature[2];
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_INTERFACE;
+    memcpy(signature, "Hv#1\0\0\0\0\0\0\0\0", 12);
+    c->eax = signature[0];
+    c->ebx = 0;
+    c->ecx = 0;
+    c->edx = 0;
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_VERSION;
+    c->eax = 0x00001bbc;
+    c->ebx = 0x00060001;
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_FEATURES;
+    c->eax = env->features[FEAT_HYPERV_EAX];
+    c->ebx = env->features[FEAT_HYPERV_EBX];
+    c->edx = env->features[FEAT_HYPERV_EDX];
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_ENLIGHTMENT_INFO;
+    c->eax = env->features[FEAT_HV_RECOMM_EAX];
+    c->ebx = cpu->hyperv_spinlock_attempts;
+
+    c = &cpuid_ent[cpuid_i++];
+    c->function = HV_CPUID_IMPLEMENT_LIMITS;
+    c->eax = cpu->hv_max_vps;
+    c->ebx = 0x40;
+
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
+        __u32 function;
+
+        /* Create zeroed 0x40000006..0x40000009 leaves */
+        for (function = HV_CPUID_IMPLEMENT_LIMITS + 1;
+             function < HV_CPUID_NESTED_FEATURES; function++) {
+            c = &cpuid_ent[cpuid_i++];
+            c->function = function;
+        }
+
+        c = &cpuid_ent[cpuid_i++];
+        c->function = HV_CPUID_NESTED_FEATURES;
+        c->eax = env->features[FEAT_HV_NESTED_EAX];
+    }
+    r = cpuid_i;
+
+free:
     g_free(cpuid);
 
-    return r ? -ENOSYS : 0;
+    return r;
 }
 
 static int hyperv_init_vcpu(X86CPU *cpu)
@@ -1179,79 +1262,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     /* Paravirtualization CPUIDs */
-    if (hyperv_enabled(cpu)) {
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
-        if (!cpu->hyperv_vendor_id) {
-            memcpy(signature, "Microsoft Hv", 12);
-        } else {
-            size_t len = strlen(cpu->hyperv_vendor_id);
-
-            if (len > 12) {
-                error_report("hv-vendor-id truncated to 12 characters");
-                len = 12;
-            }
-            memset(signature, 0, 12);
-            memcpy(signature, cpu->hyperv_vendor_id, len);
-        }
-        c->eax = hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ?
-            HV_CPUID_NESTED_FEATURES : HV_CPUID_IMPLEMENT_LIMITS;
-        c->ebx = signature[0];
-        c->ecx = signature[1];
-        c->edx = signature[2];
-
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_INTERFACE;
-        memcpy(signature, "Hv#1\0\0\0\0\0\0\0\0", 12);
-        c->eax = signature[0];
-        c->ebx = 0;
-        c->ecx = 0;
-        c->edx = 0;
-
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_VERSION;
-        c->eax = 0x00001bbc;
-        c->ebx = 0x00060001;
-
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_FEATURES;
-        r = hyperv_handle_properties(cs);
-        if (r) {
-            return r;
-        }
-        c->eax = env->features[FEAT_HYPERV_EAX];
-        c->ebx = env->features[FEAT_HYPERV_EBX];
-        c->edx = env->features[FEAT_HYPERV_EDX];
-
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_ENLIGHTMENT_INFO;
-
-        c->eax = env->features[FEAT_HV_RECOMM_EAX];
-        c->ebx = cpu->hyperv_spinlock_attempts;
-
-        c = &cpuid_data.entries[cpuid_i++];
-        c->function = HV_CPUID_IMPLEMENT_LIMITS;
-
-        c->eax = cpu->hv_max_vps;
-        c->ebx = 0x40;
-
+    r = hyperv_handle_properties(cs, cpuid_data.entries);
+    if (r < 0) {
+        return r;
+    } else if (r > 0) {
+        cpuid_i = r;
         kvm_base = KVM_CPUID_SIGNATURE_NEXT;
         has_msr_hv_hypercall = true;
-
-        if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS)) {
-            __u32 function;
-
-            /* Create zeroed 0x40000006..0x40000009 leaves */
-            for (function = HV_CPUID_IMPLEMENT_LIMITS + 1;
-                 function < HV_CPUID_NESTED_FEATURES; function++) {
-                c = &cpuid_data.entries[cpuid_i++];
-                c->function = function;
-            }
-
-            c = &cpuid_data.entries[cpuid_i++];
-            c->function = HV_CPUID_NESTED_FEATURES;
-            c->eax = env->features[FEAT_HV_NESTED_EAX];
-        }
     }
 
     if (cpu->expose_kvm) {
-- 
1.8.3.1



