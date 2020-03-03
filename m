Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC1DC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 18:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5307C2072D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 18:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKwoCzBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5307C2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9CPz-00082u-D2
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 13:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j9CP7-00077e-RD
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:36:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j9CP6-0001ti-Qt
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:36:29 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45545)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j9CP6-0001tM-Li
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 13:36:28 -0500
Received: by mail-pl1-x644.google.com with SMTP id b22so1692773pls.12
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 10:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=X1IImt7x0eAq2SbTkLrGAxxgYhVqi+DI9hniu2bAOn0=;
 b=tKwoCzBxA/V9S9qXJJnpWr1nMuk7nCAPpM7vYUhnEgz3vgk9QOc1jX7O2mfVgJAydD
 4lzCm6fUrV2xzKH7G7NPvDWco2M6Koc3urd5eEuQ7l5Nyau0bpgreldipIzHtolMC3R/
 WbR3DJBfDNaIvbLQGqK42PoRzFT+QZQB5gkuRegjpqvyevXbXkZaIqeWOasV9CtUq7ef
 pBKgeNgcjdsxUnUQDJl8Sf1wC0WVe8rmlZivPMigqBQ+jimuVPW0KHaJbrzMj8Z4Dtc4
 dC0A76VaEFMoc3W5g6cUIzoi4OVl5mVugKq+kXhzHtdF8UCegs5SIpreFwnzyKaIibNL
 8rYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X1IImt7x0eAq2SbTkLrGAxxgYhVqi+DI9hniu2bAOn0=;
 b=TgX1nTg+pnVPoet4yXgfghKPRrzsTQ2mrRRJzxLJPe1UO5zmdT5ivxD+aw2c5AXG62
 qtnZYaMDUhkYpMociGMcUKl8TDrVc7ZEAjFAhewu/ncPOQDkD34tQZJtAhbMUA+dJW8A
 m8HbUivNVmIm1nf+SKm49rITCN+FNOoRqb1sf36fpVODBUOqH91vC/jD/BiG1FHelxyr
 ztQML2RN12txu3RzZruXNaD/Nlh4gvAmWc552p03Z0yEumf8tJW2kF7GFh4vUDbDkQuh
 Ng3ZrgL5dxPtg5o7vJk86piRfIGcKXfjkxdw6sYVZSISh8P9BT2Yg7OohwLpMD75buf3
 qKKw==
X-Gm-Message-State: ANhLgQ3LydcnGrvdbCdUkbaP3MoDDvibDdY1Wq3fc8ABdxC87JGQ9UvU
 lz3XI1PchjoC3EEYrquIcaYFEDfnAUs=
X-Google-Smtp-Source: ADFU+vuLFn7vsQ/tiZYnVFc3o7Z8Ijql3sZ89dU+gJxoxLsJG4ZRNwplEjNHatop3E2D1kMPvOaeYw==
X-Received: by 2002:a17:90a:b009:: with SMTP id
 x9mr5336433pjq.124.1583260587447; 
 Tue, 03 Mar 2020 10:36:27 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z6sm351976pfq.39.2020.03.03.10.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2020 10:36:26 -0800 (PST)
Subject: Re: [PATCH 2/4] target/arm: Update hflags in trans_CPS_v7m()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200303174950.3298-1-peter.maydell@linaro.org>
 <20200303174950.3298-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4c321c94-8b3c-3099-aea9-ab3eebc66e99@linaro.org>
Date: Tue, 3 Mar 2020 10:36:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303174950.3298-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

On 3/3/20 9:49 AM, Peter Maydell wrote:
> For M-profile CPUs, the FAULTMASK value affects the CPU's MMU index
> (it changes the NegPri bit). We update the hflags after calls
> to the v7m_msr helper in trans_MSR_v7m() but forgot to do so
> in trans_CPS_v7m().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

