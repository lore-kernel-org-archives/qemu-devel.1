Received: from eggs.gnu.org ([2001:4830:134:3::10]:35378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZzM-0003FK-A7
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZzI-0004HN-V7
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:25:44 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dcZzI-0004GQ-ML
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:25:40 -0400
Received: by mail-wm0-x241.google.com with SMTP id r77so3808820wmd.2
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 09:25:40 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  1 Aug 2017 18:17:15 +0200
Message-Id: <1501604245-33460-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/17] target-i386: kvm_get/put_vcpu_events
 don't handle sipi_vector
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peng Hao <peng.hao2@zte.com.cn>

From: Peng Hao <peng.hao2@zte.com.cn>

qemu call kvm_get_vcpu_events, and kernel return sipi_vector always
0, never valid when reporting to user space. But when qemu calls
kvm_put_vcpu_events will make sipi_vector in kernel be 0. This will
accidently modify sipi_vector when sipi_vector in kernel is not 0.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Reviewed-by: Liu Yi <liu.yi24@zte.com.cn>
Message-Id: <1500047256-8911-1-git-send-email-peng.hao2@zte.com.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index a6613e1..6db7783 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2444,8 +2444,10 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     }
 
     if (level >= KVM_PUT_RESET_STATE) {
-        events.flags |=
-            KVM_VCPUEVENT_VALID_NMI_PENDING | KVM_VCPUEVENT_VALID_SIPI_VECTOR;
+        events.flags |= KVM_VCPUEVENT_VALID_NMI_PENDING;
+        if (env->mp_state == KVM_MP_STATE_SIPI_RECEIVED) {
+            events.flags |= KVM_VCPUEVENT_VALID_SIPI_VECTOR;
+        }
     }
 
     return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
@@ -2633,6 +2635,10 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
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
@@ -2644,11 +2650,6 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
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
@@ -2668,35 +2669,39 @@ int kvm_arch_get_registers(CPUState *cs)
 
     assert(cpu_is_stopped(cs) || qemu_cpu_is_self(cs));
 
-    ret = kvm_getput_regs(cpu, 0);
+    ret = kvm_get_vcpu_events(cpu);
     if (ret < 0) {
         goto out;
     }
-    ret = kvm_get_xsave(cpu);
+    /*
+     * KVM_GET_MPSTATE can modify CS and RIP, call it before
+     * KVM_GET_REGS and KVM_GET_SREGS.
+     */
+    ret = kvm_get_mp_state(cpu);
     if (ret < 0) {
         goto out;
     }
-    ret = kvm_get_xcrs(cpu);
+    ret = kvm_getput_regs(cpu, 0);
     if (ret < 0) {
         goto out;
     }
-    ret = kvm_get_sregs(cpu);
+    ret = kvm_get_xsave(cpu);
     if (ret < 0) {
         goto out;
     }
-    ret = kvm_get_msrs(cpu);
+    ret = kvm_get_xcrs(cpu);
     if (ret < 0) {
         goto out;
     }
-    ret = kvm_get_mp_state(cpu);
+    ret = kvm_get_sregs(cpu);
     if (ret < 0) {
         goto out;
     }
-    ret = kvm_get_apic(cpu);
+    ret = kvm_get_msrs(cpu);
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
