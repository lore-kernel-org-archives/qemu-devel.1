Received: from eggs.gnu.org ([2001:4830:134:3::10]:53558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gZxAc-0007UX-Lj
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gZxAZ-00068Z-FQ
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:11:18 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gZxAZ-00065l-8p
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:11:15 -0500
Received: by mail-wr1-x444.google.com with SMTP id t27so1499788wra.6
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 04:11:15 -0800 (PST)
Received: from donizetti.lan ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id r64sm9788978wmg.5.2018.12.20.04.11.12
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 20 Dec 2018 04:11:13 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Dec 2018 13:11:12 +0100
Message-Id: <20181220121112.21667-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target-i386: hvf: remove MPX support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

MPX support is being phased out by Intel and actually I am not sure that
OS X has ever enabled it in XCR0.  Drop it from the Hypervisor.framework
acceleration.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_cpuid.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 9874a46e92..4d957fe896 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -38,16 +38,6 @@ static uint64_t xgetbv(uint32_t xcr)
     return (((uint64_t)edx) << 32) | eax;
 }
 
-static bool vmx_mpx_supported()
-{
-    uint64_t cap_exit, cap_entry;
-
-    hv_vmx_read_capability(HV_VMX_CAP_ENTRY, &cap_entry);
-    hv_vmx_read_capability(HV_VMX_CAP_EXIT, &cap_exit);
-
-    return ((cap_exit & (1 << 23)) && (cap_entry & (1 << 16)));
-}
-
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
                                  int reg)
 {
@@ -92,11 +82,8 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
                     CPUID_7_0_EBX_CLFLUSHOPT | CPUID_7_0_EBX_CLWB |
                     CPUID_7_0_EBX_AVX512DQ | CPUID_7_0_EBX_SHA_NI |
                     CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512VL |
-                    CPUID_7_0_EBX_INVPCID | CPUID_7_0_EBX_MPX;
+                    CPUID_7_0_EBX_INVPCID;
 
-            if (!vmx_mpx_supported()) {
-                ebx &= ~CPUID_7_0_EBX_MPX;
-            }
             hv_vmx_read_capability(HV_VMX_CAP_PROCBASED2, &cap);
             if (!(cap & CPU_BASED2_INVPCID)) {
                 ebx &= ~CPUID_7_0_EBX_INVPCID;
@@ -119,9 +106,6 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
                                   XSTATE_BNDCSR_MASK | XSTATE_OPMASK_MASK |
                                   XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK);
             eax &= supp_xcr0;
-            if (!vmx_mpx_supported()) {
-                eax &= ~(XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK);
-            }
         } else if (idx == 1) {
             hv_vmx_read_capability(HV_VMX_CAP_PROCBASED2, &cap);
             eax &= CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1;
-- 
2.20.1
