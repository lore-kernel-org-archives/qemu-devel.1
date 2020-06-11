Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6ACC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476BE20720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBPM3Jxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476BE20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTqi-0005r4-ES
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9Q-0008I4-FJ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37355
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9N-0001Dr-Qx
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KGJrn4mBcuuQPbf5h+fVCvjwwd4L5qQyUYwiSYCkEv4=;
 b=LBPM3JxvkpOACg5/0p3aBpb+McEX0j+U+5EWr64NaFqQVEIt39MNJ1SNqLV8ctU27E5khL
 xelqXUAjXzYTVOjVq8tfnCmX28YDPlp3e0Y2SL53YKYNM2c7zpnAVoM7LqFh3NDTxAOBzf
 hkwjpvCkJHFnVeRqiqAU45qY1Xa2p74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-K9DwVHw_P-WDhLRWDaJKzg-1; Thu, 11 Jun 2020 15:46:06 -0400
X-MC-Unique: K9DwVHw_P-WDhLRWDaJKzg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02610107ACCA
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 19:46:06 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AC2051C50;
 Thu, 11 Jun 2020 19:45:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 067/115] vfio/pci: Use kvm_irqchip_add_irqfd_notifier_gsi() for
 irqfds
Date: Thu, 11 Jun 2020 15:44:01 -0400
Message-Id: <20200611194449.31468-68-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 Cornelia Huck <cohuck@redhat.com>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

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
Message-Id: <20200318145204.74483-3-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/pci.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 342dd6b912..6838bcc4b3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -115,11 +115,7 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
 static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
 #ifdef CONFIG_KVM
-    struct kvm_irqfd irqfd = {
-        .fd = event_notifier_get_fd(&vdev->intx.interrupt),
-        .gsi = vdev->intx.route.irq,
-        .flags = KVM_IRQFD_FLAG_RESAMPLE,
-    };
+    int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
     Error *err = NULL;
 
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
@@ -129,7 +125,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     }
 
     /* Get to a known interrupt state */
-    qemu_set_fd_handler(irqfd.fd, NULL, NULL, vdev);
+    qemu_set_fd_handler(irq_fd, NULL, NULL, vdev);
     vfio_mask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
     pci_irq_deassert(&vdev->pdev);
@@ -140,17 +136,18 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
         goto fail;
     }
 
-    /* KVM triggers it, VFIO listens for it */
-    irqfd.resamplefd = event_notifier_get_fd(&vdev->intx.unmask);
-
-    if (kvm_vm_ioctl(kvm_state, KVM_IRQFD, &irqfd)) {
+    if (kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
+                                           &vdev->intx.interrupt,
+                                           &vdev->intx.unmask,
+                                           vdev->intx.route.irq)) {
         error_setg_errno(errp, errno, "failed to setup resample irqfd");
         goto fail_irqfd;
     }
 
     if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
                                VFIO_IRQ_SET_ACTION_UNMASK,
-                               irqfd.resamplefd, &err)) {
+                               event_notifier_get_fd(&vdev->intx.unmask),
+                               &err)) {
         error_propagate(errp, err);
         goto fail_vfio;
     }
@@ -165,12 +162,12 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     return;
 
 fail_vfio:
-    irqfd.flags = KVM_IRQFD_FLAG_DEASSIGN;
-    kvm_vm_ioctl(kvm_state, KVM_IRQFD, &irqfd);
+    kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
+                                          vdev->intx.route.irq);
 fail_irqfd:
     event_notifier_cleanup(&vdev->intx.unmask);
 fail:
-    qemu_set_fd_handler(irqfd.fd, vfio_intx_interrupt, NULL, vdev);
+    qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
     vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 #endif
 }
@@ -178,12 +175,6 @@ fail:
 static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
 {
 #ifdef CONFIG_KVM
-    struct kvm_irqfd irqfd = {
-        .fd = event_notifier_get_fd(&vdev->intx.interrupt),
-        .gsi = vdev->intx.route.irq,
-        .flags = KVM_IRQFD_FLAG_DEASSIGN,
-    };
-
     if (!vdev->intx.kvm_accel) {
         return;
     }
@@ -197,7 +188,8 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
     pci_irq_deassert(&vdev->pdev);
 
     /* Tell KVM to stop listening for an INTx irqfd */
-    if (kvm_vm_ioctl(kvm_state, KVM_IRQFD, &irqfd)) {
+    if (kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
+                                              vdev->intx.route.irq)) {
         error_report("vfio: Error: Failed to disable INTx irqfd: %m");
     }
 
@@ -205,7 +197,8 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
     event_notifier_cleanup(&vdev->intx.unmask);
 
     /* QEMU starts listening for interrupt events. */
-    qemu_set_fd_handler(irqfd.fd, vfio_intx_interrupt, NULL, vdev);
+    qemu_set_fd_handler(event_notifier_get_fd(&vdev->intx.interrupt),
+                        vfio_intx_interrupt, NULL, vdev);
 
     vdev->intx.kvm_accel = false;
 
-- 
2.26.2



