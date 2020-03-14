Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6B0C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4552074D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uyEeMcgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4552074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD019-0008DI-AV
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 02:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD00Y-0007mf-M8
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD00X-0005ve-QK
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:10:50 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD00X-0005sw-KO
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:10:49 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mj6so5105220pjb.5
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 23:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LBoJKx8A8qtZQp7JbE01RexiLGiQ8B+fMtyuFPwUvCo=;
 b=uyEeMcgYvlDhF/8klO8mUJ7cJvzzQTgyMW/m661ROaj7I5QSa3GZAfp2H1NZchvDbl
 azHyRqYXHc9rO6c6b6foTFrta+7QD/FztQl7AIyowBv8m8ZK9OmAmgbllVtHctkRQLmX
 kGW4IbCUBzF4th2GAjlQmdT9HDdld8y0Eo4rc7LB7DbsPemUuWtfK4ONdq8xydyydX2z
 nwSDV8dLcHb1PVkvrv0b5uqxR7+xl0SwvmTBhqtWjWO9Hdw88ibGoeFV+SZxpojSSsQW
 cDChT5AcbUyhTdm3NhSpsHI2FBOCvjaG8GlirdCA6bUXI75tnELvnLpDa7/m7SxGzZLD
 JWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LBoJKx8A8qtZQp7JbE01RexiLGiQ8B+fMtyuFPwUvCo=;
 b=F2OCgDRQBWNhnL/e+PmFfCo4pxDuDaPP4yqaVi5yxTHzQizZfbRzQ4ejK2NDiBGlgJ
 BLzg5sh1ILhhBNbG5TPrYSVoyb07BwWqrUZ1Y/qiFhfXadwwVIVIFO/uTBqUfEisVyg+
 peQWtQbc6kvfwmfqEuMrIJK3uglko4Pw2r0YBhpy7Q2Nh83WOGiSQT5H2ZiaqBQLuixj
 g3jv5m2HcL3q7//P8O66e6NV5neAxXzXKubExTGZNSn/LSQu4kFY8cfer0zO6V41WPdR
 XFbMa2543klrrbSB5YgzJM4/aHDk9P8RSdxBEb+K8dRoF203Mq0/9+wJufTtayyTePh/
 /e9Q==
X-Gm-Message-State: ANhLgQ2KptdULpz6W9bcbZ93xxgjes9ABVtPQANJFx9+t8TXh/x4NOwI
 Rqkzluhr6okIYjy2fIGmc05wLA==
X-Google-Smtp-Source: ADFU+vsJZcTvdxDTdHjxQNnez/Cc48Yeh5GeJW5SoPjzdwigLWPoeXS6SeRVHRJsyCqhzDO/FoE4+g==
X-Received: by 2002:a17:902:864a:: with SMTP id
 y10mr17171249plt.2.1584166248535; 
 Fri, 13 Mar 2020 23:10:48 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 r22sm13184477pjo.3.2020.03.13.23.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 23:10:47 -0700 (PDT)
Subject: Re: [PATCH v5 14/60] target/riscv: vector narrowing integer right
 shift instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-15-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <55ea569f-3e60-7943-5975-af8baac6e38a@linaro.org>
Date: Fri, 13 Mar 2020 23:10:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-15-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   | 13 ++++
>  target/riscv/insn32.decode              |  6 ++
>  target/riscv/insn_trans/trans_rvv.inc.c | 91 +++++++++++++++++++++++++
>  target/riscv/vector_helper.c            | 14 ++++
>  4 files changed, 124 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

