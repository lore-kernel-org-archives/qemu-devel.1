Received: from eggs.gnu.org ([2001:4830:134:3::10]:47326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeeo-0000mg-Ku
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHeen-0006uo-LK
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:46:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gHeen-0006tn-BC
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:46:49 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 Oct 2018 21:45:50 -0300
Message-Id: <20181031004550.15410-8-ehabkost@redhat.com>
In-Reply-To: <20181031004550.15410-1-ehabkost@redhat.com>
References: <20181031004550.15410-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] i386: Add PKU on Skylake-Server CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Tao Xu <tao3.xu@intel.com>

From: Tao Xu <tao3.xu@intel.com>

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
Message-Id: <5014b57f834dcfa8fd3781504d98dcf063d54fde.1540801392.git.tao3.xu@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
index 9f2e93bdae..af7e9f09cc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2392,6 +2392,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_PKU,
         /* Missing: XSAVES (not supported by some Linux versions,
          * including v4.1 to v4.12).
          * KVM doesn't yet expose any XSAVES state save component,
@@ -2442,6 +2444,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
             CPUID_7_0_EBX_AVX512VL,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_PKU,
         /* Missing: XSAVES (not supported by some Linux versions,
          * including v4.1 to v4.12).
          * KVM doesn't yet expose any XSAVES state save component,
-- 
2.18.0.rc1.1.g3f1ff2140
