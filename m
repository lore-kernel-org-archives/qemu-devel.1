Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F227CC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 10:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B830824C28
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 10:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B830824C28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY6N5-0002u8-0C
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 06:08:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1hY6J8-00085K-4F
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 06:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1hY6J6-0000oP-8X
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 06:04:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:33967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tina.zhang@intel.com>)
	id 1hY6J4-0000aq-K8
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 06:04:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Jun 2019 03:04:33 -0700
X-ExtLoop1: 1
Received: from gvt.bj.intel.com ([10.238.158.187])
	by orsmga007.jf.intel.com with ESMTP; 04 Jun 2019 03:04:31 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: intel-gvt-dev@lists.freedesktop.org,
	qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 17:58:47 +0800
Message-Id: <20190604095847.10532-4-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604095847.10532-1-tina.zhang@intel.com>
References: <20190604095847.10532-1-tina.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.126
Subject: [Qemu-devel] [RFC PATCH 3/3] vfio/display: Refresh display
 depending on vGPU page flip events
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kevin.tian@intel.com, zhenyuw@linux.intel.com,
	Tina Zhang <tina.zhang@intel.com>, alex.williamson@redhat.com,
	zhiyuan.lv@intel.com, hang.yuan@intel.com, zhi.a.wang@intel.com,
	kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use vGPU plane page flip events to refresh display.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 hw/vfio/display.c             | 249 +++++++++++++++++++++++++++++-----
 include/hw/vfio/vfio-common.h |   8 ++
 2 files changed, 225 insertions(+), 32 deletions(-)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 2c2d3e5b71..6ef383b5e8 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -288,44 +288,54 @@ static void vfio_display_dmabuf_update(void *opaque)
     VFIODMABuf *primary, *cursor;
     bool free_bufs = false, new_cursor = false;;
 
-    primary = vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_PRIMARY);
-    if (primary == NULL) {
-        if (dpy->ramfb) {
-            ramfb_display_update(dpy->con, dpy->ramfb);
-        }
-        return;
+    if (dpy->event_flags & VFIO_IRQ_EVENT_ENABLE) {
+        dpy_update_interval(dpy->con, GUI_REFRESH_INTERVAL_IDLE);
     }
 
-    if (dpy->dmabuf.primary != primary) {
-        dpy->dmabuf.primary = primary;
-        qemu_console_resize(dpy->con,
-                            primary->buf.width, primary->buf.height);
-        dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
-        free_bufs = true;
-    }
+    if (!dpy->event_flags ||
+        (dpy->event_flags & VFIO_IRQ_EVENT_PRIMRAY_PLANE_FLIP)) {
+        primary = vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_PRIMARY);
+        if (primary == NULL) {
+            if (dpy->ramfb) {
+                ramfb_display_update(dpy->con, dpy->ramfb);
+            }
+            return;
+        }
 
-    cursor = vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_CURSOR);
-    if (dpy->dmabuf.cursor != cursor) {
-        dpy->dmabuf.cursor = cursor;
-        new_cursor = true;
-        free_bufs = true;
+        if (dpy->dmabuf.primary != primary) {
+            dpy->dmabuf.primary = primary;
+            qemu_console_resize(dpy->con,
+                                primary->buf.width, primary->buf.height);
+            dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
+            free_bufs = true;
+        }
     }
 
-    if (cursor && (new_cursor || cursor->hot_updates)) {
-        bool have_hot = (cursor->hot_x != 0xffffffff &&
-                         cursor->hot_y != 0xffffffff);
-        dpy_gl_cursor_dmabuf(dpy->con, &cursor->buf, have_hot,
-                             cursor->hot_x, cursor->hot_y);
-        cursor->hot_updates = 0;
-    } else if (!cursor && new_cursor) {
-        dpy_gl_cursor_dmabuf(dpy->con, NULL, false, 0, 0);
-    }
+    if (!dpy->event_flags ||
+        (dpy->event_flags & VFIO_IRQ_EVENT_CURSOR_PLANE_FLIP)) {
+        cursor = vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_CURSOR);
+        if (dpy->dmabuf.cursor != cursor) {
+            dpy->dmabuf.cursor = cursor;
+            new_cursor = true;
+            free_bufs = true;
+        }
+
+        if (cursor && (new_cursor || cursor->hot_updates)) {
+            bool have_hot = (cursor->hot_x != 0xffffffff &&
+                             cursor->hot_y != 0xffffffff);
+            dpy_gl_cursor_dmabuf(dpy->con, &cursor->buf, have_hot,
+                                 cursor->hot_x, cursor->hot_y);
+            cursor->hot_updates = 0;
+        } else if (!cursor && new_cursor) {
+            dpy_gl_cursor_dmabuf(dpy->con, NULL, false, 0, 0);
+        }
 
-    if (cursor && cursor->pos_updates) {
-        dpy_gl_cursor_position(dpy->con,
-                               cursor->pos_x,
-                               cursor->pos_y);
-        cursor->pos_updates = 0;
+        if (cursor && cursor->pos_updates) {
+            dpy_gl_cursor_position(dpy->con,
+                                   cursor->pos_x,
+                                   cursor->pos_y);
+            cursor->pos_updates = 0;
+        }
     }
 
     dpy_gl_update(dpy->con, 0, 0, primary->buf.width, primary->buf.height);
@@ -340,6 +350,7 @@ static const GraphicHwOps vfio_display_dmabuf_ops = {
     .ui_info    = vfio_display_edid_ui_info,
 };
 
+static int vfio_register_display_notifier(VFIOPCIDevice *vdev);
 static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
 {
     if (!display_opengl) {
@@ -355,6 +366,8 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
         vdev->dpy->ramfb = ramfb_setup(DEVICE(vdev), errp);
     }
     vfio_display_edid_init(vdev);
+    vfio_register_display_notifier(vdev);
+
     return 0;
 }
 
@@ -495,6 +508,177 @@ static void vfio_display_region_exit(VFIODisplay *dpy)
 
 /* ---------------------------------------------------------------------- */
 
+static void primary_plane_update(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIODisplay *dpy = vdev->dpy;
+
+    if (!event_notifier_test_and_clear(&dpy->pri_event_notifier)) {
+        return;
+    }
+
+    dpy->event_flags |= VFIO_IRQ_EVENT_PRIMRAY_PLANE_FLIP;
+    graphic_hw_refresh(dpy->con);
+    dpy->event_flags &= ~VFIO_IRQ_EVENT_PRIMRAY_PLANE_FLIP;
+}
+
+static void cursor_plane_update(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIODisplay *dpy = vdev->dpy;
+    static int times;
+
+    if (!event_notifier_test_and_clear(&dpy->cur_event_notifier)) {
+        return;
+    }
+
+    /* Have to skip some cursor events due to performance impact */
+    if (times++ / 2) {
+        times = 0;
+        dpy->event_flags |= VFIO_IRQ_EVENT_CURSOR_PLANE_FLIP;
+        graphic_hw_refresh(dpy->con);
+        dpy->event_flags &= ~VFIO_IRQ_EVENT_CURSOR_PLANE_FLIP;
+    }
+}
+
+static int register_display_notifier(VFIOPCIDevice *vdev,
+                                     uint32_t type, uint32_t subtype,
+                                     EventNotifier *notifier,
+                                     void (*handler)(void *opaque))
+{
+    struct vfio_irq_info *irq;
+    struct vfio_irq_set *irq_set;
+    int argsz;
+    int32_t *pfd;
+    int ret;
+
+    ret = vfio_get_dev_irq_info(&vdev->vbasedev,
+                                type,
+                                subtype,
+                                &irq);
+    if (ret) {
+        goto out;
+    }
+
+    ret = event_notifier_init(notifier, 0);
+    if (ret) {
+        error_report("vfio: Unable to init event notifier for device request");
+        goto out;
+    }
+
+    argsz = sizeof(*irq_set) + sizeof(*pfd);
+
+    irq_set = g_malloc0(argsz);
+    irq_set->argsz = argsz;
+    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
+                     VFIO_IRQ_SET_ACTION_TRIGGER;
+    irq_set->index = irq->index;
+    irq_set->start = 0;
+    irq_set->count = 1;
+    pfd = (int32_t *)&irq_set->data;
+
+    *pfd = event_notifier_get_fd(notifier);
+    qemu_set_fd_handler(*pfd, handler, NULL, vdev);
+
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
+    if (ret) {
+        error_report("vfio: Failed to set up device request notification");
+        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
+        event_notifier_cleanup(notifier);
+    }
+
+    g_free(irq_set);
+
+out:
+    return ret;
+}
+
+static int vfio_register_display_notifier(VFIOPCIDevice *vdev)
+{
+    VFIODisplay *dpy = vdev->dpy;
+    int ret;
+
+    ret = register_display_notifier(vdev, VFIO_IRQ_TYPE_GFX,
+                                    VFIO_IRQ_SUBTYPE_GFX_PRI_PLANE_FLIP,
+                                    &dpy->pri_event_notifier,
+                                    primary_plane_update);
+
+    if (ret) {
+        goto out;
+    }
+
+    ret = register_display_notifier(vdev, VFIO_IRQ_TYPE_GFX,
+                                   VFIO_IRQ_SUBTYPE_GFX_CUR_PLANE_FLIP,
+                                   &dpy->cur_event_notifier,
+                                   cursor_plane_update);
+out:
+    if (ret) {
+        dpy->event_flags = 0;
+    } else {
+        dpy->event_flags = VFIO_IRQ_EVENT_ENABLE;
+    }
+
+    return ret;
+}
+
+static void unregister_display_notifier(VFIOPCIDevice *vdev,
+                                       uint32_t type, uint32_t subtype,
+                                       EventNotifier *notifier)
+{
+    VFIODisplay *dpy = vdev->dpy;
+    int argsz;
+    struct vfio_irq_info *irq;
+    struct vfio_irq_set *irq_set;
+    int32_t *pfd;
+    int ret;
+
+    if (!dpy->event_flags) {
+        return;
+    }
+
+    ret = vfio_get_dev_irq_info(&vdev->vbasedev,
+                                type,
+                                subtype,
+                                &irq);
+    if (ret) {
+        return ;
+    }
+
+    argsz = sizeof(*irq_set) + sizeof(*pfd);
+
+    irq_set = g_malloc0(argsz);
+    irq_set->argsz = argsz;
+    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
+                     VFIO_IRQ_SET_ACTION_TRIGGER;
+    irq_set->index = irq->index;
+    irq_set->start = 0;
+    irq_set->count = 1;
+    pfd = (int32_t *)&irq_set->data;
+    *pfd = -1;
+
+    if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
+        error_report("vfio: Failed to de-assign device request fd: %m");
+    }
+    g_free(irq_set);
+    qemu_set_fd_handler(event_notifier_get_fd(notifier),
+                        NULL, NULL, vdev);
+    event_notifier_cleanup(notifier);
+}
+
+static void vfio_unregister_display_notifier(VFIOPCIDevice *vdev)
+{
+    VFIODisplay *dpy = vdev->dpy;
+
+    unregister_display_notifier(vdev, VFIO_IRQ_TYPE_GFX,
+                                VFIO_IRQ_SUBTYPE_GFX_PRI_PLANE_FLIP,
+                                &dpy->pri_event_notifier);
+
+    unregister_display_notifier(vdev, VFIO_IRQ_TYPE_GFX,
+                                VFIO_IRQ_SUBTYPE_GFX_CUR_PLANE_FLIP,
+                                &dpy->cur_event_notifier);
+    dpy->event_flags = false;
+}
+
 int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
 {
     struct vfio_device_gfx_plane_info probe;
@@ -531,6 +715,7 @@ void vfio_display_finalize(VFIOPCIDevice *vdev)
         return;
     }
 
+    vfio_unregister_display_notifier(vdev);
     graphic_console_close(vdev->dpy->con);
     vfio_display_dmabuf_exit(vdev->dpy);
     vfio_display_region_exit(vdev->dpy);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 5cab6a1b81..a3f03b20e8 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -27,6 +27,7 @@
 #include "qemu/notify.h"
 #include "ui/console.h"
 #include "hw/display/ramfb.h"
+#include "qemu/event_notifier.h"
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 #endif
@@ -145,6 +146,10 @@ typedef struct VFIODMABuf {
     QTAILQ_ENTRY(VFIODMABuf) next;
 } VFIODMABuf;
 
+#define VFIO_IRQ_EVENT_ENABLE              (1 << 0)
+#define VFIO_IRQ_EVENT_PRIMRAY_PLANE_FLIP  (1 << 1)
+#define VFIO_IRQ_EVENT_CURSOR_PLANE_FLIP   (1 << 2)
+
 typedef struct VFIODisplay {
     QemuConsole *con;
     RAMFBState *ramfb;
@@ -152,6 +157,9 @@ typedef struct VFIODisplay {
     struct vfio_region_gfx_edid *edid_regs;
     uint8_t *edid_blob;
     QEMUTimer *edid_link_timer;
+    EventNotifier pri_event_notifier;
+    EventNotifier cur_event_notifier;
+    uint32_t event_flags;
     struct {
         VFIORegion buffer;
         DisplaySurface *surface;
-- 
2.17.1


