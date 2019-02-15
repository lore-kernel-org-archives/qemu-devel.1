Received: from eggs.gnu.org ([209.51.188.92]:52081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugAi-00035A-6e
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gugAf-0005gU-NP
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:17:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37454
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gugAf-0005fs-GA
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:17:01 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FGBcCn108967
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 11:17:01 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qp0ga1pfy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 11:16:59 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 15 Feb 2019 16:16:54 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 15 Feb 2019 17:16:40 +0100
In-Reply-To: <20190215161648.9600-1-clg@kaod.org>
References: <20190215161648.9600-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190215161648.9600-3-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/10] target/ppc: Don't clobber MSR:EE on PM
 instructions
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

When issuing a power management instruction, we set MSR:EE
to force ppc_hw_interrupt() into calling powerpc_excp()
to deal with the fact that on P7 and P8, the system reset
caused by the wakeup needs to be generated regardless of
the MSR:EE value (using LPCR only).

This however means that the OS will see a bogus SRR1:EE
value which is a problem. It also prevents properly
implementing P9 STOP "light".

So fix this by instead putting some logic in ppc_hw_interrupt()
to decide whether to deliver or not by taking into account the
fact that we are waking up from sleep.

The LPCR isn't checked as this is done in the has_work() test.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/excp_helper.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 8407e0ade938..7c7c8d1b9dc6 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -748,6 +748,7 @@ void ppc_cpu_do_interrupt(CPUState *cs)
 static void ppc_hw_interrupt(CPUPPCState *env)
 {
     PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
+    bool async_deliver;
=20
     /* External reset */
     if (env->pending_interrupts & (1 << PPC_INTERRUPT_RESET)) {
@@ -769,11 +770,20 @@ static void ppc_hw_interrupt(CPUPPCState *env)
         return;
     }
 #endif
+
+    /*
+     * For interrupts that gate on MSR:EE, we need to do something a
+     * bit more subtle, as we need to let them through even when EE is
+     * clear when coming out of some power management states (in order
+     * for them to become a 0x100).
+     */
+    async_deliver =3D (msr_ee !=3D 0) || env->in_pm_state;
+
     /* Hypervisor decrementer exception */
     if (env->pending_interrupts & (1 << PPC_INTERRUPT_HDECR)) {
         /* LPCR will be clear when not supported so this will work */
         bool hdice =3D !!(env->spr[SPR_LPCR] & LPCR_HDICE);
-        if ((msr_ee !=3D 0 || msr_hv =3D=3D 0) && hdice) {
+        if ((async_deliver || msr_hv =3D=3D 0) && hdice) {
             /* HDEC clears on delivery */
             env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_HDECR);
             powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_HDECR);
@@ -783,7 +793,7 @@ static void ppc_hw_interrupt(CPUPPCState *env)
     /* Extermal interrupt can ignore MSR:EE under some circumstances */
     if (env->pending_interrupts & (1 << PPC_INTERRUPT_EXT)) {
         bool lpes0 =3D !!(env->spr[SPR_LPCR] & LPCR_LPES0);
-        if (msr_ee !=3D 0 || (env->has_hv_mode && msr_hv =3D=3D 0 && !lp=
es0)) {
+        if (async_deliver || (env->has_hv_mode && msr_hv =3D=3D 0 && !lp=
es0)) {
             powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_EXTERNAL);
             return;
         }
@@ -795,7 +805,7 @@ static void ppc_hw_interrupt(CPUPPCState *env)
             return;
         }
     }
-    if (msr_ee !=3D 0) {
+    if (async_deliver !=3D 0) {
         /* Watchdog timer on embedded PowerPC */
         if (env->pending_interrupts & (1 << PPC_INTERRUPT_WDT)) {
             env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_WDT);
@@ -943,21 +953,14 @@ void helper_pminsn(CPUPPCState *env, powerpc_pm_ins=
n_t insn)
=20
     cs =3D CPU(ppc_env_get_cpu(env));
     cs->halted =3D 1;
-    env->in_pm_state =3D true;
=20
     /* The architecture specifies that HDEC interrupts are
      * discarded in PM states
      */
     env->pending_interrupts &=3D ~(1 << PPC_INTERRUPT_HDECR);
=20
-    /* Technically, nap doesn't set EE, but if we don't set it
-     * then ppc_hw_interrupt() won't deliver. We could add some
-     * other tests there based on LPCR but it's simpler to just
-     * whack EE in. It will be cleared by the 0x100 at wakeup
-     * anyway. It will still be observable by the guest in SRR1
-     * but this doesn't seem to be a problem.
-     */
-    env->msr |=3D (1ull << MSR_EE);
+    /* Condition for waking up at 0x100 */
+    env->in_pm_state =3D true;
 }
 #endif /* defined(TARGET_PPC64) */
=20
--=20
2.20.1
