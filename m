Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838A7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C66520774
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjuHeJqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C66520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ecP-0005Fh-K0
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 14:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6ebl-0004ae-IU
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:39:17 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:40034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6ebk-00080K-0H
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:39:17 -0400
Received: by mail-pj1-x1041.google.com with SMTP id d4so4781950pjx.5
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 11:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=S0nGAnw7tjps7ZeHxAke4OPnE9swDCH5MPqzSXGLXiQ=;
 b=fjuHeJqSDspEkN6ewyvYtJaYrX6l6Q/OnJHRB2MkddWhpqkFUP3p7fBEWHqwuD+eFG
 0iqBnFTduQ5emFHgq0bK6I8OI+lR0Ij4dw9LlJnAXpdv0MII3PsJt0OUWr72EsM2nrac
 t7hdHLrV5uGjbTB9nS4184VwYfJXkXyxgP/m/kZuV/xXp5tGOdII9FDas/bb9XTlyN38
 6tjVM115VANqxTaIgMGDaM5Ie3mx6eT9z7V7hRfAkgnQGzyxQYeKicm+otHgEZ1KNHU0
 0oTAOY8b85AlR7NXDDtp3tGTuaFUzpync6GnAsyuJn8BVNsk8pOl3SAfa+JoMtkeL4G8
 8k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S0nGAnw7tjps7ZeHxAke4OPnE9swDCH5MPqzSXGLXiQ=;
 b=LTCtGyri7i9t5a7T6xJXw+WC3vA5dlWvaBYnnAon5+LuuPbAYqgQCFbQnFy7RJvFit
 xZX21xq3e0u8Nr1OkYZf5T2aFqOHHSZe8LF3XMSY46tU2USAdmaVxwWBCE0bz5L8XLwV
 dW5gJ31fTK50LgG6tCW0LXcQm6TcLe0qJ2Zfy+qibBdws7aZzckESZoOY1a5mx0gtB5E
 Wm/QneBH4/qsvECyqOGfFaqj2qOanjvhFh9ShjK7iNQH/6Nmqo7OFx9l/JwJR7h3uJlI
 FukSjDY0UihuQ8XRuPdcsHw/sSYTej/e7oNqPRnfgH7gcBoaiMmLFvx0aVOW2YKfi1jk
 hyNw==
X-Gm-Message-State: AOAM533EZ6c+cPvn4p51dMTlTakfMNb4Ll9QmqgKSi1rrxBVgazJfz7y
 +K8Im3mjrE4ngjQKfPWmSxv9/EJxjxZseg==
X-Google-Smtp-Source: ABdhPJxjxqDFjZ0N8Jfs9W9xncX7M82Zo5zp/03Rzm9mCbcuANFFPguZyt7vHAGnScAQt3Lz9vOt2A==
X-Received: by 2002:a17:90a:c591:: with SMTP id
 l17mr3237114pjt.17.1597430354596; 
 Fri, 14 Aug 2020 11:39:14 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r7sm10070750pfl.186.2020.08.14.11.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 11:39:13 -0700 (PDT)
Subject: Re: [PATCH v5 02/20] qapi: Fix indentation, again
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <69a47ded-6f23-b739-101e-89f5b866c412@linaro.org>
Date: Fri, 14 Aug 2020 11:39:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810195019.25427-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 12:50 PM, Peter Maydell wrote:
> In commit 26ec4e53f2 and similar commits we fixed the indentation
> for doc comments in our qapi json files to follow a new stricter
> standard for indentation, which permits only:
>     @arg: description line 1
>           description line 2
> 
> or:
>     @arg:
>     line 1
>     line 2
> 
> Unfortunately since we didn't manage to get the script changes that
> enforced the new style in, a variety of commits (eg df4097aeaf71,
> 2e4457032105) introduced new doc text which doesn't follow the new
> stricter rules for indentation on multi-line doc comments.  Bring
> those into line with the new rules.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

