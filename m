Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A693CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E9C20650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keDUGG/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E9C20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfC8-0002Ne-Tb
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdj7-000882-51
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdj1-0007nD-SO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdj1-0007mo-Kl
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:27 -0400
Received: by mail-wm1-x341.google.com with SMTP id n7so2167426wmc.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fkvm9nrySjtGqEqh6sk4DK7nSHHS/gX3BsRBOkEFvus=;
 b=keDUGG/yBFtGV3tw0WN+roAJAig/BbaIL5TL8UsKIMmHKdZrNGNomWs8vvDGXJZJQc
 4hvk5IqjzwP3RQqJ+tRKAEvq7QXbgihs0K9luApE6DuOCquBPozsHknbVvj12wwfBqdU
 Ula6s90gUqrZEN5BD6bGJDYPli23wLEGWVHsJJYcdZIwlD3+0HfDsPkz8085BcgWGM7f
 yyUkjlPZci87gV+dbIWRHqqiHsvNAOmptXzQUR1WXlkURYFKpZ/d9BGnUy68f7yWUA85
 X+T79EyMyNNnO9LHWiFWjs2j6ufdxyJ9kAWMxj9hzkm/psva+ZskX9bsJpod5xaLAOXz
 HYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=fkvm9nrySjtGqEqh6sk4DK7nSHHS/gX3BsRBOkEFvus=;
 b=FoMt3pnre1gCkR8IK4zQs4WLU8Vu4WBTsJt1sz8S5eRL/xPdEp3QefXQiV8/8A0egh
 k2WCZfvWLfOPhDRSqxX7FHg2mfaJvWXeWtVZQG40NLRW0NC6U49oUvRLho3H37fsMhY4
 wQxPYAiK4S/78Kn6cupMdwbLjxxM8OqGABRqk0auyyKsRarH6uyrJoiTtz9U2UA67WrZ
 xiUXlcpWwVjwk7n+ZzeZw2ha0ruPI6aFL8MEGbVRQ2cu91IKcd9BfF42Vd7UzPR2Zpa5
 c6MZMTXafOfqsTcBt3EwUetHE+Zi+DfppirugxNJHSLlUu4eeURkAhOxcAEiqv7W16p1
 RBuA==
X-Gm-Message-State: APjAAAWYLH+wEfAD31pg/YZgfW2qXDRLPKAaqIFr2DVPOmFNw+mFG9e7
 BpZmeiaOfhnmqLhGUwywtPudC9Wz
X-Google-Smtp-Source: APXvYqyFt9a5EGOmmNolhHIF2RhmlnTgzXeu+AsTZkhVqNvnIkmUcx6GqhI1YugNJWoagccy6cxg5g==
X-Received: by 2002:a1c:2d49:: with SMTP id t70mr432720wmt.131.1571925866214; 
 Thu, 24 Oct 2019 07:04:26 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/39] target/i386: Add support for save/load
 IA32_UMWAIT_CONTROL MSR
Date: Thu, 24 Oct 2019 16:03:42 +0200
Message-Id: <1571925835-31930-27-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, Tao Xu <tao3.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tao Xu <tao3.xu@intel.com>

UMWAIT and TPAUSE instructions use 32bits IA32_UMWAIT_CONTROL at MSR
index E1H to determines the maximum time in TSC-quanta that the processor
can reside in either C0.1 or C0.2.

This patch is to Add support for save/load IA32_UMWAIT_CONTROL MSR in
guest.

Co-developed-by: Jingqi Liu <jingqi.liu@intel.com>
Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20191011074103.30393-3-tao3.xu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     |  2 ++
 target/i386/kvm.c     | 13 +++++++++++++
 target/i386/machine.c | 20 ++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 112f867..b772e82 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -452,6 +452,7 @@ typedef enum X86Seg {
 
 #define MSR_IA32_BNDCFGS                0x00000d90
 #define MSR_IA32_XSS                    0x00000da0
+#define MSR_IA32_UMWAIT_CONTROL         0xe1
 
 #define MSR_IA32_VMX_BASIC              0x00000480
 #define MSR_IA32_VMX_PINBASED_CTLS      0x00000481
@@ -1587,6 +1588,7 @@ typedef struct CPUX86State {
     uint16_t fpregs_format_vmstate;
 
     uint64_t xss;
+    uint32_t umwait;
 
     TPRAccess tpr_access_type;
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 94c2339..bfd09bd 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -95,6 +95,7 @@ static bool has_msr_hv_stimer;
 static bool has_msr_hv_frequencies;
 static bool has_msr_hv_reenlightenment;
 static bool has_msr_xss;
+static bool has_msr_umwait;
 static bool has_msr_spec_ctrl;
 static bool has_msr_virt_ssbd;
 static bool has_msr_smi_count;
@@ -2005,6 +2006,9 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_XSS:
                 has_msr_xss = true;
                 break;
+            case MSR_IA32_UMWAIT_CONTROL:
+                has_msr_umwait = true;
+                break;
             case HV_X64_MSR_CRASH_CTL:
                 has_msr_hv_crash = true;
                 break;
@@ -2684,6 +2688,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     if (has_msr_xss) {
         kvm_msr_entry_add(cpu, MSR_IA32_XSS, env->xss);
     }
+    if (has_msr_umwait) {
+        kvm_msr_entry_add(cpu, MSR_IA32_UMWAIT_CONTROL, env->umwait);
+    }
     if (has_msr_spec_ctrl) {
         kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, env->spec_ctrl);
     }
@@ -3097,6 +3104,9 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (has_msr_xss) {
         kvm_msr_entry_add(cpu, MSR_IA32_XSS, 0);
     }
+    if (has_msr_umwait) {
+        kvm_msr_entry_add(cpu, MSR_IA32_UMWAIT_CONTROL, 0);
+    }
     if (has_msr_spec_ctrl) {
         kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, 0);
     }
@@ -3349,6 +3359,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_XSS:
             env->xss = msrs[i].data;
             break;
+        case MSR_IA32_UMWAIT_CONTROL:
+            env->umwait = msrs[i].data;
+            break;
         default:
             if (msrs[i].index >= MSR_MC0_CTL &&
                 msrs[i].index < MSR_MC0_CTL + (env->mcg_cap & 0xff) * 4) {
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 2767b30..6481f84 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -943,6 +943,25 @@ static const VMStateDescription vmstate_xss = {
     }
 };
 
+static bool umwait_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->umwait != 0;
+}
+
+static const VMStateDescription vmstate_umwait = {
+    .name = "cpu/umwait",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = umwait_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.umwait, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 #ifdef TARGET_X86_64
 static bool pkru_needed(void *opaque)
 {
@@ -1391,6 +1410,7 @@ VMStateDescription vmstate_x86_cpu = {
         &vmstate_msr_hyperv_reenlightenment,
         &vmstate_avx512,
         &vmstate_xss,
+        &vmstate_umwait,
         &vmstate_tsc_khz,
         &vmstate_msr_smi_count,
 #ifdef TARGET_X86_64
-- 
1.8.3.1



