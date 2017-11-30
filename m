Received: from eggs.gnu.org ([2001:4830:134:3::10]:33921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKRhE-0005BC-7h
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKRhC-00039z-F2
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:28:20 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 30 Nov 2017 17:27:34 +0100
Message-Id: <20171130162744.25442-7-david@redhat.com>
In-Reply-To: <20171130162744.25442-1-david@redhat.com>
References: <20171130162744.25442-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.12 06/16] s390x/diag: pass the retaddr
 into handle_diag_308()
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

Needed to later drop potential_page_fault() from the diag TCG translate
function.

Convert program_interrupt() to s390_program_interrupt() directly, making
use of the passed address.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/diag.c        | 14 +++++++-------
 target/s390x/internal.h    |  3 ++-
 target/s390x/kvm.c         |  2 +-
 target/s390x/misc_helper.c |  2 +-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index dbbb9e886f..a755837ad5 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -99,19 +99,19 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 #define DIAG_308_RC_NO_CONF         0x0102
 #define DIAG_308_RC_INVALID         0x0402
 
-void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3)
+void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     uint64_t addr =  env->regs[r1];
     uint64_t subcode = env->regs[r3];
     IplParameterBlock *iplb;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        program_interrupt(env, PGM_PRIVILEGED, ILEN_AUTO);
+        s390_program_interrupt(env, PGM_PRIVILEGED, ILEN_AUTO, ra);
         return;
     }
 
     if ((subcode & ~0x0ffffULL) || (subcode > 6)) {
-        program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
         return;
     }
 
@@ -136,12 +136,12 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3)
         break;
     case 5:
         if ((r1 & 1) || (addr & 0x0fffULL)) {
-            program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
+            s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
             return;
         }
         if (!address_space_access_valid(&address_space_memory, addr,
                                         sizeof(IplParameterBlock), false)) {
-            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
+            s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
             return;
         }
         iplb = g_new0(IplParameterBlock, 1);
@@ -165,12 +165,12 @@ out:
         return;
     case 6:
         if ((r1 & 1) || (addr & 0x0fffULL)) {
-            program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO);
+            s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
             return;
         }
         if (!address_space_access_valid(&address_space_memory, addr,
                                         sizeof(IplParameterBlock), true)) {
-            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
+            s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
             return;
         }
         iplb = s390_ipl_get_iplb();
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 9db5f2d49d..6817b2c432 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -411,7 +411,8 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
 
 /* misc_helper.c */
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
-void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3);
+void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
+                     uintptr_t ra);
 
 
 /* translate.c */
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index fb20435e50..05db242563 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1451,7 +1451,7 @@ static void kvm_handle_diag_308(S390CPU *cpu, struct kvm_run *run)
     cpu_synchronize_state(CPU(cpu));
     r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
     r3 = run->s390_sieic.ipa & 0x000f;
-    handle_diag_308(&cpu->env, r1, r3);
+    handle_diag_308(&cpu->env, r1, r3, RA_IGNORED);
 }
 
 static int handle_sw_breakpoint(S390CPU *cpu, struct kvm_run *run)
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 9b53abbfa7..556340756c 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -88,7 +88,7 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     case 0x308:
         /* ipl */
         qemu_mutex_lock_iothread();
-        handle_diag_308(env, r1, r3);
+        handle_diag_308(env, r1, r3, GETPC());
         qemu_mutex_unlock_iothread();
         r = 0;
         break;
-- 
2.14.3
