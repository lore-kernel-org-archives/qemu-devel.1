Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77305C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 23:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF41221EB
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 23:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0gJKQKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF41221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDGEX-0007MQ-Ag
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 19:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDGDw-0006vU-H8
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDGDv-0005bj-1T
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:29:44 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDGDu-0005ZA-P7
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:29:42 -0400
Received: by mail-pg1-x544.google.com with SMTP id b1so7267945pgm.8
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 16:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1ue1VaLXiYjFKi7SBMXHCsLK7kkEUvQ5QfrV2zIPD+A=;
 b=e0gJKQKQu5fYXD5hPiEq8kvBwfY1IpjsHw8aDZcSOXa+6KRkfbgAa/sxS+maCc8Dh7
 gInvIvxpeSSNlBqavPOI/7E1ZrHaPPMiK4EkLpxW6lvUa7G9uAR4jmGuE5D9l+aGZZZC
 /jTuDBlXPr+kgWXqFD2lqZyssmbVRjp2LS91iq7JkArQQHVJ3LtKk2x7S9Xc2TIDeozk
 ElPG8+TJoATYNX2xKJbPXslsI+pC/78BVYGyn9V51mWOZS1/mgUnUpUe6WTLMq0TgKEb
 KN35MbL7/AU4rvTfEfQBQf1lKYqLDopCgdx7qFhSgevdeoJqCk16lZXhjD7V9rEmfYKC
 Nb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1ue1VaLXiYjFKi7SBMXHCsLK7kkEUvQ5QfrV2zIPD+A=;
 b=Z7wxbfpKv4QXqSHq936IgM5oljCiukK9SPTIjHO4BS/f6SnGYk1RwNdkSwfxt4g2Q6
 hujvO4oPj5+xI8khugW8+Y8CvPnBM7YNNLRPKbHCqjtLdjUUrJ1wwqe4MPK7VGuGZKuO
 G70l7J2Fxdg0WHnZdohR4RS6gqMsWyuA3+1V3OTg5XcF/rFXmh8bjlqG9RNo7/MNNHUT
 sS8aB56Ufj1jM1ewC4CNd9jkw+pmKP99wdj47CMMR7p6HLEZiKbIX1feJSBv+2nF0Dog
 gJ7rs+QvODgVfLxAlSWM8S+t8f28cev2Yc+CpagtGrmFAtWZytnTM5ZmccSm5KXt17qI
 Vvvw==
X-Gm-Message-State: ANhLgQ19uf+XiogHdhZRz+f6OsWf1fk61Q9uNGzWfSR7kxIiGiVPdS04
 YDea9D+T+q1VdT9hOEs7C8xfIw==
X-Google-Smtp-Source: ADFU+vsQynG+a5EPaQn57cdgr6M2rr1E3x31QjkHdA+NSxl1tiM+O+cgA99F5ufm/V1QRHPKUu5QbQ==
X-Received: by 2002:a62:fc07:: with SMTP id e7mr19527361pfh.299.1584228581303; 
 Sat, 14 Mar 2020 16:29:41 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z16sm2679322pfr.138.2020.03.14.16.29.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 16:29:40 -0700 (PDT)
Subject: Re: [PATCH v5 44/60] target/riscv: vector single-width integer
 reduction instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-45-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <84c1bedd-faa1-5d91-4a7e-39b8da511bb6@linaro.org>
Date: Sat, 14 Mar 2020 16:29:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-45-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
>  target/riscv/helper.h                   | 33 +++++++++++
>  target/riscv/insn32.decode              |  8 +++
>  target/riscv/insn_trans/trans_rvv.inc.c | 17 ++++++
>  target/riscv/vector_helper.c            | 76 +++++++++++++++++++++++++
>  4 files changed, 134 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

