Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF952C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 19:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5F424249
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 19:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N32gbZ2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5F424249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icwNQ-0007fC-O2
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 14:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1icwKk-0006zJ-UD
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:58:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1icwKi-0003y0-HI
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:58:38 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39901)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1icwKg-0003ug-BA
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:58:36 -0500
Received: by mail-oi1-x243.google.com with SMTP id a67so3749017oib.6
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 10:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AEQI4xHNIqMIIegnskaMD5l3+ExBopVS61N6I2vC0DI=;
 b=N32gbZ2VEtN1AHvzpjEXiZx4Ufd7FLblT6aZPLL0RX9jZhF+HfkH7WHvz20n5EUjl5
 hcyYU30R+uZIPoq68oSlvUl7U8xqwB1R8WtdWlFybSSvIp+CrIOws8yuPJRAHiucfOKU
 5hYFYJTQw1dmhC8vwi0n6L/gLPua22W5v/ca8cj1FBatZjwitlygXg6RJkOz9QlCyIUk
 lYWHEQATshFkx2oGQFukvjfrxKqobGsm/N8nTOo5d1dRX2nqt4CWW+KwTTz2vxuGov6w
 t2HjmPRFtMjoP9IhTIcdlSFOWNFlFLEdpWJpFBBljkA83BnwSFZ6Offx4MNa5Blz4x48
 wSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AEQI4xHNIqMIIegnskaMD5l3+ExBopVS61N6I2vC0DI=;
 b=qnFcPXLGq9XGPZHzAsPwpi+tHy9AttcZI947yiELDirjkRvxUmDDr5APxpZ9u4/iNi
 VfvBsOhzBGYxoTEkWmKkvvuArYxKOMNph9CEGqsRsjFLEf/hcewwo1/IY0UmV23qzXKG
 1dANTkc1Iyw7afzhN6S0uRPFSoowrA4d+7Nf8FVmj7jaLh808D8tAFJVcdcj9D1YB/7y
 9/Iw7oj6HV0rNqpd6+Y3dQYl5laxHxFwDzHBGWJxQOhleQl2rRycQWinC1rpbhhf7ULP
 ZLcMDSBewMlUMqLcFvp4gF6dKTyBepkoG5IDkbsSwDnE6N80XAw59OhtpRj7CkCMgjxv
 DRfA==
X-Gm-Message-State: APjAAAXw+dB4LqEFeHAuuNKX0fPVOV40QG1Q6rJzi5XnibDIa5rcOadn
 9DEtDELE4Xnsv8RE6veIcx9l9K83clzAz0nRKfvHwg==
X-Google-Smtp-Source: APXvYqw/AISrj/43VSH6spRMT8kKxwzOMJTGiR6VxBuZ2Y0SNwLSjenNeiDz9BmnsUe6Pe2diizbucxV8pbkwu54Msk=
X-Received: by 2002:aca:f484:: with SMTP id s126mr8226827oih.48.1575572312105; 
 Thu, 05 Dec 2019 10:58:32 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-16-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2019 18:58:21 +0000
Message-ID: <CAFEAcA86hhBNLWhAe2UY+0-pS65wpSdPKFPTA9O4m9avjECxaA@mail.gmail.com>
Subject: Re: [PATCH v5 15/22] target/arm: Clean address for DC ZVA
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Fri, 11 Oct 2019 at 14:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This data access was forgotten in the previous patch.
>
> Fixes: 3a471103ac1823ba
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 4e049bb4aa..49817b96ae 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1766,7 +1766,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
>          return;
>      case ARM_CP_DC_ZVA:
>          /* Writes clear the aligned block of memory which rt points into. */
> -        tcg_rt = cpu_reg(s, rt);
> +        tcg_rt = clean_data_tbi(s, cpu_reg(s, rt), false);
>          gen_helper_dc_zva(cpu_env, tcg_rt);
>          return;

...doesn't this mean we don't do a tag check for DC ZVA?
Or is that handled in the helper ? (I guess it has to be,
the DC ZVA will span multiple tag granules).

thanks
-- PMM

