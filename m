Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4666CC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A6D207EA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5SaWBrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A6D207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kClSi-0001mA-58
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 11:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kClK0-0006i1-R3
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:02:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40237
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kClJy-0004av-OD
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 11:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598886130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VpX/PWJFUx7NdHOUX10cT7htrNNEu4lX7nluG+6/dKI=;
 b=S5SaWBrIrA7NTjHlT+/13azDlQ/q8vPvFQGirNRR7YKsWhKegGkEcQIYRY5wDxr0ow9LY1
 pn2tc58LQ1vqISKNDdfGIo0O6Oierge0ZmtUMkY2OlfD2y0jf2b0A1hjWYccE0iohvGUvE
 /6bf7Re6DZ2eQWtn68w3gYzfsaNJilE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-B6BWyGr_MbqGUPsoqsK0Vw-1; Mon, 31 Aug 2020 11:01:53 -0400
X-MC-Unique: B6BWyGr_MbqGUPsoqsK0Vw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEE83425DF;
 Mon, 31 Aug 2020 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBDA419C4F;
 Mon, 31 Aug 2020 15:01:50 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 6/9] scsi/scsi-bus: scsi_device_find: don't return
 unrealized devices
Date: Mon, 31 Aug 2020 18:01:21 +0300
Message-Id: <20200831150124.206267-7-mlevitsk@redhat.com>
In-Reply-To: <20200831150124.206267-1-mlevitsk@redhat.com>
References: <20200831150124.206267-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 11:01:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The device core first places a device on the bus and then realizes it.
Make scsi_device_find avoid returing such devices to avoid
races in drivers that use an iothread (currently virtio-scsi)

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1812399

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/scsi/scsi-bus.c | 88 ++++++++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 35 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 92d412b65c..7ceae2c92b 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -51,6 +51,56 @@ static const TypeInfo scsi_bus_info = {
 };
 static int next_scsi_bus;
 
+static SCSIDevice *_scsi_device_find(SCSIBus *bus, int channel, int id, int lun,
+                                     bool include_unrealized)
+{
+    BusChild *kid;
+    SCSIDevice *retval = NULL;
+
+    rcu_read_lock();
+
+    QTAILQ_FOREACH_RCU(kid, &bus->qbus.children, sibling) {
+        DeviceState *qdev = kid->child;
+        SCSIDevice *dev = SCSI_DEVICE(qdev);
+
+        if (dev->channel == channel && dev->id == id) {
+            if (dev->lun == lun) {
+                retval = dev;
+                goto out;
+            }
+
+            /*
+             * If we don't find exact match (channel/bus/lun),
+             * we will return the first device which matches channel/bus
+             */
+
+            if (!retval) {
+                retval = dev;
+            }
+        }
+    }
+out:
+    /*
+     * This function might run on the IO thread and we might race against
+     * main thread hot-plugging the device.
+     * We assume that as soon as .realized is set to true we can let
+     * the user access the device.
+     */
+
+    if (retval && !include_unrealized &&
+        !atomic_load_acquire(&retval->qdev.realized)) {
+        retval = NULL;
+    }
+
+    rcu_read_unlock();
+    return retval;
+}
+
+SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
+{
+    return _scsi_device_find(bus, channel, id, lun, false);
+}
+
 static void scsi_device_realize(SCSIDevice *s, Error **errp)
 {
     SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(s);
@@ -186,7 +236,7 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
             dev->lun = 0;
         }
         do {
-            d = scsi_device_find(bus, dev->channel, ++id, dev->lun);
+            d = _scsi_device_find(bus, dev->channel, ++id, dev->lun, true);
         } while (d && d->lun == dev->lun && id < bus->info->max_target);
         if (d && d->lun == dev->lun) {
             error_setg(errp, "no free target");
@@ -196,7 +246,7 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
     } else if (dev->lun == -1) {
         int lun = -1;
         do {
-            d = scsi_device_find(bus, dev->channel, dev->id, ++lun);
+            d = _scsi_device_find(bus, dev->channel, dev->id, ++lun, true);
         } while (d && d->lun == lun && lun < bus->info->max_lun);
         if (d && d->lun == lun) {
             error_setg(errp, "no free lun");
@@ -204,7 +254,7 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
         }
         dev->lun = lun;
     } else {
-        d = scsi_device_find(bus, dev->channel, dev->id, dev->lun);
+        d = _scsi_device_find(bus, dev->channel, dev->id, dev->lun, true);
         assert(d);
         if (d->lun == dev->lun && dev != d) {
             error_setg(errp, "lun already used by '%s'", d->qdev.id);
@@ -1573,38 +1623,6 @@ static char *scsibus_get_fw_dev_path(DeviceState *dev)
                            qdev_fw_name(dev), d->id, d->lun);
 }
 
-SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
-{
-    BusChild *kid;
-    SCSIDevice *target_dev = NULL;
-
-    rcu_read_lock();
-
-    QTAILQ_FOREACH_RCU(kid, &bus->qbus.children, sibling) {
-        DeviceState *qdev = kid->child;
-        SCSIDevice *dev = SCSI_DEVICE(qdev);
-
-        if (dev->channel == channel && dev->id == id) {
-            if (dev->lun == lun) {
-                rcu_read_unlock();
-                return dev;
-            }
-
-            /*
-             * If we don't find exact match (channel/bus/lun),
-             * we will return the first device which matches channel/bus
-             */
-
-            if (!target_dev) {
-                target_dev = dev;
-            }
-        }
-    }
-
-    rcu_read_unlock();
-    return target_dev;
-}
-
 /* SCSI request list.  For simplicity, pv points to the whole device */
 
 static int put_scsi_requests(QEMUFile *f, void *pv, size_t size,
-- 
2.26.2


