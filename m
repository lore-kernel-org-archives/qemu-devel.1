Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB20C0044D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 01:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCFF206EB
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 01:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zpaacgA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCFF206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDHy3-0000DP-UG
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 21:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDHxH-0008E9-7A
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 21:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDHxF-0001eV-RI
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 21:20:38 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDHxF-0001d7-LQ
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 21:20:37 -0400
Received: by mail-pl1-x641.google.com with SMTP id w3so6145741plz.5
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 18:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W5HNBH4jui6quQMCWhjPPMXVLK0xL9sVCID+Te6wTes=;
 b=zpaacgA9uvt36EOxk82lQGpPO9LmH1Etuwu/r5uVOht1kcyzPyZoyR1fZZ0bFXFlYH
 WMkh4kjXzs8AFSzPmZqWTKYT33PLo5PdDwwFdy5waEzWY8Wfw5pEaEJzcdU1WYEZEtbx
 0jdjDWn4Hr0sJUDhE3PuIaWdgm5Cf38N9BbYu9+XXbOzf9DTa9Jv7TydqAs5QRVf5OOo
 CQtkzKF9M+mfzq0kB6EIu+IZkea9vEX3RaPBT33Lp1sUf8LW08Xkvi/CfxFZg/xidvJQ
 /g1bY+FPV3L3bMIHSnTwDaTXanFftw1zX0MZgqt22YPbItL++/sg4Ym2v24J8rAGpbrk
 UvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W5HNBH4jui6quQMCWhjPPMXVLK0xL9sVCID+Te6wTes=;
 b=P6CDjpVJYtoWmMInjc9y6cObrRKhTrB4NKmdfkqmlx8dyMJh6h5N5aAtzlh043zlRc
 qMEyO8gB+He5+KSXLFF9Yt/yZwneJpNbGGfFOojOMmXAAiDb2SpwdCiLFDGc/HziOTw/
 eqcg0Qs4PBc1282S0QJPfYFK/el4Hsv54Hlw7Jdail7fQN9y/ezzpLgNQsP9mdnKjYE0
 QzJt2s0H+ke+1a00Wdl5O+OaQRtCWIxToIeAUdHE2ovqsW5uoBXnpSFowZFhmiPScTuz
 ncpJ2TmKKiW5tvKWrHhTV/YMOIFtk25J72oo0tByheTjhjPmztHm2rCaNj4yf0jato80
 6P0g==
X-Gm-Message-State: ANhLgQ1gthNI9mepiaFV94DzZxC43xVyZwcNCvuox8D9UwJRtzw5uUte
 hs8PMma9smLCUUx1JTWSJEqPCQ==
X-Google-Smtp-Source: ADFU+vvWJ6z1B6ozI9oJRKksQcBD6gZY5b5ot+mG7LOHyyh/O0SkKflJaQuZngxx6ec6REPTf8vvNQ==
X-Received: by 2002:a17:90a:8d10:: with SMTP id
 c16mr1223905pjo.7.1584235235842; 
 Sat, 14 Mar 2020 18:20:35 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 j4sm767053pfg.133.2020.03.14.18.20.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 18:20:35 -0700 (PDT)
Subject: Re: [PATCH v5 49/60] target/riscv: vector mask population count vmpopc
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-50-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f0ba29ea-7491-1240-fbbe-53431783195d@linaro.org>
Date: Sat, 14 Mar 2020 18:20:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-50-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
> +target_ulong HELPER(vmpopc_m)(void *v0, void *vs2, CPURISCVState *env,
> +        uint32_t desc)
> +{
> +    target_ulong cnt = 0;
> +    uint32_t mlen = vext_mlen(desc);
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t vl = env->vl;
> +    int i;
> +
> +    for (i = 0; i < vl; i++) {
> +        if (vm || vext_elem_mask(v0, mlen, i)) {
> +            if (vext_elem_mask(vs2, mlen, i)) {
> +                cnt++;
> +            }
> +        }
> +    }
> +    return cnt;
> +}

This is ok as-is, so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

But you can do better.

You create an array, similar to arm's pred_esz_masks[],
indexed by log2(mlen).

    mask = pred_mlen_masks[log2_mlen];
    n = vl >> (6 - log2_mlen);
    r = extract32(vl, 0, 6 - log2_mlen);
    if (r) {
        rmask = extract64(mask, 0, r << log2_mlen);
    } else {
        rmask = 0;
    }

    if (vm) {
        for (i = 0; i < n; i++) {
            uint64_t j = ((uint64_t *)vs2)[i];
            cnt += ctpop64(j & mask);
        }
        if (rmask) {
            uint64_t j = ((uint64_t *)vs2)[i];
            cnt += ctpop64(j & rmask);
        }
    } else {
        for (i = 0; i < n; i++) {
            uint64_t j = ((uint64_t *)vs2)[i];
            uint64_t k = ((uint64_t *)v0)[i];
            cnt += ctpop64(j & k & mask);
        }
        if (rmask) {
            uint64_t j = ((uint64_t *)vs2)[i];
            uint64_t k = ((uint64_t *)v0)[i];
            cnt += ctpop64(j & k & rmask);
        }
    }


r~

