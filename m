Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6C7C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E1D208D5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gW55q9yS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E1D208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBnZM-0004G2-9Y
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnYo-0003iG-NF
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:13:30 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnYn-0005IV-A5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:13:30 -0400
Received: by mail-pg1-x542.google.com with SMTP id o13so1142455pgf.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 16:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=G96Swk1Bj3MHCv5uo/EPexivUAIliibw0hEPmaMVLWo=;
 b=gW55q9ySiu1bS3RLSRJ71G8Q923l9JZYXrRFJ2eeQze0ySy7V5a7qqoNdri9WHZVu5
 H3ZNWMAekWCWcstQMj/X1WPk1Q/mDcXVnBKr9u8gQi9NvU+D4dEOjh4wRg4TFHCYaHWE
 t87TK7Kj7v0POCN8BeLVCKyCk/h2qxdae4ssrsGO1fMmNscvFDOr3cxUhBkrTsrARd4D
 0RvzmQc/dBoqJzKdwuHp3jPJ+JQ/qcKX78ycalkYMr+wh3Hfhi0Sf5g+2GecitZUgD6y
 H4XTsBpRyh45xfGH+qAHIER4CBegrfS984ntBEFbJ2XKSqbTWuPKdsQZSgwaxM1wAq23
 rTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G96Swk1Bj3MHCv5uo/EPexivUAIliibw0hEPmaMVLWo=;
 b=BoSs7Yd++WEoIHXZhrHmiuis2X78wzr15kO/L199vG7j6rTQMwU2kTPdJjIs9rVkTb
 qtkT/qTxDhT3SM14SxEZmUM8BOBA31VceI20DSfm3NfFXsg1mY6h9kG9hxz3m4gQgjIb
 Cf1j9y1NNVIDlKwQv3vMbPu+LsK6/AqrWGkNN4oqSzdgjpCmL86T8QCx0PYRg0vBv640
 BfXeSvjCjEyypkjkqIGmaAUOM2ggk8i4ifHEUm3CnHO3DArWmqB7z0zmvoVunUX85bmv
 cod9CQk/1y2ITmWBXqWKylD1PVaoVJDGhPYJX22SMAA5aAqSoFRS1ElISX0wZlAFgjUb
 dJ7Q==
X-Gm-Message-State: AOAM533Y2Do9FthKdYFIM9vW5QymN/t66/pP/BcI+0KXSnWp5bD8aXwa
 Xdrp/a4/jjEWH/HNHn0pX9RHiE+50/RXww==
X-Google-Smtp-Source: ABdhPJwph51YLyzqkRD+Zq2Za6tI1yQ1u4bBgx16MqejoTW3HBKNx3nVyXX2DN+5AJEACX3O4BDY5g==
X-Received: by 2002:a63:b24b:: with SMTP id t11mr737266pgo.233.1598656407582; 
 Fri, 28 Aug 2020 16:13:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x19sm505288pfq.43.2020.08.28.16.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 16:13:26 -0700 (PDT)
Subject: Re: [PATCH v2 39/45] target/arm: Implement fp16 for Neon VCVT with
 rounding modes
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-40-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d2321e5f-a96d-57fb-aa28-497b213df11a@linaro.org>
Date: Fri, 28 Aug 2020 16:13:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-40-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/28/20 11:33 AM, Peter Maydell wrote:
> Convert the Neon VCVT with-specified-rounding-mode instructions
> to gvec, and use this to implement fp16 support for them.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h             |   5 ++
>  target/arm/vec_helper.c         |  23 +++++++
>  target/arm/translate-neon.c.inc | 103 +++++++++++---------------------
>  3 files changed, 64 insertions(+), 67 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


