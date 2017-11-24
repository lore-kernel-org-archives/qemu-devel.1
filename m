Received: from eggs.gnu.org ([2001:4830:134:3::10]:33712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eI83y-0002a5-Ai
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eI83s-0007sM-FA
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:06:14 -0500
Received: from 3.mo6.mail-out.ovh.net ([178.33.253.26]:33421)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eI83s-0007rP-A0
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:06:08 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id F3EBF120D92
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 08:06:06 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 24 Nov 2017 08:05:49 +0100
Message-Id: <20171124070550.6433-3-clg@kaod.org>
In-Reply-To: <20171124070550.6433-1-clg@kaod.org>
References: <20171124070550.6433-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 2/3] spapr/rtas: fix reboot of a a SMP TCG
 guest
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

Just like for hot unplug CPUs, when a guest is rebooted, the secondary
CPUs can be awaken by the decrementer and start entering SLOF at the
same time the boot CPU is.

To be safe, let's disable on the secondaries all the exceptions which
can cause an exit while the CPU is in power-saving mode.

Based on previous work from Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---

Changes in v4:

 - used the 'lpcr_pm' field of PowerPCCPUClass

Changes in v3:

 - used the cpu_ppc_papr_pece_bits() helper=20

 hw/ppc/spapr_cpu_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 3a4c17401226..a2290528542d 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -26,6 +26,7 @@ static void spapr_cpu_reset(void *opaque)
     PowerPCCPU *cpu =3D opaque;
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
+    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
=20
     cpu_reset(cs);
=20
@@ -35,6 +36,13 @@ static void spapr_cpu_reset(void *opaque)
     cs->halted =3D 1;
=20
     env->spr[SPR_HIOR] =3D 0;
+
+    /* Disable Power-saving mode Exit Cause exceptions for the CPU.
+     * This can cause issues when rebooting the guest if a secondary
+     * is awaken */
+    if (cs !=3D first_cpu) {
+        env->spr[SPR_LPCR] &=3D ~pcc->lpcr_pm;
+    }
 }
=20
 static void spapr_cpu_destroy(PowerPCCPU *cpu)
--=20
2.13.6
