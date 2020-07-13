Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373F8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03FAF20738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AaICnYEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FAF20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3zN-0002UB-CN
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv3yj-0001wS-5R
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:19:05 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv3yh-00065M-MY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:19:04 -0400
Received: by mail-pf1-x442.google.com with SMTP id 1so6428191pfn.9
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 12:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Cz9UW3BFGXzAicalZC8X4be/s5r70xCB4y1DOAG0154=;
 b=AaICnYEn67RB0QU8U7nR7Q8yEPPKlPR2jF5kLBJZgUtLzlchvnoIiuiZDvOQ+LjRhd
 NYYTls+qiaYucwISu5z8i5cayMsWDqD9tkGJuZkYGR8OhBIzjiLLIwRdHGAa84eBkFeU
 WFUVvOlbWVzlRHFglisPSQq0ud7gQ9TMd6CYBWblxw82fd5KzV7K8fCUA2JuLw0wEGRU
 cnxpZ1YnQN+aIs5X9Xosb4sp1YqEAGLYrG9wuJe0n3a26/oSA6GclGSFt9GUh+FNXdW0
 K20CLrw+VJWUZv/0G0z0vcYnP8QJGC2ZGcbMupapzvjbCFnMiD/z/Cj75WKcpHufq0H2
 7n+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Cz9UW3BFGXzAicalZC8X4be/s5r70xCB4y1DOAG0154=;
 b=ZJogr8+ZiwH0vOsE2Oz99JxQ417+E/i8ojfsIBl+iOipOVs9uowCAiTE4hX5VYIEjr
 U0wGgXLFhJfJIxamYKPHpPxG+9NRNpdTxL3ZLs+Ld7sVH0kAF7NHAGlfx8Wh1A/z8p53
 8nFI7S5QP+uUVfEtlAalyKkBTLQrDcvriiOOXNvX4TsKgmcwsNQKhNtK7JdekJMHon/S
 w/hPJ0E8uFbac+NQQhBq48rWl2Yw8i4iFMDYaHMEg3xHIsouR+BBpHRRdDHOoV3AOXV4
 P9vQnlkc/gicslQTaJLEupc0s3ZhiOqxWHst7KVcICd5tt1H+Z494i4MsPFVunphkd47
 1NrA==
X-Gm-Message-State: AOAM531vjHAcCBIwqsC9jz8NWXTa82FnuGDzky5EnKu1Kxx7FqkrIFZk
 mDjZhbPxBr6eYIHFy8xLNkhn3A==
X-Google-Smtp-Source: ABdhPJwXddZh5GBRUuRFsVjriOTF09lZMRisjpJbSYB6tWMllNFZw3hC+F1x6uvMrYe41fs2bTNacA==
X-Received: by 2002:a63:571b:: with SMTP id l27mr526167pgb.417.1594667942283; 
 Mon, 13 Jul 2020 12:19:02 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 127sm13646668pgf.5.2020.07.13.12.19.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 12:19:01 -0700 (PDT)
Subject: Re: [RFC PATCH 3/8] fpu/softfloat: add FloatFmt for bfloat16
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org
References: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
 <20200712234521.3972-4-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c8fa12f7-6200-4eea-b965-c5e4b2915800@linaro.org>
Date: Mon, 13 Jul 2020 12:18:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200712234521.3972-4-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
>  fpu/softfloat.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

