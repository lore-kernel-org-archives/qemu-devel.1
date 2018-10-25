Received: from eggs.gnu.org ([2001:4830:134:3::10]:60299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5N-0004D4-Ah
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgvE-0008Bf-EG
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:42 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52279)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFgvE-00082d-3T
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:40 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:46:12 -0400
Message-Id: <20181025144644.15464-39-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 39/71] i386/hax-all: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/hax-all.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 8b53a9708f..70cea8b1a1 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -293,7 +293,7 @@ int hax_vm_destroy(struct hax_vm *vm)
 
 static void hax_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
 
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
@@ -427,7 +427,7 @@ static int hax_vcpu_interrupt(CPUArchState *env)
      * Unlike KVM, HAX kernel check for the eflags, instead of qemu
      */
     if (ht->ready_for_interrupt_injection &&
-        (cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+        (cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD)) {
         int irq;
 
         irq = cpu_get_pic_interrupt(env);
@@ -441,7 +441,7 @@ static int hax_vcpu_interrupt(CPUArchState *env)
      * interrupt, request an interrupt window exit.  This will
      * cause a return to userspace as soon as the guest is ready to
      * receive interrupts. */
-    if ((cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+    if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD)) {
         ht->request_interrupt_window = 1;
     } else {
         ht->request_interrupt_window = 0;
@@ -482,19 +482,19 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
 
     cpu_halted_set(cpu, 0);
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_POLL) {
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         apic_poll_irq(x86_cpu->apic_state);
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_INIT) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_INIT) {
         DPRINTF("\nhax_vcpu_hax_exec: handling INIT for %d\n",
                 cpu->cpu_index);
         do_cpu_init(x86_cpu);
         hax_vcpu_sync_state(env, 1);
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_SIPI) {
         DPRINTF("hax_vcpu_hax_exec: handling SIPI for %d\n",
                 cpu->cpu_index);
         hax_vcpu_sync_state(env, 0);
@@ -553,13 +553,17 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
             ret = -1;
             break;
         case HAX_EXIT_HLT:
-            if (!(cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
-                !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
-                /* hlt instruction with interrupt disabled is shutdown */
-                env->eflags |= IF_MASK;
-                cpu_halted_set(cpu, 1);
-                cpu->exception_index = EXCP_HLT;
-                ret = 1;
+            {
+                uint32_t interrupt_request = cpu_interrupt_request(cpu);
+
+                if (!(interrupt_request & CPU_INTERRUPT_HARD) &&
+                    !(interrupt_request & CPU_INTERRUPT_NMI)) {
+                    /* hlt instruction with interrupt disabled is shutdown */
+                    env->eflags |= IF_MASK;
+                    cpu_halted_set(cpu, 1);
+                    cpu->exception_index = EXCP_HLT;
+                    ret = 1;
+                }
             }
             break;
         /* these situations will continue to hax module */
-- 
2.17.1
