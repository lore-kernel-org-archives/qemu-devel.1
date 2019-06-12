Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260FBC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7F5207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zcIgjHa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7F5207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58162 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hazqK-0007sd-4j
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 05:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44153)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hazmv-0005Bh-Ov
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hazmu-0000pK-Dh
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:43:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hazmr-0000no-De; Wed, 12 Jun 2019 05:43:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C9Y5pE185455;
 Wed, 12 Jun 2019 09:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=LGrComxyqN1TLgk8Bo9iKZ5zTEqxz7KVof3cokKzZBY=;
 b=zcIgjHa7ak8wZLBQaEEvg1t0gOV4iL7/QtYNT5PdxQAaJJ6tZU3KjviblcTjw283x1Zj
 ftSK6CvPUP13HMugaf3NrOd0asJh9OXjZzC/v9oEfqpQN7JxwRIOuuJkuHWXeUAw35EC
 ZqtZ/yAlq20enWvEnvFr7d2+9tLdJvmqeCRMAn/7APaGV5fyxIhXUT8GZlZrgch2BhOu
 hooohHe2URHYCVUnCOZCkF+TSwGvEVOWh1VtfVr2U64qdgPvyV5g8h0RpafuyrWYTjOq
 AwlY5anKe+bCCAwCTD589uAVCWZWrghWDHQtJ3WNn8wpc+eYsnG+wDgOEZQe/DDscrP+ Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2t04ettc1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 09:43:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C9gRNi116414;
 Wed, 12 Jun 2019 09:43:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2t0p9rsgps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 09:43:18 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5C9hHdb028834;
 Wed, 12 Jun 2019 09:43:17 GMT
Received: from nexus.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 12 Jun 2019 02:43:17 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
To: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 kevin@koconnor.net
Date: Wed, 12 Jun 2019 12:42:34 +0300
Message-Id: <20190612094237.47462-6-shmuel.eiderman@oracle.com>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20190612094237.47462-1-shmuel.eiderman@oracle.com>
References: <20190612094237.47462-1-shmuel.eiderman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=886
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=930 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120066
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [QEMU] [PATCH 5/8] bootdevice: Gather LCHS from all
 relevant devices
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
Cc: liran.alon@oracle.com, shmuel.eiderman@oracle.com, karl.heubaum@oracle.com,
 arbel.moshe@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Relevant devices are:
    * ide-hd (and ide-cd, ide-drive)
    * scsi-hd (and scsi-cd, scsi-disk, scsi-block)
    * virtio-blk-pci

We do not call del_boot_device_lchs() for ide-* since we don't need to -
IDE block devices do not support unplugging.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 hw/block/virtio-blk.c |  6 ++++++
 hw/ide/qdev.c         |  5 +++++
 hw/scsi/scsi-disk.c   | 14 ++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 06e57a4d39..787bbd768a 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1182,6 +1182,11 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     blk_set_guest_block_size(s->blk, s->conf.conf.logical_block_size);
 
     blk_iostatus_enable(s->blk);
+
+    add_boot_device_lchs(dev, "/disk@0,0",
+                         (&conf->conf)->lcyls,
+                         (&conf->conf)->lheads,
+                         (&conf->conf)->lsecs);
 }
 
 static void virtio_blk_device_unrealize(DeviceState *dev, Error **errp)
@@ -1189,6 +1194,7 @@ static void virtio_blk_device_unrealize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBlock *s = VIRTIO_BLK(dev);
 
+    del_boot_device_lchs(dev, "/disk@0,0");
     virtio_blk_data_plane_destroy(s->dataplane);
     s->dataplane = NULL;
     qemu_del_vm_change_state_handler(s->change);
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 9cae3205df..07f429d5e3 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -215,6 +215,11 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
 
     add_boot_device_path(dev->conf.bootindex, &dev->qdev,
                          dev->unit ? "/disk@1" : "/disk@0");
+
+    add_boot_device_lchs(&dev->qdev, dev->unit ? "/disk@1" : "/disk@0",
+                         (&dev->conf)->lcyls,
+                         (&dev->conf)->lheads,
+                         (&dev->conf)->lsecs);
 }
 
 static void ide_dev_get_bootindex(Object *obj, Visitor *v, const char *name,
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 7b89ac798b..3451aefdea 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2390,6 +2390,16 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
     blk_set_guest_block_size(s->qdev.conf.blk, s->qdev.blocksize);
 
     blk_iostatus_enable(s->qdev.conf.blk);
+
+    add_boot_device_lchs(&dev->qdev, NULL,
+                         (&dev->conf)->lcyls,
+                         (&dev->conf)->lheads,
+                         (&dev->conf)->lsecs);
+}
+
+static void scsi_unrealize(SCSIDevice *dev, Error **errp)
+{
+    del_boot_device_lchs(&dev->qdev, NULL);
 }
 
 static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
@@ -2988,6 +2998,7 @@ static void scsi_hd_class_initfn(ObjectClass *klass, void *data)
     SCSIDeviceClass *sc = SCSI_DEVICE_CLASS(klass);
 
     sc->realize      = scsi_hd_realize;
+    sc->unrealize    = scsi_unrealize;
     sc->alloc_req    = scsi_new_request;
     sc->unit_attention_reported = scsi_disk_unit_attention_reported;
     dc->desc = "virtual SCSI disk";
@@ -3019,6 +3030,7 @@ static void scsi_cd_class_initfn(ObjectClass *klass, void *data)
     SCSIDeviceClass *sc = SCSI_DEVICE_CLASS(klass);
 
     sc->realize      = scsi_cd_realize;
+    sc->unrealize    = scsi_unrealize;
     sc->alloc_req    = scsi_new_request;
     sc->unit_attention_reported = scsi_disk_unit_attention_reported;
     dc->desc = "virtual SCSI CD-ROM";
@@ -3054,6 +3066,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, void *data)
     SCSIDiskClass *sdc = SCSI_DISK_BASE_CLASS(klass);
 
     sc->realize      = scsi_block_realize;
+    sc->unrealize    = scsi_unrealize;
     sc->alloc_req    = scsi_block_new_request;
     sc->parse_cdb    = scsi_block_parse_cdb;
     sdc->dma_readv   = scsi_block_dma_readv;
@@ -3095,6 +3108,7 @@ static void scsi_disk_class_initfn(ObjectClass *klass, void *data)
     SCSIDeviceClass *sc = SCSI_DEVICE_CLASS(klass);
 
     sc->realize      = scsi_disk_realize;
+    sc->unrealize    = scsi_unrealize;
     sc->alloc_req    = scsi_new_request;
     sc->unit_attention_reported = scsi_disk_unit_attention_reported;
     dc->fw_name = "disk";
-- 
2.13.3


