Received: from eggs.gnu.org ([2001:4830:134:3::10]:39761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cuwhA-0001wi-GP
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 03:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cuwh5-0008T2-GR
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 03:46:36 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:32923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cuwh5-0008Sr-A6
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 03:46:31 -0400
Received: from player796.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id E2DCE7B082
	for <qemu-devel@nongnu.org>; Mon,  3 Apr 2017 09:46:29 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  3 Apr 2017 09:45:59 +0200
Message-Id: <1491205565-12831-4-git-send-email-clg@kaod.org>
In-Reply-To: <1491205565-12831-1-git-send-email-clg@kaod.org>
References: <1491205565-12831-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 3/9] ppc/xics: add a realize() handler to
 ICPStateClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

It will be used by derived classes in PowerNV for customization.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 5 +++++
 include/hw/ppc/xics.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index d4428b41b03a..292fffecd376 100644
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
index 88e0f021b168..05bb10a4ce8f 100644
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
2.7.4
