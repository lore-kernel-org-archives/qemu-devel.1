Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3995C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 20:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B24120658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 20:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lOL79TOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B24120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDwCI-0000hV-Lh
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 16:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDwBG-0008AO-GL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDwBE-00060r-IQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:17:46 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDwBD-0005wz-Ve
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:17:44 -0400
Received: by mail-pj1-x1042.google.com with SMTP id m15so8581848pje.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2yW7S1n3gr0Wmk0qZ8ztP7NorwmiXCsES5nj7/m/l2s=;
 b=lOL79TOmLAhOOPelKaD2VIxJ8azSNOLBXgkxGer1aFJdDHP1Q15mIaKCKsAgieJfCz
 iIsEJkPjvaqmZEBsjzvL2OfIMhCplUv5MXEUi2QHyfxqNMcNyDUnbUlgZMcu/zB81WtH
 gRPCUc9FTR/GDj9vkyF+6dJ36N5oG9FH4E9MiIECxl+I+Pysp0cAa/7hTZjJTOJSvfzD
 rve3rydC76PoRy2zpe7yIq+aTMVo1jrxNDx4FlH5ctnoM0x+4GcHTYqoXUVrdl6Reelu
 DUiHA7eEtnUl8ivnyP9PPFykGKHZQD4J8Qd3cdyT0+2oRf05TyfA9ktCteVYvHQAPHwv
 l0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2yW7S1n3gr0Wmk0qZ8ztP7NorwmiXCsES5nj7/m/l2s=;
 b=HIllFnbRrW4BKzYajNtzHwNeo/+ICl14KuIhPld2vw7pXgs3fNLQHCU7liME54CP68
 WYVs/6FvXCvAGxChMKXrd7+IohH2i/3K9SO6LcJCYfZJiExro2rHuYRhfddpCIu9C6EG
 UQc4ru9aEefxZQGNqSZ2WC9YtT3MtCf8oFFckQcg6LWXYt/2QiPPNPClECrbQltpUG5F
 daNED92gssk16pXBNA3tLlNuNh7ELcDCPh9hB1gkWN067AK+DFgsjd/Qjk3HeIWHV6oz
 /Bnz8egArZws0mG4XWmuFmIe5t5bZENJQ4EcisepEVkpZiAZ/fTYiVu9hFlcso0gkg6O
 O4pQ==
X-Gm-Message-State: ANhLgQ15CnhqCB5syibuqrmepydiwuVtG7oYINSfvt52U/H9fwNUVgZ5
 3lV5sOjjIyuMrgeuTqzQzOHcJw==
X-Google-Smtp-Source: ADFU+vth/TIZRKQ+ne19YZSby2Ty7zpQb7LvvexFS2GGoAPSTqzbmzzEvmtJN4ay/ktxRf/Mc3hJDw==
X-Received: by 2002:a17:90a:e384:: with SMTP id
 b4mr1234622pjz.89.1584389862018; 
 Mon, 16 Mar 2020 13:17:42 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 gc16sm593969pjb.8.2020.03.16.13.17.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 13:17:41 -0700 (PDT)
Subject: Re: [PATCH v3 05/19] target/arm: Restrict Virtualization Host
 Extensions instructions to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-6-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9cff4a7a-e404-fcc4-eb04-fdbc48ceb7c2@linaro.org>
Date: Mon, 16 Mar 2020 13:17:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316160634.3386-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 9:06 AM, Philippe Mathieu-Daudé wrote:
> Under KVM the ARMv8.1-VHE instruction will trap.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/arm/helper.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

What happened to the uses of these functions?


r~

> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index a5280c091b..ce6778283d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2897,16 +2897,6 @@ static void gt_virt_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      gt_ctl_write(env, ri, GTIMER_VIRT, value);
>  }
>  
> -static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
> -                              uint64_t value)
> -{
> -    ARMCPU *cpu = env_archcpu(env);
> -
> -    trace_arm_gt_cntvoff_write(value);
> -    raw_write(env, ri, value);
> -    gt_recalc_timer(cpu, GTIMER_VIRT);
> -}
> -
>  static uint64_t gt_virt_redir_cval_read(CPUARMState *env,
>                                          const ARMCPRegInfo *ri)
>  {
> @@ -2949,6 +2939,17 @@ static void gt_virt_redir_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      gt_ctl_write(env, ri, timeridx, value);
>  }
>  
> +#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
> +static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                              uint64_t value)
> +{
> +    ARMCPU *cpu = env_archcpu(env);
> +
> +    trace_arm_gt_cntvoff_write(value);
> +    raw_write(env, ri, value);
> +    gt_recalc_timer(cpu, GTIMER_VIRT);
> +}
> +
>  static void gt_hyp_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
>      gt_timer_reset(env, ri, GTIMER_HYP);
> @@ -2976,6 +2977,7 @@ static void gt_hyp_ctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  {
>      gt_ctl_write(env, ri, GTIMER_HYP, value);
>  }
> +#endif /* !CONFIG_USER_ONLY && CONFIG_TCG */
>  
>  static void gt_sec_timer_reset(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
> 


