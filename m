Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0806AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 04:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF832073B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 04:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABjzplJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF832073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbzHZ-0003JR-Vv
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 00:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbzGp-0002gh-VC
 for qemu-devel@nongnu.org; Fri, 22 May 2020 00:26:55 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbzGp-0001aH-2x
 for qemu-devel@nongnu.org; Fri, 22 May 2020 00:26:55 -0400
Received: by mail-pg1-x543.google.com with SMTP id u5so4424826pgn.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 21:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6t60OdTEj/+df3YqBoi4RRSuD0MFWy3jgFZjTOxrC5Y=;
 b=ABjzplJhJ7v2EY8T2PgfadwVYMYTpiHXzRtnQiQkyE4tHYiLWv6q11Iga0HDgro8op
 sFg13WEznnn/nDw8bLQbIqm1rIJe/JWLZokpnzC9Ne5TzC0dYt0/u+1bOTs3mLemDtZG
 iJKQ27PM4/Tvbix1SectJRTOYh9omaCRJULwouNn8ck/B82K3A3vc5QqNNCMiG76SK5z
 IM3lazPWmdYRW7Q1nzdK5neqLhXPvv62pjemgG7+93b2a0f7x6XD6aUvUcTK6C8nZ70P
 9a/ylK595DV60+amKQnC5UdYL5c9GumoHzc4Xxyuf/yRWzI8nP4lHu5tyaJW6GiDf2JC
 rqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6t60OdTEj/+df3YqBoi4RRSuD0MFWy3jgFZjTOxrC5Y=;
 b=UddthSPkWE1hpFSKzzGJVNDyFykwUclSknRegJDMBebfGhtjonk2hC8BClj3I+mxI6
 4Sbx+91SOmO3utwIPhYeL4/NZf0H/QFLt+ctqfetwIi+WZbEyLQtl661x6NFWKAYhVrr
 jijlnT2x8U8QcdyPQkV2eKxJ64MYF4WBBXxOLx5X2AgadoQT6xm0nrZg1Oup5zLiMtSY
 3XNcwRdaTRrb4HcYW9FRajtYKDLF0cXdI+00kEkyvP+rih1FWMNbj80q0nuQV3v8ma3L
 6LPFqCAdAyDa0avxJ4ewcw5Z5jb+2bTXMkHOmtRVS5iZJrWA/Rp9tT4UOXQ/wQ8MeN72
 b3BQ==
X-Gm-Message-State: AOAM5318B/EmmOWICEYTPxrad5T8gLLKNZjyd53JFOSzW82bxqlwk8qm
 4P06WpyQxCwIutq1vkgoy2qXiQ==
X-Google-Smtp-Source: ABdhPJyH7IulLdrBCc4zXIN9Yv0wCSv7AC2Yz2CgZMKL/CyQ70uJA/LgBzwbW61NL8Ezx4Mta1z1RQ==
X-Received: by 2002:a17:90b:2396:: with SMTP id
 mr22mr2264422pjb.118.1590121613947; 
 Thu, 21 May 2020 21:26:53 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q17sm5064573pfq.117.2020.05.21.21.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 21:26:53 -0700 (PDT)
Subject: Re: [PATCH v3 11/11] hw/semihosting: Make the feature depend of TCG, 
 and allow to disable it
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200521195911.19685-1-philmd@redhat.com>
 <20200521195911.19685-12-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <36db7554-dcc0-6b8c-e7b7-628c105d8fc7@linaro.org>
Date: Thu, 21 May 2020 21:26:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521195911.19685-12-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Michael Walle <michael@walle.cc>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 12:59 PM, Philippe Mathieu-Daudé wrote:
> +++ b/hw/semihosting/Kconfig
> @@ -1,3 +1,5 @@
>  
> +# default is 'n'
>  config SEMIHOSTING
> -       bool
> +    bool
> +    depends on TCG
> diff --git a/target/arm/Kconfig b/target/arm/Kconfig
> new file mode 100644
> index 0000000000..035592dd86
> --- /dev/null
> +++ b/target/arm/Kconfig
> @@ -0,0 +1,2 @@
> +config SEMIHOSTING
> +    default y if TCG

Did you answer my question about replicating the TCG test?  If you did, I
missed it...


r~

