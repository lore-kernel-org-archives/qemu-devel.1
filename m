Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4BAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBDE217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOnCvRWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBDE217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itagy-0000mm-Iq
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1itaWV-0005rA-Lk
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1itaWU-0001gx-GL
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:35 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:39485)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1itaWU-0001gJ-BE
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:34 -0500
Received: by mail-ot1-x32d.google.com with SMTP id 77so379028oty.6
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 09:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xXgs8aTcQ0uGhBK5sC1zXETwAujk79dljWd/Jt9xxR0=;
 b=uOnCvRWGs6oeu3Jde/XWJaqb20pytL83RVdKJkXyvT73RioKMb45nZk19MqvvYezIc
 WlgP1atkjvsK44HjXqTarZv2hpwZd9XH0x8WsnNY7BrZzZUaPN2JXMoB2TSc8esmDJXU
 ntf31FQpKGfe2F1DXaSEdP/RZ+Hajtw1bhUKZICi3u/rithZNUkXJHoWj/nxPAq/mrrX
 twbDoi6Xb0gVXuzbaoAytHm6BrUG4ROjAIos5Vpx5dyajmK11ljo8dG3sILR5SxtlkXR
 cvasqKx8HcYRMV/J8zmkkEQPVxulyzraXZNVd35JfdTopeIZPQQcmxNQA7oTbwoTZNK0
 TXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xXgs8aTcQ0uGhBK5sC1zXETwAujk79dljWd/Jt9xxR0=;
 b=XOPM4orJMPrGi2fZpCPgj+N9u/5zsenFga7NeAf4RSW3ZRAsJemrAJqbHnDHHzNhhv
 SZwhkQ9YTFaDo57RJpsEsuPU6X7LjQ1J1hBqfaSuUR/f12k4qIn5n2nRAEPy1rS7Xk65
 e8sJqtz1IVkEz1XUZvPWoSTMt0D2h4eDFmLNKXgt14Bx3iahudCV0JFhs21Q4BB5GW6e
 AtY9ep8b+vc+096AIiI0AFWWCqiw/oV8ef+e6RcESFOU6g0XQfqQLdm8Ryfn5V7N/Gwt
 XrxAf2s73wdgvAHsaXsTBdZs2XLbiO5GyVEUBR50Msk5yKAwD+zVZVYbhxn7Ovl6nMtO
 ho6g==
X-Gm-Message-State: APjAAAUgKAmY+qQ3qrBNpU4ZboIZVUWFJVb0BQlZn/u+3CNQp0rCmfMq
 VWBD20tl4GkrBRYdglnj9A==
X-Google-Smtp-Source: APXvYqyKvU4FF1l+DMGylGFkQ76jnSmRhzrYP4In1sH3GWqwYOmv02NRVJrc45EqzzSq12RBWTytzA==
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr353777otq.112.1579540052529;
 Mon, 20 Jan 2020 09:07:32 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id k17sm2597801otl.45.2020.01.20.09.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 09:07:32 -0800 (PST)
Received: from t560.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:9c9c:d583:ce3d:f87a])
 by serve.minyard.net (Postfix) with ESMTPA id 7D0BD180052;
 Mon, 20 Jan 2020 17:07:31 +0000 (UTC)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: [PATCH 2/5] smbus-eeprom: remove PROP_PTR
Date: Mon, 20 Jan 2020 11:07:22 -0600
Message-Id: <20200120170725.24935-3-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120170725.24935-1-minyard@acm.org>
References: <20200120170725.24935-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Corey Minyard <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Instead, set the initial data field directly.

(the initial data is an array of 256 bytes. As I don't know if it may
change over time, I keep the pointer to original buffer as is, but it
might be worth to consider to copy it instead)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191120152442.26657-32-marcandre.lureau@redhat.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
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
 
 static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
 {
+    SMBusEEPROMDevice *eeprom = SMBUS_EEPROM(dev);
+
     smbus_eeprom_reset(dev);
+    if (eeprom->init_data == NULL) {
+        error_setg(errp, "init_data cannot be NULL");
+    }
 }
 
-static Property smbus_eeprom_properties[] = {
-    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, init_data),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -146,9 +146,8 @@ static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
     dc->reset = smbus_eeprom_reset;
     sc->receive_byte = eeprom_receive_byte;
     sc->write_data = eeprom_write_data;
-    dc->props = smbus_eeprom_properties;
     dc->vmsd = &vmstate_smbus_eeprom;
-    /* Reason: pointer property "data" */
+    /* Reason: init_data */
     dc->user_creatable = false;
 }
 
@@ -172,7 +171,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eeprom_buf)
 
     dev = qdev_create((BusState *) smbus, TYPE_SMBUS_EEPROM);
     qdev_prop_set_uint8(dev, "address", address);
-    qdev_prop_set_ptr(dev, "data", eeprom_buf);
+    SMBUS_EEPROM(dev)->init_data = eeprom_buf;
     qdev_init_nofail(dev);
 }
 
-- 
2.17.1


