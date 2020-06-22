Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C550C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58363206F1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8hMYsyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58363206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnK1b-00029X-GG
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 06:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnJuo-0007Q6-A8
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:43:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29675
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnJul-0005Mh-Ab
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592822578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4tL3HIKS4vITLC3fFlbuCWS7ycaHKLToIkhZt8tjHeA=;
 b=M8hMYsyK2211fiKtQTv1ZeK/cgafD8C1R2NUVbK/7VOrDEPCOTbM7jrQTCrvT+y4fZsSm1
 /hjlMSgz0AAHQekELHFYowdIcfY/UrQiXMMmfxb7nhhngtMF+HnlNUZKX6iVImZN/VxCWE
 7YJgU8q/09its5OKbabN3u4+06E3VLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-bDdUJn_gMTu6DU0dLMi2hw-1; Mon, 22 Jun 2020 06:42:57 -0400
X-MC-Unique: bDdUJn_gMTu6DU0dLMi2hw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39F12184D142
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 10:42:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0554A1001925;
 Mon, 22 Jun 2020 10:42:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 32EC4113847C; Mon, 22 Jun 2020 12:42:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/22] qdev: Drop qbus_set_bus_hotplug_handler() parameter
 @errp
Date: Mon, 22 Jun 2020 12:42:42 +0200
Message-Id: <20200622104250.1404835-15-armbru@redhat.com>
In-Reply-To: <20200622104250.1404835-1-armbru@redhat.com>
References: <20200622104250.1404835-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All callers pass &error_abort.  Drop the parameter.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/qdev-core.h      | 2 +-
 hw/core/bus.c               | 4 ++--
 hw/scsi/scsi-bus.c          | 2 +-
 hw/usb/bus.c                | 2 +-
 hw/xen/xen-bus.c            | 2 +-
 hw/xen/xen-legacy-backend.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 7dc10be46f..78acdeaed6 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -537,7 +537,7 @@ char *qdev_get_dev_path(DeviceState *dev);
 
 void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **errp);
 
-void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp);
+void qbus_set_bus_hotplug_handler(BusState *bus);
 
 static inline bool qbus_is_hotpluggable(BusState *bus)
 {
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 6cc28b334e..8d4e810d7f 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -29,9 +29,9 @@ void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **errp)
                              QDEV_HOTPLUG_HANDLER_PROPERTY, errp);
 }
 
-void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp)
+void qbus_set_bus_hotplug_handler(BusState *bus)
 {
-    qbus_set_hotplug_handler(bus, OBJECT(bus), errp);
+    qbus_set_hotplug_handler(bus, OBJECT(bus), &error_abort);
 }
 
 int qbus_walk_children(BusState *bus,
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 27843bb04b..b878a08080 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -107,7 +107,7 @@ void scsi_bus_new(SCSIBus *bus, size_t bus_size, DeviceState *host,
     qbus_create_inplace(bus, bus_size, TYPE_SCSI_BUS, host, bus_name);
     bus->busnr = next_scsi_bus++;
     bus->info = info;
-    qbus_set_bus_hotplug_handler(BUS(bus), &error_abort);
+    qbus_set_bus_hotplug_handler(BUS(bus));
 }
 
 static void scsi_dma_restart_bh(void *opaque)
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index a81aee2051..957559b18d 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -84,7 +84,7 @@ void usb_bus_new(USBBus *bus, size_t bus_size,
                  USBBusOps *ops, DeviceState *host)
 {
     qbus_create_inplace(bus, bus_size, TYPE_USB_BUS, host, NULL);
-    qbus_set_bus_hotplug_handler(BUS(bus), &error_abort);
+    qbus_set_bus_hotplug_handler(BUS(bus));
     bus->ops = ops;
     bus->busnr = next_usb_bus++;
     QTAILQ_INIT(&bus->free);
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 4b00320f1c..c4e2162ae9 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -1391,5 +1391,5 @@ void xen_bus_init(void)
     BusState *bus = qbus_create(TYPE_XEN_BUS, dev, NULL);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    qbus_set_bus_hotplug_handler(bus, &error_abort);
+    qbus_set_bus_hotplug_handler(bus);
 }
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 2335ee2e65..7d4b13351e 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -705,7 +705,7 @@ int xen_be_init(void)
     xen_sysdev = qdev_new(TYPE_XENSYSDEV);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(xen_sysdev), &error_fatal);
     xen_sysbus = qbus_create(TYPE_XENSYSBUS, xen_sysdev, "xen-sysbus");
-    qbus_set_bus_hotplug_handler(xen_sysbus, &error_abort);
+    qbus_set_bus_hotplug_handler(xen_sysbus);
 
     return 0;
 
-- 
2.26.2


