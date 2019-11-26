Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6697C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 06:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B4E2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 06:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gnzxat47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B4E2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZUBd-0001Bz-Uh
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 01:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iZU8x-0007Mj-WF
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 01:16:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iZTvF-0004NH-Vu
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 01:02:06 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:35309 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iZTvE-0004KU-Vp; Tue, 26 Nov 2019 01:02:01 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47MYFc5Bnxz9sR5; Tue, 26 Nov 2019 17:01:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574748116;
 bh=YXoCERS56wn75a8kv2DqcGF9kiUBlvFpYPk1X6VGAIY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gnzxat47L3B+LmOVayyfyWe6k2iLrCe2i8CakVDjxthKFdK+fjNpO1XcfajASVxnp
 PJb4K/qIfd8s13ktJfjzPUazhyloi4xtUkEggc3egGCfyB2q4lL69IKuqYeefRq+c/
 hx3X6JDF7m44IrqO/L3AS4kkmSEOa+uLuBMFxD94=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 4/8] vfio/pci: Respond to KVM irqchip change notifier
Date: Tue, 26 Nov 2019 17:01:47 +1100
Message-Id: <20191126060151.729845-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191126060151.729845-1-david@gibson.dropbear.id.au>
References: <20191126060151.729845-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel@nongnu.org, groug@kaod.org,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VFIO PCI devices already respond to the pci intx routing notifier, in ord=
er
to update kernel irqchip mappings when routing is updated.  However this
won't handle the case where the irqchip itself is replaced by a different
model while retaining the same routing.  This case can happen on
the pseries machine type due to PAPR feature negotiation.

To handle that case, add a handler for the irqchip change notifier, which
does much the same thing as the routing notifier, but is unconditional,
rather than being a no-op when the routing hasn't changed.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c | 25 +++++++++++++++++++------
 hw/vfio/pci.h |  1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 521289aa7d..2d40b396f2 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -256,6 +256,14 @@ static void vfio_intx_routing_notifier(PCIDevice *pd=
ev)
     }
 }
=20
+static void vfio_irqchip_change(Notifier *notify, void *data)
+{
+    VFIOPCIDevice *vdev =3D container_of(notify, VFIOPCIDevice,
+                                       irqchip_change_notifier);
+
+    vfio_intx_update(vdev, &vdev->intx.route);
+}
+
 static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
     uint8_t pin =3D vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN,=
 1);
@@ -2973,30 +2981,32 @@ static void vfio_realize(PCIDevice *pdev, Error *=
*errp)
                                                   vfio_intx_mmap_enable,=
 vdev);
         pci_device_set_intx_routing_notifier(&vdev->pdev,
                                              vfio_intx_routing_notifier)=
;
+        vdev->irqchip_change_notifier.notify =3D vfio_irqchip_change;
+        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
         ret =3D vfio_intx_enable(vdev, errp);
         if (ret) {
-            goto out_teardown;
+            goto out_deregister;
         }
     }
=20
     if (vdev->display !=3D ON_OFF_AUTO_OFF) {
         ret =3D vfio_display_probe(vdev, errp);
         if (ret) {
-            goto out_teardown;
+            goto out_deregister;
         }
     }
     if (vdev->enable_ramfb && vdev->dpy =3D=3D NULL) {
         error_setg(errp, "ramfb=3Don requires display=3Don");
-        goto out_teardown;
+        goto out_deregister;
     }
     if (vdev->display_xres || vdev->display_yres) {
         if (vdev->dpy =3D=3D NULL) {
             error_setg(errp, "xres and yres properties require display=3D=
on");
-            goto out_teardown;
+            goto out_deregister;
         }
         if (vdev->dpy->edid_regs =3D=3D NULL) {
             error_setg(errp, "xres and yres properties need edid support=
");
-            goto out_teardown;
+            goto out_deregister;
         }
     }
=20
@@ -3020,8 +3030,10 @@ static void vfio_realize(PCIDevice *pdev, Error **=
errp)
=20
     return;
=20
-out_teardown:
+out_deregister:
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
+    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
+out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
 error:
@@ -3064,6 +3076,7 @@ static void vfio_exitfn(PCIDevice *pdev)
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
+    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
     vfio_disable_interrupts(vdev);
     if (vdev->intx.mmap_timer) {
         timer_free(vdev->intx.mmap_timer);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index b329d50338..35626cd63e 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -169,6 +169,7 @@ typedef struct VFIOPCIDevice {
     bool enable_ramfb;
     VFIODisplay *dpy;
     Error *migration_blocker;
+    Notifier irqchip_change_notifier;
 } VFIOPCIDevice;
=20
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
--=20
2.23.0


