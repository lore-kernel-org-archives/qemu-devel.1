Received: from eggs.gnu.org ([2001:4830:134:3::10]:34240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKRhk-0005e7-Ok
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKRhj-0003Td-UK
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:28:52 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 30 Nov 2017 17:27:43 +0100
Message-Id: <20171130162744.25442-16-david@redhat.com>
In-Reply-To: <20171130162744.25442-1-david@redhat.com>
References: <20171130162744.25442-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.12 15/16] s390x/tcg: drop
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

All users are gone, we can finally drop it and make sure that all new
program interrupt injections are reminded of the retaddr - as they have to
use s390_program_interrupt() now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h       |  1 -
 target/s390x/interrupt.c | 22 +++++-----------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index ae61d18c0a..9cfbbbac04 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -719,7 +719,6 @@ void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
                        uint32_t io_int_parm, uint32_t io_int_word);
 /* automatically detect the instruction length */
 #define ILEN_AUTO                   0xff
-void program_interrupt(CPUS390XState *env, uint32_t code, int ilen);
 #define RA_IGNORED                  0
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
                             uintptr_t ra);
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index b07e75daed..39c026b8b5 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -27,17 +27,18 @@ void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
 }
 
 static void tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
-                                       int ilen)
+                                       int ilen, uintptr_t ra)
 {
 #ifdef CONFIG_TCG
     trigger_pgm_exception(env, code, ilen);
-    cpu_loop_exit(CPU(s390_env_get_cpu(env)));
+    cpu_loop_exit_restore(CPU(s390_env_get_cpu(env)), ra);
 #else
     g_assert_not_reached();
 #endif
 }
 
-void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
+void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
+                            uintptr_t ra)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
 
@@ -47,25 +48,12 @@ void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
     if (kvm_enabled()) {
         kvm_s390_program_interrupt(cpu, code);
     } else if (tcg_enabled()) {
-        tcg_s390_program_interrupt(env, code, ilen);
+        tcg_s390_program_interrupt(env, code, ilen, ra);
     } else {
         g_assert_not_reached();
     }
 }
 
-void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
-                            uintptr_t ra)
-{
-#ifdef CONFIG_TCG
-    S390CPU *cpu = s390_env_get_cpu(env);
-
-    if (tcg_enabled()) {
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
