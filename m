Received: from eggs.gnu.org ([2001:4830:134:3::10]:56713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwl-0005F5-BH
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwe-00080T-O1
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:07 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 26 Apr 2017 17:00:06 +1000
Message-Id: <20170426070034.10727-21-david@gibson.dropbear.id.au>
In-Reply-To: <20170426070034.10727-1-david@gibson.dropbear.id.au>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/48] ppc/xics: add a realize() handler to
 ICPStateClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

It will be used by derived classes in PowerNV for customization.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 5 +++++
 include/hw/ppc/xics.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index d4428b4..292fffe 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -337,6 +337,7 @@ static void icp_reset(void *dev)
 static void icp_realize(DeviceState *dev, Error **errp)
 {
     ICPState *icp =3D ICP(dev);
+    ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
     Object *obj;
     Error *err =3D NULL;
=20
@@ -349,6 +350,10 @@ static void icp_realize(DeviceState *dev, Error **er=
rp)
=20
     icp->xics =3D XICS_FABRIC(obj);
=20
+    if (icpc->realize) {
+        icpc->realize(dev, errp);
+    }
+
     qemu_register_reset(icp_reset, dev);
 }
=20
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index b07f56f..731e177 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -60,6 +60,7 @@ typedef struct XICSFabric XICSFabric;
 struct ICPStateClass {
     DeviceClass parent_class;
=20
+    void (*realize)(DeviceState *dev, Error **errp);
     void (*pre_save)(ICPState *s);
     int (*post_load)(ICPState *s, int version_id);
     void (*cpu_setup)(ICPState *icp, PowerPCCPU *cpu);
--=20
2.9.3
