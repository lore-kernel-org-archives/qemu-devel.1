Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF60C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33A32133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33A32133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36879 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToEI-0003sd-S9
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:57:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hTo1k-0002vl-KA
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hTo1i-00068g-Ft
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:45:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hTo1i-0005eL-8h
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:44:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AB84C004BEB;
	Thu, 23 May 2019 13:44:40 +0000 (UTC)
Received: from localhost (ovpn-116-196.ams2.redhat.com [10.36.116.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 76E185D707;
	Thu, 23 May 2019 13:44:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Date: Thu, 23 May 2019 14:44:09 +0100
Message-Id: <20190523134409.18673-4-stefanha@redhat.com>
In-Reply-To: <20190523134409.18673-1-stefanha@redhat.com>
References: <20190523134409.18673-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Thu, 23 May 2019 13:44:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v2 3/3] virtio-scsi: fix iothread deadlock on
 'cont'
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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
between vm change state handlers.  When two layers of code both use vm
change state handlers, we don't control which handler runs first.

virtio-scsi with iothreads hits a deadlock when a failed SCSI command is
restarted and completes before the iothread is re-initialized.

This patch makes sure that DMA restart happens after the iothread has
been started again.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/virtio-scsi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 839f120256..236a0ee873 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -846,12 +846,28 @@ static void virtio_scsi_hotunplug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
     qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
 }
=20
+static void virtio_scsi_vmstate_change(VirtIODevice *vdev, bool running)
+{
+    VirtIOSCSI *s =3D VIRTIO_SCSI(vdev);
+
+    if (running) {
+        scsi_bus_dma_restart(&s->bus);
+    }
+}
+
 static struct SCSIBusInfo virtio_scsi_scsi_info =3D {
     .tcq =3D true,
     .max_channel =3D VIRTIO_SCSI_MAX_CHANNEL,
     .max_target =3D VIRTIO_SCSI_MAX_TARGET,
     .max_lun =3D VIRTIO_SCSI_MAX_LUN,
=20
+    /* We call scsi_bus_dma_restart() ourselves to control the ordering =
between
+     * ->start_ioeventfd() and DMA restart.  Do it in
+     * virtio_scsi_vmstate_change(), which is called by the core virtio =
code
+     * after ->start_ioeventfd().
+     */
+    .custom_dma_restart =3D true,
+
     .complete =3D virtio_scsi_command_complete,
     .cancel =3D virtio_scsi_request_cancelled,
     .change =3D virtio_scsi_change,
@@ -986,6 +1002,7 @@ static void virtio_scsi_class_init(ObjectClass *klas=
s, void *data)
     vdc->reset =3D virtio_scsi_reset;
     vdc->start_ioeventfd =3D virtio_scsi_dataplane_start;
     vdc->stop_ioeventfd =3D virtio_scsi_dataplane_stop;
+    vdc->vmstate_change =3D virtio_scsi_vmstate_change;
     hc->plug =3D virtio_scsi_hotplug;
     hc->unplug =3D virtio_scsi_hotunplug;
 }
--=20
2.21.0


