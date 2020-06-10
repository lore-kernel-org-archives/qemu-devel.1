Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B15BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45962074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V58kPkY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45962074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jitfa-0001Kg-2c
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMQ-0005Fh-Uk
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42754
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMD-0003rh-0C
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591767179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LN21TAO75aQBfGc7iA5pi/tk6JhwKVCIzDphOzDmXH0=;
 b=V58kPkY338+sN8Pf2dBHMnL/yv+aGCn6AxSte90SyG8d0H8fkkIM9ZDnwD7qc+3Z5aauyS
 DfIVMbGiShhC2SCYHZ5tm2vvQZO4WjqG8g6NSl5aJjqAI+2RpIgDBHjOOe18taGAi56z3Q
 FrvAFrX7oC5bqpljh8qTqeI5K8TJ2A8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-hvWqDWCTMPynpv7uKB7zDA-1; Wed, 10 Jun 2020 01:32:57 -0400
X-MC-Unique: hvWqDWCTMPynpv7uKB7zDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0993107ACCD
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 05:32:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B25A57BFEA;
 Wed, 10 Jun 2020 05:32:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C696B1138482; Wed, 10 Jun 2020 07:32:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 44/58] sysbus: New sysbus_realize(),
 sysbus_realize_and_unref()
Date: Wed, 10 Jun 2020 07:32:33 +0200
Message-Id: <20200610053247.1583243-45-armbru@redhat.com>
In-Reply-To: <20200610053247.1583243-1-armbru@redhat.com>
References: <20200610053247.1583243-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
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


