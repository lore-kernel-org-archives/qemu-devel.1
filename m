Received: from eggs.gnu.org ([2001:4830:134:3::10]:54385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvk-0001vv-8a
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvj-0003LR-9q
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXZvj-0003Kn-3b
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:51 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 25 Jun 2018 19:25:24 -0300
Message-Id: <20180625222524.382-13-ehabkost@redhat.com>
In-Reply-To: <20180625222524.382-1-ehabkost@redhat.com>
References: <20180625222524.382-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 12/12] i386: Remove generic SMT thread check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Babu Moger <babu.moger@amd.com>

From: Babu Moger <babu.moger@amd.com>

Remove generic non-intel check while validating hyperthreading support.
Certain AMD CPUs can support hyperthreading now.

CPU family with TOPOEXT feature can support hyperthreading now.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1529443919-67509-4-git-send-email-babu.moger@amd.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d6ed29b484..e6c2f8a22a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4985,17 +4985,22 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     qemu_init_vcpu(cs);
 
-    /* Only Intel CPUs support hyperthreading. Even though QEMU fixes this
-     * issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
-     * based on inputs (sockets,cores,threads), it is still better to gives
+    /*
+     * Most Intel and certain AMD CPUs support hyperthreading. Even though QEMU
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
+                         "options properly or try enabling topoext feature.",
+                         cs->nr_threads);
         ht_warned = true;
     }
 
-- 
2.18.0.rc1.1.g3f1ff2140
