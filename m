Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0F2C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F49A2078B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LsWHfqT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F49A2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDDwy-0007kR-I7
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 17:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDDv6-00072I-9G
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:34:24 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDDv4-00041I-6u
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:34:24 -0400
Received: by mail-pl1-x643.google.com with SMTP id a8so1217159plm.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 14:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8nW5NS6j3gBAYiRTtVWo9ouAU2pPd4jJH8ZgD9DSfAE=;
 b=LsWHfqT54oFHhrOnrcm30t3a56X99TKSJf6YvBUJWYwRpJ2AhAqX6o2MAzp0ifx2yj
 f86u1JQ49TV99FEidCqzggorYkOS90oY5XtLTYOHow6jd27V3XR2VywPp9O4VK/EYVia
 OQaDbSnq0yR2duBCD0l1CO0ICYzRYweOUW5s1ePfvWquAssGHOKsYagongJbL+MIlCvl
 LNpCQBRAjthJhaoenjsGWijxhC5zRW2J3/O8ZpFyDuu+qI/ltyDgwOa3sOhLoFj35kw7
 lS5UFEP8nPff1ZioB/4dUPeMqjCXxVEdv4eTiy+WMeTf8zLhepClhx2GLvI3pLDddjBR
 kzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8nW5NS6j3gBAYiRTtVWo9ouAU2pPd4jJH8ZgD9DSfAE=;
 b=ZDLM5RJnOzz+5aaPWFlfvN7sUq32ntuThrqfXG5mPCiNEmEOjMHJ60LWXhwEsN3bvm
 lsyoK4R3Bm1x6Y34BDb7v0ziAm0LK9V4Octc4I0rUu+Knr2n1QVXDvNAnR909qijuL4f
 rhs5ExkzuHLRcU5A7Y9VB8691Tv39AUh2KJ6dQxAogdHhdlR9K9QpK90cdhUgX6o+Vcf
 zExDx06jTzftffmmGiMmzzLpNxOhhKuRgaee12oE4hGc6UIU51nbYk5J8LpP48VL2ICO
 tZze+/z8Ck+PD4U+zzDH2Nq7pdggV5RQrPRVv/XTrEVpRq34SwbtfzUZKXnvX9n2A3E6
 9QoQ==
X-Gm-Message-State: AOAM5316hPRGrb6QPLKXXYtyNLrHYGb3UcpyFjz0npPnSHQz0Jqy1RAp
 MQ0Oeq6fGp1LuWu0ET4n2nANxg==
X-Google-Smtp-Source: ABdhPJzJmv3QMP3U6Moqn2g7UYgz7vN7aMlOCjKa10EN8++T7zftoZssqebHsekyUNrLjXOgw08Tfg==
X-Received: by 2002:a17:90b:1b12:: with SMTP id
 nu18mr3380996pjb.126.1598996060321; 
 Tue, 01 Sep 2020 14:34:20 -0700 (PDT)
Received: from ?IPv6:2607:fb90:27d2:4b79:8545:2b44:3b48:7db9?
 ([2607:fb90:27d2:4b79:8545:2b44:3b48:7db9])
 by smtp.gmail.com with ESMTPSA id m19sm2391644pjq.18.2020.09.01.14.34.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 14:34:19 -0700 (PDT)
Subject: Re: [PATCH 0/4] hw/misc/a9scu: Verify CPU count is valid and simplify
 a bit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200901144100.116742-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <451946a7-835b-1f44-f3d1-ac5a3aa6aedc@linaro.org>
Date: Tue, 1 Sep 2020 14:34:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901144100.116742-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 7:40 AM, Philippe Mathieu-Daudé wrote:
> Trivial patches:
> - verify the A9 CPU count is in range,
> - simplify using MemoryRegionOps valid/impl,
> - log unimplemented registers.
> 
> Philippe Mathieu-Daudé (4):
>   hw/misc/a9scu: Do not allow invalid CPU count
>   hw/misc/a9scu: Simplify setting MemoryRegionOps::valid fields
>   hw/misc/a9scu: Simplify setting MemoryRegionOps::impl fields
>   hw/misc/a9scu: Report unimplemented accesses with qemu_log_mask(UNIMP)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

