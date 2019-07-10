Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E830CC74A26
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 14:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D592064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 14:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D592064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlDOx-0003f5-Sz
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 10:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41356)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hlDMz-0002a6-Te
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 10:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hlDMy-0003P8-AU
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 10:14:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37865)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hlDMy-0003NE-2R
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 10:14:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31C77307D911;
 Wed, 10 Jul 2019 14:14:50 +0000 (UTC)
Received: from localhost (ovpn-112-49.ams2.redhat.com [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13D631A92A;
 Wed, 10 Jul 2019 14:14:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Date: Wed, 10 Jul 2019 16:14:40 +0200
Message-Id: <20190710141440.27635-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 10 Jul 2019 14:14:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] virtio-balloon: fix QEMU 4.0 config size
 migration incompatibility
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
Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtio-balloon config size changed in QEMU 4.0 even for existing
machine types.  Migration from QEMU 3.1 to 4.0 can fail in some
circumstances with the following error:

  qemu-system-x86_64: get_pci_config_device: Bad config data: i=3D0x10 re=
ad: a1 device: 1 cmask: ff wmask: c0 w1cmask:0

This happens because the virtio-balloon config size affects the VIRTIO
Legacy I/O Memory PCI BAR size.

Introduce a qdev property called "qemu-4-0-config-size" and enable it
only for the QEMU 4.0 machine types.  This way <4.0 machine types use
the old size, 4.0 uses the larger size, and >4.0 machine types use the
appropriate size depending on enabled virtio-balloon features.

Live migration to and from old QEMUs to QEMU 4.1 works again as long as
a versioned machine type is specified (do not use just "pc"!).

Originally-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/virtio/virtio-balloon.h |  2 ++
 hw/core/machine.c                  |  2 ++
 hw/virtio/virtio-balloon.c         | 28 +++++++++++++++++++++++++---
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virti=
o-balloon.h
index 1afafb12f6..5a99293a45 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -71,6 +71,8 @@ typedef struct VirtIOBalloon {
     int64_t stats_poll_interval;
     uint32_t host_features;
     PartiallyBalloonedPage *pbp;
+
+    bool qemu_4_0_config_size;
 } VirtIOBalloon;
=20
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2be19ec0cd..c4ead16010 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,6 +34,7 @@ GlobalProperty hw_compat_4_0[] =3D {
     { "virtio-vga",     "edid", "false" },
     { "virtio-gpu-pci", "edid", "false" },
     { "virtio-device", "use-started", "false" },
+    { "virtio-balloon-device", "qemu-4-0-config-size", "true" },
 };
 const size_t hw_compat_4_0_len =3D G_N_ELEMENTS(hw_compat_4_0);
=20
@@ -49,6 +50,7 @@ GlobalProperty hw_compat_3_1[] =3D {
     { "usb-tablet", "serial", "42" },
     { "virtio-blk-device", "discard", "false" },
     { "virtio-blk-device", "write-zeroes", "false" },
+    { "virtio-balloon-device", "qemu-4-0-config-size", "false" },
 };
 const size_t hw_compat_3_1_len =3D G_N_ELEMENTS(hw_compat_3_1);
=20
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 11fad86d64..e85d1c0d5c 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -615,6 +615,22 @@ virtio_balloon_free_page_report_notify(NotifierWithR=
eturn *n, void *data)
     return 0;
 }
=20
+static size_t virtio_balloon_config_size(VirtIOBalloon *s)
+{
+    uint64_t features =3D s->host_features;
+
+    if (s->qemu_4_0_config_size) {
+        return sizeof(struct virtio_balloon_config);
+    }
+    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
+        return sizeof(struct virtio_balloon_config);
+    }
+    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        return offsetof(struct virtio_balloon_config, poison_val);
+    }
+    return offsetof(struct virtio_balloon_config, free_page_report_cmd_i=
d);
+}
+
 static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *confi=
g_data)
 {
     VirtIOBalloon *dev =3D VIRTIO_BALLOON(vdev);
@@ -635,7 +651,7 @@ static void virtio_balloon_get_config(VirtIODevice *v=
dev, uint8_t *config_data)
     }
=20
     trace_virtio_balloon_get_config(config.num_pages, config.actual);
-    memcpy(config_data, &config, sizeof(struct virtio_balloon_config));
+    memcpy(config_data, &config, virtio_balloon_config_size(dev));
 }
=20
 static int build_dimm_list(Object *obj, void *opaque)
@@ -679,7 +695,7 @@ static void virtio_balloon_set_config(VirtIODevice *v=
dev,
     uint32_t oldactual =3D dev->actual;
     ram_addr_t vm_ram_size =3D get_current_ram_size();
=20
-    memcpy(&config, config_data, sizeof(struct virtio_balloon_config));
+    memcpy(&config, config_data, virtio_balloon_config_size(dev));
     dev->actual =3D le32_to_cpu(config.actual);
     if (dev->actual !=3D oldactual) {
         qapi_event_send_balloon_change(vm_ram_size -
@@ -766,7 +782,7 @@ static void virtio_balloon_device_realize(DeviceState=
 *dev, Error **errp)
     int ret;
=20
     virtio_init(vdev, "virtio-balloon", VIRTIO_ID_BALLOON,
-                sizeof(struct virtio_balloon_config));
+                virtio_balloon_config_size(s));
=20
     ret =3D qemu_add_balloon_handler(virtio_balloon_to_target,
                                    virtio_balloon_stat, s);
@@ -897,6 +913,12 @@ static Property virtio_balloon_properties[] =3D {
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
+    /* QEMU 4.0 accidentally changed the config size even when free-page=
-hint
+     * is disabled, resulting in QEMU 3.1 migration incompatibility.  Th=
is
+     * property retains this quirk for QEMU 4.1 machine types.
+     */
+    DEFINE_PROP_BOOL("qemu-4-0-config-size", VirtIOBalloon,
+                     qemu_4_0_config_size, false),
     DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
                      IOThread *),
     DEFINE_PROP_END_OF_LIST(),
--=20
2.21.0


