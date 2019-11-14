Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1DCC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6F5206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXoS07Yd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6F5206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVGyb-0005gi-Pt
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 10:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1iVElY-0002sP-SC
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zltjiangshi@gmail.com>) id 1iVElW-0005ib-HG
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:02:28 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:35062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zltjiangshi@gmail.com>)
 id 1iVElW-0005i3-7b
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:02:26 -0500
Received: by mail-lj1-x243.google.com with SMTP id r7so6605919ljg.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 05:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xY858FZhltXf8u/Fe2p5BTnW1HQp3BVSAzz9nIgvRMY=;
 b=iXoS07YdD3iooiv0Qb8LrLlc+eamN/DONg+7x6cnv9fyBqUS0TShjnJ76ITF+yjhGr
 oPaTe/xRLzmu0F9v3MvF3TvB0i1R8TqbgCVZnAZtj/maCPbqS7SAs2zwwEUfSouNwqd2
 82ekMcTJnYIE05UFQnWQpZ1KNi1on4B3Gm/KQUlbjDH4Z/Piep9Sdn92O87yfU7JHjJU
 JpdfySAl9neTrfo/sFPXSF4J814Z/ha4e4r1PewkCPR0EqzEagN59qDP6hHgoZwjWmKW
 iiFDNabw5yeK7P3qZVlndAloJILk5etFlh4G+EruH22/ZW9z2TUGOKyorQvK8cNM6ZiX
 TuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xY858FZhltXf8u/Fe2p5BTnW1HQp3BVSAzz9nIgvRMY=;
 b=M+KedoNkU6r0CPu7mcq+dPnWoQlIQch0rFpuXJutWIYY1GL+Ko0FKHldq40o11aWbf
 aa2Kzcd2r1knd+3YQy0/QkW/8TsuKCXfLb9yj+7joj597eeIHaFQXbCq2bF7VUf7q7ya
 hlpbnQGxgM9ciev1yQyXdZ1ZGyru6Hl8+8QNGK5fJYQaGNF0fY0VDsCUWK4E0WYha/h4
 5WX1nA8ogvja+fzX0RLc3VzQYIsxrfNllc+qHbFsyUV9Z0Zmw8V/z++BHDsXObHfJipL
 qC/YEdwqYqnS6/aXA9twKvki4u79Cjbe8/SzlRRhsz5vbgXEoVYO2LwRXLS9g2xEgV1H
 3i4A==
X-Gm-Message-State: APjAAAXOty0bg+m/H4Gq9JKpNGzODAMnoKvGRfQ3ymmTavG5gRx59yJ/
 m/QOOMa1grsgH2S43vbtxRYmI3aAR9ODcHIXuQk=
X-Google-Smtp-Source: APXvYqyZz5E2jI63QY+3gNDprqyOgsbBjF5OQ5QDOVb/zG8OtILzMs0aUgbYzLqhKtYndbBN1iA/ik5bLHnfvnnfyB4=
X-Received: by 2002:a2e:890a:: with SMTP id d10mr105096lji.33.1573736542692;
 Thu, 14 Nov 2019 05:02:22 -0800 (PST)
MIME-Version: 1.0
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-3-git-send-email-aleksandar.markovic@rt-rk.com>
 <c053c16c-c6f4-4f73-7383-7b66e54ad696@redhat.com>
 <BN6PR2201MB12512B977314BCFCA202449DC6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB12512B977314BCFCA202449DC6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: chen huacai <zltjiangshi@gmail.com>
Date: Thu, 14 Nov 2019 21:08:17 +0800
Message-ID: <CABDp7VoVpZsQpDc7U4uJ1B7ZVCc8A2KO5qNaOucHQH6xUdX8tQ@mail.gmail.com>
Subject: Re: [EXTERNAL]Re: [PATCH v2 2/5] MAINTAINERS: Adjust maintainership
 for Fulong 2E board
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
X-Mailman-Approved-At: Thu, 14 Nov 2019 10:21:44 -0500
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>, Huacai Chen <chenhc@lemote.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, all,

On Thu, Nov 14, 2019 at 8:34 PM Aleksandar Markovic
<amarkovic@wavecomp.com> wrote:
>
> Hi, Philippe,
>
> > From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> > Hi Aleksandar,
> >
> > On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
> > > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> > >
> > > Change the maintainership for Fulong 2E board to improve its quality.
> >
> > IIRC you told me once this board is named Fuloong, and its CPU is a
> =E2=80=8E> Loongson, both with 2x 'o' :) I have a patch renaming the vari=
ous
> > occurrences.
> >
>
> I still think that the oficial name is "Fuloong 2E", however, it is
> shortened to "Fulong 2E" quite often in communication, and, it seems,
> sometimes even in various docs/app notes etc.
>
> Can perhaps Huacai Chen enlighten us regarding the right spelling?
The right spelling is Fuloong.

>
> > > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > > ---
> > >   MAINTAINERS | 7 ++++---
> > >   1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index fd9ba32..3bf2144 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -976,9 +976,10 @@ S: Maintained
> > >   F: hw/mips/mips_r4k.c
> > >
> > >   Fulong 2E
> > > -M: Aleksandar Markovic <amarkovic@wavecomp.com>
> > > -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> > > -S: Odd Fixes
> > > +M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> > I am happy to keep the Fuloong working, but this will be on my personal
> > (hobbyist) time. This area is not a priority for my employer, so I'll
> > use my personal email: f4bug@amsat.org.
> >
>
> OK.
>
> > The original author is active on the Linux kernel, let ask him if he'd
> > be OK to keep an eye on his work.
> >
> > Huacai, would you agree to be listed as a reviewer on the Fuloong
> > related QEMU files? You don't have to worry about the generic QEMU code
> > plate (like keeping API up to date) I'll manage that, but I'd like to
> > have you listed to assert the hardware is properly modeled.
> >
> > You would appear as:
> > R: Huacai Chen <chenhc@lemote.com>
> >
>
> That is a great idea!
>
> Please, Chen, get involved, you would be very welcomed, there is a place
> for you in QEMU community!
I'm sorry that I'm busy now, but I think I will do something in QEMU
in the next year.

>
>
> > > +R: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> >
> > I don't think Herv=C3=A9 is interested by this board, he has not modifi=
ed the
> > code.
> >
> > > +R: Aleksandar Markovic <amarkovic@wavecomp.com>
> > > +S: Maintained
> >
> > Let keep it as "Odd Fixes" :)
> >
>
> OK.
>
> >    Odd Fixes:   It has a maintainer but they don't have
> >                 time to do much other than throw the odd
> >                 patch in.
> >
> > >   F: hw/mips/mips_fulong2e.c
> > >   F: hw/isa/vt82c686.c
> > >   F: hw/pci-host/bonito.c
> > >
> >
> > So the patch would be:
> >
> > -- 8< --
> >   Fulong 2E
> > -M: Aleksandar Markovic <amarkovic@wavecomp.com>
> > -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> > +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > +R: Aleksandar Markovic <amarkovic@wavecomp.com>
> > +R: Huacai Chen <chenhc@lemote.com>
> >   S: Odd Fixes
> >   F: hw/mips/mips_fulong2e.c
> >   F: hw/isa/vt82c686.c
>
> Plus possible s/Fulong 2E/Fuloong 2E/
>
> > ---
> >
> > But let's wait to see what Huacai Chen thinks of it, before posting it.
> >
> > Thanks for taking care of those changes!
> >
> > Phil.
> >
> >
>
> Thank you!
>
> Aleksandar
Thanks,

Huacai

