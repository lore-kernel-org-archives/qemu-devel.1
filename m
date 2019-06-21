Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACBDC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3F42083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsxcLYib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3F42083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59976 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heI2z-0007Xs-QC
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 07:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49164)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHki-0000no-OS
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkf-0005xi-MI
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1heHkf-0005vX-Gb
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id f17so6233318wme.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 04:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jGOTUhh33OOT1Enfmvtwgh0euyeueOCeP1kgbRTa4fI=;
 b=LsxcLYibqiJwqVVPEgMPe6DHkUaueCP51KdnuJZk3tuNhPrfndHQaUte9pjKJqrs0e
 1VL+rykF7gh+Ed2lzc5qouKZcY9G6gUL6fTAmcMUZRQ4Jef++JtXlJ2nqdcYJHvarMdP
 6BXLIBrKNT9ekStqKF/tRTh/0FzMdxGZSL6XG0fsOsDqs91o6Ni2kNXoS9EkSAdVA2NY
 EifdbT2bh0J/85h6I68upQ/BB2ZCn/JceGldPgIMUwc4/LkhZrbzTo1vy7HLL5WqnwzT
 TPTsF6gzrB8sgq+ZFui1mXEhaQrPkkGN+vDFysCjUMZrjpKCMh3tYEUC2vzL3Mngcrsr
 VmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=jGOTUhh33OOT1Enfmvtwgh0euyeueOCeP1kgbRTa4fI=;
 b=moYBTKGMBp78bw2ybfKKP/VQgSSPv4nQCI0DHA2y462dvBdHd8C0e1a8gbVdzjzTIk
 3Xo9NmHBXRA3hi6WkeAI9DJ28diGvaGPEYKu/cQS6gBSyUGhJ7abEyZv9Gtm/G5PI0C0
 Sk5vUCj2Y/+aYE8tsvAjyblaR3VkxeZWRVf66HBqDCFAqwdpbZn8V9tjF4jUQjMV4rK/
 EUhS5IT5JE9N6ArxjOIS56Wn8PjWCRHXX2D6+VODClu4nYlB2JJzNuPXAzs9Hn3TscFU
 MNzZQwaxFkgBb4XjPFF0c1V51hGYG5aIpSfAcwLENAvi9Fzkqhq8SlhzkDqHeLXYjSXG
 0hWA==
X-Gm-Message-State: APjAAAW8gESPS+nOMqcjmc6S6YYOl1OPwjGtdqSZnjI3byRY1gV3SoJM
 GKBeHlcNuUMksefSRM5NY/NeiJqX
X-Google-Smtp-Source: APXvYqwx3PQfJse8vvms+8JS91gnEzw7tfxRRGjQx1usJmrz7eZ33+SCFuihYGkwl2Lx/OhjP3/uMA==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr3645177wmk.36.1561116639913;
 Fri, 21 Jun 2019 04:30:39 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r3sm2712851wrr.61.2019.06.21.04.30.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 04:30:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:30:12 +0200
Message-Id: <1561116620-22245-18-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PULL 17/25] target/i386: kvm: Block migration for
 vCPUs exposed with nested virtualization
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
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

Commit d98f26073beb ("target/i386: kvm: add VMX migration blocker")
added a migration blocker for vCPU exposed with Intel VMX.
However, migration should also be blocked for vCPU exposed with
AMD SVM.

Both cases should be blocked because QEMU should extract additional
vCPU state from KVM that should be migrated as part of vCPU VMState.
E.g. Whether vCPU is running in guest-mode or host-mode.

Fixes: d98f26073beb ("target/i386: kvm: add VMX migration blocker")
Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20190619162140.133674-6-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c |  6 ------
 target/i386/cpu.h | 12 ++++++++++++
 target/i386/kvm.c | 14 +++++++-------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c330fd9..61e44cb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5215,12 +5215,6 @@ static int x86_cpu_filter_features(X86CPU *cpu)
     return rv;
 }
 
-#define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
-                           (env)->cpuid_vendor2 == CPUID_VENDOR_INTEL_2 && \
-                           (env)->cpuid_vendor3 == CPUID_VENDOR_INTEL_3)
-#define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
-                         (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
-                         (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7f48136..bf0c9c2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -722,6 +722,13 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_VENDOR_HYGON    "HygonGenuine"
 
+#define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
+                           (env)->cpuid_vendor2 == CPUID_VENDOR_INTEL_2 && \
+                           (env)->cpuid_vendor3 == CPUID_VENDOR_INTEL_3)
+#define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
+                         (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
+                         (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
+
 #define CPUID_MWAIT_IBE     (1U << 1) /* Interrupts can exit capability */
 #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
 
@@ -1848,6 +1855,11 @@ static inline int32_t x86_get_a20_mask(CPUX86State *env)
     }
 }
 
+static inline bool cpu_has_vmx(CPUX86State *env)
+{
+    return env->features[FEAT_1_ECX] & CPUID_EXT_VMX;
+}
+
 /* fpu_helper.c */
 void update_fp_status(CPUX86State *env);
 void update_mxcsr_status(CPUX86State *env);
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9864aa0..f9872f1 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1299,7 +1299,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
 }
 
 static Error *invtsc_mig_blocker;
-static Error *vmx_mig_blocker;
+static Error *nested_virt_mig_blocker;
 
 #define KVM_MAX_CPUID_ENTRIES  100
 
@@ -1597,13 +1597,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
                                   !!(c->ecx & CPUID_EXT_SMX);
     }
 
-    if ((env->features[FEAT_1_ECX] & CPUID_EXT_VMX) && !vmx_mig_blocker) {
-        error_setg(&vmx_mig_blocker,
-                   "Nested VMX virtualization does not support live migration yet");
-        r = migrate_add_blocker(vmx_mig_blocker, &local_err);
+    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker) {
+        error_setg(&nested_virt_mig_blocker,
+                   "Nested virtualization does not support live migration yet");
+        r = migrate_add_blocker(nested_virt_mig_blocker, &local_err);
         if (local_err) {
             error_report_err(local_err);
-            error_free(vmx_mig_blocker);
+            error_free(nested_virt_mig_blocker);
             return r;
         }
     }
@@ -1674,7 +1674,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
  fail:
     migrate_del_blocker(invtsc_mig_blocker);
  fail2:
-    migrate_del_blocker(vmx_mig_blocker);
+    migrate_del_blocker(nested_virt_mig_blocker);
 
     return r;
 }
-- 
1.8.3.1



