Received: from eggs.gnu.org ([2001:4830:134:3::10]:39118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3RiI-0006G5-39
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 14:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1d3RiE-0003Ad-PB
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 14:30:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47632
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1d3RiE-0003AD-IV
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 14:30:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QITA4N173910
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 14:30:49 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a2ebv2cun-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 14:30:48 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 27 Apr 2017 04:30:46 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed, 26 Apr 2017 23:59:49 +0530
Message-Id: <20170426182949.13433-1-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] target/ppc: do not reset reserve_addr in
 exec_enter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: alex.bennee@linaro.org, nikunj@linux.vnet.ibm.com, benh@kernel.crashing.org

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
---

Depends on following fix by Richard Henderson:
https://patchwork.ozlabs.org/patch/755582/

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
index 77e5463..dc4239d 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10426,14 +10426,6 @@ static bool ppc_cpu_has_work(CPUState *cs)
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
@@ -10650,7 +10642,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_phys_page_debug = ppc_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_ppc_cpu;
 #endif
-    cc->cpu_exec_enter = ppc_cpu_exec_enter;
 #if defined(CONFIG_SOFTMMU)
     cc->write_elf64_note = ppc64_cpu_write_elf64_note;
     cc->write_elf32_note = ppc32_cpu_write_elf32_note;
-- 
2.9.3
