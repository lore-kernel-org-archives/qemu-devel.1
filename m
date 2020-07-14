Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D53BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3385D22365
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rSysSiIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3385D22365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLJl-0003mm-EK
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLIx-0002nt-QR
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:49:07 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:39131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLIv-0002JL-PZ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:49:07 -0400
Received: by mail-pj1-x1044.google.com with SMTP id b92so1542039pjc.4
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jg/D1KeTkUPZaYtuyV+8WgeIArn8o31gf3qjjXyMHwY=;
 b=rSysSiIP8h9928Yi7oGt2LjS4fNoGezqDNRG9KLO7l9Yu2ge2TZJgVpqACQb+TBCFS
 OOFSTJOUNT8XKf7C+8sxN+uatoU0zj+1cvgGUCQmIVuUz0R/bMvUhZ2VyUTe7HWHgo2Q
 4K6OJMvgsNseBs6CoB14wyXSvNatebUP6OoH6srviycJcDeW9a+ImWs1lQb3WOpBSL/A
 RPLjb7MAwtxvtJrPjWj6Rjde3xMH6Rlg3O4eYCU68qLMeSnw6G8TMDTwrVaj/JJrAT7h
 GGpHx7BLmWmRcAdl3JGBwM77xX28F9zsm7JBe9U0i+2v9b+JWB42qjU6/0AURrkwHQ6/
 5U7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jg/D1KeTkUPZaYtuyV+8WgeIArn8o31gf3qjjXyMHwY=;
 b=nLOo9YHPha1yX4SZqZvTYlO7gpGj7KLQZRpaJPRS+riCUcI/7oLkdgtkg7YZ+UevRl
 KGJFDqhXSUiQ9npkPNPEh8W0DTTjJYylxipo2S8XVfNg0+Ot1NZedX2aDL5OShSRykGm
 V+OmNVOiclME4NOe9Pc5SJ0q+IQo37uBxgGgMIffidvwL9kye4CYOzWxwbaEd52Ftmbw
 IkEgg8PwKFMLNF0+Rs7LsXCZFngL8N7OnybG8GqQjmefmCdpRQFM06SXWFuS5GPCYtNW
 0hjeUxTOrVAk09WV84vSSG8ZzjcSM2XgfgnDWc9XjDLy7X2o4Y5WibOD10YMqZIAHviq
 XpwA==
X-Gm-Message-State: AOAM5333JzPlcJn9H4MMqdUTK++1zO+PO5bVYnwk+ovVAdVEsVkNRPCM
 P/Q0HnazjLlKK+JcyDB+sSKY1g==
X-Google-Smtp-Source: ABdhPJxusqjMqMVnvXab5oE9IvJ25TctpU4diOYO4Mq5iQPsT37ph+3pSdccfbSt2vYFg9DvJiks3Q==
X-Received: by 2002:a17:902:728c:: with SMTP id
 d12mr4030973pll.155.1594734544242; 
 Tue, 14 Jul 2020 06:49:04 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id t1sm2875030pje.55.2020.07.14.06.49.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 06:49:03 -0700 (PDT)
Subject: Re: [PATCH] vnc: Remove the superfluous break
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594600436-23162-1-git-send-email-wang.yi59@zte.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2482366c-19eb-001e-47f9-0dd313b016c5@linaro.org>
Date: Tue, 14 Jul 2020 06:49:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594600436-23162-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: xue.zhihong@zte.com.cn, qemu-trivial <qemu-trivial@nongnu.org>,
 wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 5:33 PM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove the superfluous break, as there is a "return" before.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
>  ui/vnc-enc-tight.c | 1 -
>  1 file changed, 1 deletion(-)

Cc: qemu-trivial
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

