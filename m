Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBBDC4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6091F20658
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJczxeTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6091F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFeuM-0004QB-HB
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 10:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFetM-00038B-FY
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFetL-0008PM-BP
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:14:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:23632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFetL-0008Oy-8G
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584800063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I4YPJfNJi4WWcG7pY6jdJqKE/BIVLG+Ljgkk1E7R0Ec=;
 b=WJczxeTjmGZhH58fONYCYPi12g5watD3HA8PQCmhjia/86wy0p6l4uKDRhxk2IwciluD/o
 lHMiq1q/UkHAvrZzje+8HgWXyw2vlNZJIbcbLP6jd7ZWXFxF3WOI0pnsNfDDAyQ+C0vcf+
 hdjtMFBBh/x2jG+t+VUOgINRx+M/Bng=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-YfYDhztZPRuIAS3pSNGCdw-1; Sat, 21 Mar 2020 10:14:19 -0400
X-MC-Unique: YfYDhztZPRuIAS3pSNGCdw-1
Received: by mail-ed1-f70.google.com with SMTP id y14so7478161edq.22
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 07:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qt1rHCnwTVKvmp4ECYAy2Qr+S1/Jr4/xJXDIyI0NVHs=;
 b=taTwQQbc/j+rpSI0F2q/M5jb75A4xOQsxCY6bzRjcypwOkvj0u4ua6ftA16acKL42Y
 nccrf+iRoyq9B+B142v8ygBGLOT3GEkHNTuo+ea6dXJexYWokP7/uDX1ZOY1SjU0+lAp
 bp/WSL1GrVHycc5ao+XZxRMcdBRUukZabQ2sXXgfqjevH16MC6y2PgktmTYtjDoLx5Fw
 8KPsDGd8+0RmeaCzMqSTiEtS9S9rZOYo9M63wlSmldduNQ7DwlGyhYxvGK0ihkz9hD0c
 QAX9aC/rsCRrarUlJW6uvLKQDNtT0t8qMxEeiPr/3CRZ7FVFBDzDaEDVPuYSn/tmMXox
 bmNQ==
X-Gm-Message-State: ANhLgQ31sFg0QlBSQzK6qxS/hc068hQnyOcHiBZ7q6OHW2MXX+4fJ27n
 KoQUy21Dd8qzPw+M3m9UjuQ+rgYx8w7plpjEFZiDXOQdMQhVGa8bjr23D21J8gzE7R3UIW0ymeE
 E+kGPR6UFUrUnvBE=
X-Received: by 2002:a17:907:2154:: with SMTP id
 rk20mr2095864ejb.298.1584800058080; 
 Sat, 21 Mar 2020 07:14:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv/Y2nCgu7P2p3jdGiuanAi4R5EOhRMe94mLPQttnahOfgMryMxlRLU5XoHsDht2tMQ2SwBWg==
X-Received: by 2002:a17:907:2154:: with SMTP id
 rk20mr2095843ejb.298.1584800057627; 
 Sat, 21 Mar 2020 07:14:17 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id z22sm599472edl.6.2020.03.21.07.14.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2020 07:14:17 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 05/11] hw/ide/sii3112: Remove dead assignment
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200321114615.5360-1-philmd@redhat.com>
 <20200321114615.5360-6-philmd@redhat.com>
 <CAL1e-=hQPwJ3XKrt4ip2S92ScjyjS63-A4REDeXzyiCt1Phx6A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <02375897-b520-fefb-a141-c013d29bde28@redhat.com>
Date: Sat, 21 Mar 2020 15:14:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hQPwJ3XKrt4ip2S92ScjyjS63-A4REDeXzyiCt1Phx6A@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On 3/21/20 2:39 PM, Aleksandar Markovic wrote:
>=20
>=20
> On Saturday, March 21, 2020, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     Fix warning reported by Clang static code analyzer:
>=20
>      =C2=A0 =C2=A0 CC=C2=A0 =C2=A0 =C2=A0 hw/ide/sii3112.o
>      =C2=A0 hw/ide/sii3112.c:204:9: warning: Value stored to 'val' is nev=
er read
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D 0;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^=C2=A0 =C2=A0 =C2=A0~
>=20
>     Reported-by: Clang Static Analyzer
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      =C2=A0hw/ide/sii3112.c | 2 +-
>      =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
>     diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
>     index 06605d7af2..36f1905ddb 100644
>     --- a/hw/ide/sii3112.c
>     +++ b/hw/ide/sii3112.c
>     @@ -125,7 +125,7 @@ static uint64_t sii3112_reg_read(void *opaque,
>     hwaddr addr,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D (uint32_t)d->regs[1].sien =
<< 16;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>      =C2=A0 =C2=A0 =C2=A0default:
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D 0;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>=20
>=20
> There is another function in the same file, having a similar switch=20
> statement. There is no warning for that second tunction, since "val" is=
=20
> its parameter, not a local varioble, like is the case here. This means=20
> that the proposed change introduces inconsistency between two functions,=
=20
> therefore it is better to remove the initialization of "val" to 0, than=
=20
> to remove this line in "default" section.

No clue why there is no warnings emitted for sii3112_reg_write()...

Do you mind sending a patch?

>=20
> Regards,
> Aleksandar
>=20
>      =C2=A0 =C2=A0 =C2=A0}
>      =C2=A0 =C2=A0 =C2=A0trace_sii3112_read(size, addr, val);
>      =C2=A0 =C2=A0 =C2=A0return val;
>     --=20
>     2.21.1
>=20
>=20


