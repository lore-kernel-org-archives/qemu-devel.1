Received: from eggs.gnu.org ([2001:4830:134:3::10]:45813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eGiw6-0000j7-BR
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eGiw3-0001j2-3H
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:04:18 -0500
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:59490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eGiw2-0001hr-T7
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:04:15 -0500
Received: from player739.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id A77F288A08
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 11:04:12 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 20 Nov 2017 11:03:46 +0100
Message-Id: <20171120100347.8601-3-clg@kaod.org>
In-Reply-To: <20171120100347.8601-1-clg@kaod.org>
References: <20171120100347.8601-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v3 2/3] spapr/rtas: fix reboot of a a
 SMP TCG guest
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

Just like for hot unplug CPUs, when a guest is rebooted, the secondary
CPUs can be awaken by the decrementer and start entering SLOF at the
same time the boot CPU is.

To be safe, let's disable on the secondaries all the exceptions which
can cause an exit while the CPU is in power-saving mode.

Based on previous work from Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

Changes in v3:

 - used the cpu_ppc_papr_pece_bits() helper=20

 hw/ppc/spapr_cpu_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 3a4c17401226..4ba8563d49e4 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -35,6 +35,13 @@ static void spapr_cpu_reset(void *opaque)
     cs->halted =3D 1;
=20
     env->spr[SPR_HIOR] =3D 0;
+
+    /* Disable Power-saving mode Exit Cause exceptions for the CPU.
+     * This can cause issues when rebooting the guest if a secondary
+     * is awaken */
+    if (cs !=3D first_cpu) {
+        env->spr[SPR_LPCR] &=3D ~cpu_ppc_papr_pece_bits(env);
+    }
 }
=20
 static void spapr_cpu_destroy(PowerPCCPU *cpu)
--=20
2.13.6
