Received: from eggs.gnu.org ([209.51.188.92]:35752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe41-0000CU-0I
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe40-0001U2-1c
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:12 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe3y-00016w-Rt
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:10 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:48 -0500
Message-Id: <20190130004811.27372-51-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 50/73] mips: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, James Hogan <jhogan@kernel.org>

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: James Hogan <jhogan@kernel.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/mips/cpu.c | 7 ++++---
 target/mips/kvm.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index e217fb3e36..fdae8cf440 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -56,11 +56,12 @@ static bool mips_cpu_has_work(CPUState *cs)
     MIPSCPU *cpu = MIPS_CPU(cs);
     CPUMIPSState *env = &cpu->env;
     bool has_work = false;
+    uint32_t interrupt_request = cpu_interrupt_request(cs);
 
     /* Prior to MIPS Release 6 it is implementation dependent if non-enabled
        interrupts wake-up the CPU, however most of the implementations only
        check for interrupts that can be taken. */
-    if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if ((interrupt_request & CPU_INTERRUPT_HARD) &&
         cpu_mips_hw_interrupts_pending(env)) {
         if (cpu_mips_hw_interrupts_enabled(env) ||
             (env->insn_flags & ISA_MIPS32R6)) {
@@ -72,7 +73,7 @@ static bool mips_cpu_has_work(CPUState *cs)
     if (env->CP0_Config3 & (1 << CP0C3_MT)) {
         /* The QEMU model will issue an _WAKE request whenever the CPUs
            should be woken up.  */
-        if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
+        if (interrupt_request & CPU_INTERRUPT_WAKE) {
             has_work = true;
         }
 
@@ -82,7 +83,7 @@ static bool mips_cpu_has_work(CPUState *cs)
     }
     /* MIPS Release 6 has the ability to halt the CPU.  */
     if (env->CP0_Config5 & (1 << CP0C5_VP)) {
-        if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
+        if (interrupt_request & CPU_INTERRUPT_WAKE) {
             has_work = true;
         }
         if (!mips_vp_active(env)) {
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 0b177a7577..568c3d8f4a 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -135,7 +135,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 
     qemu_mutex_lock_iothread();
 
-    if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if ((cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
             cpu_mips_io_interrupts_pending(cpu)) {
         intr.cpu = -1;
         intr.irq = 2;
-- 
2.17.1
