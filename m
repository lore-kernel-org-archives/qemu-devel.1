Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1054CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D0A21D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRIuWjRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D0A21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iui4l-0003oj-Cj
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iugNS-0001YQ-BV
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iugNR-0001Om-1S
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:34:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55287
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iugNQ-0001O9-Sl
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579800883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QxrHYZ/+CqyAi2ffTFV1RS5A+0hVDD6X49C+Qi7UrM=;
 b=VRIuWjRWFg/gD5J7s4yMIDh6MWwXNGI7HjiMhMZ5a9V9sLkk0a+HCbo2uqLghUoa8+arag
 dPL4pxARDPWsppqBlBj4Ngt43rz9X+U/S50YEbvDF6ygKAO7MpQsWgMpLPGMQ7ETCtCKJx
 2haCrPvZxEuQ/8F7UPzLbKiJMnsEFck=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-y2O9rKKCO-WWbjOXJ-xHLA-1; Thu, 23 Jan 2020 12:29:46 -0500
Received: by mail-wm1-f72.google.com with SMTP id q26so968945wmq.8
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 09:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Yl51thC8M2gtd7bpZZXNCdwoWwXv9aSNev/0fGCwafU=;
 b=d5Q0Fh2hssvpnWNjbg6+aFI1d4WrymgkM6bIX8OFZlOU3QYzBiu2iDMHpL+z+3e0py
 4OTHcB6VaJAmQdvtRL4sfL++N8wPxnAlToPGbl5shNGevpKXBXTbG4tG0rV9KNL2d/5W
 D4pLNj7b6Y1E8XIgNExHQRAh9PTIvMK1SY42Se7qgAb+w4jjKCFigsdCaacLn6v++gHl
 wjhPLYhNdCaDnXMqkB+rf/hmZqNX1vHUm0nDMkJ9EX49O8p224Dd6pxZWcUgGElyudTm
 Q1BvlbJ35vfkI0Uzgf09ILZWrSwPAUQIhl2eb3KIMYuWnNUs4p14RWU9AbYaRPtznGK8
 jTgg==
X-Gm-Message-State: APjAAAVvph58IQR1qMeoOhtvkQc2Gj5znWVn5si9MgnXyj7WHqmZKB4s
 X4vf8QydML2kKZTt0wkQ34i2v2f1MZsHtkwTlDMvyAMeefzTBhcfNYZ/mh2GKuD9ugvnC2sNgK7
 fKIVmx0WmVW0MuWc=
X-Received: by 2002:a7b:c119:: with SMTP id w25mr4290766wmi.116.1579800584880; 
 Thu, 23 Jan 2020 09:29:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfdmtO2JHaf9GEjtzMfnGKoCi4hbVnJHE7ccBXna8fgQW3l6nzYa+N+3jTPv2sudN421Zobg==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr4290743wmi.116.1579800584649; 
 Thu, 23 Jan 2020 09:29:44 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id i5sm3461916wml.31.2020.01.23.09.29.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 09:29:44 -0800 (PST)
Subject: Re: [PATCH rc1 12/24] hw/timer: Add limited support for Atmel 16 bit
 timer peripheral
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200123000307.11541-1-richard.henderson@linaro.org>
 <20200123000307.11541-13-richard.henderson@linaro.org>
 <13770068-790a-5317-a0fa-5a672bae7253@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <acdd7512-239f-e23a-b541-dd638dd32f59@redhat.com>
Date: Thu, 23 Jan 2020 18:29:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <13770068-790a-5317-a0fa-5a672bae7253@redhat.com>
Content-Language: en-US
X-MC-Unique: y2O9rKKCO-WWbjOXJ-xHLA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: S.E.Harris@kent.ac.uk, dovgaluk@ispras.ru, me@xcancerberox.com.ar,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, mrolnik@gmail.com,
 imammedo@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/23/20 5:49 AM, Thomas Huth wrote:
> On 23/01/2020 01.02, Richard Henderson wrote:
>> From: Michael Rolnik <mrolnik@gmail.com>
>>
>> These were designed to facilitate testing but should provide enough
>> function to be useful in other contexts.  Only a subset of the functions
>> of each peripheral is implemented, mainly due to the lack of a standard
>> way to handle electrical connections (like GPIO pins).
>>
>> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>> Message-Id: <20200118191416.19934-13-mrolnik@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> [rth: Squash info mtree fixes and a file rename from f4bug, which was:]
>> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> [...]
>> +static void avr_timer16_clksrc_update(AVRTimer16State *t16)
>> +{
>> +    uint16_t divider =3D 0;
>> +    switch (CLKSRC(t16)) {
>> +    case T16_CLKSRC_EXT_FALLING:
>> +    case T16_CLKSRC_EXT_RISING:
>> +        ERROR("external clock source unsupported");
>=20
> Maybe this should rather be qemu_log_mask(LOG_UNIMP, ...) instead?

Yes.

>> +        goto end;
>> +    case T16_CLKSRC_STOPPED:
>> +        goto end;
>> +    case T16_CLKSRC_DIV1:
>> +        divider =3D 1;
>> +        break;
>> +    case T16_CLKSRC_DIV8:
>> +        divider =3D 8;
>> +        break;
>> +    case T16_CLKSRC_DIV64:
>> +        divider =3D 64;
>> +        break;
>> +    case T16_CLKSRC_DIV256:
>> +        divider =3D 256;
>> +        break;
>> +    case T16_CLKSRC_DIV1024:
>> +        divider =3D 1024;
>> +        break;
>> +    default:
>> +        goto end;
>> +    }
>> +    t16->freq_hz =3D t16->cpu_freq_hz / divider;
>> +    t16->period_ns =3D NANOSECONDS_PER_SECOND / t16->freq_hz;
>> +    DB_PRINT("Timer frequency %" PRIu64 " hz, period %" PRIu64 " ns (%f=
 s)",
>> +             t16->freq_hz, t16->period_ns, 1 / (double)t16->freq_hz);
>> +end:
>> +    return;
>> +}
>=20
> Nit: You could use an early "return" instead of "goto end" and the
> superfluous return statement at the end of the function.

I'd prefer use a 'break' statement, and check if divider !=3D then { set=20
values and log trace event}.

>> +static void avr_timer16_set_alarm(AVRTimer16State *t16)
>> +{
>> +    if (CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_FALLING ||
>> +        CLKSRC(t16) =3D=3D T16_CLKSRC_EXT_RISING ||
>> +        CLKSRC(t16) =3D=3D T16_CLKSRC_STOPPED) {
>> +        /* Timer is disabled or set to external clock source (unsupport=
ed) */
>> +        goto end;
>> +    }
>> +
>> +    uint64_t alarm_offset =3D 0xffff;
>> +    enum NextInterrupt next_interrupt =3D OVERFLOW;
>> +
>> +    switch (MODE(t16)) {
>> +    case T16_MODE_NORMAL:
>> +        /* Normal mode */
>> +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) &&
>> +            (t16->imsk & T16_INT_OCA)) {
>> +            alarm_offset =3D OCRA(t16);
>> +            next_interrupt =3D COMPA;
>> +        }
>> +        break;
>> +    case T16_MODE_CTC_OCRA:
>> +        /* CTC mode, top =3D ocra */
>> +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16)) {
>> +            alarm_offset =3D OCRA(t16);
>> +            next_interrupt =3D COMPA;
>> +        }
>> +       break;
>> +    case T16_MODE_CTC_ICR:
>> +        /* CTC mode, top =3D icr */
>> +        if (ICR(t16) < alarm_offset && ICR(t16) > CNT(t16)) {
>> +            alarm_offset =3D ICR(t16);
>> +            next_interrupt =3D CAPT;
>> +        }
>> +        if (OCRA(t16) < alarm_offset && OCRA(t16) > CNT(t16) &&
>> +            (t16->imsk & T16_INT_OCA)) {
>> +            alarm_offset =3D OCRA(t16);
>> +            next_interrupt =3D COMPA;
>> +        }
>> +        break;
>> +    default:
>> +        ERROR("pwm modes are unsupported");
>=20
> qemu_log_mask(LOG_UNIMP, ...) ?
>=20
>> +        goto end;
>> +    }
>> +    if (OCRB(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
>> +        (t16->imsk & T16_INT_OCB)) {
>> +        alarm_offset =3D OCRB(t16);
>> +        next_interrupt =3D COMPB;
>> +    }
>> +    if (OCRC(t16) < alarm_offset && OCRB(t16) > CNT(t16) &&
>> +        (t16->imsk & T16_INT_OCC)) {
>> +        alarm_offset =3D OCRB(t16);
>> +        next_interrupt =3D COMPC;
>> +    }
>> +    alarm_offset -=3D CNT(t16);
>> +
>> +    t16->next_interrupt =3D next_interrupt;
>> +    uint64_t alarm_ns =3D
>> +        t16->reset_time_ns + ((CNT(t16) + alarm_offset) * t16->period_n=
s);
>> +    timer_mod(t16->timer, alarm_ns);
>> +
>> +    DB_PRINT("next alarm %" PRIu64 " ns from now",
>> +        alarm_offset * t16->period_ns);
>> +
>> +end:
>> +    return;
>> +}
>=20
> This function could also use early returns instead of "goto end".
>=20
> (no need to respin just because of these nits ... but maybe something to
> consider if you respin anyway)
>=20
>   Thomas
>=20
>=20


