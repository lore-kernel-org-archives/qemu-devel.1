Received: from eggs.gnu.org ([2001:4830:134:3::10]:45946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eGiwE-0000zm-Vv
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eGiw9-0001oh-CO
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:04:26 -0500
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:38104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eGiw8-0001mb-HH
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:04:21 -0500
Received: from player739.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id CC65788A58
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 11:04:17 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 20 Nov 2017 11:03:47 +0100
Message-Id: <20171120100347.8601-4-clg@kaod.org>
In-Reply-To: <20171120100347.8601-1-clg@kaod.org>
References: <20171120100347.8601-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v3 3/3] spapr/rtas: do not reset the
 MSR in stop-self command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When a CPU is stopped with the 'stop-self' RTAS call, its state
'halted' is switched to 1 and, in this case, the MSR is not taken into
account anymore in the cpu_has_work() routine. Only the pending
hardware interrupts are checked with their LPCR:PECE* enablement bit.

The CPU is now also protected from the decrementer interrupt by the
LPCR:PECE* bits which are disabled in the 'stop-self' RTAS
call. Reseting the MSR is pointless.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_rtas.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index b5cff3ab29d3..7ddddc1c9c8a 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -204,16 +204,6 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMac=
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
     /* Disable Power-saving mode Exit Cause exceptions for the CPU.
      * This could deliver an interrupt on a dying CPU and crash the
--=20
2.13.6
