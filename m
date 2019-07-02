Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9C5C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946392184B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946392184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiNbx-0004YR-SV
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 14:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59629)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hiMQK-0008Fg-Np
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hiMQG-0003Qi-Ps
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:18:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hiMQG-0003OJ-6A
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:18:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C0E30308FC20;
 Tue,  2 Jul 2019 17:18:25 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-95.ams2.redhat.com [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 116511001B01;
 Tue,  2 Jul 2019 17:18:19 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 19:18:16 +0200
Message-Id: <20190702171816.11939-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 02 Jul 2019 17:18:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] vfio/pci: Trace vfio_set_irq_signaling()
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Report an error in case we fail to set a trigger action
on any VFIO_PCI_MSIX_IRQ_INDEX subindex. This might be
useful in debugging a device that is not working properly.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ce3fe96efe..d7a4e1875c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -551,9 +551,12 @@ static void vfio_msix_vector_release(PCIDevice *pdev=
, unsigned int nr)
      */
     if (vector->virq >=3D 0) {
         int32_t fd =3D event_notifier_get_fd(&vector->interrupt);
+        Error *err =3D NULL;
=20
-        vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,=
 nr,
-                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, NULL);
+        if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_IN=
DEX, nr,
+                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err=
)) {
+            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name)=
;
+        }
     }
 }
=20
--=20
2.20.1


