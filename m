Received: from eggs.gnu.org ([2001:4830:134:3::10]:53197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixM-0003d8-B8
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixL-0004fL-A4
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:48 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:22 +1100
Message-Id: <20171215055435.24204-12-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/24] spapr/rtas: fix reboot of a a SMP TCG
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Just like for hot unplug CPUs, when a guest is rebooted, the secondary
CPUs can be awaken by the decrementer and start entering SLOF at the
same time the boot CPU is.

To be safe, let's disable on the secondaries all the exceptions which
can cause an exit while the CPU is in power-saving mode.

Based on previous work from Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 588f9b4571..1ea0e295dd 100644
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
2.14.3
