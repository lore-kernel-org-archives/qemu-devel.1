Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8782C10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8A221920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDZF6nru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8A221920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFhwr-0003WR-IV
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 12:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhr9-00059P-6C
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhr7-00039R-PZ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:03 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:46757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhr7-00038e-Ig
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:01 -0400
Received: by mail-wr1-x42c.google.com with SMTP id o18so20444676wrv.13
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=0xYz+BH2rMxrOscxGjnU6A3/paa1HYzKHp1tH86q4D0=;
 b=HDZF6nrueaWcRJKbdBaqNYs48QjtrZ+nPE+IKXL8IS3oVOUgxsq9lQgTSBRF1AetPf
 F5GubME4XdkpNiOPwc76gvcXi6hG/dNTZl3HZ0tnNndsILRug7y4m7rusb3u2uos1x8T
 EaZPaFDBVROXa/KuYicrUfKY0655Fm5ywGeq1YVH8OrfiKyeRTC0seBV9xpep00o3YF5
 LizVzYkbwazjrg2Edi7ntR7gM4xlwwKDRyYpIxhuMijVavdSFURbtaj7vyyf8AID8nTg
 a/Xcx26i1R3IeVISWmw+Dk5a2P8EMejc6ZmGnR54NTm/uV0psY9JdRdYJay1X9hggGDz
 PbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=0xYz+BH2rMxrOscxGjnU6A3/paa1HYzKHp1tH86q4D0=;
 b=icjg4aZkZOkA51ITzcxc06Ba1vnTLYyEtPErz42WhlG5VtctUxJ6J+OwvsCNgw+47b
 x5zDbIAGP9ERI9l9G13ZKkQeXAaD/Dpd/aylR8cpp36dPjbtieUeVyDEyq1gPQwaZgV+
 kAX09vaFbYO+b3vAbO91QbNhUnUk/CAW0GJJzjgYaTW4ZSBFfyrYdbfccS4VT2pTP84U
 lWQyvYWpaSUckLJ9LL3nOF5j6lyQ0SatJNBeC0vNmwggBEF3LLisTUzkNKU6LbtoRgpW
 lg+3KscbDwYiNMCl9YVX3f0laM7s6UuUh4M6kqFclSTdBX/ChYrFQOr88Ju7RVyf00uy
 bT+g==
X-Gm-Message-State: APjAAAUxJDjhfBXFDztqV0QVCpfqpH3Nolv3X16+svKROGunFXlRPGMf
 Q+6b2ViT4sThZ0GKcWemXMDKnro5
X-Google-Smtp-Source: APXvYqwL3y4EI01ZgsW+t+mTq4DEhTaBjrSIoBtQwpEfRpxDsNtSUYlvBYmWdNyXS8ysM6809Ug8qQ==
X-Received: by 2002:adf:f68f:: with SMTP id v15mr901893wrp.210.1570035120288; 
 Wed, 02 Oct 2019 09:52:00 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.51.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:51:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/30] target/i386: add VMX definitions
Date: Wed,  2 Oct 2019 18:51:28 +0200
Message-Id: <1570035113-56848-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These will be used to compile the list of VMX features for named
CPU models, and/or by the code that sets up the VMX MSRs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 130 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c00cc35..23a30e1 100644
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
@@ -750,6 +769,117 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 
 #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
 
+/* VMX MSR features */
+#define MSR_VMX_BASIC_VMCS_REVISION_MASK             0x7FFFFFFFull
+#define MSR_VMX_BASIC_VMXON_REGION_SIZE_MASK         (0x00001FFFull << 32)
+#define MSR_VMX_BASIC_VMCS_MEM_TYPE_MASK             (0x003C0000ull << 32)
+#define MSR_VMX_BASIC_DUAL_MONITOR                   (1ULL << 49)
+#define MSR_VMX_BASIC_INS_OUTS                       (1ULL << 54)
+#define MSR_VMX_BASIC_TRUE_CTLS                      (1ULL << 55)
+
+#define MSR_VMX_MISC_PREEMPTION_TIMER_SHIFT_MASK     0x1Full
+#define MSR_VMX_MISC_STORE_LMA                       (1ULL << 5)
+#define MSR_VMX_MISC_ACTIVITY_HLT                    (1ULL << 6)
+#define MSR_VMX_MISC_ACTIVITY_SHUTDOWN               (1ULL << 7)
+#define MSR_VMX_MISC_ACTIVITY_WAIT_SIPI              (1ULL << 8)
+#define MSR_VMX_MISC_MAX_MSR_LIST_SIZE_MASK          0x0E000000ull
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



