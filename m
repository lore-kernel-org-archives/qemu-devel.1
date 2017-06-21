Received: from eggs.gnu.org ([2001:4830:134:3::10]:55803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckO-0002Ux-SU
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckN-00057p-UP
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:6553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dNckN-0004zB-KJ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:27 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 21 Jun 2017 18:19:52 +0800
Message-Id: <1498040401-16361-7-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH 06/15] kvmvapic: remove tcg related code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, a.rigo@virtualopensystems.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

Since Paolo's below patch has fixed A20 issue
commit bbfa326fc8028e275eddf8c9965c2a1b59405b2e
target/i386: enable A20 automatically in system management mod

The tcg code in kvmvapic.c is NOT useful, those code need remove.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 hw/i386/kvmvapic.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 82a4955..5b7be5a 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -18,7 +18,6 @@
 #include "sysemu/kvm.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/sysbus.h"
-#include "tcg/tcg.h"
 
 #define VAPIC_IO_PORT           0x7e
 
@@ -396,13 +395,9 @@ static void patch_call(VAPICROMState *s, X86CPU *cpu, target_ulong ip,
 static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
 {
     CPUState *cs = CPU(cpu);
-    CPUX86State *env = &cpu->env;
     VAPICHandlers *handlers;
     uint8_t opcode[2];
     uint32_t imm32 = 0;
-    target_ulong current_pc = 0;
-    target_ulong current_cs_base = 0;
-    uint32_t current_flags = 0;
 
     if (smp_cpus == 1) {
         handlers = &s->rom_state.up;
@@ -410,17 +405,6 @@ static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
         handlers = &s->rom_state.mp;
     }
 
-    if (!kvm_enabled()) {
-        cpu_get_tb_cpu_state(env, &current_pc, &current_cs_base,
-                             &current_flags);
-        /* Account this instruction, because we will exit the tb.
-           This is the first instruction in the block. Therefore
-           there is no need in restoring CPU state. */
-        if (use_icount) {
-            --cs->icount_decr.u16.low;
-        }
-    }
-
     pause_all_vcpus();
 
     cpu_memory_rw_debug(cs, ip, opcode, sizeof(opcode), 0);
@@ -455,14 +439,6 @@ static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
     }
 
     resume_all_vcpus();
-
-    if (!kvm_enabled()) {
-        /* Both tb_lock and iothread_mutex will be reset when
-         *  longjmps back into the cpu_exec loop. */
-        tb_lock();
-        tb_gen_code(cs, current_pc, current_cs_base, current_flags, 1);
-        cpu_loop_exit_noexc(cs);
-    }
 }
 
 void vapic_report_tpr_access(DeviceState *dev, CPUState *cs, target_ulong ip,
-- 
1.9.1
