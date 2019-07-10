Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D02EC74A22
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 13:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0402064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 13:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2iWWJwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0402064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlCeQ-0007nu-05
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 09:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51208)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <christophe.lyon@linaro.org>) id 1hlCcv-0007I8-BY
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 09:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <christophe.lyon@linaro.org>) id 1hlCct-0002TN-Un
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 09:27:17 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:44656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <christophe.lyon@linaro.org>)
 id 1hlCct-0002RW-L9
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 09:27:15 -0400
Received: by mail-lf1-x142.google.com with SMTP id r15so1574946lfm.11
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EgCBmtVyKSOLbMLxU1gRJDabje58eRMdzIG7CsC18xc=;
 b=j2iWWJwVouix8mgsHL9bj1fQZcF+yiSUuo86uraV6ZIJEEPN1Fs4Bl9G4n7v6AFtEY
 uaqV4SyfSrkE/rHCESgukvOhrCNsVOZkdklappMfzqmXBNeszB19mbRLZpKpsmKnzVFk
 GWXLWGY6pRo6XMplIwANoCsGj/ss+mBqPy+9NUijV8xzJvveT55emFkXS6uxy9Izeiyn
 kUYs257khziW59QHOfOlTA36vTEDT4y2sjbDUXZopqpBx9KHqxO8YU1rCXK1MrpDbVfn
 QgfCrwGsqEmLA8kUNj9H+6d9iDWrBGSgsqmr8CKsBfniEiSnQb6zlRIPSYXd2ix4nREO
 Wd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EgCBmtVyKSOLbMLxU1gRJDabje58eRMdzIG7CsC18xc=;
 b=XGE9m9DBscGj1IxiTk20/MoE2pqez4s9K0mZxNWLnjZNwCynRoq8+FrraSVGRpd9RU
 jItp1vU8PSK7GkC6xiSNmjwvhjy+09HGaL9S/iuIr4l+lMbxyImBkuDQRtcGp/KEo0H3
 CNNWCvj+sdhRS29nxsyiNjDiYKWedBoS7eoLaX2aJvR1UwTetd7PUkoZRArUJfLwIN2s
 DeSbJ3T58+1pbfkSEzSoQlMcvjaHrdeNhl9Y1ZFJlFlass2dSGkqEc6HeZAdI5DaSIUh
 zvBqvKvRYux0fL2M59B0bHVo/Mm2tgnHAOY+LSk8qK30bZsBBkZyHY/wviHBikGMxPTJ
 GDxw==
X-Gm-Message-State: APjAAAU0s6YvkH6UA6TaqRX9qOJXA/pBh/k0Iibqpy+iC7tp7mfxQ1fA
 r45eX/aOdclslukyoksFfo0frXlAo042UmbwzYOuPA==
X-Google-Smtp-Source: APXvYqweducevTg03okCnDalulbqzIP2Yt7nKX+Ekn3sUaflWtCUO+xPCiVh/BvMr5Ox8EzT9MoLQB2jMhdKG6fgjKU=
X-Received: by 2002:ac2:5c1d:: with SMTP id r29mr13907617lfp.72.1562765233580; 
 Wed, 10 Jul 2019 06:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190709121900.25644-1-richard.henderson@linaro.org>
 <87sgrfe4y9.fsf@zen.linaroharston>
In-Reply-To: <87sgrfe4y9.fsf@zen.linaroharston>
From: Christophe Lyon <christophe.lyon@linaro.org>
Date: Wed, 10 Jul 2019 15:27:02 +0200
Message-ID: <CAKdteOZ2aVuRGO92kFKfkXub6f0aydc-W6=uDq3Jtz2gDVi58A@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH for-4.1] tcg: Fix constant folding of
 INDEX_op_extract2_i32
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jul 2019 at 15:02, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
> > On a 64-bit host, discard any replications of the 32-bit
> > sign bit when performing the shift and merge.
> >
> > Fixes: https://bugs.launchpad.net/bugs/1834496
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>

Tested-by: Christophe Lyon <christophe.lyon@linaro.org>

Hi,

I ran GCC validations with your fix, it does fix the problems I
reported with the arm-none-linux-gnueabi target.

Unfortunately, we are unlucky because there are still regressions
compared to qemu-3.1 when using the arm-none-linux-gnueabihf target,
as well as arm-eabi and aarch64-elf.
I hoped all had the same root cause..... I'll report the remaining
ones in a new launchpad bug.

Thanks

Christophe


> > ---
> >  tcg/optimize.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tcg/optimize.c b/tcg/optimize.c
> > index d7c71a6085..d2424de4af 100644
> > --- a/tcg/optimize.c
> > +++ b/tcg/optimize.c
> > @@ -1213,8 +1213,8 @@ void tcg_optimize(TCGContext *s)
> >                  if (opc =3D=3D INDEX_op_extract2_i64) {
> >                      tmp =3D (v1 >> op->args[3]) | (v2 << (64 - op->arg=
s[3]));
> >                  } else {
> > -                    tmp =3D (v1 >> op->args[3]) | (v2 << (32 - op->arg=
s[3]));
> > -                    tmp =3D (int32_t)tmp;
> > +                    tmp =3D (int32_t)(((uint32_t)v1 >> op->args[3]) |
> > +                                    ((uint32_t)v2 << (32 - op->args[3]=
)));
> >                  }
> >                  tcg_opt_gen_movi(s, op, op->args[0], tmp);
> >                  break;
>
>
> --
> Alex Benn=C3=A9e

