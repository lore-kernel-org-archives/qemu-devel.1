Received: from eggs.gnu.org ([2001:4830:134:3::10]:45200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgYN-00086z-1C
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgYI-0004UE-8z
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:26:02 -0500
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:56658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgYH-0004SD-HE
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:58 -0500
Received: from player714.ha.ovh.net (unknown [10.109.160.253])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 035B31075B0
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:25:56 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:46 +0100
Message-Id: <20181205232251.10446-33-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 32/37] ppc/xics: introduce a
 icp_kvm_connect() routine
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
 hw/intc/xics_kvm.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index e8fa9a53aeba..de86e1d0b1ab 100644
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
2.17.2
