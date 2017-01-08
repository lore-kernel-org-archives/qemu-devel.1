Received: from eggs.gnu.org ([2001:4830:134:3::10]:60838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQH2K-0004BV-Nj
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQH2J-0006Hr-Im
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:13:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cQH2J-0006Gt-DS
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 12:13:39 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Sun,  8 Jan 2017 15:13:30 -0200
Message-Id: <20170108171330.11129-3-ehabkost@redhat.com>
In-Reply-To: <20170108171330.11129-1-ehabkost@redhat.com>
References: <20170108171330.11129-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] kvm: Allow invtsc migration if tsc-khz
 is set explicitly
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

We can safely allow a VM to be migrated with invtsc enabled if
tsc-khz is set explicitly, because:
* QEMU already refuses to start if it can't set the TSC frequency
  to the configured value.
* Management software is already required to keep device
  configuration (including CPU configuration) the same on
  migration source and destination.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Reworded commit message
---
 target/i386/kvm.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index a26290fdc1..6a51399945 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -962,15 +962,16 @@ int kvm_arch_init_vcpu(CPUState *cs)
         has_msr_mcg_ext_ctl = has_msr_feature_control = true;
     }
 
-    if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
-        invtsc_mig_blocker == NULL) {
-        /* for migration */
-        error_setg(&invtsc_mig_blocker,
-                   "State blocked by non-migratable CPU device"
-                   " (invtsc flag)");
-        migrate_add_blocker(invtsc_mig_blocker);
-        /* for savevm */
-        vmstate_x86_cpu.unmigratable = 1;
+    if (!env->user_tsc_khz) {
+        if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
+            invtsc_mig_blocker == NULL) {
+            /* for migration */
+            error_setg(&invtsc_mig_blocker,
+                       "State blocked by non-migratable CPU device"
+                       " (invtsc flag)");
+            migrate_add_blocker(invtsc_mig_blocker);
+            /* for savevm */
+            vmstate_x86_cpu.unmigratable = 1;
     }
 
     cpuid_data.cpuid.padding = 0;
-- 
2.11.0.259.g40922b1
