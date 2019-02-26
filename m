Received: from eggs.gnu.org ([209.51.188.92]:57527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUka-0004lA-5S
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkQ-0001Lz-Ob
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:53:46 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:19 +1100
Message-Id: <20190226045304.25618-6-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/50] target/ppc: Rename "in_pm_state" to
 "resume_as_sreset"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

To better reflect what this does, as it's specific to some of the
P7/P8/P9 PM states, not generic.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190215161648.9600-6-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc.c             | 2 +-
 target/ppc/cpu.h         | 6 +++---
 target/ppc/excp_helper.c | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index cffdc3914a..12439dbe5d 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -776,7 +776,7 @@ static inline void cpu_ppc_hdecr_excp(PowerPCCPU *cpu=
)
      * interrupts in a PM state. Not only they don't cause a
      * wakeup but they also get effectively discarded.
      */
-    if (!env->in_pm_state) {
+    if (!env->resume_as_sreset) {
         ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 1);
     }
 }
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 5b1899bfc9..d2364564a0 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1117,10 +1117,10 @@ struct CPUPPCState {
=20
     /*
      * On P7/P8/P9, set when in PM state, we need to handle resume in
-     * a special way (such as routing some resume causes to 0x100), so
-     * flag this here.
+     * a special way (such as routing some resume causes to 0x100, ie,
+     * sreset), so flag this here.
      */
-    bool in_pm_state;
+    bool resume_as_sreset;
 #endif
=20
     /* Those resources are used only during code translation */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 489a54f51b..7536620a41 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -69,7 +69,7 @@ static int powerpc_reset_wakeup(CPUState *cs, CPUPPCSta=
te *env, int excp,
                                 target_ulong *msr)
 {
     /* We no longer are in a PM state */
-    env->in_pm_state =3D false;
+    env->resume_as_sreset =3D false;
=20
     /* Pretend to be returning from doze always as we don't lose state *=
/
     *msr |=3D (0x1ull << (63 - 47));
@@ -141,7 +141,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
      * check for special resume at 0x100 from doze/nap/sleep/winkle on
      * P7/P8/P9
      */
-    if (env->in_pm_state) {
+    if (env->resume_as_sreset) {
         excp =3D powerpc_reset_wakeup(cs, env, excp, &msr);
     }
=20
@@ -787,7 +787,7 @@ static void ppc_hw_interrupt(CPUPPCState *env)
      * clear when coming out of some power management states (in order
      * for them to become a 0x100).
      */
-    async_deliver =3D (msr_ee !=3D 0) || env->in_pm_state;
+    async_deliver =3D (msr_ee !=3D 0) || env->resume_as_sreset;
=20
     /* Hypervisor decrementer exception */
     if (env->pending_interrupts & (1 << PPC_INTERRUPT_HDECR)) {
@@ -970,7 +970,7 @@ void helper_pminsn(CPUPPCState *env, powerpc_pm_insn_=
t insn)
     env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_HDECR);
=20
     /* Condition for waking up at 0x100 */
-    env->in_pm_state =3D (insn !=3D PPC_PM_STOP) ||
+    env->resume_as_sreset =3D (insn !=3D PPC_PM_STOP) ||
         (env->spr[SPR_PSSCR] & PSSCR_EC);
 }
 #endif /* defined(TARGET_PPC64) */
--=20
2.20.1
