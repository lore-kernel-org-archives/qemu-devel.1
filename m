Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0FAC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B9F208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRsQOzfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B9F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59992 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heI5I-0001aw-9o
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 07:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49044)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHka-0000hb-CI
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkW-0005YJ-8p
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:36 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:51021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1heHkW-0005V5-15
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id c66so6035179wmf.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 04:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HAAne3y/gROX4bU2C72LMlD4mSuvEZFb/lzmz3j4hms=;
 b=aRsQOzfFlJ7SUog+PSDnEfue3a52L44GPhkTjV8O6fCWQJO/0ZsyH6UmjtOA16VnMT
 t7W3MOho8lw8W1tXHGFwzRrSOXCWJnoYF41SFR9qdb7c7CYGPSeNtVl7oKNUY4hYSQ0g
 oPKNknuc1t5VCDnliamzLRFPL+1XCCbbB7Lorc8TNF/+LxFkp7UCOPZR8vkYzB744Pgn
 HrvPfIdTI3twTapZPDGuHneyBNfTCXRyaH5ynVKhaWdfRbqF+PuqcmxSK8oz09HGTr9t
 PhnkjgByNEC3HgwZmA0AnAXuqp2x9DpnNW/AmdoTNHuJlgv+3onoEB6Ua+6hLtoUM+Kw
 DOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=HAAne3y/gROX4bU2C72LMlD4mSuvEZFb/lzmz3j4hms=;
 b=Pc/5tiSfIs2w0jBC602v83SEDSkfjao+BOM5zyh/ANipfR3rkkn+/Nn/Y387ZMTKwV
 wVmiIXuNl0prOZYPUIpPe++EI4yJX1PdoogPZGXQkujxZhLKFy46tUBFEdzEejV33Apf
 dJMCXJ+u44ovVnIrV1XMfQ4NirOWTk8yjvbhuCR+0wHIdJIAIMeX108ECpXxPMx9uUUH
 BjdB43AxgRt+NcQfVl90naW3v0uYOgSHD9VEhSkrAbkH+VpGJWI570A2np20iTzJ0Ycl
 leezsO/LDIbFHISlII3HGhajB4ascOGDekDmVUA3j8eCQzT7fWkG33Uj4o9mOz71z2aD
 hrsQ==
X-Gm-Message-State: APjAAAW1zfUgOj5BYZL0XVVGx+lK+I8K7gWt+kfxnAvUbGnP8GWObzBM
 68uLQ0OwXR7j/EDfF+aWnq3bwbY3
X-Google-Smtp-Source: APXvYqyG5BrQN1PUI/eKhI1tgGenUMLv3s8wYiseKBj/N1e94pZZvVflVS9nuijn3DP6M//+LRl3/Q==
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr3480297wmj.87.1561116630797; 
 Fri, 21 Jun 2019 04:30:30 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r3sm2712851wrr.61.2019.06.21.04.30.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 04:30:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:30:03 +0200
Message-Id: <1561116620-22245-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: [Qemu-devel] [PULL 08/25] i386/kvm: hv-stimer requires hv-time and
 hv-synic
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

Synthetic timers operate in hv-time time and Windows won't use these
without SynIC.

Add .dependencies field to kvm_hyperv_properties[] and a generic mechanism
to check dependencies between features.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20190517141924.19024-7-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 93ac6ba..58afa31 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -689,6 +689,7 @@ static struct {
         uint32_t fw;
         uint32_t bits;
     } flags[2];
+    uint64_t dependencies;
 } kvm_hyperv_properties[] = {
     [HYPERV_FEAT_RELAXED] = {
         .desc = "relaxed timing (hv-relaxed)",
@@ -756,7 +757,8 @@ static struct {
         .flags = {
             {.fw = FEAT_HYPERV_EAX,
              .bits = HV_SYNTIMERS_AVAILABLE}
-        }
+        },
+        .dependencies = BIT(HYPERV_FEAT_SYNIC) | BIT(HYPERV_FEAT_TIME)
     },
     [HYPERV_FEAT_FREQUENCIES] = {
         .desc = "frequency MSRs (hv-frequencies)",
@@ -986,12 +988,25 @@ static int hv_cpuid_check_and_set(CPUState *cs, struct kvm_cpuid2 *cpuid,
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     uint32_t r, fw, bits;
-    int i;
+    uint64_t deps;
+    int i, dep_feat = 0;
 
     if (!hyperv_feat_enabled(cpu, feature) && !cpu->hyperv_passthrough) {
         return 0;
     }
 
+    deps = kvm_hyperv_properties[feature].dependencies;
+    while ((dep_feat = find_next_bit(&deps, 64, dep_feat)) < 64) {
+        if (!(hyperv_feat_enabled(cpu, dep_feat))) {
+                fprintf(stderr,
+                        "Hyper-V %s requires Hyper-V %s\n",
+                        kvm_hyperv_properties[feature].desc,
+                        kvm_hyperv_properties[dep_feat].desc);
+                return 1;
+        }
+        dep_feat++;
+    }
+
     for (i = 0; i < ARRAY_SIZE(kvm_hyperv_properties[feature].flags); i++) {
         fw = kvm_hyperv_properties[feature].flags[i].fw;
         bits = kvm_hyperv_properties[feature].flags[i].bits;
@@ -1107,11 +1122,11 @@ static int hyperv_handle_properties(CPUState *cs,
     r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_EVMCS);
     r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_IPI);
 
-    /* Dependencies */
+    /* Additional dependencies not covered by kvm_hyperv_properties[] */
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
         !cpu->hyperv_synic_kvm_only &&
         !hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)) {
-        fprintf(stderr, "Hyper-V %s requires %s\n",
+        fprintf(stderr, "Hyper-V %s requires Hyper-V %s\n",
                 kvm_hyperv_properties[HYPERV_FEAT_SYNIC].desc,
                 kvm_hyperv_properties[HYPERV_FEAT_VPINDEX].desc);
         r |= 1;
-- 
1.8.3.1



