Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C6DCA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B07B2086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wo7G/Y2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B07B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNLlx-000437-3G
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 14:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKXt-0006DI-4r
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKXn-0002ma-LB
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:35:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29418
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iNKXn-0002ly-Gj
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571852135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SyUZ4JsJycVqOSKTWD2PuRrZH/UM5sDUfeCR0AwZmPE=;
 b=Wo7G/Y2gxDDq4DTjKnEM4wW1WfZheB2KPh909qt9eggoUqaL5nzjx00LOScUSpegRKTlHW
 BrddYWo5NI6iRkvat2PcjGPr0wJjFS2QPnZbJaL1qI0PDKDHwMVaHMnZnRcGA/yapZy/mt
 3ilvTETz2GAHF/sET3COsJ1E17qLnis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-eGptjdXAMc-Me0wY99FoZw-1; Wed, 23 Oct 2019 13:35:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CBDF47B;
 Wed, 23 Oct 2019 17:35:29 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3EF7196B2;
 Wed, 23 Oct 2019 17:35:23 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 30/33] omap-i2c: remove PROP_PTR
Date: Wed, 23 Oct 2019 19:31:51 +0200
Message-Id: <20191023173154.30051-31-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-1-marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: eGptjdXAMc-Me0wY99FoZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since clocks are not QOM objects, replace PROP_PTR of clocks with
setters methods.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/omap1.c        |  2 +-
 hw/arm/omap2.c        |  8 ++++----
 hw/i2c/omap_i2c.c     | 19 ++++++++++++-------
 include/hw/arm/omap.h | 13 +++++++++++++
 4 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 1afd1d3d7f..807e5f70d1 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -4030,7 +4030,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegio=
n *dram,
=20
     s->i2c[0] =3D qdev_create(NULL, "omap_i2c");
     qdev_prop_set_uint8(s->i2c[0], "revision", 0x11);
-    qdev_prop_set_ptr(s->i2c[0], "fclk", omap_findclk(s, "mpuper_ck"));
+    omap_i2c_set_fclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "mpuper_ck"));
     qdev_init_nofail(s->i2c[0]);
     busdev =3D SYS_BUS_DEVICE(s->i2c[0]);
     sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(s->ih[1], OMAP_INT_I2C)=
);
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 1d7cc435ef..171e2d0472 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -2425,8 +2425,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegi=
on *sdram,
=20
     s->i2c[0] =3D qdev_create(NULL, "omap_i2c");
     qdev_prop_set_uint8(s->i2c[0], "revision", 0x34);
-    qdev_prop_set_ptr(s->i2c[0], "iclk", omap_findclk(s, "i2c1.iclk"));
-    qdev_prop_set_ptr(s->i2c[0], "fclk", omap_findclk(s, "i2c1.fclk"));
+    omap_i2c_set_iclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "i2c1.iclk"));
+    omap_i2c_set_fclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "i2c1.fclk"));
     qdev_init_nofail(s->i2c[0]);
     busdev =3D SYS_BUS_DEVICE(s->i2c[0]);
     sysbus_connect_irq(busdev, 0,
@@ -2437,8 +2437,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegi=
on *sdram,
=20
     s->i2c[1] =3D qdev_create(NULL, "omap_i2c");
     qdev_prop_set_uint8(s->i2c[1], "revision", 0x34);
-    qdev_prop_set_ptr(s->i2c[1], "iclk", omap_findclk(s, "i2c2.iclk"));
-    qdev_prop_set_ptr(s->i2c[1], "fclk", omap_findclk(s, "i2c2.fclk"));
+    omap_i2c_set_iclk(OMAP_I2C(s->i2c[1]), omap_findclk(s, "i2c2.iclk"));
+    omap_i2c_set_fclk(OMAP_I2C(s->i2c[1]), omap_findclk(s, "i2c2.fclk"));
     qdev_init_nofail(s->i2c[1]);
     busdev =3D SYS_BUS_DEVICE(s->i2c[1]);
     sysbus_connect_irq(busdev, 0,
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index 3ba965a58f..3ccbd5cc2c 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -28,10 +28,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
=20
-#define TYPE_OMAP_I2C "omap_i2c"
-#define OMAP_I2C(obj) OBJECT_CHECK(OMAPI2CState, (obj), TYPE_OMAP_I2C)
-
-typedef struct OMAPI2CState {
+struct OMAPI2CState {
     SysBusDevice parent_obj;
=20
     MemoryRegion iomem;
@@ -56,7 +53,7 @@ typedef struct OMAPI2CState {
     uint8_t divider;
     uint8_t times[2];
     uint16_t test;
-} OMAPI2CState;
+};
=20
 #define OMAP2_INTR_REV=090x34
 #define OMAP2_GC_REV=090x34
@@ -504,10 +501,18 @@ static void omap_i2c_realize(DeviceState *dev, Error =
**errp)
     }
 }
=20
+void omap_i2c_set_iclk(OMAPI2CState *i2c, omap_clk clk)
+{
+    i2c->iclk =3D clk;
+}
+
+void omap_i2c_set_fclk(OMAPI2CState *i2c, omap_clk clk)
+{
+    i2c->fclk =3D clk;
+}
+
 static Property omap_i2c_properties[] =3D {
     DEFINE_PROP_UINT8("revision", OMAPI2CState, revision, 0),
-    DEFINE_PROP_PTR("iclk", OMAPI2CState, iclk),
-    DEFINE_PROP_PTR("fclk", OMAPI2CState, fclk),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index bcecf19f89..39a295ba20 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -81,6 +81,19 @@ typedef struct omap_intr_handler_s omap_intr_handler;
 void omap_intc_set_iclk(omap_intr_handler *intc, omap_clk clk);
 void omap_intc_set_fclk(omap_intr_handler *intc, omap_clk clk);
=20
+/* omap_i2c.c */
+#define TYPE_OMAP_I2C "omap_i2c"
+#define OMAP_I2C(obj) OBJECT_CHECK(OMAPI2CState, (obj), TYPE_OMAP_I2C)
+
+typedef struct OMAPI2CState OMAPI2CState;
+
+/*
+ * TODO: Ideally we should have a clock framework that
+ * let us wire these clocks up with QOM properties or links.
+ */
+void omap_i2c_set_iclk(OMAPI2CState *i2c, omap_clk clk);
+void omap_i2c_set_fclk(OMAPI2CState *i2c, omap_clk clk);
+
 /* OMAP2 l4 Interconnect */
 struct omap_l4_s;
 struct omap_l4_region_s {
--=20
2.23.0.606.g08da6496b6


