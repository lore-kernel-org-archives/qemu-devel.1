Received: from eggs.gnu.org ([2001:4830:134:3::10]:47317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5G-0005fe-N3
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5D-0007Cy-W5
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:02 -0400
Received: from mail-eopbgr30133.outbound.protection.outlook.com
	([40.107.3.133]:4192
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dIJ5D-00075V-KW
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:19:59 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Jun 2017 21:19:29 +0300
Message-Id: <20170606181948.16238-5-rkagan@virtuozzo.com>
In-Reply-To: <20170606181948.16238-1-rkagan@virtuozzo.com>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 04/23] hyperv: ensure msrs are inited properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

Make sure HV_X64_MSR_SVERSION and HV_X64_MSR_SINTx are properly
initialized at guest start.

For that, move the field containing SVERSION value into the region in
CPUX86State which is preserved across resets, and move the
initialization of SINTx to kvm_arch_vcpu_reset().

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/cpu.h |  3 ++-
 target/i386/kvm.c | 12 +++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7af2cce..7c97bce 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1099,7 +1099,6 @@ typedef struct CPUX86State {
     uint64_t msr_hv_crash_params[HV_CRASH_PARAMS];
     uint64_t msr_hv_runtime;
     uint64_t msr_hv_synic_control;
-    uint64_t msr_hv_synic_version;
     uint64_t msr_hv_synic_evt_page;
     uint64_t msr_hv_synic_msg_page;
     uint64_t msr_hv_synic_sint[HV_SINT_COUNT];
@@ -1159,6 +1158,8 @@ typedef struct CPUX86State {
     uint64_t mtrr_deftype;
     MTRRVar mtrr_var[MSR_MTRRcap_VCNT];
 
+    uint64_t msr_hv_synic_version;
+
     /* For KVM */
     uint32_t mp_state;
     int32_t exception_injected;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 3a80913..251aa95 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -646,8 +646,6 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |= HV_VP_RUNTIME_AVAILABLE;
     }
     if (cpu->hyperv_synic) {
-        int sint;
-
         if (!has_msr_hv_synic ||
             kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_SYNIC, 0)) {
             fprintf(stderr, "Hyper-V SynIC is not supported by kernel\n");
@@ -656,9 +654,6 @@ static int hyperv_handle_properties(CPUState *cs)
 
         env->features[FEAT_HYPERV_EAX] |= HV_SYNIC_AVAILABLE;
         env->msr_hv_synic_version = HV_SYNIC_VERSION;
-        for (sint = 0; sint < ARRAY_SIZE(env->msr_hv_synic_sint); sint++) {
-            env->msr_hv_synic_sint[sint] = HV_SINT_MASKED;
-        }
     }
     if (cpu->hyperv_stimer) {
         if (!has_msr_hv_stimer) {
@@ -1038,6 +1033,13 @@ void kvm_arch_reset_vcpu(X86CPU *cpu)
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
2.9.4
