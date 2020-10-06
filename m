Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2214EC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FC620760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRJs9LJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FC620760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmNR-0001Ad-Gl
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kPmFt-0001HM-MI
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kPmFq-0007wK-Lz
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601987981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lZUKs0z7jfCFm1NgfTxccxpZuuL2RU5UTO4LliXmsU=;
 b=KRJs9LJaZQ7y/p3p7Jg+fki7EuVPEYbumTwu3SrdRZEQOJxhDg1aUlWEmYUidTHcppFG/P
 90M5K81SXg5fxMqQp5NaTJJlXxJRC1XMEcNm7Sp7ret6BocUT3lthX0zqPmlKu73bvHJiO
 og1AkGRHAdDklxwdhtXVqIhwglGl3oQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-US84SNAlNUWtoabEOx1rtg-1; Tue, 06 Oct 2020 08:39:39 -0400
X-MC-Unique: US84SNAlNUWtoabEOx1rtg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D634D87950D;
 Tue,  6 Oct 2020 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0629255767;
 Tue,  6 Oct 2020 12:39:33 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 05/13] scsi: switch to bus->check_address
Date: Tue,  6 Oct 2020 15:38:56 +0300
Message-Id: <20201006123904.610658-6-mlevitsk@redhat.com>
In-Reply-To: <20201006123904.610658-1-mlevitsk@redhat.com>
References: <20201006123904.610658-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c | 122 ++++++++++++++++++++++++++++-----------------
 1 file changed, 75 insertions(+), 47 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 3284a5d1fb..94921c04b1 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -22,33 +22,6 @@ static void scsi_req_dequeue(SCSIRequest *req);
 static uint8_t *scsi_target_alloc_buf(SCSIRequest *req, size_t len);
 static void scsi_target_free_buf(SCSIRequest *req);
 
-static Property scsi_props[] = {
-    DEFINE_PROP_UINT32("channel", SCSIDevice, channel, 0),
-    DEFINE_PROP_UINT32("scsi-id", SCSIDevice, id, -1),
-    DEFINE_PROP_UINT32("lun", SCSIDevice, lun, -1),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void scsi_bus_class_init(ObjectClass *klass, void *data)
-{
-    BusClass *k = BUS_CLASS(klass);
-    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
-
-    k->get_dev_path = scsibus_get_dev_path;
-    k->get_fw_dev_path = scsibus_get_fw_dev_path;
-    hc->unplug = qdev_simple_device_unplug_cb;
-}
-
-static const TypeInfo scsi_bus_info = {
-    .name = TYPE_SCSI_BUS,
-    .parent = TYPE_BUS,
-    .instance_size = sizeof(SCSIBus),
-    .class_init = scsi_bus_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_HOTPLUG_HANDLER },
-        { }
-    }
-};
 static int next_scsi_bus;
 
 static void scsi_device_realize(SCSIDevice *s, Error **errp)
@@ -160,35 +133,68 @@ static void scsi_dma_restart_cb(void *opaque, int running, RunState state)
     }
 }
 
-static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
+static bool scsi_bus_is_address_free(SCSIBus *bus,
+				     int channel, int target, int lun,
+				     SCSIDevice **p_dev)
+{
+    SCSIDevice *d = scsi_device_find(bus, channel, target, lun);
+    if (d && d->lun == lun) {
+        if (p_dev) {
+            *p_dev = d;
+        }
+        return false;
+    }
+    if (p_dev) {
+        *p_dev = NULL;
+    }
+    return true;
+}
+
+static bool scsi_bus_check_address(BusState *qbus, DeviceState *qdev, Error **errp)
 {
     SCSIDevice *dev = SCSI_DEVICE(qdev);
-    SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, dev->qdev.parent_bus);
-    SCSIDevice *d;
-    Error *local_err = NULL;
+    SCSIBus *bus = SCSI_BUS(qbus);
 
     if (dev->channel > bus->info->max_channel) {
         error_setg(errp, "bad scsi channel id: %d", dev->channel);
-        return;
+        return false;
     }
     if (dev->id != -1 && dev->id > bus->info->max_target) {
         error_setg(errp, "bad scsi device id: %d", dev->id);
-        return;
+        return false;
     }
     if (dev->lun != -1 && dev->lun > bus->info->max_lun) {
         error_setg(errp, "bad scsi device lun: %d", dev->lun);
-        return;
+        return false;
+    }
+
+    if (dev->id != -1 && dev->lun != -1) {
+        SCSIDevice *d;
+        if (!scsi_bus_is_address_free(bus, dev->channel, dev->id, dev->lun, &d)) {
+            error_setg(errp, "lun already used by '%s'", d->qdev.id);
+            return false;
+        }
     }
 
+    return true;
+}
+
+static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
+{
+    SCSIDevice *dev = SCSI_DEVICE(qdev);
+    SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, dev->qdev.parent_bus);
+    bool is_free;
+    Error *local_err = NULL;
+
     if (dev->id == -1) {
         int id = -1;
         if (dev->lun == -1) {
             dev->lun = 0;
         }
         do {
-            d = scsi_device_find(bus, dev->channel, ++id, dev->lun);
-        } while (d && d->lun == dev->lun && id < bus->info->max_target);
-        if (d && d->lun == dev->lun) {
+            is_free = scsi_bus_is_address_free(bus, dev->channel, ++id, dev->lun, NULL);
+        } while (!is_free && id < bus->info->max_target);
+        if (!is_free) {
             error_setg(errp, "no free target");
             return;
         }
@@ -196,20 +202,13 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
     } else if (dev->lun == -1) {
         int lun = -1;
         do {
-            d = scsi_device_find(bus, dev->channel, dev->id, ++lun);
-        } while (d && d->lun == lun && lun < bus->info->max_lun);
-        if (d && d->lun == lun) {
+            is_free = scsi_bus_is_address_free(bus, dev->channel, dev->id, ++lun, NULL);
+        } while (!is_free && lun < bus->info->max_lun);
+        if (!is_free) {
             error_setg(errp, "no free lun");
             return;
         }
         dev->lun = lun;
-    } else {
-        d = scsi_device_find(bus, dev->channel, dev->id, dev->lun);
-        assert(d);
-        if (d->lun == dev->lun && dev != d) {
-            error_setg(errp, "lun already used by '%s'", d->qdev.id);
-            return;
-        }
     }
 
     QTAILQ_INIT(&dev->requests);
@@ -1709,6 +1708,13 @@ const VMStateDescription vmstate_scsi_device = {
     }
 };
 
+static Property scsi_props[] = {
+    DEFINE_PROP_UINT32("channel", SCSIDevice, channel, 0),
+    DEFINE_PROP_UINT32("scsi-id", SCSIDevice, id, -1),
+    DEFINE_PROP_UINT32("lun", SCSIDevice, lun, -1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void scsi_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
@@ -1739,6 +1745,28 @@ static const TypeInfo scsi_device_type_info = {
     .instance_init = scsi_dev_instance_init,
 };
 
+static void scsi_bus_class_init(ObjectClass *klass, void *data)
+{
+    BusClass *k = BUS_CLASS(klass);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
+
+    k->get_dev_path = scsibus_get_dev_path;
+    k->get_fw_dev_path = scsibus_get_fw_dev_path;
+    k->check_address = scsi_bus_check_address;
+    hc->unplug = qdev_simple_device_unplug_cb;
+}
+
+static const TypeInfo scsi_bus_info = {
+    .name = TYPE_SCSI_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = sizeof(SCSIBus),
+    .class_init = scsi_bus_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_HOTPLUG_HANDLER },
+        { }
+    }
+};
+
 static void scsi_register_types(void)
 {
     type_register_static(&scsi_bus_info);
-- 
2.26.2


