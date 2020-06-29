Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1064BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC79125495
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=genode-labs.com header.i=@genode-labs.com header.b="KvatqGqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC79125495
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=genode-labs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvzX-0008UL-1a
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.boettcher@genode-labs.com>)
 id 1jpu2b-0001vo-2M
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:41:45 -0400
Received: from mail.genode-labs.com ([94.130.141.206]:56394
 helo=genode.genode-labs.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.boettcher@genode-labs.com>)
 id 1jpu2Y-0000Sk-9l
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=genode-labs.com; s=2018-03; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mSJdnbPdHXfgRaHLt7gIw1fMHbT20CjL66DRqYCPq/I=; b=KvatqGqtfBiLCvp1rbGD+P6qDJ
 hgCkozj73zEVaDSFMxckG6X5Zw0b5e5zQ7hUitPd546j2h+R1oTDwXlitDEs26AVMMIuD1V9cefbh
 G4DMgYQndJ2DrE8Z9n67+KKykexVE/oZ1/mLpXbu+N7wMpPuI3ByxiwrbOgDqCOyJa63xbRJu/Fol
 SxohWkEChmqsJXCdj8sm92e1xuHprBVXi5CuenNnC/v/qc/wErBZ6+FL22qVk0+PHvmPadrqdtDh/
 ODHslgLVpGpcJkLLYIlAlWd3dh8Cd8k7RDo17fMwP3QbsOp1ZyoBvQW43l7yZxpEBYEmT0tAuMFmI
 eSVTssNQ==;
Received: by mail.genode-labs.com (Exim 4.89) with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (envelope-from <alexander.boettcher@genode-labs.com>)
 id 1jptmS-0002xH-7l ; Mon, 29 Jun 2020 15:25:07 +0200
From: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Subject: [PATCH] tcg/svm: use host cr4 during NPT page table walk
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Message-ID: <c9ba7c23-581e-86d8-8174-37d2beeab768@genode-labs.com>
Date: Mon, 29 Jun 2020 15:25:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=94.130.141.206;
 envelope-from=alexander.boettcher@genode-labs.com; helo=genode.genode-labs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 09:25:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 29 Jun 2020 11:45:06 -0400
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

Hello,

during a page table walk of TCG+SVM the code in target/i386/excp_helper.c get_hphys() uses the cr4 register of the guest instead of the hypervisor to check for the PSE bit. In the test case we have, the guest have not enabled (yet) the PSE bit and so the page table walk results in a wrong host physical address resolution and wrong content read by the guest.

Attached patch is against 4.2.1, but works also on 3.1.0. It fixes the issue for our automated testcase, which is a 32bit hypervisor w/o PAE support running a guest VM with tcg+svm.
The test worked beforehand up to qemu 2.12, started to fail with qemu 3.0 and later. The added TCG/SVM NPT commit seems to introduce the regression.

In case someone want to try to reproduce it, the iso is at [0], the good case is [1] and the failing case is [2]. The used commandline is:

qemu-system-i386 -no-kvm -nographic -cpu phenom -m 512 -machine q35 -cdrom seoul-vmm-test.iso

[0] https://depot.genode.org/alex-ab/images/seoul-vmm-test.iso
[1] https://depot.genode.org/alex-ab/images/seoul-vmm-good.txt
[2] https://depot.genode.org/alex-ab/images/seoul-vmm-bad.txt

-- 
Alexander Boettcher
Genode Labs

https://www.genode-labs.com - https://www.genode.org

Genode Labs GmbH - Amtsgericht Dresden - HRB 28424 - Sitz Dresden
Geschäftsführer: Dr.-Ing. Norman Feske, Christian Helmuth




Signed-off-by: Alexander Boettcher <alexander.boettcher@genode-labs.com>
---
 target/i386/excp_helper.c | 4 ++--
 target/i386/svm.h         | 1 +
 target/i386/svm_helper.c  | 7 ++++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index 1447bda7a9..b10c7ecbcc 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -262,8 +262,8 @@ static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType access_type,
         }
         ptep = pde | PG_NX_MASK;
 
-        /* if PSE bit is set, then we use a 4MB page */
-        if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
+        /* if host cr4 PSE bit is set, then we use a 4MB page */
+        if ((pde & PG_PSE_MASK) && (env->nested_pg_mode & SVM_NPT_PSE)) {
             page_size = 4096 * 1024;
             pte_addr = pde_addr;
 
diff --git a/target/i386/svm.h b/target/i386/svm.h
index 23a3a040b8..ae30fc6f79 100644
--- a/target/i386/svm.h
+++ b/target/i386/svm.h
@@ -135,6 +135,7 @@
 #define SVM_NPT_PAE         (1 << 0)
 #define SVM_NPT_LMA         (1 << 1)
 #define SVM_NPT_NXE         (1 << 2)
+#define SVM_NPT_PSE         (1 << 3)
 
 #define SVM_NPTEXIT_P       (1ULL << 0)
 #define SVM_NPTEXIT_RW      (1ULL << 1)
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 7b8105a1c3..6224387eab 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -209,16 +209,21 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
 
     nested_ctl = x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb,
                                                           control.nested_ctl));
+
+    env->nested_pg_mode = 0;
+
     if (nested_ctl & SVM_NPT_ENABLED) {
         env->nested_cr3 = x86_ldq_phys(cs,
                                 env->vm_vmcb + offsetof(struct vmcb,
                                                         control.nested_cr3));
         env->hflags2 |= HF2_NPT_MASK;
 
-        env->nested_pg_mode = 0;
         if (env->cr[4] & CR4_PAE_MASK) {
             env->nested_pg_mode |= SVM_NPT_PAE;
         }
+        if (env->cr[4] & CR4_PSE_MASK) {
+            env->nested_pg_mode |= SVM_NPT_PSE;
+        }
         if (env->hflags & HF_LMA_MASK) {
             env->nested_pg_mode |= SVM_NPT_LMA;
         }
-- 
2.17.1

