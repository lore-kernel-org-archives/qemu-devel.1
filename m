Received: from eggs.gnu.org ([2001:4830:134:3::10]:60833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQH2K-0004BT-Ee
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQH2H-0006GO-Pr
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:13:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cQH2H-0006G3-K1
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:13:37 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Sun,  8 Jan 2017 15:13:29 -0200
Message-Id: <20170108171330.11129-2-ehabkost@redhat.com>
In-Reply-To: <20170108171330.11129-1-ehabkost@redhat.com>
References: <20170108171330.11129-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] kvm: Simplify invtsc check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>

Instead of searching the table we have just built, we can check
the env->features field directly.

Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 10a9cd8f7f..a26290fdc1 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -962,8 +962,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         has_msr_mcg_ext_ctl = has_msr_feature_control = true;
     }
 
-    c = cpuid_find_entry(&cpuid_data.cpuid, 0x80000007, 0);
-    if (c && (c->edx & 1<<8) && invtsc_mig_blocker == NULL) {
+    if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
+        invtsc_mig_blocker == NULL) {
         /* for migration */
         error_setg(&invtsc_mig_blocker,
                    "State blocked by non-migratable CPU device"
-- 
2.11.0.259.g40922b1
