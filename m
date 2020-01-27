Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0346FC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 07:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE82A21569
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 07:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnTPSxLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE82A21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivz9m-0006jW-W2
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 02:50:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ivz9E-0006Eg-Jz
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:49:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ivz9D-0007En-MJ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:49:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32992
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ivz9D-0007E7-IU
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580111367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2isgC+Th+Y5lBOuihoALDvgG82ggvzF9Eoh0UOce5iU=;
 b=ZnTPSxLGRsYDQHdVx15NqWyehRzNVeGVjr1KySs3A9tmLyZ0EmOxDnsGZTJGvPVh0iBRat
 7lH54grIWin2UXOxMP409m8andJxSaJrgUBOqQ2XRefuzw0A+fKxTBpBLkmQFIWQNJ6WTN
 DZisG/v9s/gkmQ13woVx0tZJtGTUPAM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-WGoGvLqJOle0fl-wW7CnEQ-1; Mon, 27 Jan 2020 02:49:23 -0500
Received: by mail-wr1-f71.google.com with SMTP id y7so5712114wrm.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2020 23:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+KkpnSe7NgDwqjJ8ktjeHvyMM+wNpqJbSmqs6R84lkY=;
 b=MWGbhgCyeL+KJpNZXG6fn2GKeXZ4Q02576mjes3HUwAv6DSvI63LC7TDPeWAnS3n50
 2rq0ffQhMYC5BzUCqYNF8YyebgP+x2i+565N1mqGf3f05mdkA2/Isbc8yKE+7RsKlHSw
 HCBCkPv4qYu6SE70ngvhr4TW/i5yMk6b+bVX89++EPH3oYggowiR4KrU65r+ugRLhHX1
 NTMma09RtbSubA9hN8qudrCrqxzTgIjIuO78jS83eilLW9dBwIMB8YU2tXkBiO9fuTUu
 KxAWiscLZgYsyJ664GFtbPaGgMFIE8uL4Mnv/goAbDkxVqaliBFL9Dgo1S96QWeAmorF
 hxTQ==
X-Gm-Message-State: APjAAAUUIx7igqgp5Wx9cNAhgQ4Zg31rMooqnEkuoVti34ufZNajauPp
 1MXYb33F60MlIDbNx/bRe6izLcOEDTQZ0Z6AzBNXqGTtEh5COzxeQdOab4LC/ncnoerAFC+1D0L
 7eqL1Ygj2KUh9qYg=
X-Received: by 2002:adf:ec83:: with SMTP id z3mr18981198wrn.133.1580111361168; 
 Sun, 26 Jan 2020 23:49:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqwKxnQfFAj0EKVTH0pMG+djquyU5Ddauf1IPtVqNunVDwCdtJV/GFzN6NWT446EzqWDeip0og==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr18981171wrn.133.1580111360839; 
 Sun, 26 Jan 2020 23:49:20 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id q19sm17262137wmc.12.2020.01.26.23.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2020 23:49:20 -0800 (PST)
Subject: Re: [PATCH] target/arm/arm-semi: Don't let the guest close
 stdin/stdout/stderr
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200124172954.28481-1-peter.maydell@linaro.org>
 <87zhec8w67.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <44ee8563-ced3-9416-4e79-1dccba02d27b@redhat.com>
Date: Mon, 27 Jan 2020 08:49:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87zhec8w67.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: WGoGvLqJOle0fl-wW7CnEQ-1
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 8:57 PM, Alex Benn=C3=A9e wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
>> The guest can use the semihosting API to open a handle
>> corresponding to QEMU's own stdin, stdout, or stderr.
>> When the guest closes this handle, we should not
>> close the underlying host stdin/stdout/stderr
>> the way we would do if the handle corresponded to
>> a host fd we'd opened on behalf of the guest in SYS_OPEN.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>> ---
>>   target/arm/arm-semi.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
>> index 788fe61b51a..8718fd01948 100644
>> --- a/target/arm/arm-semi.c
>> +++ b/target/arm/arm-semi.c
>> @@ -403,6 +403,15 @@ static uint32_t host_closefn(ARMCPU *cpu, GuestFD *=
gf)
>>   {
>>       CPUARMState *env =3D &cpu->env;
>>  =20
>> +    /*
>> +     * Only close the underlying host fd if it's one we opened on behal=
f
>> +     * of the guest in SYS_OPEN.
>> +     */
>> +    if (gf->hostfd =3D=3D STDIN_FILENO ||
>> +        gf->hostfd =3D=3D STDOUT_FILENO ||
>> +        gf->hostfd =3D=3D STDERR_FILENO) {
>> +        return 0;
>> +    }
>>       return set_swi_errno(env, close(gf->hostfd));
>>   }


