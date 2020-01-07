Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6624FC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBA92087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wuh456UY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBA92087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqdr-00075R-77
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioqTy-0006PJ-Lo
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioqTx-0005ZJ-60
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:09:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58554
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ioqTx-0005Yn-28
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578409760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KzZquunIWkcFxIp6xrNXd5CyX26rzDuiaRhlVh+ittg=;
 b=Wuh456UY7SJHQXfnkTjl2j7M7z0vYSSCFiGYBNDjT7wpyG6r0tzI0THZVsyMobK8jpXrWt
 ZfA//DAYtv6JlVkMJnmaRZg49iUyVfE578GOSDsvD4kF70V7ZF4vsII7UrOUVCFo7S9MF9
 qRnqTlVbVf9tarAONS74Usb206PttKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-7G22zW-mOe2QoMaNYGPnZQ-1; Tue, 07 Jan 2020 10:09:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1A36107ACC5;
 Tue,  7 Jan 2020 15:09:16 +0000 (UTC)
Received: from localhost (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B37E110018FF;
 Tue,  7 Jan 2020 15:09:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/37] vmmouse: replace PROP_PTR with PROP_LINK
Date: Tue,  7 Jan 2020 19:04:27 +0400
Message-Id: <20200107150442.1727958-23-marcandre.lureau@redhat.com>
In-Reply-To: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
References: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 7G22zW-mOe2QoMaNYGPnZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While at it, use the expected type.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/input/i8042.h | 4 +++-
 hw/i386/pc.c             | 6 +++---
 hw/i386/vmmouse.c        | 8 +++-----
 hw/input/pckbd.c         | 8 +++-----
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/hw/input/i8042.h b/include/hw/input/i8042.h
index 246e6f3335..8eaebf50ce 100644
--- a/include/hw/input/i8042.h
+++ b/include/hw/input/i8042.h
@@ -14,10 +14,12 @@
=20
 #define I8042_A20_LINE "a20"
=20
+typedef struct ISAKBDState ISAKBDState;
+
 void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_irq,
                    MemoryRegion *region, ram_addr_t size,
                    hwaddr mask);
-void i8042_isa_mouse_fake_event(void *opaque);
+void i8042_isa_mouse_fake_event(ISAKBDState *isa);
 void i8042_setup_a20_line(ISADevice *dev, qemu_irq a20_out);
=20
 #endif /* HW_INPUT_I8042_H */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a4fda69b49..8054bc4147 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1156,9 +1156,9 @@ static void pc_superio_init(ISABus *isa_bus, bool cre=
ate_fdctrl, bool no_vmport)
         vmmouse =3D NULL;
     }
     if (vmmouse) {
-        DeviceState *dev =3D DEVICE(vmmouse);
-        qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
-        qdev_init_nofail(dev);
+        object_property_set_link(OBJECT(vmmouse), OBJECT(i8042),
+                                 "i8042", &error_abort);
+        qdev_init_nofail(DEVICE(vmmouse));
     }
     port92 =3D isa_create_simple(isa_bus, TYPE_PORT92);
=20
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 41ad91ad53..c0c329f817 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -66,7 +66,7 @@ typedef struct VMMouseState
     uint16_t status;
     uint8_t absolute;
     QEMUPutMouseEntry *entry;
-    void *ps2_mouse;
+    ISAKBDState *i8042;
 } VMMouseState;
=20
 static uint32_t vmmouse_get_status(VMMouseState *s)
@@ -105,7 +105,7 @@ static void vmmouse_mouse_event(void *opaque, int x, in=
t y, int dz, int buttons_
=20
     /* need to still generate PS2 events to notify driver to
        read from queue */
-    i8042_isa_mouse_fake_event(s->ps2_mouse);
+    i8042_isa_mouse_fake_event(s->i8042);
 }
=20
 static void vmmouse_remove_handler(VMMouseState *s)
@@ -275,7 +275,7 @@ static void vmmouse_realizefn(DeviceState *dev, Error *=
*errp)
 }
=20
 static Property vmmouse_properties[] =3D {
-    DEFINE_PROP_PTR("ps2_mouse", VMMouseState, ps2_mouse),
+    DEFINE_PROP_LINK("i8042", VMMouseState, i8042, TYPE_I8042, ISAKBDState=
 *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -287,8 +287,6 @@ static void vmmouse_class_initfn(ObjectClass *klass, vo=
id *data)
     dc->reset =3D vmmouse_reset;
     dc->vmsd =3D &vmstate_vmmouse;
     dc->props =3D vmmouse_properties;
-    /* Reason: pointer property "ps2_mouse" */
-    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo vmmouse_info =3D {
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 2f09f780ba..60a4130320 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -482,17 +482,15 @@ void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_i=
rq,
=20
 #define I8042(obj) OBJECT_CHECK(ISAKBDState, (obj), TYPE_I8042)
=20
-typedef struct ISAKBDState {
+struct ISAKBDState {
     ISADevice parent_obj;
=20
     KBDState kbd;
     MemoryRegion io[2];
-} ISAKBDState;
+};
=20
-void i8042_isa_mouse_fake_event(void *opaque)
+void i8042_isa_mouse_fake_event(ISAKBDState *isa)
 {
-    ISADevice *dev =3D opaque;
-    ISAKBDState *isa =3D I8042(dev);
     KBDState *s =3D &isa->kbd;
=20
     ps2_mouse_fake_event(s->mouse);
--=20
2.25.0.rc1.20.g2443f3f80d


