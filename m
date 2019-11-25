Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B05C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429EA2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwK7RBF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429EA2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZBQW-0007ZO-Cy
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 05:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iZBPi-0006vM-E1
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iZBPh-0003iN-AF
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:16:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42979
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iZBPh-0003i0-6B
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574676972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gXFHqMljj42gi/Hjiu6zvwJIZmwUGMVMi1lq66Ot+N0=;
 b=bwK7RBF3D/NJPwITYZyeTNoG2+ugeuEiYfTZXLVhzLMj7WEhmhx5rtdNYKQp4KGHz9smK+
 ++w06HbjrZ7WB1pOWyrUGWPaGLjiyciZ7hC0RuJzpdFjNhCbeMwy7AvYZgw0f5nwKYrb6I
 xd3V4h3KFIox7s8Y279GCBdQw0HWq+U=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-S0gSyzVDPLSk4wKo-xOoiA-1; Mon, 25 Nov 2019 05:16:11 -0500
Received: by mail-oi1-f200.google.com with SMTP id q82so7278073oih.14
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 02:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gXFHqMljj42gi/Hjiu6zvwJIZmwUGMVMi1lq66Ot+N0=;
 b=HQXGSIZTEWR73qjKrHQuYV/13eNltm0zxQ11RdnebG0QqKhFeTUkJPvcu11LeItJDy
 amglAA3cfzfAwKTvihEiohFQbbtTaD5P0OI20U373fqeeUJQC3KYvqx1VVsxJAp1asc+
 C8797P6L5Y8eeYbfF6jU2qsS5Nj7TJkAnrkEfcb3FRi6FfaD8FckgPdfCzKS3NtP4/3j
 z6aRokwdimRPsbrE9slYeZYhl56Vne2UhKAvujWzFvFyhkSwefbqUMuEr25uUW2OF17E
 Q+qSm1FEMh/SnqIz1tp7ZUhu3qmWR6/HI+vzoYELwdvKQGr386PgA1rw+866HVzwZ+Xv
 dE3A==
X-Gm-Message-State: APjAAAUxOZu7VO1tgVIoli9aA9/hp+o7varR3WFUrXAtqsbOBtPrzS1K
 dRsa1SI5Lj1itSlBF0pSTItR99/E12gSdHwnQQFbU4E7wl1oyzAlT0jU+SQEt2roPq5YOFlVaW8
 QNNLu9Uojhhd3qVaG6YEqK1cOk+TIC1Q=
X-Received: by 2002:a05:6830:164a:: with SMTP id
 h10mr18702120otr.62.1574676970639; 
 Mon, 25 Nov 2019 02:16:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwNEjq7OIRFlVYwkVSqqdncYauRWqk0tWPivUW1ZUzkUho9kHDNC6mjYiAxaVcv54VPIfX52fNtpAJCgbS9Shw=
X-Received: by 2002:a05:6830:164a:: with SMTP id
 h10mr18702091otr.62.1574676970352; 
 Mon, 25 Nov 2019 02:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-18-marcandre.lureau@redhat.com>
 <CAL1e-=iqhBRcscTEDHczoqTGbCZnu386AX-WHnVdq-0uYA25ug@mail.gmail.com>
In-Reply-To: <CAL1e-=iqhBRcscTEDHczoqTGbCZnu386AX-WHnVdq-0uYA25ug@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 25 Nov 2019 14:15:58 +0400
Message-ID: <CAMxuvaxeNQae2iN63CvskxjOiug3dTocaqri4rU9fO6nkz+2Hw@mail.gmail.com>
Subject: Re: [PATCH v4 17/37] mips: inline serial_init()
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
X-MC-Unique: S0gSyzVDPLSk4wKo-xOoiA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Nov 25, 2019 at 2:12 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
>
>
> On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau <marcandre.lureau=
@redhat.com> wrote:
>>
>> The function is specific to mipssim, let's inline it.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  hw/char/serial.c         | 16 ----------------
>>  hw/mips/mips_mipssim.c   | 15 ++++++++++++---
>>  include/hw/char/serial.h |  2 --
>>  3 files changed, 12 insertions(+), 21 deletions(-)
>>
>> diff --git a/hw/char/serial.c b/hw/char/serial.c
>> index 164146ede8..23f0b02516 100644
>> --- a/hw/char/serial.c
>> +++ b/hw/char/serial.c
>> @@ -1023,22 +1023,6 @@ static const TypeInfo serial_io_info =3D {
>>      .class_init =3D serial_io_class_init,
>>  };
>>
>> -SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
>> -                         Chardev *chr, MemoryRegion *system_io)
>> -{
>> -    SerialIO *sio =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
>> -
>> -    qdev_prop_set_uint32(DEVICE(sio), "baudbase", baudbase);
>> -    qdev_prop_set_chr(DEVICE(sio), "chardev", chr);
>> -    qdev_set_legacy_instance_id(DEVICE(sio), base, 2);
>> -    qdev_init_nofail(DEVICE(sio));
>> -
>> -    sysbus_connect_irq(SYS_BUS_DEVICE(sio), 0, irq);
>> -    memory_region_add_subregion(system_io, base, &sio->serial.io);
>> -
>> -    return sio;
>> -}
>> -
>>  static Property serial_properties[] =3D {
>>      DEFINE_PROP_CHR("chardev", SerialState, chr),
>>      DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
>> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
>> index 282bbecb24..bfafa4d7e9 100644
>> --- a/hw/mips/mips_mipssim.c
>> +++ b/hw/mips/mips_mipssim.c
>> @@ -40,6 +40,7 @@
>>  #include "hw/loader.h"
>>  #include "elf.h"
>>  #include "hw/sysbus.h"
>> +#include "hw/qdev-properties.h"
>>  #include "exec/address-spaces.h"
>>  #include "qemu/error-report.h"
>>  #include "sysemu/qtest.h"
>> @@ -219,9 +220,17 @@ mips_mipssim_init(MachineState *machine)
>>       * A single 16450 sits at offset 0x3f8. It is attached to
>>       * MIPS CPU INT2, which is interrupt 4.
>>       */
>> -    if (serial_hd(0)) a
>> -        serial_init(0x3f8, env->irq[4], 115200, serial_hd(0),
>> -                    get_system_io());
>> +    if (serial_hd(0)) {
>> +        DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
>> +
>> +        qdev_prop_set_uint32(DEVICE(dev), "baudbase", 115200);
>> +        qdev_prop_set_chr(dev, "chardev", serial_hd(0));
>> +        qdev_set_legacy_instance_id(dev, 0x3f8, 2);
>> +        qdev_init_nofail(dev);
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
>> +        memory_region_add_subregion(get_system_io(), 0x3f8,
>> +                                    &SERIAL_IO(dev)->serial.io);
>> +    }
>
>
>
> Please explain why the code in the deleted function and the new function =
are not identical. Why is the new code better?

What differences do you spot?

serial_init() looks very generic, but it is not, and this is
confusing. QDev users should call qdev_create().

If there is a single user, it is better to inline the code where it is
being used, or move the function there.


