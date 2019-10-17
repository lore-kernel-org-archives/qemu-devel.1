Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6C4C4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 05:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596EF2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 05:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Xfh9aFlA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596EF2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKyaA-0002pR-Uj
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 01:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iKyYO-00016K-Ok
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 01:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iKyYN-0005Iq-Hc
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 01:42:28 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52041)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iKyYN-0005HZ-61; Thu, 17 Oct 2019 01:42:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46tyjT5GT8z9sPV; Thu, 17 Oct 2019 16:42:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571290941;
 bh=3vh+L/Wvc64AgJedFt6SujDhRBXr/JOzBL3DIiBl6Bs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Xfh9aFlAI/rRN9893ONcEPpEkpB180jIUz9qQGTLhqvEZWNl+sVH8FzkN8bTpGhei
 Q4sOFXJIP93iavCBis5oGKGEDO7q3DLd2EGt+kuibMW7TkxVfLOMeCAkEtkHBsT/3T
 2/zcGTQ3zUvSKCzxX8j3oP72buxJwTK6PeMMV8NE=
From: David Gibson <david@gibson.dropbear.id.au>
To: alex.williamson@redhat.com,
	clg@kaod.org,
	groug@kaod.org
Subject: [RFC 3/5] vfio/pci: Respond to KVM irqchip change notifier
Date: Thu, 17 Oct 2019 16:42:16 +1100
Message-Id: <20191017054218.8876-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017054218.8876-1-david@gibson.dropbear.id.au>
References: <20191017054218.8876-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
---
 hw/vfio/pci.c | 12 ++++++++++++
 hw/vfio/pci.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 529ad13908..6aa806baff 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -255,6 +255,14 @@ static void vfio_intx_routing_notifier(PCIDevice *pd=
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
@@ -2960,6 +2968,8 @@ static void vfio_realize(PCIDevice *pdev, Error **e=
rrp)
                                                   vfio_intx_mmap_enable,=
 vdev);
         pci_device_set_intx_routing_notifier(&vdev->pdev,
                                              vfio_intx_routing_notifier)=
;
+        vdev->irqchip_change_notifier.notify =3D vfio_irqchip_change;
+        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
         ret =3D vfio_intx_enable(vdev, errp);
         if (ret) {
             goto out_teardown;
@@ -3009,6 +3019,7 @@ static void vfio_realize(PCIDevice *pdev, Error **e=
rrp)
=20
 out_teardown:
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
+    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
 error:
@@ -3042,6 +3053,7 @@ static void vfio_exitfn(PCIDevice *pdev)
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
+    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
     vfio_disable_interrupts(vdev);
     if (vdev->intx.mmap_timer) {
         timer_free(vdev->intx.mmap_timer);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 834a90d646..11324f28ce 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -168,6 +168,8 @@ typedef struct VFIOPCIDevice {
     bool no_vfio_ioeventfd;
     bool enable_ramfb;
     VFIODisplay *dpy;
+
+    Notifier irqchip_change_notifier;
 } VFIOPCIDevice;
=20
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
--=20
2.21.0


