Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A458DC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3022073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBK656vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3022073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Apq-0008GF-Jq
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5Anj-0004qR-QX
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5Anh-0004bl-GS
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:05:15 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38275)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5Ang-0004XY-HV
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:05:12 -0500
Received: by mail-ot1-x341.google.com with SMTP id z9so2440865oth.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DvQiWBPQDQl6ZN8unjHshGja3SyKA0iVBsQImelp2UU=;
 b=WBK656vy9HcydMcExzWyZItxQxtf/cAPa2GrIJs9h3U8f+ilogJzt19XPvZ+glXtzB
 NAWgRI1ZQx2dJdrwVYQelhEy2iBCUeKfx+tYKtjxfYMm0gkqjOhKsA7eAFjqCvuUvWrL
 s1NdxbQaH8XPhizaxmvO0PVfKt+Kxj0IpjEbAQf1b40YBp1mrWTr++J0/Rl68cis4eWR
 aA9FDGzl/IzA0hmk8+ETTJ5aENreSbCPN7rBqRMHUCjTcZnHG9bIClRBcONrulmdfp6J
 QHnlC0UoRfHFSyM3A0fBq2XIH8PvRp8HfzFD3ntMX8fPGYGGtNBnazc8OS/oO8s9RSub
 m0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DvQiWBPQDQl6ZN8unjHshGja3SyKA0iVBsQImelp2UU=;
 b=Crvht+kXdzgLkQm6VcSekrUu5zStphOtrbddgiqSOx/oC5KA3Pme8xDC0SLH8vfv1B
 4Q68NmkYhASMcEQZD7LlfUqgcSylAMM/yXK4CL2yVBkf2d7TfL8Dd/TeCVEfI2wIjpd5
 FDEDuZMTrzdU1BtVVhhVBn2KCX2xKpuG+2lmca/Q0o0HdVTviOBWVyPTVcqXmd1zHhaK
 LwtNBoK/r9H1ruuyko4pCRPc8DIRty484UIavVDHUe6qAHiCT21H4f/gBsQ+5VX3edXI
 iXKPQtv+/yEVBKTIZVjmg/EvxpQd2ZmpZL6lERSuozLbIMGMmvCpIy7z/XxFFo01QYs7
 ZEKQ==
X-Gm-Message-State: APjAAAVzRklHjWtB/0AVGj/LTpeY+9x6XjIbMOvvRQw68QwSZpXVeOvx
 Yov3tOHemfRk+LGPJ6jPYTQTrGKt/pel4B9VPN66xENl
X-Google-Smtp-Source: APXvYqx4JQ84qq/KY5CW70TsYO5PgVeLXK3pIRSmr414YYBW43rfgqDWxNMcjMRCzj1W0jJ00xkEDbeu6kEWR2oZO4Y=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr16673403oto.135.1582301111727; 
 Fri, 21 Feb 2020 08:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-10-richard.henderson@linaro.org>
In-Reply-To: <20200214181547.21408-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 16:05:00 +0000
Message-ID: <CAFEAcA-m_yMrX8rQQCAEy0i5UBpWxswW5+NwU+FQLCsFCxoVFQ@mail.gmail.com>
Subject: Re: [PATCH 09/19] target/arm: Replace ARM_FEATURE_VFP3 checks with
 fp{sp, dp}_v3
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 18:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Sort this check to the start of a trans_* function.
> Merge this with any existing test for fpdp_v2.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

