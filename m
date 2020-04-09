Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59015C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 02:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B052087E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 02:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="Qc0pFEMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B052087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMN7j-0006Kf-5W
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 22:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jMN78-0005mx-KY
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 22:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jMN77-0003XE-4B
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 22:40:22 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jMN76-0003Sk-DB
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 22:40:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586399927; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=kyCUbVt7DDHIp9oZ02HRhCgIwIdEQJdXW5cQQ4Kzy2vgBwGFm1VjAvtdNTZD1f9mzBT/JkWqhcru6Gq6FhKcu9QRFkd32dOtKP8MIGRTN9QcW7XxJir4XsTwv61VCVjW5+nlO5xnYcaMVmnhhuX17cC6KZabm4Gd5X7S2FnB9rI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1586399927;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=L8RyLyIO5cA+WJS12LcCV4FTG3FjLOTzF3Niw96yqW4=; 
 b=l/BmSWAXYXcf65skADV/3IiGap1ivh4+nvfbFcy/lfwjo39RH+ZZoIk20Q5ea5fC+zPpnSbhcd3SUHBw/3Q655hO/WoNo1UU1wJoMg5MaZItVtgfKtiP8NFnKSi3vpcxYwWfyZeJ+ZyWR2e1MPqevlaZSpxonFvMfSqKn/ZRfwA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=flygoat.com;
 spf=pass  smtp.mailfrom=jiaxun.yang@flygoat.com;
 dmarc=pass header.from=<jiaxun.yang@flygoat.com>
 header.from=<jiaxun.yang@flygoat.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1586399927; 
 s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
 h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=L8RyLyIO5cA+WJS12LcCV4FTG3FjLOTzF3Niw96yqW4=;
 b=Qc0pFEMJ3pNzFdH+4uwjJMMoj050mtwoKrfG3E1fBhPvMVvdxRxQrJJemnxf6OqE
 cWBcJPnCpHC+TMAgO2orJb4eyuAAx5nzmk+OeAFanI8AJVYSB8GdyM3E95JgfyA+29A
 QHLC2Q7AYU3noEzI0eFa2uaDhnMkQCTdzVxk9tg4=
Received: from flygoat-x1e (122.235.212.87 [122.235.212.87]) by mx.zoho.com.cn
 with SMTPS id 1586399924957572.7251930516607;
 Thu, 9 Apr 2020 10:38:44 +0800 (CST)
Date: Thu, 9 Apr 2020 10:38:44 +0800
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add myself as fulong2e co-maintainer
Message-ID: <20200409103844.1591548c@flygoat-x1e>
In-Reply-To: <CAAhV-H5moZ8kD5WAM1GvLRmg9spO7m=2DZZL+uUXAoo4iWZyVg@mail.gmail.com>
References: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
 <1586337380-25217-3-git-send-email-chenhc@lemote.com>
 <CAHiYmc61GZSvvwhCaC0B5q0GrEUN3CevDvNTEEWLE9PCJqVbvw@mail.gmail.com>
 <CAAhV-H5moZ8kD5WAM1GvLRmg9spO7m=2DZZL+uUXAoo4iWZyVg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 124.251.121.243
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Apr 2020 10:17:46 +0800
Huacai Chen <chenhc@lemote.com> wrote:

> Hi, Aleksandar,
>=20
> On Wed, Apr 8, 2020 at 11:30 PM Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
> >
> > 11:08 Sre, 08.04.2020. Huacai Chen <chenhc@lemote.com> =D1=98=D0=B5
> > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0: =20
> > >
> > > I submitted the MIPS/fulong2e support about ten years ago, and
> > > after that I became a MIPS kernel developer. Last year, Philippe
> > > Mathieu- Daud=C3=A9 asked me that whether I can be a reviewer of
> > > MIPS/fulong2e, and I promised that I will do some QEMU work in
> > > the next year (i.e., 2020 and later). I think now (and also in
> > > future) I can have some spare time, so I can finally do some real
> > > work on QEMU/MIPS. And if possible, I hope I can be a
> > > co-maintainer of MIPS/fulong2e.
> > >
> > > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 642c8e0..3281ff2 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1073,6 +1073,7 @@ F: hw/mips/mips_r4k.c
> > >  Fulong 2E
> > >  M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > >  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > > +M: Huacai Chen <chenhc@lemote.com>
> > >  S: Odd Fixes
> > >  F: hw/mips/mips_fulong2e.c
> > >  F: hw/isa/vt82c686.c
> > > --
> > > 2.7.0
> > > =20
> >
> > First of all, I want to express great pleasure and delight seing
> > your series, and this patch in particular.
> >
> > A warm welcome to QEMU developers communities!
> >
> > We are currenyly very busy preparing QEMU 5.0 release, and
> > additionaly, Easter holidays are in next few days or week
> > (different parts od Christian world have different calendars), so,
> > fot thay and other reasons, don't expect promot replies from us.
> >
> > I would also like to see Jiaxng at least having official reviewer
> > status, but, of course, only if he wants that. =20
> Thank you for your best wishes, I'm also very glad to see Jiaxun be
> an reviewer.

Thanks, but I was a primary school student at Loongson-2E's era, so I
can do nothing with 2E.

My experience with Loongson starts from 2F. And I'm more familiar with
2K and 3A.

I'm happy to contribute QEMU support for these platforms.

Thanks.

>=20
> Regards,
> Huacai
> >
> > Yours,
> > and wishing you and all people from China best health!
> >
> > Aleksandar =20

--
Jiaxun Yang

