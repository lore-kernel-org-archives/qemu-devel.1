Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2FBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98252078E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBQ8Qddn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98252078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkwj8-0006OK-Tw
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 17:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkw20-0006yg-9y
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:48:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28418
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkw1y-0001sS-9B
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592254113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FK722c5ZFKER/wHuGqRHn4hCieNnVg1zW4nTNMQ6CSE=;
 b=FBQ8Qddnq22C+ZBaiX304Kxf6+5SXH+2jPs5XUf/bNMoyRnQQyOOQIuY/TdZgXRngGsaQO
 kIzPlqxToXsEizmWakEXL/9LEd5rYPZf8WdxLWofdqo+QsPLDb+ZmuRUVrwG+XjJUzfbOO
 ECqYNwBAHg49BefQ/UMyR9VrN5wNwos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-vQiCIEQ0PRWta6Q8W5X62w-1; Mon, 15 Jun 2020 16:48:31 -0400
X-MC-Unique: vQiCIEQ0PRWta6Q8W5X62w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2CAD1009613
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 20:48:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77F5E19D9E;
 Mon, 15 Jun 2020 20:48:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2BF5D11328AB; Mon, 15 Jun 2020 22:40:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 70/84] sysbus: New sysbus_realize(), sysbus_realize_and_unref()
Date: Mon, 15 Jun 2020 22:39:54 +0200
Message-Id: <20200615204008.3069956-71-armbru@redhat.com>
In-Reply-To: <20200615204008.3069956-1-armbru@redhat.com>
References: <20200615204008.3069956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 16:38:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sysbus devices almost always plug into the main system bus.
qdev_create() even has a convenience feature to make that easy: a null
bus argument gets replaced by the main system bus.  qdev_realize() and
qdev_realize_and_unref() do the same.

We can do better.  Provide convenience wrappers around qdev_realize()
and qdev_realize_and_unref() that don't take a @bus argument.  They
always pass the main system bus.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200610053247.1583243-45-armbru@redhat.com>
---
 include/hw/sysbus.h |  4 +++-
 hw/core/sysbus.c    | 14 ++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index c4a1c0adfa..606095ba35 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -90,6 +90,9 @@ void sysbus_add_io(SysBusDevice *dev, hwaddr addr,
                    MemoryRegion *mem);
 MemoryRegion *sysbus_address_space(SysBusDevice *dev);
 
+bool sysbus_realize(SysBusDevice *dev, Error **errp);
+bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp);
+
 /**
  * sysbus_init_child_obj:
  * @parent: The parent object
@@ -121,5 +124,4 @@ static inline DeviceState *sysbus_create_simple(const char *name,
     return sysbus_create_varargs(name, addr, irq, NULL);
 }
 
-
 #endif /* HW_SYSBUS_H */
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index e8d08d349b..68b837ac85 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -217,7 +217,7 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size)
  * from being set to NULL to break the normal init/realize
  * of some devices.
  */
-static void sysbus_realize(DeviceState *dev, Error **errp)
+static void sysbus_device_realize(DeviceState *dev, Error **errp)
 {
 }
 
@@ -250,6 +250,16 @@ DeviceState *sysbus_create_varargs(const char *name,
     return dev;
 }
 
+bool sysbus_realize(SysBusDevice *dev, Error **errp)
+{
+    return qdev_realize(DEVICE(dev), sysbus_get_default(), errp);
+}
+
+bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp)
+{
+    return qdev_realize_and_unref(DEVICE(dev), sysbus_get_default(), errp);
+}
+
 static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent)
 {
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
@@ -301,7 +311,7 @@ MemoryRegion *sysbus_address_space(SysBusDevice *dev)
 static void sysbus_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
-    k->realize = sysbus_realize;
+    k->realize = sysbus_device_realize;
     k->bus_type = TYPE_SYSTEM_BUS;
     /*
      * device_add plugs devices into a suitable bus.  For "real" buses,
-- 
2.26.2


