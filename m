Received: from eggs.gnu.org ([2001:4830:134:3::10]:43331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzWo-0002IU-HT
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzWn-0003mF-9U
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:02:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ebzWn-0003lo-3r
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:02:05 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Jan 2018 00:01:51 -0200
Message-Id: <20180118020157.25401-3-ehabkost@redhat.com>
In-Reply-To: <20180118020157.25401-1-ehabkost@redhat.com>
References: <20180118020157.25401-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/8] target/i386: add clflushopt to
 "Skylake-Server" cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>

From: Haozhong Zhang <haozhong.zhang@intel.com>

CPUID_7_0_EBX_CLFLUSHOPT is missed in current "Skylake-Server" cpu
model. Add it to "Skylake-Server" cpu model on pc-i440fx-2.12 and
pc-q35-2.12. Keep it disabled in "Skylake-Server" cpu model on older
machine types.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Message-Id: <20171219033730.12748-3-haozhong.zhang@intel.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h | 5 +++++
 target/i386/cpu.c    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 83d825e896..bb49165fe0 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -323,6 +323,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_2_11 \
     HW_COMPAT_2_11 \
+    {\
+        .driver   = "Skylake-Server" "-" TYPE_X86_CPU,\
+        .property = "clflushopt",\
+        .value    = "off",\
+    },
 
 #define PC_COMPAT_2_10 \
     HW_COMPAT_2_10 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ad8196b166..4385853646 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1382,7 +1382,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLWB |
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
-            CPUID_7_0_EBX_AVX512VL,
+            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
         /* Missing: XSAVES (not supported by some Linux versions,
          * including v4.1 to v4.12).
          * KVM doesn't yet expose any XSAVES state save component,
-- 
2.14.3
