Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F466C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA9D2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acr/hxcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA9D2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThHB-0008F1-2y
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh24-0007u8-0Q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1i-0003ym-M9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28506
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh1h-0003vh-IG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0CwfPL0bHAmIgroIO9vlkMhNJh/UfpvjW50OODwJ/U=;
 b=acr/hxcOHKYI0yrWnytTpc5dlzCa6L/2cpc3VhOBRc6jr+vD9/Eos7UiQH8nMK/7rUTrb7
 zfXGojYa+ThE2ITPyZu9+ZP7cZOv9cnZEbZqZfdbuDgxlgRFfHBgfncP37KyiQyuoUhoUZ
 Zysm2UtvSAN0t6YqaDhtBXBFYIEzFI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-T2-mIlrQP5229-5Zlmi-CQ-1; Wed, 29 Apr 2020 03:20:57 -0400
X-MC-Unique: T2-mIlrQP5229-5Zlmi-CQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55FC68015CB
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 07:20:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FC02282D8;
 Wed, 29 Apr 2020 07:20:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F41911358CE; Wed, 29 Apr 2020 09:20:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/32] bochs-display: Fix vgamem=SIZE error handling
Date: Wed, 29 Apr 2020 09:20:33 +0200
Message-Id: <20200429072048.29963-18-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
References: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200422130719.28225-8-armbru@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
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


