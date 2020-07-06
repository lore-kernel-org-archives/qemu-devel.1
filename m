Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A2BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0C1206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvgQXldk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0C1206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUJZ-0001p2-Jv
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCK-0003Zb-BA
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38980
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUC9-000364-8s
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hEWTZdll5mwD2SxvOrMYy2zK3cjMHJ9TOZNLiKmN/XU=;
 b=BvgQXldk9oMULOp+8/DdretrxzC3m67cYvLgCIe1ojzGZLfIHMzGTjATmGU21FshQ1dLYU
 msDb6L9ip4stHh2BI+k5bERXDg4VE76Jj+Iy6S4cFq2polXXrf1TiHVink9jS8TczZKtwt
 rKhmbf1Tn7kzf0yc2hAgcBVroebUGdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-jRLCNvYYOHaVXnKpfkiCgA-1; Mon, 06 Jul 2020 12:42:12 -0400
X-MC-Unique: jRLCNvYYOHaVXnKpfkiCgA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9769A107ACCD;
 Mon,  6 Jul 2020 16:42:11 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42AE55BACD;
 Mon,  6 Jul 2020 16:42:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/53] i386: hvf: Move Guest LMA reset to macvm_set_cr0()
Date: Mon,  6 Jul 2020 12:41:18 -0400
Message-Id: <20200706164155.24696-17-pbonzini@redhat.com>
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

The only useful purpose of hvf_reset_vcpu() is to clear "IA-32e mode
guest" (LMA) VM-Entry control. But it can be moved to macvm_set_cr0()
which is indirectly used by post-init and post-reset to flush emulator
state. That enables clean removal of hvf_reset_vcpu().

LMA is set only if IA32_EFER.LME = 1, according to Intel SDM "9.8.5
Initializing IA-32e Mode" and "9.8.5.4 Switching Out of IA-32e Mode
Operation", otherwise the entry control can be safely cleared.

Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200630102824.77604-7-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c | 1 -
 target/i386/hvf/vmx.h | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index efe9802962..31980f9076 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -459,7 +459,6 @@ void hvf_reset_vcpu(CPUState *cpu) {
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
2.26.2



