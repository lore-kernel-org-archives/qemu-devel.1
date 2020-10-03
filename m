Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1103EC41604
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 16:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CC3206DD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 16:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZFwqZAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CC3206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOkcy-0004Pt-Uo
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 12:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOkcF-0003uc-43
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 12:42:35 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOkcB-0005En-UN
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 12:42:34 -0400
Received: by mail-ot1-x343.google.com with SMTP id u25so4483221otq.6
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 09:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8yPkfA2wZOoIuEJH6f80huAhzNipziIHTSHiZcCxKQo=;
 b=RZFwqZAovl7bwzM6lOqCYpMhSbK8VsEQSIQbiqU0ZFecvHWPQp5SqdTvx0S0HPoVlF
 LcYMOHS595x1IcqlZVnstVSq8l4mLdQn/9j07Ot5m5l0bhRQOKwVBUO7CY0lfr6jXFjp
 nvfcuY0SS9VMUkq8ceSGiDb57qh7fS77QASnnAJt1FDsf9TsIKCNXtHWaFjxK0AhAgKV
 6jdq7snT4sxj5DIQaeVF3tVdSulb9KqqHcTPhloh16EyNgRgBJhzSFr17BEAvHYVzQZg
 9h5DlNpdm1e22iewDXBc+hbNiVliVApJLQ2oLXPm6Bb5RXAIIssrFc+EaWgjQlkTR/p2
 PE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8yPkfA2wZOoIuEJH6f80huAhzNipziIHTSHiZcCxKQo=;
 b=FOSf4VL7fLUXkrciyffOxt6X29F3G9IkWsmhJ5HhUfmJ7SF/K25R0S96CF7480ZPUY
 ptKYKoS7XSShYd0V/UGaLl6g3zZo+KrQnanNCak1+1nM5qKyUR8546nL02XGQ/YlIIBK
 JmkddFETMqfVUBFF99Ska2/1kM04kxSCtr9efJfks7gbBSu9gWdN/jKql/zIPreTiVYe
 VioMfkV3jTsytE5HCqO2MyLfcmhstXNYzEbrdSRMZpJ7WtRw/kwv+QL3ELu51lXQWneA
 iwURNNDvMr2sKDUFYvX2AwVa37qXpVHiJGdgZGIrt92VY2hj4KogQaZw1c07il/Bpkdi
 VozA==
X-Gm-Message-State: AOAM530aBz0KiJKDH7n1IMn3beGOwY9DddcCPYogxUlzABP0CVJPncOb
 OhWO4acD9W7DJF4ZdvNjA2vcPg==
X-Google-Smtp-Source: ABdhPJza1y3srsMj1CBPNNw1gcJDJSFHJLhrV0GmmpYjVCq21wS3AwjjROK+/8+xMY47SXSbcSfsfw==
X-Received: by 2002:a9d:4e8f:: with SMTP id v15mr5457248otk.121.1601743350331; 
 Sat, 03 Oct 2020 09:42:30 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id k128sm290911oib.52.2020.10.03.09.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 09:42:29 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] hw/timer/bcm2835: Introduce BCM2835_SYSTIMER_COUNT
 definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201002164216.1741110-1-f4bug@amsat.org>
 <20201002164216.1741110-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <699e6f0a-1db2-3a80-101b-fc2f84e41bb0@linaro.org>
Date: Sat, 3 Oct 2020 11:42:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002164216.1741110-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.252,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 11:42 AM, Philippe Mathieu-Daudé wrote:
> Use the BCM2835_SYSTIMER_COUNT definition instead of the
> magic '4' value.
> 
> Reviewed-by: Luc Michel <luc.michel@greensocs.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/timer/bcm2835_systmr.h | 4 +++-
>  hw/timer/bcm2835_systmr.c         | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

