Received: from eggs.gnu.org ([2001:4830:134:3::10]:59862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfH-00041w-QE
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfD-0005Lm-Ii
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:11 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfD-0005LM-Ck
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:07 -0400
Received: by mail-wm0-x243.google.com with SMTP id i131so3749601wma.1
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:07 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:09 +0200
Message-Id: <1505824179-21541-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/50] i386/kvm: introduce
 tsc_is_stable_and_known()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ladi Prosek <lprosek@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

Move the "is TSC stable and known" condition to a reusable helper.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170807085703.32267-4-lprosek@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
