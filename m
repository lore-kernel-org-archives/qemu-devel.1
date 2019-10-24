Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C29DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4679C2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xqZp6AVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4679C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdjV-0006ZO-Hr
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNdUv-0007YW-DR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNdUt-0000MQ-S1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:49:52 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNdUt-0000MB-Jz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:49:51 -0400
Received: by mail-ot1-x343.google.com with SMTP id z20so2049210otk.10
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ooq7dmnoQZtK8JLOj0nV7TogF6dsbmHh45dAnnb9lFM=;
 b=xqZp6AVygjUS+fLnDwZgV0rNwHygjKB0AVtyfOav+XZTbD8ZjMGAshzqTijQAdnM4P
 oqowkWWEuFnbf+8xvh1suLDt/O7EDOjUrLXATOzZSAxsTOZCQX+FzIySbF7jJf4fWRAg
 cV9TJttna/8HGY5DqA4khngD0ze72KTPTe7T23EBU+6uqrr/mUQohznAUq4sC4qE+4nz
 SJd1U5hdzu6V3pqw/VrtQAuREXihKL8X6zWQFbN5VsPOPJ+rzKY7E9rlixCr01NsTmMX
 cjwqlEJ2Tj9jEQWN6c5Ik1oS8nJYdNW7t01aDluQ5/DnILyqWwDi5KCQ49uNDNXpaLWB
 gr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ooq7dmnoQZtK8JLOj0nV7TogF6dsbmHh45dAnnb9lFM=;
 b=gEf9TEpq5aUr/xIa2KVMe5YphAPXAVN/MzxsFlV4IEHHKz4X/cInlyQ2Yf/asNRbQM
 S779/Y0Xfrh89mjaFcCfNlSSPWaPybBANyCh9T4NYnbyjvNNkEGarXxs+nhe7t7RZH4k
 x3zQC0hXXO76Gb9LksxnhO5w40isS4wkCB5/o2hZEBAix55D7YhfJcgkEQ8Gkm1WdNXe
 qqUXBGwOdUtRhAUMpEgWhRUHi0EW3Z8kRngHG7frbTwbwxKCJtggcJx7p6ydNHGeWu0U
 WP2Lwlrhz+jUFv17/eCIlce7YCSFeKiLuUgNMHWIlzlHj5APbJzPEU324BNsCGI9HsnX
 PdNw==
X-Gm-Message-State: APjAAAXPY1nzEOmAXqDEaLRAw/AEU3EfqLx/3PjZYtJ+ijD80X/zEO61
 7RRE+KLZLDuxIQIDE9M4wApaymmO0DJANY7IW0xSHw==
X-Google-Smtp-Source: APXvYqwzf76lClbs5Ms5b+ntxQWC5jjtMJRUX7RK8HcXHI8cxGUPYd28KblCZ9wDFxKm/YdTWy/qa3rxudFJexKEyjI=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr11906940otj.135.1571924990613; 
 Thu, 24 Oct 2019 06:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191019234715.25750-1-f4bug@amsat.org>
 <CAFEAcA_WTyJ2AWZfKQSipFmn46ztG1XTL9sE9P2QDD7ob-FKFg@mail.gmail.com>
 <1ad1b559-13c4-ed2c-f82b-e6a516219e57@amsat.org>
In-Reply-To: <1ad1b559-13c4-ed2c-f82b-e6a516219e57@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2019 14:49:39 +0100
Message-ID: <CAFEAcA8Zst6XbPWiAat=z1s7HBzEMscsP=ibrPxP75kHXjZ3Kw@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] hw/arm/raspi: Add thermal/timer, improve address
 space, run U-boot
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Rob Herring <robh@kernel.org>, Matthias Brugger <mbrugger@suse.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Oct 2019 at 14:46, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> On 10/24/19 3:42 PM, Peter Maydell wrote:
> > On Sun, 20 Oct 2019 at 00:47, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> >>
> >> Since v2:
> >> - fixed issue in videocore address space
> >> - allow to start with some cores OFF (to boot firmwares)
> >> - add proof-of-concept test for '-smp cores=3D1' and U-boot
> >> - fixed my email setup
> >>
> >> Previous cover:
> >>
> >> Hi,
> >>
> >> Some patches from v1 are already merged. This v2 addresses the
> >> review comment from v1, and add patches to clean the memory
> >> space when using multiple cores.
> >>
> >> Laurent, if you test U-Boot with this patchset again, do you mind
> >> replying with a "Tested-by:" tag?
> >>
> >> The next patchset is probably about the interrupt controller blocks,
> >> then will come another one about the MBox/Properties.
> >>
> >> The last patch is unrelated to the series, but since I cleaned this
> >> for the raspi and the highbank is the only board with the same issue,
> >> I included the patch in this series.
> >
> > I'm going to apply 1-10 and 14 to target-arm.next.
> > (I've reviewed 10, and the rest have been reviewed.)
>
> Thanks!
>
> Do you mind amending this to patch #3
> "hw/timer/bcm2835: Add the BCM2835 SYS_timer"
> or should I respin (or resend it alone)?
>
> -- >8 --
> diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
> index 49b40b55f9..3387a6214a 100644
> --- a/hw/timer/bcm2835_systmr.c
> +++ b/hw/timer/bcm2835_systmr.c
> @@ -115,10 +115,7 @@ static void bcm2835_systmr_reset(DeviceState *dev)
>   {
>       BCM2835SystemTimerState *s =3D BCM2835_SYSTIMER(dev);
>
> -    s->reg.status =3D 0;
> -    for (size_t i =3D 0; i < ARRAY_SIZE(s->reg.compare); i++) {
> -        s->reg.compare[i] =3D 0;
> -    }
> +    memset(&s->reg, 0, sizeof(s->reg));
>   }
>

Sure, I'll just squash that in.

-- PMM

