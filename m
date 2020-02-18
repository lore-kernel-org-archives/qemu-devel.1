Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785DFC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E7F21D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="syrsSzcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E7F21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47aW-0006M9-8h
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j47ZI-0005S2-Pt
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j47ZH-0000hK-Cu
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:26:00 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j47ZH-0000fc-6W
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:25:59 -0500
Received: by mail-ot1-x344.google.com with SMTP id p8so20425289oth.10
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 10:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dcvSQoAsUL9C5Aq1ofm643zj+vq9wM/Vam8GdBtyzPM=;
 b=syrsSzcQKVlBcC4d1Rcsd5/4t0RaqvNT83RQbH0e9qu3biyh4kETK5t9dacw9Ja9yZ
 POl3cMCdmEQb1aN9pMIW2ydt6WPgnA/Lkir/9kPIuGyjch80ZwnIfIXBxS1LOgGGfRgc
 SgNRUsUKZ8EcmYzidpP2h6frvqaS5rnBFDZuxs8bKciLmWbERaht8LLVIRJOvpGsZaMn
 Jod+f4SRzQceLm/np5nDjIodtiGaIyqn9bd2OaSa4KvIxWt5L7BVI+oYyoCyjPz2dQpY
 z3MKisFrgsV0UYsAafJ8FpDPk+yfizX89nOFtGmLM3d1YK7sKzYultaoCWSOfYzbErn4
 bDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dcvSQoAsUL9C5Aq1ofm643zj+vq9wM/Vam8GdBtyzPM=;
 b=rBvRjJdCUkB5eMHMJPEv8upBOp12Su2O8CnnZDmNcirdqgIAbp/XagOjeOTI4wNTa9
 3Nksanhq13onl6FlWdPJBWUNyvoS7Kjh/qcuZR52agi3g8w4/+nMKH6s2va+LayW1ih0
 kjdr/CFF2vM6FdPVvJdHSoyQd3sC9nB5WMBWxPf106R3iI66QY032mzKqdNddnY2c03x
 ZhCz0zqJCzVP+o6jBS10JmFf1PqtxWVAqTPrXgHhbE83jFIV6DcxOdt5Xvo5F094mUJu
 0tok/gDia+S6YU+PctqVnBFd6zuyaSiwrk2zAXIifq0NWdnQ/mcBjRkDVqC/CthoknWf
 H3Bw==
X-Gm-Message-State: APjAAAWqwffq0ooevKfZ5d/2OlGE2n9dyQiWINUqbsjxLAa3+nGI9drS
 NdgQrn4to2CCvf4pXeyTaNUaTE0A60GJbFiliAz0xQ==
X-Google-Smtp-Source: APXvYqzWlBRP4rz5M6OU7lJFZy0ck0ZPyPoXJfqO86Z52x7haqRbJ00VIrh3emh0Y2uYAn3yui+8evGa+a42nNLmGX4=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr15663627otq.97.1582050357188; 
 Tue, 18 Feb 2020 10:25:57 -0800 (PST)
MIME-Version: 1.0
References: <1581686212-9625-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1581686212-9625-3-git-send-email-sai.pavan.boddu@xilinx.com>
 <CAFEAcA9Bs9VuZNstbpF6Q2=MhVDN_HHMnUdwfOJSf7Qm9to2nw@mail.gmail.com>
In-Reply-To: <CAFEAcA9Bs9VuZNstbpF6Q2=MhVDN_HHMnUdwfOJSf7Qm9to2nw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2020 18:25:46 +0000
Message-ID: <CAFEAcA88+k9nhpCsb38qaf3KnrfVKhp_2eVFToGqO+eLGTE7rQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] cpu/a9mpcore: Add num priority bits property
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Anthony Liguori <anthony@codemonkey.ws>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 at 18:16, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 14 Feb 2020 at 13:21, Sai Pavan Boddu
> <sai.pavan.boddu@xilinx.com> wrote:
> >
> > Set number of priority bits property of gic as guided by machine
> > configuration.
> >
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > ---
> >  hw/cpu/a9mpcore.c         | 2 ++
> >  include/hw/cpu/a9mpcore.h | 1 +
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
> > index 1f8bc8a..eb1e752 100644
> > --- a/hw/cpu/a9mpcore.c
> > +++ b/hw/cpu/a9mpcore.c
> > @@ -68,6 +68,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
> >      gicdev = DEVICE(&s->gic);
> >      qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
> >      qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
> > +    qdev_prop_set_uint32(gicdev, "num-prio-bits", s->n_prio_bits);
> >
> >      /* Make the GIC's TZ support match the CPUs. We assume that
> >       * either all the CPUs have TZ, or none do.
> > @@ -167,6 +168,7 @@ static Property a9mp_priv_properties[] = {
> >       * Other boards may differ and should set this property appropriately.
> >       */
> >      DEFINE_PROP_UINT32("num-irq", A9MPPrivState, num_irq, 96),
> > +    DEFINE_PROP_UINT32("num-priority-bits", A9MPPrivState, n_prio_bits, 8),
> >      DEFINE_PROP_END_OF_LIST(),
>
> You should be able to just directly pass through the property
> from the GIC object by calling
>     object_property_add_alias(obj, "num-priority-bits", OBJECT(&s->gic),
>                               "num-priority-bits", &error_abort);
> at the end of a9mp_priv_initfn().

On second thoughts, and having checked the manual:

All A9 CPUs have a GIC with 5 bits of priority. So we should
just set the num-priority-bits on the GIC object in a9mpcore.c,
and not expose it as a property of this container device.

That will be a behaviour change for:
 - exynos4210 boards
 - fsl-imx6 boards
 - highbank
 - realview
 - vexpress
as well as xilinx, but it is a bug fix, and I have enough test
images for those to check it doesn't completely break them.
So we should just go ahead and implement them correctly.

Similarly, the 11MPCore GIC always has 4 bits of priority,
so we could get the behaviour right for the 'realview-eb-mpcore'
board too.

thanks
-- PMM

