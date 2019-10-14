Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A16C47404
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 04:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB642067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 04:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5z6qe/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB642067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJsCI-0004Ea-7A
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 00:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iJsAz-0003mR-GG
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 00:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iJsAy-0007Vz-9U
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 00:41:45 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:36665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iJsAy-0007Vk-4L
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 00:41:44 -0400
Received: by mail-oi1-x229.google.com with SMTP id k20so12692348oih.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 21:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=akTTEmks7V47Xz9wwUCSzj6PJzW0A/M74cxRPrqJC24=;
 b=b5z6qe/VU+qgIvmbVg/j+CmVqll2TlcoLOLKYF8AzesDe/1oQaijPIi3KvFIhf0n34
 fWxIBU//zfJos0NO/yUoBGVSEYHbY1DnLjebPuOaxl8mLS7OQg895WE3I3kQJ7j4lCL9
 l610Xelk4s7iNelFWei0tAR7e/QefpBhn2DHx+UM6TdqqSixQfu8ngcAOxeVQaxP7YL0
 eJvAnog/Z6njwWpMhsHq5Ddhf1U1/Vg84Hd+QgeGtfpjKrLb7nZomTMEmHGzC2D9X9tb
 A5V4AoO/om6+kWQk8l7xEJuDO+gI/7x5ofLEdabG+SJkOlLks0/rw7gvycc1hgWu5UER
 w2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=akTTEmks7V47Xz9wwUCSzj6PJzW0A/M74cxRPrqJC24=;
 b=cVvY4qCc3rBLyXBl66ETSZFosrPTtU/cYIikqUZvxOq3l2G24agfoNAC8s17M8lN9D
 DFQ8eaU5cvUL/lu3MrzJxDWRlvKWUXbDCrt6ByVcc8kI9ildngJTJFtWWibcWGKDHDBo
 fovo6LV9t5a9Q2pNkd8iUDdM+JdoUXj+aZfZ7sPTjQzfA0Y+bPlANV4FvcvRsZ3DO/rm
 Yrez4NpaF8y7QKe5O3bLHVYLRdL6DoKaVOeNUV/sRvm8S0CFEI/DsbZcwn8LUfx4k/5Y
 eRU45kvrk2xfw01gLiTFMmFBQNBk7qTKk3IxSbucpMYBBCG8Jeo8Rm6i0QoysHTSMbpD
 i0Fw==
X-Gm-Message-State: APjAAAXEicVRO02PvlWeweMes8wUppQZLPlZ7UC75eWd1A1wXn7tJK2H
 46abxWuh2pWPGHoHmOsj84gi5IeBnbiF8XUEcZw=
X-Google-Smtp-Source: APXvYqx2FHlgwv0/aQXwmJv90wL1a5cThS36zrerVkIChAE2uURPfMLaKHnnkRNinFj0wrMXzLvA/0NHb7F1mCDnUsA=
X-Received: by 2002:aca:62d5:: with SMTP id
 w204mr23050748oib.136.1571028103262; 
 Sun, 13 Oct 2019 21:41:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sun, 13 Oct 2019 21:41:42
 -0700 (PDT)
In-Reply-To: <35cb0bfc-fc91-8555-9725-0c3fc420d93c@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
 <CAL1e-=ioCkAxyjdDvBTeQPMWpUy0W=ej-WiUmZkyTVJYUsd-_A@mail.gmail.com>
 <35cb0bfc-fc91-8555-9725-0c3fc420d93c@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 14 Oct 2019 06:41:42 +0200
Message-ID: <CAL1e-=giZhYZMykWiyZW-x-yj+c_s9akUU-ONHvrvL+NdA4XsA@mail.gmail.com>
Subject: Re: [PULL 00/23] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000006f4900594d77cb8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000006f4900594d77cb8
Content-Type: text/plain; charset="UTF-8"

On Monday, October 14, 2019, Richard Henderson <richard.henderson@linaro.org>
wrote:

> On 10/13/19 4:53 PM, Aleksandar Markovic wrote:
> > Just for the sake of being punctual, may I ask you to add "Tested-by:"
> for Mark
> > Cave-Ayland, and "Reviewed-by:" for myself to all 22 ppc host patches,
> as it
> > was indicated in the responses to the last version of the ppc host
> series?
>
> I did add your r-b to those patches that didn't already have your s-o-b.
>
> I added Mark's T-b to patch 15, which is the one that enables basic
> altivec.
> Mark said that he was testing ppc32 and I know that he's got a G4.  He
> would
> not have tested the later patches with that hardware.
>
>
>
Mark tested the whole series, applied to his test bed. This means that all
patches are tested for a particular setup - for example, among other
things, he established that the patches that are supposed to directly
impact different setups do not cause regressions on his setup.

I responded to the cover letter with "r-b for all patches", and would like
that to be recorded.

Aleksandar


> r~
>

--00000000000006f4900594d77cb8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, October 14, 2019, Richard Henderson &lt;<a href=3D"mailt=
o:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On 10/13/19 4:53 PM, Aleksandar Markovic=
 wrote:<br>
&gt; Just for the sake of being punctual, may I ask you to add &quot;Tested=
-by:&quot; for Mark<br>
&gt; Cave-Ayland, and &quot;Reviewed-by:&quot; for myself to all 22 ppc hos=
t patches, as it<br>
&gt; was indicated in the responses to the last version of the ppc host ser=
ies?<br>
<br>
I did add your r-b to those patches that didn&#39;t already have your s-o-b=
.<br>
<br>
I added Mark&#39;s T-b to patch 15, which is the one that enables basic alt=
ivec.<br>
Mark said that he was testing ppc32 and I know that he&#39;s got a G4.=C2=
=A0 He would<br>
not have tested the later patches with that hardware.<br>
<br>
<br></blockquote><div><br></div><div>Mark tested the whole series, applied =
to his test bed. This means that all patches are tested for a particular se=
tup - for example, among other things, he established that the patches that=
 are supposed to directly impact different setups do not cause regressions =
on his setup.</div><div><br></div><div>I responded to the cover letter with=
 &quot;r-b for all patches&quot;, and would like that to be recorded.</div>=
<div><br></div><div>Aleksandar</div><div>=C2=A0<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
r~<br>
</blockquote>

--00000000000006f4900594d77cb8--

