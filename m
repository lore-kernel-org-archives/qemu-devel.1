Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA324C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77776222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HItnXlY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77776222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CDK-0003Jt-IY
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j5C8p-0006CG-FK
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j5C8o-000807-B9
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54570
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j5C8o-0007zf-78
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582306265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VEFA07cxDExgBn425ggzA1li5B5q1BBqRYxz1LjraoI=;
 b=HItnXlY0Kxdz/YhP2oWzPJMnZLpaqZ6/kQ5MJ0Lkzr3PE2WbLu9gZCvblZ/r9uI4OMwVwb
 4RQhotmbmxVx+drvaTQyEa1oeNhupW6/C3eep7pkTPte6Y2NDSQj8jryM1hLfIxfSvzG5T
 yo6kiW9qG2qe1lvVJd0XK1ekcf5+kow=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-Rw44Jy64Ovm_wcKR-QPNYQ-1; Fri, 21 Feb 2020 12:31:03 -0500
X-MC-Unique: Rw44Jy64Ovm_wcKR-QPNYQ-1
Received: by mail-wm1-f71.google.com with SMTP id y125so2067579wmg.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 09:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EJXr99FJ98twgvm41idHKUIEhs+PYW203OES1NY0r5o=;
 b=ZdYUSxsRWw8k8bVxI/JpQVgBvo3jllUmnzKVjKjLvwzBnAj5F75IJnE3rGk6QVQA++
 Da15nz7jb0aaNIWjrEL/Do7somTrt+mCXKmaPwRzEVKh+yVvqpMn2BoA9KdqYvwyJO5O
 1eMiDaTIq3zxkkzWPHbVKogntYkQVlLBxlQ3IGxEfFEGIVY88Bzid7HouWPqbJ93wFxo
 YbV8KaQcAAdVvs/qqrDgs6Fglc442ZuNbr2TKxtnJW8XT3A8xJ+YlAqsX7rHWKI2pPFW
 LZBYh5vPRb1LQ01601vaR76kRnqh9U3to2qiLuFIwQD8xrVg2OUFgSBBUoCueMHeEpCm
 c38g==
X-Gm-Message-State: APjAAAUStpd3nD92//bGGV/hUGk2jnuqWM34AgZq6XRx3MRZTPWj2EHi
 I8tqAIOelkHrfA46yTUwnklVLJCuzM4t56DwZAosyiCc7HpYEa+0Iua4dCwAy9gt8K+SESh7rpE
 4aWxCf/Iu4mdCqxM=
X-Received: by 2002:a1c:e388:: with SMTP id a130mr4895515wmh.176.1582306262287; 
 Fri, 21 Feb 2020 09:31:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqzxKK4rofAtrCdp/lELRI9WruL74WpqyFZLmhDMq/d7/UXqXq6F7h1gVJASQwbnvwlXqxfsag==
X-Received: by 2002:a1c:e388:: with SMTP id a130mr4895477wmh.176.1582306261997; 
 Fri, 21 Feb 2020 09:31:01 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id h18sm5000871wrv.78.2020.02.21.09.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 09:31:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] hw/display: Let devices own the MemoryRegion they create
Date: Fri, 21 Feb 2020 18:30:47 +0100
Message-Id: <20200221173049.18134-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200221173049.18134-1-philmd@redhat.com>
References: <20200221173049.18134-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To avoid orphean memory regions being added in the /unattached
QOM container, use the memory_region_owner_nonnull.cocci script
to set the correct ownership.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/display/cg3.c        | 4 ++--
 hw/display/g364fb.c     | 5 +++--
 hw/display/macfb.c      | 4 ++--
 hw/display/vmware_vga.c | 4 ++--
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 4fb67c6b1c..db2e291d16 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -315,8 +315,8 @@ static void cg3_realizefn(DeviceState *dev, Error **err=
p)
         }
     }
=20
-    memory_region_init_ram(&s->vram_mem, NULL, "cg3.vram", s->vram_size,
-                           &error_fatal);
+    memory_region_init_ram(&s->vram_mem, OBJECT(dev), "cg3.vram",
+                           s->vram_size, &error_fatal);
     memory_region_set_log(&s->vram_mem, true, DIRTY_MEMORY_VGA);
     sysbus_init_mmio(sbd, &s->vram_mem);
=20
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 55185c95c6..28785cceda 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -477,8 +477,9 @@ static void g364fb_init(DeviceState *dev, G364State *s)
=20
     s->con =3D graphic_console_init(dev, 0, &g364fb_ops, s);
=20
-    memory_region_init_io(&s->mem_ctrl, NULL, &g364fb_ctrl_ops, s, "ctrl",=
 0x180000);
-    memory_region_init_ram_ptr(&s->mem_vram, NULL, "vram",
+    memory_region_init_io(&s->mem_ctrl, OBJECT(dev), &g364fb_ctrl_ops, s,
+                          "ctrl", 0x180000);
+    memory_region_init_ram_ptr(&s->mem_vram, OBJECT(dev), "vram",
                                s->vram_size, s->vram);
     vmstate_register_ram(&s->mem_vram, dev);
     memory_region_set_log(&s->mem_vram, true, DIRTY_MEMORY_VGA);
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
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 58ea82e3e5..79574e3c46 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1238,8 +1238,8 @@ static void vmsvga_init(DeviceState *dev, struct vmsv=
ga_state_s *s,
     s->vga.con =3D graphic_console_init(dev, 0, &vmsvga_ops, s);
=20
     s->fifo_size =3D SVGA_FIFO_SIZE;
-    memory_region_init_ram(&s->fifo_ram, NULL, "vmsvga.fifo", s->fifo_size=
,
-                           &error_fatal);
+    memory_region_init_ram(&s->fifo_ram, OBJECT(dev), "vmsvga.fifo",
+                           s->fifo_size, &error_fatal);
     s->fifo_ptr =3D memory_region_get_ram_ptr(&s->fifo_ram);
=20
     vga_common_init(&s->vga, OBJECT(dev));
--=20
2.21.1


