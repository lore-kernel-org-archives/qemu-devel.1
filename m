Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D690C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D79020671
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDa9udDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D79020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahTD-0001Q8-FR
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jahS2-0008CT-MB
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:13:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26982
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jahS0-0005x7-VM
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589814788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=ddE1J3IeNEdn4AeoJi2TcC6T3/GhYGv2cotZGl9fFUk=;
 b=VDa9udDDJ//8FdQkHJzoISMhGsDN5VIVEkZhl4jo4XxpTQ5pRQnsnSt0U86QFD1kUiISkM
 u6iPM3oA1y7Klw+QT65Hr7mHNIhg96yVD71ZG0EgDtyiowtzCw1hbjlr8UvfURj2jMhIUE
 Yr2q5SP2G3v0eLtLFAvFnGJXj8/by/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-PSAQBG95MZmhcie1xhnpzQ-1; Mon, 18 May 2020 11:13:06 -0400
X-MC-Unique: PSAQBG95MZmhcie1xhnpzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 662EB107ACF4;
 Mon, 18 May 2020 15:13:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A59375D9DC;
 Mon, 18 May 2020 15:12:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9C38117538; Mon, 18 May 2020 17:12:55 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] Revert "hw/display/ramfb: initialize fw-config space with
 xres/ yres"
Date: Mon, 18 May 2020 17:12:50 +0200
Message-Id: <20200518151255.10785-4-kraxel@redhat.com>
In-Reply-To: <20200518151255.10785-1-kraxel@redhat.com>
References: <20200518151255.10785-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Thomas Huth <huth@tuxfamily.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Hou Qiming <hqm03ster@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit f79081b4b71b72640bedd40a7cd76f864c8287f1.

Patch has broken byteorder handling: RAMFBCfg fields are in bigendian
byteorder, the reset function doesn't care so native byteorder is used
instead.  Given this went unnoticed so far the feature is obviously
unused, so just revert the patch.

Cc: Hou Qiming <hqm03ster@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Message-id: 20200429115236.28709-2-kraxel@redhat.com
---
 include/hw/display/ramfb.h    |  2 +-
 hw/display/ramfb-standalone.c | 12 +-----------
 hw/display/ramfb.c            | 16 +---------------
 hw/vfio/display.c             |  4 ++--
 stubs/ramfb.c                 |  2 +-
 5 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
index f6c2de93b222..b33a2c467b28 100644
--- a/include/hw/display/ramfb.h
+++ b/include/hw/display/ramfb.h
@@ -4,7 +4,7 @@
 /* ramfb.c */
 typedef struct RAMFBState RAMFBState;
 void ramfb_display_update(QemuConsole *con, RAMFBState *s);
-RAMFBState *ramfb_setup(DeviceState *dev, Error **errp);
+RAMFBState *ramfb_setup(Error **errp);
 
 /* ramfb-standalone.c */
 #define TYPE_RAMFB_DEVICE "ramfb"
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index d76a9d0fe2c9..b18db97eeb1b 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -3,7 +3,6 @@
 #include "qemu/module.h"
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
-#include "hw/isa/isa.h"
 #include "hw/display/ramfb.h"
 #include "ui/console.h"
 
@@ -13,8 +12,6 @@ typedef struct RAMFBStandaloneState {
     SysBusDevice parent_obj;
     QemuConsole *con;
     RAMFBState *state;
-    uint32_t xres;
-    uint32_t yres;
 } RAMFBStandaloneState;
 
 static void display_update_wrapper(void *dev)
@@ -37,22 +34,15 @@ static void ramfb_realizefn(DeviceState *dev, Error **errp)
     RAMFBStandaloneState *ramfb = RAMFB(dev);
 
     ramfb->con = graphic_console_init(dev, 0, &wrapper_ops, dev);
-    ramfb->state = ramfb_setup(dev, errp);
+    ramfb->state = ramfb_setup(errp);
 }
 
-static Property ramfb_properties[] = {
-    DEFINE_PROP_UINT32("xres", RAMFBStandaloneState, xres, 0),
-    DEFINE_PROP_UINT32("yres", RAMFBStandaloneState, yres, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void ramfb_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->realize = ramfb_realizefn;
-    device_class_set_props(dc, ramfb_properties);
     dc->desc = "ram framebuffer standalone device";
     dc->user_creatable = true;
 }
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 7ba07c80f6e1..bd4746dc1768 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -13,7 +13,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu/option.h"
 #include "hw/loader.h"
 #include "hw/display/ramfb.h"
 #include "ui/console.h"
@@ -31,7 +30,6 @@ struct QEMU_PACKED RAMFBCfg {
 struct RAMFBState {
     DisplaySurface *ds;
     uint32_t width, height;
-    uint32_t starting_width, starting_height;
     struct RAMFBCfg cfg;
     bool locked;
 };
@@ -117,11 +115,9 @@ static void ramfb_reset(void *opaque)
     RAMFBState *s = (RAMFBState *)opaque;
     s->locked = false;
     memset(&s->cfg, 0, sizeof(s->cfg));
-    s->cfg.width = s->starting_width;
-    s->cfg.height = s->starting_height;
 }
 
-RAMFBState *ramfb_setup(DeviceState* dev, Error **errp)
+RAMFBState *ramfb_setup(Error **errp)
 {
     FWCfgState *fw_cfg = fw_cfg_find();
     RAMFBState *s;
@@ -133,16 +129,6 @@ RAMFBState *ramfb_setup(DeviceState* dev, Error **errp)
 
     s = g_new0(RAMFBState, 1);
 
-    const char *s_fb_width = qemu_opt_get(dev->opts, "xres");
-    const char *s_fb_height = qemu_opt_get(dev->opts, "yres");
-    if (s_fb_width) {
-        s->cfg.width = atoi(s_fb_width);
-        s->starting_width = s->cfg.width;
-    }
-    if (s_fb_height) {
-        s->cfg.height = atoi(s_fb_height);
-        s->starting_height = s->cfg.height;
-    }
     s->locked = false;
 
     rom_add_vga("vgabios-ramfb.bin");
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index f4977c66e1b5..a57a22674d62 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -353,7 +353,7 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
                                           &vfio_display_dmabuf_ops,
                                           vdev);
     if (vdev->enable_ramfb) {
-        vdev->dpy->ramfb = ramfb_setup(DEVICE(vdev), errp);
+        vdev->dpy->ramfb = ramfb_setup(errp);
     }
     vfio_display_edid_init(vdev);
     return 0;
@@ -479,7 +479,7 @@ static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
                                           &vfio_display_region_ops,
                                           vdev);
     if (vdev->enable_ramfb) {
-        vdev->dpy->ramfb = ramfb_setup(DEVICE(vdev), errp);
+        vdev->dpy->ramfb = ramfb_setup(errp);
     }
     return 0;
 }
diff --git a/stubs/ramfb.c b/stubs/ramfb.c
index 0799093a5d6e..48143f33542f 100644
--- a/stubs/ramfb.c
+++ b/stubs/ramfb.c
@@ -6,7 +6,7 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
 {
 }
 
-RAMFBState *ramfb_setup(DeviceState* dev, Error **errp)
+RAMFBState *ramfb_setup(Error **errp)
 {
     error_setg(errp, "ramfb support not available");
     return NULL;
-- 
2.18.4


