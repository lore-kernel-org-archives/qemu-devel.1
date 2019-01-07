Received: from eggs.gnu.org ([209.51.188.92]:43778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggZpU-0002qu-8m
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ggZpT-000380-Bh
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:40:52 -0500
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:37064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ggZpT-00033p-4n
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 13:40:51 -0500
Received: from player687.ha.ovh.net (unknown [10.109.159.248])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id CC3E1393E8
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 19:40:49 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  7 Jan 2019 19:39:40 +0100
Message-Id: <20190107183946.7230-8-clg@kaod.org>
In-Reply-To: <20190107183946.7230-1-clg@kaod.org>
References: <20190107183946.7230-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/13] ppc/xics: introduce a icp_kvm_connect()
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This routine gathers all the KVM initialization of the XICS KVM
presenter. It will be useful when the initialization of the KVM XICS
device is moved to a global routine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_kvm.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index ac94594b1919..2426e5b2f4ed 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -123,11 +123,8 @@ static void icp_kvm_reset(DeviceState *dev)
     icp_set_kvm_state(ICP(dev), 1);
 }
=20
-static void icp_kvm_realize(DeviceState *dev, Error **errp)
+static void icp_kvm_connect(ICPState *icp, Error **errp)
 {
-    ICPState *icp =3D ICP(dev);
-    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
-    Error *local_err =3D NULL;
     CPUState *cs;
     KVMEnabledICP *enabled_icp;
     unsigned long vcpu_id;
@@ -135,11 +132,6 @@ static void icp_kvm_realize(DeviceState *dev, Error =
**errp)
=20
     if (kernel_xics_fd =3D=3D -1) {
         abort();
-    }
-
-    icpc->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
         return;
     }
=20
@@ -168,6 +160,25 @@ static void icp_kvm_realize(DeviceState *dev, Error =
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
+    /* Connect the presenter to the VCPU (required for CPU hotplug) */
+    icp_kvm_connect(ICP(dev), &local_err);
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
2.20.1
