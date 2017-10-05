Received: from eggs.gnu.org ([2001:4830:134:3::10]:34158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e09M5-0008Ir-LY
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e09M1-0003MW-7n
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:50:37 -0400
Received: from 12.mo7.mail-out.ovh.net ([178.33.107.167]:48030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e09M1-0003Ks-1D
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:50:33 -0400
Received: from player697.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id A37866F5C0
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 18:50:31 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  5 Oct 2017 18:49:59 +0200
Message-Id: <20171005164959.26024-3-clg@kaod.org>
In-Reply-To: <20171005164959.26024-1-clg@kaod.org>
References: <20171005164959.26024-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] spapr/rtas: do not reset the MSR in
 stop-self command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When a CPU is stopped with the 'stop-self' RTAS call, its state
'halted' is switched to 1 and, in this case, the MSR is not taken into
account anymore in the cpu_has_work() routine. Only the pending
hardware interrupts are checked with their LPCR:PECE* enablement bit.

The CPU is now also protected from the decrementer interrupt by the
LPCR:PECE* bits which are disabled in the 'stop-self' RTAS
call. Reseting the MSR is pointless.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_rtas.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 2389220c9738..7f5ddce89ef2 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -209,16 +209,6 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
=20
     cs->halted =3D 1;
     qemu_cpu_kick(cs);
-    /*
-     * While stopping a CPU, the guest calls H_CPPR which
-     * effectively disables interrupts on XICS level.
-     * However decrementer interrupts in TCG can still
-     * wake the CPU up so here we disable interrupts in MSR
-     * as well.
-     * As rtas_start_cpu() resets the whole MSR anyway, there is
-     * no need to bother with specific bits, we just clear it.
-     */
-    env->msr =3D 0;
=20
     if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
         env->spr[SPR_LPCR] &=3D ~LPCR_DEE;
--=20
2.13.6
