Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77275C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 400B321897
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jWIGl7oO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400B321897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i18Yi-0007MJ-93
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i18Vi-0005pW-4F
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i18Vh-0001LO-5B
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:17:41 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i18Vg-0001L6-Vi
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:17:41 -0400
Received: by mail-oi1-x241.google.com with SMTP id a127so6847812oii.2
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 05:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EDFjzMZB/tEMJxBQIka91gbQDjgWB8klAFTgQcdJ79Q=;
 b=jWIGl7oO1PMZl4HSFH0gBeuHm877eiqxDNiRFqUPsoBxBhZXKGz0H1//JtUOhFrWAK
 TwtF/FjuDTZ4XlsTz8oOw2KKyA8UETbVGXCb8gRdMeAA6EgYK+650IKuGwg61SvY2eMo
 Gd4RsOufpLmJzebPngBOvKNorPaQc0jpCdHZG83lfb0aCgx4mjvUI8Qz2cj349/p+oWz
 L+whuZNIfeWjULrjkXKvb0q/olR5+xlIIhPbZi155h1IU617+nBI8tWC1eemIq0+KPSy
 6GgkInjjbDfbGhfGVfO//TuTUZkXRhD5hKCxyECSvsxImOH1GebgUJ+50d3uYq+W7uUH
 0oeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EDFjzMZB/tEMJxBQIka91gbQDjgWB8klAFTgQcdJ79Q=;
 b=jloQpYsET071eJdT+zLz1L4GgxC0vBafW6DSrv/mXrztkqLf0H/YOqJfBPiiCGjnYw
 +gHNvIaakF6JhTdo4ZX0/gTZxmIHaMSVRHaNCjZCAdyQtseqb7HkOHYSINdrBmInqY66
 z5n64ITUTwPRtWDkbR4ncN+a9COOaTDWClljB7AO1pJw3OWLSyQmUZ0qLJoJkKmFl+ez
 gLk7vjJXmwOcCq7OfbXM60MBYoBiUeOOyR7t/is+ul0RACrxMuwghbeHVVIGeH6LcFdq
 2+fnO0x+GfGpeB76CNJfZfux2oxOpHt81QyZ82vWeTAWHp/ttWqJYXtWxKbcTtAKpsve
 D1kQ==
X-Gm-Message-State: APjAAAXq7HkrW0DXb6F+OZep0LXBV9JyH76HE+nuSHreg9XOM92ub9Cf
 orf0RKf1enFIu5hb1rL5LB7+G96tkp9W5YQmiBHJNQ==
X-Google-Smtp-Source: APXvYqyhwYOvYIZNRcwulZ0j0xApH7RCyC16sAO4cxqQd49+qMIxqWxoWDVQRb3/C2rr1K2rAS/i+u1JEp4MTMf3cn0=
X-Received: by 2002:aca:4b86:: with SMTP id y128mr2894127oia.163.1566562660102; 
 Fri, 23 Aug 2019 05:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-5-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 13:17:29 +0100
Message-ID: <CAFEAcA9bSxhjjY-98SoT=buAsji1oc_-dg2WEnkfu-MZV6YN_g@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2 04/68] target/arm: Convert Data
 Processing (reg-shifted-reg)
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Convert the register shifted by register form of the data
> processing insns.  For A32, we cannot yet remove any code
> because the legacy decoder intertwines the immediate form.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 74 ++++++++++++++++++++++++++++++------------
>  target/arm/a32.decode  | 27 +++++++++++++++
>  target/arm/t32.decode  |  6 ++++
>  3 files changed, 87 insertions(+), 20 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

