Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73826C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 13:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7B92071C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 13:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="twjD/QPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7B92071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWgoI-0007v5-CO
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 08:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWgnN-0007WA-Nx
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 08:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWgnL-0002QF-JO
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 08:10:21 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWgnL-0002Ps-Dq
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 08:10:19 -0500
Received: by mail-ot1-x343.google.com with SMTP id 19so4516416otz.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 05:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fzpfXXmyJ/6T/xKi3F0O7/hA51wKZtpTADIKH4T6quI=;
 b=twjD/QPCf7w1FfnPAQzlT6tQQNziVFhtkGZl+551nkLxvinShLoicRfT+bbR8bq1t9
 JZM/l+u2qJi/srShKLxqg7GJjBQcgTD5J+vMZ2omXmofXCar01yCi0dD5/ZFSaUrxb1g
 UpKjewSEndcYRIqz/X5YWqDYsYjzvntDJO4vJpmir8dEt59YtcvP5pdIvZxAayNgJIWV
 ucxhjuFPJ/4+nBc6SghLCO3URFOZlXoRkrdgv7hxDkAUiaV8PR1YFsx7umSRyMo6dHMU
 VrjbiogHOxEbKIV+mU5U1ERXkeseAP5XFizTsDpj/6IxNQOUQ699eIkUhqd0AriHDSwe
 VfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fzpfXXmyJ/6T/xKi3F0O7/hA51wKZtpTADIKH4T6quI=;
 b=G1r1DzBYrG/P5T0N22GoBTlwAhG0fbrXPF7pFw3bjyQ44ahYBieYZ9D9G3y1QoiiJQ
 xEBI4XuN85pIo/bZX5PVvgLfH9kb7s7QippolnSsZyzOkQ1hIKLLbATIgrdvcC6XAtEZ
 Bc3tcqRtqwmHN+0E6nQsROhxJJfp02qXx+3q7tO4ia6IQh4IT6e7U+QZUOlEAvpr2p8K
 VqCZilWa2BsjyccCFxTzicUZrVsU5OykMgEqcjgtf6iCdLlRZa4o2Q6ch94q8UTv2mS7
 BjhKH2mH2+EsS5s33+Q8Vw8Tz5WhPCHTrGdc1zdPuwIOHPcul3/jdv5oVmNf59jcBuN2
 FZKw==
X-Gm-Message-State: APjAAAXafCpwZDLnq0BbOBpOMzgPdwoxSBWXLu1HGNkyAgD3mZCs3ygE
 dm6f+iSdv3inXCw9+nHZNP/BSSHhQMx3hC/dSqELDA==
X-Google-Smtp-Source: APXvYqzjDsEYIwGmWdc+wYQC/PwE7Qq0uiUTEBIQ+y50q4yfn6vUzpB9FyLiti0Az+fKbnAtyVR9W9R3a4xcLEIrvNA=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr725519otk.91.1574082618465;
 Mon, 18 Nov 2019 05:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20191117090621.32425-1-richard.henderson@linaro.org>
 <20191117090621.32425-3-richard.henderson@linaro.org>
In-Reply-To: <20191117090621.32425-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 13:10:07 +0000
Message-ID: <CAFEAcA8FdT8R4_nwUQ1QLBMBST_K0xuHABER3f8kt6JY1vYojw@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: Relax r13 restriction for ldrex/strex for
 v8.0
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 17 Nov 2019 at 09:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Armv8-A removes UNPREDICTABLE for R13 for these cases.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index b285b23858..3db8103966 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8931,11 +8931,11 @@ static bool op_strex(DisasContext *s, arg_STREX *a, MemOp mop, bool rel)
>      /* We UNDEF for these UNPREDICTABLE cases.  */
>      if (a->rd == 15 || a->rn == 15 || a->rt == 15
>          || a->rd == a->rn || a->rd == a->rt
> -        || (s->thumb && (a->rd == 13 || a->rt == 13))
> +        || (!ENABLE_ARCH_8 && s->thumb && (a->rd == 13 || a->rt == 13))
>          || (mop == MO_64
>              && (a->rt2 == 15
>                  || a->rd == a->rt2
> -                || (s->thumb && a->rt2 == 13)))) {
> +                || (!ENABLE_ARCH_8 && s->thumb && a->rt2 == 13)))) {
>          unallocated_encoding(s);
>          return true;
>      }
> @@ -9087,10 +9087,10 @@ static bool op_ldrex(DisasContext *s, arg_LDREX *a, MemOp mop, bool acq)
>
>      /* We UNDEF for these UNPREDICTABLE cases.  */
>      if (a->rn == 15 || a->rt == 15
> -        || (s->thumb && a->rt == 13)
> +        || (!ENABLE_ARCH_8 && s->thumb && a->rt == 13)
>          || (mop == MO_64
>              && (a->rt2 == 15 || a->rt == a->rt2
> -                || (s->thumb && a->rt2 == 13)))) {
> +                || (!ENABLE_ARCH_8 && s->thumb && a->rt2 == 13)))) {
>          unallocated_encoding(s);
>          return true;
>      }

These cases for r13 are indeed no longer UNPREDICTABLE in
v8A, but they are still marked as UNPREDICTABLE for v8M...

thanks
-- PMM

