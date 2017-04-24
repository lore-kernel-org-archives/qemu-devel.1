Received: from eggs.gnu.org ([2001:4830:134:3::10]:56427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TID-0001ZK-Lg
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIC-0003S8-Lp
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:57 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:59:24 +1000
Message-Id: <20170424015927.8933-45-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 44/47] spapr-cpu-core: Release ICPState object
 during CPU unrealization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

Recent commits that re-organized ICPState object missed to destroy
the object when CPU is unrealized. Fix this so that CPU unplug
doesn't abort QEMU.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 2e689b5..4389ef4 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -127,6 +127,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState *d=
ev, Error **errp)
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
         spapr_cpu_destroy(cpu);
+        object_unparent(cpu->intc);
         cpu_remove_sync(cs);
         object_unparent(obj);
     }
--=20
2.9.3
