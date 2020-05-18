Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F3CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2273C20671
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1OpDumv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2273C20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahVY-0004i2-Bk
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jahS7-0008DI-Dn
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:13:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23405
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jahS0-0005wr-U4
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589814787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=+iI8FGRKs81adLpcBjB+Oh9YO05lIOQpzFUXVMZs9XA=;
 b=P1OpDumv24JBrnngvxcOqJVEK0+tzFiIygOuFUF2TqiPr5eQlSRThDQQMOBqgCZU/iNjiT
 xq9Dylt+a/4o/TnpO4Fp/EtGnhA9e5RxofaFDrL2/5zA/3I2b/n1W0/av4S1FUQ3E+IR6d
 vRi7qRTk6EKOTLW+rUIAV74X0l1dNoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-ZLrXOuxSPE2VLEQSGIjyag-1; Mon, 18 May 2020 11:13:04 -0400
X-MC-Unique: ZLrXOuxSPE2VLEQSGIjyag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99CC1805726;
 Mon, 18 May 2020 15:13:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6B8A99ED;
 Mon, 18 May 2020 15:12:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A50F59DAD; Mon, 18 May 2020 17:12:55 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] Revert "hw/display/ramfb: lock guest resolution after it's
 set"
Date: Mon, 18 May 2020 17:12:51 +0200
Message-Id: <20200518151255.10785-5-kraxel@redhat.com>
In-Reply-To: <20200518151255.10785-1-kraxel@redhat.com>
References: <20200518151255.10785-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

This reverts commit a9e0cb67b7f4c485755659f9b764c38b5f970de4.

This breaks OVMF.  Reproducer: Just hit 'ESC' at early boot to enter
firmware setup.  OVMF wants switch from (default) 800x600 to 640x480 for
that, and this patch blocks it.

Cc: Hou Qiming <hqm03ster@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-id: 20200429115236.28709-3-kraxel@redhat.com
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
 
 static void ramfb_unmap_display_surface(pixman_image_t *image, void *unused)
@@ -72,25 +71,18 @@ static DisplaySurface *ramfb_create_display_surface(int width, int height,
 static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
 {
     RAMFBState *s = dev;
-    uint32_t fourcc, format, width, height;
+    uint32_t fourcc, format;
     hwaddr stride, addr;
 
-    width     = be32_to_cpu(s->cfg.width);
-    height    = be32_to_cpu(s->cfg.height);
+    s->width  = be32_to_cpu(s->cfg.width);
+    s->height = be32_to_cpu(s->cfg.height);
     stride    = be32_to_cpu(s->cfg.stride);
     fourcc    = be32_to_cpu(s->cfg.fourcc);
     addr      = be64_to_cpu(s->cfg.addr);
     format    = qemu_drm_format_to_pixman(fourcc);
 
     fprintf(stderr, "%s: %dx%d @ 0x%" PRIx64 "\n", __func__,
-            width, height, addr);
-    if (s->locked) {
-        fprintf(stderr, "%s: resolution locked, change rejected\n", __func__);
-        return;
-    }
-    s->locked = true;
-    s->width = width;
-    s->height = height;
+            s->width, s->height, addr);
     s->ds = ramfb_create_display_surface(s->width, s->height,
                                          format, stride, addr);
 }
@@ -110,13 +102,6 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
     dpy_gfx_update_full(con);
 }
 
-static void ramfb_reset(void *opaque)
-{
-    RAMFBState *s = (RAMFBState *)opaque;
-    s->locked = false;
-    memset(&s->cfg, 0, sizeof(s->cfg));
-}
-
 RAMFBState *ramfb_setup(Error **errp)
 {
     FWCfgState *fw_cfg = fw_cfg_find();
@@ -129,12 +114,9 @@ RAMFBState *ramfb_setup(Error **errp)
 
     s = g_new0(RAMFBState, 1);
 
-    s->locked = false;
-
     rom_add_vga("vgabios-ramfb.bin");
     fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
                              NULL, ramfb_fw_cfg_write, s,
                              &s->cfg, sizeof(s->cfg), false);
-    qemu_register_reset(ramfb_reset, s);
     return s;
 }
-- 
2.18.4


