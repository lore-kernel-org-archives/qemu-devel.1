Received: from eggs.gnu.org ([2001:4830:134:3::10]:38301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo2D-0003X0-Qf
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo2C-0006FH-4Z
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cVo2B-0006Ew-Ul
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:24 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jan 2017 21:27:38 -0200
Message-Id: <20170123232738.20796-14-ehabkost@redhat.com>
In-Reply-To: <20170123232738.20796-1-ehabkost@redhat.com>
References: <20170123232738.20796-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 13/13] kvm: Allow invtsc migration if tsc-khz is
 set explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

We can safely allow a VM to be migrated with invtsc enabled if
tsc-khz is set explicitly, because:
* QEMU already refuses to start if it can't set the TSC frequency
  to the configured value.
* Management software is already required to keep device
  configuration (including CPU configuration) the same on
  migration source and destination.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170108173234.25721-3-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/kvm.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9744552b8a..3b5282186c 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -963,15 +963,17 @@ int kvm_arch_init_vcpu(CPUState *cs)
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
+        }
     }
 
     cpuid_data.cpuid.padding = 0;
-- 
2.11.0.259.g40922b1
