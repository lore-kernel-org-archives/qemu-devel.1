Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D517C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3422073C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ySnVuIXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3422073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2MG-0004Kr-F0
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2LA-0003km-7U
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2L9-0001kD-1U
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:40:16 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36347)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD2L8-0001hV-QI
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:40:14 -0400
Received: by mail-pf1-x442.google.com with SMTP id i13so6756566pfe.3
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=P4sNrvWNvCaBZj3mNu70ffhO7O7WmJm8Gb6cNvUeIWU=;
 b=ySnVuIXXq+eWUlRFP2RQAYCtnSWmkoCeKitu/kNh8qEKWO64FA57+QaxnrEpUENZsR
 IeIVvhNVddoGitWShK4uY5h1cRV6Ec6QxoTRjGJxLyQ/81vpBMZZuBPUoFVy2DPP/p3L
 UOXtel0+Z4BsOja34RMCg/YvT68jmeloeLtY9vKvLqRStBZpmpJxSl5I9naxzaqvCsJ6
 WNEW+N92W3+qQ3Mts8rBwS9nM5y8o8xpuoZFEZlFL+bFQeWU3MEKwjdrE2OliJc9pIhj
 2KSzqndC1z/cq9q7PfBfampomgkrWCqk5we42sg9ti6EWqjtlp0osK7SGS31WY8wggqo
 fdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P4sNrvWNvCaBZj3mNu70ffhO7O7WmJm8Gb6cNvUeIWU=;
 b=A6ukdU24gZpIfbrE8++yJXOGTpg8MAsjJ2PAb5vMK7dVLZbCHmlqbvU4S+ER7DNN7M
 qR0kQIRgHOSz7BB+ieCZ/WZZp/TO+bWSufWnaA1Vq+qJbdgoCAj/BfKqGhEtDU6WUkW2
 9/Wgm5CNExDsrgIqmipesUpoJhg6dKiVmP62qg4M6j0TBpqRJyXEbPqaT3IdKj46jbj6
 dj1kuuQhX8SB+aJZs3geK0lrPkpOLpyKE3LXP1RB7uSyRey19RMbJpxuWVmYcM0I5y2Q
 MGEIVeQc+ctG4VuGvq9daeoOFNITkNnwu3nSjVUQ6tvaXt1YpyNLghROKm30FYjNdUdY
 KXZQ==
X-Gm-Message-State: ANhLgQ33GAoyog4DH/VMVefQwlYaS5UUeoLE1Kq+bRD/zRIobGszB4MW
 mxFs5qQylEmqjNgphw2+g/hbcw==
X-Google-Smtp-Source: ADFU+vurUo6td4SfbfpAfR7jcSg3OIzmOVo4udCOehuNTSfUO54JPCFQeHWaiCm2NMts5uuGunBBHA==
X-Received: by 2002:a63:4e4e:: with SMTP id o14mr16868290pgl.228.1584175213708; 
 Sat, 14 Mar 2020 01:40:13 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 63sm20354289pfx.132.2020.03.14.01.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 01:40:13 -0700 (PDT)
Subject: Re: [PATCH v5 29/60] target/riscv: vector single-width floating-point
 add/subtract instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-30-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0a8b13f2-6696-5e5c-d35f-e00962d7f0a8@linaro.org>
Date: Sat, 14 Mar 2020 01:40:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-30-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
>  target/riscv/helper.h                   |  16 ++++
>  target/riscv/insn32.decode              |   5 ++
>  target/riscv/insn_trans/trans_rvv.inc.c | 107 ++++++++++++++++++++++++
>  target/riscv/vector_helper.c            |  89 ++++++++++++++++++++
>  4 files changed, 217 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

