Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3076EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF558217D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Udze8tA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF558217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i56SD-0004mv-3j
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 06:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i56RB-0004AV-Kf
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i56RA-0007t9-Ls
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:53:25 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i56RA-0007r9-EG
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:53:24 -0400
Received: by mail-oi1-x243.google.com with SMTP id 7so4213070oip.5
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 03:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kQkkXusMshIf1V0FOllRy7ZCPcfh/TZbTKGIHoNaEr8=;
 b=Udze8tA+7KlCxwIElf0jBkNngRal1P9HWoSfep2oqL+nZq6QtrSvmAVjBi7MCkZObx
 LeUt71pZWwe40bPQ7EUrUJFUdo7gmqGEGCKjVtBVmvB8oFHDqoCSzZZtoKpkJJwVG5ge
 Yt8dEZuLrPgcvbB2+llHzlBnSNTOrAIlybyKF2c7dkdIdnStC+b4vrvlXJhiDSNwcJdL
 T6NqDmZay9oUY1OHY+JODm5YupZTIf7EspvxPRk3AgKxgcRkS/aP7SizdATnVYSEo/P0
 GVqV2YmcCymonFsBt+pxGuHjJVyb39JyKc/D6e0eBCI15ZPPUJ8LZZ4/X6NyCM/KeiV1
 tvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kQkkXusMshIf1V0FOllRy7ZCPcfh/TZbTKGIHoNaEr8=;
 b=YHfJfXpiDoi/nMc/e9i4lvoosz/kRm2RVzVJU/AjRh8o0dZU0JpbnK+2ndNlV+n+Ey
 Pr/P1CClWX0oTnZtrJBft67Gvc/aOkNq5gEuUUrVeL/py6Ea9sh6BVSCsy9zED+b1VYC
 8vTA+GEMF8oY0EKktOkR+lQZWN3cJngmoiSn2aH7YhpbI1ihfAKIUk59mA0wa+IVeM8G
 R2/1Q932AZlleTsI0zT8E5wVQ4z34ytDGktGHm89nMROoorkRlw0uZQBYSnKXfTU/vWZ
 FPnYikWjThxbUz07ItG9TgSfJkfQqz2jNVvx0RfTuyY3qGDqr+AF4uNanfEDAjOMKnLt
 QVZg==
X-Gm-Message-State: APjAAAVtwrrryZnGi5KwsioRzreKt0kGfivGrRDk0oTk2LOwJMjr7Izs
 IYWgKbDB5K9RQ65aJUcv0tQPDheLXa3RMmPxp1Q26g==
X-Google-Smtp-Source: APXvYqzXjivHTSOriQV7+khW3lVP7ipR+L7NHHmhwJpqHLQwISricEzKl+l53QBuwhEZIOydUv77CgTNoOuPucC8llY=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr10049743oib.48.1567508003417; 
 Tue, 03 Sep 2019 03:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190828190456.30315-1-richard.henderson@linaro.org>
 <20190828190456.30315-23-richard.henderson@linaro.org>
In-Reply-To: <20190828190456.30315-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 11:53:12 +0100
Message-ID: <CAFEAcA-jpR6+zD1EMTL9W92w8Cuf+jfwcxYcJX2S2xQyacd=ww@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v3 22/69] target/arm: Diagnose
 UNPREDICTABLE ldrex/strex cases
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

On Wed, 28 Aug 2019 at 20:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

