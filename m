Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CC5C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1E32073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXB00Aoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1E32073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlHc-0007Pj-7k
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTlGj-0005sT-53
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTlGh-0001zL-W8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:52:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52217
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTlGh-0001yb-GW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588161165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iR/PkxKSellVCVy1YCIMxlTzekbc9CEHHA/wm6uB5xo=;
 b=fXB00AocEy5P5h6ofd/cYfKdKa4vk6TY9ZfH2DNVsmJD/r8dQIwGJjYHiFKTygjSZ56huq
 4Q/xbzjme9uhcTAeXEIFva2zrWYojFNQpIlOQZislGE/AOroOh+mCMjleWWENV9nXb2ZCs
 MHBE36N2/0pjPObD0xLPzmtIcs4LS7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-34pskwfIP--ntgo58Cj-1A-1; Wed, 29 Apr 2020 07:52:44 -0400
X-MC-Unique: 34pskwfIP--ntgo58Cj-1A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B303804A46;
 Wed, 29 Apr 2020 11:52:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBAC710016E8;
 Wed, 29 Apr 2020 11:52:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 196859D9D; Wed, 29 Apr 2020 13:52:37 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] ramfb: don't update RAMFBState on errors
Date: Wed, 29 Apr 2020 13:52:34 +0200
Message-Id: <20200429115236.28709-5-kraxel@redhat.com>
In-Reply-To: <20200429115236.28709-1-kraxel@redhat.com>
References: <20200429115236.28709-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Gerd Hoffmann <kraxel@redhat.com>, hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Store width & height & surface in local variables.  Update RAMFBState
with the new values only in case the ramfb_create_display_surface() call
succeeds.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 hw/display/ramfb.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 228defee5683..eb8b4bc49a2f 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -71,18 +71,25 @@ static DisplaySurface *ramfb_create_display_surface(int=
 width, int height,
 static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
 {
     RAMFBState *s =3D dev;
-    uint32_t fourcc, format;
+    DisplaySurface *surface;
+    uint32_t fourcc, format, width, height;
     hwaddr stride, addr;
=20
-    s->width  =3D be32_to_cpu(s->cfg.width);
-    s->height =3D be32_to_cpu(s->cfg.height);
-    stride    =3D be32_to_cpu(s->cfg.stride);
-    fourcc    =3D be32_to_cpu(s->cfg.fourcc);
-    addr      =3D be64_to_cpu(s->cfg.addr);
-    format    =3D qemu_drm_format_to_pixman(fourcc);
+    width  =3D be32_to_cpu(s->cfg.width);
+    height =3D be32_to_cpu(s->cfg.height);
+    stride =3D be32_to_cpu(s->cfg.stride);
+    fourcc =3D be32_to_cpu(s->cfg.fourcc);
+    addr   =3D be64_to_cpu(s->cfg.addr);
+    format =3D qemu_drm_format_to_pixman(fourcc);
=20
-    s->ds =3D ramfb_create_display_surface(s->width, s->height,
-                                         format, stride, addr);
+    surface =3D ramfb_create_display_surface(width, height,
+                                           format, stride, addr);
+    if (!surface)
+        return;
+
+    s->width =3D width;
+    s->height =3D height;
+    s->ds =3D surface;
 }
=20
 void ramfb_display_update(QemuConsole *con, RAMFBState *s)
--=20
2.18.2


