Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C3DC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FFCD20714
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSF4SXVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFCD20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXS8o-0004Nk-NQ
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRux-0004ST-QF
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRuw-0007tT-Hr
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:29:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRuw-0007tN-E1
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P73cl5fO+YHfQF+Bys7MbTUAfr63r3Q1J6DtVtz23D8=;
 b=fSF4SXVbAqwUrEUjf+uMCVAzXSxW11zTDohBRukNC8oyfcZMulZYBmUfOtnpxRWolm/1vB
 QG/WfYpva6DAJglTDgapS4MBpvbzT4xqyDExN/x7igNotsOohrPH/izPT3vtTYlvPHdl1q
 4ZEM8/pdZZQgqVaWj5GxKEpGMls/M1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-kDAdtwDUPAyCHaxirOweNA-1; Wed, 20 Nov 2019 10:29:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA0A418B5F69;
 Wed, 20 Nov 2019 15:29:14 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6CB51037ADA;
 Wed, 20 Nov 2019 15:29:06 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 22/37] vmmouse: replace PROP_PTR with PROP_LINK
Date: Wed, 20 Nov 2019 19:24:27 +0400
Message-Id: <20191120152442.26657-23-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: kDAdtwDUPAyCHaxirOweNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While at it, use the expected type.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c             | 6 +++---
 hw/i386/vmmouse.c        | 8 +++-----
 hw/input/pckbd.c         | 8 +++-----
 include/hw/input/i8042.h | 4 +++-
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 49e2259327..d7ac8401a5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1358,9 +1358,9 @@ static void pc_superio_init(ISABus *isa_bus, bool cre=
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
     port92 =3D isa_create_simple(isa_bus, "port92");
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
index f0acfd86f7..9b641021c9 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -483,17 +483,15 @@ void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_i=
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
--=20
2.24.0


