Received: from eggs.gnu.org ([2001:4830:134:3::10]:60550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dVv6s-0007WU-Kx
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dVv6n-0005SG-Ue
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:33:58 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:39998)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dVv6n-0005Pi-Bh
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:33:53 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Fri, 14 Jul 2017 23:47:36 +0800
Message-Id: <1500047256-8911-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V2] target-i386:kvm_get/put_vcpu_events don't
 handle sipi_vector
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, pbonzini@redhat.com, ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

qemu call kvm_get_vcpu_events, and kernel return sipi_vector always 0,
never valid when reporting to user space. But qemu call kvm_put_vcpu_events
will make sipi_vector in kernel be 0. This will accidently modify sipi_vector
when sipi_vector in kernel is not 0.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Reviewed-by: Liu Yi <liu.yi24@zte.com.cn>
---
 target/i386/kvm.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index f84a49d..7abb533 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2444,8 +2444,12 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     }
 
     if (level >= KVM_PUT_RESET_STATE) {
-        events.flags |=
-            KVM_VCPUEVENT_VALID_NMI_PENDING | KVM_VCPUEVENT_VALID_SIPI_VECTOR;
+        if (env->mp_state == KVM_MP_STATE_SIPI_RECEIVED) {
+            events.flags |=
+                KVM_VCPUEVENT_VALID_NMI_PENDING | KVM_VCPUEVENT_VALID_SIPI_VECTOR;
+        } else {
+            events.flags |= KVM_VCPUEVENT_VALID_NMI_PENDING;
+        }
     }
 
     return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
@@ -2633,6 +2637,10 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
     if (ret < 0) {
         return ret;
     }
+    ret = kvm_put_vcpu_events(x86_cpu, level);
+    if (ret < 0) {
+        return ret;
+    }
     if (level >= KVM_PUT_RESET_STATE) {
         ret = kvm_put_mp_state(x86_cpu);
         if (ret < 0) {
@@ -2644,11 +2652,6 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
     if (ret < 0) {
         return ret;
     }
-
-    ret = kvm_put_vcpu_events(x86_cpu, level);
-    if (ret < 0) {
-        return ret;
-    }
     ret = kvm_put_debugregs(x86_cpu);
     if (ret < 0) {
         return ret;
@@ -2688,15 +2691,15 @@ int kvm_arch_get_registers(CPUState *cs)
     if (ret < 0) {
         goto out;
     }
-    ret = kvm_get_mp_state(cpu);
+    ret = kvm_get_vcpu_events(cpu);
     if (ret < 0) {
         goto out;
     }
-    ret = kvm_get_apic(cpu);
+    ret = kvm_get_mp_state(cpu);
     if (ret < 0) {
         goto out;
     }
-    ret = kvm_get_vcpu_events(cpu);
+    ret = kvm_get_apic(cpu);
     if (ret < 0) {
         goto out;
     }
-- 
1.8.3.1
