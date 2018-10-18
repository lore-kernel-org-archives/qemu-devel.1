Received: from eggs.gnu.org ([2001:4830:134:3::10]:48121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyJ-0007Jj-M5
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyI-0006M7-O9
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:53353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyG-0006FW-QF
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id y11-v6so1571355wma.3
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:42 +0200
Message-Id: <1539894735-14232-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/48] i386: hvf: Remove hvf_disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <r.bolshakov@yadro.com>

From: Roman Bolshakov <r.bolshakov@yadro.com>

accel_init_machine sets *(acc->allowed) to true if acc->init_machine(ms)
succeeds. There's no need to have both hvf_allowed and hvf_disabled.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20181018143051.48508-1-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/hvf.h  | 4 ++--
 target/i386/hvf/hvf.c | 9 +--------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 2411188..aaa51d2 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -17,7 +17,7 @@
 #include "exec/memory.h"
 #include "sysemu/accel.h"
 
-extern int hvf_disabled;
+extern bool hvf_allowed;
 #ifdef CONFIG_HVF
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
@@ -26,7 +26,7 @@ extern int hvf_disabled;
 #include "hw/hw.h"
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
                                  int reg);
-#define hvf_enabled() !hvf_disabled
+#define hvf_enabled() (hvf_allowed)
 #else
 #define hvf_enabled() 0
 #define hvf_get_supported_cpuid(func, idx, reg) 0
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 9f52bc4..e193022 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -73,7 +73,6 @@
 #include "target/i386/cpu.h"
 
 HVFState *hvf_state;
-int hvf_disabled = 1;
 
 static void assert_hvf_ok(hv_return_t ret)
 {
@@ -604,11 +603,6 @@ int hvf_init_vcpu(CPUState *cpu)
     return 0;
 }
 
-void hvf_disable(int shouldDisable)
-{
-    hvf_disabled = shouldDisable;
-}
-
 static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_info)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -934,7 +928,7 @@ int hvf_vcpu_exec(CPUState *cpu)
     return ret;
 }
 
-static bool hvf_allowed;
+bool hvf_allowed;
 
 static int hvf_accel_init(MachineState *ms)
 {
@@ -942,7 +936,6 @@ static int hvf_accel_init(MachineState *ms)
     hv_return_t ret;
     HVFState *s;
 
-    hvf_disable(0);
     ret = hv_vm_create(HV_VM_DEFAULT);
     assert_hvf_ok(ret);
 
-- 
1.8.3.1
