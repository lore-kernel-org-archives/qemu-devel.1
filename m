Received: from eggs.gnu.org ([2001:4830:134:3::10]:39851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fKvMr-0002NL-79
	for qemu-devel@nongnu.org; Mon, 21 May 2018 20:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fKvMo-0007AL-NA
	for qemu-devel@nongnu.org; Mon, 21 May 2018 20:41:33 -0400
Received: from mail-co1nam03on0050.outbound.protection.outlook.com
	([104.47.40.50]:16315
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fKvMo-00078T-F6
	for qemu-devel@nongnu.org; Mon, 21 May 2018 20:41:30 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Mon, 21 May 2018 20:41:15 -0400
Message-Id: <1526949675-106737-6-git-send-email-babu.moger@amd.com>
In-Reply-To: <1526949675-106737-1-git-send-email-babu.moger@amd.com>
References: <1526949675-106737-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v10 5/5] i386: Remove generic SMT thread check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, babu.moger@amd.com, kash@tripleback.net, geoff@hostfission.com

Remove generic non-intel check while validating hyperthreading support.
Certain AMD CPUs can support hyperthreading now.

CPU family with TOPOEXT feature can support hyperthreading now.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d20b305..7eba8cc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4961,17 +4961,20 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
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
+                         "hyperthreading(%d). Please configure -smp "
+                         "options properly.", cs->nr_threads);
         ht_warned = true;
     }
 
-- 
1.8.3.1
