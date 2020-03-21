Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0C4C4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D39C2072C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkRi+Ldo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D39C2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFf5s-0003W4-QP
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 10:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFf53-0002Xj-E3
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFf52-00084X-50
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:26:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42652)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFf51-00083s-VA
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584800787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Z4ixueJjJ4ubeAjWuW5nAjaqvlbdw9Nl7/+fHva+CU=;
 b=RkRi+LdoW0teX4WOpkhzqGk6sT+x2Ub9wCDdo6K06kApI+wv/4E6VrcXP+CBiwOPTIDCAc
 xT36QdTJ/7EBFrkqhou+icLQkIi3zh1TRhR8i/1WYBwF19Sjz/cPahFXZAX9EX08yd5bV/
 qFnzDXSv7KKIDdVnma1bvP+ztNF0ZsI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-J64oPEH0PTCxjiWdGyZKQQ-1; Sat, 21 Mar 2020 10:26:25 -0400
X-MC-Unique: J64oPEH0PTCxjiWdGyZKQQ-1
Received: by mail-ed1-f69.google.com with SMTP id ce13so7572196edb.11
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 07:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8fXzrylgCR5TsnuGN9CDtaZ0d54miYJjDG0GGxm3NPM=;
 b=l9puv85jNPp7etKSlqdV8ct7ul59HUYJ+EtUMht3hne1cqCoiDdl9oikdC9/ncKLnk
 N5w7kdFNYyNv7Oqk0gXSGBYoZzUOkieMjxIiJA392VKFZTlCWgkLc1wnn1z8LiaQfVKd
 Is9bYAXzrh4+O/49TcA5fZSsxvdfkzNNwwXjZnNFfr4sm7DK0zBfjtzUDdXVbZYupDiN
 bMbeGk+Uf8gyNJET0cyAtmVzIbQHaLgHnR+ZOGPT5mWmKtWI3Xo20JB6S+af36SoBN6x
 T4XOvhPNh/KTja6gBNKZ9yeiBOcm1rKG6QczXzuFzoyMN/f32cHQlglNuYtoc5RrDwro
 RNNQ==
X-Gm-Message-State: ANhLgQ14rDh5ZVdHytzFRtJDL1OQUSKMc3WCwHnRfz6QcdhpULi73nmq
 EeQpwOMYvsu5Pamcg3pY7DuDsV+lp+DNNWX+7UNtAO+3TpnZoYXPoAsry3LJMH/lAataNktnQF6
 TtJNxFIFkhkT1n/E=
X-Received: by 2002:a05:6402:14da:: with SMTP id
 f26mr7073504edx.96.1584800784463; 
 Sat, 21 Mar 2020 07:26:24 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvOjHNr3YDvQ1Nz9kZ8HTQvl+KMrHaw9aJwXFXslPTJtiGj+E5C1hcJrPqz8a8sAbtOS5MLcg==
X-Received: by 2002:a05:6402:14da:: with SMTP id
 f26mr7073462edx.96.1584800784104; 
 Sat, 21 Mar 2020 07:26:24 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id e16sm563771ejx.53.2020.03.21.07.26.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2020 07:26:23 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 05/11] hw/ide/sii3112: Remove dead assignment
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200321114615.5360-1-philmd@redhat.com>
 <20200321114615.5360-6-philmd@redhat.com>
 <CAL1e-=hQPwJ3XKrt4ip2S92ScjyjS63-A4REDeXzyiCt1Phx6A@mail.gmail.com>
 <02375897-b520-fefb-a141-c013d29bde28@redhat.com>
Message-ID: <7117b1dd-074b-04bf-61f5-da215faa0b7b@redhat.com>
Date: Sat, 21 Mar 2020 15:26:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <02375897-b520-fefb-a141-c013d29bde28@redhat.com>
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goate?= =?UTF-8?Q?r?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/21/20 3:14 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/21/20 2:39 PM, Aleksandar Markovic wrote:
>>
>>
>> On Saturday, March 21, 2020, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com=20
>> <mailto:philmd@redhat.com>> wrote:
>>
>> =C2=A0=C2=A0=C2=A0 Fix warning reported by Clang static code analyzer:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 CC=C2=A0 =C2=A0 =C2=A0 hw/ide/sii=
3112.o
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 hw/ide/sii3112.c:204:9: warning: Value s=
tored to 'val' is never=20
>> read
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^=C2=A0 =C2=
=A0 =C2=A0~
>>
>> =C2=A0=C2=A0=C2=A0 Reported-by: Clang Static Analyzer
>> =C2=A0=C2=A0=C2=A0 Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@re=
dhat.com
>> =C2=A0=C2=A0=C2=A0 <mailto:philmd@redhat.com>>
>> =C2=A0=C2=A0=C2=A0 ---
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0hw/ide/sii3112.c | 2 +-
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletio=
n(-)
>>
>> =C2=A0=C2=A0=C2=A0 diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
>> =C2=A0=C2=A0=C2=A0 index 06605d7af2..36f1905ddb 100644
>> =C2=A0=C2=A0=C2=A0 --- a/hw/ide/sii3112.c
>> =C2=A0=C2=A0=C2=A0 +++ b/hw/ide/sii3112.c
>> =C2=A0=C2=A0=C2=A0 @@ -125,7 +125,7 @@ static uint64_t sii3112_reg_read(=
void *opaque,
>> =C2=A0=C2=A0=C2=A0 hwaddr addr,
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D (uint=
32_t)d->regs[1].sien << 16;
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0default:
>> =C2=A0=C2=A0=C2=A0 -=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D 0;
>> =C2=A0=C2=A0=C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>
>>
>> There is another function in the same file, having a similar switch=20
>> statement. There is no warning for that second tunction, since "val"=20
>> is its parameter, not a local varioble, like is the case here. This=20
>> means that the proposed change introduces inconsistency between two=20
>> functions, therefore it is better to remove the initialization of=20
>> "val" to 0, than to remove this line in "default" section.
>=20
> No clue why there is no warnings emitted for sii3112_reg_write()...
>=20
> Do you mind sending a patch?

Don't worry I'll follow up.

>=20
>>
>> Regards,
>> Aleksandar
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_sii3112_read(size, ad=
dr, val);
>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0return val;
>> =C2=A0=C2=A0=C2=A0 -- =C2=A0=C2=A0=C2=A0 2.21.1
>>
>>


