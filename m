Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F699C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481A620708
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWMkavVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481A620708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUQz-00029T-I9
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCI-0003Xz-QW
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39780
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUC8-00035q-Ka
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5hDMF/Ltdo6fLCLBK2hQ0VSgajmckEc+AeTBeNB9erI=;
 b=bWMkavVE8Ysg2I5oZNCHjv3G6w3fWjLx2hgMbXi9zr6+ANr1cYxfpHus/zhLg56r02Nw6v
 oY8WzmkcxPcGTSjMFoW6Q32PdcVyA1JTY1t5a4z9ISs8Y0VpsLYlbjHA8nO2FLgX3Unxzl
 XnynIeMUnWJx0s2jEISYH8TxK2KBxx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-Nh5I98VrMhi05h2Qm1yImw-1; Mon, 06 Jul 2020 12:41:58 -0400
X-MC-Unique: Nh5I98VrMhi05h2Qm1yImw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72288EC1A0;
 Mon,  6 Jul 2020 16:41:57 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C3801002380;
 Mon,  6 Jul 2020 16:41:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/53] tcg/svm: use host cr4 during NPT page table walk
Date: Mon,  6 Jul 2020 12:41:03 -0400
Message-Id: <20200706164155.24696-2-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Boettcher <alexander.boettcher@genode-labs.com>

During a page table walk of TCG+SVM the code in target/i386/excp_helper.c
get_hphys() uses the cr4 register of the guest instead of the hypervisor
to check for the PSE bit. In the test case we have, the guest have not
enabled (yet) the PSE bit and so the page table walk results in a wrong
host physical address resolution and wrong content read by the guest.

Attached patch is against 4.2.1, but works also on 3.1.0. It fixes the
issue for our automated testcase, which is a 32bit hypervisor w/o PAE
support running a guest VM with tcg+svm.

The test worked beforehand up to qemu 2.12, started to fail with qemu 3.0
and later. The added TCG/SVM NPT commit seems to introduce the regression.

In case someone want to try to reproduce it, the iso is at [0], the good
case is [1] and the failing case is [2]. The used commandline is:

qemu-system-i386 -no-kvm -nographic -cpu phenom -m 512 -machine q35 -cdrom seoul-vmm-test.iso

[0] https://depot.genode.org/alex-ab/images/seoul-vmm-test.iso
[1] https://depot.genode.org/alex-ab/images/seoul-vmm-good.txt
[2] https://depot.genode.org/alex-ab/images/seoul-vmm-bad.txt

Signed-off-by: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.26.2



