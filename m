Received: from eggs.gnu.org ([2001:4830:134:3::10]:39171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1dNW6e-0005UL-Ni
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 23:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1dNW6a-0004pl-NS
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 23:15:00 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1dNW6a-0004pM-Hj
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 23:14:56 -0400
Received: by mail-pg0-x244.google.com with SMTP id e187so16301501pgc.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 20:14:55 -0700 (PDT)
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 20 Jun 2017 20:14:49 -0700
Message-Id: <1498014889-52658-1-git-send-email-wanpeng.li@hotmail.com>
Subject: [Qemu-devel] [PATCH] KVM: Add async pf flag to
 KVM_GET/SET_VCPU_EVENTS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Wanpeng Li <wanpeng.li@hotmail.com>

From: Wanpeng Li <wanpeng.li@hotmail.com>

This patch adds async pf flag to KVM_GET/SET_VCPU_EVENTS interface.

Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
---
 linux-headers/asm-x86/kvm.h | 2 ++
 target/i386/cpu.h           | 1 +
 target/i386/kvm.c           | 6 +++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index c2824d0..435f03f 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -287,6 +287,7 @@ struct kvm_reinject_control {
 #define KVM_VCPUEVENT_VALID_SIPI_VECTOR	0x00000002
 #define KVM_VCPUEVENT_VALID_SHADOW	0x00000004
 #define KVM_VCPUEVENT_VALID_SMM		0x00000008
+#define KVM_VCPUEVENT_VALID_ASYNC_PF 0x00000010
 
 /* Interrupt shadow states */
 #define KVM_X86_SHADOW_INT_MOV_SS	0x01
@@ -300,6 +301,7 @@ struct kvm_vcpu_events {
 		__u8 has_error_code;
 		__u8 pad;
 		__u32 error_code;
+		bool async_page_fault;
 	} exception;
 	struct {
 		__u8 injected;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cfe825f..f409958 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1105,6 +1105,7 @@ typedef struct CPUX86State {
 
     /* exception/interrupt handling */
     int error_code;
+    bool async_page_fault;
     int exception_is_int;
     target_ulong exception_next_eip;
     target_ulong dr[8]; /* debug registers; note dr4 and dr5 are unused */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 49b6115..793d1e1 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2493,6 +2493,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     events.exception.has_error_code = env->has_error_code;
     events.exception.error_code = env->error_code;
     events.exception.pad = 0;
+    events.exception.async_page_fault = env->async_page_fault;
 
     events.interrupt.injected = (env->interrupt_injected >= 0);
     events.interrupt.nr = env->interrupt_injected;
@@ -2531,7 +2532,8 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
 
     if (level >= KVM_PUT_RESET_STATE) {
         events.flags |=
-            KVM_VCPUEVENT_VALID_NMI_PENDING | KVM_VCPUEVENT_VALID_SIPI_VECTOR;
+            KVM_VCPUEVENT_VALID_NMI_PENDING | KVM_VCPUEVENT_VALID_SIPI_VECTOR |
+		             KVM_VCPUEVENT_VALID_ASYNC_PF;
     }
 
     return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
@@ -2556,6 +2558,8 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
        events.exception.injected ? events.exception.nr : -1;
     env->has_error_code = events.exception.has_error_code;
     env->error_code = events.exception.error_code;
+    if (events.flags & KVM_VCPUEVENT_VALID_ASYNC_PF)
+        env->async_page_fault = events.exception.async_page_fault;
 
     env->interrupt_injected =
         events.interrupt.injected ? events.interrupt.nr : -1;
-- 
2.7.4
