Received: from eggs.gnu.org ([2001:4830:134:3::10]:33270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1coWXI-0002y0-5u
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1coWXD-0006qo-OQ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:37:52 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:32817)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1coWXD-0006q8-IV
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:37:47 -0400
Received: from player756.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 14AF4625B1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 15:37:46 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Mar 2017 15:35:07 +0100
Message-Id: <1489674912-21942-4-git-send-email-clg@kaod.org>
In-Reply-To: <1489674912-21942-1-git-send-email-clg@kaod.org>
References: <1489674912-21942-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/8] ppc/xics: add a realize() handler to
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
---
 hw/intc/xics.c        | 5 +++++
 include/hw/ppc/xics.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 5cde86ceb3bc..7cd842102265 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -348,6 +348,7 @@ static void icp_reset(void *dev)
 static void icp_realize(DeviceState *dev, Error **errp)
 {
     ICPState *icp =3D ICP(dev);
+    ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
     Object *obj;
     Error *err =3D NULL;
=20
@@ -360,6 +361,10 @@ static void icp_realize(DeviceState *dev, Error **er=
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
index 9a5e715fe553..0863e3a079f5 100644
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
