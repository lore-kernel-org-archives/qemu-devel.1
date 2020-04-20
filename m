Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CE8C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605D1206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTIydP7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605D1206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQRuB-0008VF-FN
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 04:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56492 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRrC-0002u4-Kw
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:47 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRrC-0006yJ-3K
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28667
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jQRrB-0006xK-MV
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587371565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zizm9RjgByTgrCBzPtpJ+e+xEYQesiEI32NKmLTT0yY=;
 b=ZTIydP7wlLQeP44+kL5hoYjRBrkuLLwfMGIY4Du0hofHAdcUYwNsYHv27mDrD9R3HuR0Og
 SGuni1ks/f63ybwOcJf9/qLg44o8MHZTJoJXoet4hdLiSS5MnVex1LWBGI/vQVXW5OJGxb
 Byhhhs9UZP2pOpXJCVRpC2Jk4V37P+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-EAj6ecJYPCiwZdc19PnMpg-1; Mon, 20 Apr 2020 04:32:43 -0400
X-MC-Unique: EAj6ecJYPCiwZdc19PnMpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71BDD107ACC4
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 08:32:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C04715C28F;
 Mon, 20 Apr 2020 08:32:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B452511358C3; Mon, 20 Apr 2020 10:32:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/11] bochs-display: Fix vgamem=SIZE error handling
Date: Mon, 20 Apr 2020 10:32:32 +0200
Message-Id: <20200420083236.19309-8-armbru@redhat.com>
In-Reply-To: <20200420083236.19309-1-armbru@redhat.com>
References: <20200420083236.19309-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 04:32:42
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bochs_display_realize() rejects out-of-range vgamem.  The error
handling is broken:

    $ qemu-system-x86_64 -S -display none -monitor stdio
    QEMU 4.2.93 monitor - type 'help' for more information
    (qemu) device_add bochs-display,vgamem=3D1
    Error: bochs-display: video memory too small
    (qemu) device_add bochs-display,vgamem=3D1
    RAMBlock "0000:00:04.0/bochs-display-vram" already registered, abort!
    Aborted (core dumped)

Cause: bochs_display_realize() neglects to bail out after setting the
error.  Fix that.

Fixes: 765c94290863eef1fc4a67819d452cc13b7854a1
Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/display/bochs-display.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 70eb619ef4..e763a0a72d 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -267,16 +267,18 @@ static void bochs_display_realize(PCIDevice *dev, Err=
or **errp)
     Object *obj =3D OBJECT(dev);
     int ret;
=20
-    s->con =3D graphic_console_init(DEVICE(dev), 0, &bochs_display_gfx_ops=
, s);
-
     if (s->vgamem < 4 * MiB) {
         error_setg(errp, "bochs-display: video memory too small");
+        return;
     }
     if (s->vgamem > 256 * MiB) {
         error_setg(errp, "bochs-display: video memory too big");
+        return;
     }
     s->vgamem =3D pow2ceil(s->vgamem);
=20
+    s->con =3D graphic_console_init(DEVICE(dev), 0, &bochs_display_gfx_ops=
, s);
+
     memory_region_init_ram(&s->vram, obj, "bochs-display-vram", s->vgamem,
                            &error_fatal);
     memory_region_init_io(&s->vbe, obj, &bochs_display_vbe_ops, s,
--=20
2.21.1


