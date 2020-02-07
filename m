Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1880BC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE9420726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzWzpH7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE9420726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j01lr-0001Hi-4P
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j01lA-0000j4-Rh
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j01l9-0008K0-T6
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:25:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43274
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j01l9-0008JH-PN
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581074719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bgKHnlRpojuC2/I20bt1mTeRaEBo4Zu3/FkZhKlA1ms=;
 b=BzWzpH7zpSisZUJClE1lc1FjfaJMlW1caqa1BONquY/Q17I7yAI/1LH4q4U7y7Cu6ThrYF
 Fl7eit2MkEQixJBmY1d6nzYEv6IdK/0PbkqFIdy/2jOczSTNQ3FUzEcP4b7uypDySKdhVp
 mh7/TYi/zvr0aFe54kidGjvRKX50sDI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-cx9a52SUP4WbboPoTd28Bg-1; Fri, 07 Feb 2020 06:25:16 -0500
Received: by mail-wr1-f71.google.com with SMTP id o6so1103451wrp.8
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kdkny600VcCOTeOaqonAkoG+I23E1H+EAJ4drPnGlnY=;
 b=Hqq5TkTnvziK3KYV5PFAlY5IRd5TTYzD8j+tN8sRrYuAZbCYn3p9J+ZUaAtYfmTZtK
 /HL5goXqNjgb8glYBvEnBUN7PIfGveQvjbHtDInWQE/fsYd8Mlk0kYJQRoATL4LHc2qW
 eCQEp+WukcvjheTtqAL+gaB7YQlJq+Kh8MqB+GJG3mgILP08ljVWkIYFgnuGHcnU00m0
 tNi8Q3PjKuRbeJyR2a5XwIANHzDt1FlEUTNsjyIFxSEI3hjMHZ408R5ejD1Qtqv7V48Z
 c+WWinlFB1fdlbxlM32KB78m64o+q1VIbo5QZ+Spq8qi2wTlclgXEdRJmkbNwz+U4RU1
 B40w==
X-Gm-Message-State: APjAAAVteDDGw62Ph4gjuTXtaYgW9Sz5o7yLqLKg79rOg/Y5qmKuFvDW
 a8Wo09rLxe25SuMIa3TrHCDwm+kVtsWoAieIrSYyoEpKGFoT1UVY3VswwmeaI8c8uDjKp6SRbQD
 0VPeon7ZI2XW/aDQ=
X-Received: by 2002:a7b:c450:: with SMTP id l16mr3770067wmi.166.1581074715131; 
 Fri, 07 Feb 2020 03:25:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwdxeVnhvBXgJuUnR5sCFJfSS3a+JBqnJ6c2o12TmPRh6oftKxF/olVR3RQD30dGmjuMmT+Fg==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr3770042wmi.166.1581074714872; 
 Fri, 07 Feb 2020 03:25:14 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id g15sm3103135wro.65.2020.02.07.03.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 03:25:14 -0800 (PST)
Subject: Re: [PATCH] vl: Abort if multiple machines are registered as default
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200207110259.12544-1-philmd@redhat.com>
 <24bddc77-801e-ae63-dd1d-e06e3ac1cc03@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <078fbde9-3c93-b00a-2d53-34e65c7f56d9@redhat.com>
Date: Fri, 7 Feb 2020 12:25:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <24bddc77-801e-ae63-dd1d-e06e3ac1cc03@vivier.eu>
Content-Language: en-US
X-MC-Unique: cx9a52SUP4WbboPoTd28Bg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 12:08 PM, Laurent Vivier wrote:
> Le 07/02/2020 =C3=A0 12:02, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>> It would be confusing to have multiple default machines.
>> Abort if this ever occurs.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   vl.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/vl.c b/vl.c
>> index 7dcb0879c4..da828188eb 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -2354,6 +2354,8 @@ static MachineClass *machine_parse(const char *nam=
e, GSList *machines)
>>       GSList *el;
>>  =20
>>       if (is_help_option(name)) {
>> +        int default_count =3D 0;
>> +
>>           printf("Supported machines are:\n");
>>           machines =3D g_slist_sort(machines, machine_class_cmp);
>>           for (el =3D machines; el; el =3D el->next) {
>> @@ -2364,6 +2366,11 @@ static MachineClass *machine_parse(const char *na=
me, GSList *machines)
>>               printf("%-20s %s%s%s\n", mc->name, mc->desc,
>>                      mc->is_default ? " (default)" : "",
>>                      mc->deprecation_reason ? " (deprecated)" : "");
>> +            default_count +=3D !!mc->is_default;
>> +        }
>> +        if (default_count > 1) {
>> +            error_printf("Multiple default machines available\n");
>> +            abort();
>>           }
>>           exit(0);
>>       }
>>
>=20
> Does it really deserve an abort?
> Ideal solution would be to be able to check this at build or in the unit
> tests.

This is for developers, not for users. I'll use Marc-Andr=C3=A9 suggestion=
=20
and use an assertion.


