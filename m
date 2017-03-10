Received: from eggs.gnu.org ([2001:4830:134:3::10]:56692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cmPYM-0005fF-1e
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:46:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cmPYK-0006CB-VY
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:46:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cmPYK-0006Bj-PJ
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 13:46:12 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 10 Mar 2017 15:45:52 -0300
Message-Id: <20170310184552.1481-4-ehabkost@redhat.com>
In-Reply-To: <20170310184552.1481-1-ehabkost@redhat.com>
References: <20170310184552.1481-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] i386: Change stepping of Haswell to
 non-blacklisted value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

glibc blacklists TSX on Haswell CPUs with model==60 and
stepping < 4. To make the Haswell CPU model more useful, make
those guests actually use TSX by changing CPU stepping to 4.

References:
* glibc commit 2702856bf45c82cf8e69f2064f5aa15c0ceb6359
  https://sourceware.org/git/?p=glibc.git;a=commit;h=2702856bf45c82cf8e69f2064f5aa15c0ceb6359

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170309181212.18864-4-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h | 5 +++++
 target/i386/cpu.c    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ab303c7fee..f278b3ae89 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -389,6 +389,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = TYPE_X86_CPU,\
         .property = "vmware-cpuid-freq",\
         .value    = "off",\
+    },\
+    {\
+        .driver   = "Haswell-" TYPE_X86_CPU,\
+        .property = "stepping",\
+        .value    = "1",\
     },
 
 #define PC_COMPAT_2_7 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 30ba1bd06b..7aa762245a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1196,7 +1196,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .vendor = CPUID_VENDOR_INTEL,
         .family = 6,
         .model = 60,
-        .stepping = 1,
+        .stepping = 4,
         .features[FEAT_1_EDX] =
             CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
             CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
-- 
2.11.0.259.g40922b1
