Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41064C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8EA21569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="etzYxfvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8EA21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itsAO-0001Aa-8e
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 06:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1its9b-0000jT-AW
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1its9a-0000Kf-6k
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:57:07 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41553)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1its9Z-0000IJ-DL
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:57:06 -0500
Received: by mail-oi1-x244.google.com with SMTP id i1so2258889oie.8
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 03:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V/QsjLnaDB4M6GUK7FuuwKCz4jRenqKFOGI5qHA7F64=;
 b=etzYxfvfpMnKjJvl/bhe+GKUsHoDhPsN7CGJKreW7lbgwdcQiS8N2u+LzwpboW89jU
 tqXMyURGV8QCkmdsorqZoOzz7wjYgCBX34HG4ihsC2AYegc8is5b7mR5TwWEDQMc+d1a
 KGenbJ/In/7GPwT46rC8wMcI1YVYIkCk9HntTiszKgk0X0ySaRnL/scZwmKg12zjz96D
 V/iEvQa7T6prFfTuzQA2Cmrc6G4chhnOuyNV2cRb4jEV+gzoxwe28XHDaHmK9cmtXO8C
 RJjyv86TLNejiKIXhKGvPjhFlTSfGARU3IBhQFxkxfRQ0HadGlKnY4a1+xS21G/v0JvV
 FY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V/QsjLnaDB4M6GUK7FuuwKCz4jRenqKFOGI5qHA7F64=;
 b=RVxP102YzBHKndo3uT75Bmi70sHbWYxu807eDp2auHBPuxawWb0b+lsA6YwTyyIMyz
 kVjbtSwckQyurTjyoIyp/NI8sEAdbA6oDFIvTprgXkwJmUsh0966pb7yATyisht9//hm
 hhNfs28o2+bwxIdQ7RKwU78qME6oW/OT07INKHkwaRuXGhkOjlkCJ51A13KzEDUIRNR2
 NH31DLUZmc7fTxOD0J0JUmpkOtqOJbcqdR6VvhSqRpWPeda/s8psEcNC8ab1sHU70R49
 Gb7Mls+QuOsdt5UDcZBERSqAkZqNF6vnFt1ME1OGO9ufyhGMGmmf2yFHSNuEAElESMaj
 4H4g==
X-Gm-Message-State: APjAAAVipj0unEuWWUGpiN+/rK6AR3TxamOytvjrjxFwIW329vmaJTxB
 hMqMzCpnpX3s0sA0bUsyoL/sJbE2MSaywZSSNbZAOP6DdDE=
X-Google-Smtp-Source: APXvYqwbu6N9KhrB9DtNsDqiS7xUi1PwK1sGlTQeM/kGofXl9g1zL5/kHRlC8jOAAGGflxLKC3V7NLGG1BLcHNCkhy4=
X-Received: by 2002:aca:3182:: with SMTP id x124mr2715473oix.170.1579607824388; 
 Tue, 21 Jan 2020 03:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20200120163400.603449-1-stefanha@redhat.com>
 <20200121110637.4pzkxbyepgozk4q3@lws.brq.redhat.com>
In-Reply-To: <20200121110637.4pzkxbyepgozk4q3@lws.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jan 2020 11:56:53 +0000
Message-ID: <CAFEAcA9b9CRH8Z0K5PvTBWN7Cp=0_LLGfqC3CkxN16OEPCnVLQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: add missing mkdir MANUAL_BUILDDIR
To: Miroslav Rezanina <mrezanin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jan 2020 at 11:06, Miroslav Rezanina <mrezanin@redhat.com> wrote:
>
> On Mon, Jan 20, 2020 at 04:34:00PM +0000, Stefan Hajnoczi wrote:
> > The MANUAL_BUILDDIR directory is automatically created by sphinx-build
> > for the other targets.  The index.html target does not use sphinx-build
> > so we must manually create the directory to avoid the following error:
> >
> >   GEN     docs/built/index.html
> >   /bin/sh: docs/built/index.html: No such file or directory
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Makefile b/Makefile
> > index afa5cb6548..6562b0dc97 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1022,6 +1022,7 @@ $(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
> >       $(call build-manual,interop,man)
> >
> >  $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version.h
> > +     @mkdir -p "$(MANUAL_BUILDDIR)"
> >       $(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
> >               "GEN","$@")
> >
> > --
> > 2.24.1
> >
>
> Fixing our issues with build,
>
> Reviewed-by: Miroslav Rezanina <mrezanin@redhat.com>

Thanks; applied to master as a build-fix.

-- PMM

