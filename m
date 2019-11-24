Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376D7C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 20:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02296207DD
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 20:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="KDaSo0RP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02296207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYyCQ-0003AB-VE
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 15:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1iYy8T-0006sw-Nb
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 15:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1iYy8S-0007wH-GJ
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 15:05:33 -0500
Received: from ma1-aaemail-dr-lapp01.apple.com ([17.171.2.60]:45388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1iYy8S-0007vZ-AH
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 15:05:32 -0500
Received: from pps.filterd (ma1-aaemail-dr-lapp01.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xAOK1s5u060184; Sun, 24 Nov 2019 12:05:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : in-reply-to : references : mime-version
 : content-transfer-encoding; s=20180706;
 bh=631i+E5+V3w/tMPntS6QFcgMcTtYiV0pvlXBW1bjmXA=;
 b=KDaSo0RPLNUQS0XWgd8vgsUdUP02HM3xTytFabX0FB5Cep2bY7vSVK8a2nG8kyKWmhb3
 PJX5/NfsSfuDiq9/3rndu0lpo1sveEOaivr4QkDttF1MLS5w3TDPQoW0JWvFZj/AA8vm
 asSTcIb7aDJ4/5QO+VVdF5hqp1eoImfSWexR0CmhF4ufsjOptErsvlgydk2cpKxwihCE
 9Mo3URa89s/nvjvTqqr6Y+w0vyNR/pLZOja2WY0t+BWUcsTs+3GjvOTeepGEpaCXenON
 BBxyfONNLwT6r83jXDTP2FnMw1XSLdJ79cWNqAAEP2W/vg8A5UKY+Dzt6x8jlgbNdFIM vQ== 
Received: from mr2-mtap-s02.rno.apple.com (mr2-mtap-s02.rno.apple.com
 [17.179.226.134])
 by ma1-aaemail-dr-lapp01.apple.com with ESMTP id 2wf4a64tvw-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Sun, 24 Nov 2019 12:05:31 -0800
Received: from nwk-mmpp-sz10.apple.com
 (nwk-mmpp-sz10.apple.com [17.128.115.122]) by mr2-mtap-s02.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q1H00NR4P553D00@mr2-mtap-s02.rno.apple.com>; Sun,
 24 Nov 2019 12:05:29 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz10.apple.com by
 nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q1H00F00P3BWT00@nwk-mmpp-sz10.apple.com>; Sun,
 24 Nov 2019 12:05:29 -0800 (PST)
X-Va-A: 
X-Va-T-CD: c56cc4374afe9162bf6a337f3d661529
X-Va-E-CD: 9dc0bdaa47fefc899b9535aa263da81f
X-Va-R-CD: adefe9b51cd7c25a3de7c46b7195bdc9
X-Va-CD: 0
X-Va-ID: 77f77e58-038c-47bc-84c1-0d3830f85798
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 9dc0bdaa47fefc899b9535aa263da81f
X-V-R-CD: adefe9b51cd7c25a3de7c46b7195bdc9
X-V-CD: 0
X-V-ID: 1e954263-8d8e-4469-a389-5694a37c6fa3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-11-24_02:,, signatures=0
Received: from pontoon.com (unknown [17.234.36.164]) by nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q1H000C0P54NN30@nwk-mmpp-sz10.apple.com>; Sun,
 24 Nov 2019 12:05:29 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 2/5] hvf: remove TSC synchronization code because it isn't
 fully complete
Date: Sun, 24 Nov 2019 12:05:24 -0800
Message-id: <44c4afd2301b8bf99682b229b0796d84edd6d66f.1574625592.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
In-reply-to: <cover.1574625592.git.dirty@apple.com>
References: <cover.1574625592.git.dirty@apple.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-24_02:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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

The existing code in QEMU's HVF support to attempt to synchronize TSC
across multiple cores is not sufficient.  TSC value on other cores
can go backwards.  Until implementation is fixed, remove calls to
hv_vm_sync_tsc().  Pass through TSC to guest OS.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
---
 target/i386/hvf/hvf.c     | 3 +--
 target/i386/hvf/x86_emu.c | 3 ---
 target/i386/hvf/x86hvf.c  | 4 ----
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 0b50cfcbc6..90fd50acfc 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -518,7 +518,6 @@ void hvf_reset_vcpu(CPUState *cpu) {
         wreg(cpu->hvf_fd, HV_X86_R8 + i, 0x0);
     }
 
-    hv_vm_sync_tsc(0);
     hv_vcpu_invalidate_tlb(cpu->hvf_fd);
     hv_vcpu_flush(cpu->hvf_fd);
 }
@@ -612,7 +611,7 @@ int hvf_init_vcpu(CPUState *cpu)
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_GSBASE, 1);
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_KERNELGSBASE, 1);
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_TSC_AUX, 1);
-    /*hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_IA32_TSC, 1);*/
+    hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_IA32_TSC, 1);
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_IA32_SYSENTER_CS, 1);
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_IA32_SYSENTER_EIP, 1);
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_IA32_SYSENTER_ESP, 1);
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 1b04bd7e94..3df767209d 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -772,9 +772,6 @@ void simulate_wrmsr(struct CPUState *cpu)
 
     switch (msr) {
     case MSR_IA32_TSC:
-        /* if (!osx_is_sierra())
-             wvmcs(cpu->hvf_fd, VMCS_TSC_OFFSET, data - rdtscp());
-        hv_vm_sync_tsc(data);*/
         break;
     case MSR_IA32_APICBASE:
         cpu_set_apic_base(X86_CPU(cpu)->apic_state, data);
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index e0ea02d631..1485b95776 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -152,10 +152,6 @@ void hvf_put_msrs(CPUState *cpu_state)
 
     hv_vcpu_write_msr(cpu_state->hvf_fd, MSR_GSBASE, env->segs[R_GS].base);
     hv_vcpu_write_msr(cpu_state->hvf_fd, MSR_FSBASE, env->segs[R_FS].base);
-
-    /* if (!osx_is_sierra())
-         wvmcs(cpu_state->hvf_fd, VMCS_TSC_OFFSET, env->tsc - rdtscp());*/
-    hv_vm_sync_tsc(env->tsc);
 }
 
 
-- 
2.24.0


