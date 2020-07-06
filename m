Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108A3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF5B206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byNtjv8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF5B206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUJA-0000Kh-UA
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCB-0003R0-NN
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55057
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUC7-00035i-Ua
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l5fXLBze59nPDEkEuVrpthSN+Z5ri2IdAgGJVsMcbG4=;
 b=byNtjv8kQSEK69jkBd6CrjyDol5lq7oSA8sWnjkfmAY4TfQnYvvaUN+1YeiH2vA1AcCw2d
 8EujLWXwS7iOayLf/W4RjX8gkAmNfQszWceSjHNEcG13t+5f30xcktGiKlTXeD2YHUr6zL
 tuX+3A4SyZjzmkDX/q8FcTa0k9ShiDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-JaypAMh-MTmhO4iIi3K69A-1; Mon, 06 Jul 2020 12:42:13 -0400
X-MC-Unique: JaypAMh-MTmhO4iIi3K69A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 160571052502;
 Mon,  6 Jul 2020 16:42:12 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4DAD5BACD;
 Mon,  6 Jul 2020 16:42:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/53] i386: hvf: Don't duplicate register reset
Date: Mon,  6 Jul 2020 12:41:19 -0400
Message-Id: <20200706164155.24696-18-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Bolshakov <r.bolshakov@yadro.com>

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
Message-Id: <20200630102824.77604-8-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/hvf.h  |  1 -
 target/i386/cpu.c     |  3 --
 target/i386/hvf/hvf.c | 89 -------------------------------------------
 3 files changed, 93 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 1d40a8ec01..6d3ee4fdb7 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -30,7 +30,6 @@ void hvf_cpu_synchronize_post_reset(CPUState *);
 void hvf_cpu_synchronize_post_init(CPUState *);
 void hvf_cpu_synchronize_pre_loadvm(CPUState *);
 void hvf_vcpu_destroy(CPUState *);
-void hvf_reset_vcpu(CPUState *);
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f1cbac2fb5..c44cc510e1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6099,9 +6099,6 @@ static void x86_cpu_reset(DeviceState *dev)
     if (kvm_enabled()) {
         kvm_arch_reset_vcpu(cpu);
     }
-    else if (hvf_enabled()) {
-        hvf_reset_vcpu(s);
-    }
 #endif
 }
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 31980f9076..2a12867ef0 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -452,95 +452,6 @@ static MemoryListener hvf_memory_listener = {
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
2.26.2



