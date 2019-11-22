Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FEAC43215
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9252820870
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Atg06HH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9252820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6nh-0001tQ-Nf
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY6ms-0001GI-3L
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY6mq-0005K9-Ip
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:07:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60997
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY6mq-0005Jv-FO
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574420859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LpEgNozCzT9WZmwObMVvlN9bV6ahCOMVbHR0E6kF3t4=;
 b=Atg06HH/jF4zMhlUiUUqpAdHrYd6AJU7Rya/ed72g88TLHu763NDS7JTORFpI2NjHLppbV
 O4YrhZ+aXMZYtVHXHgVlF5h3E8Y8Ab1h50aomdqyvHq6rwo3wx9A3YV6jP5RgHQPxSOc5/
 nRVBgueGU18iK5JlVYaIt7yHgcT+nCA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-tSgI7hPfMGiH8m-vt8FuWg-1; Fri, 22 Nov 2019 06:07:37 -0500
Received: by mail-wr1-f72.google.com with SMTP id e10so3681821wrt.16
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 03:07:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b1ls0GJhWbX2KisndwiA2xaVLoQ3xG1FGJJRpEcIHmU=;
 b=D92iS3IdtJ6bX+8yCrQe9sxeNywgd3U1+1JaisoXHBxh2WUHb0q4fpQP3jzYyv5gBA
 lNFEogAmDmqLGBhQtOMjd3YMpeXbNsSVO61z0LfYs+KX5qkVXozn84P6yQbHq6I9JesH
 o3oFkcyoTU5y85dYhbeq+yXjtMqJl3qcmbIkiBvMUGwNYJONC5lDRPOq4kbL40mvlX9W
 wjEoPu40zadJo6xPbPiBz7Bq8w49rkRof30javWCks+VGJiQb9GykKq4ozAPRVFJ/6T4
 yi6NeNmzOBtvu45x/1o5EyYQyRzJ6kYKo5Ob5IrUbNPfmRNvFpAmIAS+xG+/Es4nilGm
 p9fw==
X-Gm-Message-State: APjAAAXJ5G4sR7FRqc8YAdKYdYmEmATY59Wly+g5xIy0gb3INrSbDdwD
 S755cyVEyaW71yHZ75nyEwWNms+g4sXQyb+dAjPA0fhIuGTVcZphqUL1vu4rQbBUB+MeVlsym8Z
 aFJ/jlGM//285Sp4=
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr15847962wmh.151.1574420856388; 
 Fri, 22 Nov 2019 03:07:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9jTaCUBOhvU6oDB1IK3KmlBPw9dDfTj7x/MDSSA6Fe4rMPWEYJWCyxzPpy8FDlxjOyhtRug==
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr15847938wmh.151.1574420856172; 
 Fri, 22 Nov 2019 03:07:36 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id p9sm7044762wrs.55.2019.11.22.03.07.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 03:07:35 -0800 (PST)
Subject: Re: [PATCH v4 31/37] smbus-eeprom: remove PROP_PTR
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-32-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7b1c7f87-75e0-84f0-7fec-b004923d56a7@redhat.com>
Date: Fri, 22 Nov 2019 12:07:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120152442.26657-32-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: tSgI7hPfMGiH8m-vt8FuWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 Corey Minyard <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 4:24 PM, Marc-Andr=C3=A9 Lureau wrote:
> Instead, set the initial data field directly.
>=20
> (the initial data is an array of 256 bytes. As I don't know if it may
> change over time, I keep the pointer to original buffer as is, but it
> might be worth to consider to copy it instead)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/i2c/smbus_eeprom.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index 54c86a0112..533c728b3b 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -44,7 +44,7 @@
>   typedef struct SMBusEEPROMDevice {
>       SMBusDevice smbusdev;
>       uint8_t data[SMBUS_EEPROM_SIZE];
> -    void *init_data;
> +    uint8_t *init_data;
>       uint8_t offset;
>       bool accessed;
>   } SMBusEEPROMDevice;
> @@ -129,14 +129,14 @@ static void smbus_eeprom_reset(DeviceState *dev)
>  =20
>   static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
>   {
> +    SMBusEEPROMDevice *eeprom =3D SMBUS_EEPROM(dev);
> +
>       smbus_eeprom_reset(dev);
> +    if (eeprom->init_data =3D=3D NULL) {
> +        error_setg(errp, "init_data cannot be NULL");
> +    }
>   }
>  =20
> -static Property smbus_eeprom_properties[] =3D {
> -    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, init_data),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>   static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -146,9 +146,8 @@ static void smbus_eeprom_class_initfn(ObjectClass *kl=
ass, void *data)
>       dc->reset =3D smbus_eeprom_reset;
>       sc->receive_byte =3D eeprom_receive_byte;
>       sc->write_data =3D eeprom_write_data;
> -    dc->props =3D smbus_eeprom_properties;
>       dc->vmsd =3D &vmstate_smbus_eeprom;
> -    /* Reason: pointer property "data" */
> +    /* Reason: init_data */
>       dc->user_creatable =3D false;
>   }
>  =20
> @@ -172,7 +171,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t add=
ress, uint8_t *eeprom_buf)
>  =20
>       dev =3D qdev_create((BusState *) smbus, TYPE_SMBUS_EEPROM);
>       qdev_prop_set_uint8(dev, "address", address);
> -    qdev_prop_set_ptr(dev, "data", eeprom_buf);
> +    SMBUS_EEPROM(dev)->init_data =3D eeprom_buf;

Isn't this a QOM anti-pattern?

>       qdev_init_nofail(dev);
>   }
>  =20
>=20


