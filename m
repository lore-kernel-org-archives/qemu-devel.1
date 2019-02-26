Received: from eggs.gnu.org ([209.51.188.92]:58109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlH-0005PA-IB
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlF-0002th-H4
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:35 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:50 +1100
Message-Id: <20190226045304.25618-37-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 36/50] spapr_irq: Expose the phandle of the
 interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

This will be used by PHB hotplug in order to create the "interrupt-map"
property of the PHB node.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155059669374.1466090.12943228478046223856.stgit@bahia.lab.to=
ulouse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c         | 21 +++++++++++++++++++++
 include/hw/ppc/spapr_irq.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 359761494c..4145079d7f 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -638,6 +638,27 @@ void spapr_irq_reset(sPAPRMachineState *spapr, Error=
 **errp)
     }
 }
=20
+int spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt, Error **e=
rrp)
+{
+    const char *nodename =3D spapr->irq->get_nodename(spapr);
+    int offset, phandle;
+
+    offset =3D fdt_subnode_offset(fdt, 0, nodename);
+    if (offset < 0) {
+        error_setg(errp, "Can't find node \"%s\": %s", nodename,
+                   fdt_strerror(offset));
+        return -1;
+    }
+
+    phandle =3D fdt_get_phandle(fdt, offset);
+    if (!phandle) {
+        error_setg(errp, "Can't get phandle of node \"%s\"", nodename);
+        return -1;
+    }
+
+    return phandle;
+}
+
 /*
  * XICS legacy routines - to deprecate one day
  */
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 8bf1a72919..ec1ee64fa6 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -61,6 +61,7 @@ void spapr_irq_free(sPAPRMachineState *spapr, int irq, =
int num);
 qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
 int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
 void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
+int spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt, Error **e=
rrp);
=20
 /*
  * XICS legacy routines
--=20
2.20.1
