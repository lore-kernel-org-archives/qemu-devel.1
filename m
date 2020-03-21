Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF4AC4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B3120658
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeNrGnGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B3120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFew8-0006pl-3Z
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 10:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFevI-0005nv-Bi
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFevH-0001rr-8l
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:16:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23007)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFevH-0001rL-5N
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584800182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=njLK0rH8vHGOJ+Mc5dURjJtNNPmhW6cJ2g/UU+Cj9/A=;
 b=UeNrGnGO8T+2SbUAp2vO11Ucb+N4pPwnedENT4fWnIY/WCY1m3FSZKFoRtYRx3ehSapll+
 xrRAfMXYjQBfoYzh68AmIy/TApA3OkMiO7CQu9voe7HkheFpC5VCWh7RZ1Ofe86ElrFyfC
 fLTw13JJuLuRdk3YzOvtbRaxlW55Su8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-SUHsD54yMMOAiPXbcF6BnQ-1; Sat, 21 Mar 2020 10:16:19 -0400
X-MC-Unique: SUHsD54yMMOAiPXbcF6BnQ-1
Received: by mail-ed1-f71.google.com with SMTP id b12so4645675edy.7
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 07:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B2w5aB3KtXWGYrfsxcpbGSy7pJ3V05lyzlzVysm9X/g=;
 b=OtPny9nUtHneXMgwDdq6aP+yrvfK7g/6B4endzYuzl8Q+0rIdnhUdr4aRIL9yDf5vL
 Qs7oeWcnZDAGkT+UgiUmXgdf4RPIPIlUQQTFreAnOLf69avMKvWHSGLFZrbU00tMgDd0
 JEGr6SBAeXZmX6K8ujikOolg6XVAgEqX+NrM0bFaFZcLccp7VCS5PyYzMy3fj5zs7Vpz
 JB1dR3ONTiO6gL36bv15RAgFJriYOWaz2P0mGfh46hH1P3h2hV39stNlSkcPVpFHUB2J
 PGD0Uxp0u7ivdYF18cXtDWQIQBYn5aMxuvZRNcb9J8G58Y01DcgvAkOF9Ix7/sg3ic1f
 alKg==
X-Gm-Message-State: ANhLgQ1+hqH8wjxD7PqeKw5xosM2EOOcYpRM6TZIwzQsI1Lt2Id8xV2Y
 G2pV67aDz7P79+0/3OAQ4I4CUUUlEDKRP2zAfniqLIOWg/x1317qjrvZFoFom3WqQy3t+h3weAD
 tmq4HZY/3mMcIxJM=
X-Received: by 2002:a17:906:3410:: with SMTP id
 c16mr6339273ejb.304.1584800177722; 
 Sat, 21 Mar 2020 07:16:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs7wM6NYFhNp5nbMUbePHaYyce1N+nccLLUOaxTv3YzytYk+/XBYJxJA5MufqLFdRratLttxw==
X-Received: by 2002:a17:906:3410:: with SMTP id
 c16mr6339251ejb.304.1584800177404; 
 Sat, 21 Mar 2020 07:16:17 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id l19sm575026ejn.31.2020.03.21.07.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2020 07:16:16 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 05/11] hw/ide/sii3112: Remove dead assignment
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200321114615.5360-1-philmd@redhat.com>
 <20200321114615.5360-6-philmd@redhat.com>
 <CAL1e-=hQPwJ3XKrt4ip2S92ScjyjS63-A4REDeXzyiCt1Phx6A@mail.gmail.com>
 <alpine.BSF.2.22.395.2003211511170.82121@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <11fc4c44-fb8c-9698-e59f-5592b7d8efea@redhat.com>
Date: Sat, 21 Mar 2020 15:16:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003211511170.82121@zero.eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>,
 Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goate?= =?UTF-8?Q?r?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/21/20 3:12 PM, BALATON Zoltan wrote:
> On Sat, 21 Mar 2020, Aleksandar Markovic wrote:
>> On Saturday, March 21, 2020, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
>> wrote:
>>
>>> Fix warning reported by Clang static code analyzer:
>>>
>>> =C2=A0=C2=A0=C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/ide/sii3112.o
>>> =C2=A0 hw/ide/sii3112.c:204:9: warning: Value stored to 'val' is never =
read
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^=C2=A0=C2=A0=C2=
=A0=C2=A0 ~
>>>
>>> Reported-by: Clang Static Analyzer
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>> =C2=A0hw/ide/sii3112.c | 2 +-
>>> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
>>> index 06605d7af2..36f1905ddb 100644
>>> --- a/hw/ide/sii3112.c
>>> +++ b/hw/ide/sii3112.c
>>> @@ -125,7 +125,7 @@ static uint64_t sii3112_reg_read(void *opaque,=20
>>> hwaddr
>>> addr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D (uint32_t)d->r=
egs[1].sien << 16;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 default:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>
>>
>> There is another function in the same file, having a similar switch
>> statement. There is no warning for that second tunction, since "val"=20
>> is its
>> parameter, not a local varioble, like is the case here. This means=20
>> that the
>> proposed change introduces inconsistency between two functions, therefor=
e
>> it is better to remove the initialization of "val" to 0, than to remove
>> this line in "default" section.
>=20
> Oh, actually I think the warning was for that statement not for the one=
=20
> patched as it makes more sense there where val is assigned in void=20
> sii3112_reg_write() where it's indeed not used so maybe that was meant=20
> to be patched instead?

Ah, the warning is for hw/ide/sii3112.c:204 but I incorrectly patched=20
hw/ide/sii3112.c:128 =3D)

>=20
> Regards,
> BALATON Zoltan


