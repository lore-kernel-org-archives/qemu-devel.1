Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344D5C55186
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0097F20575
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3Awnl1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0097F20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRCHS-0007ct-41
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 06:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jRCD5-0002Oh-4K
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jRCD4-0004aF-MW
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:02:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32452
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jRCD4-0004SP-5q
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587549744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4+U+IFAQKG2D0+8CRwtUCE59kHFkczepZEFwLCC2K8=;
 b=S3Awnl1/yxsG7ab/siJ8ybbWHw0aojTSrSg0fr/SpWSVzXJVnhyoK/14i/JCFifI6oJZmY
 DoR8OkgHdIQYwWDv6XjAsVckt811dYaN94fF+tkoyjHhkhUGoAiaPn5kZZFhKW4Kll45Sh
 XwHtC/XUtAtxSd/DeDxJJCRhL3UmdY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-kp7trzsTOxy_h0srseXFww-1; Wed, 22 Apr 2020 06:02:23 -0400
X-MC-Unique: kp7trzsTOxy_h0srseXFww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A6258017F5;
 Wed, 22 Apr 2020 10:02:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B166F600D2;
 Wed, 22 Apr 2020 10:02:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D83369D9B; Wed, 22 Apr 2020 12:02:11 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] Revert "hw/display/ramfb: lock guest resolution after
 it's set"
Date: Wed, 22 Apr 2020 12:02:08 +0200
Message-Id: <20200422100211.30614-3-kraxel@redhat.com>
In-Reply-To: <20200422100211.30614-1-kraxel@redhat.com>
References: <20200422100211.30614-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, lersek@redhat.com,
 hqm03ster@gmail.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit a9e0cb67b7f4c485755659f9b764c38b5f970de4.

This breaks OVMF.  Reproducer: Just hit 'ESC' at early boot to enter
firmware setup.  OVMF wants switch from (default) 800x600 to 640x480 for
that, and this patch blocks it.

Cc: Hou Qiming <hqm03ster@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ramfb.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index bd4746dc1768..9d41c2ad2868 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -31,7 +31,6 @@ struct RAMFBState {
     DisplaySurface *ds;
     uint32_t width, height;
     struct RAMFBCfg cfg;
-    bool locked;
 };
=20
 static void ramfb_unmap_display_surface(pixman_image_t *image, void *unuse=
d)
@@ -72,25 +71,18 @@ static DisplaySurface *ramfb_create_display_surface(int=
 width, int height,
 static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
 {
     RAMFBState *s =3D dev;
-    uint32_t fourcc, format, width, height;
+    uint32_t fourcc, format;
     hwaddr stride, addr;
=20
-    width     =3D be32_to_cpu(s->cfg.width);
-    height    =3D be32_to_cpu(s->cfg.height);
+    s->width  =3D be32_to_cpu(s->cfg.width);
+    s->height =3D be32_to_cpu(s->cfg.height);
     stride    =3D be32_to_cpu(s->cfg.stride);
     fourcc    =3D be32_to_cpu(s->cfg.fourcc);
     addr      =3D be64_to_cpu(s->cfg.addr);
     format    =3D qemu_drm_format_to_pixman(fourcc);
=20
     fprintf(stderr, "%s: %dx%d @ 0x%" PRIx64 "\n", __func__,
-            width, height, addr);
-    if (s->locked) {
-        fprintf(stderr, "%s: resolution locked, change rejected\n", __func=
__);
-        return;
-    }
-    s->locked =3D true;
-    s->width =3D width;
-    s->height =3D height;
+            s->width, s->height, addr);
     s->ds =3D ramfb_create_display_surface(s->width, s->height,
                                          format, stride, addr);
 }
@@ -110,13 +102,6 @@ void ramfb_display_update(QemuConsole *con, RAMFBState=
 *s)
     dpy_gfx_update_full(con);
 }
=20
-static void ramfb_reset(void *opaque)
-{
-    RAMFBState *s =3D (RAMFBState *)opaque;
-    s->locked =3D false;
-    memset(&s->cfg, 0, sizeof(s->cfg));
-}
-
 RAMFBState *ramfb_setup(Error **errp)
 {
     FWCfgState *fw_cfg =3D fw_cfg_find();
@@ -129,12 +114,9 @@ RAMFBState *ramfb_setup(Error **errp)
=20
     s =3D g_new0(RAMFBState, 1);
=20
-    s->locked =3D false;
-
     rom_add_vga("vgabios-ramfb.bin");
     fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
                              NULL, ramfb_fw_cfg_write, s,
                              &s->cfg, sizeof(s->cfg), false);
-    qemu_register_reset(ramfb_reset, s);
     return s;
 }
--=20
2.18.2


