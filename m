Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C163AC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B96A20B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUdpUth2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B96A20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIEmz-0005vc-0m
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1tY-0001hy-Vf
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 22:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iI1FR-0004dJ-Ky
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:58:43 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:38627)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iI1FR-0004cq-GR
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:58:41 -0400
Received: by mail-yw1-xc41.google.com with SMTP id s6so236903ywe.5
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 18:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8UMEmM0M8spBbkixIMqYmPrgIc0DqB9gcnQ2zQpAiZo=;
 b=vUdpUth2EV7mAedIqN/tWOmpyo4ZmeVAPWj9+ak9aTBwJNE+ZXVIyjnySkS2RC/WVX
 iJJ9+La6qrBTEDeKvhlivGiEw7UWzXhlzKn/fzuGzGB/P81xyUZIsuh6jB7bQU53eiS/
 B/7tMm+z+pW+8zMEEwzBquMGV0tsnb6aC/6vs97VD5VATpAYUE/nECb+3Hq5Df7P4XKi
 hTjLgHiihNybNiEGQv7gi/gthK+ja1JMgUB0Rm5/pTyWWbqPd4DS+mJkNI6YWOyeCNru
 ze7XAJBdhkaVZ/7ZVwGiMJ4dQIOTCPNe8ZevDbaM+HVvQjkkCe2e9xG0RRcUF5y2Ded8
 5TNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8UMEmM0M8spBbkixIMqYmPrgIc0DqB9gcnQ2zQpAiZo=;
 b=B8JgDGzEKID5B/FtzfYQYXcNdpZiU/70gk/7kZ3XOqr0oi6P/r9dzgcZP2uPjdxOwG
 eqXAOkKG1EXqgp8UZQZxzJre7/cYexIxhTy9uruKH416dDujFo5lLi+hul2ZLqppnwCJ
 n/f6L3Sct+fClNSkgjne92Yu8BF1PPvu3DTakOfuA2QMz421S8IDqrHKLiW1eB0dt6fB
 73RhwkZx6Iv39PI5A0/VIcbBgLHPEPPgHD98HN99gGNZCbG186pZY0VtkoUneeII6rcu
 a4a3myFSkI2Aglqe4sFk8nRMlHbFUNLHLsd0QHKOjv/CwtNCMmpSt/pvmy0zuAICofhM
 GN2A==
X-Gm-Message-State: APjAAAWQv8Oh7anHM2Q/N1TeEa4dQFT2PhCafSC8oaOkOcUNBXxW+rM/
 VGTbdIXGuUwlKKpiqU+yEswj5A==
X-Google-Smtp-Source: APXvYqwFSqkV43fQCR3ydzXBh8lC2AcA0tveUrgcTm281rnrrnMb/s7BDheDnGOC4sbHm3Aas5jfGw==
X-Received: by 2002:a0d:f8c6:: with SMTP id i189mr960585ywf.411.1570586320530; 
 Tue, 08 Oct 2019 18:58:40 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id y67sm234362ywd.63.2019.10.08.18.58.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Oct 2019 18:58:39 -0700 (PDT)
Subject: Re: [PATCH v2 12/21] hw/timer/exynos4210_mct.c: Switch LFRC to
 transaction-based ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191008171740.9679-1-peter.maydell@linaro.org>
 <20191008171740.9679-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a15bd258-a909-557a-0bbc-9cc16141b2f1@linaro.org>
Date: Tue, 8 Oct 2019 21:58:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008171740.9679-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 1:17 PM, Peter Maydell wrote:
> Switch the exynos MCT LFRC timers over to the ptimer transaction API.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/exynos4210_mct.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

