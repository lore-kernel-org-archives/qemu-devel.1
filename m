Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D8AC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E90E206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E90E206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxWf-0005tP-Qx
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIxQX-0005a2-0N
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIxQV-00041z-Jh
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:06:00 -0400
Received: from relay.sw.ru ([185.231.240.75]:47800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIxQV-00040i-BC
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:05:59 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIxQT-0003XG-Tg; Fri, 11 Oct 2019 19:05:58 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [RFC v5 006/126] qdev-monitor: well form error hint helpers
Date: Fri, 11 Oct 2019 19:03:52 +0300
Message-Id: <20191011160552.22907-7-vsementsov@virtuozzo.com>
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

Make qbus_list_bus and qbus_list_dev hint append helpers well formed:
rename errp to errp_in, as it is IN-parameter here (which is unusual
for errp), rename functions to be error_append_*_hint.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qdev-monitor.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index 85b58620d1..d14ef6af01 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -326,36 +326,36 @@ static Object *qdev_get_peripheral_anon(void)
     return dev;
 }
 
-static void qbus_list_bus(DeviceState *dev, Error **errp)
+static void error_append_qbus_bus_list_hint(DeviceState *dev, Error **errp_in)
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
+static void error_append_qbus_dev_list_hint(BusState *bus, Error **errp_in)
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
@@ -498,7 +498,7 @@ static BusState *qbus_find(const char *path, Error **errp)
         if (!dev) {
             error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
                       "Device '%s' not found", elem);
-            qbus_list_dev(bus, errp);
+            error_append_qbus_dev_list_hint(bus, errp);
             return NULL;
         }
 
@@ -516,7 +516,7 @@ static BusState *qbus_find(const char *path, Error **errp)
             if (dev->num_child_bus) {
                 error_setg(errp, "Device '%s' has multiple child buses",
                            elem);
-                qbus_list_bus(dev, errp);
+                error_append_qbus_bus_list_hint(dev, errp);
             } else {
                 error_setg(errp, "Device '%s' has no child bus", elem);
             }
@@ -532,7 +532,7 @@ static BusState *qbus_find(const char *path, Error **errp)
         bus = qbus_find_bus(dev, elem);
         if (!bus) {
             error_setg(errp, "Bus '%s' not found", elem);
-            qbus_list_bus(dev, errp);
+            error_append_qbus_bus_list_hint(dev, errp);
             return NULL;
         }
     }
-- 
2.21.0


