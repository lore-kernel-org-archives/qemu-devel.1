Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1C3C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A30223B6F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A30223B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXoj8-0004Od-Js
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:18:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoVs-0001Oj-5e
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoVo-000121-AZ
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:04:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoVT-0000FP-7u; Mon, 03 Jun 2019 11:04:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA6E844BC6;
	Mon,  3 Jun 2019 15:03:58 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B0E9F67279;
	Mon,  3 Jun 2019 15:03:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:20 +0200
Message-Id: <20190603150233.6614-16-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
References: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 03 Jun 2019 15:04:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/28] scsi-disk: Use qdev_prop_drive_iothread
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes use of qdev_prop_drive_iothread for scsi-disk so that the
disk can be attached to a node that is already in the target AioContext.
We need to check that the HBA actually supports iothreads, otherwise
scsi-disk must make sure that the node is already in the main
AioContext.

This changes the error message for conflicting iothread settings.
Previously, virtio-scsi produced the error message, now it comes from
blk_set_aio_context(). Update a test case accordingly.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/scsi/scsi.h     |  1 +
 hw/scsi/scsi-disk.c        | 22 +++++++++++++++-------
 hw/scsi/virtio-scsi.c      | 15 ++++++++-------
 tests/qemu-iotests/240.out |  2 +-
 4 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index acef25faa4..426566a5c6 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -88,6 +88,7 @@ struct SCSIDevice
     int scsi_version;
     int default_scsi_version;
     bool needs_vpd_bl_emulation;
+    bool hba_supports_iothread;
 };
=20
 extern const VMStateDescription vmstate_scsi_device;
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 91c5a8b1ac..7b89ac798b 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2336,6 +2336,13 @@ static void scsi_realize(SCSIDevice *dev, Error **=
errp)
         return;
     }
=20
+    if (blk_get_aio_context(s->qdev.conf.blk) !=3D qemu_get_aio_context(=
) &&
+        !s->qdev.hba_supports_iothread)
+    {
+        error_setg(errp, "HBA does not support iothreads");
+        return;
+    }
+
     if (dev->type =3D=3D TYPE_DISK) {
         if (!blkconf_geometry(&dev->conf, NULL, 65535, 255, 255, errp)) =
{
             return;
@@ -2929,13 +2936,14 @@ static const TypeInfo scsi_disk_base_info =3D {
     .abstract      =3D true,
 };
=20
-#define DEFINE_SCSI_DISK_PROPERTIES()                                \
-    DEFINE_BLOCK_PROPERTIES(SCSIDiskState, qdev.conf),               \
-    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
-    DEFINE_PROP_STRING("ver", SCSIDiskState, version),               \
-    DEFINE_PROP_STRING("serial", SCSIDiskState, serial),             \
-    DEFINE_PROP_STRING("vendor", SCSIDiskState, vendor),             \
-    DEFINE_PROP_STRING("product", SCSIDiskState, product),           \
+#define DEFINE_SCSI_DISK_PROPERTIES()                                   =
\
+    DEFINE_PROP_DRIVE_IOTHREAD("drive", SCSIDiskState, qdev.conf.blk),  =
\
+    DEFINE_BLOCK_PROPERTIES_BASE(SCSIDiskState, qdev.conf),             =
\
+    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),            =
\
+    DEFINE_PROP_STRING("ver", SCSIDiskState, version),                  =
\
+    DEFINE_PROP_STRING("serial", SCSIDiskState, serial),                =
\
+    DEFINE_PROP_STRING("vendor", SCSIDiskState, vendor),                =
\
+    DEFINE_PROP_STRING("product", SCSIDiskState, product),              =
\
     DEFINE_PROP_STRING("device_id", SCSIDiskState, device_id)
=20
=20
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 01c2b85f90..2994f0738f 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -789,6 +789,13 @@ static void virtio_scsi_change(SCSIBus *bus, SCSIDev=
ice *dev, SCSISense sense)
     }
 }
=20
+static void virtio_scsi_pre_hotplug(HotplugHandler *hotplug_dev,
+                                    DeviceState *dev, Error **errp)
+{
+    SCSIDevice *sd =3D SCSI_DEVICE(dev);
+    sd->hba_supports_iothread =3D true;
+}
+
 static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState=
 *dev,
                                 Error **errp)
 {
@@ -798,16 +805,9 @@ static void virtio_scsi_hotplug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
     int ret;
=20
     if (s->ctx && !s->dataplane_fenced) {
-        AioContext *ctx;
         if (blk_op_is_blocked(sd->conf.blk, BLOCK_OP_TYPE_DATAPLANE, err=
p)) {
             return;
         }
-        ctx =3D blk_get_aio_context(sd->conf.blk);
-        if (ctx !=3D s->ctx && ctx !=3D qemu_get_aio_context()) {
-            error_setg(errp, "Cannot attach a blockdev that is using "
-                       "a different iothread");
-            return;
-        }
         virtio_scsi_acquire(s);
         ret =3D blk_set_aio_context(sd->conf.blk, s->ctx, errp);
         virtio_scsi_release(s);
@@ -990,6 +990,7 @@ static void virtio_scsi_class_init(ObjectClass *klass=
, void *data)
     vdc->reset =3D virtio_scsi_reset;
     vdc->start_ioeventfd =3D virtio_scsi_dataplane_start;
     vdc->stop_ioeventfd =3D virtio_scsi_dataplane_stop;
+    hc->pre_plug =3D virtio_scsi_pre_hotplug;
     hc->plug =3D virtio_scsi_hotplug;
     hc->unplug =3D virtio_scsi_hotunplug;
 }
diff --git a/tests/qemu-iotests/240.out b/tests/qemu-iotests/240.out
index 84e0a43ce5..d00df50297 100644
--- a/tests/qemu-iotests/240.out
+++ b/tests/qemu-iotests/240.out
@@ -43,7 +43,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"error": {"class": "GenericError", "desc": "Cannot attach a blockdev th=
at is using a different iothread"}}
+{"error": {"class": "GenericError", "desc": "Cannot change iothread of a=
ctive block backend"}}
 {"return": {}}
 {"return": {}}
 {"return": {}}
--=20
2.20.1


