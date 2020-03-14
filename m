Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1847C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B41BB2074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xVsUQjud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41BB2074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2cN-0004bY-Tl
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2bm-00049Z-10
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2bl-0003gr-2Q
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:57:25 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD2bk-0003fU-S5
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:57:25 -0400
Received: by mail-pf1-x441.google.com with SMTP id u68so6765827pfb.2
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 01:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KgY6OfSp+ymbGQbvkMcTA1g9zMHOZqHeNAU3qRbRAY0=;
 b=xVsUQjudwT7N1W4+bmgTphW/226w8pOnr/IR+7bYGlYiFkKrbHWMi5r/Z3OPc3aSZX
 hbR3A/0t3vBImH9pD7ECeFCVmdLT3x0803dZXauYcGIsZ7XjU5ezHdOHFHqasyXJFfJA
 Fy/5CPOJ5HV2TTEyrP5bppOsmhfiVzngcoF2yf9K6sM7z1oJXz6f3366Wd2LsNaRGK0J
 sgKFqAKguQJk1dDK/ftSmNaecpTni/OeX+EhKrJ5ix1pa2sElE1hnRT9UJVun7iJOqLl
 AtspSmNPa/5OJqzbdsc0l4qP1FoctvWJxAVl8srJGh9zwXto61Rlu+S/zSdc0wM0DDPg
 HhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KgY6OfSp+ymbGQbvkMcTA1g9zMHOZqHeNAU3qRbRAY0=;
 b=X4JkkeLmYpPm+KEQKmUYxsDbXZ/NJdbaCibshgNdL8pwjhISSqaxweTJVZnKj800iC
 0V8ZpRvyK4wse75bHnK4NeuDx5I+cWL9fN8YSBpwC+ViTjVjd/InOD2gOdWqMC1WiIWk
 ETQSYlX7EZoY4m6uOdtdQN/6iatN3eyFP0qDdVNPoCh3LhB5uTZscfnz2qCet7o9j1BV
 bGYNejxs6A3DsPUJGjqix0q2v/lFvB602JeVYRiiwmstYDqwGCz4xn/giMQMdYVOj+l3
 0WzBpiaghRZHEVFq6ZZl/Ey5SUhwlYevtBUHhJ6bq6ikPAkCqiTT9l9VhWw6ruy9SBv6
 gGOA==
X-Gm-Message-State: ANhLgQ37GaRX/Df2Sq79LXudiLS2E00EUI7yLDhuwJxuP822KLS4k8oU
 ICLqUA3zg+YyjbYAg6072DDBQg==
X-Google-Smtp-Source: ADFU+vt3Vbog0guhAXVM+Bx5qiHcAZCaqiaLz8l3iuhR4y0ZQ7c4cys8F5KMoJ8D3Pr6yx/F+l3/WQ==
X-Received: by 2002:a63:9d0c:: with SMTP id i12mr16910096pgd.378.1584176243763; 
 Sat, 14 Mar 2020 01:57:23 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 d22sm14282433pja.14.2020.03.14.01.57.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 01:57:23 -0700 (PDT)
Subject: Re: [PATCH v5 37/60] target/riscv: vector floating-point
 sign-injection instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-38-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <75425609-527e-9691-3306-4eede7ee8ea1@linaro.org>
Date: Sat, 14 Mar 2020 01:57:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-38-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
>  target/riscv/helper.h                   | 19 +++++++
>  target/riscv/insn32.decode              |  6 ++
>  target/riscv/insn_trans/trans_rvv.inc.c |  8 +++
>  target/riscv/vector_helper.c            | 76 +++++++++++++++++++++++++
>  4 files changed, 109 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

