Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42CCC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCAB206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYuK8AxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCAB206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYB67-00037p-Hb
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jYB0Y-0002er-Px
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:10:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56920
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jYB0X-0001Cq-Tp
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589213421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=z6E8fClkSbbsupJYLxw1Lqcf48MNwJNj/0CvVbP4DbE=;
 b=SYuK8AxGhlkjdVuQNFTjQSYRmvC+K5U/ZZ77QzeduoQdAbrdjTAmBFAgreDyI73A6GUQKi
 00+f7YJxiarUN4pH3kOlzdzOBmuHnrbhS7qshbSHFWKvH3fENhKEqSD76XsEYOpvTTISoP
 nFuVRawGJm5L8tAxa29szB+GelFu60o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-0Ei92VfpP_aD3WJP1FHoYA-1; Mon, 11 May 2020 12:10:18 -0400
X-MC-Unique: 0Ei92VfpP_aD3WJP1FHoYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7350A0BE1;
 Mon, 11 May 2020 16:10:17 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AC4A5C1B5;
 Mon, 11 May 2020 16:10:12 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/7] scsi: Add scsi_device_get
Date: Mon, 11 May 2020 19:09:50 +0300
Message-Id: <20200511160951.8733-7-mlevitsk@redhat.com>
In-Reply-To: <20200511160951.8733-1-mlevitsk@redhat.com>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 01:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add scsi_device_get which finds the scsi device
and takes a reference to it.

Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/scsi/scsi-bus.c     | 31 ++++++++++++++++++++++++-------
 include/hw/scsi/scsi.h |  2 ++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 2bf6d005f3..4e15de0bd7 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1584,8 +1584,13 @@ static char *scsibus_get_fw_dev_path(DeviceState *dev)
     return g_strdup_printf("channel@%x/%s@%x,%x", d->channel,
                            qdev_fw_name(dev), d->id, d->lun);
 }
-
-SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
+/*
+ * Finds a matching channel/id/lun device on scsi bus, and
+ * takes a reference to it and returns it.
+ * If we don't find exact match (channel/bus/lun),
+ * we will return the first device which matches channel/bus
+ * */
+SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int id, int lun)
 {
     BusChild *kid;
     SCSIDevice *target_dev = NULL;
@@ -1598,25 +1603,37 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
 
         if (dev->channel == channel && dev->id == id) {
             if (dev->lun == lun) {
+                object_ref(OBJECT(dev));
                 rcu_read_unlock();
                 return dev;
             }
 
-            /*
-             * If we don't find exact match (channel/bus/lun),
-             * we will return the first device which matches channel/bus
-             */
-
             if (!target_dev) {
                 target_dev = dev;
             }
         }
     }
 
+    object_ref(OBJECT(target_dev));
     rcu_read_unlock();
     return target_dev;
 }
 
+/*
+ * This function works like scsi_device_get but doesn't take a refernce
+ * to the returned object. Intended for legacy code
+ */
+SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
+{
+    SCSIDevice *dev = scsi_device_get(bus, channel, id, lun);
+
+    if (!dev)
+        return NULL;
+
+    object_unref(OBJECT(dev));
+    return dev;
+}
+
 /* SCSI request list.  For simplicity, pv points to the whole device */
 
 static int put_scsi_requests(QEMUFile *f, void *pv, size_t size,
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 332ef602f4..5e1d31ab6d 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -193,7 +193,9 @@ void scsi_generic_read_device_inquiry(SCSIDevice *dev);
 int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed);
 int scsi_SG_IO_FROM_DEV(BlockBackend *blk, uint8_t *cmd, uint8_t cmd_size,
                         uint8_t *buf, uint8_t buf_size);
+
 SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int target, int lun);
+SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int target, int lun);
 
 /* scsi-generic.c. */
 extern const SCSIReqOps scsi_generic_req_ops;
-- 
2.17.2


