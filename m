Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D62C06513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353942146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9qS+nwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353942146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKSy-0003dF-GX
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57168)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hiKIU-0001tH-9J
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hiKIS-0004vR-H9
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:18 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44261)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hiKIS-0004RK-7U
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id e3so8678205wrs.11
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iOB5P9WVHrwr6z3v5EXEtLiTeQ5jwJgEffaWVd4Prbc=;
 b=N9qS+nwqCDKPZJ05JdEsfyWXyCdM+zYTG3D9g6oXl6qlQqo41LeOvCOct2uZVc1rN/
 5x/iY1RKCYGCzycufzwmBCcS+SK29k4mznoRkynbe6vGhbeldZMDOkvv/KwWxSNwX7wG
 nup64cN6V6xcHRW9lQY1Lxvwn51g7rLv4bIToBZ0tnvsdTzXOlFaox2HN01YlHnHO9G7
 lSmbuJK6akZR2nzqAXWsdXA5v9EevJd9+/UwpFwK7hLOFcCP10BC+sP3mhtlQsGFc0/y
 UBQE9Q2iIds3VGu/NnZMqrzC304kLIY9Bd3c9seoPyyvhNFvG30x849H1kTr5kro4VwH
 Oxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=iOB5P9WVHrwr6z3v5EXEtLiTeQ5jwJgEffaWVd4Prbc=;
 b=cL0nHEct9gM/iC4YRSckV6h1552Ity7YBkv9O3lfNy5f+ob8R5J0MZ8w3GHwkVH7SG
 laTZvZZdnBiZV/dGRjWk1o0nPcXC+GbBeW3lbsnLGsvCMnArtpSsWaoRNCEYUJsnMrAg
 +YK666WNAFAGrVRRKvY2e56+NBIZ1JKJYnU6eow9KneEhEDCq6E6V2+Iml3zhRq3Q6wG
 cMA2Q47wfkZwyWwNC5jJJTSCM6zNTVSo/fxa+TOoWzB7A52aaOff2XcJCzYjjpJYRAOL
 t/6/9tKPGaIYF+S8JzOXZHvlArLJL9aV4c95vkJSH8PFjzfcOV9qB2Zr3YQgkxPM9db0
 D2jQ==
X-Gm-Message-State: APjAAAVQVumgkh1la4kIUn2amtzonFLLSSA/PWpJ7N8Xm39MKOpbV+dH
 ZEZdTYisSXvnBrLY0qTCAXj5Ymcy5qQ=
X-Google-Smtp-Source: APXvYqwcDsg21/kCxdCYiThnZThTR5/hvIIY73yRehu0y6PG3aYoLrZV0nCk9y4WqWkKjoxF8bzGdQ==
X-Received: by 2002:adf:f104:: with SMTP id r4mr25568225wro.140.1562079687839; 
 Tue, 02 Jul 2019 08:01:27 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id m24sm3006262wmi.39.2019.07.02.08.01.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 08:01:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:01:18 +0200
Message-Id: <1562079681-19204-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 4/7] target/i386: add VMX definitions
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
Cc: Liran Alon <liran.alon@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These will be used to compile the list of VMX features for named
CPU models, and/or by the code that sets up the VMX MSRs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4e5dc30..ec479d5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -452,6 +452,25 @@ typedef enum X86Seg {
 #define MSR_IA32_BNDCFGS                0x00000d90
 #define MSR_IA32_XSS                    0x00000da0
 
+#define MSR_IA32_VMX_BASIC              0x00000480
+#define MSR_IA32_VMX_PINBASED_CTLS      0x00000481
+#define MSR_IA32_VMX_PROCBASED_CTLS     0x00000482
+#define MSR_IA32_VMX_EXIT_CTLS          0x00000483
+#define MSR_IA32_VMX_ENTRY_CTLS         0x00000484
+#define MSR_IA32_VMX_MISC               0x00000485
+#define MSR_IA32_VMX_CR0_FIXED0         0x00000486
+#define MSR_IA32_VMX_CR0_FIXED1         0x00000487
+#define MSR_IA32_VMX_CR4_FIXED0         0x00000488
+#define MSR_IA32_VMX_CR4_FIXED1         0x00000489
+#define MSR_IA32_VMX_VMCS_ENUM          0x0000048a
+#define MSR_IA32_VMX_PROCBASED_CTLS2    0x0000048b
+#define MSR_IA32_VMX_EPT_VPID_CAP       0x0000048c
+#define MSR_IA32_VMX_TRUE_PINBASED_CTLS  0x0000048d
+#define MSR_IA32_VMX_TRUE_PROCBASED_CTLS 0x0000048e
+#define MSR_IA32_VMX_TRUE_EXIT_CTLS      0x0000048f
+#define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
+#define MSR_IA32_VMX_VMFUNC             0x00000491
+
 #define XSTATE_FP_BIT                   0
 #define XSTATE_SSE_BIT                  1
 #define XSTATE_YMM_BIT                  2
@@ -746,6 +765,112 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 
 #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
 
+/* VMX MSR features */
+#define MSR_VMX_BASIC_DUAL_MONITOR                   (1ULL << 49)
+#define MSR_VMX_BASIC_INS_OUTS                       (1ULL << 54)
+#define MSR_VMX_BASIC_TRUE_CTLS                      (1ULL << 55)
+
+#define MSR_VMX_MISC_STORE_LMA                       (1ULL << 5)
+#define MSR_VMX_MISC_ACTIVITY_HLT                    (1ULL << 6)
+#define MSR_VMX_MISC_ACTIVITY_SHUTDOWN               (1ULL << 7)
+#define MSR_VMX_MISC_ACTIVITY_WAIT_SIPI              (1ULL << 8)
+#define MSR_VMX_MISC_VMWRITE_VMEXIT                  (1ULL << 29)
+#define MSR_VMX_MISC_ZERO_LEN_INJECT                 (1ULL << 30)
+
+#define MSR_VMX_EPT_EXECONLY                         (1ULL << 0)
+#define MSR_VMX_EPT_PAGE_WALK_LENGTH_4               (1ULL << 6)
+#define MSR_VMX_EPT_PAGE_WALK_LENGTH_5               (1ULL << 7)
+#define MSR_VMX_EPT_UC                               (1ULL << 8)
+#define MSR_VMX_EPT_WB                               (1ULL << 14)
+#define MSR_VMX_EPT_2MB                              (1ULL << 16)
+#define MSR_VMX_EPT_1GB                              (1ULL << 17)
+#define MSR_VMX_EPT_INVEPT                           (1ULL << 20)
+#define MSR_VMX_EPT_AD_BITS                          (1ULL << 21)
+#define MSR_VMX_EPT_ADVANCED_VMEXIT_INFO             (1ULL << 22)
+#define MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT            (1ULL << 25)
+#define MSR_VMX_EPT_INVEPT_ALL_CONTEXT               (1ULL << 26)
+#define MSR_VMX_EPT_INVVPID                          (1ULL << 32)
+#define MSR_VMX_EPT_INVVPID_SINGLE_ADDR              (1ULL << 40)
+#define MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT           (1ULL << 41)
+#define MSR_VMX_EPT_INVVPID_ALL_CONTEXT              (1ULL << 42)
+#define MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS (1ULL << 43)
+
+#define MSR_VMX_VMFUNC_EPT_SWITCHING                 (1ULL << 0)
+
+
+/* VMX controls */
+#define VMX_CPU_BASED_VIRTUAL_INTR_PENDING          0x00000004
+#define VMX_CPU_BASED_USE_TSC_OFFSETING             0x00000008
+#define VMX_CPU_BASED_HLT_EXITING                   0x00000080
+#define VMX_CPU_BASED_INVLPG_EXITING                0x00000200
+#define VMX_CPU_BASED_MWAIT_EXITING                 0x00000400
+#define VMX_CPU_BASED_RDPMC_EXITING                 0x00000800
+#define VMX_CPU_BASED_RDTSC_EXITING                 0x00001000
+#define VMX_CPU_BASED_CR3_LOAD_EXITING              0x00008000
+#define VMX_CPU_BASED_CR3_STORE_EXITING             0x00010000
+#define VMX_CPU_BASED_CR8_LOAD_EXITING              0x00080000
+#define VMX_CPU_BASED_CR8_STORE_EXITING             0x00100000
+#define VMX_CPU_BASED_TPR_SHADOW                    0x00200000
+#define VMX_CPU_BASED_VIRTUAL_NMI_PENDING           0x00400000
+#define VMX_CPU_BASED_MOV_DR_EXITING                0x00800000
+#define VMX_CPU_BASED_UNCOND_IO_EXITING             0x01000000
+#define VMX_CPU_BASED_USE_IO_BITMAPS                0x02000000
+#define VMX_CPU_BASED_MONITOR_TRAP_FLAG             0x08000000
+#define VMX_CPU_BASED_USE_MSR_BITMAPS               0x10000000
+#define VMX_CPU_BASED_MONITOR_EXITING               0x20000000
+#define VMX_CPU_BASED_PAUSE_EXITING                 0x40000000
+#define VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS   0x80000000
+
+#define VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES 0x00000001
+#define VMX_SECONDARY_EXEC_ENABLE_EPT               0x00000002
+#define VMX_SECONDARY_EXEC_DESC                     0x00000004
+#define VMX_SECONDARY_EXEC_RDTSCP                   0x00000008
+#define VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE   0x00000010
+#define VMX_SECONDARY_EXEC_ENABLE_VPID              0x00000020
+#define VMX_SECONDARY_EXEC_WBINVD_EXITING           0x00000040
+#define VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST       0x00000080
+#define VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT       0x00000100
+#define VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY    0x00000200
+#define VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING       0x00000400
+#define VMX_SECONDARY_EXEC_RDRAND_EXITING           0x00000800
+#define VMX_SECONDARY_EXEC_ENABLE_INVPCID           0x00001000
+#define VMX_SECONDARY_EXEC_ENABLE_VMFUNC            0x00002000
+#define VMX_SECONDARY_EXEC_SHADOW_VMCS              0x00004000
+#define VMX_SECONDARY_EXEC_ENCLS_EXITING            0x00008000
+#define VMX_SECONDARY_EXEC_RDSEED_EXITING           0x00010000
+#define VMX_SECONDARY_EXEC_ENABLE_PML               0x00020000
+#define VMX_SECONDARY_EXEC_XSAVES                   0x00100000
+
+#define VMX_PIN_BASED_EXT_INTR_MASK                 0x00000001
+#define VMX_PIN_BASED_NMI_EXITING                   0x00000008
+#define VMX_PIN_BASED_VIRTUAL_NMIS                  0x00000020
+#define VMX_PIN_BASED_VMX_PREEMPTION_TIMER          0x00000040
+#define VMX_PIN_BASED_POSTED_INTR                   0x00000080
+
+#define VMX_VM_EXIT_SAVE_DEBUG_CONTROLS             0x00000004
+#define VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE            0x00000200
+#define VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL      0x00001000
+#define VMX_VM_EXIT_ACK_INTR_ON_EXIT                0x00008000
+#define VMX_VM_EXIT_SAVE_IA32_PAT                   0x00040000
+#define VMX_VM_EXIT_LOAD_IA32_PAT                   0x00080000
+#define VMX_VM_EXIT_SAVE_IA32_EFER                  0x00100000
+#define VMX_VM_EXIT_LOAD_IA32_EFER                  0x00200000
+#define VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER       0x00400000
+#define VMX_VM_EXIT_CLEAR_BNDCFGS                   0x00800000
+#define VMX_VM_EXIT_PT_CONCEAL_PIP                  0x01000000
+#define VMX_VM_EXIT_CLEAR_IA32_RTIT_CTL             0x02000000
+
+#define VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS            0x00000004
+#define VMX_VM_ENTRY_IA32E_MODE                     0x00000200
+#define VMX_VM_ENTRY_SMM                            0x00000400
+#define VMX_VM_ENTRY_DEACT_DUAL_MONITOR             0x00000800
+#define VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL     0x00002000
+#define VMX_VM_ENTRY_LOAD_IA32_PAT                  0x00004000
+#define VMX_VM_ENTRY_LOAD_IA32_EFER                 0x00008000
+#define VMX_VM_ENTRY_LOAD_BNDCFGS                   0x00010000
+#define VMX_VM_ENTRY_PT_CONCEAL_PIP                 0x00020000
+#define VMX_VM_ENTRY_LOAD_IA32_RTIT_CTL             0x00040000
+
 /* Supported Hyper-V Enlightenments */
 #define HYPERV_FEAT_RELAXED             0
 #define HYPERV_FEAT_VAPIC               1
-- 
1.8.3.1



