Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B780CC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8358020738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXZG7KMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8358020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3y9-0001OI-S1
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv3xU-0000yO-2f
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:17:48 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv3xS-0005pT-GT
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:17:47 -0400
Received: by mail-pf1-x444.google.com with SMTP id 207so6446985pfu.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ie+WsQlsMhuybBRTeB883QisVS/fIKad5PGQNZ6h6tM=;
 b=bXZG7KMbHkWORD4fjgHgm9QNM4fLgX5kHEozZRu+T/fzEwquBBFE5cqWDkHWm859IP
 ozV2SZ4aubwsESxei/iMm5f4Q/SnbCpzQgDvNSk5b7MUKmVJQyM0Rfly3hPpHhJsNCfN
 H2lJukhyaL0P5TXlvGrpTlmHiZ3fYE4e3lMEyK2A0JxA3ZBZeys5Y6kZBSZ8Kkjj8js6
 k6WxwR43n27W7HzqFrRuUkYei1DJvaA65Ix/81KXOJxm2ry6fquQqvlOllpYOlLcO4qh
 V87l4ev1wfatgQFeH35100lcjyYcdfjFTEjzUwDh9Nfv5trDxmEefMQT46yPOYq3KKee
 1HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ie+WsQlsMhuybBRTeB883QisVS/fIKad5PGQNZ6h6tM=;
 b=seUrhi80AAQJnXKqkuPFpWT4ufN+8HqgTZ7CJYUP6FdJPyStXdq0lNZ9UCd1tLT01P
 gpL39HpJ7ef5OutBigsqeuTG6Pm02caZ1G7yqPdoPTIXP5qgaTAXoRb1mgzQrrviJWPh
 Z2FUIyk+uXhaeiwlAzsZ+FgnNbyfzscmndx6SyVfc+iNlkZ6PNf12OcDxkaGyFVj7s8T
 BnAAy6Ztsg459EHFAKel4tio0nWfNpaPKA72hnZaT/ZgtPLnfQtfUEZs/uQnspXoba9t
 jj+cswzlgZhhxhfCBOr1K+ACZ9wRAu8RPCJmhpetm/B320BGuLBeBK5bEwmzzj1A7nQX
 HDtw==
X-Gm-Message-State: AOAM530+zoHazYLCfvGJULTEVpowg8qsynHM4GzuN5KDJ9i1/dF9NqQ7
 nSwe/jD0Qmc44FpmNapgHJzsnA==
X-Google-Smtp-Source: ABdhPJxXw6MIL85H03mG50hmctA3xoVm2qN1DlV0x8FLnrcMRJ9pO8QntG67A+VXUeWIcPnziXbIQg==
X-Received: by 2002:aa7:984d:: with SMTP id n13mr1240654pfq.276.1594667864874; 
 Mon, 13 Jul 2020 12:17:44 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 200sm15506776pfy.57.2020.07.13.12.17.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 12:17:43 -0700 (PDT)
Subject: Re: [RFC PATCH 2/8] fpu/softfloat: use the similiar logic to
 recognize sNaN and qNaN
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org
References: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
 <20200712234521.3972-3-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a213775-58f4-a4d3-a61e-469d0f33913d@linaro.org>
Date: Mon, 13 Jul 2020 12:17:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200712234521.3972-3-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: wenmeng_zhang@c-sky.com, alex.bennee@linaro.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 4:45 PM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  fpu/softfloat-specialize.inc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fpu/softfloat-specialize.inc.c b/fpu/softfloat-specialize.inc.c
> index 034d18199c..6b778a7830 100644
> --- a/fpu/softfloat-specialize.inc.c
> +++ b/fpu/softfloat-specialize.inc.c
> @@ -292,7 +292,7 @@ bool float32_is_quiet_nan(float32 a_, float_status *status)
>      if (snan_bit_is_one(status)) {
>          return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
>      } else {
> -        return ((uint32_t)(a << 1) >= 0xFF800000);
> +        return ((a >> 22) & 0x1FF) == 0x1FF;
>      }
>  #endif
>  }

I don't see a reason for this.  The previous was a bug, but this isn't.


r~

