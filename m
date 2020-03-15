Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015C8C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 05:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6AB320722
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 05:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JuRr9Oso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AB320722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDLfb-0000ds-VM
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 01:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDLds-0008Cc-Rp
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 01:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDLdr-00039g-C0
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 01:16:52 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDLdp-00035u-GB
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 01:16:50 -0400
Received: by mail-pf1-x443.google.com with SMTP id 23so7869231pfj.1
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 22:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GJ1xXDGuQv2FAeoa5/AH5ynqpDbt7k/V0nxVvKL2QzU=;
 b=JuRr9OsonweBRlntBy1JpkWvLDKq1aTqeUudS2zlyQ0QAhj4djdwnZETU9tit645w/
 wnqcK44Iu/hRfoeUyhw3eK0zGJiNNr3R6pKpXM5fG2QwjAnQFZF/ebnTdeG5P/zpUExd
 zycyGi4hN5+znfmCawJKVLzj9e/Hpuyou3MPZvfT74xu9patIaY0NPYFM4WcXjTwn1ok
 QYYTzOjCvrmefNqrFSyrV3s+2TvZ26Aqvor6B0halhfXM4NQFrSbel3XKHO/79+pTHdL
 KGNhngi19zw0vwdT37V1zrBRA3o0lBgPLteybN3dYCHlfokvLL7FGBe0/u6872lURcXY
 Ia2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GJ1xXDGuQv2FAeoa5/AH5ynqpDbt7k/V0nxVvKL2QzU=;
 b=G6k2NDkzGq0ahBOeeTfR7aKa6nJY+d2mjXiYQwam8Xv+HkC1MZv+nKZNUl4NZ7ktUA
 wNOgou6fsCXaAPwad5JRaKe9MaFdVqkynOMThXvANC4wqrKL0qsJj89iAEd4Zaow8/Gb
 5mwrZboHk72+zlmWZIaz4Kuy44jjRXuZeNjNq8K2uQ5t24nRClXjjgHQyFDDz2yxrCXv
 DikNffImZHwILnC3JyK3ximK4YfSnlW84pp+VgJJxiaaCEkXzRlTwvSKxmW7iOlHuu3w
 ppNiglAWgmGlqQCbCM5LzFt5TQLRZ/+LDgpiXXTv1SyYPQ07xa5zGFqYMK1185eXpiqT
 oPLA==
X-Gm-Message-State: ANhLgQ20vCHBX1l+u6TA4FWZWd+4wjLeml69Y6V/dyYKNpnQPyDbZKWd
 67GRhOdEEzYQLNFZeEL2x+T4Kg==
X-Google-Smtp-Source: ADFU+vvkn/Nvj5xqOu+RSJrET6d9f2l8+HuGAPw6TkcWQyWtr7yH3UDVkeFYPIB0OUfWBSjM5MQM7w==
X-Received: by 2002:a63:5549:: with SMTP id f9mr20699884pgm.118.1584249407375; 
 Sat, 14 Mar 2020 22:16:47 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 15sm56943371pfp.125.2020.03.14.22.16.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 22:16:46 -0700 (PDT)
Subject: Re: [PATCH v5 57/60] target/riscv: vector slide instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-58-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <28063df7-bf38-d136-2d32-39651692c4c6@linaro.org>
Date: Sat, 14 Mar 2020 22:16:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-58-zhiwei_liu@c-sky.com>
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
> +#define GEN_VEXT_VSLIDEUP_VX(NAME, ETYPE, H, CLEAR_FN)                    \
> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
> +        CPURISCVState *env, uint32_t desc)                                \
> +{                                                                         \
> +    uint32_t mlen = vext_mlen(desc);                                      \
> +    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
> +    uint32_t vm = vext_vm(desc);                                          \
> +    uint32_t vl = env->vl;                                                \
> +    uint32_t offset = s1, i;                                              \
> +                                                                          \
> +    if (offset > vl) {                                                    \
> +        offset = vl;                                                      \
> +    }                                                                     \

This isn't right.

> +    for (i = 0; i < vl; i++) {                                            \
> +        if (((i < offset)) || (!vm && !vext_elem_mask(v0, mlen, i))) {    \
> +            continue;                                                     \
> +        }                                                                 \
> +        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
> +    }                                                                     \
> +    if (i == 0) {                                                         \
> +        return;                                                           \
> +    }                                                                     \

You need to eliminate vl == 0 first, not last.
Then

    for (i = offset; i < vl; i++)

The types of i and vl need to be extended to target_ulong, so that you don't
incorrectly crop the input offset.

It may be worth special-casing vm=1, or hoisting it out of the loop.  The
operation becomes a memcpy (at least for little-endian) at that point.  See
swap_memmove in arm/sve_helper.c.


> +#define GEN_VEXT_VSLIDEDOWN_VX(NAME, ETYPE, H, CLEAR_FN)                  \
> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
> +        CPURISCVState *env, uint32_t desc)                                \
> +{                                                                         \
> +    uint32_t mlen = vext_mlen(desc);                                      \
> +    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
> +    uint32_t vm = vext_vm(desc);                                          \
> +    uint32_t vl = env->vl;                                                \
> +    uint32_t offset = s1, i;                                              \
> +                                                                          \
> +    for (i = 0; i < vl; i++) {                                            \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
> +            continue;                                                     \
> +        }                                                                 \
> +        if (i + offset < vlmax) {                                         \
> +            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + offset));      \

Again, eliminate vl == 0 first.  In fact, why don't we make that a global
request for all of the patches for the next revision.  Checking for i == 0 last
is silly, and checks for the zero twice: once in the loop bounds and again at
the end.

It is probably worth changing the loop bounds to

    if (offset >= vlmax) {
       max = 0;
    } else {
       max = MIN(vl, vlmax - offset);
    }
    for (i = 0; i < max; ++i)


> +        } else {                                                          \
> +            *((ETYPE *)vd + H(i)) = 0;                                    \
> +        }

Which lets these zeros merge into...

> +    for (; i < vlmax; i++) {                                              \
> +        CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));      \
> +    }                                                                     \

These zeros.

> +#define GEN_VEXT_VSLIDE1UP_VX(NAME, ETYPE, H, CLEAR_FN)                   \
> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
> +        CPURISCVState *env, uint32_t desc)                                \
> +{                                                                         \
> +    uint32_t mlen = vext_mlen(desc);                                      \
> +    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
> +    uint32_t vm = vext_vm(desc);                                          \
> +    uint32_t vl = env->vl;                                                \
> +    uint32_t i;                                                           \
> +                                                                          \
> +    for (i = 0; i < vl; i++) {                                            \
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
> +            continue;                                                     \
> +        }                                                                 \
> +        if (i == 0) {                                                     \
> +            *((ETYPE *)vd + H(i)) = s1;                                   \
> +        } else {                                                          \
> +            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));           \
> +        }                                                                 \
> +    }                                                                     \
> +    if (i == 0) {                                                         \
> +        return;                                                           \
> +    }                                                                     \
> +    for (; i < vlmax; i++) {                                              \
> +        CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));      \
> +    }                                                                     \
> +}

As a preference, I think you can do away with this helper.
Simply use the slideup helper with argument 1, and then
afterwards store the integer register into element 0.  You should be able to
re-use code from vmv.s.x for that.

> +#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, ETYPE, H, CLEAR_FN)                 \
> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
> +        CPURISCVState *env, uint32_t desc)                                \
> +{                                                                         \

Likewise.


r~

