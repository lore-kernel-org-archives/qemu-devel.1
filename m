Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54A8C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C3420409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmPKpe3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C3420409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtQ8-0006Qk-Nq
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDrgY-00073z-Q0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDrgX-0005hJ-8P
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:29:46 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDrgX-0005bl-1H
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:29:45 -0400
Received: by mail-oi1-x241.google.com with SMTP id d63so18203341oig.6
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 08:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rsVvqa9kEBpaKYZwDI4QbsyQDuz5Bpb4wRRnlFykK3s=;
 b=mmPKpe3n56L2g4uIGTLOtiSJQYdsR0TIeCxf+6NR+pt5GoOdUZNY7lyjJsEiKv492d
 V7TISmbc08dRhSG52rkr0yONJiP9T9RbXz5kcb3ciGE7YFiKPav3FMDGPGIzNUscjLfQ
 /rzpAfHeY8JQ9R+ZzIHWyP7uZjxnsiOw9xxjtoRceQR5YBN0qQRGHepm5JjspSg6jrmJ
 pDRoXjOXY8IZioJtJo49DVY5JyTRvZ+aoC17QqQdqBaVHahfoa4dnVLcd8m4PPxXXNCC
 Wmm78saSIZ2u45hgwzm//cpgYuejLAVYVE454ejEvcVjP557GW3QzxjVRwflEW0J5ENC
 yvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rsVvqa9kEBpaKYZwDI4QbsyQDuz5Bpb4wRRnlFykK3s=;
 b=C4mTyLrAZ66YKdCXa7yNDDve9Q6QtjdNcC1FJum175mqpqtVm1wMBXVu11yr7mf2Wr
 ExztR5dA58dxe+QN6VL7SVIzFqVGWCGF7rfOu0q2JMqDFYp328+M8FpNJOp4lxaZQOar
 l5mYPsEHo+LcAwCFFuwwT+SiZEShw2bo3dUW8gaHJ2cBhPRquiSLNyBt2RzVRrsrGrp5
 xOApC8MDR9Huu6IoAy5tNUmlM3jVkAw/4NM3EQLc34HoLzUO7w6N/MSrKx/KHrw9cjg+
 ci+LsfbHQiO0jxirrpsnrZ6N1+uZkRxJHLIQdq8Cm5O2WgVENpSYaLs05JPSiTIYEGjV
 uUWQ==
X-Gm-Message-State: ANhLgQ3iNNCPIbz2eAGEQP+fAzE0oXd8qAxTQqDpO3HgXKNEa4T9sp6A
 ZqmMS6R4bC4LOSpARqREzcwPfIGLR1jAn+sq6sNkTQ==
X-Google-Smtp-Source: ADFU+vudkVK0M/uAPnYJDlOHWPraZqZ0UQWV118awdmYO6keNOvne+jOV0Dt4OnlWy/L2087t0pogRELesQOzBZBfc8=
X-Received: by 2002:aca:c695:: with SMTP id w143mr93974oif.98.1584372583847;
 Mon, 16 Mar 2020 08:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200206183219.3756-1-linux@roeck-us.net>
 <488b3355-4467-e01e-d6a0-a2d5bc959428@kaod.org>
 <5589b5ce-1ff3-bf1e-ceae-fe82e1e1265c@kaod.org>
 <CAFEAcA_Zg65ebyTH+7i8ZGf4jzmf1tRPYdVz590UP0rQoz86pg@mail.gmail.com>
 <a6af95d9-f95c-f9fc-eac0-60d9c8517dec@kaod.org>
In-Reply-To: <a6af95d9-f95c-f9fc-eac0-60d9c8517dec@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 15:29:32 +0000
Message-ID: <CAFEAcA--vBbg835-AOm1xhnz1R_ic7Xz3SjWoerkSEwq1+Hsqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] m25p80: Convert to support tracing
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 at 15:11, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 3/16/20 3:58 PM, Peter Maydell wrote:
> > On Mon, 16 Mar 2020 at 14:14, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
> >>
> >> Hello,
> >>
> >> On 2/17/20 4:47 PM, C=C3=A9dric Le Goater wrote:
> >>> Hello all,
> >>>
> >>> On 2/6/20 7:32 PM, Guenter Roeck wrote:
> >>>> While at it, add some trace messages to help debug problems
> >>>> seen when running the latest Linux kernel.
> >>>
> >>> Through which tree do you think it is best to merge this patchset ?
> >>> block or arm ?
> >>
> >> It would be nice to have these 4 patches for 5.0. All are reviewed and
> >> tested.
> >
> > Do you have a pointer to the cover letter? Not sure
> > which platforms (and so which tree) they're aiming for...
>
> Not having a cover letter clearly doesn't help ...
>
> Here is the patchset diffstat :
>
>  block/m25p80.c     |   58 ++++++++++++++++++++++++++++------------------=
-------
>  block/trace-events |   16 ++++++++++++++
>  ssi/aspeed_smc.c   |    2 -
>  3 files changed, 48 insertions(+), 28 deletions(-)
>
> http://patchwork.ozlabs.org/patch/1234532/
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> http://patchwork.ozlabs.org/patch/1234533/
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> http://patchwork.ozlabs.org/patch/1234535/
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> http://patchwork.ozlabs.org/patch/1234536/
> Fixes: f95c4bffdc4c ("aspeed/smc: snoop SPI transfers to fake dummy cycle=
s")
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks for rounding up the patchwork links; applied all
4 to target-arm.next.

-- PMM

