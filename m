Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AC5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 23:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA73B2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 23:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAwUP6e1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA73B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjAN8-00032f-TM
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 19:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjAMO-0002YT-42
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 19:42:20 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51008)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjAMN-0001Uj-5S
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 19:42:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id l17so3391042wmj.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 16:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LXjwYXgEdelYimfIKoem2lLgYyk/eptnkPPhi+2Khz8=;
 b=TAwUP6e1df6jBijgpGGghZaW65mF0O05qgmfI3BF603ED6ibmrOYXdfO435wjGxBvU
 MY3MKpYugCCYV7UAG9AsFWFsNy39o1jxiTngmPRkP+ft4Xp2mMbIWBPebs0HYai9d8S1
 S/4/PwfLgu2v7d2HpTSz/Y5KPg79EMsn7GZE/xwxyAJkSSu83U6ToiYi9h7Dc9L6SxsX
 gBfGD7szorE6VV4VnAZpzZ/kMkCNTvzRlsWR5mJTTl8FFhcYU0VLT1rANUxfUi/KR5Vr
 SHOh3VZr7su8Mz4D5EMBsYsbepoEhQbf08ULbaSFWTxMNOCdjxTqfX4Db2akDc3n4VnJ
 1FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LXjwYXgEdelYimfIKoem2lLgYyk/eptnkPPhi+2Khz8=;
 b=X8v2uTqFb98E3s3UPIM9xxmURe5WQBjYAHASJTnpYmxDZ5DMugXsc9oqYD+heHnPtR
 cxWLChslCnEFHFkgbBOr+/PZcIngj2yYPLZCxaE5q/yHsqv2tLd0g3IxY9ENZRXpJIWI
 Lzbb9iU4ARFXIsAY0FfZYpBTpUF8xAwGWQWwwoDSA2KyR/a2ABH1mvjl9wFvMazAw7OX
 jgc4878h1MqhnCxlT2wPXtMIjhPBl96tgOHSQ6MJ84Yc8TOiEeDiQI0g/Kb5epHTUcPa
 4eq3NrkGlFKPN4UbxYqtlEPWsCEl6OnjoZExLKtNHujxWe5wDagM7gV8ln+Kw9IGqqtA
 HG0A==
X-Gm-Message-State: AOAM530f7VxUZx/x/haxMfjt5aeqOLTrPIFKdfXtLd8mDGr2LJs0duFq
 5EHUfQUkBzqlhqNjPV8nHVGOEhPxIzabyZVbGqU=
X-Google-Smtp-Source: ABdhPJyM2JJ2NYtL1D0cr54LGVTHke56jwfIZnL6DdN9YRoBJLtMoFEhElYuzn14K2w5q8QoVWtDxB9XNmCvLcTH8jo=
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr5129302wmj.159.1591832531758; 
 Wed, 10 Jun 2020 16:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200610221743.24627-1-aleksandar.qemu.devel@gmail.com>
 <20200610221743.24627-2-aleksandar.qemu.devel@gmail.com>
 <3b784117-49ef-fbec-e8ad-df49ca0e892a@amsat.org>
In-Reply-To: <3b784117-49ef-fbec-e8ad-df49ca0e892a@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 11 Jun 2020 01:41:59 +0200
Message-ID: <CAHiYmc5K4t5_NAFd=JsXnMBWqC=64rig_6Z3JPmenihgtCfVeg@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Adjust sh4 maintainership
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=87=D0=B5=D1=82, 11. =D1=98=D1=83=D0=BD 2020. =D1=83 00:51 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 6/11/20 12:17 AM, Aleksandar Markovic wrote:
> > This patch transfers sh4 sections to Yoshinori Sato, who is best
> > positioned in the community to assume their maintainership.
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg708235.html
>
> "BTW, you also dictate there Yoshimoto that to do and
>  what not to do. Why?"
>
> I suppose you meant Yoshinori? Again I'm didn't want to appear
> as dictating, I spend hours trying to raise the quality of the
> RX hardware model to be sure it'd be merged. You can not say
> otherwise, see the latest series posted:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg708317.html
>
> We can not say likewise with the AVR port you almost killed,
> asking changes then disappearing, letting other contributors
> stuck.
>
> > He is
> > the maintainer of the related target rx.
> >
> > Further adjustments, reorganizations, and improvements of sh4
> > sections are left to the future maintainer to be devised and
> > executed, as he deems suitable.
> >
> > Aurealien and Magnus are deleted from some sections from the
>
> Typo 'Aurelien'.
>
> > MAINTAINERS file with this patch. However, they will not be
> > deleted from QEMU Hall of Fame, where their names will always
> > be carved in stone as QEMU pioneers and granddadies.
>
> Typo 'granddaddies'.
>
> >
> > Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> > Acked-by: Magnus Damm <magnus.damm@gmail.com>
> > Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>
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
>
> 'Maintained'? See:
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg710928.html
>
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
> >
> >  Shix
> > -M: Magnus Damm <magnus.damm@gmail.com>
> > +M: Yoshinori Sato <ysato@users.sourceforge.jp>
> >  S: Odd Fixes
>
> Ditto 'Maintained'?
>
> Whichever status Yoshinori like:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>

Thank you!

> >  F: hw/sh4/shix.c
> >
> >
>

