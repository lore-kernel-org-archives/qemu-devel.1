Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F62C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5F820862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsFUx432"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5F820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9rk-0005iE-JA
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iA9q2-0004oe-Rk
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iA9q1-0002jv-G3
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:31:58 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iA9q1-0002h4-2N
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:31:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id q17so2310525wrx.10
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 02:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=01NIAzPxt4FCKal2z0X9NukHMe58mfMpvUKcrLoiEyo=;
 b=DsFUx432BkxHnBGOxHBp6X2ugj3SqRfE16+G3v/ZaROXyInBOkEtWrPK9KhE42wS1N
 i98iI+jkHXgdBNoryHL6QM9Le59TtPpAT75+tMvbk1FE2Ng01/nezx3UKFHHns/QbYTh
 Yt1MqtZwbBWIjHoRnMChpm1QNDqWl7/jl2Oar/HaCs8oObinU429jDcdrxTy8cC7LUZL
 /m99bybyPOeDDZvVDgsqlna7acH/6XKG2oI+f6Bbfxyp6jvTLg4OpyJGfANTIeCgU4tU
 Odk7L1F89fm75m4AUUWI4DvBikDOXXWuN9DYNRjR1RRGKqdWOdHhqmjnxFS7XPmVsZRS
 avaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=01NIAzPxt4FCKal2z0X9NukHMe58mfMpvUKcrLoiEyo=;
 b=UdzHnDyb4HGOyWZXJaJjs72y80UgbI3QR3YQOOJ38a+G75fcE4+tjkP4+XNz53CfY7
 j7VvpMBDdz8FvxpF/6rswMZOk5hOd45L04Omnjxr5NP5YFwavNnTQKXL3o8LVd7gY5hf
 u+imlM9Ptu5RJOE+fL1F6vQzl5VMlOuwe2yj+a5aQSgljPv30+HzvJ7fxoHAd69Udkcf
 H1DXfjdi98wJ+v1jCJ7ZarDlUWhZakhxS2rwEhJDebcCNI/b/NrFCbp9VMQByDvzuhVf
 UZeJsVrEARdTQNSugIqll4/UfWZxAXpsa5dacx9ei0Xr/w93XKvzt7VH35d7XzlAodjt
 IxKg==
X-Gm-Message-State: APjAAAWvhXF57MqRlU5577AGi0hfC9W6izrjZuhHFvG0d2k+9LkUEeg8
 bhM2Q+BXrWS6TPvx9BV1wVCvmg==
X-Google-Smtp-Source: APXvYqwy3dMUEFDdV3TzEjGEaQu8rH+yEJYRLDjtU5mP8Pm6DzJH0xFGqVu2DOyjR5FfHlEoXbQBFw==
X-Received: by 2002:a5d:5592:: with SMTP id i18mr2034326wrv.316.1568712714715; 
 Tue, 17 Sep 2019 02:31:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e20sm2686987wrc.34.2019.09.17.02.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 02:31:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4F4481FF87;
 Tue, 17 Sep 2019 10:31:53 +0100 (BST)
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190915211940.30427-4-f4bug@amsat.org>
 <20190916193245.GA15318@dhcp-17-173.bos.redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
In-reply-to: <20190916193245.GA15318@dhcp-17-173.bos.redhat.com>
Date: Tue, 17 Sep 2019 10:31:53 +0100
Message-ID: <87impr1d6e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 3/6] tests/acceptance: Test OpenBIOS on
 the PReP/40p
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 qemu-ppc@nongnu.org,
 =?utf-8?Q?Herv?= =?utf-8?Q?=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cleber Rosa <crosa@redhat.com> writes:

> On Sun, Sep 15, 2019 at 11:19:37PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> User case from:
>> https://mail.coreboot.org/pipermail/openbios/2018-May/010360.html
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  tests/acceptance/ppc_prep_40p.py | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_pre=
p_40p.py
>> index a0eac40d9f..87b5311b89 100644
>> --- a/tests/acceptance/ppc_prep_40p.py
>> +++ b/tests/acceptance/ppc_prep_40p.py
>> @@ -82,3 +82,35 @@ class IbmPrep40pMachine(Test):
>>          self.wait_for_console_pattern(fw_banner)
>>          prompt_msg =3D 'Type any key to interrupt automatic startup'
>>          self.wait_for_console_pattern(prompt_msg)
>> +
>> +    def test_openbios_192m(self):
>> +        """
>> +        :avocado: tags=3Darch:ppc
>> +        :avocado: tags=3Dmachine:40p
>> +        """
>> +        self.vm.set_machine('40p')
>> +        self.vm.set_console()
>> +        self.vm.add_args('-m', '192')
>
> Is 192 a magic number (some kind of limit)?  Or just a value to check
> against later?

Just the memory configured for the machine, checked bellow. Or are you
wondering why 192m and not any other amount?

>> +
>> +        self.vm.launch()
>> +        self.wait_for_console_pattern('>> OpenBIOS')
>> +        self.wait_for_console_pattern('>> Memory: 192M')
>> +        self.wait_for_console_pattern('>> CPU type PowerPC,604')
>> +
>
> On my testing, this is a very stable test, I'm only getting PASSes.
<snip>

--
Alex Benn=C3=A9e

