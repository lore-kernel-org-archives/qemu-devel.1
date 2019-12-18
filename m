Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69293C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 324D2218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhGUv56F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324D2218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihWUy-00073u-Cm
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 05:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihWU8-00067l-Df
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihWU7-0008Mi-4F
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:23:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37030
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihWU7-0008KW-02
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576664594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fpdCi1Vs5Sx99MRuyxpOGtmz6PhoFr8L0o1+pOaA+HM=;
 b=AhGUv56FJ8m5RWE8heqHzp7TJvIHXtS5GzVJgUNSDfYq2ESVNRvA8USLTnNlvNRQ17Z56m
 MGtlN42Ivo56oiUraUJPB9qceq1wUGobZC2XrgO78YgmyGrzWA4Evr9+mPZo0hBQtFomCf
 6GmeG8JkS/AD39gp9srskheYLdUSreQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-zRfh-zYIMemumyzsG5Z6eA-1; Wed, 18 Dec 2019 05:23:07 -0500
Received: by mail-wr1-f70.google.com with SMTP id y7so694405wrm.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 02:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PkL8wZtfB33r50sUpWg026bN3R6UzcewUQVBMO7Orzg=;
 b=jYdvmQkYJR+PGu90iI2u4erlWw6CqFYlKpgR6lE5RdjHJovDGmcq/ewyNWE94KAo0l
 HzghC8CeikZa5aUo4Vo1OzWU3ojB94rWkuQH6NEDdrEDmIz3XZZRt2Bnn0wDjWyisFeN
 JIt53NHLJAYVhDfB7e33uRKb98XuTSTe18l2yk3MrCPTa/NEgDOK/LcSt/kAvw4MBo6V
 X2TdRlOt077yjM8G1i5kd/p4zPpqAvHyTzy/+/w8wUcW0nXxHgRDIjzfvi11w7Jasiwu
 dm7+NYwsVceMaEOqbyTfFmVuFT80gXjYaQJDrbzyKzx1Tfh2be6AM3m90N1umQk24znH
 KOoQ==
X-Gm-Message-State: APjAAAW6aUZZ98ZdnKiJNEgkGAYAZophLaOzQgvGoUrYZZg3knK7WMjj
 NvWmE9sjbZSsAx9mYOigVUUv5Hybc1zWdlV+aYIVrCA8NrwGfXsmjVzNoXZcLTNk53u+WEDnCAk
 7fnmnV7gU13Jd3JM=
X-Received: by 2002:adf:f7c4:: with SMTP id a4mr1862375wrq.332.1576664585826; 
 Wed, 18 Dec 2019 02:23:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSTSWOSUaG4kA8hkaj3lJwpt1r0BiKPaf0Bg1q64BBFRNodVTgQ3RWOstxB963DB6VF/2TmA==
X-Received: by 2002:adf:f7c4:: with SMTP id a4mr1862335wrq.332.1576664585415; 
 Wed, 18 Dec 2019 02:23:05 -0800 (PST)
Received: from [192.168.23.166] (40.red-88-21-19.staticip.rima-tde.net.
 [88.21.19.40])
 by smtp.gmail.com with ESMTPSA id w22sm1875036wmk.34.2019.12.18.02.23.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 02:23:04 -0800 (PST)
Subject: Re: [PATCH 2/6] hw/display/tcx: Add missing fall through comments
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191217173425.5082-1-philmd@redhat.com>
 <20191217173425.5082-3-philmd@redhat.com>
 <CAL1e-=gPi2C41Lc7cOQnTP+gL3aW=yWpQvamzTSfdDCJOK5BEA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d1234e8e-4ab8-eded-c0c3-8b9c0946fdf5@redhat.com>
Date: Wed, 18 Dec 2019 11:23:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gPi2C41Lc7cOQnTP+gL3aW=yWpQvamzTSfdDCJOK5BEA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: zRfh-zYIMemumyzsG5Z6eA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Olivier Danet <odanet@caramail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 8:54 AM, Aleksandar Markovic wrote:
>=20
>=20
> On Tuesday, December 17, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     GCC9 is confused by this comment when building with
>     CFLAG -Wimplicit-fallthrough=3D2:
>=20
>      =C2=A0 hw/display/tcx.c: In function =E2=80=98tcx_dac_writel=E2=80=
=99:
>      =C2=A0 hw/display/tcx.c:453:26: error: this statement may fall throu=
gh
>     [-Werror=3Dimplicit-fallthrough=3D]
>      =C2=A0 =C2=A0 453 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
->dac_index =3D (s->dac_index + 1) & 0xff; /*
>     Index autoincrement */
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>      =C2=A0 hw/display/tcx.c:454:9: note: here
>      =C2=A0 =C2=A0 454 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~=
~~
>      =C2=A0 hw/display/tcx.c: In function =E2=80=98tcx_dac_readl=E2=80=99=
:
>      =C2=A0 hw/display/tcx.c:412:22: error: this statement may fall throu=
gh
>     [-Werror=3Dimplicit-fallthrough=3D]
>      =C2=A0 =C2=A0 412 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->dac_index =
=3D (s->dac_index + 1) & 0xff; /*
>     Index autoincrement */
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~=
~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>      =C2=A0 hw/display/tcx.c:413:5: note: here
>      =C2=A0 =C2=A0 413 |=C2=A0 =C2=A0 =C2=A0default:
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0^~~~~~~
>      =C2=A0 cc1: all warnings being treated as errors
>=20
>     Add the missing fall through comments.
>=20
>     Fixes: 55d7bfe22
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>     Cc: Olivier Danet <odanet@caramail.com <mailto:odanet@caramail.com>>
>     Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk
>     <mailto:mark.cave-ayland@ilande.co.uk>>
>     ---
>      =C2=A0hw/display/tcx.c | 2 ++
>      =C2=A01 file changed, 2 insertions(+)
>=20
>=20
> The content of the patch is fine, but the commit message is, I think,=20
> inacurate: gcc is not confused at all, it does what it was told to.

You are correct, I'll update the comment.

> The title is fine.
>=20
>     diff --git a/hw/display/tcx.c b/hw/display/tcx.c
>     index 14e829d3fa..abbeb30284 100644
>     --- a/hw/display/tcx.c
>     +++ b/hw/display/tcx.c
>     @@ -410,6 +410,7 @@ static uint64_t tcx_dac_readl(void *opaque,
>     hwaddr addr,
>      =C2=A0 =C2=A0 =C2=A0case 2:
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D s->b[s->dac_index] << 24;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->dac_index =3D (s->dac_index + 1=
) & 0xff; /* Index
>     autoincrement */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through */
>      =C2=A0 =C2=A0 =C2=A0default:
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->dac_state =3D 0;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>     @@ -451,6 +452,7 @@ static void tcx_dac_writel(void *opaque, hwaddr
>     addr, uint64_t val,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->b[index] =3D val =
>> 24;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0update_palette_entri=
es(s, index, index + 1);
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->dac_index =3D (s-=
>dac_index + 1) & 0xff; /* Index
>     autoincrement */
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fall through */
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s->dac_state =3D 0;
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>     --=20
>     2.21.0
>=20
>=20


