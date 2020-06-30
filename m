Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2A0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F0720771
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="XLM/yU7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F0720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDYE-0006GF-5R
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqDVI-0001lB-Fn
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:28:40 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:58172 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqDVE-0000Ya-Hj
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:28:39 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 86F3B4C8A6;
 Tue, 30 Jun 2020 10:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1593512913; x=1595327314; bh=4IQZgJczcCUTieQ8Wf6mR93bDaNV5bniGKg
 TQ4nDSYU=; b=XLM/yU7V/BPZYoGgmGwdvQGvsVWmQmM2Wm8OMH+yIbg8YIJp9vJ
 GE6RF55H9bwMJ2Wwu/2HW1X2sOgRRCnPvrOIMbqTUGmTGZgMVJpb0BcLIIJCU3X2
 IkiyOG4NJEEG/7FdYQU/KxvF2GRaC5u6yXjHuQWBr3DCp4L3Gp+FHSz4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Etf8cxaDX3S; Tue, 30 Jun 2020 13:28:33 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 191554C89B;
 Tue, 30 Jun 2020 13:28:33 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 30
 Jun 2020 13:28:32 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 6/9] i386: hvf: Move Guest LMA reset to macvm_set_cr0()
Date: Tue, 30 Jun 2020 13:28:21 +0300
Message-ID: <20200630102824.77604-7-r.bolshakov@yadro.com>
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

The only useful purpose of hvf_reset_vcpu() is to clear "IA-32e mode
guest" (LMA) VM-Entry control. But it can be moved to macvm_set_cr0()
which is indirectly used by post-init and post-reset to flush emulator
state. That enables clean removal of hvf_reset_vcpu().

LMA is set only if IA32_EFER.LME = 1, according to Intel SDM "9.8.5
Initializing IA-32e Mode" and "9.8.5.4 Switching Out of IA-32e Mode
Operation", otherwise the entry control can be safely cleared.

Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 target/i386/hvf/hvf.c | 1 -
 target/i386/hvf/vmx.h | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 317304aa1d..1d3a27167d 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -462,7 +462,6 @@ void hvf_reset_vcpu(CPUState *cpu) {
     /* TODO: this shouldn't be needed; there is already a call to
      * cpu_synchronize_all_post_reset in vl.c
      */
-    wvmcs(cpu->hvf_fd, VMCS_ENTRY_CTLS, 0);
     wvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER, 0);
 
     /* Initialize PDPTE */
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 437238f11d..75ba1e2a5f 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -123,6 +123,7 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
     uint64_t old_cr0 = rvmcs(vcpu, VMCS_GUEST_CR0);
     uint64_t changed_cr0 = old_cr0 ^ cr0;
     uint64_t mask = CR0_PG | CR0_CD | CR0_NW | CR0_NE | CR0_ET;
+    uint64_t entry_ctls;
 
     if ((cr0 & CR0_PG) && (rvmcs(vcpu, VMCS_GUEST_CR4) & CR4_PAE) &&
         !(efer & MSR_EFER_LME)) {
@@ -146,6 +147,9 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
                 exit_long_mode(vcpu, cr0, efer);
             }
         }
+    } else {
+        entry_ctls = rvmcs(vcpu, VMCS_ENTRY_CTLS);
+        wvmcs(vcpu, VMCS_ENTRY_CTLS, entry_ctls & ~VM_ENTRY_GUEST_LMA);
     }
 
     /* Filter new CR0 after we are finished examining it above. */
-- 
2.26.1


