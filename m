Received: from eggs.gnu.org ([2001:4830:134:3::10]:44464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gCiBT-0004i2-WB
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gCiBS-0004aj-9Z
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:32:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:10864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1gCiBQ-0004R8-2k
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:32:04 -0400
From: Tao Xu <tao3.xu@intel.com>
Date: Wed, 17 Oct 2018 17:30:53 +0800
Message-Id: <20181017093053.8811-2-tao3.xu@intel.com>
In-Reply-To: <20181017093053.8811-1-tao3.xu@intel.com>
References: <20181017093053.8811-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH 1/1] i386: Add PKU/OSPKE on Skylake-Server CPU
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com
Cc: pbonzini@redhat.com, rth@twiddle.net, jingqi.liu@intel.com, robert.hu@intel.com, qemu-devel@nongnu.org, Tao Xu <tao3.xu@intel.com>

As the release document ref below link (page 13):
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf

PKU is supported in Skylake Server (Only Server) and later, and 
on Intel(R) Xeon(R) Processor Scalable Family. OSPKE is to reads 
the value of PKRU (Instruction of PKU) into EAX and clears EDX.
So PKU/OSPKE are supposed to be in Skylake-Server CPU model. 
And PKU/OSPKE 's CPUID has been exposed to QEMU. But PKU/OSPKE
can't be find in Skylake-Server CPU model in the code. 
So this patch will fix PKU/OSPKE this issue in Skylake-Server 
CPU model.  

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 target/i386/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f24295e6e4..6ecd28c8a2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2322,6 +2322,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_OSPKE,
         /* Missing: XSAVES (not supported by some Linux versions,
          * including v4.1 to v4.12).
          * KVM doesn't yet expose any XSAVES state save component,
@@ -2372,6 +2374,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_OSPKE,
         /* Missing: XSAVES (not supported by some Linux versions,
          * including v4.1 to v4.12).
          * KVM doesn't yet expose any XSAVES state save component,
-- 
2.17.1
