Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1A9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63A920771
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="OguG2JMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63A920771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDai-0000ci-5g
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqDVJ-0001nF-PI
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:28:42 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:58170 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqDVE-0000YZ-Oz
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:28:41 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id E45DF4C8A7;
 Tue, 30 Jun 2020 10:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1593512913; x=1595327314; bh=KB3JgMtoMEELNzweceVVD15txCvAyVBDr/F
 mg92vNsw=; b=OguG2JMcxI/41uGqsIhdAlD2l88rUPiKJ4k4EOxX6Z17aKY20Gd
 3pzmpKuSIHgsXxuGASQe1frNGLJLOUwoeAv+fUSOqRAgalemPT7mm+uTgwqR2yOj
 hb82xPI5EUyHtulWU6pXyFiygNm3ySs1IMUdKAfugdlWENmNnIDe+thI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2GfyNPh6JCsq; Tue, 30 Jun 2020 13:28:33 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 9E0444C879;
 Tue, 30 Jun 2020 13:28:33 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 30
 Jun 2020 13:28:33 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 7/9] i386: hvf: Don't duplicate register reset
Date: Tue, 30 Jun 2020 13:28:22 +0300
Message-ID: <20200630102824.77604-8-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200630102824.77604-1-r.bolshakov@yadro.com>
References: <20200630102824.77604-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 06:12:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Claudio Fontana <cfontana@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hvf_reset_vcpu() duplicates actions performed by x86_cpu_reset(). The
difference is that hvf_reset_vcpu() stores initial values directly to
VMCS while x86_cpu_reset() stores it in CPUX86State and then
cpu_synchronize_all_post_init() or cpu_synchronize_all_post_reset()
flushes CPUX86State into VMCS. That makes hvf_reset_vcpu() a kind of
no-op.

Here's the trace of CPU state modifications during VM start:
  hvf_reset_vcpu (resets VMCS)
  cpu_synchronize_all_post_init (overwrites VMCS fields written by
                                 hvf_reset_vcpu())
  cpu_synchronize_all_states
  hvf_reset_vcpu (resets VMCS)
  cpu_synchronize_all_post_reset (overwrites VMCS fields written by
                                  hvf_reset_vcpu())

General purpose registers, system registers, segment descriptors, flags
and IP are set by hvf_put_segments() in post-init and post-reset,
therefore it's safe to remove them from hvf_reset_vcpu().

PDPTE initialization can be dropped because Intel SDM (26.3.1.6 Checks
on Guest Page-Directory-Pointer-Table Entries) doesn't require PDPTE to
be clear unless PAE is used: "A VM entry to a guest that does not use
PAE paging does not check the validity of any PDPTEs."
And if PAE is used, PDPTE's are initialized from CR3 in macvm_set_cr0().

Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 include/sysemu/hvf.h  |  1 -
 target/i386/cpu.c     |  3 --
 target/i386/hvf/hvf.c | 89 -------------------------------------------
 3 files changed, 93 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index aaa00cbf05..a1ab61403f 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -31,7 +31,6 @@ void hvf_cpu_synchronize_post_reset(CPUState *);
 void hvf_cpu_synchronize_post_init(CPUState *);
 void hvf_cpu_synchronize_pre_loadvm(CPUState *);
 void hvf_vcpu_destroy(CPUState *);
-void hvf_reset_vcpu(CPUState *);
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 36cbd3d027..6463712524 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6098,9 +6098,6 @@ static void x86_cpu_reset(DeviceState *dev)
     if (kvm_enabled()) {
         kvm_arch_reset_vcpu(cpu);
     }
-    else if (hvf_enabled()) {
-        hvf_reset_vcpu(s);
-    }
 #endif
 }
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 1d3a27167d..f1114c2a09 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -455,95 +455,6 @@ static MemoryListener hvf_memory_listener = {
     .log_sync = hvf_log_sync,
 };
 
-void hvf_reset_vcpu(CPUState *cpu) {
-    uint64_t pdpte[4] = {0, 0, 0, 0};
-    int i;
-
-    /* TODO: this shouldn't be needed; there is already a call to
-     * cpu_synchronize_all_post_reset in vl.c
-     */
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER, 0);
-
-    /* Initialize PDPTE */
-    for (i = 0; i < 4; i++) {
-        wvmcs(cpu->hvf_fd, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
-    }
-
-    macvm_set_cr0(cpu->hvf_fd, 0x60000010);
-
-    wvmcs(cpu->hvf_fd, VMCS_CR4_MASK, CR4_VMXE_MASK);
-    wvmcs(cpu->hvf_fd, VMCS_CR4_SHADOW, 0x0);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_CR4, CR4_VMXE_MASK);
-
-    /* set VMCS guest state fields */
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_CS_SELECTOR, 0xf000);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_CS_LIMIT, 0xffff);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_CS_ACCESS_RIGHTS, 0x9b);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_CS_BASE, 0xffff0000);
-
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_DS_SELECTOR, 0);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_DS_LIMIT, 0xffff);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_DS_ACCESS_RIGHTS, 0x93);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_DS_BASE, 0);
-
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_ES_SELECTOR, 0);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_ES_LIMIT, 0xffff);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_ES_ACCESS_RIGHTS, 0x93);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_ES_BASE, 0);
-
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_FS_SELECTOR, 0);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_FS_LIMIT, 0xffff);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_FS_ACCESS_RIGHTS, 0x93);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_FS_BASE, 0);
-
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_GS_SELECTOR, 0);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_GS_LIMIT, 0xffff);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_GS_ACCESS_RIGHTS, 0x93);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_GS_BASE, 0);
-
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_SS_SELECTOR, 0);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_SS_LIMIT, 0xffff);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_SS_ACCESS_RIGHTS, 0x93);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_SS_BASE, 0);
-
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_LDTR_SELECTOR, 0);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_LDTR_LIMIT, 0);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_LDTR_ACCESS_RIGHTS, 0x10000);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_LDTR_BASE, 0);
-
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_TR_SELECTOR, 0);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_TR_LIMIT, 0);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_TR_ACCESS_RIGHTS, 0x83);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_TR_BASE, 0);
-
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_GDTR_LIMIT, 0);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_GDTR_BASE, 0);
-
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_IDTR_LIMIT, 0);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_IDTR_BASE, 0);
-
-    /*wvmcs(cpu->hvf_fd, VMCS_GUEST_CR2, 0x0);*/
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_CR3, 0x0);
-
-    wreg(cpu->hvf_fd, HV_X86_RIP, 0xfff0);
-    wreg(cpu->hvf_fd, HV_X86_RDX, 0x623);
-    wreg(cpu->hvf_fd, HV_X86_RFLAGS, 0x2);
-    wreg(cpu->hvf_fd, HV_X86_RSP, 0x0);
-    wreg(cpu->hvf_fd, HV_X86_RAX, 0x0);
-    wreg(cpu->hvf_fd, HV_X86_RBX, 0x0);
-    wreg(cpu->hvf_fd, HV_X86_RCX, 0x0);
-    wreg(cpu->hvf_fd, HV_X86_RSI, 0x0);
-    wreg(cpu->hvf_fd, HV_X86_RDI, 0x0);
-    wreg(cpu->hvf_fd, HV_X86_RBP, 0x0);
-
-    for (int i = 0; i < 8; i++) {
-        wreg(cpu->hvf_fd, HV_X86_R8 + i, 0x0);
-    }
-
-    hv_vcpu_invalidate_tlb(cpu->hvf_fd);
-    hv_vcpu_flush(cpu->hvf_fd);
-}
-
 void hvf_vcpu_destroy(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-- 
2.26.1


