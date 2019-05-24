Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750CBC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078EB217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078EB217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51292 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU68e-0007kV-Uy
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 05:05:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hU636-0003f6-6M
	for qemu-devel@nongnu.org; Fri, 24 May 2019 04:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hU60x-00007Y-Re
	for qemu-devel@nongnu.org; Fri, 24 May 2019 04:57:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hU60x-000073-JT
	for qemu-devel@nongnu.org; Fri, 24 May 2019 04:57:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BCD4308FBA9;
	Fri, 24 May 2019 08:57:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-101.ams2.redhat.com
	[10.36.116.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8AE0A679D6;
	Fri, 24 May 2019 08:57:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 75CB317536; Fri, 24 May 2019 10:57:17 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 10:57:15 +0200
Message-Id: <20190524085717.3493-2-kraxel@redhat.com>
In-Reply-To: <20190524085717.3493-1-kraxel@redhat.com>
References: <20190524085717.3493-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 24 May 2019 08:57:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/3] hw/display/ramfb: fix guest memory
 un-mapping
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Hou Qiming <hqm03ster@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hou Qiming <hqm03ster@gmail.com>

Pulled back the `qemu_create_displaysurface_guestmem` function to create
the display surface so that the guest memory gets properly unmapped.

Signed-off-by: HOU Qiming <hqm03ster@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-id: 20190513115731.17588-2-marcel.apfelbaum@gmail.com
[rename the new functions and use QEMU coding style]
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ramfb.c | 51 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 25c8ad7c252e..1955b048dd24 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -32,33 +32,58 @@ struct RAMFBState {
     struct RAMFBCfg cfg;
 };
 
+static void ramfb_unmap_display_surface(pixman_image_t *image, void *unused)
+{
+    void *data = pixman_image_get_data(image);
+    uint32_t size = pixman_image_get_stride(image) *
+        pixman_image_get_height(image);
+    cpu_physical_memory_unmap(data, size, 0, 0);
+}
+
+static DisplaySurface *ramfb_create_display_surface(int width, int height,
+                                                    pixman_format_code_t format,
+                                                    int linesize, uint64_t addr)
+{
+    DisplaySurface *surface;
+    hwaddr size;
+    void *data;
+
+    if (linesize == 0) {
+        linesize = width * PIXMAN_FORMAT_BPP(format) / 8;
+    }
+
+    size = (hwaddr)linesize * height;
+    data = cpu_physical_memory_map(addr, &size, 0);
+    if (size != (hwaddr)linesize * height) {
+        cpu_physical_memory_unmap(data, size, 0, 0);
+        return NULL;
+    }
+
+    surface = qemu_create_displaysurface_from(width, height,
+                                              format, linesize, data);
+    pixman_image_set_destroy_function(surface->image,
+                                      ramfb_unmap_display_surface, NULL);
+
+    return surface;
+}
+
 static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
 {
     RAMFBState *s = dev;
-    void *framebuffer;
     uint32_t fourcc, format;
-    hwaddr stride, addr, length;
+    hwaddr stride, addr;
 
     s->width  = be32_to_cpu(s->cfg.width);
     s->height = be32_to_cpu(s->cfg.height);
     stride    = be32_to_cpu(s->cfg.stride);
     fourcc    = be32_to_cpu(s->cfg.fourcc);
     addr      = be64_to_cpu(s->cfg.addr);
-    length    = stride * s->height;
     format    = qemu_drm_format_to_pixman(fourcc);
 
     fprintf(stderr, "%s: %dx%d @ 0x%" PRIx64 "\n", __func__,
             s->width, s->height, addr);
-    framebuffer = address_space_map(&address_space_memory,
-                                    addr, &length, false,
-                                    MEMTXATTRS_UNSPECIFIED);
-    if (!framebuffer || length < stride * s->height) {
-        s->width = 0;
-        s->height = 0;
-        return;
-    }
-    s->ds = qemu_create_displaysurface_from(s->width, s->height,
-                                            format, stride, framebuffer);
+    s->ds = ramfb_create_display_surface(s->width, s->height,
+                                         format, stride, addr);
 }
 
 void ramfb_display_update(QemuConsole *con, RAMFBState *s)
-- 
2.18.1


