Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770EDC35240
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464F62082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOwsLBAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464F62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCb2-0000V7-EE
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTt-0005VV-To
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTs-0002wQ-Gx
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:49 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTs-0002va-AZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:48 -0500
Received: by mail-wm1-x32f.google.com with SMTP id p9so4409378wmc.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LRMkbeW5JbDxshKRBpUKtYjp3nf3vc5OCTS76DvNo+w=;
 b=gOwsLBAkV3EOZS+Q2IB/oBH9hxdrrgWPQj3VGlIhedGB9Fw6qHTTtOmxZfAARaBFOr
 QmkM4c38cdbCrFr+BnX5JpUTh3FS31Lcg7wMz2kvVULCh/Mn86spHDPaZZNgo65tIE2H
 BeyvTwFnYA0YBVaKgOzHUF2aqv2/mgHkOuHatVVeTYWzLUF7uhGByGtoDQbcEV4stDIH
 j0fqiDIW0ruDqRZHGMljC9nM5P3kjzBYXVeLSx5CBK47uWRgGOZvwFwobl3a84vsBRYf
 ES6zwlDp2F0e/akLVtF5ML1uHsL+AE2ZbkcYlAY+VT79SjVn8jDn/Yw5oqurEfds/CCv
 fPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LRMkbeW5JbDxshKRBpUKtYjp3nf3vc5OCTS76DvNo+w=;
 b=ZuzJ5Z+ORwIyBfjmp0VPWnAuBpIzljkxzWW4j82MvSy+H5KU14MY8H//TFBQhqySeO
 HHkEDzUCi/MTjd3P5vq+PzEWNtOqSsdmYnT/T8ZadE9n56hosHuX82IG5rnF5PQCEPR0
 aURApZK6u+uzUf9QakjiuHHe2JPqkLAAwen1nngs/aU/+heeRS12YESB4aRlXfPXP7H2
 7uWXGzqLI8qytGj3b+SPdmmuzY8+d66pvOFbIDGwaMLzVHCXpKSnHj9UtuGaNN0OoHt2
 7wcdzfvJiOEcTmmPkLbV4Zdx23V3dfuEAJZCCmFZn7HcJYiaXYYjop83QcSXZYi1xGMb
 0tlA==
X-Gm-Message-State: APjAAAXcU8Zxpi+MjJSUD6scCExg69UwYZacn29+tdv3NDDZEuBaq9il
 wmHrelKaSD2f4K/CPYXXS3t7JGQ16E90zw==
X-Google-Smtp-Source: APXvYqxVzdGkxH04DhP+yFcCKsYsyajvGowfEm9V5Ck7O1UaelXFMJvIjjsLrxGNT4Pl0v4bTkwgwg==
X-Received: by 2002:a05:600c:21c6:: with SMTP id
 x6mr6453435wmj.177.1580400946862; 
 Thu, 30 Jan 2020 08:15:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/26] hw/core/qdev: add trace events to help with resettable
 transition
Date: Thu, 30 Jan 2020 16:15:17 +0000
Message-Id: <20200130161533.8180-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

From: Damien Hedde <damien.hedde@greensocs.com>

Adds trace events to reset procedure and when updating the parent
bus of a device.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200123132823.1117486-3-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/qdev.c       | 29 ++++++++++++++++++++++++++---
 hw/core/trace-events |  9 +++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 00230eecb77..29e8c6b8dfc 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -38,6 +38,7 @@
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
+#include "trace.h"
 
 bool qdev_hotplug = false;
 static bool qdev_hot_added = false;
@@ -98,7 +99,11 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
     bool replugging = dev->parent_bus != NULL;
 
     if (replugging) {
-        /* Keep a reference to the device while it's not plugged into
+        trace_qdev_update_parent_bus(dev, object_get_typename(OBJECT(dev)),
+            dev->parent_bus, object_get_typename(OBJECT(dev->parent_bus)),
+            OBJECT(bus), object_get_typename(OBJECT(bus)));
+        /*
+         * Keep a reference to the device while it's not plugged into
          * any bus, to avoid it potentially evaporating when it is
          * dereffed in bus_remove_child().
          */
@@ -296,6 +301,18 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
     return hotplug_ctrl;
 }
 
+static int qdev_prereset(DeviceState *dev, void *opaque)
+{
+    trace_qdev_reset_tree(dev, object_get_typename(OBJECT(dev)));
+    return 0;
+}
+
+static int qbus_prereset(BusState *bus, void *opaque)
+{
+    trace_qbus_reset_tree(bus, object_get_typename(OBJECT(bus)));
+    return 0;
+}
+
 static int qdev_reset_one(DeviceState *dev, void *opaque)
 {
     device_legacy_reset(dev);
@@ -306,6 +323,7 @@ static int qdev_reset_one(DeviceState *dev, void *opaque)
 static int qbus_reset_one(BusState *bus, void *opaque)
 {
     BusClass *bc = BUS_GET_CLASS(bus);
+    trace_qbus_reset(bus, object_get_typename(OBJECT(bus)));
     if (bc->reset) {
         bc->reset(bus);
     }
@@ -314,7 +332,9 @@ static int qbus_reset_one(BusState *bus, void *opaque)
 
 void qdev_reset_all(DeviceState *dev)
 {
-    qdev_walk_children(dev, NULL, NULL, qdev_reset_one, qbus_reset_one, NULL);
+    trace_qdev_reset_all(dev, object_get_typename(OBJECT(dev)));
+    qdev_walk_children(dev, qdev_prereset, qbus_prereset,
+                       qdev_reset_one, qbus_reset_one, NULL);
 }
 
 void qdev_reset_all_fn(void *opaque)
@@ -324,7 +344,9 @@ void qdev_reset_all_fn(void *opaque)
 
 void qbus_reset_all(BusState *bus)
 {
-    qbus_walk_children(bus, NULL, NULL, qdev_reset_one, qbus_reset_one, NULL);
+    trace_qbus_reset_all(bus, object_get_typename(OBJECT(bus)));
+    qbus_walk_children(bus, qdev_prereset, qbus_prereset,
+                       qdev_reset_one, qbus_reset_one, NULL);
 }
 
 void qbus_reset_all_fn(void *opaque)
@@ -1105,6 +1127,7 @@ void device_legacy_reset(DeviceState *dev)
 {
     DeviceClass *klass = DEVICE_GET_CLASS(dev);
 
+    trace_qdev_reset(dev, object_get_typename(OBJECT(dev)));
     if (klass->reset) {
         klass->reset(dev);
     }
diff --git a/hw/core/trace-events b/hw/core/trace-events
index fe47a9c8cb1..a375aa88a48 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -1,2 +1,11 @@
 # loader.c
 loader_write_rom(const char *name, uint64_t gpa, uint64_t size, bool isrom) "%s: @0x%"PRIx64" size=0x%"PRIx64" ROM=%d"
+
+# qdev.c
+qdev_reset(void *obj, const char *objtype) "obj=%p(%s)"
+qdev_reset_all(void *obj, const char *objtype) "obj=%p(%s)"
+qdev_reset_tree(void *obj, const char *objtype) "obj=%p(%s)"
+qbus_reset(void *obj, const char *objtype) "obj=%p(%s)"
+qbus_reset_all(void *obj, const char *objtype) "obj=%p(%s)"
+qbus_reset_tree(void *obj, const char *objtype) "obj=%p(%s)"
+qdev_update_parent_bus(void *obj, const char *objtype, void *oldp, const char *oldptype, void *newp, const char *newptype) "obj=%p(%s) old_parent=%p(%s) new_parent=%p(%s)"
-- 
2.20.1


