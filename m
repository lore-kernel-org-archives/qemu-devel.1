Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCFEC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB0820658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdMIAVi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB0820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvAJ-0005wQ-0I
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuq2-0001ga-DE
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuq1-0000r2-AQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34983)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuq1-0000oo-65
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VSR9kygTTReaCRIBAeG2Orj1G8eqxnIXlzuyJCEoZ4=;
 b=QdMIAVi1ZkDXke0i876+cZQKuvndMkboH5M8tE9FknGSOO7hBfq73Nqj6Umlqt7AnusoYY
 IfnsUCdK4wfMn9TQTeuKlZ5h55AEql0igUgaVO85vdZpqQbnXnN+4+QiXKUOo9V1Vg7hzA
 MpjyFOGx4/UmhW2u4rVuyMpHSnpv0y8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-0yDrMbkiPBWBkgIHefu_0w-1; Mon, 16 Mar 2020 14:51:42 -0400
X-MC-Unique: 0yDrMbkiPBWBkgIHefu_0w-1
Received: by mail-wr1-f69.google.com with SMTP id w11so9465637wrp.20
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t3v5KkPJFqQ5Hvd8PkUF+qQTJk/z0T5Un950kyyDqAQ=;
 b=psJKQe05f0VII45BM7eUZ9ML8B7sNJrMZiUNpxbVth0yyYeiEWEJDpMzCHCde6YzPH
 XT7jmdA0JYP3nMqpAby7ieqLgN+0qd8M+TGK6Gx9y45CMNP6mfPIY40ZlHgGiMm1yGQ6
 QWM1orbgCwcyuVeW0Y+GpRdflzYy9HF/P6n2VZf6amzpHZGNHp34XTbSE/VF1PYnKUzP
 x5VGGoEAxqGRKo9bO0qDcvPmxn7ZzaSyoIBY6Ots74PKF0IpqvXmZJHlisByI4QsJdIR
 w60ysCjX32ZDryvTtSMEKJTuhCRafg1jbUq6eRVlQdj8kGz16LutZYjOyKyaX9R4HhSq
 XzHQ==
X-Gm-Message-State: ANhLgQ2fNSMhrDfsKVnqzIkdEpArb7KjPna5Xychn/iA3bIx+kmcs6Mn
 KzCpJWOeW4L9Eb4u6S9H2t7x10lZELlSwkB5MqfZshtCF4pPha8rtM7p+L/OMdvh2ID8kQQq/xg
 YOgWGDQPLxTo3ioQ=
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr725330wrh.311.1584384701497;
 Mon, 16 Mar 2020 11:51:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtfD6HXEuELQkAUsgJzstaLWfjF3PFpCHIpTWt5s/PhF+tuPeA0D/I34QmESmCXiL0zDj2Aow==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr725318wrh.311.1584384701328;
 Mon, 16 Mar 2020 11:51:41 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id g3sm1123154wro.93.2020.03.16.11.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:51:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 18/25] hw/display: Let devices own the MemoryRegion they
 create
Date: Mon, 16 Mar 2020 19:49:59 +0100
Message-Id: <20200316185006.576-19-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
References: <20200316185006.576-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
index 55185c95c6..adcba96e34 100644
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
index 8bff16d535..b68faff4bb 100644
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
2.21.1


