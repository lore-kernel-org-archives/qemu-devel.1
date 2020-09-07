Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C5EC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F112080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpRhX5da"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F112080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF5nV-0000kK-W7
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kF5lF-0005Sc-3I
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 21:15:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20212
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kF5lD-0003Ho-72
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 21:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599441354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYKMuCNTu0CWpezTgFvQrBp6rENgdo+gYHsIjc8AdfQ=;
 b=DpRhX5daIGK794UnxCDJbFYN8CWpVDxGU+zz9/sfFwz1iR9E80oFby/FqpQyn1iZL+E94q
 IJmRL7J0JOb/Rhu+ROqCvqGnvpz6Jns6e27FaNGA2ztZIP1dPr0mnBVw62XUwAIsg8ZZSr
 aOWcHpu84wOltlUGFPVQ/IjGf5i2Usc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-z5S0OkSFOVmEOOICKpjMdA-1; Sun, 06 Sep 2020 21:15:52 -0400
X-MC-Unique: z5S0OkSFOVmEOOICKpjMdA-1
Received: by mail-wr1-f70.google.com with SMTP id r16so5075292wrm.18
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 18:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PYKMuCNTu0CWpezTgFvQrBp6rENgdo+gYHsIjc8AdfQ=;
 b=R992/fz54NiAuFobc0DY19H1Zq3X517G4ppnckXx7NpzFt295rpMdtzvls77L+zPO3
 nyPP3sdWs+CRmFbvwBWzs/3k5nj4IvXauzK2tglnrBf1otLJnCf4dhbY30QXLqeZShHX
 eP5CIYknweGmO65jc/DMvAYqtww1+qQ/VVZk4AylT0RE17o+WEPm4VpCjvm/FiolP83U
 ofsDQdxl9duiM6yfbtRU7xTgrNOZ4HK04DssmCB2LSmcXQ+oayrunMXbTCtP5w/OrY5E
 Tfem/OgNWJfPBFry0ar0HySco5hSGBJOZQnNv22vkVonseMlbKPlq2UW19yZyRiCT1fr
 ghnQ==
X-Gm-Message-State: AOAM532fo/Pzn/O6M3JL8SujUD9+pbP5mNaIYBdk2c8eDsvDE/cY0xpA
 ltDa4vvdncnK8OT993S6Qt4ZytHKcMIC8RwN5nxQtmV7Q9mejj759qpFdGtvi7g6CFpvfpOuBTx
 Jjyhh9Sck7jEjIyI=
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr18189113wmh.39.1599441351167; 
 Sun, 06 Sep 2020 18:15:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp7uqF2w1dkwMk5iiatrzjFNk6Kd88XKncpUINmWVImn57FgsXdh5KS5SYBt1ngUriRbtMrg==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr18189097wmh.39.1599441351010; 
 Sun, 06 Sep 2020 18:15:51 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id z7sm17477175wrw.93.2020.09.06.18.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 18:15:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] hw/char/serial: Remove TYPE_SERIAL_IO (superset of
 TYPE_SERIAL_MM)
Date: Mon,  7 Sep 2020 03:15:38 +0200
Message-Id: <20200907011538.818996-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907011538.818996-1-philmd@redhat.com>
References: <20200907011538.818996-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 21:15:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TYPE_SERIAL_IO is a superset of TYPE_SERIAL_MM, and it is
not used anymore. Remove it.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/char/serial.h |  9 ---------
 hw/char/serial.c         | 41 ----------------------------------------
 2 files changed, 50 deletions(-)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 535fa23a2b8..81d7ba1917f 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -88,12 +88,6 @@ typedef struct SerialMM {
     uint8_t endianness;
 } SerialMM;
 
-typedef struct SerialIO {
-    SysBusDevice parent;
-
-    SerialState serial;
-} SerialIO;
-
 extern const VMStateDescription vmstate_serial;
 extern const MemoryRegionOps serial_io_ops;
 
@@ -105,9 +99,6 @@ void serial_set_frequency(SerialState *s, uint32_t frequency);
 #define TYPE_SERIAL_MM "serial-mm"
 #define SERIAL_MM(s) OBJECT_CHECK(SerialMM, (s), TYPE_SERIAL_MM)
 
-#define TYPE_SERIAL_IO "serial-io"
-#define SERIAL_IO(s) OBJECT_CHECK(SerialIO, (s), TYPE_SERIAL_IO)
-
 SerialMM *serial_mm_init(MemoryRegion *address_space,
                          hwaddr base, int regshift,
                          qemu_irq irq, int baudbase,
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 23864794929..fd80ae55929 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -985,46 +985,6 @@ const MemoryRegionOps serial_io_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void serial_io_realize(DeviceState *dev, Error **errp)
-{
-    SerialIO *sio = SERIAL_IO(dev);
-    SerialState *s = &sio->serial;
-
-    if (!qdev_realize(DEVICE(s), NULL, errp)) {
-        return;
-    }
-
-    memory_region_init_io(&s->io, OBJECT(dev), &serial_io_ops, s, "serial", 8);
-    sysbus_init_mmio(SYS_BUS_DEVICE(sio), &s->io);
-    sysbus_init_irq(SYS_BUS_DEVICE(sio), &s->irq);
-}
-
-static void serial_io_class_init(ObjectClass *klass, void* data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = serial_io_realize;
-    /* No dc->vmsd: class has no migratable state */
-}
-
-static void serial_io_instance_init(Object *o)
-{
-    SerialIO *sio = SERIAL_IO(o);
-
-    object_initialize_child(o, "serial", &sio->serial, TYPE_SERIAL);
-
-    qdev_alias_all_properties(DEVICE(&sio->serial), o);
-}
-
-
-static const TypeInfo serial_io_info = {
-    .name = TYPE_SERIAL_IO,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SerialIO),
-    .instance_init = serial_io_instance_init,
-    .class_init = serial_io_class_init,
-};
-
 static Property serial_properties[] = {
     DEFINE_PROP_CHR("chardev", SerialState, chr),
     DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
@@ -1178,7 +1138,6 @@ static const TypeInfo serial_mm_info = {
 static void serial_register_types(void)
 {
     type_register_static(&serial_info);
-    type_register_static(&serial_io_info);
     type_register_static(&serial_mm_info);
 }
 
-- 
2.26.2


