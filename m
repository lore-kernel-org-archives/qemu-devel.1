Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C382C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 22:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F265B205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 22:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXCTeSmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F265B205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxsf-0001XD-49
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 18:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxIM-0004ic-S4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxIL-0008Gx-P3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxIL-0008Ep-LB
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7p3MLZ3d8LKWVb9Q2azzwfZzSAYNFpiViKoFByrCLvc=;
 b=SXCTeSmtYQEdiMZICoNd/cheZ7jViCzww1wC1JezcQ5vabcoMHEkTpVpvi8zfHisMZQRO1
 012dlS7TEwiKe++YhLqG99RpMarUNEPWmEXBft2L62YHOuGJ4y7RBuVJDOtiwan5IH50bT
 g7oNqj09kpUHtJWLuLJ+42vin5GH3Sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-aqK-6ALONKeg_zhDAyjbow-1; Mon, 16 Mar 2020 17:29:07 -0400
X-MC-Unique: aqK-6ALONKeg_zhDAyjbow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE77C801E6D
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:29:06 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EABEE19C4F;
 Mon, 16 Mar 2020 21:29:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 54/61] hw/display: Let devices own the MemoryRegion they create
Date: Mon, 16 Mar 2020 22:27:21 +0100
Message-Id: <1584394048-44994-55-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Avoid orphan memory regions being added in the /unattached QOM
container.

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/display/g364fb.c | 3 ++-
 hw/display/macfb.c  | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 55185c9..adcba96 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -477,7 +477,8 @@ static void g364fb_init(DeviceState *dev, G364State *s)
=20
     s->con =3D graphic_console_init(dev, 0, &g364fb_ops, s);
=20
-    memory_region_init_io(&s->mem_ctrl, NULL, &g364fb_ctrl_ops, s, "ctrl",=
 0x180000);
+    memory_region_init_io(&s->mem_ctrl, OBJECT(dev), &g364fb_ctrl_ops, s,
+                          "ctrl", 0x180000);
     memory_region_init_ram_ptr(&s->mem_vram, NULL, "vram",
                                s->vram_size, s->vram);
     vmstate_register_ram(&s->mem_vram, dev);
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 8bff16d..b68faff 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -362,8 +362,8 @@ static void macfb_common_realize(DeviceState *dev, Macf=
bState *s, Error **errp)
         return;
     }
=20
-    memory_region_init_io(&s->mem_ctrl, NULL, &macfb_ctrl_ops, s, "macfb-c=
trl",
-                          0x1000);
+    memory_region_init_io(&s->mem_ctrl, OBJECT(dev), &macfb_ctrl_ops, s,
+                          "macfb-ctrl", 0x1000);
=20
     memory_region_init_ram_nomigrate(&s->mem_vram, OBJECT(s), "macfb-vram"=
,
                                      MACFB_VRAM_SIZE, errp);
--=20
1.8.3.1



