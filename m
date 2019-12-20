Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C60BC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08626206EC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JioO+cyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08626206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJ09-0007Ur-35
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIgp-0002LI-7F
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIgn-0004oR-4h
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:51:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44867
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iiIgl-0004mx-Gf
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576849891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seUv81PPqDXJefiGlBZFQYkFmzBhDZ7nbB04X8mdrrU=;
 b=JioO+cyrpSaWA64rZ0f48diZj+z00SO7Vx9SwGjTJUnwM4DNbQNLnbyB9laoqru4jt/y+D
 F58DcOOwJe48maqIDUKu87c7JE3yYKBck2CQ4g2XxSxPvA0E+DwDCeRYg0ciyZY7UMuEwm
 Y3YRE+bpsXDPlLeerg7iYzq0o6NTHzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-A9V5SP1HMKytGFf4W7QhGA-1; Fri, 20 Dec 2019 08:51:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8254391232;
 Fri, 20 Dec 2019 13:51:28 +0000 (UTC)
Received: from localhost (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B4D95DA32;
 Fri, 20 Dec 2019 13:51:24 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 31/37] smbus-eeprom: remove PROP_PTR
Date: Fri, 20 Dec 2019 17:45:55 +0400
Message-Id: <20191220134601.571905-32-marcandre.lureau@redhat.com>
In-Reply-To: <20191220134601.571905-1-marcandre.lureau@redhat.com>
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: A9V5SP1HMKytGFf4W7QhGA-1
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead, set the initial data field directly.

(the initial data is an array of 256 bytes. As I don't know if it may
change over time, I keep the pointer to original buffer as is, but it
might be worth to consider to copy it instead)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/smbus_eeprom.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 54c86a0112..5adf3b15b5 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -44,7 +44,7 @@
 typedef struct SMBusEEPROMDevice {
     SMBusDevice smbusdev;
     uint8_t data[SMBUS_EEPROM_SIZE];
-    void *init_data;
+    uint8_t *init_data;
     uint8_t offset;
     bool accessed;
 } SMBusEEPROMDevice;
@@ -129,14 +129,14 @@ static void smbus_eeprom_reset(DeviceState *dev)
=20
 static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
 {
+    SMBusEEPROMDevice *eeprom =3D SMBUS_EEPROM(dev);
+
     smbus_eeprom_reset(dev);
+    if (eeprom->init_data =3D=3D NULL) {
+        error_setg(errp, "init_data cannot be NULL");
+    }
 }
=20
-static Property smbus_eeprom_properties[] =3D {
-    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, init_data),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -146,9 +146,8 @@ static void smbus_eeprom_class_initfn(ObjectClass *klas=
s, void *data)
     dc->reset =3D smbus_eeprom_reset;
     sc->receive_byte =3D eeprom_receive_byte;
     sc->write_data =3D eeprom_write_data;
-    dc->props =3D smbus_eeprom_properties;
     dc->vmsd =3D &vmstate_smbus_eeprom;
-    /* Reason: pointer property "data" */
+    /* Reason: init_data */
     dc->user_creatable =3D false;
 }
=20
@@ -172,7 +171,8 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t addre=
ss, uint8_t *eeprom_buf)
=20
     dev =3D qdev_create((BusState *) smbus, TYPE_SMBUS_EEPROM);
     qdev_prop_set_uint8(dev, "address", address);
-    qdev_prop_set_ptr(dev, "data", eeprom_buf);
+    /* FIXME: use an array of byte or block backend property? */
+    SMBUS_EEPROM(dev)->init_data =3D eeprom_buf;
     qdev_init_nofail(dev);
 }
=20
--=20
2.24.0.308.g228f53135a


