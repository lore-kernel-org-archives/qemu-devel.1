Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40110C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 22:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057AD206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 22:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="M89G5phN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057AD206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXvPD-0007EM-1D
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 17:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1iXvNo-0005vP-3d
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 17:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1iXvNm-0005pT-PI
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 17:57:04 -0500
Received: from nwk-aaemail-lapp01.apple.com ([17.151.62.66]:48280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1iXvNm-0005p7-Hy
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 17:57:02 -0500
Received: from pps.filterd (nwk-aaemail-lapp01.apple.com [127.0.0.1])
 by nwk-aaemail-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xALMuml8025486; Thu, 21 Nov 2019 14:57:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : in-reply-to : references : mime-version
 : content-transfer-encoding; s=20180706;
 bh=Wfjqgan7+LbRhyL3uAriVKkUmA2bv4a+Ay74QimgKAc=;
 b=M89G5phN8MZyENZTYQVdJ3BA9iHNGoEHYTYqd9huWuH5v+Mj60F/LX9sdyvwvyb6hm/N
 KRxrKXC2DEm42PlcTW2fojPzcaqqKzMQfnJ5mQ+zYdDHHiZ/9ZM3TLCfAvv8ympZvoLp
 0m5ThElZ0uVzqLgPEwoKGKzMKNQx1tWd4rGxR2WqnDOGQm+EqQHtnvSWxi07NpMOWD8I
 vExhe2UGgWWcWrWMWMEik6CBDWhmkNnlge6jNN+16ByC4PrZDrpB6DYq1TTY8z0u/WEa
 wvCaLOYihmiCmddxipMRFWnyQ5jWjZwUxGLQhuA4+k1MlJiZBP1zpHb+z53tzA9lGZ9O IA== 
Received: from mr2-mtap-s02.rno.apple.com (mr2-mtap-s02.rno.apple.com
 [17.179.226.134])
 by nwk-aaemail-lapp01.apple.com with ESMTP id 2wagx5dygn-46
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 21 Nov 2019 14:57:01 -0800
Received: from nwk-mmpp-sz11.apple.com
 (nwk-mmpp-sz11.apple.com [17.128.115.155]) by mr2-mtap-s02.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q1C00DIRD2Y6980@mr2-mtap-s02.rno.apple.com>; Thu,
 21 Nov 2019 14:56:59 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz11.apple.com by
 nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q1C00J00CBS2W00@nwk-mmpp-sz11.apple.com>; Thu,
 21 Nov 2019 14:56:59 -0800 (PST)
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 5b47ed150e04c9990a270d9f85eb4bbb
X-V-R-CD: 93de497c94ae2d22b36935d2cbfc41a3
X-V-CD: 0
X-V-ID: da5a5d5c-ada4-4a00-915e-2e3167835d1d
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-11-21_06:,, signatures=0
Received: from pontoon.com (unknown [17.193.42.199]) by nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q1C00JWACZIHUA0@nwk-mmpp-sz11.apple.com>; Thu,
 21 Nov 2019 14:54:55 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 5/5] hvf: save away type as well as vector so we can reinject
 them
Date: Thu, 21 Nov 2019 14:54:54 -0800
Message-id: <fc8406e583ec425620f181ab18df2b768e7ec2f5.1574375668.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
In-reply-to: <cover.1574375668.git.dirty@apple.com>
References: <cover.1574375668.git.dirty@apple.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-21_06:, , signatures=0
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

Save away type as well as vector in hvf_store_events() so we can
correctly reinject both in hvf_inject_interrupts().

Make sure to clear ins_len and has_error_code when ins_len isn't
valid and error_code isn't set.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
---
 target/i386/hvf/hvf.c    | 16 ++++++++++++----
 target/i386/hvf/x86hvf.c | 22 ++++++++++------------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 7f6ebd2e50..818591ceee 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -634,14 +634,16 @@ static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_in
         switch (idtvec_info & VMCS_IDT_VEC_TYPE) {
         case VMCS_IDT_VEC_HWINTR:
         case VMCS_IDT_VEC_SWINTR:
-            env->interrupt_injected = idtvec_info & VMCS_IDT_VEC_VECNUM;
+            /* Save away the event type as well so we can inject the correct type. */
+            env->interrupt_injected = idtvec_info & (VMCS_IDT_VEC_TYPE | VMCS_IDT_VEC_VECNUM);
             break;
         case VMCS_IDT_VEC_NMI:
             env->nmi_injected = true;
             break;
         case VMCS_IDT_VEC_HWEXCEPTION:
         case VMCS_IDT_VEC_SWEXCEPTION:
-            env->exception_nr = idtvec_info & VMCS_IDT_VEC_VECNUM;
+            /* Save away the event type as well so we can inject the correct type. */
+            env->exception_nr = idtvec_info & (VMCS_IDT_VEC_TYPE | VMCS_IDT_VEC_VECNUM);
             env->exception_injected = 1;
             break;
         case VMCS_IDT_VEC_PRIV_SWEXCEPTION:
@@ -651,10 +653,16 @@ static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_in
         if ((idtvec_info & VMCS_IDT_VEC_TYPE) == VMCS_IDT_VEC_SWEXCEPTION ||
             (idtvec_info & VMCS_IDT_VEC_TYPE) == VMCS_IDT_VEC_SWINTR) {
             env->ins_len = ins_len;
+        } else {
+            /* Make sure to clear ins_len when it isn't valid. */
+            env->ins_len = 0;
         }
-        if (idtvec_info & VMCS_INTR_DEL_ERRCODE) {
+        if (idtvec_info & VMCS_IDT_VEC_ERRCODE_VALID) {
             env->has_error_code = true;
             env->error_code = rvmcs(cpu->hvf_fd, VMCS_IDT_VECTORING_ERROR);
+        } else {
+            /* Make sure to clear has_error_code when error_code isn't valid. */
+            env->has_error_code = false;
         }
     }
     if ((rvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY) &
@@ -935,7 +943,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             macvm_set_rip(cpu, rip + ins_len);
             break;
         case VMX_REASON_VMCALL:
-            env->exception_nr = EXCP0D_GPF;
+            env->exception_nr = VMCS_INTR_T_HWEXCEPTION | EXCP0D_GPF;
             env->exception_injected = 1;
             env->has_error_code = true;
             env->error_code = 0;
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 1485b95776..f9187cee3f 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -345,8 +345,6 @@ void vmx_clear_int_window_exiting(CPUState *cpu)
              ~VMCS_PRI_PROC_BASED_CTLS_INT_WINDOW_EXITING);
 }
 
-#define NMI_VEC 2
-
 bool hvf_inject_interrupts(CPUState *cpu_state)
 {
     X86CPU *x86cpu = X86_CPU(cpu_state);
@@ -356,17 +354,15 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
     uint64_t intr_type;
     bool have_event = true;
     if (env->interrupt_injected != -1) {
-        vector = env->interrupt_injected;
-        intr_type = VMCS_INTR_T_SWINTR;
+        /* Type and vector are both saved in interrupt_injected. */
+        vector = env->interrupt_injected & VMCS_IDT_VEC_VECNUM;
+        intr_type = env->interrupt_injected & VMCS_IDT_VEC_TYPE;
     } else if (env->exception_nr != -1) {
-        vector = env->exception_nr;
-        if (vector == EXCP03_INT3 || vector == EXCP04_INTO) {
-            intr_type = VMCS_INTR_T_SWEXCEPTION;
-        } else {
-            intr_type = VMCS_INTR_T_HWEXCEPTION;
-        }
+        /* Type and vector are both saved in exception_nr. */
+        vector = env->exception_nr & VMCS_IDT_VEC_VECNUM;
+        intr_type = env->exception_nr & VMCS_IDT_VEC_TYPE;
     } else if (env->nmi_injected) {
-        vector = NMI_VEC;
+        vector = EXCP02_NMI;
         intr_type = VMCS_INTR_T_NMI;
     } else {
         have_event = false;
@@ -390,6 +386,8 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
             if (env->has_error_code) {
                 wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_EXCEPTION_ERROR,
                       env->error_code);
+                /* Make sure to indicate that VMCS_ENTRY_EXCEPTION_ERROR is valid */
+                info |= VMCS_INTR_DEL_ERRCODE;
             }
             /*printf("reinject  %lx err %d\n", info, err);*/
             wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_INTR_INFO, info);
@@ -399,7 +397,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
     if (cpu_state->interrupt_request & CPU_INTERRUPT_NMI) {
         if (!(env->hflags2 & HF2_NMI_MASK) && !(info & VMCS_INTR_VALID)) {
             cpu_state->interrupt_request &= ~CPU_INTERRUPT_NMI;
-            info = VMCS_INTR_VALID | VMCS_INTR_T_NMI | NMI_VEC;
+            info = VMCS_INTR_VALID | VMCS_INTR_T_NMI | EXCP02_NMI;
             wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_INTR_INFO, info);
         } else {
             vmx_set_nmi_window_exiting(cpu_state);
-- 
2.24.0


