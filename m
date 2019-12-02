Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA42AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 23:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D8120678
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 23:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="JsN1yuR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D8120678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibvaB-0008U6-D0
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 18:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1ibvXf-0006fh-GS
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 18:55:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1ibvXd-0008SP-7A
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 18:55:47 -0500
Received: from nwk-aaemail-lapp01.apple.com ([17.151.62.66]:37118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1ibvXc-0008PS-U4
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 18:55:45 -0500
Received: from pps.filterd (nwk-aaemail-lapp01.apple.com [127.0.0.1])
 by nwk-aaemail-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xB2Nq6Lw044435; Mon, 2 Dec 2019 15:55:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : in-reply-to : references : mime-version
 : content-transfer-encoding; s=20180706;
 bh=ee7/7Ngklg3ShuDiqM1OyHxaWCHXtBSBarKuirDBevs=;
 b=JsN1yuR8DbdR6AAAktaUpvXZ3NyP771eqL0MniXpwFuXFodp+WfUjvSAJOXOkjqxHFJT
 Pr+SXCAdR1aEnEfYAK++qMlcoZHDZ30VpFFfL1a2GreZbXFAFMhdmbAwo7TvWLCC6qaD
 ltak1ho2qvSRJBqAY7DzPQJjRM7ISRGrA/Vwia3CoV4CFjxSDhx46nAP2lz4MsALUYg1
 /b2HES+fxKfr89gIa9MAf+IRymI22oaZ6RKFwH/I3sJBbZvT4ghU3Va0nnmf72OO6FHe
 lBfqHYbyNZ5DIEW7SNbOU8NxWObHbK9yJpS3EsEzNtsB+4ZbRhcEPq1PGlJgdnHmMnJ5 GA== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com
 [17.40.76.7])
 by nwk-aaemail-lapp01.apple.com with ESMTP id 2wkr83ys1h-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 02 Dec 2019 15:55:44 -0800
Received: from nwk-mmpp-sz12.apple.com
 (nwk-mmpp-sz12.apple.com [17.128.115.204]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q1W00D69T4U1O50@ma1-mtap-s03.corp.apple.com>; Mon,
 02 Dec 2019 15:55:43 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz12.apple.com by
 nwk-mmpp-sz12.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q1W00A00SGIRL00@nwk-mmpp-sz12.apple.com>; Mon,
 02 Dec 2019 15:55:42 -0800 (PST)
X-Va-A: 
X-Va-T-CD: c56cc4374afe9162bf6a337f3d661529
X-Va-E-CD: 263ce0a3bfc93a533d48b3d0f711ae8c
X-Va-R-CD: 4f855c1c806c43b90c8de5dcdc6f0780
X-Va-CD: 0
X-Va-ID: 9b16ca19-295a-4906-9e71-268c6a03dab1
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 263ce0a3bfc93a533d48b3d0f711ae8c
X-V-R-CD: 4f855c1c806c43b90c8de5dcdc6f0780
X-V-CD: 0
X-V-ID: ad9ef32c-9d87-4ef6-9c48-586f54af0cd5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-12-02_06:,, signatures=0
Received: from pontoon.com (unknown [17.193.42.217]) by nwk-mmpp-sz12.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q1W00JNAT4TQI20@nwk-mmpp-sz12.apple.com>; Mon,
 02 Dec 2019 15:55:42 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v3 4/5] hvf: more accurately match SDM when setting CR0 and
 PDPTE registers
Date: Mon, 02 Dec 2019 15:55:40 -0800
Message-id: <cdf0b1b6bd00e2ae8c635feaab39871c173ab0ed.1575330463.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
In-reply-to: <cover.1575330463.git.dirty@apple.com>
References: <cover.1575330463.git.dirty@apple.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-12-02_06:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.151.62.66
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
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

More accurately match SDM when setting CR0 and PDPTE registers.

Clear PDPTE registers when resetting vcpus.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c |  8 ++++++++
 target/i386/hvf/vmx.h | 18 ++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 90fd50acfc..784e67d77e 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -441,12 +441,20 @@ static MemoryListener hvf_memory_listener = {
 };
 
 void hvf_reset_vcpu(CPUState *cpu) {
+    uint64_t pdpte[4] = {0, 0, 0, 0};
+    int i;
 
     /* TODO: this shouldn't be needed; there is already a call to
      * cpu_synchronize_all_post_reset in vl.c
      */
     wvmcs(cpu->hvf_fd, VMCS_ENTRY_CTLS, 0);
     wvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER, 0);
+
+    /* Initialize PDPTE */
+    for (i = 0; i < 4; i++) {
+        wvmcs(cpu->hvf_fd, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
+    }
+
     macvm_set_cr0(cpu->hvf_fd, 0x60000010);
 
     wvmcs(cpu->hvf_fd, VMCS_CR4_MASK, CR4_VMXE_MASK);
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 5dc52ecad6..eb8894cd58 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -121,6 +121,7 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
     uint64_t pdpte[4] = {0, 0, 0, 0};
     uint64_t efer = rvmcs(vcpu, VMCS_GUEST_IA32_EFER);
     uint64_t old_cr0 = rvmcs(vcpu, VMCS_GUEST_CR0);
+    uint64_t mask = CR0_PG | CR0_CD | CR0_NW | CR0_NE | CR0_ET;
 
     if ((cr0 & CR0_PG) && (rvmcs(vcpu, VMCS_GUEST_CR4) & CR4_PAE) &&
         !(efer & MSR_EFER_LME)) {
@@ -128,18 +129,15 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
                          rvmcs(vcpu, VMCS_GUEST_CR3) & ~0x1f,
                          MEMTXATTRS_UNSPECIFIED,
                          (uint8_t *)pdpte, 32, 0);
+        /* Only set PDPTE when appropriate. */
+        for (i = 0; i < 4; i++) {
+            wvmcs(vcpu, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
+        }
     }
 
-    for (i = 0; i < 4; i++) {
-        wvmcs(vcpu, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
-    }
-
-    wvmcs(vcpu, VMCS_CR0_MASK, CR0_CD | CR0_NE | CR0_PG);
+    wvmcs(vcpu, VMCS_CR0_MASK, mask);
     wvmcs(vcpu, VMCS_CR0_SHADOW, cr0);
 
-    cr0 &= ~CR0_CD;
-    wvmcs(vcpu, VMCS_GUEST_CR0, cr0 | CR0_NE | CR0_ET);
-
     if (efer & MSR_EFER_LME) {
         if (!(old_cr0 & CR0_PG) && (cr0 & CR0_PG)) {
             enter_long_mode(vcpu, cr0, efer);
@@ -149,6 +147,10 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
         }
     }
 
+    /* Filter new CR0 after we are finished examining it above. */
+    cr0 = (cr0 & ~(mask & ~CR0_PG));
+    wvmcs(vcpu, VMCS_GUEST_CR0, cr0 | CR0_NE | CR0_ET);
+
     hv_vcpu_invalidate_tlb(vcpu);
     hv_vcpu_flush(vcpu);
 }
-- 
2.24.0


