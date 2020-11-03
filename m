Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0F6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C7B2080D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJCh7aJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C7B2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzjk-0001pM-OG
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZzg8-0005ib-WB
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:01:07 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZzg5-00086i-Hr
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:01:04 -0500
Received: by mail-pf1-x444.google.com with SMTP id 10so14753119pfp.5
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 09:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=K+WGWnzJYW4S2iI8/mx93AwJbjDQ0v4CrAPEeljIjTg=;
 b=KJCh7aJKI5EnlxloJ4ZPnSMBxccao4rWDqVyxz5LMOoMOiUCo4iSkJ89a2xJC63U75
 EDOwAtgFYdqUMyDoUJmb8OkuevOLyoOrGOsWXfBFZUBoNfY2k4uC7027gHRtGdMhnyf8
 CaBeh+xDH7LxHLVb74apmiACWVBCN28ff1/gtjvtnr9jEIiCWgne4dx/0OhSzeYPq23D
 s89JwzTYIPyAKgXnda4BYgS7Mrv1jSzIwPT9IGgrXf3THR0YOZQcDmJsd5vhl8nkMSZs
 L2l36Vo6KfG7qlDhqCjXIgnNegqKtHzlysZOrh2lwwi56Fjtw2qwWplZcuJNIv5VFRrY
 Cxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K+WGWnzJYW4S2iI8/mx93AwJbjDQ0v4CrAPEeljIjTg=;
 b=AyRKKq7ECcB3igWRiZOwMnBCi9efM2+pHmwHOa1XzjFcwy2tihLMLDegUT9as4nuqy
 yuuDcyv8ALWlUd/+0yeowzAnd/YYr4hkHNiCN74XsWo7Yo8ctSdUKjBL5RDMNprIGuKx
 2oWGGWhSuRxfg6mFPrgEKIwYz893yR9XhV/kiKN3OQiGY/M/Vb6d4aoigtZcYc4l537M
 cMEmvbBd1kG4DrVFFO28TimoJ7NYx9r+DXHrSKS/DbVuXgAX8GMaLNgHWaFDi0SHDOmc
 4KT325JPETUH2sH66viASA69BwusJwHqOqQxJprArDXkxcJHpjHcZwZpsHhYH9GV9GAl
 QEjQ==
X-Gm-Message-State: AOAM532FIpYCvdyAeCYAicspiiV2vQLPec9axpaN5HRs2MQL/VaEMmh2
 jeynEz0dpuiEouPAAhxp43Sb3a5V2sakrQ==
X-Google-Smtp-Source: ABdhPJx0YbxiH2QZjwSAg/vjsSv2Er5pC1bxKHPOhaAZc6VvVMDyvjQPIme3hac0yFWUZbYAy6gWfA==
X-Received: by 2002:aa7:84d5:0:b029:18a:ae45:54bc with SMTP id
 x21-20020aa784d50000b029018aae4554bcmr15469760pfn.27.1604422856231; 
 Tue, 03 Nov 2020 09:00:56 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id j24sm4042568pjn.9.2020.11.03.09.00.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 09:00:52 -0800 (PST)
Subject: Re: [PATCH 04/14] target/arm: factor MDCR_EL2 common handling
To: remi.denis.courmont@huawei.com, qemu-arm@nongnu.org
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-4-remi.denis.courmont@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fe08bf17-ec53-582b-1d3f-bb78b2403691@linaro.org>
Date: Tue, 3 Nov 2020 09:00:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102105802.39332-4-remi.denis.courmont@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 2:57 AM, remi.denis.courmont@huawei.com wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> This adds a common helper to compute the effective value of MDCR_EL2.
> That is the actual value if EL2 is enabled in the current security
> context, or 0 elsewise.
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/helper.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

