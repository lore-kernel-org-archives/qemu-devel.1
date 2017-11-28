Received: from eggs.gnu.org ([2001:4830:134:3::10]:46772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eJma0-0001EL-N6
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eJmZz-0003wB-R8
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:34:08 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 28 Nov 2017 21:33:24 +0100
Message-Id: <20171128203326.6062-15-david@redhat.com>
In-Reply-To: <20171128203326.6062-1-david@redhat.com>
References: <20171128203326.6062-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.12 14/15] s390x/tcg: drop
 program_interrupt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

All users are gone, we can finally drop it and make sure that all new
new program interrupt injections are reminded of the retaddr - as they
have to use program_interrupt_ra() now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h       |  1 -
 target/s390x/interrupt.c | 22 ++++++++--------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 617f9b0148..890a25c1d6 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -719,7 +719,6 @@ void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
                        uint32_t io_int_parm, uint32_t io_int_word);
 /* automatically detect the instruction length */
 #define ILEN_AUTO                   0xff
-void program_interrupt(CPUS390XState *env, uint32_t code, int ilen);
 void program_interrupt_ra(CPUS390XState *env, uint32_t code, int ilen,
                           uintptr_t ra);
 /* service interrupts are floating therefore we must not pass an cpustate */
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 6ce06bb549..c0996187ef 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -37,13 +37,20 @@ static void tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
 #endif
 }
 
-void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
+void program_interrupt_ra(CPUS390XState *env, uint32_t code, int ilen,
+                          uintptr_t ra)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
 
     qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
                   env->psw.addr);
 
+#ifdef CONFIG_TCG
+    if (tcg_enabled() && ra) {
+        cpu_restore_state(CPU(cpu), ra);
+    }
+#endif
+
     if (kvm_enabled()) {
         kvm_s390_program_interrupt(cpu, code);
     } else if (tcg_enabled()) {
@@ -53,19 +60,6 @@ void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
     }
 }
 
-void program_interrupt_ra(CPUS390XState *env, uint32_t code, int ilen,
-                          uintptr_t ra)
-{
-    S390CPU *cpu = s390_env_get_cpu(env);
-
-#ifdef CONFIG_TCG
-    if (tcg_enabled() && ra) {
-        cpu_restore_state(CPU(cpu), ra);
-    }
-#endif
-    program_interrupt(env, code, ilen);
-}
-
 #if !defined(CONFIG_USER_ONLY)
 static void cpu_inject_service(S390CPU *cpu, uint32_t param)
 {
-- 
2.14.3
