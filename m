Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE903C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FF521897
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X8LthGAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FF521897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i18Nr-0000OB-Ut
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i18MA-0007rp-D9
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i18M9-0004nE-A1
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:07:50 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i18M9-0004ms-4o
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:07:49 -0400
Received: by mail-oi1-x241.google.com with SMTP id o6so6793652oic.9
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 05:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y2zP5Hql75VDGYtYiSdiDiP7qqnmBl0T25A2qJRa3NM=;
 b=X8LthGAAqQK7Ar8ayAlkwaCMLxRZbuG/p2cZfCmoG2sQuLjK6i+9CwThZWsxDhvpRw
 GCseo+wbljDRSm1omN/aIriPAQgig1TLGpwBM8xeFRcpVOh5Xfi550y/uhC1PpoKpMWQ
 dzeTOfyEdjvXKmIyvvGaX+iYEDmh7Cjtg6SYdA2LWaCbyJoX5hMC7r33N4uRQOpxX5U9
 dU1U9A4GlFoAzcJ9aG4HJOqp23zSLzwNoTkGLh/CQmjP7xPVrJKsqBS9LiIaquvEF+6d
 mA2oeOMkRj2CIruTAbSayeMAdY5dOsv26mFxQGxGO8PbafEoVblbMIALU5arEKJu/OfL
 0GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y2zP5Hql75VDGYtYiSdiDiP7qqnmBl0T25A2qJRa3NM=;
 b=oWrGeWqhCzndcdgFL+1Rjls/udracr0gqqwR3cg6ztHOgwx53xgRiPBm/+GBC2pCFE
 UvxtpU7opzlRYdzAxvXR7clV7TOCsyZfM8O+lKqE2dsusYUiM7L2ULFZRfZx4edYvgYr
 gCJ5awTbg5MEcqi35z9ho+Gek+0fa/U4DsHJRbQTny0lW5EeJDy5ZIe7NFkC3BygTKEe
 pUnYFQgjHcS2b98xhJy7SxQaLYk5Roydigs2kC7QsZ8V0sJ2HMq2HX9q3PAGBpGRDynN
 b81RuqV4s4ZQXL4twWjuPSBUzpNpJ3yTnCtcbsZRr61TCJ3ytONoTvO/3HkUKzozEjSx
 14+g==
X-Gm-Message-State: APjAAAUrzT+uGhSeRHg5ht5kPpRgvG/zKVO0zXCaCXpMeWdo6i1hQjIk
 8sYtrN81Hku+8j9MbMivFlMMUfqJZZ36A0FY6/8Azw==
X-Google-Smtp-Source: APXvYqwU2vrUosGhrxqWqf3LQqavvSUoWyDcSiedzAjWysOZGQ/tki3sr0sss83g5nGL9VO4zgd/MwBIrJyChZ4ev20=
X-Received: by 2002:aca:4a57:: with SMTP id x84mr2906252oia.170.1566562068170; 
 Fri, 23 Aug 2019 05:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <1566495734-23297-1-git-send-email-pbonzini@redhat.com>
 <9492af41-2125-9543-203a-312f0cd9087c@redhat.com>
 <CAFEAcA__BNnW4oSyv4iTAd7rsMUfcjyNJgk0nOwbkRQtmLj9jQ@mail.gmail.com>
 <dd473e9b-716d-cd9f-47bd-433d2b17687d@redhat.com>
In-Reply-To: <dd473e9b-716d-cd9f-47bd-433d2b17687d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 13:07:37 +0100
Message-ID: <CAFEAcA81qUSMqpMTCrs9-vgj7Wmji2dCDkYrQ91wxmhTiP83Xw@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH] modules-test: fix const cast
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 at 13:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 23/08/19 11:11, Peter Maydell wrote:
> > On Fri, 23 Aug 2019 at 10:06, Thomas Huth <thuth@redhat.com> wrote:
> >>
> >> On 8/22/19 7:42 PM, Paolo Bonzini wrote:
> >>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >>> ---
> >>>  tests/modules-test.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tests/modules-test.c b/tests/modules-test.c
> >>> index 3aef0e5..a8118e9 100644
> >>> --- a/tests/modules-test.c
> >>> +++ b/tests/modules-test.c
> >>> @@ -4,7 +4,7 @@
> >>>  static void test_modules_load(const void *data)
> >>>  {
> >>>      QTestState *qts;
> >>> -    const char **args = data;
> >>> +    const char **args = (const char **)data;
> >>>
> >>>      qts = qtest_init(NULL);
> >>>      qtest_module_load(qts, args[0], args[1]);
> >>
> >> Why did nobody notice this before? ... some additional words in the
> >> patch description would be fine.
> >
> > It got into the tree because I don't have an --enable-modules
> > config in my set of things I run before merging. It's in
> > the Travis build set, but that only runs after the fact.
>
> Are you going to apply this and "[PATCH] modules-test: ui-spice-app is
> not built as module" to qemu.git directly?

Is the other one also needed as a build fix ?

I was planning to apply this one directly, yes, but I was
waiting to see if you and Thomas wanted to agree any change
to the commit message.

thanks
-- PMM

