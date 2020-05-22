Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B76EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB0B2078B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXYim05B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB0B2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jby0v-000600-Gw
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 23:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jby0G-0005V0-4x
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:05:44 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jby0F-0003Yg-8I
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:05:43 -0400
Received: by mail-pj1-x1043.google.com with SMTP id t8so2262069pju.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 20:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zDI/cC68y9Xtb2dfQ8wJ6nYgzR1AdykJatDlMiotk4o=;
 b=DXYim05Bm2ACQi3qSPEKTtqzDPRQSCXW0wwYwM+CB7xM359QW3DLVT9ct5UAY9pol0
 21zfC5x2MiAT/OQFwB0aXQ3yq9pM6Bs2HwzjDOIPIXb5hY85A8zAJqC6enP5ixzypb1E
 gBQyYHDsqHZ/I7k9GubqPENo1lD8GChbo3oV3sESU5/HG9iueAVZm49Ofcyqg9Baqs0B
 p1KcWVHG13NTqwpHZJOLTx/+c/2udDT+W8b0b4TZaMicu+V+mKvg1Qwd8DSpv7+mOz5R
 m+qqAdKpaCS16i7tYBgJAXDOZuOjS3eLi7JA/36Sxavb8oBIIPi4WiCfH7OpqoN2/mx+
 YfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zDI/cC68y9Xtb2dfQ8wJ6nYgzR1AdykJatDlMiotk4o=;
 b=qXTtPx3f+VFPU57Hj+DSaHWlXXvlm8x942fbKUxV+b/ACJdQT+PrT3/XOG7cbsNLBq
 vtQCK3BqmhK1FoeSEtRS1Knys+8Wg5LKqCqbhVc8sFWgx1mKhbVJ13A91PhOsqrQUZMl
 Ib5DD9K6PymemFQPsHdlilND72QhN8vWvVG9xnIW6Z7Zct1RUJhRUrXHuupw4zwKVpHX
 jg7P3gkHcVijb7h2Y4SpFkQcu7RWIboXgsfcNLKbsQyUhQFCI8jZWBTBeJaxw9JAOUO+
 Ma3BuI/br6QnaL+Zs+PxpfYZxRqJIX3yhdaW39HUr+2iPRa/BNczSeJFt7mPC8/pq4yj
 ahcg==
X-Gm-Message-State: AOAM532rCOlOkbayeus+24OFDsGJOuLP0SvUpGeZRk0V1EYAzxSd1e9t
 OmQVeJVzy0WT7BP+tYnltPmoIg==
X-Google-Smtp-Source: ABdhPJzd+kEdinQGknB64k1M+iuG+rxDtU4XIWHpqBd75197uas6LRglUC+BaoA87BvGKZ9A9QS1/w==
X-Received: by 2002:a17:902:9049:: with SMTP id
 w9mr12911487plz.27.1590116741377; 
 Thu, 21 May 2020 20:05:41 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p9sm4994707pgb.19.2020.05.21.20.05.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 20:05:40 -0700 (PDT)
Subject: Re: [PATCH v1 11/15] tests/tcg/aarch64: Add bti smoke test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200520140541.30256-1-alex.bennee@linaro.org>
 <20200520140541.30256-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cbe6d55f-b593-a802-f0e0-8abd63d4a4f9@linaro.org>
Date: Thu, 21 May 2020 20:05:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520140541.30256-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 7:05 AM, Alex Bennée wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Requires gcc 10 for -mbranch-protection=standard.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20200520023139.9812-3-richard.henderson@linaro.org>
> [AJB: add CROSS_CC_HAS_ARMV8_BTI check]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/aarch64/bti-1.c         | 62 +++++++++++++++++++++++++++++++
>  tests/tcg/aarch64/bti-crt.inc.c   | 51 +++++++++++++++++++++++++
>  tests/tcg/aarch64/Makefile.target |  9 +++++
>  tests/tcg/configure.sh            |  4 ++
>  4 files changed, 126 insertions(+)
>  create mode 100644 tests/tcg/aarch64/bti-1.c
>  create mode 100644 tests/tcg/aarch64/bti-crt.inc.c

This should be dropped from this patch set.  I have adjusted it and it and
posted as

https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05891.html


r~

