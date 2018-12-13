Received: from eggs.gnu.org ([2001:4830:134:3::10]:55890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCr-0007rb-Un
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCo-0001u5-IC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:41 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34993)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJCn-0001Zu-TB
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:38 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:04:21 -0500
Message-Id: <20181213050453.9677-42-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 41/73] i386/hax-all: convert to
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
