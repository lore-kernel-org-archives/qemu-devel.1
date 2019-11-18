Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85319C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 12:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCD020730
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 12:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0BbQJ6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCD020730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWgB4-0005q5-HT
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 07:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iWgAD-0005JP-Dj
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:29:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iWgA8-0002SD-2w
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:29:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42226
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iWgA7-0002Rx-Vg
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 07:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574080187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ealHoRndLgBhWoQitQnT4iHsYgtbq3VAFyg6PVgU5V8=;
 b=e0BbQJ6msTRxa04YxhHPsbifT7jR9xucCaolTIXU6lXfwFZVTEfL3nqx6/YPumJYyDomlg
 Xn0BmWdtIHBtK0cptXRSqStJiT/cr8fK9rYYaHVB/u26h9KGUEn1h2YcddYZeqids53VnE
 kIQhisqxbBQQ1wMAVhpxriQp6kWVuGE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-jjxhqQR-O0OuoXSMQCoMQg-1; Mon, 18 Nov 2019 07:29:46 -0500
Received: by mail-wm1-f72.google.com with SMTP id t203so11249784wmt.7
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 04:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=weovNXt0zhuZRbY6hI7D/m+1QR3GpgvSs2A0uBgcVDg=;
 b=qhkHfHeHoaHN8+TmnrS7hvDoITBkrI11hadTOu8740OB8RrvypwEx4TdvIgPYZNcsV
 u908q96hIf60bp2lv0yCMX+bLlg+vsXdfYNk8zpqWt/AOn2pz3MMmEfSjHDk0KtSBTzK
 CE8pmO4LGR+SWm+qVU2cjjvwohyoGjsW9YoIEu8+YE5cjzBeb5KkUg4fo7SpHxspSef2
 9rbneuKy70XuXyg/NEFuXa+5WNFEnBmV6t5bJSUldKNDATBJ2OAC8HY/i5HYcS5VQRhF
 ZVXmINEFlh14e6eam4xfXOlPMCz09YdiyUg8vVFk2FpFvDxNY3wXnpLuC5OxPhdQZLmt
 qznw==
X-Gm-Message-State: APjAAAWTDuq1OGfLOSQtKRU0RoAeaex8OH6gNw15cGVFjg+cEUgUPtVD
 GkNlFXz88uMSc3BI6qzESKEK/lE63XU0JCH4kMMKqCa8vmNnPWrgExdSun9ftAUjWo6d7ir6i8x
 7/x7Xwc9so/qYAE0=
X-Received: by 2002:a5d:414a:: with SMTP id c10mr23037350wrq.100.1574080184958; 
 Mon, 18 Nov 2019 04:29:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqzF0fuos6gqx8rm9phJsRRkO0H2Q8V70PVvPa4zt1JkWRauQJvlKcJg4A7n9nzoBNUaZymprw==
X-Received: by 2002:a5d:414a:: with SMTP id c10mr23037285wrq.100.1574080184776; 
 Mon, 18 Nov 2019 04:29:44 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id z6sm8657628wrq.76.2019.11.18.04.29.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2019 04:29:44 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Add a TILE-Gx section
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191012071210.13632-1-philmd@redhat.com>
 <CAL1e-=h2d8vBs3bKpsReFNgCW-f4FMTYvJuSahjyNgeF7x5cfw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <71b94fba-c0b0-f745-1c11-f08041a865ec@redhat.com>
Date: Mon, 18 Nov 2019 13:29:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=h2d8vBs3bKpsReFNgCW-f4FMTYvJuSahjyNgeF7x5cfw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: jjxhqQR-O0OuoXSMQCoMQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Richard Henderson <rth@twiddle.net>, Chen Gang <gang.chen.5i5j@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/19 2:40 PM, Aleksandar Markovic wrote:
>=20
> 12.10.2019. 09.12, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com=20
> <mailto:philmd@redhat.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>  >
>  > The TILE-Gx architecture was missing its section, add it.
>  >
>  > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=20
> <mailto:philmd@redhat.com>>
>  > ---
>  > =C2=A0MAINTAINERS | 5 +++++
>  > =C2=A01 file changed, 5 insertions(+)
>  >
>=20
> It is certainly good that there is a maintainer for each QEMU component.=
=20
> But:
>=20
> - is Chen Gang available and willing to assume the role?

One month passed, so we can assume this architecture is orphan.
I'll prepare a patch.

> - sadly, tilegx arch support was recently removed from kernel upstream.=
=20
> That does not mean (in my understanding) automatic removal from QEMU,=20
> but certainly raises some eyebrows. Should we continue supporting=20
> tilegx? Isthete any feedback from users, or the company that owns tilegx?

We should properly deprecate it, to give any users a chance to notice it=20
and tell us. I'll prepare another patch.

> Sincerely,
> Aleksandar
>=20
>  > diff --git a/MAINTAINERS b/MAINTAINERS
>  > index 3ca814850e..a3be0a4a31 100644
>  > --- a/MAINTAINERS
>  > +++ b/MAINTAINERS
>  > @@ -299,6 +299,11 @@ F: hw/sparc64/
>  > =C2=A0F: include/hw/sparc/sparc64.h
>  > =C2=A0F: disas/sparc.c
>  >
>  > +TILE-Gx CPUs
>  > +M: Chen Gang <gang.chen.5i5j@gmail.com=20
> <mailto:gang.chen.5i5j@gmail.com>>
>  > +S: Maintained
>  > +F: target/tilegx/
>  > +
>  > =C2=A0UniCore32 TCG CPUs
>  > =C2=A0M: Guan Xuetao <gxt@mprc.pku.edu.cn <mailto:gxt@mprc.pku.edu.cn>=
>
>  > =C2=A0S: Maintained
>  > --
>  > 2.21.0
>  >
>  >
>=20


