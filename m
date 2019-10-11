Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6406AC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39620206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39620206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxdl-0003cu-Pm
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIxQZ-0005dR-Bb
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIxQY-00044w-6m
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:06:03 -0400
Received: from relay.sw.ru ([185.231.240.75]:47828)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIxQX-00043U-Si
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:06:02 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIxQV-0003XG-N0; Fri, 11 Oct 2019 19:06:00 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [RFC v5 010/126] hw/core/qdev: cleanup Error ** variables
Date: Fri, 11 Oct 2019 19:03:56 +0300
Message-Id: <20191011160552.22907-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011160552.22907-1-vsementsov@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 armbru@redhat.com, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename Error ** parameter in check_only_migratable to common errp.

In device_set_realized:

 - Move "if (local_err != NULL)" closer to error setters.

 - Drop 'Error **local_errp': it doesn't save any LoCs, but it's very
   unusual.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 hw/core/qdev.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index cbad6c1d55..e3be8cc3c4 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -796,12 +796,12 @@ static bool device_get_realized(Object *obj, Error **errp)
     return dev->realized;
 }
 
-static bool check_only_migratable(Object *obj, Error **err)
+static bool check_only_migratable(Object *obj, Error **errp)
 {
     DeviceClass *dc = DEVICE_GET_CLASS(obj);
 
     if (!vmstate_check_only_migratable(dc->vmsd)) {
-        error_setg(err, "Device %s is not migratable, but "
+        error_setg(errp, "Device %s is not migratable, but "
                    "--only-migratable was specified",
                    object_get_typename(obj));
         return false;
@@ -850,10 +850,9 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
 
         if (dc->realize) {
             dc->realize(dev, &local_err);
-        }
-
-        if (local_err != NULL) {
-            goto fail;
+            if (local_err != NULL) {
+                goto fail;
+            }
         }
 
         DEVICE_LISTENER_CALL(realize, Forward, dev);
@@ -894,27 +893,26 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
        }
 
     } else if (!value && dev->realized) {
-        Error **local_errp = NULL;
+        /* We want to catch in local_err only first error */
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
-            local_errp = local_err ? NULL : &local_err;
             object_property_set_bool(OBJECT(bus), false, "realized",
-                                     local_errp);
+                                     local_err ? NULL : &local_err);
         }
         if (qdev_get_vmsd(dev)) {
             vmstate_unregister(dev, qdev_get_vmsd(dev), dev);
         }
         if (dc->unrealize) {
-            local_errp = local_err ? NULL : &local_err;
-            dc->unrealize(dev, local_errp);
+            dc->unrealize(dev, local_err ? NULL : &local_err);
         }
         dev->pending_deleted_event = true;
         DEVICE_LISTENER_CALL(unrealize, Reverse, dev);
-    }
 
-    if (local_err != NULL) {
-        goto fail;
+        if (local_err != NULL) {
+            goto fail;
+        }
     }
 
+    assert(local_err == NULL);
     dev->realized = value;
     return;
 
@@ -952,7 +950,7 @@ static bool device_get_hotpluggable(Object *obj, Error **errp)
                                 qbus_is_hotpluggable(dev->parent_bus));
 }
 
-static bool device_get_hotplugged(Object *obj, Error **err)
+static bool device_get_hotplugged(Object *obj, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
 
-- 
2.21.0


