Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3CBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B9C2089C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPbQLrl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B9C2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLRLs-0008Fw-C9
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 08:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLRKU-0006Zk-6h
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLRKT-0000nO-46
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:26:02 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLRKS-0000n5-Vx
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:26:01 -0400
Received: by mail-ot1-x344.google.com with SMTP id s22so4778316otr.6
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OnhC+T9CPfzWhaYQxeCK9tQMbyJ2aRBMNOGy3SeaMh8=;
 b=GPbQLrl+V78zmkSyMivytDJ4a4U/LovDmsQUY0lPiEKNXkradS8yJvDGcM+MqpLKvO
 WU5vJQpSmmMrs1o2Iv9SF4KvoigxG+MhavuaNTJ/C4syb39x/USjyAf+mzR5hN2p3JvA
 JUCvD4HyUc8KldR7jfwapd7DxWDldpoNJT7eU1h3ctQONqEpCimFGnBqSwt5tR3Bmk7T
 zA9Eadwypbue9dakPEZ2sp8fajEhNiqqcelhSIzw1D/drIlsB9H/V/bXkngpRftJ/vkG
 //7W+78Anu37Ut0sz7p73uc+emVpvKLo9QnzBWWBZIEOWANn39TC7LDLOPmM0/cFyzES
 wdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OnhC+T9CPfzWhaYQxeCK9tQMbyJ2aRBMNOGy3SeaMh8=;
 b=aftm+4DEFcIXQer26lQbANDXqjibccJzNvcUjEa5Xs1ndU9MVulowgocfYzgm4LheX
 3OuGAHsKBsGG2C4mtLuW6W3WCBmjYnVOrp/aPqse7hv0ESwbULCUdLpuCVtjGc02bClW
 5ZJh41WXE5U1O2aE1MWQXfkJtMI0Jq3+i/t/jiMqPwAAzIKx220EF0hVff5rqlk/Sn7f
 O0xLJLmtIN89de7UujRIEKvd5R0XpJqSAgAwyDmCng6s7CcUZjwyzk7rvVs+qDW6L2iN
 Qz4R6FZIiO56jjmP3F1OemWm//KolEvkUT/g1lb2655whs9R4NwC6oh2B8L3HxQXZhTx
 kaYA==
X-Gm-Message-State: APjAAAWB2+R3CD8KleaIjEb3mdLm4SoUo8JtE5UJCpkt0Wl3KuzOUCqd
 UfVhrOwRNaLb7nJY3SGxxsiBnF44PwmVLmGSDxQjcw==
X-Google-Smtp-Source: APXvYqyYpvtS9jQi8E9v3MHPUCLXy2ws2OhApfZBLwSx/LmqFQA8zhlN7re8GJnxvRGd+xV+1mGVgj9kgvlVdyOS0pU=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr7459904otj.135.1571401559894; 
 Fri, 18 Oct 2019 05:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191017185110.539-1-richard.henderson@linaro.org>
 <20191017185110.539-20-richard.henderson@linaro.org>
In-Reply-To: <20191017185110.539-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 13:25:49 +0100
Message-ID: <CAFEAcA9oJ0P-g87caLKyT1mS2k7YhtNXAOhSgXuMy0bCGwX0WA@mail.gmail.com>
Subject: Re: [PATCH v7 19/20] target/arm: Rebuild hflags for M-profile.
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

On Thu, 17 Oct 2019 at 19:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Continue setting, but not relying upon, env->hflags.
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v7: Add rebuilds for v7m_msr and nvic_writel to v7m.ccr.
> ---
>  hw/intc/armv7m_nvic.c  | 1 +
>  target/arm/m_helper.c  | 6 ++++++
>  target/arm/translate.c | 5 ++++-
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 8e93e51e81..a3993e7b72 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -1604,6 +1604,7 @@ static void nvic_writel(NVICState *s, uint32_t offs=
et, uint32_t value,
>          }
>
>          cpu->env.v7m.ccr[attrs.secure] =3D value;
> +        arm_rebuild_hflags(&cpu->env);
>          break;
>      case 0xd24: /* System Handler Control and State (SHCSR) */
>          if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {

This seems fragile -- we have to remember to add in
a call to arm_rebuild_hflags() for every individual
case of a memory-mapped system register that we choose
to cache in tb flags. It doesn't seem consistent with
the choice for A-profile to rebuild hflags for pretty
much any sysreg write. Maybe it would be better to just
always rebuild hflags at the end of nvic_sysreg_write() ?

thanks
-- PMM

