Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1069EC33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D415B20730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsJiBUu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D415B20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is2tH-0007ET-1w
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 06:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1is2rh-0005YZ-R6
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1is2re-0008J8-2C
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:59:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33984
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1is2rd-0008I6-TX
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579172340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1croXUzum/qSSRlM+s0uaE6Fw2t2Z7a0QNUg85ZvAyo=;
 b=TsJiBUu60MNvMiB1gmupsHWMAV9swacEpF/pvsTpvUF4OKpDxTy54+8befS8w855Y5jS8o
 1bcJ0FnI69JTvHSb+rIjXU1mRk80seOoRBTrIoA8WbFNwIzVn9FZAsMBW6CqR4ot7y0prC
 478EVG2VKew8ySWSdryQ4IRxhvIZJU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-oDPQkXAyO1eit8fxX9VFkg-1; Thu, 16 Jan 2020 05:58:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B0238010C0;
 Thu, 16 Jan 2020 10:58:56 +0000 (UTC)
Received: from localhost (ovpn-117-207.ams2.redhat.com [10.36.117.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84A4F5D9C9;
 Thu, 16 Jan 2020 10:58:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] virtio-scsi: introduce a constant for fixed virtqueues
Date: Thu, 16 Jan 2020 10:58:38 +0000
Message-Id: <20200116105842.271179-2-stefanha@redhat.com>
In-Reply-To: <20200116105842.271179-1-stefanha@redhat.com>
References: <20200116105842.271179-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: oDPQkXAyO1eit8fxX9VFkg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The event and control virtqueues are always present, regardless of the
multi-queue configuration.  Define a constant so that virtqueue number
calculations are easier to read.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/vhost-user-scsi.c       | 2 +-
 hw/scsi/virtio-scsi.c           | 7 ++++---
 include/hw/virtio/virtio-scsi.h | 3 +++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 23f972df59..eb37733bd0 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -115,7 +115,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, E=
rror **errp)
         goto free_virtio;
     }
=20
-    vsc->dev.nvqs =3D 2 + vs->conf.num_queues;
+    vsc->dev.nvqs =3D VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
     vsc->dev.vqs =3D g_new0(struct vhost_virtqueue, vsc->dev.nvqs);
     vsc->dev.vq_index =3D 0;
     vsc->dev.backend_features =3D 0;
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 4bc73a370e..5622dd54e5 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -191,7 +191,7 @@ static void virtio_scsi_save_request(QEMUFile *f, SCSIR=
equest *sreq)
     VirtIOSCSIReq *req =3D sreq->hba_private;
     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(req->dev);
     VirtIODevice *vdev =3D VIRTIO_DEVICE(req->dev);
-    uint32_t n =3D virtio_get_queue_index(req->vq) - 2;
+    uint32_t n =3D virtio_get_queue_index(req->vq) - VIRTIO_SCSI_VQ_NUM_FI=
XED;
=20
     assert(n < vs->conf.num_queues);
     qemu_put_be32s(f, &n);
@@ -892,10 +892,11 @@ void virtio_scsi_common_realize(DeviceState *dev,
                 sizeof(VirtIOSCSIConfig));
=20
     if (s->conf.num_queues =3D=3D 0 ||
-            s->conf.num_queues > VIRTIO_QUEUE_MAX - 2) {
+            s->conf.num_queues > VIRTIO_QUEUE_MAX - VIRTIO_SCSI_VQ_NUM_FIX=
ED) {
         error_setg(errp, "Invalid number of queues (=3D %" PRIu32 "), "
                          "must be a positive integer less than %d.",
-                   s->conf.num_queues, VIRTIO_QUEUE_MAX - 2);
+                   s->conf.num_queues,
+                   VIRTIO_QUEUE_MAX - VIRTIO_SCSI_VQ_NUM_FIXED);
         virtio_cleanup(vdev);
         return;
     }
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scs=
i.h
index 24e768909d..9f293bcb80 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -36,6 +36,9 @@
 #define VIRTIO_SCSI_MAX_TARGET  255
 #define VIRTIO_SCSI_MAX_LUN     16383
=20
+/* Number of virtqueues that are always present */
+#define VIRTIO_SCSI_VQ_NUM_FIXED    2
+
 typedef struct virtio_scsi_cmd_req VirtIOSCSICmdReq;
 typedef struct virtio_scsi_cmd_resp VirtIOSCSICmdResp;
 typedef struct virtio_scsi_ctrl_tmf_req VirtIOSCSICtrlTMFReq;
--=20
2.24.1


