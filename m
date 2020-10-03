Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB90C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3428B206CA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zen9iB1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3428B206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOdYY-0004Np-5j
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 05:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOdXl-0003ph-4c
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:09:30 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOdXi-00068e-6t
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:09:28 -0400
Received: by mail-ot1-x342.google.com with SMTP id q21so3794183ota.8
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 02:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HYSCtcMUH1CnN1lWiP4pycuNjmBqf/V7CmBzZsvjo70=;
 b=zen9iB1yMPujq97iQd0rcqeRg2ftw3ME8gIklBFi8p9ldwneLaDXCDPYRUIQTkjPmu
 34gpNg5WuzSZl9oqb4EqsMJpID7Y8kqBXJN3lH6S4KyBU2GMIlgl0TTl6E+UVa33u510
 3Rh14+w366lPClVPydalaCx8NxczYi4TvLeZD2vj3p3wCzFn7msZNBt/JVfVWh3nGC0n
 7+GGP4US3qXnRDgu9/Ti+7ZjPRKMQiE30/YT7a1k6v6ax+sUGyRg9yD6N68gbwO1wt1H
 Rt9BsMi2c3z3Q8NvcmfIH8x9WHxlS3gWDRK7Ni2ODGW31CZ6cw45ek/rpWWeBWhDhvBh
 lXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HYSCtcMUH1CnN1lWiP4pycuNjmBqf/V7CmBzZsvjo70=;
 b=AlmgbXMn9HnoQ73ChPy+FlAD81HngFlVVpCnGlnKX/QmEgZ2nL+iC2KS0CnSdE3zeN
 1CnMbsJynZeoF43qpBa10hSqyquoGcpefYH7PsChFlC8xHar6DIBREu6P54bySKpwgwf
 E6KpZkzTxWq8V7ETyNOYQ1Us5EpZkfdSdUsiwMV9Z26FFvezeXlOElIVBS8sP2qsYkjd
 CFEqE7isbhSNZZeBehUROh9LcZDJ4VN7OEg5JqRbxcA7L2+hXNSjpOcuCG0TIAdG2mID
 p7TXr7J4spcZnJFG89y+XW1WrlfrzqkD7Kv3xl4UuMvRc5hgBh2PwAbFeTvYS6xGj9ag
 SVCQ==
X-Gm-Message-State: AOAM533zswzACSU++SNlYgFqbqa6fa5slqSR6HAVFByKvxJAshcl2YoY
 tV5EjRnVpEg4oB0pjWOqECDuew==
X-Google-Smtp-Source: ABdhPJx4lrVJsgCJS8zeF1KPZ5f9Ry1mx0UpzDyt1+dQuj+wzFEHnqikKO7+ju8aX5ld/ijPH/aJeg==
X-Received: by 2002:a9d:53cc:: with SMTP id i12mr4536397oth.215.1601716164481; 
 Sat, 03 Oct 2020 02:09:24 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id v18sm1125780oof.41.2020.10.03.02.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 02:09:23 -0700 (PDT)
Subject: Re: [PATCH v4 01/12] accel/tcg: Add stub for cpu_loop_exit()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200929224355.1224017-1-philmd@redhat.com>
 <20200929224355.1224017-2-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c4d714db-18d6-a789-b7f9-fe7e2c62b224@linaro.org>
Date: Sat, 3 Oct 2020 04:09:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929224355.1224017-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.256,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 Keith Packard <keithp@keithp.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 5:43 PM, Philippe Mathieu-Daudé wrote:
> Since the support of SYS_READC in commit 8de702cb67 the
> semihosting code is strongly depedent of the TCG accelerator
> via a call to cpu_loop_exit().
> 
> Ideally we would only build semihosting support when TCG
> is available, but unfortunately this is not trivial because
> semihosting is used by many targets in different configurations.
> For now add a simple stub to avoid link failure when building
> with --disable-tcg:
> 
>   hw/semihosting/console.c:160: undefined reference to `cpu_loop_exit'
> 
> Cc: Keith Packard <keithp@keithp.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  accel/stubs/tcg-stub.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

