Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869D7C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A734206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lih9ADrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A734206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsXP-0000Xn-E7
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsWI-0007XR-7n
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:55:30 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:37621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsWE-0006cG-W4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:55:29 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mw10so1757124pjb.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xixXR6txDil36bLKtu6slbQXCG/+KT1Mjn/eTXmikks=;
 b=lih9ADrLRCXPbI3l1xg0nfTg3elLhZaXvVe9UdkPlUrjgfBOHdwpLQl6JhDsGUdXUM
 rn0Hrpn4/YpHd8y4A39IIUec+arZ/USdHWTzQOwhTEFnv/GBDJ2Q3SVhC+EGu8khhACx
 S13KnhNhHNmfkSru/ODLKLDbzDtr7O1vtn7BPnDdV9WdvdWlLQ8gQdMoC0RDEqtZBgA/
 B+n5PapThpHhKBVEhXYx7pH8HxPwwpzfBiSkFhH9BEeJ2fAaGn97bfHxNM7lHi6ShMB4
 5hy2Dya2y1B9T3PpGVUS5l2iDWz9IhW+Jos7bJZKU2tD/edTLwJEhUQ6vin3pVMy0cjp
 t1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xixXR6txDil36bLKtu6slbQXCG/+KT1Mjn/eTXmikks=;
 b=ktccQfUvh8aGpYfFF79d9zqUYnygsmNC68NROW7YBA/QRIiUxEEefVsTpRbcUsw1yN
 UKcZuE327ioachG7/7xVqkalfaALigEJsJujdhhG+q1hC3H5qbeokq/5ZmGStfO7rLmk
 N5ks8EeQoo5LC9ux7Kl2LkhEgA6tpSOosIDQ3BTjSHRKRH6h7ipy2lauHykAXhOHVZFM
 ovvfgFb3WGWPEclIhetgh+yBPu/JHcf728aeS2o486cxrWhZY4Vwxxsitk1NsM9zvnbY
 Yvgtu9aEfs3VU4e02f9zADjkrK3fJYGsXrYsrpWHhaPZybQIywxqSulSBceZPWd8qlpA
 vvpw==
X-Gm-Message-State: AOAM532AvHqJFAn/8ZLrJmPL3Y+K5nHIDKDVDH1x7yNh71FevDSReXGR
 0VvwpnDIpgm7oxYPzYnYhlxykA==
X-Google-Smtp-Source: ABdhPJxGzqj3v2i4rYAmf0h1VGRnpVvExzso6TPRAhd+XTuQcZLIfzxa/YS0p7GotxHFs5E/3Vl2BA==
X-Received: by 2002:a17:90a:468d:: with SMTP id
 z13mr4125450pjf.105.1599152125573; 
 Thu, 03 Sep 2020 09:55:25 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id p190sm3744879pfp.9.2020.09.03.09.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 09:55:24 -0700 (PDT)
Subject: Re: [PATCH v6 7/8] util: give a specific error message when O_DIRECT
 doesn't work
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200903152210.1917355-1-berrange@redhat.com>
 <20200903152210.1917355-8-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c741505d-853e-774f-5adf-f28327a06678@linaro.org>
Date: Thu, 3 Sep 2020 09:55:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903152210.1917355-8-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 8:22 AM, Daniel P. Berrangé wrote:
> A common error scenario is to tell QEMU to use O_DIRECT in combination
> with a filesystem that doesn't support it. To aid users to diagnosing
> their mistake we want to provide a clear error message when this happens.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  util/osdep.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


