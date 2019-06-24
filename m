Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF6CC4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC9720665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZDSUj0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC9720665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54888 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfX6K-0001oZ-0l
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54962)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX2C-0007yC-Em
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX2A-000498-Ba
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX2A-00035Z-42
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:54 -0400
Received: by mail-wr1-x441.google.com with SMTP id n4so14307239wrs.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KG1ocHR9CwXIKkrRGNYi2cBkFImhdlC2FkdsDqiv+kk=;
 b=AZDSUj0SfoAGxyrrVuFgGs14Hcf9GfGSo/aOcr+AR63a9VGW58off0Tkwf/5nxL9KW
 jc0xpZ0e8m0+X3Qa6cqB51BDNVtSSYrGB9M9IEzWUc3eII3ZkE3D9gCc5VFH7SGz3n6E
 qW1ApwnT2x8LbT1Yd7MvR7IELDKjMknw9IYAev2+c5ZOJMQR4cdXQz41O0gpVuPWi6F8
 /Ov5K/gObGVbKjLIBY2DkP6Re4T4exKyzj0B8VEl6IW91ZzdEiAh/NttXFZFTs9P9Xc1
 6VmlsQiSyo1A5OsuAfWaZ4E1oLFYBX5eBG/ni5VJ7xAe2UJ6jna1y0A3F6VyVLmNq7Pv
 0vJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KG1ocHR9CwXIKkrRGNYi2cBkFImhdlC2FkdsDqiv+kk=;
 b=mU3C3Lj6QOny67/7Bge33j6RGojhLwQwxDih45MbEsk43RlD8aN4T+MvGeI3wzUJ/c
 Wtueqee1s3whQm7jx0ANXnK95Ksu3X7iVnt6TFAxaJaSYinAEzZbxO70gxVNeGp2d97s
 bKTx9xaTZHnHlveMvc88W9G9CouzUXGgEwy/hTViL9StU9TPTjZzSdIqix0kgQM7RwDj
 DyLrM+YzYFdGEGEFNnEqOhVelqczaUGo4pDEX2ns8VSIEpmxBmnsDyUTUzs1Mota7q8Y
 zQe3T5AcDwfVPlByCBcAr6GFf0mmusQLs5YQGvT8TgYmudb1VQOtl2CuLOCauG/a2hIO
 6vkQ==
X-Gm-Message-State: APjAAAUR/nfn/oLTICcOaONVOslCDd/SfsUEu4OfRROIYFrR+mGOUFX2
 jYRHlxEDp8aX2EddCQItEb73ncx+
X-Google-Smtp-Source: APXvYqzlFENU9TL7FeDoaTbmH6CR0WZ4w3bOLyTaW7fjWOPvi2TsFCQFW+LOOvrnIKgWA7ujeaDqrQ==
X-Received: by 2002:adf:e442:: with SMTP id t2mr37800775wrm.286.1561413664324; 
 Mon, 24 Jun 2019 15:01:04 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z126sm1118612wmb.32.2019.06.24.15.01.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:01:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:00:51 +0200
Message-Id: <20190624220056.25861-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624220056.25861-1-f4bug@amsat.org>
References: <20190624220056.25861-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 4/9] hw/misc/empty_slot: Add a qdev property
 'size'
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
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a qdev 'size' property, check the size is not zero in the
realize() function, simplify the empty_slot_init() logic.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/empty_slot.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
index 53299cdbd1..ef0a7b99ba 100644
--- a/hw/misc/empty_slot.c
+++ b/hw/misc/empty_slot.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
@@ -55,41 +56,45 @@ static const MemoryRegionOps empty_slot_ops = {
 
 void empty_slot_init(hwaddr addr, uint64_t slot_size)
 {
-    if (slot_size > 0) {
-        /* Only empty slots larger than 0 byte need handling. */
-        DeviceState *dev;
-        SysBusDevice *s;
-        EmptySlot *e;
-
-        dev = qdev_create(NULL, TYPE_EMPTY_SLOT);
-        s = SYS_BUS_DEVICE(dev);
-        e = EMPTY_SLOT(dev);
-        e->size = slot_size;
-
-        qdev_init_nofail(dev);
-
-        /*
-         * We use a priority lower than the default UNIMPLEMENTED_DEVICE
-         * to be able to plug a UnimplementedDevice on an EmptySlot.
-         */
-        sysbus_mmio_map_overlap(s, 0, addr, -10000);
-    }
+    DeviceState *dev;
+
+    dev = qdev_create(NULL, TYPE_EMPTY_SLOT);
+
+    qdev_prop_set_uint64(dev, "size", slot_size);
+    qdev_init_nofail(dev);
+
+    /*
+     * We use a priority lower than the default UNIMPLEMENTED_DEVICE
+     * to be able to plug a UnimplementedDevice on an EmptySlot.
+     */
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(dev), 0, addr, -10000);
 }
 
 static void empty_slot_realize(DeviceState *dev, Error **errp)
 {
     EmptySlot *s = EMPTY_SLOT(dev);
 
+    if (s->size == 0) {
+        error_setg(errp, "property 'size' not specified or zero");
+        return;
+    }
+
     memory_region_init_io(&s->iomem, OBJECT(s), &empty_slot_ops, s,
                           "empty-slot", s->size);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
 
+static Property empty_slot_properties[] = {
+    DEFINE_PROP_UINT64("size", EmptySlot, size, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void empty_slot_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = empty_slot_realize;
+    dc->props = empty_slot_properties;
 }
 
 static const TypeInfo empty_slot_info = {
-- 
2.19.1


