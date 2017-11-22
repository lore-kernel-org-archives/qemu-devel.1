Received: from eggs.gnu.org ([2001:4830:134:3::10]:48468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eHZXd-0000g2-MW
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:14:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eHZXb-0007bR-Rt
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:14:33 -0500
Received: from mail-eopbgr20115.outbound.protection.outlook.com
	([40.107.2.115]:44320
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eHZXb-0007aQ-Kc
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:14:31 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 22 Nov 2017 21:14:17 +0300
Message-Id: <20171122181418.14180-3-rkagan@virtuozzo.com>
In-Reply-To: <20171122181418.14180-1-rkagan@virtuozzo.com>
References: <20171122181418.14180-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3] hyperv: ensure SINTx msrs are reset
 properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>

Initially SINTx msrs should be in "masked" state.  To ensure that
happens on *every* reset, move setting their values to
kvm_arch_vcpu_reset.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/kvm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 563967241b..ea6e6e5f30 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -662,8 +662,6 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |= HV_VP_RUNTIME_AVAILABLE;
     }
     if (cpu->hyperv_synic) {
-        int sint;
-
         if (!has_msr_hv_synic ||
             kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_SYNIC, 0)) {
             fprintf(stderr, "Hyper-V SynIC is not supported by kernel\n");
@@ -672,9 +670,6 @@ static int hyperv_handle_properties(CPUState *cs)
 
         env->features[FEAT_HYPERV_EAX] |= HV_SYNIC_AVAILABLE;
         env->msr_hv_synic_version = HV_SYNIC_VERSION;
-        for (sint = 0; sint < ARRAY_SIZE(env->msr_hv_synic_sint); sint++) {
-            env->msr_hv_synic_sint[sint] = HV_SINT_MASKED;
-        }
     }
     if (cpu->hyperv_stimer) {
         if (!has_msr_hv_stimer) {
@@ -1053,6 +1048,13 @@ void kvm_arch_reset_vcpu(X86CPU *cpu)
     } else {
         env->mp_state = KVM_MP_STATE_RUNNABLE;
     }
+
+    if (cpu->hyperv_synic) {
+        int i;
+        for (i = 0; i < ARRAY_SIZE(env->msr_hv_synic_sint); i++) {
+            env->msr_hv_synic_sint[i] = HV_SINT_MASKED;
+        }
+    }
 }
 
 void kvm_arch_do_init_vcpu(X86CPU *cpu)
-- 
2.14.3
