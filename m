Received: from eggs.gnu.org ([2001:4830:134:3::10]:42600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eR8jf-0007vU-Nk
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 22:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eR8je-0004y4-58
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 22:38:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:24814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eR8jd-0004v3-RR
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 22:38:30 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Tue, 19 Dec 2017 11:37:30 +0800
Message-Id: <20171219033730.12748-3-haozhong.zhang@intel.com>
In-Reply-To: <20171219033730.12748-1-haozhong.zhang@intel.com>
References: <20171219033730.12748-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v3 2/2] target/i386: add clflushopt to
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
model. Add it to "Skylake-Server" cpu model on pc-i440fx-2.12 and
pc-q35-2.12. Keep it disabled in "Skylake-Server" cpu model on older
machine types.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
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
index 82603e3130..54574fa232 100644
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
