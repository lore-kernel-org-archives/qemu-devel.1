Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22367C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 23:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26B220684
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 23:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="WSsFoc2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26B220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibvaF-0000A7-U1
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 18:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1ibvXf-0006fl-VA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 18:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1ibvXd-0008TF-H3
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 18:55:47 -0500
Received: from nwk-aaemail-lapp01.apple.com ([17.151.62.66]:37134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1ibvXd-0008QE-6i
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 18:55:45 -0500
Received: from pps.filterd (nwk-aaemail-lapp01.apple.com [127.0.0.1])
 by nwk-aaemail-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xB2Nq6Lx044435; Mon, 2 Dec 2019 15:55:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : in-reply-to : references : mime-version
 : content-transfer-encoding; s=20180706;
 bh=M6Amdn5tTnG0+MiIbSoHQ+Q5fB9Zaizyl4VxdLmO/kM=;
 b=WSsFoc2QN+FRvFnnaFf9wNSRpt83JFp5LRorxfI690Lrr2oorXypbCMG0XER0J0enOhp
 T6oFK04qrqzQ63FT1fe0SP86bugzhBEJXqRpnIrF44uN7foQ9Mb2Gab10yU28e37KwOy
 YjRaetdmKd4MWL3YHL5+LPtWJNNJ9xqVuB9tC22Ne5WZ/tvvQPj9VMJ3fbVpMT37Z3nP
 HAAeLi3lZykTtgwGdsmlR+k1eBYEW5xui1RAZ25xsbh5AOBMH5GsupQbqkWhhqCaN8MF
 u4n10T5SbmQPP6GqfsRrVZ6bi7pl4CzQ4gjn0aYiB6Iv6lF2Lf8c860CNpQXT6OrHjVT FQ== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com
 [17.40.76.7])
 by nwk-aaemail-lapp01.apple.com with ESMTP id 2wkr83ys1h-5
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
X-Va-E-CD: e901bae79aabc4d8f90935e818db0bf1
X-Va-R-CD: 717efc5767b68d0267f4c572528f496b
X-Va-CD: 0
X-Va-ID: 5dcc9b38-72a6-4400-9259-6c6f6ae2f8c4
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: e901bae79aabc4d8f90935e818db0bf1
X-V-R-CD: 717efc5767b68d0267f4c572528f496b
X-V-CD: 0
X-V-ID: d94293ff-4d4d-4fb9-b533-5ed91a6a0d7a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-12-02_06:,, signatures=0
Received: from pontoon.com (unknown [17.193.42.217]) by nwk-mmpp-sz12.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q1W00JNAT4TQI20@nwk-mmpp-sz12.apple.com>; Mon,
 02 Dec 2019 15:55:42 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v3 5/5] hvf: correctly inject VMCS_INTR_T_HWINTR versus
 VMCS_INTR_T_SWINTR.
Date: Mon, 02 Dec 2019 15:55:41 -0800
Message-id: <bf8d945ea1b423786d7802bbcf769517d1fd01f8.1575330463.git.dirty@apple.com>
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

Previous implementation in hvf_inject_interrupts() would always inject
VMCS_INTR_T_SWINTR even when VMCS_INTR_T_HWINTR was required.  Now
correctly determine when VMCS_INTR_T_HWINTR is appropriate versus
VMCS_INTR_T_SWINTR.

Make sure to clear ins_len and has_error_code when ins_len isn't
valid and error_code isn't set.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
---
 target/i386/hvf/hvf.c    |  4 +++-
 target/i386/hvf/x86hvf.c | 14 +++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 784e67d77e..d72543dc31 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -637,6 +637,8 @@ static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_in
     env->exception_injected = 0;
     env->interrupt_injected = -1;
     env->nmi_injected = false;
+    env->ins_len = 0;
+    env->has_error_code = false;
     if (idtvec_info & VMCS_IDT_VEC_VALID) {
         switch (idtvec_info & VMCS_IDT_VEC_TYPE) {
         case VMCS_IDT_VEC_HWINTR:
@@ -659,7 +661,7 @@ static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_in
             (idtvec_info & VMCS_IDT_VEC_TYPE) == VMCS_IDT_VEC_SWINTR) {
             env->ins_len = ins_len;
         }
-        if (idtvec_info & VMCS_INTR_DEL_ERRCODE) {
+        if (idtvec_info & VMCS_IDT_VEC_ERRCODE_VALID) {
             env->has_error_code = true;
             env->error_code = rvmcs(cpu->hvf_fd, VMCS_IDT_VECTORING_ERROR);
         }
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 1485b95776..edefe5319a 100644
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
@@ -357,7 +355,11 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
     bool have_event = true;
     if (env->interrupt_injected != -1) {
         vector = env->interrupt_injected;
-        intr_type = VMCS_INTR_T_SWINTR;
+        if (env->ins_len) {
+            intr_type = VMCS_INTR_T_SWINTR;
+        } else {
+            intr_type = VMCS_INTR_T_HWINTR;
+        }
     } else if (env->exception_nr != -1) {
         vector = env->exception_nr;
         if (vector == EXCP03_INT3 || vector == EXCP04_INTO) {
@@ -366,7 +368,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
             intr_type = VMCS_INTR_T_HWEXCEPTION;
         }
     } else if (env->nmi_injected) {
-        vector = NMI_VEC;
+        vector = EXCP02_NMI;
         intr_type = VMCS_INTR_T_NMI;
     } else {
         have_event = false;
@@ -390,6 +392,8 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
             if (env->has_error_code) {
                 wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_EXCEPTION_ERROR,
                       env->error_code);
+                /* Indicate that VMCS_ENTRY_EXCEPTION_ERROR is valid */
+                info |= VMCS_INTR_DEL_ERRCODE;
             }
             /*printf("reinject  %lx err %d\n", info, err);*/
             wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_INTR_INFO, info);
@@ -399,7 +403,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
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


