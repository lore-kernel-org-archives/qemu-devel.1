Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4B5C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA482084E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsy7NQPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA482084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60354 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heIJZ-0006d7-R6
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49137)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkh-0000mu-JS
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHke-0005uf-G9
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:43 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1heHkc-0005hI-Ci
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:40 -0400
Received: by mail-wm1-x343.google.com with SMTP id a15so6005383wmj.5
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 04:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yJQvGCIAx/7TCPsH6MnF6RRvIVhWqu77d3ySjfEx700=;
 b=Wsy7NQPEWK0RolMo9fdHrp9tqDQiAVnTbitD6kAmMkrbVgQz+Datifdpc+mC3Vefm8
 Df7DEYzKOEQ8x8FHeuLKwTpzA7stcUDDN9oII2BEcmaS8LJj0/xKEKbn087yFK+59c0/
 +KlxM5UgLDaM0dQ2PRS19c5Gdnh3+MBl/bp8ZW+8zAmZ+rnqEYqOKS7PHU5cOkdDRn84
 Nf+iPPdS4IKQUXvIA7rMkKNBkDx05063CmFccTQHBPWTJyoRRYjZdnBuebDUwrQNed8I
 0uZIiPd2FhVQuXbKBXyNV//1XZL6IopR3cdNEuEjIN7RBwx9wwIiBShWeUKNd+ygEf9v
 Mzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=yJQvGCIAx/7TCPsH6MnF6RRvIVhWqu77d3ySjfEx700=;
 b=ZSd0NyzHbRzt+ZSZKgO0Rn2UWBVqA2ipTMPsn4oMvP5JgDHKGIY4LCsAtajW78s5FG
 /ooZ6l/X+upX/4hbVgdwPg/s3BECQSzHexOF2iiZiT6AqKmVtSBxckFMBDu57StRogGf
 KfgSrXwQx5YgnJ6WmFLlDUkVDxFaipgdJH0+eThBmwYoC2HUcAWkpjtLGQi8xawPsYQl
 cgVnx9I+s2NJvg0id93WjLhluTK98hw4aKzL0DWtdWobw73u4QgUHg1i0l4hB75TBRbd
 2zPipJecDLZg9/R2Ar59dEWaJM1JE5ew9I87EPbQtBroH3Gmv1mtU8aoWI2f5afxQfCF
 29rQ==
X-Gm-Message-State: APjAAAVWfXLkxxelSV3XqRQ9JLFFw1UW9L6wyh+0W2CFQMi+8cVMz77g
 jAelYA0605kY8AApdJOFrmt/1mpy
X-Google-Smtp-Source: APXvYqx/Xu75/HMWQqpFerPLQ9i4eqnCZNjKoJZ4nWuhvIn6saX66B0atMixq9M1ZCkMznGJaXVCZQ==
X-Received: by 2002:a1c:7f54:: with SMTP id a81mr3896341wmd.170.1561116634470; 
 Fri, 21 Jun 2019 04:30:34 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r3sm2712851wrr.61.2019.06.21.04.30.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 04:30:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:30:07 +0200
Message-Id: <1561116620-22245-13-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 12/25] target/i386: define a new MSR based
 feature word - FEAT_CORE_CAPABILITY
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
Cc: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xiaoyao Li <xiaoyao.li@linux.intel.com>

MSR IA32_CORE_CAPABILITY is a feature-enumerating MSR, which only
enumerates the feature split lock detection (via bit 5) by now.

The existence of MSR IA32_CORE_CAPABILITY is enumerated by CPUID.7_0:EDX[30].

The latest kernel patches about them can be found here:
https://lkml.org/lkml/2019/4/24/1909

Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Message-Id: <20190617153654.916-1-xiaoyao.li@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 22 +++++++++++++++++++++-
 target/i386/cpu.h |  5 +++++
 target/i386/kvm.c |  9 +++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7beb8ab..c330fd9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1085,7 +1085,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", "stibp",
-            NULL, "arch-capabilities", NULL, "ssbd",
+            NULL, "arch-capabilities", "core-capability", "ssbd",
         },
         .cpuid = {
             .eax = 7,
@@ -1203,6 +1203,26 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             }
         },
     },
+    [FEAT_CORE_CAPABILITY] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, "split-lock-detect", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_CORE_CAPABILITY,
+            .cpuid_dep = {
+                FEAT_7_0_EDX,
+                CPUID_7_0_EDX_CORE_CAPABILITY,
+            },
+        },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7470acf..7f48136 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -345,6 +345,7 @@ typedef enum X86Seg {
 #define MSR_IA32_SPEC_CTRL              0x48
 #define MSR_VIRT_SSBD                   0xc001011f
 #define MSR_IA32_PRED_CMD               0x49
+#define MSR_IA32_CORE_CAPABILITY        0xcf
 #define MSR_IA32_ARCH_CAPABILITIES      0x10a
 #define MSR_IA32_TSCDEADLINE            0x6e0
 
@@ -496,6 +497,7 @@ typedef enum FeatureWord {
     FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
     FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
     FEAT_ARCH_CAPABILITIES,
+    FEAT_CORE_CAPABILITY,
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -687,6 +689,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
 #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
+#define CPUID_7_0_EDX_CORE_CAPABILITY   (1U << 30)  /*Core Capability*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
 
 #define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and
@@ -734,6 +737,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY (1U << 3)
 #define MSR_ARCH_CAP_SSB_NO     (1U << 4)
 
+#define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
+
 /* Supported Hyper-V Enlightenments */
 #define HYPERV_FEAT_RELAXED             0
 #define HYPERV_FEAT_VAPIC               1
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index a323b1f..279f99a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -95,6 +95,7 @@ static bool has_msr_spec_ctrl;
 static bool has_msr_virt_ssbd;
 static bool has_msr_smi_count;
 static bool has_msr_arch_capabs;
+static bool has_msr_core_capabs;
 
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -1842,6 +1843,9 @@ static int kvm_get_supported_msrs(KVMState *s)
                 case MSR_IA32_ARCH_CAPABILITIES:
                     has_msr_arch_capabs = true;
                     break;
+                case MSR_IA32_CORE_CAPABILITY:
+                    has_msr_core_capabs = true;
+                    break;
                 }
             }
         }
@@ -2368,6 +2372,11 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
                           env->features[FEAT_ARCH_CAPABILITIES]);
     }
 
+    if (has_msr_core_capabs) {
+        kvm_msr_entry_add(cpu, MSR_IA32_CORE_CAPABILITY,
+                          env->features[FEAT_CORE_CAPABILITY]);
+    }
+
     /*
      * The following MSRs have side effects on the guest or are too heavy
      * for normal writeback. Limit them to reset or full state updates.
-- 
1.8.3.1



