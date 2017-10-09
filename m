Received: from eggs.gnu.org ([2001:4830:134:3::10]:49124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1aJf-0004JO-O4
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e1aJc-0003GQ-KA
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:50:03 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:33814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e1aJc-0003Dz-Di
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:50:00 -0400
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 0DD22D9648
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 17:49:59 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  9 Oct 2017 17:49:29 +0200
Message-Id: <20171009154930.29095-4-clg@kaod.org>
In-Reply-To: <20171009154930.29095-1-clg@kaod.org>
References: <20171009154930.29095-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/4] spapr/rtas: fix reboot of a SMP TCG
 guest
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

Just like for hot unplugged CPUs, when a guest is rebooted, the
secondary CPUs can be awaken by the decrementer and start entering
SLOF at the same time the boot CPU is.

To be safe, let's disable the decrementer interrupt in the LPCR for
the secondaries.

Based on previous work from Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_cpu_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 37beb56e8b18..112868dc39d5 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -20,6 +20,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/error-report.h"
+#include "target/ppc/cpu-models.h"
=20
 void spapr_cpu_parse_features(sPAPRMachineState *spapr)
 {
@@ -86,6 +87,17 @@ static void spapr_cpu_reset(void *opaque)
     cs->halted =3D 1;
=20
     env->spr[SPR_HIOR] =3D 0;
+
+    /* Don't let the decremeter wake up CPUs other than the boot
+     * CPUs. this can cause issues when rebooting the guest */
+    if (cs !=3D first_cpu) {
+        if (ppc_cpu_pvr_match(cpu, CPU_POWERPC_LOGICAL_3_00)) {
+            env->spr[SPR_LPCR] &=3D ~LPCR_DEE;
+        } else {
+            /* P7 and P8 both have same bit for DECR */
+            env->spr[SPR_LPCR] &=3D ~LPCR_P8_PECE3;
+        }
+    }
 }
=20
 static void spapr_cpu_destroy(PowerPCCPU *cpu)
--=20
2.13.6
