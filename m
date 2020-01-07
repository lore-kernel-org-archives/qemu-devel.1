Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB2CC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9141208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlivjNvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9141208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iosFw-0004xF-8D
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorla-0008R9-7k
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorlY-0005io-Gi
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27865
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorlY-0005iZ-C9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z13KJ0vWOirv0bpEydzTz+1MhtfDLJdvDbH6dIjPp+0=;
 b=BlivjNvy7Iiw1UVlpFcpEFC8M8GHmIolwBZQI96M0yCb2TAVx9ulI/7eetsU+MMt/nPFmW
 uguLnDV2lCQ4Bqw/BBgshwD4vmxQGO4g6839UjWNnkGiHjjtUnf+Y2hxLoiiwr2UBC4hEB
 sM1DVOwSKomvCfHMEHiSAvh8qM2VdZQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-nT-DiKBjOpiCnDeTOzZi1g-1; Tue, 07 Jan 2020 11:31:33 -0500
Received: by mail-qv1-f71.google.com with SMTP id z12so238046qvk.14
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fzSk4nDQJOb6ecY+TCyTxG5Cc5pBBrBejXKsi0VExAI=;
 b=otjW9c4QAF2SqxocT1Zg1p8Jv5ICuwxMdBepVOxpUsoCJMEQpD5AXXpoiwNNcBnTDj
 yhmnQbbHh88dDF6Lv42gFXUkybQhQhlRSwio4KWC6HQWHT+xoEIdT3mrRezpBVO9Ufy7
 voTRe4kogciyCVPbMPaCrsgyNf09lB+cifTY7UvctwCZoEcl0+h9H9xdiSZOLCB5sUZx
 OTLHbAms/2rRaiTRc/fl0UxX96iWwK8PqQ5x+WYAN7B2WKH18qlrZSF5y6N8OGL4AvTR
 sCHod2UPIQKlQ50OSKVDh160NdCOp4xn+NRQF1NAFy1kn8to2qEvv00iNPK44b1zOnC4
 qXHw==
X-Gm-Message-State: APjAAAVNB3mOAVFNs/eKriqy911MhJUpA6BeE214RUfl1skQhAhs0kWn
 qhoije0VZesRfZ9v1AHlstdP/TkLGaj01wA/Jb4ykB7Q2KP8hS0i1DWXG/c3vA/wX+FMmMNHQMh
 QIeiVoFRtpr3Ur2g=
X-Received: by 2002:a05:620a:15e8:: with SMTP id
 p8mr82440qkm.469.1578414693057; 
 Tue, 07 Jan 2020 08:31:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPeGGbQGhvmApR7G5VYRy2GDQpa9+q1vrpyNXd55Yy1rHHtiYohyfiIk9blFGxvHdZZzngow==
X-Received: by 2002:a05:620a:15e8:: with SMTP id
 p8mr82409qkm.469.1578414692754; 
 Tue, 07 Jan 2020 08:31:32 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id e3sm105569qtj.30.2020.01.07.08.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:31:31 -0800 (PST)
Date: Tue, 7 Jan 2020 11:31:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 26/32] virtio: make seg_max virtqueue size dependent
Message-ID: <20200107162850.411448-27-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: nT-DiKBjOpiCnDeTOzZi1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Denis Plotnikov <dplotnikov@virtuozzo.com>

Before the patch, seg_max parameter was immutable and hardcoded
to 126 (128 - 2) without respect to queue size. This has two negative effec=
ts:

1. when queue size is < 128, we have Virtio 1.1 specfication violation:
   (2.6.5.3.1 Driver Requirements) seq_max must be <=3D queue_size.
   This violation affects the old Linux guests (ver < 4.14). These guests
   crash on these queue_size setups.

2. when queue_size > 128, as was pointed out by Denis Lunev <den@virtuozzo.=
com>,
   seg_max restrics guest's block request length which affects guests'
   performance making them issues more block request than needed.
   https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html

To mitigate this two effects, the patch adds the property adjusting seg_max
to queue size automaticaly. Since seg_max is a guest visible parameter,
the property is machine type managable and allows to choose between
old (seg_max =3D 126 always) and new (seg_max =3D queue_size - 2) behaviors=
.

Not to change the behavior of the older VMs, prevent setting the default
seg_max_adjust value for older machine types.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-Id: <20191220140905.1718-2-dplotnikov@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-blk.h  |  1 +
 include/hw/virtio/virtio-scsi.h |  1 +
 hw/block/virtio-blk.c           |  9 ++++++++-
 hw/core/machine.c               |  3 +++
 hw/scsi/vhost-scsi.c            |  2 ++
 hw/scsi/virtio-scsi.c           | 10 +++++++++-
 6 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.=
h
index 9c19f5b634..1e62f869b2 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -38,6 +38,7 @@ struct VirtIOBlkConf
     uint32_t request_merging;
     uint16_t num_queues;
     uint16_t queue_size;
+    bool seg_max_adjust;
     uint32_t max_discard_sectors;
     uint32_t max_write_zeroes_sectors;
     bool x_enable_wce_if_config_wce;
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scs=
i.h
index 122f7c4b6f..24e768909d 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -48,6 +48,7 @@ typedef struct virtio_scsi_config VirtIOSCSIConfig;
 struct VirtIOSCSIConf {
     uint32_t num_queues;
     uint32_t virtqueue_size;
+    bool seg_max_adjust;
     uint32_t max_sectors;
     uint32_t cmd_per_lun;
 #ifdef CONFIG_VHOST_SCSI
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b12157b5eb..9bee514c4e 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -913,7 +913,8 @@ static void virtio_blk_update_config(VirtIODevice *vdev=
, uint8_t *config)
     blk_get_geometry(s->blk, &capacity);
     memset(&blkcfg, 0, sizeof(blkcfg));
     virtio_stq_p(vdev, &blkcfg.capacity, capacity);
-    virtio_stl_p(vdev, &blkcfg.seg_max, 128 - 2);
+    virtio_stl_p(vdev, &blkcfg.seg_max,
+                 s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128 - 2=
);
     virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
     virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
     virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);
@@ -1138,6 +1139,11 @@ static void virtio_blk_device_realize(DeviceState *d=
ev, Error **errp)
         error_setg(errp, "num-queues property must be larger than 0");
         return;
     }
+    if (conf->queue_size <=3D 2) {
+        error_setg(errp, "invalid queue-size property (%" PRIu16 "), "
+                   "must be > 2", conf->queue_size);
+        return;
+    }
     if (!is_power_of_2(conf->queue_size) ||
         conf->queue_size > VIRTQUEUE_MAX_SIZE) {
         error_setg(errp, "invalid queue-size property (%" PRIu16 "), "
@@ -1267,6 +1273,7 @@ static Property virtio_blk_properties[] =3D {
                     true),
     DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
     DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
+    DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjust, t=
rue),
     DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD=
,
                      IOThread *),
     DEFINE_PROP_BIT64("discard", VirtIOBlock, host_features,
diff --git a/hw/core/machine.c b/hw/core/machine.c
index f5e2b32b3b..ec2e3fcb61 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -29,6 +29,9 @@
=20
 GlobalProperty hw_compat_4_2[] =3D {
     { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
+    { "virtio-blk-device", "seg-max-adjust", "off"},
+    { "virtio-scsi-device", "seg_max_adjust", "off"},
+    { "vhost-blk-device", "seg_max_adjust", "off"},
 };
 const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
=20
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index c693fc748a..26f710d3ec 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -275,6 +275,8 @@ static Property vhost_scsi_properties[] =3D {
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1)=
,
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_=
size,
                        128),
+    DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSICommon, conf.seg_max_adju=
st,
+                      true),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
                        0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, =
128),
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index f080545f48..4bc73a370e 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -659,7 +659,8 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
     VirtIOSCSICommon *s =3D VIRTIO_SCSI_COMMON(vdev);
=20
     virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
-    virtio_stl_p(vdev, &scsiconf->seg_max, 128 - 2);
+    virtio_stl_p(vdev, &scsiconf->seg_max,
+                 s->conf.seg_max_adjust ? s->conf.virtqueue_size - 2 : 128=
 - 2);
     virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_sectors);
     virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_lun);
     virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIOSCSIEvent)=
);
@@ -898,6 +899,11 @@ void virtio_scsi_common_realize(DeviceState *dev,
         virtio_cleanup(vdev);
         return;
     }
+    if (s->conf.virtqueue_size <=3D 2) {
+        error_setg(errp, "invalid virtqueue_size property (=3D %" PRIu32 "=
), "
+                   "must be > 2", s->conf.virtqueue_size);
+        return;
+    }
     s->cmd_vqs =3D g_new0(VirtQueue *, s->conf.num_queues);
     s->sense_size =3D VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
     s->cdb_size =3D VIRTIO_SCSI_CDB_DEFAULT_SIZE;
@@ -954,6 +960,8 @@ static Property virtio_scsi_properties[] =3D {
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queue=
s, 1),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
                                          parent_obj.conf.virtqueue_size, 1=
28),
+    DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
+                      parent_obj.conf.seg_max_adjust, true),
     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_sect=
ors,
                                                   0xFFFF),
     DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSI, parent_obj.conf.cmd_per_=
lun,
--=20
MST


