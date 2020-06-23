Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8696AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F0C20716
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXBskfzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F0C20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnjr8-0003Nx-HO
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnjpo-0001fG-SY
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49992
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnjpl-0007hv-EP
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592922212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93r6nGHMD5ISEA8tB0ai9TdRd7SKuzIGhlrhL8D2N+o=;
 b=XXBskfzQqI3I11d5ll2/OgB0WYdSVmuFpyrY0QpBuxnNsiIAh5HxxiO/IGeXq3+IsOGhyk
 sx1lMnmha/Khf4CSuY36abpbXpSZ53mMOLw/lFu5Uc4lE8W4DmOtw4QuI6zKPzxcklgljj
 Ak3lhjqRvZ8i+d3NaW0bikIwoaZqEUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-j7hD1WEGNbuHEomT91aRUw-1; Tue, 23 Jun 2020 10:23:30 -0400
X-MC-Unique: j7hD1WEGNbuHEomT91aRUw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED83464AD4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 14:23:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75B8610016E8
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 14:23:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5813A1138477; Tue, 23 Jun 2020 16:23:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/16] qdev: Eliminate get_pointer(), set_pointer()
Date: Tue, 23 Jun 2020 16:23:19 +0200
Message-Id: <20200623142326.2349416-10-armbru@redhat.com>
In-Reply-To: <20200623142326.2349416-1-armbru@redhat.com>
References: <20200623142326.2349416-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We stopped using get_pointer() and set_pointer() for netdev in commit
23120b13c6 "net: don't use set/get_pointer() in set/get_netdev()"
(v2.3.0), and for chardev in commit becdfa00cf "char: replace PROP_CHR
with CharBackend" (v2.8.0).  With only the drive user left, they're
not helpful anymore.  Eliminate.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200622094227.1271650-10-armbru@redhat.com>
---
 hw/core/qdev-properties-system.c | 95 ++++++++++++--------------------
 1 file changed, 35 insertions(+), 60 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 70bfd4809b..9aa80495ee 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -25,29 +25,45 @@
 #include "sysemu/iothread.h"
 #include "sysemu/tpm_backend.h"
 
-static void get_pointer(Object *obj, Visitor *v, Property *prop,
-                        char *(*print)(void *ptr),
-                        const char *name, Error **errp)
+/* --- drive --- */
+
+static void get_drive(Object *obj, Visitor *v, const char *name, void *opaque,
+                      Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
     void **ptr = qdev_get_prop_ptr(dev, prop);
+    const char *value;
     char *p;
 
-    p = *ptr ? print(*ptr) : g_strdup("");
+    if (*ptr) {
+        value = blk_name(*ptr);
+        if (!*value) {
+            BlockDriverState *bs = blk_bs(*ptr);
+            if (bs) {
+                value = bdrv_get_node_name(bs);
+            }
+        }
+    } else {
+        value = "";
+    }
+
+    p = g_strdup(value);
     visit_type_str(v, name, &p, errp);
     g_free(p);
 }
 
-static void set_pointer(Object *obj, Visitor *v, Property *prop,
-                        void (*parse)(DeviceState *dev, const char *str,
-                                      void **ptr, const char *propname,
-                                      Error **errp),
-                        const char *name, Error **errp)
+static void set_drive_helper(Object *obj, Visitor *v, const char *name,
+                             void *opaque, bool iothread, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
     Error *local_err = NULL;
     void **ptr = qdev_get_prop_ptr(dev, prop);
     char *str;
+    BlockBackend *blk;
+    bool blk_created = false;
+    int ret;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
@@ -59,23 +75,12 @@ static void set_pointer(Object *obj, Visitor *v, Property *prop,
         error_propagate(errp, local_err);
         return;
     }
+
     if (!*str) {
         g_free(str);
         *ptr = NULL;
         return;
     }
-    parse(dev, str, ptr, prop->name, errp);
-    g_free(str);
-}
-
-/* --- drive --- */
-
-static void do_parse_drive(DeviceState *dev, const char *str, void **ptr,
-                           const char *propname, bool iothread, Error **errp)
-{
-    BlockBackend *blk;
-    bool blk_created = false;
-    int ret;
 
     blk = blk_by_name(str);
     if (!blk) {
@@ -101,7 +106,7 @@ static void do_parse_drive(DeviceState *dev, const char *str, void **ptr,
     }
     if (!blk) {
         error_setg(errp, "Property '%s.%s' can't find value '%s'",
-                   object_get_typename(OBJECT(dev)), propname, str);
+                   object_get_typename(OBJECT(dev)), prop->name, str);
         goto fail;
     }
     if (blk_attach_dev(blk, dev) < 0) {
@@ -126,18 +131,20 @@ fail:
         /* If we need to keep a reference, blk_attach_dev() took it */
         blk_unref(blk);
     }
+
+    g_free(str);
 }
 
-static void parse_drive(DeviceState *dev, const char *str, void **ptr,
-                        const char *propname, Error **errp)
+static void set_drive(Object *obj, Visitor *v, const char *name, void *opaque,
+                      Error **errp)
 {
-    do_parse_drive(dev, str, ptr, propname, false, errp);
+    set_drive_helper(obj, v, name, opaque, false, errp);
 }
 
-static void parse_drive_iothread(DeviceState *dev, const char *str, void **ptr,
-                                 const char *propname, Error **errp)
+static void set_drive_iothread(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
 {
-    do_parse_drive(dev, str, ptr, propname, true, errp);
+    set_drive_helper(obj, v, name, opaque, true, errp);
 }
 
 static void release_drive(Object *obj, const char *name, void *opaque)
@@ -156,38 +163,6 @@ static void release_drive(Object *obj, const char *name, void *opaque)
     }
 }
 
-static char *print_drive(void *ptr)
-{
-    const char *name;
-
-    name = blk_name(ptr);
-    if (!*name) {
-        BlockDriverState *bs = blk_bs(ptr);
-        if (bs) {
-            name = bdrv_get_node_name(bs);
-        }
-    }
-    return g_strdup(name);
-}
-
-static void get_drive(Object *obj, Visitor *v, const char *name, void *opaque,
-                      Error **errp)
-{
-    get_pointer(obj, v, opaque, print_drive, name, errp);
-}
-
-static void set_drive(Object *obj, Visitor *v, const char *name, void *opaque,
-                      Error **errp)
-{
-    set_pointer(obj, v, opaque, parse_drive, name, errp);
-}
-
-static void set_drive_iothread(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
-{
-    set_pointer(obj, v, opaque, parse_drive_iothread, name, errp);
-}
-
 const PropertyInfo qdev_prop_drive = {
     .name  = "str",
     .description = "Node name or ID of a block device to use as a backend",
-- 
2.26.2


