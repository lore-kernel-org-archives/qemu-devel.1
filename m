Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A02C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD702071E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QU4DmoXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD702071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZBO7-0005wQ-Ey
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 05:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iZBM6-0004Ww-22
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iZBM3-0002NZ-16
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:12:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53197
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iZBM2-0002Ld-1E
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574676743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rWLRDGxsJf8TSdEr/nAlghOY2BPi5mV+tisC4DKxr5s=;
 b=QU4DmoXYzPMbHt64B6pSTGd5d5F0aM+Dd0WyEyuYLuPZmjohkZO1spkBoQwWsZqwczawli
 VxJbdlra3/eSDOGNebO8qf+HEhahNNOfNFR9lSDfWo2zO6mfWsHtK1dqYZi9XfbYOhPAII
 vUuR8twsELa69jQJqpohd+F4nGIzwG8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-_hl1uk1mMUi4tdoh1wWpOA-1; Mon, 25 Nov 2019 05:12:20 -0500
Received: by mail-ot1-f71.google.com with SMTP id m7so7811842otr.12
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 02:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rWLRDGxsJf8TSdEr/nAlghOY2BPi5mV+tisC4DKxr5s=;
 b=VJMnsMC4hEx87OEcDMvUG0qEig4M2csvxSkupQwJR9lE8CX48wZceQvdOk79Lb8FVA
 oylZGCUhQ13U/aARImIVLfYf4abNlXQ4xFJgk+448af4iSdKmqYc0SpxItYwyI7ACzM0
 M7Cju0aKkAa7rQOOkfSfc8zh3843zRttjYWAg1GbGzybdlaMnaoorRa486YNWSyTsYGk
 LqrQuDO9JOJ2DhAC8rCnSA6QNJhvcQX/T64Uj1rKyRfenkeftcpzlIGGLyuZM9Io8yuh
 3/ZN1RXzELfqDTE9eI7O2fo9tvyzxPfz4nSonJXHaFm+bbDHOTzvtgRzzidpPP5pxVcO
 4/5Q==
X-Gm-Message-State: APjAAAUZcOgTlNwMbeae5X42uFMjzucbDaV9Z4hx0B2F0KFgyrZMP24L
 d+6Cnslz7FCMvjEFZUW+spSeD+8q9WI3J3zJhSVbPExxpA6cavYD7/Ca+zHwjBpidfwIyxP3RsJ
 Ivd0Cyi20pa5mgy1kiw1Oxz3JHl7gUPQ=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18549950otg.368.1574676739080; 
 Mon, 25 Nov 2019 02:12:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9bst2NRjhUWKUh8CeExA37uCgloe9iJiYqf6rLcE6roGBtuNBXO64KwS7cx/2jJb8gyqCbVg2Ld1g2af//V8=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18549942otg.368.1574676738886; 
 Mon, 25 Nov 2019 02:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-19-marcandre.lureau@redhat.com>
 <CAL1e-=huXgGw-uXtNXqu111O8yE-Jw_+vHXqE7Wfw1efPZATSw@mail.gmail.com>
In-Reply-To: <CAL1e-=huXgGw-uXtNXqu111O8yE-Jw_+vHXqE7Wfw1efPZATSw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 25 Nov 2019 14:12:07 +0400
Message-ID: <CAMxuvawAL5wK31-BdGWNj4p8ZavMDAvtNgjJN7Yn6EhDyB-=uw@mail.gmail.com>
Subject: Re: [PATCH v4 18/37] mips: baudbase is 115200 by default
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
X-MC-Unique: _hl1uk1mMUi4tdoh1wWpOA-1
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Nov 25, 2019 at 2:07 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
>
>
> On Wednesday, November 20, 2019, Marc-Andr=C3=A9 Lureau <marcandre.lureau=
@redhat.com> wrote:
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  hw/mips/mips_mipssim.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
>> index bfafa4d7e9..3cd0e6eb33 100644
>> --- a/hw/mips/mips_mipssim.c
>> +++ b/hw/mips/mips_mipssim.c
>> @@ -223,7 +223,6 @@ mips_mipssim_init(MachineState *machine)
>>      if (serial_hd(0)) {
>>          DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
>>
>> -        qdev_prop_set_uint32(DEVICE(dev), "baudbase", 115200);
>>          qdev_prop_set_chr(dev, "chardev", serial_hd(0));
>>          qdev_set_legacy_instance_id(dev, 0x3f8, 2);
>>          qdev_init_nofail(dev);
>> --
>
>
> Please mention in your commit message where the default baudbase is set.

ok

> Also, is there a guarantie that default value 115200 will never change in=
 future?

The level of stability on properties in general is unclear to me.

Given that 115200 is standard for serial, it is unlikely to change
though.. We can have an assert there instead?

Peter, what do you think? thanks


