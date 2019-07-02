Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CBBC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 22:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B242190E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 22:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B242190E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiRRL-0003eH-3T
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 18:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57438)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hiRKz-0000GK-Sr
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hiRKx-0004ZP-PK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:33:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hiRKu-0004NG-0Y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:33:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ACFD9C049589;
 Tue,  2 Jul 2019 22:33:12 +0000 (UTC)
Received: from gimli.home (ovpn-116-83.phx2.redhat.com [10.3.116.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4E36411B;
 Tue,  2 Jul 2019 22:33:07 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 02 Jul 2019 16:33:07 -0600
Message-ID: <156210678718.19884.1742619809608268205.stgit@gimli.home>
In-Reply-To: <156210666074.19884.7711861336532593819.stgit@gimli.home>
References: <156210666074.19884.7711861336532593819.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 02 Jul 2019 22:33:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/2] vfio/pci: Trace vfio_set_irq_signaling()
 failure in vfio_msix_vector_release()
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
Cc: eric.auger@redhat.com, farosas@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Report an error in case we fail to set a trigger action
on any VFIO_PCI_MSIX_IRQ_INDEX subindex. This might be
useful in debugging a device that is not working properly.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Coverity (CID 1402196)
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ce3fe96efe2c..d7a4e1875c05 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -551,9 +551,12 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
      */
     if (vector->virq >= 0) {
         int32_t fd = event_notifier_get_fd(&vector->interrupt);
+        Error *err = NULL;
 
-        vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
-                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, NULL);
+        if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
+                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+        }
     }
 }
 


