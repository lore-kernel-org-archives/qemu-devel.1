Received: from eggs.gnu.org ([2001:4830:134:3::10]:54385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dedqj-0001Qm-Lg
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dedqi-0007Fj-6J
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:57:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dedqh-0007FP-W4
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:57:20 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon,  7 Aug 2017 10:57:02 +0200
Message-Id: <20170807085703.32267-4-lprosek@redhat.com>
In-Reply-To: <20170807085703.32267-1-lprosek@redhat.com>
References: <20170807085703.32267-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] i386/kvm: introduce
 tsc_is_stable_and_known()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, david@redhat.com, rkrcmar@redhat.com

Move the "is TSC stable and known" condition to a reusable helper.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 target/i386/kvm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 15d56ae..2dc01c9 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -611,6 +611,15 @@ static int kvm_arch_set_tsc_khz(CPUState *cs)
     return 0;
 }
 
+static bool tsc_is_stable_and_known(CPUX86State *env)
+{
+    if (!env->tsc_khz) {
+        return false;
+    }
+    return (env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC)
+        || env->user_tsc_khz;
+}
+
 static int hyperv_handle_properties(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -986,9 +995,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         && cpu->expose_kvm
         && kvm_base == KVM_CPUID_SIGNATURE
         /* TSC clock must be stable and known for this feature. */
-        && ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC)
-            || env->user_tsc_khz != 0)
-        && env->tsc_khz != 0) {
+        && tsc_is_stable_and_known(env)) {
 
         c = &cpuid_data.entries[cpuid_i++];
         c->function = KVM_CPUID_SIGNATURE | 0x10;
-- 
2.9.3
