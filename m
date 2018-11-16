Received: from eggs.gnu.org ([2001:4830:134:3::10]:34437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbrf-0000U8-0Y
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbrN-0000pY-5N
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:00:36 -0500
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:45828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gNbrH-0000kN-Kb
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 06:00:23 -0500
Received: from player734.ha.ovh.net (unknown [10.109.159.73])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 33FAC10AD98
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 12:00:18 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 16 Nov 2018 11:57:21 +0100
Message-Id: <20181116105729.23240-29-clg@kaod.org>
In-Reply-To: <20181116105729.23240-1-clg@kaod.org>
References: <20181116105729.23240-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 28/36] ppc/xics: introduce a icp_kvm_init()
 routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This routine gathers all the KVM initialization of the XICS KVM
presenter. It will be useful when the initialization of the KVM XICS
device is moved to a global routine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_kvm.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index e8fa9a53aeba..efad1b19d821 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -123,11 +123,8 @@ static void icp_kvm_reset(DeviceState *dev)
     icp_set_kvm_state(ICP(dev), 1);
 }
=20
-static void icp_kvm_realize(DeviceState *dev, Error **errp)
+static void icp_kvm_init(ICPState *icp, Error **errp)
 {
-    ICPState *icp =3D ICP(dev);
-    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
-    Error *local_err =3D NULL;
     CPUState *cs;
     KVMEnabledICP *enabled_icp;
     unsigned long vcpu_id;
@@ -137,12 +134,6 @@ static void icp_kvm_realize(DeviceState *dev, Error =
**errp)
         abort();
     }
=20
-    icpc->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
     cs =3D icp->cs;
     vcpu_id =3D kvm_arch_vcpu_id(cs);
=20
@@ -168,6 +159,24 @@ static void icp_kvm_realize(DeviceState *dev, Error =
**errp)
     QLIST_INSERT_HEAD(&kvm_enabled_icps, enabled_icp, node);
 }
=20
+static void icp_kvm_realize(DeviceState *dev, Error **errp)
+{
+    ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
+    Error *local_err =3D NULL;
+
+    icpc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    icp_kvm_init(ICP(dev), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
 static void icp_kvm_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
--=20
2.17.2
