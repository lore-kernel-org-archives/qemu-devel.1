Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D41C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27FAF221EB
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y87QEWMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FAF221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHUYw-0003lR-6w
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 12:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kHUTf-00036M-98
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 12:03:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31979
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kHUTd-0001Qa-Cs
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 12:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600013020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mIYppoBdC1vT4S92j9I4A0mISaAkKY++kqWbdPhg+vs=;
 b=Y87QEWMYmgb434tpztMUZiXO7/Eul95ATJqSGpzNbYp29rRVaKPDckbMwB4AcAP2gupu7Y
 tP4+wcg0w88lrdEupGe5VqiprLEHomhz6+/Lu3gg8EH2dZ59cVYCHxoHdsoE5pAv1fGm75
 OPBPfChfQ9MILDdLjzRy7Pfr6eP2Zro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-bP13ZIhtPKWTtG3W2i7mCA-1; Sun, 13 Sep 2020 12:03:36 -0400
X-MC-Unique: bP13ZIhtPKWTtG3W2i7mCA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98D7A1DDF9;
 Sun, 13 Sep 2020 16:03:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D8D319C4F;
 Sun, 13 Sep 2020 16:03:33 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 7/9] scsi/scsi_bus: Add scsi_device_get
Date: Sun, 13 Sep 2020 19:02:57 +0300
Message-Id: <20200913160259.32145-8-mlevitsk@redhat.com>
In-Reply-To: <20200913160259.32145-1-mlevitsk@redhat.com>
References: <20200913160259.32145-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 11:28:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Stefan Hajnoczi <stefanha@gmail.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add scsi_device_get which finds the scsi device
and takes a reference to it.

Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/scsi/scsi-bus.c     | 22 +++++++++++++++++-----
 include/hw/scsi/scsi.h |  1 +
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 1fbb3ee584..dfd503f7ef 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -53,7 +53,7 @@ static int next_scsi_bus;
 
 static SCSIDevice *do_scsi_device_find(SCSIBus *bus,
                                        int channel, int id, int lun,
-                                       bool include_unrealized)
+                                       bool include_unrealized, bool take_ref)
 {
     BusChild *kid;
     SCSIDevice *retval = NULL;
@@ -93,13 +93,22 @@ out:
         retval = NULL;
     }
 
+    if (take_ref) {
+        object_ref(OBJECT(retval));
+    }
+
     rcu_read_unlock();
     return retval;
 }
 
 SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
 {
-    return do_scsi_device_find(bus, channel, id, lun, false);
+    return do_scsi_device_find(bus, channel, id, lun, false, false);
+}
+
+SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int id, int lun)
+{
+    return do_scsi_device_find(bus, channel, id, lun, false, true);
 }
 
 static void scsi_device_realize(SCSIDevice *s, Error **errp)
@@ -237,7 +246,8 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
             dev->lun = 0;
         }
         do {
-            d = do_scsi_device_find(bus, dev->channel, ++id, dev->lun, true);
+            d = do_scsi_device_find(bus, dev->channel, ++id, dev->lun,
+                                    true, false);
         } while (d && d->lun == dev->lun && id < bus->info->max_target);
         if (d && d->lun == dev->lun) {
             error_setg(errp, "no free target");
@@ -247,7 +257,8 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
     } else if (dev->lun == -1) {
         int lun = -1;
         do {
-            d = do_scsi_device_find(bus, dev->channel, dev->id, ++lun, true);
+            d = do_scsi_device_find(bus, dev->channel, dev->id, ++lun,
+                                    true, false);
         } while (d && d->lun == lun && lun < bus->info->max_lun);
         if (d && d->lun == lun) {
             error_setg(errp, "no free lun");
@@ -255,7 +266,8 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
         }
         dev->lun = lun;
     } else {
-        d = do_scsi_device_find(bus, dev->channel, dev->id, dev->lun, true);
+        d = do_scsi_device_find(bus, dev->channel, dev->id, dev->lun,
+                                true, false);
         assert(d);
         if (d->lun == dev->lun && dev != d) {
             error_setg(errp, "lun already used by '%s'", d->qdev.id);
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 3818e3fa46..92ee1ea351 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -193,6 +193,7 @@ int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed);
 int scsi_SG_IO_FROM_DEV(BlockBackend *blk, uint8_t *cmd, uint8_t cmd_size,
                         uint8_t *buf, uint8_t buf_size);
 SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int target, int lun);
+SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int target, int lun);
 
 /* scsi-generic.c. */
 extern const SCSIReqOps scsi_generic_req_ops;
-- 
2.26.2


