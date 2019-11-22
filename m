Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF800C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B2220706
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 14:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQFh0ti9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B2220706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY9jF-0007ZL-Eb
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 09:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:61000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iY9i6-00070U-SJ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:14:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iY9i4-0004Zb-L3
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:14:58 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iY9i4-0004Z8-GF
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 09:14:56 -0500
Received: by mail-ot1-x341.google.com with SMTP id w11so6307787ote.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 06:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bNwuUeYTrXSGPiHVcT7E0sw2b9jkxQuUW57eM/dBzzw=;
 b=PQFh0ti9DzdnNuOzxu8bNHF3JYQfO+e1zA8VenXMsDcJ0G+pXyOqHNOfXcX/70dmOB
 gqSGGQpwlCeS0E5CTKdS6KGSGcPiNeACTABWadGVoXip8Z8FBdXmtiSJFKfiNuPrGeo+
 NooWcgLYDg/cMuRCNLLhOQV3YVuZGEptlB2UkXzouB7HfXql8PJZ3F1O1dgd37+5n2qL
 2edon2sKXml9bz+y3+Veud1ICtUyhqtkMIEgomvHD2ndrc84fCFRR8BamfXBOgc3DlTH
 07spFCpx1+TzwdJSbYZr8L14gLRhvCp9MMlvLuQgvQlzogZjmtQC1YgEO3LPbWHqXBT9
 rKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bNwuUeYTrXSGPiHVcT7E0sw2b9jkxQuUW57eM/dBzzw=;
 b=Ew6QOU9QpCR4jPNggXzFTng7XpXCxdXr2iqQlqcPbfP/dSo1Rf8ZOLosWUuijIGUjG
 KjqA3XW+0cREGn4yTIIX9Xy+yUsMOHspIbmuVmDggibu7fgfBQ1T/6LtWMOPECzlY8pO
 8V0cmFugAMKsZAUtrrxH3Y5issN2zb2JTUjyFHxRA3SiMHSx3bm0uGcN5N80tg71SKk4
 WdHOGFvkBUawoXu9G9UVCq8uMXHPikMaHQSltTQtBiyGyXV/LE9+EMcLvPQc8DqP7v+N
 TWpRH8KF3tLnK6nO+yeq3qI0EqWI6fBaof8gY/Snf2pLBonMrJ/nxWSM2z43j+auOXeq
 G60Q==
X-Gm-Message-State: APjAAAUnlGLVBoL4vrlLLGL8UK150uLoyHKeRUHt0gbhDAsYAN4XDXoZ
 Zg2aLJT6s2v4GSK9+neJ1Q4Uq0clf1Yi+EiG3nI=
X-Google-Smtp-Source: APXvYqx+EQ/l6CNXXFyZoThJjyZcgTVNRvS60aoQd4XW0aK7eixlj6QnOLPTP89UQkoaCiQYCv2dfj1CKvpCN3eyfmk=
X-Received: by 2002:a05:6830:1383:: with SMTP id
 d3mr10907310otq.306.1574432095546; 
 Fri, 22 Nov 2019 06:14:55 -0800 (PST)
MIME-Version: 1.0
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-5-git-send-email-aleksandar.markovic@rt-rk.com>
 <78b81f32-0eb0-6d51-6ecc-9c8045be3896@redhat.com>
In-Reply-To: <78b81f32-0eb0-6d51-6ecc-9c8045be3896@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 22 Nov 2019 15:14:44 +0100
Message-ID: <CAL1e-=iWZszvg7pY=iL6j0bUch+gF5nhuk+XbGFkipkhzCHHug@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] MAINTAINERS: Adjust maintainership for R4000
 systems
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 2:58 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Aleksandar,
>
> On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Change the maintainership for R4000 systems to improve its quality.
> >
> > Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > ---
> >   MAINTAINERS | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6afec32..ba9ca98 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -971,8 +971,9 @@ F: hw/mips/mips_mipssim.c
> >   F: hw/net/mipsnet.c
> >
> >   R4000
> > -M: Aurelien Jarno <aurelien@aurel32.net>
> > -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> > +M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>
> Commit 0c10962a033 from Herv=C3=A9 was part of a bigger refactor series, =
so I
> don't think he is interested.
>
> > +R: Aurelien Jarno <aurelien@aurel32.net>
> > +R: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >   S: Maintained
> >   F: hw/mips/mips_r4k.c
>
> Now back to this board, I am having hard time to understand what it
> models. IIUC it predates the Malta board, and was trying to model a
> board able to run the first MIPS cpu when the port was added in 2005
> (see commit 6af0bf9c7c3a).
> The Malta board was added 1 year later (commit 5856de800df) and models a
> real hardware.
>
> As Aurelien acked to step down maintaining it, it seems the perfect
> timing to start its deprecation process. I'll prepare a patch for 5.0
> (unless someone is really using it and willing to maintain it).
>

Philippe, hi.

Herve told me a while ago that he does care about R4000 being
supported, as it is closely related to Jazz machines, so please
don't start any deprecation process.

Herve is the most familiar of all of us with R4000, and, for that
reason, my suggestion is to keep the patch as it is. Let me know
if you have any objections.

One alternative approach would be to merge "R4000" and
"Jazz" sections. But, let's leave it for future as an option,
if nobody objects.

Yours,
Aleksandar

> Regards,
>
> Phil.
>
>

