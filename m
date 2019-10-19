Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6419CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 19:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62FCA21D7C
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 19:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C71f+k5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FCA21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLuod-0001PR-Jn
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 15:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLunv-0000sc-8a
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 15:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLunt-0000Yr-PD
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 15:54:23 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39748)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLunt-0000Yf-Hy
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 15:54:21 -0400
Received: by mail-oi1-x243.google.com with SMTP id w144so7998621oia.6
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 12:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=E7wz6lOAsG5Jn+2DJqKA+l9+6nWe0d3tasPSjFumDb0=;
 b=C71f+k5RWBC6OjRD3ANAMHpE2SbMFFkHlhjNtB1qBUbPiUcOwCIY6tECtloNAIH38V
 9i+2m6buTNyTw0Ajj2I2xS2aHs38ys9ngxTVmNxqydEoQsPPsx5Ait1Jt7mhAucONT8E
 CI9MJt5RbrYEB1AAQqiwcZQiYlTZmz91wa0KM2BrwR/J7cDIIzuHQqVdWBi5VBw+E5uB
 +m8ujISn+M0sv61iDOmC0NjfEe+xK41IcY8bIJAccrpM0JdcwwK3k1YzsD+wSXLuWwxC
 c+f+4y8+3UVKJVyGixz3PKp8VrjhnC1wRrG6zjosrnix+aT/BE9t+zPKQx9EkNMPT+H7
 XdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=E7wz6lOAsG5Jn+2DJqKA+l9+6nWe0d3tasPSjFumDb0=;
 b=qHQNaORPwXrPJTVNNWgG3BOlWBiWzBDgjlPPAHe3IhuRaeFd3n1uJYXY75XmH/pWtT
 hfJCJLbm0JUjGzIha6feGFOZFJmnT8rqN48DWfOPHizKovCmP+WYM9QCfHx5UvnQRRS0
 zKqx7reD1WxfX8ik/iyt27HJphVKwGD93et/8gqzR3OGg/jrJOVJwaAWt0l72XwzmWH5
 RV+VnJuyTIFUIZ5hH6VqS0CwnmXMs6OOjmcz/+rgCuoHalRq4CCk95hJAUzCBPIQ12Qw
 wj/2KkcbhAlDuuuCAhXCMaMqaYm4z9GRIRoBC/bV5z3DNu1OAklBMAkvK5Nyfygy6dt5
 2adg==
X-Gm-Message-State: APjAAAWO2ZOOfN15dAXGlevBpPhD8SYAMKV13PRBC0i4Kj75xl3kKxhP
 AKJoKCQHrKyF4jg/VvtMfdb8l2MVvZiL0RhVszq8lw==
X-Google-Smtp-Source: APXvYqzTzPu9d96Emw/Pr7q399hYFWq8g8tKf4zPya5YEGxD+I36ArMZ0w9/yNg16dB2LhvPtUyixKPje+SvucyUyXc=
X-Received: by 2002:aca:4e56:: with SMTP id c83mr13123449oib.53.1571514860813; 
 Sat, 19 Oct 2019 12:54:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 19 Oct 2019 12:54:20
 -0700 (PDT)
In-Reply-To: <1571311659-15556-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1571311659-15556-1-git-send-email-stefan.brankovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 19 Oct 2019 21:54:20 +0200
Message-ID: <CAL1e-=gLongQhD7TV=Q9AxtGr0X1_kUug-JUeQMwRnASkqvifA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] target/ppc: Optimize emulation of some Altivec
 instructions
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Content-Type: multipart/alternative; boundary="00000000000009c0d3059548d18d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000009c0d3059548d18d
Content-Type: text/plain; charset="UTF-8"

On Thursday, October 17, 2019, Stefan Brankovic <stefan.brankovic@rt-rk.com>
wrote:

> Optimize emulation of ten Altivec instructions: lvsl, lvsr, vsl, vsr,
> vpkpx,
> vgbbd, vclzb, vclzh, vclzw, vclzd, vupkhpx and vupklpx.
>
>
ten -> twelve



> This series buils up on and complements


>
buils -> builds


>
recent work of Thomas Murta, Mark
> Cave-Ayland and Richard Henderson in the same area. It is based on
> devising TCG
> translation implementation for selected instructions rather than using
> helpers.
> The selected instructions are most of the time idiosyncratic to ppc
> platform,
> so relatively complex TCG translation (without direct mapping to host
> instruction that is not possible in these cases) seems to be the best
> option,
> and that approach is presented in this series. The performance improvements
> are significant in all cases.
>
> V7:
>
> Added optimization for vupkhpx and vupklpx instructions.
>
> V6:
>
> Rebased series to the latest qemu code.
> Excluded all patches that are already accepted.
>
> V5:
>
> Fixed vpkpx bug and added it back in patch.
> Fixed graphical distortions on OSX 10.3 and 10.4.
> Removed conversion of vmrgh and vmrgl instructions to vector operations for
> further investigation.
>
> V4:
>
> Addressed Richard's Henderson's

suggestions.
> Removed vpkpx's optimization for further investigation on graphical
> distortions
> it caused on OSX 10.2-4 guests.
> Added opcodes for vector vmrgh(b|h|w) and vmrgl(b|h|w) in tcg.
> Implemented vector vmrgh and vmrgl instructions for i386.
> Converted vmrgh and vmrgl instructions to vector operations.
>
> V3:
>
> Fixed problem during build.
>
> V2:
>
> Addressed Richard's Henderson's suggestions.
> Fixed problem during build on patch 2/8.
> Rebased series to the latest qemu code.
>
> Stefan Brankovic (3):
>   target/ppc: Optimize emulation of vclzh and vclzb instructions
>   target/ppc: Optimize emulation of vpkpx instruction
>   target/ppc: Optimize emulation of vupkhpx and vupklpx instructions
>
>  target/ppc/helper.h                 |   5 -
>  target/ppc/int_helper.c             |  50 ------
>  target/ppc/translate/vmx-impl.inc.c | 326 ++++++++++++++++++++++++++++++
> +++++-
>  3 files changed, 321 insertions(+), 60 deletions(-)
>
> --
> 2.7.4
>
>
>

--00000000000009c0d3059548d18d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, October 17, 2019, Stefan Brankovic &lt;<a href=3D"mail=
to:stefan.brankovic@rt-rk.com">stefan.brankovic@rt-rk.com</a>&gt; wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">Optimize emulation of ten Altivec instructi=
ons: lvsl, lvsr, vsl, vsr, vpkpx,<br>
vgbbd, vclzb, vclzh, vclzw, vclzd, vupkhpx and vupklpx.<br>
<br></blockquote><div><br></div><div>ten -&gt; twelve</div><div><br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">
This series buils up on and complements=C2=A0</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><br></blockquote><div>=C2=A0</div><div>buils -&gt; builds</di=
v><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">=C2=A0<br></blockquote><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">recent work of Thomas Murta, Mark<br>
Cave-Ayland and Richard Henderson in the same area. It is based on devising=
 TCG<br>
translation implementation for selected instructions rather than using help=
ers.<br>
The selected instructions are most of the time idiosyncratic to ppc platfor=
m,<br>
so relatively complex TCG translation (without direct mapping to host<br>
instruction that is not possible in these cases) seems to be the best optio=
n,<br>
and that approach is presented in this series. The performance improvements=
<br>
are significant in all cases.<br>
<br>
V7:<br>
<br>
Added optimization for vupkhpx and vupklpx instructions.<br>
<br>
V6:<br>
<br>
Rebased series to the latest qemu code.<br>
Excluded all patches that are already accepted.<br>
<br>
V5:<br>
<br>
Fixed vpkpx bug and added it back in patch.<br>
Fixed graphical distortions on OSX 10.3 and 10.4.<br>
Removed conversion of vmrgh and vmrgl instructions to vector operations for=
<br>
further investigation.<br>
<br>
V4:<br>
<br>
Addressed Richard&#39;s Henderson&#39;s=C2=A0</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">suggestions.<br>
Removed vpkpx&#39;s optimization for further investigation on graphical dis=
tortions<br>
it caused on OSX 10.2-4 guests.<br>
Added opcodes for vector vmrgh(b|h|w) and vmrgl(b|h|w) in tcg.<br>
Implemented vector vmrgh and vmrgl instructions for i386.<br>
Converted vmrgh and vmrgl instructions to vector operations.<br>
<br>
V3:<br>
<br>
Fixed problem during build.<br>
<br>
V2:<br>
<br>
Addressed Richard&#39;s Henderson&#39;s suggestions.<br>
Fixed problem during build on patch 2/8.<br>
Rebased series to the latest qemu code.<br>
<br>
Stefan Brankovic (3):<br>
=C2=A0 target/ppc: Optimize emulation of vclzh and vclzb instructions<br>
=C2=A0 target/ppc: Optimize emulation of vpkpx instruction<br>
=C2=A0 target/ppc: Optimize emulation of vupkhpx and vupklpx instructions<b=
r>
<br>
=C2=A0target/ppc/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A05 -<br>
=C2=A0target/ppc/int_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 50 ------<br>
=C2=A0target/ppc/translate/vmx-impl.<wbr>inc.c | 326 ++++++++++++++++++++++=
++++++++<wbr>+++++-<br>
=C2=A03 files changed, 321 insertions(+), 60 deletions(-)<br>
<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote>

--00000000000009c0d3059548d18d--

