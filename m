Received: from eggs.gnu.org ([2001:4830:134:3::10]:58419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gR8L4-0003zc-4W
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 23:17:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gR8L0-0000l5-2K
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 23:17:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1gR8Kz-0000js-T6
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 23:17:34 -0500
From: Bandan Das <bsd@redhat.com>
References: <7280.1542702495@dschgrazlin2.units.it>
	<jpgd0qz3vg4.fsf@linux.bootlegged.copy>
	<20181121125008.GV4755@habkost.net>
Date: Sun, 25 Nov 2018 23:17:28 -0500
In-Reply-To: <20181121125008.GV4755@habkost.net> (Eduardo Habkost's message of
	"Wed, 21 Nov 2018 10:50:08 -0200")
Message-ID: <jpg4lc4iiav.fsf_-_@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] kvm: Use KVM_GET_MSR_INDEX_LIST for
 MSR_IA32_ARCH_CAPABILITIES support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: balducci@units.it, qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>, David Alan Gilbert <dgilbert@redhat.com>, Cole Robinson <crobinso@redhat.com>


When writing to guest's MSR_IA32_ARCH_CAPABILITIES, check whether it's
supported in the guest using the KVM_GET_MSR_INDEX_LIST ioctl.

Fixes: d86f963694df27f11b3681ffd225c9362de1b634
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-by: balducci@units.it
Signed-off-by: Bandan Das <bsd@redhat.com>
---
 target/i386/kvm.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index f524e7d929..3d6739a2b2 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -95,6 +95,7 @@ static bool has_msr_xss;
 static bool has_msr_spec_ctrl;
 static bool has_msr_virt_ssbd;
 static bool has_msr_smi_count;
+static bool has_msr_arch_capabs;
 
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -1481,6 +1482,9 @@ static int kvm_get_supported_msrs(KVMState *s)
                 case MSR_VIRT_SSBD:
                     has_msr_virt_ssbd = true;
                     break;
+                case MSR_IA32_ARCH_CAPABILITIES:
+                    has_msr_arch_capabs = true;
+                    break;
                 }
             }
         }
@@ -2002,14 +2006,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
 #endif
 
     /* If host supports feature MSR, write down. */
-    if (kvm_feature_msrs) {
-        int i;
-        for (i = 0; i < kvm_feature_msrs->nmsrs; i++)
-            if (kvm_feature_msrs->indices[i] == MSR_IA32_ARCH_CAPABILITIES) {
-                kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
-                              env->features[FEAT_ARCH_CAPABILITIES]);
-                break;
-            }
+    if (has_msr_arch_capabs) {
+        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
+                          env->features[FEAT_ARCH_CAPABILITIES]);
     }
 
     /*
-- 
2.14.5
