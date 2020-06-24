Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2530C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E712076E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Oa4og9+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E712076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joER6-0004A7-R9
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joEO9-00080n-Ci
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:01:05 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:32926 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joEO7-0006nQ-0j
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:01:05 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 181F04C8AD;
 Wed, 24 Jun 2020 23:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1593039659; x=1594854060; bh=/agBQHSopimvaBz9V7rqhDp/Hc7pXQlgE5U
 iRtZKlKc=; b=Oa4og9+j+uGjcqAsI3RPExG2O44MIbRfQqcvrE3re1W/hS8hUog
 b8uu/w7VJKN9kwNqRDX0hpUj6w7tGlWf9Ir9+k00C7Tu/ul9Gpl68E2GabGgjgN2
 mDjiXgiE/qSrmP23Sxeu2sLfSvMZ46pxq6A8ZRI6NHbXfCIXPubbcFI4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sPCVySG97sVg; Thu, 25 Jun 2020 02:00:59 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 6C5064C8A7;
 Thu, 25 Jun 2020 02:00:58 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 25
 Jun 2020 02:00:58 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 5/8] i386: hvf: Don't duplicate register reset
Date: Thu, 25 Jun 2020 01:58:48 +0300
Message-ID: <20200624225850.16982-6-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200624225850.16982-1-r.bolshakov@yadro.com>
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 19:00:57
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
flushes CPUX86State into VMCS. That makes most of the hvf_reset_vcpu() a
kind of no-op.

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

Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 target/i386/hvf/hvf.c | 78 -------------------------------------------
 1 file changed, 78 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 4d254a477a..2c4028d08c 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -456,90 +456,12 @@ void hvf_reset_vcpu(CPUState *cpu) {
     uint64_t pdpte[4] = {0, 0, 0, 0};
     int i;
 
-    /* TODO: this shouldn't be needed; there is already a call to
-     * cpu_synchronize_all_post_reset in vl.c
-     */
     wvmcs(cpu->hvf_fd, VMCS_ENTRY_CTLS, 0);
-    wvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER, 0);
 
     /* Initialize PDPTE */
     for (i = 0; i < 4; i++) {
         wvmcs(cpu->hvf_fd, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
     }
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
 }
 
 void hvf_vcpu_destroy(CPUState *cpu)
-- 
2.26.1


