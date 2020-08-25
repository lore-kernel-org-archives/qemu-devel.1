Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD8FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F1E320738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHWS/Wks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1E320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAe3o-0001qK-Qv
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAe2k-00011v-Ex
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:51:38 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAe2h-00028w-VO
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:51:38 -0400
Received: by mail-pf1-x443.google.com with SMTP id k1so1208059pfu.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=MIMHNjqCWChO1zQcIX6mrRMds4H3wWi3qxahwcJEa4A=;
 b=kHWS/WksGT7JXtxvjSx7h1BJklrzTydWDGhQJiZQ0YWmFH1R1vEQrreW7qkZ5zQPuw
 w/7Gvtw3bnyaaNw/konlmDu1Fd1M04A47JEaihCVo7dzazldb6p63LJrh6dKJZCmBPFD
 uO80vkzPaPwbQqsRXXtsLAF6MIwcIz5tQT0GOTSQLEgMZQa+Uka/x1N8IY9EmFo95Bs0
 id6Bd2IQ+Orgvlg9OfjXp8mZvGWpej/Z+jTMQVuNtMF5Ml7S8vclrmpj1yuPD5kIZw5k
 gDNsgD9qQ/cJnKOrg0CmEKCk5FKu6ogxYQf5iYOznoobLNruVkNHenPQDm9Ea5ZmJMbp
 jDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MIMHNjqCWChO1zQcIX6mrRMds4H3wWi3qxahwcJEa4A=;
 b=kAdqOrShTzRDomt78kLAqMULESMOksRpf1HR50+Kk2COZvnelN8vXI+9PvEWzFMXS8
 rrlMVkTxngQgospUY+ZyiFshmga7aSmjP3QJJ9jJ+ZvHKmP9crB3GYhPgE20dtHlb/ZH
 GVvJ+E2BCofmJlNtPTD0LDzvn7PO13cs2p6WS7ykVoEG2FHkkEkOyJiRpcCaLUj+YFPr
 Ea804NdMT8FryN5yQT4qMYiV+0b5Nw6OvEZFRdCgQWW6dyNjNsAohgwA7VtNEd6E3E3v
 nUV31az0ta34eEv1uQLt7uGQxlHB1b6pWFkKIbgcgVPJLMOwMhznboGNzh5zQehSjvjM
 9Ftg==
X-Gm-Message-State: AOAM533Yz2p0KxrtvdEbR5AUGzD+PfYwhTmH8NlMSPE4aCqW9Q0H1Jys
 sEEX+GtGwUGmNLNib+LXwFlUiMa2rOeSKQ==
X-Google-Smtp-Source: ABdhPJwSqIjMqZZXvJKATCif+ktNeHnwYyBvc0OJHlUH4pe4n4jZGg3GeZxleJS59hpd2m1QWgdwZw==
X-Received: by 2002:a63:5c65:: with SMTP id n37mr7679134pgm.294.1598381494402; 
 Tue, 25 Aug 2020 11:51:34 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id i123sm2442577pfg.85.2020.08.25.11.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 11:51:33 -0700 (PDT)
Subject: Re: [PATCH 16/22] target/arm: Implement VFP vp16
 VCVT-with-specified-rounding-mode
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-17-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4cea54f7-dea2-9e54-8f4a-a1c171d17bc4@linaro.org>
Date: Tue, 25 Aug 2020 11:51:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
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

On 8/24/20 7:29 AM, Peter Maydell wrote:
> Implement the fp16 versions of the VFP VCVT instruction forms
> which convert between floating point and integer with a specified
> rounding mode.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/vfp-uncond.decode   |  6 ++++--
>  target/arm/translate-vfp.c.inc | 32 ++++++++++++++++++++++++--------
>  2 files changed, 28 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

