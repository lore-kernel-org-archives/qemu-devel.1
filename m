Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA5BC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 20:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86C1206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 20:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvY0yEox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86C1206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htHxC-0005Gh-PI
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 16:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40132)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htHwJ-0004df-Fq
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htHwI-0004eh-Cc
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:44:43 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40399)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htHwI-0004X2-1E
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 16:44:42 -0400
Received: by mail-pl1-x644.google.com with SMTP id a93so32655307pla.7
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 13:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Hhpkuz5VGf9ykB0KK5McS73KJyUkNG7XmJoRwSAg+O8=;
 b=CvY0yEoxYv9VArkXMtvB2tYtTCo1Uszh9h7/OpjqcNVjnZMqbIYQfA7Z6nE9DUzO2m
 BIH1VarHahZn+t8VR/yJD4UDDiDQxLB/QNxlbM5FVK3BUg2o0OqtxqIPI5qPLVtNmQm3
 JFeBcIdY4yKs4iezCeY4xDGbn9IDe5P5A/Gk+CaYgjHAYaEUB0LOek81lzcHVSJY62wi
 8EjUFFdrNxCw1xfcKsMKJsYCqp/kSxwDVDnWPRwrAFtX8+evW4NpGWzBt1j7t+ZWuga/
 VviMutTMhmaAuaoBW0v8rlQl3bXiwLj1m/E618725D27U2SPT9JPVHEpeePyrc74zCa2
 /LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hhpkuz5VGf9ykB0KK5McS73KJyUkNG7XmJoRwSAg+O8=;
 b=jRs2qVpMqS4RndaVkO6WtLVpCfupMH7OHqjL0IJt0QhNM/3bv+JeaOHkJMWijHQHtm
 voQweRpwGA+0JNzcFcgh+Qti2qpboj/5uxT94eQcGYgnq4Ut3SyWnzjyZZkQ31QFcA8g
 Nw9b0JYSG6jQkqF8m8JfAyRiwaebzUmF+XXD62mSZES8Q/XdvQX487C9/lwNt1XcQAUy
 rye849mOU49MxZGtxkSqPaBBmnj9hHJV3hfYplpNWVnUjIlhWJ8d1nSw/I8UPPHXJ2hw
 N8yaB4eNW6A92krH2DAKq2Pwgzeq4ph1+tiAd16baFrLdsEUCCeNcNOjNVs9LcZEJW7b
 +8aw==
X-Gm-Message-State: APjAAAVnQlmRARAD9CSUBNuUOcgOz1VTFiM/RLch70BSiEV33BlK/qBH
 I1xR1oGJWo6B6MAt0WVJ3u6FMvyc2A4=
X-Google-Smtp-Source: APXvYqweAydDNwZjr34fzKF3woH6jCY/vd45kf9RtOxm4Kuqqn3uYYDJ/EBgFaN7L/EaFCq1CTnDog==
X-Received: by 2002:a17:902:e512:: with SMTP id
 ck18mr121277370plb.53.1564692274389; 
 Thu, 01 Aug 2019 13:44:34 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i124sm133291024pfe.61.2019.08.01.13.44.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 13:44:33 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190801183012.17564-1-peter.maydell@linaro.org>
 <20190801183012.17564-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <706e645c-4049-5c19-5c9d-8d597ab4523e@linaro.org>
Date: Thu, 1 Aug 2019 13:44:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801183012.17564-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH 6/7] target/sparc: Remove unused ldl_phys
 from dump_mmu()
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/1/19 11:30 AM, Peter Maydell wrote:
> The dump_mmu() function does a ldl_phys() at the start, but
> then never uses the value it loads at all. Remove the
> unused code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/sparc/mmu_helper.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


