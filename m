Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DDAC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F6120717
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rCz5RPUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F6120717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv1aE-0005xN-06
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 11:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37660)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hv1Zr-0005X5-Fj
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hv1Zq-0005Zx-Fr
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:40:43 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hv1Zq-0005Z5-7g
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:40:42 -0400
Received: by mail-ot1-x342.google.com with SMTP id s20so28073469otp.4
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jfQOhy9tyjQodoao6X5BDljOC/gwr4xUFrZ1REAYnJg=;
 b=rCz5RPUgwlrvPpgXeqCVlrGMGyBwJdkBWyhk77k2kRx3nDzQwYsWoure2R5FIBFng7
 ktzaeTnLmU7UCB/JbGvILeldwmRkv2S2ejqG2TNQ1ryek6Pm28Lck8E2wRFr7H0wgY5z
 F7sAefP8xCFJ8URAR5EFpJ+JxOQkwKv5sYQhr4tQSyhjAxjS1TB4yMg1cBhTK0DXw2ke
 8SXZiWbTIF2LzuOpQnTDqcIZYuWEqGHPcDA72mVHZD/ECXKMsBQO8eZ99hCIvsXQufqJ
 Ha+N/LQDVO6FPHL/hhgtqEHDHsJDQWHtpbcDLXQAEbuHqGp76wDfuleVUBVw71JX1i0q
 s57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jfQOhy9tyjQodoao6X5BDljOC/gwr4xUFrZ1REAYnJg=;
 b=H3S0FywzlrWCT/yPT+X7iAT+ctv3FYpUoHmQNaidrKmsOpMORUs/4dBcU93CkqP8Xo
 zAZGk2kGUH8vNBC2QJ5Ygb2Y/0fxVOpeQ7om4xJyultlWcNt3E201KZbl/B4/Dyanqgj
 9EHzwa/3BJBDT9uWAHpQZatybFtSL/9lY3pPoXLs8UB6Q3PgMKnEK8ga7gf+0DGmNx87
 cjq4YzKv2u9wFDVzVduL4ENEvpSRkFDkI1Bqul3wbpC4Ij1oMvAo+2lQy7hG36u6E0Lx
 V/wCM5z05n+zkTEJjTmOrOkUnr6IDahf6f7FE1ZwGW40XZYO/R7U5reNHzC/HF6Zksc2
 OUgA==
X-Gm-Message-State: APjAAAVtyq/XUEbbuXbQr8q9GM3v2t3LFs8F33vtyKXJ3epKUyeLCr9u
 tnpgaTjsks5Wx2Op4TxpAwfAS4nXYXJRo7IQ4qzyig==
X-Google-Smtp-Source: APXvYqwKl6/Mn1asS0ya6HjYK4RbmIl5gMdNU8Jyu2IWAHubuajnjUccpiokyi2KsV76m+D43sA7xDEsjDC256ga+qE=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr3362733otk.221.1565106041045; 
 Tue, 06 Aug 2019 08:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190806115819.16026-1-cohuck@redhat.com>
 <20190806133952.vcgjaz6zx27b25u6@sirius.home.kraxel.org>
 <CAFEAcA-w0YEhnfu-eJuQx-Kb5s7ESwKkYqUs40+arnZxABoXQQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-w0YEhnfu-eJuQx-Kb5s7ESwKkYqUs40+arnZxABoXQQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Aug 2019 16:40:30 +0100
Message-ID: <CAFEAcA-s4XZ8QmDkA=FT6JMR_akXURtuPtbBijFogYM8z9xqpA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH for-4.1?] compat: disable edid on
 virtio-gpu base device
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 6 Aug 2019 at 14:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 6 Aug 2019 at 14:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Tue, Aug 06, 2019 at 01:58:19PM +0200, Cornelia Huck wrote:
> > > 'edid' is a property of the virtio-gpu base device, so turning
> > > it off on virtio-gpu-pci is not enough (it misses -ccw). Turn
> > > it off on the base device instead.
> > >
> > > Fixes: 0a71966253c8 ("edid: flip the default to enabled")
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >
> > Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> >
> > > Only just noticed this... should we still shove this into 4.1?
> > > Or do we need a compat 4.1.1 dance for this?
> >
> > I'd say 4.1, doing it in 4.1.1 becomes too messy.
> >
> > Peter, can you apply this directly, or do you want
> > a single-patch-pull-req instead?
>
> If you're happy for it to go in I'll just apply it directly.

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

