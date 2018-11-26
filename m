Received: from eggs.gnu.org ([2001:4830:134:3::10]:43637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRNz2-0002Vz-Rm
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRNz2-00040E-5Z
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:59:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39543)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gRNz1-000402-Un
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:59:56 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 26 Nov 2018 18:59:40 -0200
Message-Id: <20181126205941.19021-2-ehabkost@redhat.com>
In-Reply-To: <20181126205941.19021-1-ehabkost@redhat.com>
References: <20181126205941.19021-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] kvm: Use KVM_GET_MSR_INDEX_LIST for
 MSR_IA32_ARCH_CAPABILITIES support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, Bandan Das <bsd@redhat.com>

From: Bandan Das <bsd@redhat.com>

When writing to guest's MSR_IA32_ARCH_CAPABILITIES, check whether it's
supported in the guest using the KVM_GET_MSR_INDEX_LIST ioctl.

Fixes: d86f963694df27f11b3681ffd225c9362de1b634
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-by: balducci@units.it
Signed-off-by: Bandan Das <bsd@redhat.com>
Message-Id: <jpg4lc4iiav.fsf_-_@linux.bootlegged.copy>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
2.18.0.rc1.1.g3f1ff2140
