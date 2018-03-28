Received: from eggs.gnu.org ([2001:4830:134:3::10]:55474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1f1D2B-0001ZM-6j
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1f1D27-0005xG-7Y
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:30:43 -0400
Received: from mail-db5eur01on0115.outbound.protection.outlook.com
	([104.47.2.115]:29664
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1f1D26-0005tY-VW
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:30:39 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 28 Mar 2018 18:30:24 +0300
Message-Id: <20180328153024.23039-3-rkagan@virtuozzo.com>
In-Reply-To: <20180328153024.23039-1-rkagan@virtuozzo.com>
References: <20180328153024.23039-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.12 v2 2/2] i386/hyperv: error out if
 features requested but unsupported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

In order to guarantee compatibility on migration, QEMU should have
complete control over the features it announces to the guest via CPUID.

However, for a number of Hyper-V-related cpu properties, if the
corresponding feature is not supported by the underlying KVM, the
propery is silently ignored and the feature is not announced to the
guest.

Refuse to start with an error instead.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
v1 -> v2:
 - indicate what flag requested the feature that can't be enabled in the
   error message
 - fix a typo in the error message for VP_RUNTIME

 target/i386/kvm.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b35623ae24..113926aff2 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -659,17 +659,41 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
         env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
     }
-    if (cpu->hyperv_crash && has_msr_hv_crash) {
+    if (cpu->hyperv_crash) {
+        if (!has_msr_hv_crash) {
+            fprintf(stderr, "Hyper-V crash MSRs "
+                    "(requested by 'hv-crash' cpu flag) "
+                    "are not supported by kernel\n");
+            return -ENOSYS;
+        }
         env->features[FEAT_HYPERV_EDX] |= HV_GUEST_CRASH_MSR_AVAILABLE;
     }
     env->features[FEAT_HYPERV_EDX] |= HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE;
-    if (cpu->hyperv_reset && has_msr_hv_reset) {
+    if (cpu->hyperv_reset) {
+        if (!has_msr_hv_reset) {
+            fprintf(stderr, "Hyper-V reset MSR "
+                    "(requested by 'hv-reset' cpu flag) "
+                    "is not supported by kernel\n");
+            return -ENOSYS;
+        }
         env->features[FEAT_HYPERV_EAX] |= HV_RESET_AVAILABLE;
     }
-    if (cpu->hyperv_vpindex && has_msr_hv_vpindex) {
+    if (cpu->hyperv_vpindex) {
+        if (!has_msr_hv_vpindex) {
+            fprintf(stderr, "Hyper-V VP_INDEX MSR "
+                    "(requested by 'hv-vpindex' cpu flag) "
+                    "is not supported by kernel\n");
+            return -ENOSYS;
+        }
         env->features[FEAT_HYPERV_EAX] |= HV_VP_INDEX_AVAILABLE;
     }
-    if (cpu->hyperv_runtime && has_msr_hv_runtime) {
+    if (cpu->hyperv_runtime) {
+        if (!has_msr_hv_runtime) {
+            fprintf(stderr, "Hyper-V VP_RUNTIME MSR "
+                    "(requested by 'hv-runtime' cpu flag) "
+                    "is not supported by kernel\n");
+            return -ENOSYS;
+        }
         env->features[FEAT_HYPERV_EAX] |= HV_VP_RUNTIME_AVAILABLE;
     }
     if (cpu->hyperv_synic) {
-- 
2.14.3
