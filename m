Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB9CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F051720674
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Exs0m0NT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F051720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXS9O-00056w-Pb
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRwg-0006qW-Gb
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRwf-0000jk-Bk
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:31:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29385
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRwe-0000iV-V4
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VLhe4Dt8O6jn3e83q7E52BSg06cKdjFXIYZ+/ABq6FA=;
 b=Exs0m0NT+kN+Lx1eYIpQuwcD2xSONJOBFcMPG1tBKWqulZkNKcOkaUzSuG08WEIqwN4Gdk
 XIBztOZGZPWxBSxbc7dyj9sdP0Pnq3BGk8TcIHUd8cZyvsqq9ZrsLHT8btVPjtFZXfx6dZ
 UUONxC7yDkJZt3R17VtdH4YZDvv3pro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-UNqQFiHtMxyg0gDzx8rR4A-1; Wed, 20 Nov 2019 10:31:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7EEF107ACC7;
 Wed, 20 Nov 2019 15:30:59 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2504067E55;
 Wed, 20 Nov 2019 15:30:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 31/37] smbus-eeprom: remove PROP_PTR
Date: Wed, 20 Nov 2019 19:24:36 +0400
Message-Id: <20191120152442.26657-32-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UNqQFiHtMxyg0gDzx8rR4A-1
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
Cc: peter.maydell@linaro.org, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead, set the initial data field directly.

(the initial data is an array of 256 bytes. As I don't know if it may
change over time, I keep the pointer to original buffer as is, but it
might be worth to consider to copy it instead)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/i2c/smbus_eeprom.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 54c86a0112..533c728b3b 100644
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
@@ -172,7 +171,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t addre=
ss, uint8_t *eeprom_buf)
=20
     dev =3D qdev_create((BusState *) smbus, TYPE_SMBUS_EEPROM);
     qdev_prop_set_uint8(dev, "address", address);
-    qdev_prop_set_ptr(dev, "data", eeprom_buf);
+    SMBUS_EEPROM(dev)->init_data =3D eeprom_buf;
     qdev_init_nofail(dev);
 }
=20
--=20
2.24.0


