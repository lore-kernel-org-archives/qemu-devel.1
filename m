Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B09FC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9830206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TC4pZUX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9830206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1aKH-0001R0-1F
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aJ8-0000Ap-Lx
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aJ7-0000Rq-Mv
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:30:50 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1aJ7-0000Q7-GH
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:30:49 -0500
Received: by mail-pf1-x442.google.com with SMTP id k29so5880603pfp.13
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=48p9j7a2FQ69RWmeEDij6QMtYa6lvA8nNR4+fSAJxwc=;
 b=TC4pZUX1Nmlvxtwlkzo4Zsqv+ZQW5nZKfHfVawjfI3aBS8ntEJjXdi9AL9si9E6ABQ
 Os2wKfzD3X4VU0RkOllmKZT1f8jWZ9OxK/ig8HZgNWX23TfCpipepX4JrcmCjXLmCcR4
 BPMK1Vq841B7cBU34PLujbsKmfdmZ2loCUfTLgA7MixpvTLu0BjFVef7V7HqBYvCmk/T
 hFtvETkUFwn2Ustt6ikY1+zEuOOw6HC1Kdb78dKMtnkrnpU2dNQGXq4VbKl7zy/ktFOY
 TUtsyIKyyKHAZI7fcdmT4HU7z25aGNBBvfWxus7eNeVSbyl/gYQcWugGMo2JSjkssrDN
 HaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=48p9j7a2FQ69RWmeEDij6QMtYa6lvA8nNR4+fSAJxwc=;
 b=I6L32kt8vN7srl5J+NDacHnrKxPttufOftuHgYSjsvyxhZ9OhY7lJswmM6DhfWyTuW
 rzbWwsW+YwcZOxePVWZxHg+WPypIV4aAjk0oZmBMve8GEb4LnHO9r3r7etSWZ86CoW+a
 OTH6r9MVT1+SOKivOm73MDZwa8d0GmeKB2Q9bi6nxWqIQWkthccq+UOs1htEwnlaEz69
 12sizKsQFKvH3+/EFlVZsG3AGcXosvJ0HJD5g0SwCvpfLgPYflpCQZzvMVq9cIio3Fhi
 TVv+UqFNPkdfVeH5ukoA1rdLuOgl6mTr4GQrNhvhnxaAUjtvc2+hOx4QqkSZoJnq+sXE
 ghag==
X-Gm-Message-State: APjAAAXi/ucjfb98OIF21vbQOBzzpwQdR67XOqzqeeikadwe5zlSK/Oe
 9noCMM4jXXJvhRfsMyhGaUMqtw==
X-Google-Smtp-Source: APXvYqxIdi1XxIY/lBZ18Rf/8zjydTO7Rps5m0YUhfLxmpc4kKbq/W/dmQj6HszmrSnKBFW1h9rYoA==
X-Received: by 2002:a63:445e:: with SMTP id t30mr8269006pgk.367.1581445848444; 
 Tue, 11 Feb 2020 10:30:48 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 u11sm4120486pjn.2.2020.02.11.10.30.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 10:30:47 -0800 (PST)
Subject: Re: [PATCH 04/13] target/arm: Factor out PMU register definitions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <39d47875-a324-e3dc-d61b-6a419642dfd3@linaro.org>
Date: Tue, 11 Feb 2020 10:30:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 9:37 AM, Peter Maydell wrote:
> Pull the code that defines the various PMU registers out
> into its own function, matching the pattern we have
> already for the debug registers.
> 
> Apart from one style fix to a multi-line comment, this
> is purely movement of code with no changes to it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 158 +++++++++++++++++++++++---------------------
>  1 file changed, 82 insertions(+), 76 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


