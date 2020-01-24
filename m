Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B055AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB6420708
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYeOgtcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB6420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuyQw-0000Ga-OV
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 07:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuyQ7-0007md-JJ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuyQ6-0003R0-EE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:50:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28268
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuyQ6-0003PQ-AK
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579870242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+mp3//erqSzd3/gVz70vg47VpR5prs2RkavX6aqb1Y=;
 b=YYeOgtcbcOWVGtmFOPGbMykUNjMWNDWgKecnMssPxun4OQneO0GfUrZ3srXx1kmRBMiP93
 j8gmf05dDmeDwFS3hjFlMpGZyyGUXwIKqE/FirgtLVYpHYeW0N6DfxwkqNGaNU5978XvLG
 imoiZOpuNrFrdt0g30LIR2gba1/xn1c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-HlVafu30M3KdqQ40ydAjwA-1; Fri, 24 Jan 2020 07:50:39 -0500
Received: by mail-wr1-f70.google.com with SMTP id k18so1113794wrw.9
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 04:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pZFI9gdEY18DUnDJSvo+WwYq1TaEIq/5uGQsvODasOA=;
 b=AjLUz665WOzWWrYSalPmFTdcZrAevjay/R2vnL3k7l8e3MSu5UuuHd/9HgggEehJ3v
 U1+bsvzxrT5QrqLSrWMz0D15hU+FJhdy8jH0fA93ktwIYd7yexe1rOguu2uYJzTwAfnN
 T8A3NDc20kVLZRHnXoZ1x3judOkpGrc3JyLBo2RFuvDvZSdeqH+fG82053YX5vELnsiM
 aa74inYB7hmshLWqIqIbySqN2iEBM519sGR9bPqMx72x4yAYvGEkqh1QJH0SyJB+JqHj
 qmC3dLLkhSXw+LclbRsT8SPMC0h2DwsviCnlJSTJg+StAQ9XHNiLrrtXyeVbOkFUZ+d+
 T5XA==
X-Gm-Message-State: APjAAAWEs4jyZQIDGMtWWCINKG5YP4jGugdvSy3Fz36baWDcgTLkcCdX
 2UhjcLcPBLyoCVS0+c8T+NeGNJNhUFyrUoBy11K1TfAQU3wb3io05GWJuwqrGjOLYNeY82gkNxs
 p8yTTD/B6jZKgoYM=
X-Received: by 2002:a1c:a515:: with SMTP id o21mr3312379wme.85.1579870238855; 
 Fri, 24 Jan 2020 04:50:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqy9xuGA+8xUOx+T4ycfpMnXOJQ4+8Vv1fgz+eVy24bn2FurvT1MnntKKwP6G2KHUFlpOsFwCg==
X-Received: by 2002:a1c:a515:: with SMTP id o21mr3312350wme.85.1579870238661; 
 Fri, 24 Jan 2020 04:50:38 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id p17sm6819636wmk.30.2020.01.24.04.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 04:50:38 -0800 (PST)
Subject: Re: [PATCH rc2 12/25] hw/timer: Add limited support for Atmel 16 bit
 timer peripheral
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, qemu-devel@nongnu.org, mrolnik@gmail.com,
 richard.henderson@linaro.org, me@xcancerberox.com.ar
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-13-f4bug@amsat.org>
 <4f9a6d13-63b3-3df6-ecd9-def3908f90b3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3adbf3cf-37bf-237e-7c8f-1f2e9e7a5a70@redhat.com>
Date: Fri, 24 Jan 2020 13:50:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4f9a6d13-63b3-3df6-ecd9-def3908f90b3@redhat.com>
Content-Language: en-US
X-MC-Unique: HlVafu30M3KdqQ40ydAjwA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 dovgaluk@ispras.ru, imammedo@redhat.com,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 9:16 AM, Thomas Huth wrote:
> On 24/01/2020 01.51, Philippe Mathieu-Daud=C3=A9 wrote:
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
>> [PMD: Use qemu_log_mask(LOG_UNIMP), replace goto by return]
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> rc2: Use qemu_log_mask(LOG_UNIMP), replace goto by return (thuth)
>> ---
>>   include/hw/timer/atmel_timer16.h |  94 +++++
>>   hw/timer/atmel_timer16.c         | 605 +++++++++++++++++++++++++++++++
>>   hw/timer/Kconfig                 |   3 +
>>   hw/timer/Makefile.objs           |   2 +
>>   4 files changed, 704 insertions(+)
>>   create mode 100644 include/hw/timer/atmel_timer16.h
>>   create mode 100644 hw/timer/atmel_timer16.c
> [...]
>> +static void avr_timer16_clksrc_update(AVRTimer16State *t16)
>> +{
>> +    uint16_t divider =3D 0;
>> +    switch (CLKSRC(t16)) {
>> +    case T16_CLKSRC_EXT_FALLING:
>> +    case T16_CLKSRC_EXT_RISING:
>> +        qemu_log_mask(LOG_UNIMP, "%s: external clock source unsupported=
\n",
>> +                      __func__);
>> +        break;
>> +    case T16_CLKSRC_STOPPED:
>> +        break;
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
>> +        break;
>> +    }
>> +    if (divider) {
>> +        t16->freq_hz =3D t16->cpu_freq_hz / divider;
>> +        t16->period_ns =3D NANOSECONDS_PER_SECOND / t16->freq_hz;
>> +        DB_PRINT("Timer frequency %" PRIu64 " hz, period %" PRIu64 " ns=
 (%f s)",
>> +                 t16->freq_hz, t16->period_ns, 1 / (double)t16->freq_hz=
);
>> +    }
>> +    return;
>> +}
>=20
> You can remove the "return;" at the end of the function now, too.

Oops I didn't notice.

Richard, do you mind to remove this single line?

Thanks both :)


