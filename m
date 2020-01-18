Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC9EC33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AEE824699
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6zo+p95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEE824699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isor7-0000cz-N2
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 09:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isolo-000277-6n
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isoll-00004q-Dg
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:08:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25790
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isoll-0008Vw-A6
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579356488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iu7vbZou4Mkqkj+xWBLbpLkoGfA0UBUnIAfcX2ZZffA=;
 b=D6zo+p95EQr39nyRF8vOdPTSDGXVEj2ktk2S32asAN6WgpCkk0RQAcWdi952QRg8rTOtPo
 a2DOKNxYQzJV0xoJrEYn3RCkPf+P1X7UOr42lQzSJx5Brmg9j+2oHUZ24XQy3B3VZptX+1
 rfS39bSjDmtA3lFcCrll0Y5/Tgb47Ao=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-kRpz5jcKM9O2rt7I1TQsAw-1; Sat, 18 Jan 2020 09:08:07 -0500
Received: by mail-wr1-f70.google.com with SMTP id t3so11716297wrm.23
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 06:08:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9o3S4O25WsiD4zcH7WvaRM+9ICaD1wM7brIRiW5nnkk=;
 b=nUUntIBBMVzcvnM1wSzxX1Qn5wetaWgfTyNMFH3Rx+LsNP3QdqAqyLm7LOMehw4CTY
 wXtNghaSyvB5orAuE0aK9mb/djy7+5/5eypi5bA9JPdViL7wBKdaDAfAYsmuOMMh23k/
 rO+P/4IrqXp7u6rliDEdesHqVnTyN7Awraz5tJUnPHhMFqYw8jk8Zat3xOrEy6boqxDW
 UyLY61vU7+0i2IT2PGUpd+ss4sNhlXkcNrvdy+d/7OdsU+TSVszPbEtIcZiwv8ZxVmf1
 7zalRPhPEZAYvaa+P19RbnTPswufojlwK8s0SL7izGpH3HmCCu9dPDHo53UQZnh/Ajvd
 xlEA==
X-Gm-Message-State: APjAAAWSDBm1tIr8B5kBP5P5oCIpxQ3ILEASqEkSFjnCmrkC+Swu3axV
 ee82yAd5i31mrQABaobrAHhSYm4OWRjf1le5JbFfWmsts1rQu6+c/dBJ3dsHLsh2KQNhywgKM66
 U6soLBXKS1wBbH84=
X-Received: by 2002:a05:600c:d7:: with SMTP id
 u23mr9989786wmm.145.1579356485941; 
 Sat, 18 Jan 2020 06:08:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqyo8oLx+2Uoma9B9ZuTxpsO1h0KCe8dqGp3Wz4ymq8GIlfNEGaM/UeKV2tZfBtTZntcKXifZQ==
X-Received: by 2002:a05:600c:d7:: with SMTP id
 u23mr9989751wmm.145.1579356485643; 
 Sat, 18 Jan 2020 06:08:05 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id g21sm3731471wmh.17.2020.01.18.06.08.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 06:08:05 -0800 (PST)
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Move the OMAP section inside the ARM
 Machines one
To: Markus Armbruster <armbru@redhat.com>
References: <20200118085509.30182-1-philmd@redhat.com>
 <20200118085509.30182-3-philmd@redhat.com>
 <87pnfgq4ca.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ed3f9476-212e-18b3-7fe8-2242eef63515@redhat.com>
Date: Sat, 18 Jan 2020 15:08:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87pnfgq4ca.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: kRpz5jcKM9O2rt7I1TQsAw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/18/20 2:30 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> Add the Siemens SX1 (OMAP310) machines with the other ARM machines.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   MAINTAINERS | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 52fbc18566..e2c148d8d8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -560,6 +560,13 @@ F: include/hw/arm/digic.h
>>   F: hw/*/digic*
>>   F: include/hw/*/digic*
>>  =20
>> +OMAP
>> +M: Peter Maydell <peter.maydell@linaro.org>
>> +L: qemu-arm@nongnu.org
>> +S: Maintained
>> +F: hw/*/omap*
>> +F: include/hw/arm/omap.h
>> +
>>   Gumstix
>>   M: Peter Maydell <peter.maydell@linaro.org>
>>   R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> @@ -1404,13 +1411,6 @@ F: include/hw/block/fdc.h
>>   F: tests/qtest/fdc-test.c
>>   T: git https://github.com/jnsnow/qemu.git ide
>>  =20
>> -OMAP
>> -M: Peter Maydell <peter.maydell@linaro.org>
>> -L: qemu-arm@nongnu.org
>> -S: Maintained
>> -F: hw/*/omap*
>> -F: include/hw/arm/omap.h
>> -
>>   IPack
>>   M: Alberto Garcia <berto@igalia.com>
>>   S: Odd Fixes
>=20
> Commit message says "add", patch seems to merely move an existing
> entry.  What am I missing?

Ah yes indeed. Peter, can you modify s/Add/Move/ in the description or=20
do you prefer a respin?

Thanks,

Phil.


