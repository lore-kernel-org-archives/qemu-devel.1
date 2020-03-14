Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAB6C10DCE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 01:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1862074B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 01:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxNUKTZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1862074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCvxt-0001IK-3V
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 21:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCvwT-0008Cd-Iw
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 21:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCvwS-0005kb-I5
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 21:50:21 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCvwS-0005gj-AX
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 21:50:20 -0400
Received: by mail-pj1-x1043.google.com with SMTP id f15so5069763pjq.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 18:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UCiInjJDQYoCkQCTjf1DHVbDt9m5uWJ7EptQOdDN1F0=;
 b=hxNUKTZ6Bce6YZsEc4cH4jFU4qFu0yJushF+GyBFwX3m2L2sNu5MhJnI5NW0lHGaNN
 cW7kVbz3LudDKsSqdO9dshnV1Z1JRjH0E+Osx/U1IZLWtjOiSBKjp3bBOgyONtbUNrBo
 e79Y7q8PEHmhpni+QyP/PaBmqm5TrDUaixCjKRhkaNuMpAgzEsJedzuGGciL5VzjLmGE
 ZF72U9pIiF1yUhxmD2OAuJVPrYAzR/zzG6cE/rcrBQnoI3y45dzuDDh2nQ+8kUCVFcrh
 jVjwFuNoc52cq+iHA/vDtmHc/Ie8UUHT+lmXVcFFE+VaLMaI53mEhyZiL6Iv4uJ/f6x9
 dXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UCiInjJDQYoCkQCTjf1DHVbDt9m5uWJ7EptQOdDN1F0=;
 b=N5MJGJ/3HzoEZhaQqc0VzoFONbLd8BtCCiwKtM08giV9D1vOBhOyqh11QQYc4YkQuA
 jr3BJIXQGx4L/FVnnAUQ0tawHQq9gVbc7izfaUKz4hPODdD7ENuHe/tasl6zw827Tf4J
 yKZdT8ZRzVxAEHEMvR5UXOFPKIiWDlRh1ueYALhThtT1ecAU3MOhWqTFnYH8z2+4k9cj
 3KPRDDWTZQrGmuPtZi/n5LW6KmKZ3MPBNX/5j9CvlrnRjp8ESKXk2ElAfFD71QKPHM9W
 iWGUOIkGxz+zRVFvqTlMsllIjrawsXqD+11GWF2ogyLUv+L7xnaxR5CqsaMjNw/ffX/2
 feRA==
X-Gm-Message-State: ANhLgQ2LAQJ1+BBXXobO9PJwY/71nw7MDOESL25hW1ZuASai/4FBne1H
 BX5JI5+2AWkQc8AZYJqztR6NHg==
X-Google-Smtp-Source: ADFU+vtdB+XXlUBzFIDP2WOUZrQMhfLPBo4W1KRwBKK6uEb7iXZOIFgrMi9iN/BkpToEBWho5viP/A==
X-Received: by 2002:a17:902:728d:: with SMTP id
 d13mr15918961pll.92.1584150619409; 
 Fri, 13 Mar 2020 18:50:19 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 e187sm2141568pfe.143.2020.03.13.18.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 18:50:18 -0700 (PDT)
Subject: Re: [PATCH v5 07/60] target/riscv: add fault-only-first unit stride
 load
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-8-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9d6ca94b-2097-678c-a890-8b413b6d69d0@linaro.org>
Date: Fri, 13 Mar 2020 18:50:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-8-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
> The unit-stride fault-only-fault load instructions are used to
> vectorize loops with data-dependent exit conditions(while loops).
> These instructions execute as a regular load except that they
> will only take a trap on element 0.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   |  22 +++++
>  target/riscv/insn32.decode              |   7 ++
>  target/riscv/insn_trans/trans_rvv.inc.c |  69 +++++++++++++++
>  target/riscv/vector_helper.c            | 111 ++++++++++++++++++++++++
>  4 files changed, 209 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


