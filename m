Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05F9C35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3F021556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJWGuqcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3F021556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6XKI-0006Jl-69
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6XJ2-0004QV-6o
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6XJ0-0002lx-Te
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:19:11 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6XJ0-0002lW-OK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:19:10 -0500
Received: by mail-oi1-x243.google.com with SMTP id b18so12049859oie.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 02:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TdkyP/waG7yMrG/55LzQ/BCApLNTU/cpSkgd5WpaZ5s=;
 b=aJWGuqcsByu/PctTrI4xgpYxuFAB4bA2DPvEp3HYGzFo5ooSb3oYOA9ZD3ooOz8jTZ
 Y0fCOWTOpLCQwEx6se80O62AQIFRkGDPjvvupqwQ/rz59l9S4EKjaJJE15ywIBHDcEyn
 ZuTStkywfr+S7igr9M8vyOiyfiEzwtS9FQY7mm3gvJvwJoQf3j9LWJCtn7YQVwteQAm6
 tf49t02Hsdr8klM5iUQPvGSGOpa6EMJRKiqS8X6GrlFdAvy7tA3SfcXcTv4fFw7kzgBG
 4itfHuaO9EDGCfMZuOafXebRWkDoQJiVwT53U8JHN0kfXuxk2gLA0qZEN4zZY5FXfWSK
 f+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TdkyP/waG7yMrG/55LzQ/BCApLNTU/cpSkgd5WpaZ5s=;
 b=V6CmnPtnPNjmPcdOSEKdy1ekT9PhARXJeHuT5GRcaONeR/adHT9OIx9FrftKCPKVSy
 5CjVHQDnccmvRegj6l8DsFFA2Qrv00wJ6z5cljfHD3BCd2/eMeO8rWTCgilaNBAaQUhU
 CXLr7mo5y7t7AwwOhwKUyS5uFHvW+vPbaK6R1ZAW0SW4Wv+1Jf/HxFm421UnMDCpiSC5
 K7Io4THZlW9GgA2OeMEcg2JizU6WV2Z1+jymWdOHEFWROouiQuTKasA5RTIwgr7JVH5y
 LSoF5CkRafoosqzjgugSjFj9VEkJjcSQoZFazPf2vqjnRxcTRGSJSlgKxYqo+VOWq11r
 DV7Q==
X-Gm-Message-State: APjAAAWJ8rNGwU53G2RVWe53l5kY44k3C1UAsdSmRh+i9h7mSOm4cGhG
 JMM/t52oSZDxvABtGPPCKLKBQuplw509sqvU29SbqA==
X-Google-Smtp-Source: APXvYqwgO0aXqWFccuXt5YmWKmc41+jx8r1lIOxjxHtWt1MJgvvcFotRzD5SJ35lz+QWcUVfX/bl1EKJY6LGAfDm0zo=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr3029042oiy.170.1582625949753; 
 Tue, 25 Feb 2020 02:19:09 -0800 (PST)
MIME-Version: 1.0
References: <20200225025923.19328-1-kuhn.chenqun@huawei.com>
 <9206dda7-0e12-b68e-87ca-1985b61381bc@redhat.com>
In-Reply-To: <9206dda7-0e12-b68e-87ca-1985b61381bc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 10:18:58 +0000
Message-ID: <CAFEAcA-W+brVEmGr29i6JO4GFrnoLAce-qoMQpQc56x6B4BY3A@mail.gmail.com>
Subject: Re: [PATCH] hw/net/imx_fec: write TGSR and TCSR3 in imx_enet_write()
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 05:41, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/2/25 =E4=B8=8A=E5=8D=8810:59, Chen Qun wrote:
> > The current code causes clang static code analyzer generate warning:
> > hw/net/imx_fec.c:858:9: warning: Value stored to 'value' is never read
> >          value =3D value & 0x0000000f;
> >          ^       ~~~~~~~~~~~~~~~~~~
> > hw/net/imx_fec.c:864:9: warning: Value stored to 'value' is never read
> >          value =3D value & 0x000000fd;
> >          ^       ~~~~~~~~~~~~~~~~~~
> >
> > According to the definition of the function, the two =E2=80=9Cvalue=E2=
=80=9D assignments
> >   should be written to registers.
> >
> > Reported-by: Euler Robot <euler.robot@huawei.com>
> > Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> > ---
> > I'm not sure if this modification is correct, just from the function
> >   definition, it is correct.
> > ---
> >   hw/net/imx_fec.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> > index 6a124a154a..92f6215712 100644
> > --- a/hw/net/imx_fec.c
> > +++ b/hw/net/imx_fec.c
> > @@ -855,13 +855,13 @@ static void imx_enet_write(IMXFECState *s, uint32=
_t index, uint32_t value)
> >           break;
> >       case ENET_TGSR:
> >           /* implement clear timer flag */
> > -        value =3D value & 0x0000000f;
> > +        s->regs[index] =3D value & 0x0000000f;
> >           break;

Hi; the datasheet for this SoC says that these bits
of the register are write-1-to-clear, so while this
is definitely a bug I don't think this is the right fix.

> >       case ENET_TCSR0:
> >       case ENET_TCSR1:
> >       case ENET_TCSR2:
> >       case ENET_TCSR3:
> > -        value =3D value & 0x000000fd;
> > +        s->regs[index] =3D value & 0x000000fd;
> >           break;

Here bit 7 is write-1-to-clear, though bits 0 and
2..5 are simple write-the-value.

> >       case ENET_TCCR0:
> >       case ENET_TCCR1:
>
>
> Applied.

Could you drop this from your queue, please?

thanks
-- PMM

