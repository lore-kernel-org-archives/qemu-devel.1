Received: from eggs.gnu.org ([2001:4830:134:3::10]:40239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gH374-0001oS-PI
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 04:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gH36t-0003ho-83
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 04:41:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:36704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1gH36r-0003gq-OD
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 04:41:18 -0400
From: Tao Xu <tao3.xu@intel.com>
Date: Mon, 29 Oct 2018 16:39:53 +0800
Message-Id: <5014b57f834dcfa8fd3781504d98dcf063d54fde.1540801392.git.tao3.xu@intel.com>
In-Reply-To: <cover.1540801392.git.tao3.xu@intel.com>
References: <cover.1540801392.git.tao3.xu@intel.com>
In-Reply-To: <cover.1540801392.git.tao3.xu@intel.com>
References: <cover.1540801392.git.tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH v2 1/1] i386: Add PKU on Skylake-Server CPU
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
on Intel(R) Xeon(R) Processor Scalable Family. So PKU is supposed
to be in Skylake-Server CPU model. And PKU's CPUID has been
exposed to QEMU. But PKU can't be find in Skylake-Server CPU
model in the code. So this patch will fix this issue in
Skylake-Server CPU model.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 include/hw/i386/pc.h | 10 +++++++++-
 target/i386/cpu.c    |  4 ++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index dfe6746692..136fe497b6 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -300,7 +300,15 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = TYPE_X86_CPU,\
         .property = "x-hv-synic-kvm-only",\
         .value    = "on",\
-    }
+    },{\
+        .driver   = "Skylake-Server" "-" TYPE_X86_CPU,\
+        .property = "pku",\
+        .value    = "off",\
+    },{\
+        .driver   = "Skylake-Server-IBRS" "-" TYPE_X86_CPU,\
+        .property = "pku",\
+        .value    = "off",\
+    },
 
 #define PC_COMPAT_2_12 \
     HW_COMPAT_2_12 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1469a1be01..6fb7bee0f2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2322,6 +2322,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_PKU,
         /* Missing: XSAVES (not supported by some Linux versions,
          * including v4.1 to v4.12).
          * KVM doesn't yet expose any XSAVES state save component,
@@ -2372,6 +2374,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_PKU,
         /* Missing: XSAVES (not supported by some Linux versions,
          * including v4.1 to v4.12).
          * KVM doesn't yet expose any XSAVES state save component,
-- 
2.17.1
