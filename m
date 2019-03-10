Received: from eggs.gnu.org ([209.51.188.92]:42515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tns-0000hU-Ma
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnr-00018h-2X
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:06 +1100
Message-Id: <20190310082703.1245-4-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/60] spapr: Simulate CAS for qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The RTAS event hotplug code for machine types 2.8 and newer depends on
the CAS negotiated ov5 in order to work properly. However, there's no
CAS when running under qtest. There has been a tentative to trick the
code by faking the OV5_HP_EVT bit, but it turned out to break other
assumptions in the code and the change got reverted.

Go for a more general approach and simulate a CAS when running under
qtest. For simplicity, this pseudo CAS simple simulates the case where
the guest supports the same features as the machine. It is done at
reset time, just before we reset the DRCs, which could potentially
exercise the unplug code.

This allows to test unplug on spapr with both older and newer machine
types.

Suggested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155146875704.147873.10563808578795890265.stgit@bahia.lan>
Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9e01226e18..f7d527464c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -29,6 +29,7 @@
 #include "qapi/visitor.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
+#include "sysemu/qtest.h"
 #include "hw/hw.h"
 #include "qemu/log.h"
 #include "hw/fw-path-provider.h"
@@ -1711,6 +1712,16 @@ static void spapr_machine_reset(void)
      */
     spapr_irq_reset(spapr, &error_fatal);
=20
+    /*
+     * There is no CAS under qtest. Simulate one to please the code that
+     * depends on spapr->ov5_cas. This is especially needed to test devi=
ce
+     * unplug, so we do that before resetting the DRCs.
+     */
+    if (qtest_enabled()) {
+        spapr_ovec_cleanup(spapr->ov5_cas);
+        spapr->ov5_cas =3D spapr_ovec_clone(spapr->ov5);
+    }
+
     /* DRC reset may cause a device to be unplugged. This will cause tro=
ubles
      * if this device is used by another device (eg, a running vhost bac=
kend
      * will crash QEMU if the DIMM holding the vring goes away). To avoi=
d such
--=20
2.20.1
