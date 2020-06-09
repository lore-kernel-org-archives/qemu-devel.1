Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E4BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC1D02074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDSnvyM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1D02074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihaM-0006tK-0S
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHy-0004Dj-2N
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29963
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHr-0003DF-PT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2EGvII9a8ywZHb8DbNUNZcnLOkq1u0F6R3GEOVtRlg=;
 b=UDSnvyM7EynJWnw0zErDfij5DMJEXbz8jQ7RnE/5Lak6FuefNTHTcctjtfV7apYTMJTqXz
 fO8wCbZ1tqaTnjkPec2dRqliAd6o8bW2DRW25u5fQUdk07sk7SqNBcKPc01vkgVYJ1X4ur
 n9bzfnYPbZvJ4RDdId+2j8m/bSta7tk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-ajkrB96XOkWZBz9WWEks5A-1; Tue, 09 Jun 2020 12:39:40 -0400
X-MC-Unique: ajkrB96XOkWZBz9WWEks5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDDB68014D4
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 16:39:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFDD389295;
 Tue,  9 Jun 2020 16:39:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 48A721138474; Tue,  9 Jun 2020 18:39:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 30/39] qdev: qdev_create(), qdev_try_create() are now unused,
 drop
Date: Tue,  9 Jun 2020 18:39:23 +0200
Message-Id: <20200609163932.1566209-31-armbru@redhat.com>
In-Reply-To: <20200609163932.1566209-1-armbru@redhat.com>
References: <20200609163932.1566209-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-core.h |  2 --
 hw/core/qdev.c         | 48 ------------------------------------------
 hw/core/sysbus.c       |  1 -
 migration/migration.c  |  2 +-
 4 files changed, 1 insertion(+), 52 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index be6f7c4736..ef6137b6a8 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -320,8 +320,6 @@ compat_props_add(GPtrArray *arr,
 
 /*** Board API.  This should go away once we have a machine config file.  ***/
 
-DeviceState *qdev_create(BusState *bus, const char *name);
-DeviceState *qdev_try_create(BusState *bus, const char *name);
 DeviceState *qdev_new(const char *name);
 DeviceState *qdev_try_new(const char *name);
 void qdev_init_nofail(DeviceState *dev);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 4768244f31..a1fdebb3aa 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -128,54 +128,6 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
     }
 }
 
-/* Create a new device.  This only initializes the device state
-   structure and allows properties to be set.  The device still needs
-   to be realized.  See qdev-core.h.  */
-DeviceState *qdev_create(BusState *bus, const char *name)
-{
-    DeviceState *dev;
-
-    dev = qdev_try_create(bus, name);
-    if (!dev) {
-        if (bus) {
-            error_report("Unknown device '%s' for bus '%s'", name,
-                         object_get_typename(OBJECT(bus)));
-        } else {
-            error_report("Unknown device '%s' for default sysbus", name);
-        }
-        abort();
-    }
-
-    return dev;
-}
-
-DeviceState *qdev_try_create(BusState *bus, const char *type)
-{
-    DeviceState *dev;
-
-    if (object_class_by_name(type) == NULL) {
-        return NULL;
-    }
-    dev = DEVICE(object_new(type));
-    if (!dev) {
-        return NULL;
-    }
-
-    if (!bus) {
-        /* Assert that the device really is a SysBusDevice before
-         * we put it onto the sysbus. Non-sysbus devices which aren't
-         * being put onto a bus should be created with object_new(TYPE_FOO),
-         * not qdev_create(NULL, TYPE_FOO).
-         */
-        g_assert(object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE));
-        bus = sysbus_get_default();
-    }
-
-    qdev_set_parent_bus(dev, bus);
-    object_unref(OBJECT(dev));
-    return dev;
-}
-
 /*
  * Create a device on the heap.
  * A type @name must exist.
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index b5db0d179f..7ff1b5f2de 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -325,7 +325,6 @@ static const TypeInfo sysbus_device_type_info = {
     .class_init = sysbus_device_class_init,
 };
 
-/* This is a nasty hack to allow passing a NULL bus to qdev_create.  */
 static BusState *main_system_bus;
 
 static void main_system_bus_create(void)
diff --git a/migration/migration.c b/migration/migration.c
index b63ad91d34..481a590f72 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3778,7 +3778,7 @@ static const TypeInfo migration_type = {
     .name = TYPE_MIGRATION,
     /*
      * NOTE: TYPE_MIGRATION is not really a device, as the object is
-     * not created using qdev_create(), it is not attached to the qdev
+     * not created using qdev_new(), it is not attached to the qdev
      * device tree, and it is never realized.
      *
      * TODO: Make this TYPE_OBJECT once QOM provides something like
-- 
2.26.2


