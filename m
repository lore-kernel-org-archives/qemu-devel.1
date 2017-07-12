Received: from eggs.gnu.org ([2001:4830:134:3::10]:39568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dVPYf-0007zr-65
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dVPYa-0007VY-Fu
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:52:33 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:35952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dVPYa-0007FC-AJ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:52:28 -0400
Received: by mail-yw0-x241.google.com with SMTP id l21so2086558ywb.3
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 14:52:05 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 12 Jul 2017 17:51:43 -0400
Message-Id: <20170712215143.19594-2-bobby.prani@gmail.com>
In-Reply-To: <20170712215143.19594-1-bobby.prani@gmail.com>
References: <20170712215143.19594-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 2/2] mttcg/i386: Patch instruction using
 async_safe_* framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>

In mttcg, calling pause_all_vcpus() during execution from the
generated TBs causes a deadlock if some vCPU is waiting for exclusive
execution in start_exclusive(). Fix this by using the aync_safe_*
framework instead of pausing vcpus for patching instructions.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 hw/i386/kvmvapic.c | 101 +++++++++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 46 deletions(-)

diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 0d9ef77580..4e8f1f4e55 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -383,8 +383,7 @@ static void patch_byte(X86CPU *cpu, target_ulong addr, uint8_t byte)
     cpu_memory_rw_debug(CPU(cpu), addr, &byte, 1, 1);
 }
 
-static void patch_call(VAPICROMState *s, X86CPU *cpu, target_ulong ip,
-                       uint32_t target)
+static void patch_call(X86CPU *cpu, target_ulong ip, uint32_t target)
 {
     uint32_t offset;
 
@@ -393,77 +392,87 @@ static void patch_call(VAPICROMState *s, X86CPU *cpu, target_ulong ip,
     cpu_memory_rw_debug(CPU(cpu), ip + 1, (void *)&offset, sizeof(offset), 1);
 }
 
-static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
+struct PatchInfo {
+    VAPICHandlers *handler;
+    target_ulong ip;
+};
+
+static void do_patch_instruction(CPUState *cs, run_on_cpu_data data)
 {
-    CPUState *cs = CPU(cpu);
-    CPUX86State *env = &cpu->env;
-    VAPICHandlers *handlers;
+    X86CPU *x86_cpu = X86_CPU(cs);
+    struct PatchInfo *info = (struct PatchInfo *) data.host_ptr;
+    VAPICHandlers *handlers = info->handler;
+    target_ulong ip = info->ip;
     uint8_t opcode[2];
     uint32_t imm32 = 0;
-    target_ulong current_pc = 0;
-    target_ulong current_cs_base = 0;
-    uint32_t current_flags = 0;
-
-    if (smp_cpus == 1) {
-        handlers = &s->rom_state.up;
-    } else {
-        handlers = &s->rom_state.mp;
-    }
-
-    if (tcg_enabled()) {
-        cpu_restore_state(cs, cs->mem_io_pc);
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
-    pause_all_vcpus();
 
     cpu_memory_rw_debug(cs, ip, opcode, sizeof(opcode), 0);
 
     switch (opcode[0]) {
     case 0x89: /* mov r32 to r/m32 */
-        patch_byte(cpu, ip, 0x50 + modrm_reg(opcode[1]));  /* push reg */
-        patch_call(s, cpu, ip + 1, handlers->set_tpr);
+        patch_byte(x86_cpu, ip, 0x50 + modrm_reg(opcode[1]));  /* push reg */
+        patch_call(x86_cpu, ip + 1, handlers->set_tpr);
         break;
     case 0x8b: /* mov r/m32 to r32 */
-        patch_byte(cpu, ip, 0x90);
-        patch_call(s, cpu, ip + 1, handlers->get_tpr[modrm_reg(opcode[1])]);
+        patch_byte(x86_cpu, ip, 0x90);
+        patch_call(x86_cpu, ip + 1, handlers->get_tpr[modrm_reg(opcode[1])]);
         break;
     case 0xa1: /* mov abs to eax */
-        patch_call(s, cpu, ip, handlers->get_tpr[0]);
+        patch_call(x86_cpu, ip, handlers->get_tpr[0]);
         break;
     case 0xa3: /* mov eax to abs */
-        patch_call(s, cpu, ip, handlers->set_tpr_eax);
+        patch_call(x86_cpu, ip, handlers->set_tpr_eax);
         break;
     case 0xc7: /* mov imm32, r/m32 (c7/0) */
-        patch_byte(cpu, ip, 0x68);  /* push imm32 */
+        patch_byte(x86_cpu, ip, 0x68);  /* push imm32 */
         cpu_memory_rw_debug(cs, ip + 6, (void *)&imm32, sizeof(imm32), 0);
         cpu_memory_rw_debug(cs, ip + 1, (void *)&imm32, sizeof(imm32), 1);
-        patch_call(s, cpu, ip + 5, handlers->set_tpr);
+        patch_call(x86_cpu, ip + 5, handlers->set_tpr);
         break;
     case 0xff: /* push r/m32 */
-        patch_byte(cpu, ip, 0x50); /* push eax */
-        patch_call(s, cpu, ip + 1, handlers->get_tpr_stack);
+        patch_byte(x86_cpu, ip, 0x50); /* push eax */
+        patch_call(x86_cpu, ip + 1, handlers->get_tpr_stack);
         break;
     default:
         abort();
     }
 
-    resume_all_vcpus();
+    g_free(info);
+}
+
+static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
+{
+    CPUState *cs = CPU(cpu);
+    CPUX86State *env = &cpu->env;
+    VAPICHandlers *handlers;
+    struct PatchInfo *info;
+    const run_on_cpu_func fn = do_patch_instruction;
+    target_ulong current_pc = 0;
+    target_ulong current_cs_base = 0;
+    uint32_t current_flags = 0;
+
+    if (smp_cpus == 1) {
+        handlers = &s->rom_state.up;
+    } else {
+        handlers = &s->rom_state.mp;
+    }
+
+    info  = g_new(struct PatchInfo, 1);
+    info->handler = handlers;
+    info->ip = ip;
 
-    if (tcg_enabled()) {
-        /* Both tb_lock and iothread_mutex will be reset when
-         *  longjmps back into the cpu_exec loop. */
-        tb_lock();
-        tb_gen_code(cs, current_pc, current_cs_base, current_flags, 1);
-        cpu_loop_exit_noexc(cs);
+    if (!kvm_enabled()) {
+        cpu_get_tb_cpu_state(env, &current_pc, &current_cs_base,
+                             &current_flags);
+        /* Account this instruction, because we will exit the tb.
+           This is the first instruction in the block. Therefore
+           there is no need in restoring CPU state. */
+        if (use_icount) {
+            --cs->icount_decr.u16.low;
+        }
     }
+
+    async_safe_run_on_cpu(cs, fn, RUN_ON_CPU_HOST_PTR(info));
 }
 
 void vapic_report_tpr_access(DeviceState *dev, CPUState *cs, target_ulong ip,
-- 
2.13.0
