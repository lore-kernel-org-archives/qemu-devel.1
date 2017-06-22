Received: from eggs.gnu.org ([2001:4830:134:3::10]:44586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1dNrWp-0001hs-Hp
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 22:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1dNrWm-0001NH-EC
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 22:07:27 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1dNrWm-0001Mv-8v
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 22:07:24 -0400
Received: by mail-pg0-x244.google.com with SMTP id f127so509752pgc.2
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 19:07:24 -0700 (PDT)
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 21 Jun 2017 19:07:18 -0700
Message-Id: <1498097238-6301-1-git-send-email-wanpeng.li@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] KVM: Add async pf flag to
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

This patch adds async page fault flag to KVM_GET/SET_VCPU_EVENTS interface.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
---
v1 -> v2:
 * reuse the pad for async_page_fault
 * cleanup coding style

 linux-headers/asm-x86/kvm.h | 3 ++-
 target/i386/cpu.h           | 1 +
 target/i386/kvm.c           | 8 ++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index c2824d0..27b368b 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -287,6 +287,7 @@ struct kvm_reinject_control {
 #define KVM_VCPUEVENT_VALID_SIPI_VECTOR	0x00000002
 #define KVM_VCPUEVENT_VALID_SHADOW	0x00000004
 #define KVM_VCPUEVENT_VALID_SMM		0x00000008
+#define KVM_VCPUEVENT_VALID_ASYNC_PF 0x00000010
 
 /* Interrupt shadow states */
 #define KVM_X86_SHADOW_INT_MOV_SS	0x01
@@ -298,7 +299,7 @@ struct kvm_vcpu_events {
 		__u8 injected;
 		__u8 nr;
 		__u8 has_error_code;
-		__u8 pad;
+		__u8 async_page_fault;
 		__u32 error_code;
 	} exception;
 	struct {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cfe825f..90cb692 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1105,6 +1105,7 @@ typedef struct CPUX86State {
 
     /* exception/interrupt handling */
     int error_code;
+    uint8_t async_page_fault;
     int exception_is_int;
     target_ulong exception_next_eip;
     target_ulong dr[8]; /* debug registers; note dr4 and dr5 are unused */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 49b6115..b2405ec 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2491,8 +2491,8 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     events.exception.injected = (env->exception_injected >= 0);
     events.exception.nr = env->exception_injected;
     events.exception.has_error_code = env->has_error_code;
+    events.exception.async_page_fault = env->async_page_fault;
     events.exception.error_code = env->error_code;
-    events.exception.pad = 0;
 
     events.interrupt.injected = (env->interrupt_injected >= 0);
     events.interrupt.nr = env->interrupt_injected;
@@ -2531,7 +2531,8 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
 
     if (level >= KVM_PUT_RESET_STATE) {
         events.flags |=
-            KVM_VCPUEVENT_VALID_NMI_PENDING | KVM_VCPUEVENT_VALID_SIPI_VECTOR;
+            KVM_VCPUEVENT_VALID_NMI_PENDING | KVM_VCPUEVENT_VALID_SIPI_VECTOR |
+                    KVM_VCPUEVENT_VALID_ASYNC_PF;
     }
 
     return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
@@ -2555,6 +2556,9 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
     env->exception_injected =
        events.exception.injected ? events.exception.nr : -1;
     env->has_error_code = events.exception.has_error_code;
+    if (events.flags & KVM_VCPUEVENT_VALID_ASYNC_PF) {
+        env->async_page_fault = events.exception.async_page_fault;
+    }
     env->error_code = events.exception.error_code;
 
     env->interrupt_injected =
-- 
2.7.4
