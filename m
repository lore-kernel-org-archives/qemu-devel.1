Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E689CC4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D85206C9
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SuhKbrNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D85206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOe59-00087W-BT
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 05:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOe4M-0007c0-K9
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:43:10 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOe4K-0001E4-48
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:43:10 -0400
Received: by mail-ot1-x341.google.com with SMTP id 60so3863319otw.3
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 02:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3qxl6W6Hb5YLbw/EY9qvXKmVt4aFa32zNvMsgWDEaIs=;
 b=SuhKbrNebolkmv1zwZgG2kxF9agEk7c2jEVgSYCLSypk30ZV/r2YEXK7QIrm+r4gtp
 eRBa2cd/gMWSxN1vX8fqaHjZ321eW12DraZF3z6BsG+a21g41NVo41hx5N8HvVF4AL9u
 5btqslJfJtnb9p1R8SKwfTjxvN/Cr1NJSP2JCd7jMyvrZs2AMjJo5Uz5mr5up188/C15
 d5XslaZvfBmwWOpsvW+5lv/FavNKA+kPbFn5BONrnCYQymXsCAU3oWZkATag0TaRO0l7
 zBT5FPnO60q0d+HljcfWs0ZvF+s5kSxDxpfZMX6JzgwFoxdr87MBqtq3n+lgjP5joAzr
 7vjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3qxl6W6Hb5YLbw/EY9qvXKmVt4aFa32zNvMsgWDEaIs=;
 b=lAAzBRLlXTpTWTYrC3pQ3Nhd2gZEl9U4NXvgxNGF/kjyzSggNEc12euL5OxhDh9zEi
 J1IiIy8abW96zAY5ocSIX8xItgs5QUtaNwV4BS0LdDrKbJYQ5/ZElFetagwLX95H4FDx
 MVYfybuBEwqK1GiRa6ZuTh908r/2UOkiFW6KXlNS1WztRaLIGiBnmxPqLS5tHfI5bwTx
 64DBSc8C/XtUxG6S74kyVuIS3C3/4OR+kbmaJRNV0L1d50pDuprB3W/AUrHOZ4m9FsjN
 0Uc6/fg7rg79xKnQTAi7g+gMXt5fYxcOwKXADkBPKGibl5KnE8sIZiz7nc9R4YKOw6sZ
 AGGA==
X-Gm-Message-State: AOAM531b50YMDitoGgkZm0/0EY09iiniW+hGGEQOntq1Rm3F8bkzBVRQ
 qS9TxYNoOf1vQ/xRtUYyKhtoLw==
X-Google-Smtp-Source: ABdhPJwU72xkcylEdZMYoJ1HBTqlZvVLkH052G+WpZXaCQazKqWtTdpYlIkYrQ7bPjCXeqGbvd/ehg==
X-Received: by 2002:a05:6830:105:: with SMTP id
 i5mr4739874otp.68.1601718186724; 
 Sat, 03 Oct 2020 02:43:06 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id k3sm1181783oof.6.2020.10.03.02.43.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 02:43:06 -0700 (PDT)
Subject: Re: [PATCH v4 03/12] target/arm: Select SEMIHOSTING if TCG is
 available
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200929224355.1224017-1-philmd@redhat.com>
 <20200929224355.1224017-4-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3d418adc-60f6-492e-0852-2e52a3c1c5b0@linaro.org>
Date: Sat, 3 Oct 2020 04:43:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929224355.1224017-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x341.google.com
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
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 5:43 PM, Philippe Mathieu-Daudé wrote:
> Add a kconfig entry which not explicitly selected by another
> entry, but which selects SEMIHOSTING if TCG is available.
> 
> This avoids:
> 
>   /usr/bin/ld: libqemu-aarch64-softmmu.fa.p/target_arm_arm-semi.c.o: in function `do_arm_semihosting':
>   target/arm/arm-semi.c:784: undefined reference to `qemu_semihosting_console_outc'
>   target/arm/arm-semi.c:787: undefined reference to `qemu_semihosting_console_outs'
>   /usr/bin/ld: target/arm/arm-semi.c:815: undefined reference to `qemu_semihosting_console_inc'
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/arm/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 target/arm/Kconfig

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

