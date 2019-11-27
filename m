Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BF7C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD04204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD04204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia2eN-0002IE-PH
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 14:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia2d1-0001FO-AJ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia2cz-0002tV-Jb
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:05:30 -0500
Received: from relay.sw.ru ([185.231.240.75]:52834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia2cx-0002nY-Hy
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:05:29 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia2cm-0003ZO-OZ; Wed, 27 Nov 2019 22:05:17 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6] qdev-monitor: well form error hint helpers
Date: Wed, 27 Nov 2019 22:05:16 +0300
Message-Id: <20191127190516.15394-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, marcandre.lureau@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make qbus_list_bus and qbus_list_dev hint append helpers well formed:
rename errp to errp_in, as it is IN-parameter here (which is unusual
for errp), rename functions to be error_append_*_hint.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---

v6: change functions prefix to qbus_error_append_, to keep qbus_ prefix
    add r-b by Mark-André

 qdev-monitor.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index 29ed73e56a..6235898a14 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -328,36 +328,36 @@ static Object *qdev_get_peripheral_anon(void)
     return dev;
 }
 
-static void qbus_list_bus(DeviceState *dev, Error **errp)
+static void qbus_error_append_bus_list_hint(DeviceState *dev, Error **errp_in)
 {
     BusState *child;
     const char *sep = " ";
 
-    error_append_hint(errp, "child buses at \"%s\":",
+    error_append_hint(errp_in, "child buses at \"%s\":",
                       dev->id ? dev->id : object_get_typename(OBJECT(dev)));
     QLIST_FOREACH(child, &dev->child_bus, sibling) {
-        error_append_hint(errp, "%s\"%s\"", sep, child->name);
+        error_append_hint(errp_in, "%s\"%s\"", sep, child->name);
         sep = ", ";
     }
-    error_append_hint(errp, "\n");
+    error_append_hint(errp_in, "\n");
 }
 
-static void qbus_list_dev(BusState *bus, Error **errp)
+static void qbus_error_append_dev_list_hint(BusState *bus, Error **errp_in)
 {
     BusChild *kid;
     const char *sep = " ";
 
-    error_append_hint(errp, "devices at \"%s\":", bus->name);
+    error_append_hint(errp_in, "devices at \"%s\":", bus->name);
     QTAILQ_FOREACH(kid, &bus->children, sibling) {
         DeviceState *dev = kid->child;
-        error_append_hint(errp, "%s\"%s\"", sep,
+        error_append_hint(errp_in, "%s\"%s\"", sep,
                           object_get_typename(OBJECT(dev)));
         if (dev->id) {
-            error_append_hint(errp, "/\"%s\"", dev->id);
+            error_append_hint(errp_in, "/\"%s\"", dev->id);
         }
         sep = ", ";
     }
-    error_append_hint(errp, "\n");
+    error_append_hint(errp_in, "\n");
 }
 
 static BusState *qbus_find_bus(DeviceState *dev, char *elem)
@@ -500,7 +500,7 @@ static BusState *qbus_find(const char *path, Error **errp)
         if (!dev) {
             error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
                       "Device '%s' not found", elem);
-            qbus_list_dev(bus, errp);
+            qbus_error_append_dev_list_hint(bus, errp);
             return NULL;
         }
 
@@ -518,7 +518,7 @@ static BusState *qbus_find(const char *path, Error **errp)
             if (dev->num_child_bus) {
                 error_setg(errp, "Device '%s' has multiple child buses",
                            elem);
-                qbus_list_bus(dev, errp);
+                qbus_error_append_bus_list_hint(dev, errp);
             } else {
                 error_setg(errp, "Device '%s' has no child bus", elem);
             }
@@ -534,7 +534,7 @@ static BusState *qbus_find(const char *path, Error **errp)
         bus = qbus_find_bus(dev, elem);
         if (!bus) {
             error_setg(errp, "Bus '%s' not found", elem);
-            qbus_list_bus(dev, errp);
+            qbus_error_append_bus_list_hint(dev, errp);
             return NULL;
         }
     }
-- 
2.21.0


