Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B507C43141
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07CCA20730
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkRCzkpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CCA20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6s1-0003cb-50
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:13:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iY6rM-0002oF-T4
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iY6rK-0007NG-VY
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:12:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22568
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iY6rK-0007MT-Rj
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574421137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x0OR4dZ8MHeZVzGqQaeSa45WGGYwDV84ORlT3+7UtSc=;
 b=QkRCzkpg+yKAmOwH6zS2f4TMY+v9ixtqZTIdHBAx6oRfk7BkrwYS1Zagdc3mlJQgRWoM6d
 4QjTZAjcqtAreNWLsl4i2/1chwhlsmGXkVtw3DGdrij/ce+7Z95YlLPmppIcDJUvjN57b9
 BE0KkFuzkZBtZd6yg3UllbhcJxtgdz0=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-lcwKcg54OBewkKxeTl9OKg-1; Fri, 22 Nov 2019 06:12:16 -0500
Received: by mail-oi1-f200.google.com with SMTP id s204so3465856oib.7
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 03:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=x0OR4dZ8MHeZVzGqQaeSa45WGGYwDV84ORlT3+7UtSc=;
 b=SPKU2tn67QpO4E/GlKPNfp8S2SdevBnjpTtLuCQIFpTkeX/1PmDbh676hXWHAm5pzP
 wDtOCm3LB9+HgAT72gR0G8s25g+W31dquVtYC0RLvE+GccaaSbYYXPsNx96WAbw43y2x
 P6kMFg6HaTGGcAR1J7Z9q8E6chG5DKeSro3N6VO6v3O4at3OqCOpJm0Mmp6VEFgr1G1A
 By6iZllD20ZL4i17zGeBDgT7Z5ANQo2kq5urRl6lxOv1NkCcknKgythmnhUeRCPU3Z9O
 94onO+0EJ4KxYQgY39dU9mYJbmdvudgxC+qh279kQ4p05y5nLh6GrWPoiaFbfRCxPR9P
 pZbw==
X-Gm-Message-State: APjAAAVO5vT8kntXy5VXf+kFBYBUe5iA4+ww7FfywflBQUFIfxAgm/86
 7FULsVXDBRIty60WuNCPWntR5yNcRIJLZk120aSmP0ljgsVwhBEfar2okigRjs4F/ImyNsYIY2w
 YnMJmTNxMLbJesS/vqw8X0bTijHtYKbA=
X-Received: by 2002:a05:6808:c8:: with SMTP id
 t8mr12154926oic.46.1574421135463; 
 Fri, 22 Nov 2019 03:12:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxiivQBe/YCJKnu4yJBbIuAbNjfVBkhAmh/eg2gCHpQKfloHkd08RASbCqz9oPDAFFjUClEJO5c9l4ocCv0dzU=
X-Received: by 2002:a05:6808:c8:: with SMTP id
 t8mr12154898oic.46.1574421135059; 
 Fri, 22 Nov 2019 03:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-32-marcandre.lureau@redhat.com>
 <7b1c7f87-75e0-84f0-7fec-b004923d56a7@redhat.com>
In-Reply-To: <7b1c7f87-75e0-84f0-7fec-b004923d56a7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 22 Nov 2019 15:12:03 +0400
Message-ID: <CAMxuvayHYTYyWzZVhMebWyGhhpwq8XMJOKCZviV9vezqX+nB9Q@mail.gmail.com>
Subject: Re: [PATCH v4 31/37] smbus-eeprom: remove PROP_PTR
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-MC-Unique: lcwKcg54OBewkKxeTl9OKg-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Corey Minyard <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 3:07 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 11/20/19 4:24 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Instead, set the initial data field directly.
> >
> > (the initial data is an array of 256 bytes. As I don't know if it may
> > change over time, I keep the pointer to original buffer as is, but it
> > might be worth to consider to copy it instead)
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/i2c/smbus_eeprom.c | 17 ++++++++---------
> >   1 file changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> > index 54c86a0112..533c728b3b 100644
> > --- a/hw/i2c/smbus_eeprom.c
> > +++ b/hw/i2c/smbus_eeprom.c
> > @@ -44,7 +44,7 @@
> >   typedef struct SMBusEEPROMDevice {
> >       SMBusDevice smbusdev;
> >       uint8_t data[SMBUS_EEPROM_SIZE];
> > -    void *init_data;
> > +    uint8_t *init_data;
> >       uint8_t offset;
> >       bool accessed;
> >   } SMBusEEPROMDevice;
> > @@ -129,14 +129,14 @@ static void smbus_eeprom_reset(DeviceState *dev)
> >
> >   static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
> >   {
> > +    SMBusEEPROMDevice *eeprom =3D SMBUS_EEPROM(dev);
> > +
> >       smbus_eeprom_reset(dev);
> > +    if (eeprom->init_data =3D=3D NULL) {
> > +        error_setg(errp, "init_data cannot be NULL");
> > +    }
> >   }
> >
> > -static Property smbus_eeprom_properties[] =3D {
> > -    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, init_data),
> > -    DEFINE_PROP_END_OF_LIST(),
> > -};
> > -
> >   static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
> >   {
> >       DeviceClass *dc =3D DEVICE_CLASS(klass);
> > @@ -146,9 +146,8 @@ static void smbus_eeprom_class_initfn(ObjectClass *=
klass, void *data)
> >       dc->reset =3D smbus_eeprom_reset;
> >       sc->receive_byte =3D eeprom_receive_byte;
> >       sc->write_data =3D eeprom_write_data;
> > -    dc->props =3D smbus_eeprom_properties;
> >       dc->vmsd =3D &vmstate_smbus_eeprom;
> > -    /* Reason: pointer property "data" */
> > +    /* Reason: init_data */
> >       dc->user_creatable =3D false;
> >   }
> >
> > @@ -172,7 +171,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t a=
ddress, uint8_t *eeprom_buf)
> >
> >       dev =3D qdev_create((BusState *) smbus, TYPE_SMBUS_EEPROM);
> >       qdev_prop_set_uint8(dev, "address", address);
> > -    qdev_prop_set_ptr(dev, "data", eeprom_buf);
> > +    SMBUS_EEPROM(dev)->init_data =3D eeprom_buf;
>
> Isn't this a QOM anti-pattern?

Sort of, but using prop_ptr in the first place is an anti-pattern. So
I am not improving the situation much here, but just getting rid of
prop_ptr usage.

Using an array of bytes instead could be done in a follow-up patch. I
can leave a fixme if that helps.

>
> >       qdev_init_nofail(dev);
> >   }
> >
> >
>


