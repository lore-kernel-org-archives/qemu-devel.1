Received: from eggs.gnu.org ([209.51.188.92]:38549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3Vc-0005NK-1l
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3VS-00037z-9w
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3VO-00031C-Gm
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:02 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9i12J021533
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:59 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q9y2drv3r-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:59 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:46:56 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:19 +0100
In-Reply-To: <20190128094625.4428-1-clg@kaod.org>
References: <20190128094625.4428-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-14-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/19] target/ppc: Rename "in_pm_state" to
 "resume_as_sreset"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

To better reflect what this does, as it's specific to some of the
P7/P8/P9 PM states, not generic.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h         | 6 +++---
 hw/ppc/ppc.c             | 2 +-
 target/ppc/excp_helper.c | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7ff65c804b57..b69410ea2541 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1116,10 +1116,10 @@ struct CPUPPCState {
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
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 9292f986eba7..608405f6f2ca 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -722,7 +722,7 @@ static inline void cpu_ppc_hdecr_excp(PowerPCCPU *cpu=
)
      * interrupts in a PM state. Not only they don't cause a
      * wakeup but they also get effectively discarded.
      */
-    if (!env->in_pm_state) {
+    if (!env->resume_as_sreset) {
         ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 1);
     }
 }
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 489a54f51b90..7536620a4133 100644
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
