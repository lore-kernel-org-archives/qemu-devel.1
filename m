Received: from eggs.gnu.org ([2001:4830:134:3::10]:51851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1epPc1-0002AZ-7n
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 21:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1epPbx-0000Wi-VX
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 21:30:57 -0500
Received: from mail-bl2nam02on0051.outbound.protection.outlook.com
	([104.47.38.51]:33378
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1epPbx-0000W3-OB
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 21:30:53 -0500
From: Babu Moger <babu.moger@amd.com>
Date: Fri, 23 Feb 2018 21:30:25 -0500
Message-Id: <1519439425-27883-6-git-send-email-babu.moger@amd.com>
In-Reply-To: <1519439425-27883-1-git-send-email-babu.moger@amd.com>
References: <1519439425-27883-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 5/5] target/i386: Remove generic SMT thread
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, pixo@polepetko.eu, Gary.Hook@amd.com, babu.moger@amd.com

Remove generic non-intel check while validating hyperthreading support.
Certain AMD CPUs can support hyperthreading now.

CPU family with TOPOEXT feature can support hyperthreading now.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6d06637..295c409 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4336,17 +4336,20 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     qemu_init_vcpu(cs);
 
-    /* Only Intel CPUs support hyperthreading. Even though QEMU fixes this
-     * issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
-     * based on inputs (sockets,cores,threads), it is still better to gives
+    /* Most Intel and certain AMD CPUs support hyperthreading. Even though QEMU
+     * fixes this issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
+     * based on inputs (sockets,cores,threads), it is still better to give
      * users a warning.
      *
      * NOTE: the following code has to follow qemu_init_vcpu(). Otherwise
      * cs->nr_threads hasn't be populated yet and the checking is incorrect.
      */
-    if (!IS_INTEL_CPU(env) && cs->nr_threads > 1 && !ht_warned) {
-        error_report("AMD CPU doesn't support hyperthreading. Please configure"
-                     " -smp options properly.");
+     if (IS_AMD_CPU(env) &&
+         !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
+         cs->nr_threads > 1 && !ht_warned) {
+            error_report("This family of AMD CPU doesn't support "
+                         "hyperthreading. Please configure -smp "
+                         "options properly.");
         ht_warned = true;
     }
 
-- 
1.8.3.1
