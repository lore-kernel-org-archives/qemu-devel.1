Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54310C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A8E2074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOggvFNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A8E2074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD29G-0001RF-8q
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD28X-0000sT-Ox
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD28W-0007Pc-S3
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:27:13 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40701)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD28W-0007Ni-Lx
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:27:12 -0400
Received: by mail-pf1-x443.google.com with SMTP id l184so6722848pfl.7
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ofI65jt8EpvfGgFPbqGu+r2iOExM/ICFwlma49Vh2d4=;
 b=xOggvFNORlE9IE5EfjqjnY6QrXdZUW49rbV/E6nq//Z91KwFQjdn8/kuvH1mZGgGa4
 5SbnAlQ2/mxURxFKTHdYUZ9tujY59BpRtBloGHYwGGQvXApvTYcRfiSl8AXvosm5AOe0
 FbncWeiSWOZPSBjb9Lls+r4xzXTgZPrJUi0Ek6cds4/nGERhk/2dTcccxMkY41XGhUYx
 7PlpFjT1scVe1gD8QxNPNfyc3vMOreFGXihMcb8Z/6FDxT6hQt6G4b58JVkWqDomOEke
 c/pq4V8EFszHYcIPxvX/ownlHayz0N7w5hxFJb/f0eT9+uiEHKqYmON93sorbI4BZyNk
 dKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ofI65jt8EpvfGgFPbqGu+r2iOExM/ICFwlma49Vh2d4=;
 b=W7WSGwAsCCzAGshIOmH/yEIDHUmuBM4DjvQgYXZREMLKkSphwtF0EVEz8KL7HvsXLg
 2lhTUDNJcfYFUpnt5iVxxAehQtww3SgJ8Cd0CWvPioZggGI4W5tU+znNVIl2kE7j6hvc
 wckC2yhvh9yAcrdBBnlzJFsrXBGUTo93Jm/bya7yhFEVJXdDK3vDyMQehsTOhXpK3NBC
 E3nkrWyiNFGv7EmezpaKcK2nsxy6r3TbdLLjgDg72/HZ3nqwYZ6o++yH5FjfOttNpxuw
 tSKrLJ6mU1e8lkS6xchzWM1/4Tv0qPJri1di/azfGs50/414I2+Ai2o5MpIg4ADalFm5
 IrSg==
X-Gm-Message-State: ANhLgQ2vHpQnnCs/xWqAaqEGreW1Ms9VjA4nwrDTbNKpjTcuJORZJo69
 628yN1XLdk0q+n4zLMUDuUDXog==
X-Google-Smtp-Source: ADFU+vs+NLoS1mGh5ADNuVYmtyw/GfrtsYyIaMuMvdJKpU1Ht29Y1ODqrgNjeUjl0K0HKvOzcYAMQg==
X-Received: by 2002:aa7:9a95:: with SMTP id w21mr3141451pfi.57.1584174431456; 
 Sat, 14 Mar 2020 01:27:11 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 y4sm31457233pfe.31.2020.03.14.01.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 01:27:10 -0700 (PDT)
Subject: Re: [PATCH v5 25/60] target/riscv: vector single-width fractional
 multiply with rounding and saturation
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-26-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a32b5bbb-f6c5-fc3c-1ddb-32290a2cd830@linaro.org>
Date: Sat, 14 Mar 2020 01:27:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-26-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
> +/* Vector Single-Width Fractional Multiply with Rounding and Saturation */
> +static inline int8_t vsmul8(CPURISCVState *env, int8_t a, int8_t b)
> +{
> +    uint8_t round;
> +    int16_t res;
> +
> +    res = (int16_t)a * (int16_t)b;
> +    round = get_round(env, res, 7);
> +    res   = (res >> 7) + round;
> +
> +    if (res > INT8_MAX) {
> +        env->vxsat = 0x1;
> +        return INT8_MAX;
> +    } else if (res < INT8_MIN) {
> +        env->vxsat = 0x1;
> +        return INT8_MIN;
> +    } else {
> +        return res;
> +    }
> +}
> +static int16_t vsmul16(CPURISCVState *env, int16_t a, int16_t b)

With the same caveat for vxrm as before.  Oh, and watch the spacing between
these functions.  I noticed before but didn't mention.


r~

