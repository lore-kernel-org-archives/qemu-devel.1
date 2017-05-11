Received: from eggs.gnu.org ([2001:4830:134:3::10]:56035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUu-0005I1-Su
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUt-0001R3-PW
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 May 2017 14:14:10 +1000
Message-Id: <20170511041426.6488-8-david@gibson.dropbear.id.au>
In-Reply-To: <20170511041426.6488-1-david@gibson.dropbear.id.au>
References: <20170511041426.6488-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/23] target/ppc: do not reset reserve_addr in
 exec_enter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

In case when atomic operation is not supported, exit_atomic is called
and we stop the world and execute the atomic operation. This results
in a following call chain:

tcg_gen_atomic_cmpxchg_tl()
  -> gen_helper_exit_atomic()
     -> HELPER(exit_atomic)
        -> cpu_loop_exit_atomic() -> EXCP_ATOMIC
           -> qemu_tcg_cpu_thread_fn() => case EXCP_ATOMIC
              -> cpu_exec_step_atomic()
                 -> cpu_step_atomic()
                    -> cc->cpu_exec_enter() = ppc_cpu_exec_enter()
                       Sets env->reserve_addr = -1;

But by the time it return back, the reservation is erased and the code
fails, this continues forever and the lock is never taken.

Instead set this in powerpc_excp()

Now that ppc_cpu_exec_enter() doesn't have anything meaningful to do,
let us get rid of the function.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/excp_helper.c    | 3 +++
 target/ppc/translate_init.c | 9 ---------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index f4ee7aa..a6bcb47 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -728,6 +728,9 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     cs->exception_index = POWERPC_EXCP_NONE;
     env->error_code = 0;
 
+    /* Reset the reservation */
+    env->reserve_addr = -1;
+
     /* Any interrupt is context synchronizing, check if TCG TLB
      * needs a delayed flush on ppc64
      */
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index e82e3e6..9b048cd 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10436,14 +10436,6 @@ static bool ppc_cpu_has_work(CPUState *cs)
     return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
 }
 
-static void ppc_cpu_exec_enter(CPUState *cs)
-{
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
-
-    env->reserve_addr = -1;
-}
-
 /* CPUClass::reset() */
 static void ppc_cpu_reset(CPUState *s)
 {
@@ -10660,7 +10652,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_phys_page_debug = ppc_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_ppc_cpu;
 #endif
-    cc->cpu_exec_enter = ppc_cpu_exec_enter;
 #if defined(CONFIG_SOFTMMU)
     cc->write_elf64_note = ppc64_cpu_write_elf64_note;
     cc->write_elf32_note = ppc32_cpu_write_elf32_note;
-- 
2.9.3
