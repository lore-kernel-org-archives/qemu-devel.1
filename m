Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D7BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8008420747
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPiCzfeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8008420747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjJOJ-0001Kx-QW
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 05:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjJN0-0008Ge-Hg
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:19:34 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34088)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjJMz-0002AG-Jv
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:19:34 -0400
Received: by mail-wm1-x342.google.com with SMTP id u26so6493761wmn.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 02:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1XZoi35RAx+5zEu5hrLeHpjSK4P723iIymcN458n5lc=;
 b=FPiCzfeLfMbJwYDgpf1u22ZVVOsWQJqEZGtL732Tq30YCapi0d/u3m6pecLanhFsah
 oRj3T7ZgSZN3ea4ALSs8r5fDFniuMf0tCtlug4Ftkju6jhKrn6zYvZ2mBSjFUpAngyr9
 zpIVGMRcAns5Yk/TyTLvfH3Ez4Jm5EDRNbLMMVuO+9OseLj0+tIFLdpFsqDpBoIEFx2e
 o3RH5IUzOcH1me1lMeUtmutWviwcl3Ff32tH4lDwE1UBm4RDsJjzE6b5Ux0mx78a9Kyc
 3fGrvW2jCrUBhO9M7ZFatPEyuwXuUHKUg6IyRk5UjCBkYp8VkR/pjr2Vlra+WF3appmm
 aurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1XZoi35RAx+5zEu5hrLeHpjSK4P723iIymcN458n5lc=;
 b=KROEAzsTJt/3pmqW1VUCHmeN0fWxL8zI9OVqNfRCW76LmQKwFsLp6Zt5LFyPZFA6wO
 wIjo3+pmew2ZzXbqMo3wa6jAqAJc+YG+XZGg1QRVPWsZrlUTLwAxZ4UcoP0dBo9HUz9k
 VrEGDt26bJ+3EJpNLACZQZgfZGBijs4U/De12hGRtUKv1kld+Fd+mp+FAfOEWMWtdbhd
 ftCjoh0joQpmptUyR5JNOr2Mfk2ORk/Cn5+S8VIyFNc9cdVpKyf8JO1g63Jag3QYS1rs
 ksSbOwMtovQWl4FxSU5y+Bw2QUeJ944d3YRM3b7GHwENHkjuJ8I6spLxe5PYQITKTfAH
 MNMw==
X-Gm-Message-State: AOAM5319Y9LTNvqZoFkcQpeT/DZPA3AzZwtZllG8uTP8TnBlXEOGa+KM
 yytECDX+qX8xottOXsguloAexufMtR5/4MCkQ3w=
X-Google-Smtp-Source: ABdhPJxdCySSkqrEy/t0/XymY52i3i1ki/sdlw0UQGlSrHqxN6/ElkVdcrnjrua5xLIdan0RzEbwVTmmMua74wAK78Q=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr7722793wmb.168.1591867166314; 
 Thu, 11 Jun 2020 02:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200610221743.24627-1-aleksandar.qemu.devel@gmail.com>
 <20200610221743.24627-2-aleksandar.qemu.devel@gmail.com>
 <05510fa8-f2f7-7f66-13e4-59e6210adcb0@redhat.com>
In-Reply-To: <05510fa8-f2f7-7f66-13e4-59e6210adcb0@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 11 Jun 2020 11:19:13 +0200
Message-ID: <CAHiYmc4RBUstufaR_sXR=FFE8WO1hq9OdrPbdO-RnKPrtn5g-w@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Adjust sh4 maintainership
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, Magnus Damm <magnus.damm@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=87=D0=B5=D1=82, 11. =D1=98=D1=83=D0=BD 2020. =D1=83 10:25 Thomas Huth <=
thuth@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> On 11/06/2020 00.17, Aleksandar Markovic wrote:
> > This patch transfers sh4 sections to Yoshinori Sato, who is best
> > positioned in the community to assume their maintainership. He is
> > the maintainer of the related target rx.
> >
> > Further adjustments, reorganizations, and improvements of sh4
> > sections are left to the future maintainer to be devised and
> > executed, as he deems suitable.
> >
> > Aurealien and Magnus are deleted from some sections from the
> > MAINTAINERS file with this patch. However, they will not be
> > deleted from QEMU Hall of Fame, where their names will always
> > be carved in stone as QEMU pioneers and granddadies.
> >
> > Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> > Acked-by: Magnus Damm <magnus.damm@gmail.com>
> > Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>
> They more or less "acked" Philippe's patch, but I don't think you can
> conclude from that that they agree to your changes automatically, too.
> So please don't put "Acked-by"s into your completely new patch that you
> did not gather yourself.
>

I disagree. I carefully studied their responses and they, as a rule, acked-=
by
the general approach, not a particular patch. I will keep Acked-by:s unless
some of them objects.

> > Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > ---
> >  MAINTAINERS | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6e7890ce82..7ddb6db38c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -296,7 +296,7 @@ F: tests/tcg/s390x/
> >  L: qemu-s390x@nongnu.org
> >
> >  SH4 TCG CPUs
> > -M: Aurelien Jarno <aurelien@aurel32.net>
> > +M: Yoshinori Sato <ysato@users.sourceforge.jp>
> >  S: Odd Fixes
> >  F: target/sh4/
> >  F: hw/sh4/
> > @@ -1251,14 +1251,14 @@ F: include/hw/riscv/opentitan.h
> >  SH4 Machines
> >  ------------
> >  R2D
> > -M: Magnus Damm <magnus.damm@gmail.com>
> > +M: Yoshinori Sato <ysato@users.sourceforge.jp>
> >  S: Maintained
> >  F: hw/sh4/r2d.c
> >  F: hw/intc/sh_intc.c
> >  F: hw/timer/sh_timer.c
>
> Magnus said that he is still interested in R2D, just does not have the
> time anymore to actively maintain it. So I think it is a bad idea if you
> completely remove him here. His line should be changed from "M:" to "R:"
> instead unless he explicitely states that he wants to completely be remov=
ed.
>

Fair enough. I will mention him as R: in the next version.

Thanks,
Aleksandar

>  Thomas
>

