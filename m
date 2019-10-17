Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1A4FA372B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 05:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFF92089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 05:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cEEtCLpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFF92089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKyaC-0002uQ-J0
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 01:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iKyYO-00016G-CB
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 01:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iKyYN-0005IW-3V
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 01:42:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54863 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iKyYL-0005Ha-RY; Thu, 17 Oct 2019 01:42:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46tyjT3yNPz9sPJ; Thu, 17 Oct 2019 16:42:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571290941;
 bh=QVOoj/fHM/SytkR+SlnuYQR1WMMdt0CVDGRkSbKA0Rw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cEEtCLpUXt9CyZGSqklfXtk3nek7VPdZNHoyv9ehKYcP+e7OR09L1+KA0XD20S9Ie
 sqX1I2LEHEs0OafzKr0O1gY46ZVQUiVwLbX01pHfh9L5vA2D0R8ujVL7XJXtCDgL1E
 6/lyAEyW5HBkC1rp4oS+MNVhreYgbhJd6NXQGWk8=
From: David Gibson <david@gibson.dropbear.id.au>
To: alex.williamson@redhat.com,
	clg@kaod.org,
	groug@kaod.org
Subject: [RFC 2/5] vfio/pci: Split vfio_intx_update()
Date: Thu, 17 Oct 2019 16:42:15 +1100
Message-Id: <20191017054218.8876-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017054218.8876-1-david@gibson.dropbear.id.au>
References: <20191017054218.8876-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This splits the vfio_intx_update() function into one part doing the actua=
l
reconnection with the KVM irqchip (vfio_intx_update(), now taking an
argument with the new routing) and vfio_intx_routing_notifier() which
handles calls to the pci device intx routing notifier and calling
vfio_intx_update() when necessary.  This will make adding support for the
irqchip change notifier easier.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/vfio/pci.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 12fac39804..529ad13908 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -215,30 +215,18 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vd=
ev)
 #endif
 }
=20
-static void vfio_intx_update(PCIDevice *pdev)
+static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
 {
-    VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
-    PCIINTxRoute route;
     Error *err =3D NULL;
=20
-    if (vdev->interrupt !=3D VFIO_INT_INTx) {
-        return;
-    }
-
-    route =3D pci_device_route_intx_to_irq(&vdev->pdev, vdev->intx.pin);
-
-    if (!pci_intx_route_changed(&vdev->intx.route, &route)) {
-        return; /* Nothing changed */
-    }
-
     trace_vfio_intx_update(vdev->vbasedev.name,
-                           vdev->intx.route.irq, route.irq);
+                           vdev->intx.route.irq, route->irq);
=20
     vfio_intx_disable_kvm(vdev);
=20
-    vdev->intx.route =3D route;
+    vdev->intx.route =3D *route;
=20
-    if (route.mode !=3D PCI_INTX_ENABLED) {
+    if (route->mode !=3D PCI_INTX_ENABLED) {
         return;
     }
=20
@@ -251,6 +239,22 @@ static void vfio_intx_update(PCIDevice *pdev)
     vfio_intx_eoi(&vdev->vbasedev);
 }
=20
+static void vfio_intx_routing_notifier(PCIDevice *pdev)
+{
+    VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
+    PCIINTxRoute route;
+
+    if (vdev->interrupt !=3D VFIO_INT_INTx) {
+        return;
+    }
+
+    route =3D pci_device_route_intx_to_irq(&vdev->pdev, vdev->intx.pin);
+
+    if (pci_intx_route_changed(&vdev->intx.route, &route)) {
+        vfio_intx_update(vdev, &route);
+    }
+}
+
 static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
     uint8_t pin =3D vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN,=
 1);
@@ -2954,7 +2958,8 @@ static void vfio_realize(PCIDevice *pdev, Error **e=
rrp)
     if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
         vdev->intx.mmap_timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                                   vfio_intx_mmap_enable,=
 vdev);
-        pci_device_set_intx_routing_notifier(&vdev->pdev, vfio_intx_upda=
te);
+        pci_device_set_intx_routing_notifier(&vdev->pdev,
+                                             vfio_intx_routing_notifier)=
;
         ret =3D vfio_intx_enable(vdev, errp);
         if (ret) {
             goto out_teardown;
--=20
2.21.0


