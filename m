Received: from eggs.gnu.org ([208.118.235.92]:39486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gcLfI-0004Ua-SE
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 21:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gcLfC-00049O-Jo
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 21:44:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:35525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1gcLfC-0003v7-53
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 21:44:46 -0500
From: Tao Xu <tao3.xu@intel.com>
Date: Thu, 27 Dec 2018 10:43:04 +0800
Message-Id: <20181227024304.12182-3-tao3.xu@intel.com>
In-Reply-To: <20181227024304.12182-1-tao3.xu@intel.com>
References: <20181227024304.12182-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH 2/2] i386: Add some MSR based features on
 Cascadelake-Server CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, tao3.xu@intel.com, robert.hu@linux.intel.com, mark.kanda@oracle.com

As noted in
http://lists.gnu.org/archive/html/qemu-devel/2018-09/msg02212.html
Because MSR based feature has been supported by QEMU,
we add CPUID_7_0_EDX_ARCH_CAPABILITIES on Cascadelake-Server CPU
model, and add IA32_ARCH_CAPABILITIES MSR based features (RDCL_NO,
IBRS_ALL and SKIP_L1DFL_VMENTRY).

Note:
RSBA and SSBD_NO are not supported by native machines on stepping
6 of Cascadelake-Server, so we will keep the CPU model updated.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 include/hw/i386/pc.h | 16 ++++++++++++++++
 target/i386/cpu.c    |  6 +++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 95453968db..741ceefa5b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -304,6 +304,22 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = "Cascadelake-Server" "-" TYPE_X86_CPU,\
         .property = "stepping",\
         .value    = "5",\
+    },{\
+        .driver   = "Cascadelake-Server" "-" TYPE_X86_CPU,\
+        .property = "arch-capabilities",\
+        .value    = "off",\
+    },{\
+        .driver   = "Cascadelake-Server" "-" TYPE_X86_CPU,\
+        .property = "rdctl-no",\
+        .value    = "off",\
+    },{\
+        .driver   = "Cascadelake-Server" "-" TYPE_X86_CPU,\
+        .property = "ibrs-all",\
+        .value    = "off",\
+    },{\
+        .driver   = "Cascadelake-Server" "-" TYPE_X86_CPU,\
+        .property = "skip-l1dfl-vmentry",\
+        .value    = "off",\
     },
 
 #define PC_COMPAT_3_0 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 09706ad51a..5296c73cd5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2499,7 +2499,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_OSPKE |
             CPUID_7_0_ECX_AVX512VNNI,
         .features[FEAT_7_0_EDX] =
-            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD |
+            CPUID_7_0_EDX_ARCH_CAPABILITIES,
         /* Missing: XSAVES (not supported by some Linux versions,
                 * including v4.1 to v4.12).
                 * KVM doesn't yet expose any XSAVES state save component,
@@ -2511,6 +2512,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
+        .features[FEAT_ARCH_CAPABILITIES] =
+            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
+            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY,
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Cascadelake)",
     },
-- 
2.17.1
