Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64495C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 17:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0972D2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 17:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0972D2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51934 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he1Fr-0004bG-KJ
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 13:53:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34919)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1he19O-0007IG-Ou
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1he10I-0004rK-1Z
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:37:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44948)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1he10H-0004qM-RC
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:37:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EFD1B90C77;
 Thu, 20 Jun 2019 17:37:40 +0000 (UTC)
Received: from localhost (ovpn-116-108.ams2.redhat.com [10.36.116.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83E6B5C1A1;
 Thu, 20 Jun 2019 17:37:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 20 Jun 2019 18:37:09 +0100
Message-Id: <20190620173709.14753-4-stefanha@redhat.com>
In-Reply-To: <20190620173709.14753-1-stefanha@redhat.com>
References: <20190620173709.14753-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 20 Jun 2019 17:37:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 3/3] virtio-scsi: restart DMA after iothread
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the 'cont' command resumes guest execution the vm change state
handlers are invoked.  Unfortunately there is no explicit ordering
between classic qemu_add_vm_change_state_handler() callbacks.  When two
layers of code both use vm change state handlers, we don't control which
handler runs first.

virtio-scsi with iothreads hits a deadlock when a failed SCSI command is
restarted and completes before the iothread is re-initialized.

This patch uses the new qdev_add_vm_change_state_handler() API to
guarantee that virtio-scsi's virtio change state handler executes before
the SCSI bus children.  This way DMA is restarted after the iothread has
re-initialized.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/scsi-bus.c | 4 ++--
 hw/virtio/virtio.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 196136a307..fdc3a0e4e0 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -207,8 +207,8 @@ static void scsi_qdev_realize(DeviceState *qdev, Erro=
r **errp)
         error_propagate(errp, local_err);
         return;
     }
-    dev->vmsentry =3D qemu_add_vm_change_state_handler(scsi_dma_restart_=
cb,
-                                                     dev);
+    dev->vmsentry =3D qdev_add_vm_change_state_handler(DEVICE(dev),
+            scsi_dma_restart_cb, dev);
 }
=20
 static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e1e90fcfd6..e42e6710d2 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2354,8 +2354,8 @@ void virtio_init(VirtIODevice *vdev, const char *na=
me,
     } else {
         vdev->config =3D NULL;
     }
-    vdev->vmstate =3D qemu_add_vm_change_state_handler(virtio_vmstate_ch=
ange,
-                                                     vdev);
+    vdev->vmstate =3D qdev_add_vm_change_state_handler(DEVICE(vdev),
+            virtio_vmstate_change, vdev);
     vdev->device_endian =3D virtio_default_endian();
     vdev->use_guest_notifier_mask =3D true;
 }
--=20
2.21.0


