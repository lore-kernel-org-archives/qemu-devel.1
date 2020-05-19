Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041E0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:02:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3125207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bA2AZBFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3125207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3km-0005KZ-RA
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3ey-000131-2P
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33774
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3ew-0003Th-Hl
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmIODdrm7cn8m/MYtZS6YqoicbH6D5kJJtenmg0hJG0=;
 b=bA2AZBFJcMAq4W3BdwoA+/mc+3FaiUocsxcFQBE/NdSz4HgkxxKVaoBH42Ajl3AcHYimZi
 8Ipxfexnry7iANCT7iTBm/N+3oYpKABUD99IQeWUMbh32bAguXNc2YLZOBZY2TdN3xDeM6
 ozTw1WaNTS+WdfXWw6aBgAQzr2mOWMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-k1WrYDPiNT-A5rnG-5pJ7w-1; Tue, 19 May 2020 10:55:55 -0400
X-MC-Unique: k1WrYDPiNT-A5rnG-5pJ7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5617460
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:55:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A336C60CC0;
 Tue, 19 May 2020 14:55:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C773511358C3; Tue, 19 May 2020 16:55:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/55] qdev: Convert to qdev_unrealize() manually
Date: Tue, 19 May 2020 16:55:03 +0200
Message-Id: <20200519145551.22836-8-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/qdev-core.h |  1 -
 hw/core/qdev.c         | 14 +++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index fba29308f7..be6f7c4736 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -328,7 +328,6 @@ void qdev_init_nofail(DeviceState *dev);
 bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
 bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
 void qdev_unrealize(DeviceState *dev);
-
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version);
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 0f4adac865..cb7efae487 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -421,7 +421,7 @@ static void device_reset_child_foreach(Object *obj, ResettableChildCallback cb,
 void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
                                   DeviceState *dev, Error **errp)
 {
-    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
+    qdev_unrealize(dev);
 }
 
 /*
@@ -493,6 +493,11 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
     return !err;
 }
 
+void qdev_unrealize(DeviceState *dev)
+{
+    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
+}
+
 /*
  * Realize @dev and drop a reference.
  * This is like qdev_realize(), except it steals a reference rather
@@ -512,11 +517,6 @@ bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
     return ret;
 }
 
-void qdev_unrealize(DeviceState *dev)
-{
-    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
-}
-
 static int qdev_assert_realized_properly(Object *obj, void *opaque)
 {
     DeviceState *dev = DEVICE(object_dynamic_cast(obj, TYPE_DEVICE));
@@ -1187,7 +1187,7 @@ static void device_unparent(Object *obj)
     BusState *bus;
 
     if (dev->realized) {
-        object_property_set_bool(obj, false, "realized", &error_abort);
+        qdev_unrealize(dev);
     }
     while (dev->num_child_bus) {
         bus = QLIST_FIRST(&dev->child_bus);
-- 
2.21.1


