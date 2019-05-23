Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A47C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:46:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5310220881
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5310220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36663 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTo2p-0003Xj-In
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:46:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hTo1a-0002op-Ie
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hTo1Y-0005sN-RR
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:44:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hTo1Y-0005ab-Fg
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:44:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14BF1300415C;
	Thu, 23 May 2019 13:44:34 +0000 (UTC)
Received: from localhost (ovpn-116-196.ams2.redhat.com [10.36.116.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9CFE41001E80;
	Thu, 23 May 2019 13:44:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Date: Thu, 23 May 2019 14:44:08 +0100
Message-Id: <20190523134409.18673-3-stefanha@redhat.com>
In-Reply-To: <20190523134409.18673-1-stefanha@redhat.com>
References: <20190523134409.18673-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 23 May 2019 13:44:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v2 2/3] scsi: add scsi_bus_dma_restart()
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

By default scsi-bus.c registers vm change state handlers for SCSIDevice
instances and restarts DMA when guest execution is resumed.

Unfortunately virtio-scsi with iothreads has a special ordering
requirement that the core virtio code's vm change state handler runs
before scsi-bus.c's vm change state handler.

This patch allows SCSI busses to disable the default vm change state
handler for DMA restart.  The new scsi_bus_dma_restart() API allows them
to manually restart DMA at a time of their choice.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/scsi/scsi.h |  5 +++++
 hw/scsi/scsi-bus.c     | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index acef25faa4..e9cc563daa 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -120,6 +120,10 @@ struct SCSIReqOps {
 struct SCSIBusInfo {
     int tcq;
     int max_channel, max_target, max_lun;
+
+    /* Will the bus call scsi_bus_dma_restart() itself? */
+    bool custom_dma_restart;
+
     int (*parse_cdb)(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                      void *hba_private);
     void (*transfer_data)(SCSIRequest *req, uint32_t arg);
@@ -160,6 +164,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, B=
lockBackend *blk,
                                       const char *serial, Error **errp);
 void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
 void scsi_legacy_handle_cmdline(void);
+void scsi_bus_dma_restart(SCSIBus *bus);
=20
 SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
                             uint32_t tag, uint32_t lun, void *hba_privat=
e);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index c480553083..d2c5a1652b 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -134,6 +134,27 @@ void scsi_req_retry(SCSIRequest *req)
     req->retry =3D true;
 }
=20
+static void scsi_device_dma_restart(SCSIDevice *dev)
+{
+    if (!dev->bh) {
+        AioContext *ctx =3D blk_get_aio_context(dev->conf.blk);
+        dev->bh =3D aio_bh_new(ctx, scsi_dma_restart_bh, dev);
+        qemu_bh_schedule(dev->bh);
+    }
+}
+
+void scsi_bus_dma_restart(SCSIBus *bus)
+{
+    BusChild *kid;
+
+    QTAILQ_FOREACH(kid, &bus->qbus.children, sibling) {
+        DeviceState *qdev =3D kid->child;
+        SCSIDevice *dev =3D SCSI_DEVICE(qdev);
+
+        scsi_device_dma_restart(dev);
+    }
+}
+
 static void scsi_dma_restart_cb(void *opaque, int running, RunState stat=
e)
 {
     SCSIDevice *s =3D opaque;
@@ -141,11 +162,8 @@ static void scsi_dma_restart_cb(void *opaque, int ru=
nning, RunState state)
     if (!running) {
         return;
     }
-    if (!s->bh) {
-        AioContext *ctx =3D blk_get_aio_context(s->conf.blk);
-        s->bh =3D aio_bh_new(ctx, scsi_dma_restart_bh, s);
-        qemu_bh_schedule(s->bh);
-    }
+
+    scsi_device_dma_restart(s);
 }
=20
 static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
@@ -206,8 +224,13 @@ static void scsi_qdev_realize(DeviceState *qdev, Err=
or **errp)
         error_propagate(errp, local_err);
         return;
     }
-    dev->vmsentry =3D qemu_add_vm_change_state_handler(scsi_dma_restart_=
cb,
-                                                     dev);
+
+    if (bus->info->custom_dma_restart) {
+        dev->vmsentry =3D NULL;
+    } else {
+        dev->vmsentry =3D qemu_add_vm_change_state_handler(scsi_dma_rest=
art_cb,
+                                                         dev);
+    }
 }
=20
 static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
--=20
2.21.0


