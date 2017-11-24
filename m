Received: from eggs.gnu.org ([2001:4830:134:3::10]:33753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eI841-0002cI-Iz
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eI83x-0007v0-Gv
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:06:17 -0500
Received: from 13.mo6.mail-out.ovh.net ([188.165.56.124]:33434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eI83x-0007uQ-BH
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:06:13 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 27703120D8B
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 08:06:12 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 24 Nov 2017 08:05:50 +0100
Message-Id: <20171124070550.6433-4-clg@kaod.org>
In-Reply-To: <20171124070550.6433-1-clg@kaod.org>
References: <20171124070550.6433-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 3/3] spapr/rtas: do not reset the MSR in
 stop-self command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
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
index 858adb1bf3a9..4bb939d3d111 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -206,16 +206,6 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMac=
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
