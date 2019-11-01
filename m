Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA74CA9ECE
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D5E2080F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l76Q461m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D5E2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQSTJ-000547-Ex
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 04:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSRs-0004Ju-7X
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSRp-0006M3-Th
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:38:22 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQSRp-0006F9-N2
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:38:21 -0400
Received: by mail-oi1-x241.google.com with SMTP id r27so7551558oij.7
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OSxsVlW52wcJaUsVFnMpWIWKosPJTzrE6/z69U5yeHo=;
 b=l76Q461m+3Ous9zlTYtLVm9ITKvS+VH0AUnhGNrU7aXt3I7h4g4rdBCb61YdKvvqA4
 tAIKlmpkgeSOPb8HrfwJXhzGAR3TvP7+oI/O5geneqwRYSqnqFMu2f7cFLEixR4kqbpQ
 Fe7RC6XlO1z0AvPoTaad8632Iach02orSj1VovlkRFmCX5shkTyWRyCBTti+kjjxhiaB
 4pWnZCjTR0/g4mkMpzm/hUbq9wdCYUdIgPK+zrUHIjOhScdCXSfvhkpe8Vb/XO4VElp7
 gZ7fINqN1tlGcdi9/vOqnL/q0qNZuYF2FqqBgEmfU3LVDWF7x4HJ+0yegc8L0Tp2AcLH
 Dz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OSxsVlW52wcJaUsVFnMpWIWKosPJTzrE6/z69U5yeHo=;
 b=KIF9laMnLev2l6Hw/Gefoof5hh5ctZNIZaNzeln7F3PHK6h29U4JpShFZYKZbWMAY1
 weHS3Z3EnniFzp88Eqf4LXnd1AnWCUKjzWfI0irvnEuztsJKi5HH+sggOMfEe6jmW74Q
 3CFxVbB7UCj/ZrI7ng5MKu7BgeiFJx1rwbYx8G6MC125xnu+RQ8r0YTc/XP/CSC20ijY
 ZOFeOgcap6zsftwo21clpLwrpDk4YuBZXr2UUs0qDatHuixgR1VaVBCtJCO9F6aCRMH6
 57HTkT+8PsJ5uHu+yXJ9SdD2J6aOJuy5c+B4HAe3MvSQtLL5CKkgw/kBQA2Lns0WCZ+I
 JTQw==
X-Gm-Message-State: APjAAAXIWwbK89aq8WxTVO2XzaHs1j6wZJNSz1lCHqACvIPBA7ourclj
 3q6BnCB2/wclO0HhVq+pAQ37TFZlTRDtNJNW91UxZg==
X-Google-Smtp-Source: APXvYqx8iaUEY6ouf8EfChsuC/cz+kyjLXOlLLWEQnBhpYXhA96S75X8gERB1XgMRcmkADZr0YMNRUKxj9aOX3Ln32Q=
X-Received: by 2002:aca:5342:: with SMTP id h63mr124782oib.98.1572597499609;
 Fri, 01 Nov 2019 01:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191025095711.10853-1-christophe.lyon@linaro.org>
In-Reply-To: <20191025095711.10853-1-christophe.lyon@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Nov 2019 08:38:08 +0000
Message-ID: <CAFEAcA-8VYjNmzaqFzujbHReZgxL0vLWJej-Yz_4=j7Dsd=WZQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/arm: Allow reading flags from FPSCR for
 M-profile
To: Christophe Lyon <christophe.lyon@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 at 10:57, Christophe Lyon
<christophe.lyon@linaro.org> wrote:
>
> rt==15 is a special case when reading the flags: it means the
> destination is APSR. This patch avoids rejecting
> vmrs apsr_nzcv, fpscr
> as illegal instruction.
>
> Signed-off-by: Christophe Lyon <christophe.lyon@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
> index 9ae980b..82bed5b 100644
> --- a/target/arm/translate-vfp.inc.c
> +++ b/target/arm/translate-vfp.inc.c
> @@ -705,7 +705,7 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
>           * The only M-profile VFP vmrs/vmsr sysreg is FPSCR.
>           * Writes to R15 are UNPREDICTABLE; we choose to undef.
>           */
> -        if (a->rt == 15 || a->reg != ARM_VFP_FPSCR) {
> +        if (a->rt == 15 && (!a->l || a->reg != ARM_VFP_FPSCR)) {
>              return false;
>          }
>      }
> --=




Applied to target-arm.next, thanks.

-- PMM

