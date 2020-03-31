Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B98C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDFF20771
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="OXAMDx8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDFF20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ4bA-0006l2-Vd
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 20:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jJ4Zg-0005S6-91
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jJ4Ze-000069-Rw
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:16:12 -0400
Received: from ma1-aaemail-dr-lapp01.apple.com ([17.171.2.60]:56920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jJ4Ze-00005F-MU
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:16:10 -0400
Received: from pps.filterd (ma1-aaemail-dr-lapp01.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 02V02CVN005237; Mon, 30 Mar 2020 17:16:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : in-reply-to : references : mime-version
 : content-transfer-encoding; s=20180706;
 bh=PJLsleVhxwtS9kIQ+Ps4ao+b8dxNpL5IwveVR/bSPEM=;
 b=OXAMDx8AHw4xEb+bYmy67B6Lj7XKwPaASWAtBmLtvfVm4tMzLJNbHidBI5tFhGrGHqLM
 mf3T4ET1HQoDbyO0RUkdwqd0L/rXQneOgsOW9fd0jYMr67awVjviRBaIi7IGKR7+SFbJ
 XBK9lUBQYiMlkxZvnj79BZ3hFF485/R/jTBSSZtNOQcnSg2bZ4D4cuUqbwe8MiBixaLR
 QXuE9hYxgT3XMEYIjzGQPoUkunF2YYa3KkmulEF30rZwKnso2TeH9n8BoE2jNAL/g7aH
 5BMAS5MU7czcTsbWHDQ5awI/COIpceJrR2t1MIGJcc5QyfjHXDcGa8V7oCe6Vybh5GBl fQ== 
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by ma1-aaemail-dr-lapp01.apple.com with ESMTP id 302582hkve-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 30 Mar 2020 17:16:10 -0700
Received: from rn-mailsvcp-mmp-lapp01.rno.apple.com
 (rn-mailsvcp-mmp-lapp01.rno.apple.com [17.179.253.14])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q810023A7EV7V90@rn-mailsvcp-mta-lapp02.rno.apple.com>; 
 Mon, 30 Mar 2020 17:16:07 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp01.rno.apple.com by
 rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q8100B007DUTS00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Mon,
 30 Mar 2020 17:16:07 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: c56cc4374afe9162bf6a337f3d661529
X-Va-E-CD: 1ed0441e77fb65cef016f0727c15f2a5
X-Va-R-CD: ee73c95a311b25968dbf85572862976f
X-Va-CD: 0
X-Va-ID: 74c24f8c-9583-4704-898a-b9c38bdfae44
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 1ed0441e77fb65cef016f0727c15f2a5
X-V-R-CD: ee73c95a311b25968dbf85572862976f
X-V-CD: 0
X-V-ID: cd9f5c04-78b8-4ce9-b92b-a5213a52f48f
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-30_07:2020-03-30,
 2020-03-30 signatures=0
Received: from pontoon.com (unknown [17.234.84.168])
 by rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020))
 with ESMTPSA id <0Q81010CS7EU8N70@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Mon,
 30 Mar 2020 17:16:07 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, r.bolshakov@yadro.com
Subject: [PATCH v1 1/3] hvf: use standard CR0 and CR4 register definitions
Date: Mon, 30 Mar 2020 17:16:04 -0700
Message-id: <9ba0495405a1cd1e6c272a1e67d54dfda09494e1.1585607927.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
In-reply-to: <cover.1585607927.git.dirty@apple.com>
References: <cover.1585607927.git.dirty@apple.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-30_07:2020-03-30,
 2020-03-30 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 17.171.2.60
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

Signed-off-by: Cameron Esfahani <dirty@apple.com>
---
 target/i386/cpu.h          |  2 ++
 target/i386/hvf/hvf.c      |  1 +
 target/i386/hvf/vmx.h      | 15 ++++++++-------
 target/i386/hvf/x86.c      |  6 +++---
 target/i386/hvf/x86.h      | 34 ----------------------------------
 target/i386/hvf/x86_mmu.c  |  2 +-
 target/i386/hvf/x86_task.c |  3 ++-
 7 files changed, 17 insertions(+), 46 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 60d797d594..1286ec6e7a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -225,6 +225,8 @@ typedef enum X86Seg {
 #define CR0_NE_MASK  (1U << 5)
 #define CR0_WP_MASK  (1U << 16)
 #define CR0_AM_MASK  (1U << 18)
+#define CR0_NW_MASK  (1U << 29)
+#define CR0_CD_MASK  (1U << 30)
 #define CR0_PG_MASK  (1U << 31)
 
 #define CR4_VME_MASK  (1U << 0)
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index d72543dc31..fef1ee7d70 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -455,6 +455,7 @@ void hvf_reset_vcpu(CPUState *cpu) {
         wvmcs(cpu->hvf_fd, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
     }
 
+    macvm_set_cr0(cpu->hvf_fd, CR0_CD_MASK | CR0_NW_MASK | CR0_ET_MASK);
     macvm_set_cr0(cpu->hvf_fd, 0x60000010);
 
     wvmcs(cpu->hvf_fd, VMCS_CR4_MASK, CR4_VMXE_MASK);
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 03d2c79b9c..8ec2e6414e 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -121,9 +121,10 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
     uint64_t pdpte[4] = {0, 0, 0, 0};
     uint64_t efer = rvmcs(vcpu, VMCS_GUEST_IA32_EFER);
     uint64_t old_cr0 = rvmcs(vcpu, VMCS_GUEST_CR0);
-    uint64_t mask = CR0_PG | CR0_CD | CR0_NW | CR0_NE | CR0_ET;
+    uint64_t mask = CR0_PG_MASK | CR0_CD_MASK | CR0_NW_MASK |
+                    CR0_NE_MASK | CR0_ET_MASK;
 
-    if ((cr0 & CR0_PG) && (rvmcs(vcpu, VMCS_GUEST_CR4) & CR4_PAE) &&
+    if ((cr0 & CR0_PG_MASK) && (rvmcs(vcpu, VMCS_GUEST_CR4) & CR4_PAE_MASK) &&
         !(efer & MSR_EFER_LME)) {
         address_space_read(&address_space_memory,
                            rvmcs(vcpu, VMCS_GUEST_CR3) & ~0x1f,
@@ -138,17 +139,17 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
     wvmcs(vcpu, VMCS_CR0_SHADOW, cr0);
 
     if (efer & MSR_EFER_LME) {
-        if (!(old_cr0 & CR0_PG) && (cr0 & CR0_PG)) {
+        if (!(old_cr0 & CR0_PG_MASK) && (cr0 & CR0_PG_MASK)) {
             enter_long_mode(vcpu, cr0, efer);
         }
-        if (/*(old_cr0 & CR0_PG) &&*/ !(cr0 & CR0_PG)) {
+        if (!(cr0 & CR0_PG_MASK)) {
             exit_long_mode(vcpu, cr0, efer);
         }
     }
 
     /* Filter new CR0 after we are finished examining it above. */
-    cr0 = (cr0 & ~(mask & ~CR0_PG));
-    wvmcs(vcpu, VMCS_GUEST_CR0, cr0 | CR0_NE | CR0_ET);
+    cr0 = (cr0 & ~(mask & ~CR0_PG_MASK));
+    wvmcs(vcpu, VMCS_GUEST_CR0, cr0 | CR0_NE_MASK | CR0_ET_MASK);
 
     hv_vcpu_invalidate_tlb(vcpu);
     hv_vcpu_flush(vcpu);
@@ -156,7 +157,7 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
 
 static inline void macvm_set_cr4(hv_vcpuid_t vcpu, uint64_t cr4)
 {
-    uint64_t guest_cr4 = cr4 | CR4_VMXE;
+    uint64_t guest_cr4 = cr4 | CR4_VMXE_MASK;
 
     wvmcs(vcpu, VMCS_GUEST_CR4, guest_cr4);
     wvmcs(vcpu, VMCS_CR4_SHADOW, cr4);
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index 3afcedc7fc..668c02de6e 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -119,7 +119,7 @@ bool x86_read_call_gate(struct CPUState *cpu, struct x86_call_gate *idt_desc,
 bool x86_is_protected(struct CPUState *cpu)
 {
     uint64_t cr0 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0);
-    return cr0 & CR0_PE;
+    return cr0 & CR0_PE_MASK;
 }
 
 bool x86_is_real(struct CPUState *cpu)
@@ -150,13 +150,13 @@ bool x86_is_long64_mode(struct CPUState *cpu)
 bool x86_is_paging_mode(struct CPUState *cpu)
 {
     uint64_t cr0 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0);
-    return cr0 & CR0_PG;
+    return cr0 & CR0_PG_MASK;
 }
 
 bool x86_is_pae_enabled(struct CPUState *cpu)
 {
     uint64_t cr4 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR4);
-    return cr4 & CR4_PAE;
+    return cr4 & CR4_PAE_MASK;
 }
 
 target_ulong linear_addr(struct CPUState *cpu, target_ulong addr, X86Seg seg)
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index c95d5b2116..bc0170b2a8 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -100,40 +100,6 @@ typedef struct x86_reg_flags {
     };
 } __attribute__ ((__packed__)) x86_reg_flags;
 
-typedef enum x86_reg_cr0 {
-    CR0_PE =            (1L << 0),
-    CR0_MP =            (1L << 1),
-    CR0_EM =            (1L << 2),
-    CR0_TS =            (1L << 3),
-    CR0_ET =            (1L << 4),
-    CR0_NE =            (1L << 5),
-    CR0_WP =            (1L << 16),
-    CR0_AM =            (1L << 18),
-    CR0_NW =            (1L << 29),
-    CR0_CD =            (1L << 30),
-    CR0_PG =            (1L << 31),
-} x86_reg_cr0;
-
-typedef enum x86_reg_cr4 {
-    CR4_VME =            (1L << 0),
-    CR4_PVI =            (1L << 1),
-    CR4_TSD =            (1L << 2),
-    CR4_DE  =            (1L << 3),
-    CR4_PSE =            (1L << 4),
-    CR4_PAE =            (1L << 5),
-    CR4_MSE =            (1L << 6),
-    CR4_PGE =            (1L << 7),
-    CR4_PCE =            (1L << 8),
-    CR4_OSFXSR =         (1L << 9),
-    CR4_OSXMMEXCPT =     (1L << 10),
-    CR4_VMXE =           (1L << 13),
-    CR4_SMXE =           (1L << 14),
-    CR4_FSGSBASE =       (1L << 16),
-    CR4_PCIDE =          (1L << 17),
-    CR4_OSXSAVE =        (1L << 18),
-    CR4_SMEP =           (1L << 20),
-} x86_reg_cr4;
-
 /* 16 bit Task State Segment */
 typedef struct x86_tss_segment16 {
     uint16_t link;
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 65d4603dbf..8f38eccffc 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -130,7 +130,7 @@ static bool test_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
 
     uint32_t cr0 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0);
     /* check protection */
-    if (cr0 & CR0_WP) {
+    if (cr0 & CR0_WP_MASK) {
         if (pt->write_access && !pte_write_access(pte)) {
             return false;
         }
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index 1daac6cc2b..5e41d09b89 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -174,7 +174,8 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
         //ret = task_switch_16(cpu, tss_sel, old_tss_sel, old_tss_base, &next_tss_desc);
         VM_PANIC("task_switch_16");
 
-    macvm_set_cr0(cpu->hvf_fd, rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0) | CR0_TS);
+    macvm_set_cr0(cpu->hvf_fd,
+                  rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0) | CR0_TS_MASK);
     x86_segment_descriptor_to_vmx(cpu, tss_sel, &next_tss_desc, &vmx_seg);
     vmx_write_segment_descriptor(cpu, &vmx_seg, R_TR);
 
-- 
2.24.0


