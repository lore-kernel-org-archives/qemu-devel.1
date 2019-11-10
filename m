Return-Path: <SRS0=zNqU=ZC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F44C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2019 19:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AADD20818
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2019 19:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AADD20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTsWX-0001o8-8y
	for qemu-devel@archiver.kernel.org; Sun, 10 Nov 2019 14:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iTsV3-0000Fl-KD
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 14:03:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iTsV2-00037J-D5
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 14:03:49 -0500
Received: from relay.sw.ru ([185.231.240.75]:42170)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iTsUz-00033g-Gv; Sun, 10 Nov 2019 14:03:45 -0500
Received: from [10.94.4.71] (helo=dptest2.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iTsUw-00076X-3V; Sun, 10 Nov 2019 22:03:42 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v0 2/2] block: allow to set 'drive' property on a realized
 block device
Date: Sun, 10 Nov 2019 22:03:10 +0300
Message-Id: <20191110190310.19799-3-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows to change (replace) the file on a block device and is useful
to workaround exclusive file access restrictions, e.g. to implement VM
migration with a shared disk stored on some storage with the exclusive
file opening model: a destination VM is started waiting for incomming
migration with a fake image drive, and later, on the last migration
phase, the fake image file is replaced with the real one.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 hw/core/qdev-properties-system.c | 89 +++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 12 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index c534590dcd..aaab1370a4 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -79,8 +79,55 @@ static void set_pointer(Object *obj, Visitor *v, Property *prop,
 
 /* --- drive --- */
 
-static void do_parse_drive(DeviceState *dev, const char *str, void **ptr,
-                           const char *propname, bool iothread, Error **errp)
+static void do_parse_drive_realized(DeviceState *dev, const char *str,
+                                    void **ptr, const char *propname,
+                                    bool iothread, Error **errp)
+{
+    BlockBackend *blk = *ptr;
+    BlockDriverState *bs = bdrv_lookup_bs(NULL, str, NULL);
+    int ret;
+    bool blk_created = false;
+
+    if (!bs) {
+        error_setg(errp, "Can't find blockdev '%s'", str);
+        return;
+    }
+
+    if (!blk) {
+        AioContext *ctx = iothread ? bdrv_get_aio_context(bs) :
+                                     qemu_get_aio_context();
+        blk = blk_new(ctx, BLK_PERM_ALL, BLK_PERM_ALL);
+        blk_created = true;
+    } else {
+        if (blk_bs(blk)) {
+            blk_remove_bs(blk);
+        }
+    }
+
+    ret = blk_insert_bs(blk, bs, errp);
+
+    if (!ret && blk_created) {
+        if (blk_attach_dev(blk, dev) < 0) {
+            /*
+             * Shouldn't be any errors here since we just created
+             * the new blk because the device doesn't have any.
+             * Leave the message here in case blk_attach_dev is changed
+             */
+             error_setg(errp, "Can't attach drive '%s' to device '%s'",
+                        str, object_get_typename(OBJECT(dev)));
+        } else {
+            *ptr = blk;
+        }
+    }
+
+    if (blk_created) {
+        blk_unref(blk);
+    }
+}
+
+static void do_parse_drive_unrealized(DeviceState *dev, const char *str,
+                                      void **ptr, const char *propname,
+                                      bool iothread, Error **errp)
 {
     BlockBackend *blk;
     bool blk_created = false;
@@ -137,18 +184,34 @@ fail:
     }
 }
 
-static void parse_drive(DeviceState *dev, const char *str, void **ptr,
-                        const char *propname, Error **errp)
-{
-    do_parse_drive(dev, str, ptr, propname, false, errp);
-}
-
-static void parse_drive_iothread(DeviceState *dev, const char *str, void **ptr,
+static void parse_drive_realized(DeviceState *dev, const char *str, void **ptr,
                                  const char *propname, Error **errp)
 {
-    do_parse_drive(dev, str, ptr, propname, true, errp);
+    do_parse_drive_realized(dev, str, ptr, propname, false, errp);
 }
 
+static void parse_drive_realized_iothread(DeviceState *dev, const char *str,
+                                          void **ptr, const char *propname,
+                                          Error **errp)
+{
+    do_parse_drive_realized(dev, str, ptr, propname, true, errp);
+}
+
+static void parse_drive_unrealized(DeviceState *dev, const char *str,
+                                   void **ptr, const char *propname,
+                                   Error **errp)
+{
+    do_parse_drive_unrealized(dev, str, ptr, propname, false, errp);
+}
+
+static void parse_drive_unrealized_iothread(DeviceState *dev, const char *str,
+                                            void **ptr, const char *propname,
+                                            Error **errp)
+{
+    do_parse_drive_unrealized(dev, str, ptr, propname, true, errp);
+}
+
+
 static void release_drive(Object *obj, const char *name, void *opaque)
 {
     DeviceState *dev = DEVICE(obj);
@@ -188,13 +251,15 @@ static void get_drive(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_drive(Object *obj, Visitor *v, const char *name, void *opaque,
                       Error **errp)
 {
-    set_pointer(obj, v, opaque, NULL, parse_drive, name, errp);
+    set_pointer(obj, v, opaque, parse_drive_realized, parse_drive_unrealized,
+                name, errp);
 }
 
 static void set_drive_iothread(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    set_pointer(obj, v, opaque, NULL, parse_drive_iothread, name, errp);
+    set_pointer(obj, v, opaque, parse_drive_realized_iothread,
+                parse_drive_unrealized_iothread, name, errp);
 }
 
 const PropertyInfo qdev_prop_drive = {
-- 
2.17.0


