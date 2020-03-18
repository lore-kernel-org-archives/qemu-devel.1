Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8E5C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D715820714
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8eRIGx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D715820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEa4S-0001jF-1V
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jEa3X-0000Tq-12
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jEa3V-0006ZB-OH
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:52:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jEa3V-0006UL-Jv
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584543145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d7VCARQpa543CzI17Qh3SwV/uYby6Bu6+9e0X/pxZcw=;
 b=K8eRIGx1QV/oZKk4FoV8Djwpzn8m+uZNnmZ6KjK64y8HyfL/eCrbweNPJblrpJMKx9p+dG
 HzPJNmgOlv6Ko7gG1Kbb0pwma6oo3Cy5MiYKBccc69IxXBARdbdm/84zjznaI455RaW5AZ
 tIUS3gcNLhUAd+JUxEBf03xsgkLTdV4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-KILDF9pMNDmDXYUCFfFWrA-1; Wed, 18 Mar 2020 10:52:23 -0400
X-MC-Unique: KILDF9pMNDmDXYUCFfFWrA-1
Received: by mail-wm1-f70.google.com with SMTP id p18so1179528wmk.9
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 07:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R4ymvWMCxrIfLkhgyjJ3vQ3SuCXiTnkkegIn5k6FWHQ=;
 b=Xcr6fItjPYGJYf6Hz34MF2GRRJYdD8JzgtjjLRoF8tDsVzuSYBUNOKP8YmjFTEitON
 Lzk+1k6c/Pz0UdmLyledrJkaGkyiSbtACOHYvdwb/yXg2qgjpgIYizgHkeb4aEWbI8gL
 T+/XKZZM8UU/b/7sis5HLb2ivs/opwRepQJ0e/lxB8QNa6lOVTkJyGt6RT+DdtmqrmFL
 ANsdH0pvrzVXkZ2V9uaskfqvNHleidwdG1Flc4jRIxTXcyfSBea4e992AWKa47wAAsog
 WUHj6sDmHvxEU4Wm3ne9sIl6f1DUMwy2oAzCj9djCyCtkOclnkC18XweF5OQc9IqP8cV
 J0IQ==
X-Gm-Message-State: ANhLgQ3yR00lmQ0a45KXc3GDbiO9oqzbsUjUiLr5/MHFl7w4f32dbdVx
 EWNqClWtJ88j5E4rA+nvfzraycXHodN6NeNZstHaYQ53JD3Dh4hyz0u3+J1W0YBCpIFQA2n5PVF
 zBiN+5JqoTuTgqVQ=
X-Received: by 2002:a1c:2e92:: with SMTP id u140mr5622803wmu.84.1584543141476; 
 Wed, 18 Mar 2020 07:52:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtKnJco+TcUaI3QTwe7pmpsdrvaNbGxtpa2G8FyQoAWX0/FBt4bIUhcBOSmkrUCPYYvbZ2nwQ==
X-Received: by 2002:a1c:2e92:: with SMTP id u140mr5622776wmu.84.1584543141233; 
 Wed, 18 Mar 2020 07:52:21 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id v10sm3912401wml.44.2020.03.18.07.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 07:52:20 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/5] vfio/pci: Use kvm_irqchip_add_irqfd_notifier_gsi() for
 irqfds
Date: Wed, 18 Mar 2020 10:52:01 -0400
Message-Id: <20200318145204.74483-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318145204.74483-1-peterx@redhat.com>
References: <20200318145204.74483-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, peterx@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VFIO is currently the only one left that is not using the generic
function (kvm_irqchip_add_irqfd_notifier_gsi()) to register irqfds.
Let VFIO use the common framework too.

Follow up patches will introduce extra features for kvm irqfd, so that
VFIO can easily leverage that after the switch.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/pci.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 98e0e0c994..09703362df 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -115,11 +115,7 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
 static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
 #ifdef CONFIG_KVM
-    struct kvm_irqfd irqfd =3D {
-        .fd =3D event_notifier_get_fd(&vdev->intx.interrupt),
-        .gsi =3D vdev->intx.route.irq,
-        .flags =3D KVM_IRQFD_FLAG_RESAMPLE,
-    };
+    int irq_fd =3D event_notifier_get_fd(&vdev->intx.interrupt);
     Error *err =3D NULL;
=20
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
@@ -141,7 +137,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, E=
rror **errp)
     }
=20
     /* Get to a known interrupt state */
-    qemu_set_fd_handler(irqfd.fd, NULL, NULL, vdev);
+    qemu_set_fd_handler(irq_fd, NULL, NULL, vdev);
     vfio_mask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending =3D false;
     pci_irq_deassert(&vdev->pdev);
@@ -152,17 +148,18 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev,=
 Error **errp)
         goto fail;
     }
=20
-    /* KVM triggers it, VFIO listens for it */
-    irqfd.resamplefd =3D event_notifier_get_fd(&vdev->intx.unmask);
-
-    if (kvm_vm_ioctl(kvm_state, KVM_IRQFD, &irqfd)) {
+    if (kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
+                                           &vdev->intx.interrupt,
+                                           &vdev->intx.unmask,
+                                           vdev->intx.route.irq)) {
         error_setg_errno(errp, errno, "failed to setup resample irqfd");
         goto fail_irqfd;
     }
=20
     if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0=
,
                                VFIO_IRQ_SET_ACTION_UNMASK,
-                               irqfd.resamplefd, &err)) {
+                               event_notifier_get_fd(&vdev->intx.unmask),
+                               &err)) {
         error_propagate(errp, err);
         goto fail_vfio;
     }
@@ -177,12 +174,12 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev,=
 Error **errp)
     return;
=20
 fail_vfio:
-    irqfd.flags =3D KVM_IRQFD_FLAG_DEASSIGN;
-    kvm_vm_ioctl(kvm_state, KVM_IRQFD, &irqfd);
+    kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt=
,
+                                          vdev->intx.route.irq);
 fail_irqfd:
     event_notifier_cleanup(&vdev->intx.unmask);
 fail:
-    qemu_set_fd_handler(irqfd.fd, vfio_intx_interrupt, NULL, vdev);
+    qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
     vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 #endif
 }
@@ -190,12 +187,6 @@ fail:
 static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
 {
 #ifdef CONFIG_KVM
-    struct kvm_irqfd irqfd =3D {
-        .fd =3D event_notifier_get_fd(&vdev->intx.interrupt),
-        .gsi =3D vdev->intx.route.irq,
-        .flags =3D KVM_IRQFD_FLAG_DEASSIGN,
-    };
-
     if (!vdev->intx.kvm_accel) {
         return;
     }
@@ -209,7 +200,8 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
     pci_irq_deassert(&vdev->pdev);
=20
     /* Tell KVM to stop listening for an INTx irqfd */
-    if (kvm_vm_ioctl(kvm_state, KVM_IRQFD, &irqfd)) {
+    if (kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.inter=
rupt,
+                                              vdev->intx.route.irq)) {
         error_report("vfio: Error: Failed to disable INTx irqfd: %m");
     }
=20
@@ -217,7 +209,8 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
     event_notifier_cleanup(&vdev->intx.unmask);
=20
     /* QEMU starts listening for interrupt events. */
-    qemu_set_fd_handler(irqfd.fd, vfio_intx_interrupt, NULL, vdev);
+    qemu_set_fd_handler(event_notifier_get_fd(&vdev->intx.interrupt),
+                        vfio_intx_interrupt, NULL, vdev);
=20
     vdev->intx.kvm_accel =3D false;
=20
--=20
2.24.1


