Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ADCC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2402189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhycOE3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2402189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiiTj-0006kp-72
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36421)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hiiDs-0002Yz-RH
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hiiDq-0007Cr-TZ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:35:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hiiDp-000785-2k
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:35:06 -0400
Received: by mail-wm1-x343.google.com with SMTP id a15so2869212wmj.5
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qaGODbYJKsxE/CqG0c/kMGgXk1sGBE9vDO+cWlS4gVQ=;
 b=XhycOE3zX977xr6vIqBIUjNd9o8TK1F4TDPx06fGeZrWfh1iBRmfp13v0I9oRseLYO
 pes2TdDmV9TbaDk0GSfh3po7rVidVvqiXxDjs2kmFJxvpP9A3pJs6VMNBrnui6gl3p8u
 cLz5Asn7tjyhAoXEbDN3kZ3hRAyvjxCpkp8/TZpXJ6dX6RivHBPkzoglGVJ2c5tsV9Q5
 PgGbToL8O9F3gv4lY6Cz16Zbx+sNjYPtnRyGd94Wd4ymhjAxbDnKJvGkgzLyU+0YfGyp
 BGQa+dvsYCWlN8Rrv2Ebqecj+1Bkk6eXfLPF4qPpc9eh7Mge535GYVbmK5HHpiIi7gpb
 zEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qaGODbYJKsxE/CqG0c/kMGgXk1sGBE9vDO+cWlS4gVQ=;
 b=DLJghecsl9BEUqxgLmFa1jruYM4FUZsIqCQ9iz0mOUoL3EYCAUByMJ4czC0evbKUB+
 gnMLlzDPtqrcvW8U8QltlnwrwgsCz4C2C4APCYUJGC06rv5rJL1bJJZypcErj/2h+XSo
 TEPImjHVTGhwh1wO72bV3hrqQ7gv6AHUugua2I5k9rXd7jZlKkvakObrEuWaTEvEztzJ
 Tpu/+KRBZfuy/5PcwoqObNfnvCKg87C8WjAA0BISGRsfuOBNGhum/cuSdZfxQI8xWBPf
 w1HiUeyCPkWFhCepSefgNMv3lrCbyWLEWao0vZ0/9hKPLTHcVF+3KbssBEi+Ujm92q2e
 sSdA==
X-Gm-Message-State: APjAAAVaPaDSE72a/BwbqgK7dFcnsZpuzUdKtbiB8LlEfR8zfq9GpKwb
 pt3L6ahU2po9QMeow63yC+JnJw==
X-Google-Smtp-Source: APXvYqwAcLEIazn1Dpw2KBfxADhgZQz7f3OF1yEEX87evuT/xi9dz/YKpfJA8al79HBu3I/BKLsfoQ==
X-Received: by 2002:a1c:1d83:: with SMTP id d125mr8588366wmd.63.1562171702441; 
 Wed, 03 Jul 2019 09:35:02 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id x129sm2678662wmg.44.2019.07.03.09.35.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 09:35:01 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190703155244.28166-1-alex.bennee@linaro.org>
 <20190703155244.28166-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3081fb0b-0e87-6907-4055-e939c1f52573@linaro.org>
Date: Wed, 3 Jul 2019 18:35:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190703155244.28166-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v1 3/4] target/arm: handle A-profile A32
 semihosting at translate time
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/19 5:52 PM, Alex Bennée wrote:
> As for the other semihosting calls we can resolve this at translate
> time.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/translate.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


