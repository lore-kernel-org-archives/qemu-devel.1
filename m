Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B15CFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3612720854
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhPtaBhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3612720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL75h-0003BR-Ps
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iL6We-0000g1-Lv
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iL6Wd-0000ip-Hz
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:13:12 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iL6Wd-0000fg-74
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:13:11 -0400
Received: by mail-pl1-x641.google.com with SMTP id u20so1205260plq.4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ncZZKTj+JLdpJh3OEt20ZcEqe7Mn2RwqY7iUd1RZ5mc=;
 b=MhPtaBhMBo7Cmz1HYA1hmgGUaUkcf7a38chZBqGGQwZTtF1ZE6p9Y7PelsiU3sdnlQ
 XYeHe31eH3e5uOA/aNoDsEr+kRZzl4aQiPTAvxnrGLBVuJgsPskFWrWDBiMAXZvlr6jo
 2usC3k6mpblRWreL0QeEs0oGIUXFxPERypXCB4BmJYZ0GrYFf/26QOpyeMJVlCJ4xA3S
 84bUpTYeW0ELh5nm2EobVjnaevH9vBYgEmYQszpKmOQvRPcJVa+iNl/LLhPUr/E1iuAp
 UGRXaZ19iXKMqpjyDUgNeQNh2zR3ISLlsZsb/T17wR1UOWkBM1BUeB8acbo+wX//zcvq
 7alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ncZZKTj+JLdpJh3OEt20ZcEqe7Mn2RwqY7iUd1RZ5mc=;
 b=nQKmvYj2CaymClMqJTDZXbT44xgaZZwn88gWwlkrCzhOwzEBMtAojsfw/dTslR4pFO
 NBHv2lmll/ZSZxOqUkFaFHdlnl/dLNRfFjzRaq6o9ZWEjBtRBvulJOeJHCrgFLKmOuoe
 v19Z+NsS8oSlD/lykwUxaeYyWxt5znLE/8KE7KvAiuulqmDtdz9oYbNMVaSMyTzfOCEy
 lxMzrZGcccrBOo1RjBziWGHzVLfI7EKO9ZQ5U/WDo6zIspxZCC8vcZ3EsArBavkR0BKn
 rBVmmw+K+kCkvm1Bz42Yp5DbQDW/BdkH2+r8ARHt6Qi/TUAtQWlocVIterI8cxILbmG0
 gZ5w==
X-Gm-Message-State: APjAAAXEZ7SVjRgEZ8wWsKuWOOmnUX0X5YDBAfFPsceaONLOwva7FN/D
 3YQVrmz6jzMy5472vIU/jAvNYA==
X-Google-Smtp-Source: APXvYqwufnX13MFbqaDrh9VD1htSl4eSCTR07oxCLvxGZWHjbGjXt0qdOHOlgcE/73u2aqZL/tSdfw==
X-Received: by 2002:a17:902:aa02:: with SMTP id
 be2mr4284215plb.326.1571321585175; 
 Thu, 17 Oct 2019 07:13:05 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q26sm1399746pgk.60.2019.10.17.07.13.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Oct 2019 07:13:04 -0700 (PDT)
Subject: Re: [PATCH 1/3] hw/net/fsl_etsec/etsec.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132122.4402-1-peter.maydell@linaro.org>
 <20191017132122.4402-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <45d7e704-c22c-dfec-9f54-c73568f31ccc@linaro.org>
Date: Thu, 17 Oct 2019 07:13:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017132122.4402-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 6:21 AM, Peter Maydell wrote:
> Switch the fsl_etsec code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/net/fsl_etsec/etsec.h | 1 -
>  hw/net/fsl_etsec/etsec.c | 9 +++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

