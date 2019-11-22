Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FD1C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED412070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdhvosNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED412070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6wN-00079t-Rf
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:17:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY6uk-00062t-1H
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY6ui-0000Yp-7x
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:15:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY6ui-0000Yc-3x
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574421347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n5Q42ccdhyvt9pF9/iMP6nbKZK7VE0zC76LyXxEcYRo=;
 b=NdhvosNJBvHqxZdfftq6l5flC7xW47BLQdKldN4B1FQRWnWpwwkgyu/b08dlWfKTD81Xfa
 ZeA44fkZnARG0Oq2C5vX7QoZU1o/mvZChU0cbwGwfbgfKOQsxcBo53yM53tZb6mHXGGRI4
 NNRBn14puxvAtObjWiCM7kVKEPnCbWU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-KEZJ20zIO2auUWkb0m1Pag-1; Fri, 22 Nov 2019 06:15:42 -0500
Received: by mail-wm1-f69.google.com with SMTP id f21so2922613wmh.5
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 03:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ueU8QiyMH+LvCn/cpZBMG1p8qja0FYb9cg6/LqE1Zw8=;
 b=Zm560IwGiUDrTZ4prrJfN24s5mQODSZQT0pCak0Hbpp2HfuaStm5LEGa83viAzomM4
 mhiytB6WuHUkd9xG9HrrxuyE6RPizSEbv77B0+zEB3Z9cQkivZPNrHEr7M4RTNzsaB/h
 g2VJXg/vTrMpB/QF85pTkiWm4dK6dlPMfB4yq97xEe/OpYXbEHiQi/Xm1RH/wQ6Qy3XG
 qEVNnk1g/7oqLWr8J0G4MJJ8kN/l5mFUYeOhJF/TK6FEMuAU6YeRmuNxQt2zV3m/xjLX
 C2RJ0K8aFto3ZSFJc3xJ3HQyYGu7WZGQMIL3zN3wHJAFapqHmQ7FzQ5UiiAiyW0pC6AR
 npNA==
X-Gm-Message-State: APjAAAW2MgGpOyD5qCqadzjxZwBAyurDB4rXjnIW5sQbwTTQ5lw9nFtk
 6FI2aeOB7thPePU4Zce0czd3BPvlHPyiax/+FQMNkpls1OoTF7tjtV9aWoVEm9ieSEhIwWd2+4h
 eMms6HXae0zxV7y0=
X-Received: by 2002:adf:f20b:: with SMTP id p11mr6655856wro.195.1574421341095; 
 Fri, 22 Nov 2019 03:15:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4/Th1utxl0yAdmzOoUtK30PnEGnGdpcQGARn0UOqRKNl/hJ7HCMNmqScWMd13N/XdoNscAA==
X-Received: by 2002:adf:f20b:: with SMTP id p11mr6655830wro.195.1574421340866; 
 Fri, 22 Nov 2019 03:15:40 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id f24sm3091268wmb.37.2019.11.22.03.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 03:15:40 -0800 (PST)
Subject: Re: [PATCH v4 31/37] smbus-eeprom: remove PROP_PTR
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-32-marcandre.lureau@redhat.com>
 <7b1c7f87-75e0-84f0-7fec-b004923d56a7@redhat.com>
 <CAMxuvayHYTYyWzZVhMebWyGhhpwq8XMJOKCZviV9vezqX+nB9Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <50fafaff-a5f3-6197-abbb-9689f8a681ce@redhat.com>
Date: Fri, 22 Nov 2019 12:15:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMxuvayHYTYyWzZVhMebWyGhhpwq8XMJOKCZviV9vezqX+nB9Q@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: KEZJ20zIO2auUWkb0m1Pag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Corey Minyard <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 12:12 PM, Marc-Andr=C3=A9 Lureau wrote:
> On Fri, Nov 22, 2019 at 3:07 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> On 11/20/19 4:24 PM, Marc-Andr=C3=A9 Lureau wrote:
>>> Instead, set the initial data field directly.
>>>
>>> (the initial data is an array of 256 bytes. As I don't know if it may
>>> change over time, I keep the pointer to original buffer as is, but it
>>> might be worth to consider to copy it instead)
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    hw/i2c/smbus_eeprom.c | 17 ++++++++---------
>>>    1 file changed, 8 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>>> index 54c86a0112..533c728b3b 100644
>>> --- a/hw/i2c/smbus_eeprom.c
>>> +++ b/hw/i2c/smbus_eeprom.c
>>> @@ -44,7 +44,7 @@
>>>    typedef struct SMBusEEPROMDevice {
>>>        SMBusDevice smbusdev;
>>>        uint8_t data[SMBUS_EEPROM_SIZE];
>>> -    void *init_data;
>>> +    uint8_t *init_data;
>>>        uint8_t offset;
>>>        bool accessed;
>>>    } SMBusEEPROMDevice;
>>> @@ -129,14 +129,14 @@ static void smbus_eeprom_reset(DeviceState *dev)
>>>
>>>    static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
>>>    {
>>> +    SMBusEEPROMDevice *eeprom =3D SMBUS_EEPROM(dev);
>>> +
>>>        smbus_eeprom_reset(dev);
>>> +    if (eeprom->init_data =3D=3D NULL) {
>>> +        error_setg(errp, "init_data cannot be NULL");
>>> +    }
>>>    }
>>>
>>> -static Property smbus_eeprom_properties[] =3D {
>>> -    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, init_data),
>>> -    DEFINE_PROP_END_OF_LIST(),
>>> -};
>>> -
>>>    static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data=
)
>>>    {
>>>        DeviceClass *dc =3D DEVICE_CLASS(klass);
>>> @@ -146,9 +146,8 @@ static void smbus_eeprom_class_initfn(ObjectClass *=
klass, void *data)
>>>        dc->reset =3D smbus_eeprom_reset;
>>>        sc->receive_byte =3D eeprom_receive_byte;
>>>        sc->write_data =3D eeprom_write_data;
>>> -    dc->props =3D smbus_eeprom_properties;
>>>        dc->vmsd =3D &vmstate_smbus_eeprom;
>>> -    /* Reason: pointer property "data" */
>>> +    /* Reason: init_data */
>>>        dc->user_creatable =3D false;
>>>    }
>>>
>>> @@ -172,7 +171,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t a=
ddress, uint8_t *eeprom_buf)
>>>
>>>        dev =3D qdev_create((BusState *) smbus, TYPE_SMBUS_EEPROM);
>>>        qdev_prop_set_uint8(dev, "address", address);
>>> -    qdev_prop_set_ptr(dev, "data", eeprom_buf);
>>> +    SMBUS_EEPROM(dev)->init_data =3D eeprom_buf;
>>
>> Isn't this a QOM anti-pattern?
>=20
> Sort of, but using prop_ptr in the first place is an anti-pattern. So
> I am not improving the situation much here, but just getting rid of
> prop_ptr usage.

Alright.

> Using an array of bytes instead could be done in a follow-up patch. I
> can leave a fixme if that helps.

IIRC there was a discussion earlier this year about using block backend=20
for this device.

>>
>>>        qdev_init_nofail(dev);
>>>    }
>>>
>>>
>>
>=20


