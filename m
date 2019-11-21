Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_75_100,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA82C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E39206CB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP/OhevH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E39206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXnNQ-0007Jo-Fi
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iXnMD-0006JN-AT
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iXnM8-0003e8-SL
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:22:53 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:35687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iXnM5-0003bl-0Z
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:22:47 -0500
Received: by mail-wm1-x32d.google.com with SMTP id 8so3942513wmo.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 06:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=Mg4Hjr1OjuLesDowf9RwTmIcA+k8DkMN24/y+TeFJAI=;
 b=lP/OhevHnyPT7XTjt2cH/rFZcw4NlkW63tTuamH4XjeG5mJ54SYxnI5wpm6y7HQuVj
 KwdBX6ZFBN2FP59DSPXJTMvsYSQtws70tBUgzTrG8O+tkwrZUjXlAnzlNlJ4fe/vBuwl
 itjpXlUkqzfxcGPs7l6Fzgb+YttkzPSNaw5uYX/8T8tnoXqfXfkCodzxtROP5ZngJ8x3
 ETzNnQCk2CxGgRX6//W8OEL/Zrh/l9SoLdX20kVbFcwwaTIyHvLIwP94dg8tP9WWJQiZ
 NcyxV/8kpuu+pnaAPHDvrP+2TkoWq5u9akLTvPTXNq9895vsAAC5dR0/aNMKMjAS/fqI
 4CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=Mg4Hjr1OjuLesDowf9RwTmIcA+k8DkMN24/y+TeFJAI=;
 b=Frcp/oEEp9nov5SiLXMRcBmm3dmiJt7+AsYHR5kn3fHqHalrWQyZ2y142VQAEN0Hv0
 JeXiMXgK88fUI0TLlk7ScUjjhKL+URGtX0XPqtFH5ju88gVLnBMgTCrsv4tirmXKxX40
 awgrB0M2ADKJzhloK6iBIbrJce2fTvKul/U5XR+wRwlMrvIxcQoJl1o3z/K55hod+0E9
 sevFAvrY8vaUUiAPvUXWUWO7BZARVCBIeUl5FAo/We2hicOUfufTrK6ZwbQnAddQVhM4
 +KXIwT5+Dvn36uDnZkQsNKuKX5UX5uLgR2NIXeBnceqVWPQTBL6yKvc2tDlbn3/QhRkN
 Zfyg==
X-Gm-Message-State: APjAAAVeuyKvRqOEDy3UvvQpwuziG/afe5i4TvYAAfyPz/kFQqh0Lz+C
 jz5Xj4kr1VuPqRU6RzFAp9Al67Z+
X-Google-Smtp-Source: APXvYqz+QETwykwqaWkpP8AzMC3TfHVkq23TUt3WjYJUf221souiIadZQWIu7Yi0Pge5pWcphvsGQA==
X-Received: by 2002:a1c:39c2:: with SMTP id g185mr10036270wma.88.1574346161851; 
 Thu, 21 Nov 2019 06:22:41 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id 189sm3344770wme.28.2019.11.21.06.22.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Nov 2019 06:22:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] target/i386: add VMX features to named CPU models
Date: Thu, 21 Nov 2019 15:22:37 +0100
Message-Id: <1574346157-3185-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows using "-cpu Haswell,+vmx", which we did not really want to
support in QEMU but was produced by Libvirt when using the "host-model"
CPU model.

This was produced from the output of scripts/kvm/vmxcap using the following
very ugly Python script:

    bits = {
            'INS/OUTS instruction information': ['FEAT_VMX_BASIC', 'MSR_VMX_BASIC_INS_OUTS'],
            'IA32_VMX_TRUE_*_CTLS support': ['FEAT_VMX_BASIC', 'MSR_VMX_BASIC_TRUE_CTLS'],
            'External interrupt exiting': ['FEAT_VMX_PINBASED_CTLS', 'VMX_PIN_BASED_EXT_INTR_MASK'],
            'NMI exiting': ['FEAT_VMX_PINBASED_CTLS', 'VMX_PIN_BASED_NMI_EXITING'],
            'Virtual NMIs': ['FEAT_VMX_PINBASED_CTLS', 'VMX_PIN_BASED_VIRTUAL_NMIS'],
            'Activate VMX-preemption timer': ['FEAT_VMX_PINBASED_CTLS', 'VMX_PIN_BASED_VMX_PREEMPTION_TIMER'],
            'Process posted interrupts': ['FEAT_VMX_PINBASED_CTLS', 'VMX_PIN_BASED_POSTED_INTR'],
            'Interrupt window exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_VIRTUAL_INTR_PENDING'],
            'Use TSC offsetting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_USE_TSC_OFFSETING'],
            'HLT exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_HLT_EXITING'],
            'INVLPG exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_INVLPG_EXITING'],
            'MWAIT exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_MWAIT_EXITING'],
            'RDPMC exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_RDPMC_EXITING'],
            'RDTSC exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_RDTSC_EXITING'],
            'CR3-load exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_CR3_LOAD_EXITING'],
            'CR3-store exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_CR3_STORE_EXITING'],
            'CR8-load exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_CR8_LOAD_EXITING'],
            'CR8-store exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_CR8_STORE_EXITING'],
            'Use TPR shadow': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_TPR_SHADOW'],
            'NMI-window exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_VIRTUAL_NMI_PENDING'],
            'MOV-DR exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_MOV_DR_EXITING'],
            'Unconditional I/O exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_UNCOND_IO_EXITING'],
            'Use I/O bitmaps': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_USE_IO_BITMAPS'],
            'Monitor trap flag': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_MONITOR_TRAP_FLAG'],
            'Use MSR bitmaps': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_USE_MSR_BITMAPS'],
            'MONITOR exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_MONITOR_EXITING'],
            'PAUSE exiting': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_PAUSE_EXITING'],
            'Activate secondary control': ['FEAT_VMX_PROCBASED_CTLS', 'VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS'],
            'Virtualize APIC accesses': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES'],
            'Enable EPT': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_ENABLE_EPT'],
            'Descriptor-table exiting': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_DESC'],
            'Enable RDTSCP': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_RDTSCP'],
            'Virtualize x2APIC mode': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE'],
            'Enable VPID': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_ENABLE_VPID'],
            'WBINVD exiting': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_WBINVD_EXITING'],
            'Unrestricted guest': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST'],
            'APIC register emulation': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT'],
            'Virtual interrupt delivery': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY'],
            'PAUSE-loop exiting': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING'],
            'RDRAND exiting': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_RDRAND_EXITING'],
            'Enable INVPCID': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_ENABLE_INVPCID'],
            'Enable VM functions': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_ENABLE_VMFUNC'],
            'VMCS shadowing': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_SHADOW_VMCS'],
            'RDSEED exiting': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_RDSEED_EXITING'],
            'Enable PML': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_ENABLE_PML'],
            'Enable XSAVES/XRSTORS': ['FEAT_VMX_SECONDARY_CTLS', 'VMX_SECONDARY_EXEC_XSAVES'],
            'Save debug controls': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_SAVE_DEBUG_CONTROLS'],
            'Load IA32_PERF_GLOBAL_CTRL': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL'],
            'Acknowledge interrupt on exit': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_ACK_INTR_ON_EXIT'],
            'Save IA32_PAT': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_SAVE_IA32_PAT'],
            'Load IA32_PAT': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_LOAD_IA32_PAT'],
            'Save IA32_EFER': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_SAVE_IA32_EFER'],
            'Load IA32_EFER': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_LOAD_IA32_EFER'],
            'Save VMX-preemption timer value': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER'],
            'Clear IA32_BNDCFGS': ['FEAT_VMX_EXIT_CTLS', 'VMX_VM_EXIT_CLEAR_BNDCFGS'],
            'Load debug controls': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS'],
            'IA-32e mode guest': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_IA32E_MODE'],
            'Load IA32_PERF_GLOBAL_CTRL': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL'],
            'Load IA32_PAT': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_LOAD_IA32_PAT'],
            'Load IA32_EFER': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_LOAD_IA32_EFER'],
            'Load IA32_BNDCFGS': ['FEAT_VMX_ENTRY_CTLS', 'VMX_VM_ENTRY_LOAD_BNDCFGS'],
            'Store EFER.LMA into IA-32e mode guest control': ['FEAT_VMX_MISC', 'MSR_VMX_MISC_STORE_LMA'],
            'HLT activity state': ['FEAT_VMX_MISC', 'MSR_VMX_MISC_ACTIVITY_HLT'],
            'VMWRITE to VM-exit information fields': ['FEAT_VMX_MISC', 'MSR_VMX_MISC_VMWRITE_VMEXIT'],
            'Inject event with insn length=0': ['FEAT_VMX_MISC', 'MSR_VMX_MISC_ZERO_LEN_INJECT'],
            'Execute-only EPT translations': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_EXECONLY'],
            'Page-walk length 4': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_PAGE_WALK_LENGTH_4'],
            'Paging-structure memory type WB': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_WB'],
            '2MB EPT pages': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_2MB | MSR_VMX_EPT_1GB'],
            'INVEPT supported': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVEPT'],
            'EPT accessed and dirty flags': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_AD_BITS'],
            'Single-context INVEPT': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT'],
            'All-context INVEPT': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVEPT_ALL_CONTEXT'],
            'INVVPID supported': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVVPID'],
            'Individual-address INVVPID': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVVPID_SINGLE_ADDR'],
            'Single-context INVVPID': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT'],
            'All-context INVVPID': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVVPID_ALL_CONTEXT'],
            'Single-context-retaining-globals INVVPID': ['FEAT_VMX_EPT_VPID_CAPS', 'MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS'],
            'EPTP Switching': ['FEAT_VMX_VMFUNC', 'MSR_VMX_VMFUNC_EPT_SWITCHING']
    }

    import sys
    import textwrap

    out = {}
    for l in sys.stdin.readlines():
        l = l.rstrip()
        if l.endswith('!!'):
            l = l[:-2].rstrip()
        if l.startswith('    ') and (l.endswith('default') or l.endswith('yes')):
            l = l[4:]
            for key, value in bits.items():
                if l.startswith(key):
                    ctl, bit = value
                    if ctl in out:
                        out[ctl] = out[ctl] + ' | '
                    else:
                        out[ctl] = '    [%s] = ' % ctl
                    out[ctl] = out[ctl] + bit

    for x in sorted(out.keys()):
        print("\n         ".join(textwrap.wrap(out[x] + ",")))

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
v1->v2: add list of missing features
        remove VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE
        add RDSEED and PML to Broadwell and newer
        omit host address space size, which QEMU can infer automatically

v2->v3: list more missing features
        add exit controls for "Load PERF_GLOBAL_CTRL", "Load PAT", "Load EFER"
        add VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS
        remove VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING

 target/i386/cpu.c | 705 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 705 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 296b491..056874f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1799,6 +1799,34 @@ static CPUCaches epyc_cache_info = {
     },
 };
 
+/* The following VMX features are not supported by KVM and are left out in the
+ * CPU definitions:
+ *
+ *  Dual-monitor support (all processors)
+ *  Entry to SMM
+ *  Deactivate dual-monitor treatment
+ *  Number of CR3-target values
+ *  Shutdown activity state
+ *  Wait-for-SIPI activity state
+ *  PAUSE-loop exiting (Westmere and newer)
+ *  EPT-violation #VE (Broadwell and newer)
+ *  Inject event with insn length=0 (Skylake and newer)
+ *  Conceal non-root operation from PT
+ *  Conceal VM exits from PT
+ *  Conceal VM entries from PT
+ *  Enable ENCLS exiting
+ *  Mode-based execute control (XS/XU)
+ *  TSC scaling (Skylake Server and newer)
+ *  GPA translation for PT (IceLake and newer)
+ *  User wait and pause
+ *  ENCLV exiting
+ *  Load IA32_RTIT_CTL
+ *  Clear IA32_RTIT_CTL
+ *  Advanced VM-exit information for EPT violations
+ *  Sub-page write permissions
+ *  PT in VMX operation
+ */
+
 static X86CPUDefinition builtin_x86_defs[] = {
     {
         .name = "qemu64",
@@ -1873,6 +1901,24 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_LAHF_LM,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES,
         .xlevel = 0x80000008,
         .model_id = "Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40GHz",
     },
@@ -1900,6 +1946,20 @@ static X86CPUDefinition builtin_x86_defs[] = {
                     CPUID_EXT3_OSVW, CPUID_EXT3_IBS, CPUID_EXT3_SVM */
         .features[FEAT_8000_0001_ECX] =
             0,
+        /* VMX features from Cedar Mill/Prescott */
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING,
         .xlevel = 0x80000008,
         .model_id = "Common KVM processor"
     },
@@ -1931,6 +1991,19 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_SSE3,
         .features[FEAT_8000_0001_ECX] =
             0,
+        /* VMX features from Yonah */
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXITING |
+             VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_EXITING |
+             VMX_CPU_BASED_PAUSE_EXITING | VMX_CPU_BASED_USE_MSR_BITMAPS,
         .xlevel = 0x80000008,
         .model_id = "Common 32-bit KVM processor"
     },
@@ -1952,6 +2025,18 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_SSE3 | CPUID_EXT_MONITOR,
         .features[FEAT_8000_0001_EDX] =
             CPUID_EXT2_NX,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXITING |
+             VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_EXITING |
+             VMX_CPU_BASED_PAUSE_EXITING | VMX_CPU_BASED_USE_MSR_BITMAPS,
         .xlevel = 0x80000008,
         .model_id = "Genuine Intel(R) CPU           T2600  @ 2.16GHz",
     },
@@ -2062,6 +2147,24 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_LAHF_LM,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_ACK_INTR_ON_EXIT,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES,
         .xlevel = 0x80000008,
         .model_id = "Intel Celeron_4x0 (Conroe/Merom Class Core 2)",
     },
@@ -2085,6 +2188,27 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_LAHF_LM,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL,
+        .features[FEAT_VMX_EXIT_CTLS] = VMX_VM_EXIT_ACK_INTR_ON_EXIT |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING,
         .xlevel = 0x80000008,
         .model_id = "Intel Core 2 Duo P9xxx (Penryn Class Core 2)",
     },
@@ -2108,6 +2232,46 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT2_LM | CPUID_EXT2_SYSCALL | CPUID_EXT2_NX,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_LAHF_LM,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID,
         .xlevel = 0x80000008,
         .model_id = "Intel Core i7 9xx (Nehalem Class Core i7)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2148,6 +2312,47 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT3_LAHF_LM,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST,
         .xlevel = 0x80000008,
         .model_id = "Westmere E56xx/L56xx/X56xx (Nehalem-C)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2193,6 +2398,47 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XSAVEOPT,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon E312xx (Sandy Bridge)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2241,6 +2487,50 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XSAVEOPT,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon E3-12xx v2 (Ivy Bridge)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2292,6 +2582,52 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XSAVEOPT,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Core Processor (Haswell)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2376,6 +2712,53 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XSAVEOPT,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Core Processor (Broadwell)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2460,6 +2843,51 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Core Processor (Skylake)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2524,6 +2952,52 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Skylake)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2594,6 +3068,52 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Cascadelake)",
         .versions = (X86CPUVersionDefinition[]) {
@@ -2663,6 +3183,51 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Core Processor (Icelake)",
     },
@@ -2721,6 +3286,52 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        /* Missing: Mode-based execute control (XS/XU), processor tracing, TSC scaling */
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Icelake)",
     },
@@ -2768,6 +3379,53 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .features[FEAT_ARCH_CAPABILITIES] =
             MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Atom Processor (Denverton)",
     },
@@ -2838,6 +3496,53 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_VMX_BASIC] = MSR_VMX_BASIC_INS_OUTS |
+             MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_ENTRY_CTLS] = VMX_VM_ENTRY_IA32E_MODE |
+             VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VMX_VM_ENTRY_LOAD_IA32_PAT |
+             VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        .features[FEAT_VMX_EPT_VPID_CAPS] = MSR_VMX_EPT_EXECONLY |
+             MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB |
+             MSR_VMX_EPT_1GB | MSR_VMX_EPT_INVEPT |
+             MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+             MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS | MSR_VMX_EPT_AD_BITS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+             VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_DEBUG_CONTROLS |
+             VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+             VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_LOAD_IA32_EFER |
+             VMX_VM_EXIT_SAVE_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+             VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER,
+        .features[FEAT_VMX_MISC] = MSR_VMX_MISC_ACTIVITY_HLT |
+             MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] = VMX_PIN_BASED_EXT_INTR_MASK |
+             VMX_PIN_BASED_NMI_EXITING | VMX_PIN_BASED_VIRTUAL_NMIS |
+             VMX_PIN_BASED_VMX_PREEMPTION_TIMER | VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] = VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+             VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+             VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+             VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+             VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+             VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_MOV_DR_EXITING |
+             VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS |
+             VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+             VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_USE_MSR_BITMAPS |
+             VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+             VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+             VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+             VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+             VMX_SECONDARY_EXEC_WBINVD_EXITING | VMX_SECONDARY_EXEC_ENABLE_EPT |
+             VMX_SECONDARY_EXEC_DESC | VMX_SECONDARY_EXEC_RDTSCP |
+             VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+             VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+             VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+             VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+             VMX_SECONDARY_EXEC_RDRAND_EXITING | VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+             VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+             VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Intel Atom Processor (SnowRidge)",
         .versions = (X86CPUVersionDefinition[]) {
-- 
1.8.3.1


