Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F3CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A38206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kIP7kjfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A38206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsW5-0006tg-5U
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsUU-0004uA-SS
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:53:38 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsUT-0006Am-6f
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:53:38 -0400
Received: by mail-pf1-x444.google.com with SMTP id v196so2809845pfc.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 09:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fbwpneG5o59vmNAjanEnGADhFy93GeEDDek/Um9ewSk=;
 b=kIP7kjfVQ5n1WF/nWYQ/zgqhiOhPLeXpD7jLk2jiEIPtNju0TxFiECqhx1WfIX4mBb
 aPZai7BrxanCHKlFAWI9J+IwGEDNiYCFwUAU5I85J5ZweShQ6Ow2YxbHY4D9YatLbKFB
 9fFAQy9IHGOubdnXG35xr3PG3py6rjftabjA6Dh6aFyTz2WBkZ2ahCM1WvEXvosHFO4J
 NqSZ8W8GHUvn2KBpOyIc1zcgypkN5JtiIY7Z3HJTQdjpGQZBaH7OXfavuM7NbY5aL3Q7
 BBKz02PR0/5bVqNpP/iUeGHMMVPVte0IMN/up6QS6Zpx4BtF0UvcP/welaML+Y5WHWe7
 ixFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fbwpneG5o59vmNAjanEnGADhFy93GeEDDek/Um9ewSk=;
 b=IqnbjIhZqkhkW5Hn6rm8Cbal2Fl6q18LTpv1SL86MkKvVjecR1OLLPVLq8dnzrBFjq
 Xd8LNtQ/YrOm5nUUwDEz8yWwhAnUVid8+CcJ6jl6H82nPM8+u4EFfk1sRFrkTFSSl/0b
 UUpFEseM9+U4ZeX3f0Xcwt9DnxNrMwkvJ0rxmruKnKAGUz2YW/PyYAs4v+OchpgnZTTe
 +Oa//cfUwjlcYbPJJGbDL3ytJjP18IgeX6er76bKKFDXZiMSAi7bhEo7aSPvxIHni3hM
 2/Rb2FTkyYdEyjqC0uRqnY2q+cyvXGWmS+RiluI/KIuoxu/RYLkXyCzviNF1xemRKOJa
 OO0g==
X-Gm-Message-State: AOAM531SO3uicakrA0HJWVc4LROkyIAf/MA/wHnX0TQ98JOTpgJHZvKn
 KFLSSOyCd8U/539Zdgrx/9y8IQ==
X-Google-Smtp-Source: ABdhPJyG3sCYg8MLm6rp3FRBOeQiZ7PgPhgeFkwGl4u8L9t2z3QvSPucQFJwiLoJKRGD1VaE/3I4oQ==
X-Received: by 2002:a63:31d2:: with SMTP id x201mr3854059pgx.263.1599152015960; 
 Thu, 03 Sep 2020 09:53:35 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id u14sm3227556pfc.203.2020.09.03.09.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 09:53:34 -0700 (PDT)
Subject: Re: [PATCH v6 5/8] util: add Error object for qemu_open_internal
 error reporting
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200903152210.1917355-1-berrange@redhat.com>
 <20200903152210.1917355-6-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6d15333a-ad28-6e61-6432-e3b4bc427a17@linaro.org>
Date: Thu, 3 Sep 2020 09:53:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903152210.1917355-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 8:22 AM, Daniel P. Berrangé wrote:
> Instead of relying on the limited information from errno, we can now
> also provide detailed error messages to callers that ask for it.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  util/osdep.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


