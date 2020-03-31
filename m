Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F1AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F7A206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="u6NzHvyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F7A206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ4cf-0000Iu-2H
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 20:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1jJ4Zh-0005So-B6
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1jJ4Zf-000096-Vc
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:16:13 -0400
Received: from ma1-aaemail-dr-lapp03.apple.com ([17.171.2.72]:34550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1jJ4Zf-00007e-Pw
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:16:11 -0400
Received: from pps.filterd (ma1-aaemail-dr-lapp03.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 02V02F5L002286; Mon, 30 Mar 2020 17:16:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : in-reply-to : references : mime-version
 : content-transfer-encoding; s=20180706;
 bh=6cQ9YsYiD0yDtEPmmyr32KvC+c0bsiUrac9Q+3B9QH8=;
 b=u6NzHvyOqIu8EsV/Ohm/lIr1ohaJiLccSYymb5s7giivZSjvnvUlZpXo8uhcI327BMBP
 cUSpFShCRWw78k8vDapKpHbldF/G1hNmmKYkqcMepYtANmQ6aXF3UCHGehcFnpP2/EcC
 9bZYnBJpJXJVQpXc8UCdZ2mr25nHm1QqVRGQa9i+rfZK+3djIoIb+enf7wxAVGC5pCkx
 E3J9KLSumMFSKZSknjeMLag8XBJ9ICBmnZkpOTRh93bJSAEVQ5AHW3qrWFFK3/G82SN/
 5L9I0l2ovmTmgTJYYU87ya3C7a4yVAf9XW47ZKKJyFZw/JM21MxVfq69BpClkfeYDJlz NA== 
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by ma1-aaemail-dr-lapp03.apple.com with ESMTP id 3025juy2bh-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 30 Mar 2020 17:16:11 -0700
Received: from rn-mailsvcp-mmp-lapp01.rno.apple.com
 (rn-mailsvcp-mmp-lapp01.rno.apple.com [17.179.253.14])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) with ESMTPS id <0Q8100XEY7EWTJB0@rn-mailsvcp-mta-lapp04.rno.apple.com>; 
 Mon, 30 Mar 2020 17:16:08 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp01.rno.apple.com by
 rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.5.20200312 64bit (built Mar 12
 2020)) id <0Q8100C007EE3O00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Mon,
 30 Mar 2020 17:16:08 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: c56cc4374afe9162bf6a337f3d661529
X-Va-E-CD: 4313961e8f3af7e2e35e28824e600d91
X-Va-R-CD: d26d4bf9f9c9c00185d135aa104f412a
X-Va-CD: 0
X-Va-ID: c973c730-6505-428a-ad04-02bea54d6bba
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 4313961e8f3af7e2e35e28824e600d91
X-V-R-CD: d26d4bf9f9c9c00185d135aa104f412a
X-V-CD: 0
X-V-ID: 5ceefeee-3d54-4c9c-bf72-c90e169c14f9
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
Subject: [PATCH v1 3/3] hvf: Support AVX512 guests on capable hardware
Date: Mon, 30 Mar 2020 17:16:06 -0700
Message-id: <1da0fc0a4f119e951ae11b29ff26ee587f4748aa.1585607927.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
In-reply-to: <cover.1585607927.git.dirty@apple.com>
References: <cover.1585607927.git.dirty@apple.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-30_07:2020-03-30,
 2020-03-30 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 17.171.2.72
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

macOS lazily enables AVX512.  Explicitly enable it if the processor
supports it.

cpu_x86_cpuid() tries to handle OSXSAVE but refers to env->cr[4] for the
guest copy of CR4.  HVF doesn't support caching CPUID values like KVM,
so we need to track it ourselves.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
---
 target/i386/cpu.h        |  1 +
 target/i386/hvf/hvf.c    | 68 ++++++++++++++++++++++++++++++++++++++--
 target/i386/hvf/vmx.h    |  9 +++++-
 target/i386/hvf/x86hvf.c |  2 +-
 4 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1286ec6e7a..f3864d0fac 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1591,6 +1591,7 @@ typedef struct CPUX86State {
     struct kvm_nested_state *nested_state;
 #endif
 #if defined(CONFIG_HVF)
+    bool osxsave_enabled;
     HVFX86EmulatorState *hvf_emul;
 #endif
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index fef1ee7d70..68a85c3b9b 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -65,6 +65,7 @@
 
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
+#include <mach/mach.h>
 
 #include "exec/address-spaces.h"
 #include "hw/i386/apic_internal.h"
@@ -458,7 +459,7 @@ void hvf_reset_vcpu(CPUState *cpu) {
     macvm_set_cr0(cpu->hvf_fd, CR0_CD_MASK | CR0_NW_MASK | CR0_ET_MASK);
     macvm_set_cr0(cpu->hvf_fd, 0x60000010);
 
-    wvmcs(cpu->hvf_fd, VMCS_CR4_MASK, CR4_VMXE_MASK);
+    wvmcs(cpu->hvf_fd, VMCS_CR4_MASK, CR4_VMXE_MASK | CR4_OSXSAVE_MASK);
     wvmcs(cpu->hvf_fd, VMCS_CR4_SHADOW, 0x0);
     wvmcs(cpu->hvf_fd, VMCS_GUEST_CR4, CR4_VMXE_MASK);
 
@@ -541,6 +542,55 @@ static void dummy_signal(int sig)
 {
 }
 
+static bool enable_avx512_thread_state(void)
+{
+    x86_avx512_state_t state;
+    uint32_t ebx;
+    kern_return_t ret;
+    unsigned int count;
+
+    /*
+     * macOS lazily enables AVX512 support.  Enable it explicitly if the
+     * processor supports it.
+     */
+
+    host_cpuid(7, 0, NULL, &ebx, NULL, NULL);
+    if ((ebx & CPUID_7_0_EBX_AVX512F) == 0) {
+        return false;
+    }
+
+    memset(&state, 0, sizeof(x86_avx512_state_t));
+
+    /* Get AVX state */
+    count = x86_AVX_STATE_COUNT;
+    ret = thread_get_state(mach_thread_self(),
+                           x86_AVX_STATE,
+                           (thread_state_t) &state,
+                           &count);
+    if (ret != KERN_SUCCESS) {
+        return false;
+    }
+    if (count != x86_AVX_STATE_COUNT) {
+        return false;
+    }
+    if (state.ash.flavor != x86_AVX_STATE64) {
+        return false;
+    }
+    state.ash.flavor = x86_AVX512_STATE64;
+    state.ash.count = x86_AVX512_STATE64_COUNT;
+
+    /* Now set as AVX512 */
+    ret = thread_set_state(mach_thread_self(),
+                           state.ash.flavor,
+                           (thread_state_t) &state.ufs.as64,
+                           state.ash.count);
+    if (ret != KERN_SUCCESS) {
+        return false;
+    }
+
+    return true;
+}
+
 int hvf_init_vcpu(CPUState *cpu)
 {
 
@@ -826,6 +876,18 @@ int hvf_vcpu_exec(CPUState *cpu)
 
             cpu_x86_cpuid(env, rax, rcx, &rax, &rbx, &rcx, &rdx);
 
+            if (rax == 1) {
+                /*
+                 * cpu_x86_cpuid tries to handle OSXSAVE but refers to
+                 * env->cr[4] for the guest copy of CR4.  This isn't
+                 * updated regularly so we track it ourselves in
+                 * env->osxsave_enabled.
+                 */
+                if ((rcx & CPUID_EXT_XSAVE) && env->osxsave_enabled) {
+                    rcx |= CPUID_EXT_OSXSAVE;
+                }
+            }
+
             wreg(cpu->hvf_fd, HV_X86_RAX, rax);
             wreg(cpu->hvf_fd, HV_X86_RBX, rbx);
             wreg(cpu->hvf_fd, HV_X86_RCX, rcx);
@@ -889,7 +951,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                 break;
             }
             case 4: {
-                macvm_set_cr4(cpu->hvf_fd, RRX(env, reg));
+                macvm_set_cr4(env, cpu->hvf_fd, RRX(env, reg));
                 break;
             }
             case 8: {
@@ -966,6 +1028,8 @@ static int hvf_accel_init(MachineState *ms)
     hv_return_t ret;
     HVFState *s;
 
+    enable_avx512_thread_state();
+
     ret = hv_vm_create(HV_VM_DEFAULT);
     assert_hvf_ok(ret);
 
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 1a1b150c97..dccd5ceb0f 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -157,13 +157,20 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
     hv_vcpu_flush(vcpu);
 }
 
-static inline void macvm_set_cr4(hv_vcpuid_t vcpu, uint64_t cr4)
+static inline void macvm_set_cr4(CPUX86State *env, hv_vcpuid_t vcpu,
+                                 uint64_t cr4)
 {
     uint64_t guest_cr4 = cr4 | CR4_VMXE_MASK;
 
     wvmcs(vcpu, VMCS_GUEST_CR4, guest_cr4);
     wvmcs(vcpu, VMCS_CR4_SHADOW, cr4);
 
+    /*
+     * Track whether OSXSAVE is enabled so we can properly return it
+     * for CPUID 1.
+     */
+    env->osxsave_enabled = ((cr4 & CR4_OSXSAVE_MASK) != 0);
+
     hv_vcpu_invalidate_tlb(vcpu);
     hv_vcpu_flush(vcpu);
 }
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index edefe5319a..bd25bf19c4 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -100,7 +100,7 @@ void hvf_put_segments(CPUState *cpu_state)
     vmx_update_tpr(cpu_state);
     wvmcs(cpu_state->hvf_fd, VMCS_GUEST_IA32_EFER, env->efer);
 
-    macvm_set_cr4(cpu_state->hvf_fd, env->cr[4]);
+    macvm_set_cr4(env, cpu_state->hvf_fd, env->cr[4]);
     macvm_set_cr0(cpu_state->hvf_fd, env->cr[0]);
 
     hvf_set_segment(cpu_state, &seg, &env->segs[R_CS], false);
-- 
2.24.0


