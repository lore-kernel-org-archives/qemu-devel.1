Received: from eggs.gnu.org ([2001:4830:134:3::10]:59498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eObKX-0006jZ-Ip
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 22:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eObKU-0001WI-9L
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 22:34:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:38062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eObKT-0001T4-VS
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 22:34:02 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Tue, 12 Dec 2017 11:33:39 +0800
Message-Id: <20171212033339.30317-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v2] target/i386: add clflushopt to
 "Skylake-Server" cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>

CPUID_7_0_EBX_CLFLUSHOPT is missed in current "Skylake-Server" cpu
model. Add it to "Skylake-Server" cpu model on pc-i440fx-2.11 and
pc-q35-2.11. Keep it disabled in "Skylake-Server" cpu model on older
machine types.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
v1 can be found at 
  https://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg01659.html

I'm not sure whether this patch is too late for QEMU 2.11. If it is, I'll
rebase and resend it after 2.12 window opens.
---
 include/hw/i386/pc.h | 5 +++++
 target/i386/cpu.c    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ef438bd765..085a688b26 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -383,6 +383,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = "q35-pcihost",\
         .property = "x-pci-hole64-fix",\
         .value    = "off",\
+    },\
+    {\
+        .driver   = "Skylake-Server" "-" TYPE_X86_CPU,\
+        .property = "clflushopt",\
+        .value    = "off",\
     },
 
 #define PC_COMPAT_2_9 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 045d66191f..7d033b7d30 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1376,7 +1376,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLWB |
             CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
             CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
-            CPUID_7_0_EBX_AVX512VL,
+            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
         /* Missing: XSAVES (not supported by some Linux versions,
          * including v4.1 to v4.12).
          * KVM doesn't yet expose any XSAVES state save component,
-- 
2.14.1
