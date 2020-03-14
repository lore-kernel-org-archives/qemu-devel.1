Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF73EC10DCE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 01:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F53B2074B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 01:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ubm6pxtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F53B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCvwo-0008I7-J5
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 21:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCvvs-0007Qm-96
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 21:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCvvr-0003UW-0u
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 21:49:44 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCvvq-0003PY-OO
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 21:49:42 -0400
Received: by mail-pl1-x643.google.com with SMTP id j20so5153357pll.6
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 18:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fny5UvBKk0IpFay3Kp6K4gQ40euxGyv5MhPSATQPqWM=;
 b=Ubm6pxtUUf6hI61k+GpdiImUkrHH2pROa13fMA0t+IiOUmRF3oL1rO//43GjjpCHNJ
 G6FMERGVFCwLJOqHQqgVA4Tb8Edj3xon6MUdVGRnc9Yh399rKfT02KCv19bAX8L8IlIb
 UENQ2e6zXTzeI7mvAXhcUFsPkoqAro8UEcKygI5y1GX0U3bFJczWrqsI97ezs5egNcPG
 xjMn0b5zJZ8NuxGyWKY3Rh+iuDcq/mHirIQG/TMjBfHj2ILdFb2nJ0IeXZkIzyFy5iX8
 FYn7mbXfgTHWwHG1Zb85+v/92v5D/S2/9UNrYREyDWJcbDvkOhhlcRS2MVaTYxYBdXLW
 apjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fny5UvBKk0IpFay3Kp6K4gQ40euxGyv5MhPSATQPqWM=;
 b=SIvA8C9VAlkxodZV4LE9IoqDIbOLhcasMMATtP+kfXjaoXfIikHfmr8iGEYlrPuYbC
 fAnlNc1u5BFscEEvzjsProOA/VIxCrr8pjzRA0K6V0uizA0wMJOJVhtrqTa6QbMigTxr
 NHUxBbjSn9+gcgiv2ugRtMMNJN1H3kuT/ulm1tsxLfyCqyFDDm5EKEowl2bH8ReLNSQc
 zOG45Ou6k9u+rYyaW8INvXuOmutLVl2eCnwjsAuu9dzfcY3tqnxHDn89e41x0bb7v7TG
 YESYcAxbCFRSj36x0cYHi6UMbK7A+gtmrDvs1+uy37R6kXYW45d6ZPc5asRd0+Dba5X+
 o3nQ==
X-Gm-Message-State: ANhLgQ1vAvZfI+6VQh3jysnuuMWOMBEGx6OW5C0TVwUm2h7yMdH0ezeE
 GrU+rw4s6OshwCnJjaRMR0Vj2A==
X-Google-Smtp-Source: ADFU+vvMM+AFLkO1qHOm/fYg6YShEyUPumOloY40dzlbk4X7Bzgdfh3c3dn52qeblm9XSZwn/Ai0+A==
X-Received: by 2002:a17:90a:630b:: with SMTP id
 e11mr12542516pjj.53.1584150581243; 
 Fri, 13 Mar 2020 18:49:41 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 fz3sm13288697pjb.41.2020.03.13.18.49.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 18:49:40 -0700 (PDT)
Subject: Re: [PATCH v5 06/60] target/riscv: add vector index load and store
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-7-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bfcd198e-2fe3-c21e-bbde-6d106673584a@linaro.org>
Date: Fri, 13 Mar 2020 18:49:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-7-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
> +static inline void vext_ldst_index(void *vd, void *v0, target_ulong base,
> +        void *vs2, CPURISCVState *env, uint32_t desc,
> +        vext_get_index_addr get_index_addr,
> +        vext_ldst_elem_fn ldst_elem,
> +        vext_ld_clear_elem clear_elem,
> +        uint32_t esz, uint32_t msz, uintptr_t ra,
> +        MMUAccessType access_type)
> +{
> +    uint32_t i, k;
> +    uint32_t nf = vext_nf(desc);
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t mlen = vext_mlen(desc);
> +    uint32_t vlmax = vext_maxsz(desc) / esz;
> +
> +    if (env->vl == 0) {
> +        return;
> +    }
> +    /* probe every access*/
> +    for (i = 0; i < env->vl; i++) {
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
> +            continue;
> +        }
> +        probe_pages(env, get_index_addr(base, i, vs2), nf * msz, ra,
> +                access_type);

Indentation.

> +    /* load bytes from guest memory */
> +    for (i = 0; i < env->vl; i++) {
> +        k = 0;
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
> +            continue;
> +        }
> +        while (k < nf) {
> +            abi_ptr addr = get_index_addr(base, i, vs2) + k * msz;
> +            ldst_elem(env, addr, i + k * vlmax, vd, ra);
> +            k++;
> +        }

Why the odd formulation with k?

> +        for (k = 0; k < nf; k++) {
> +            clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
> +        }

Using a for is certainly a bit clearer.

Which does bring to mind an optimization -- letting the compiler know that
these loops always go at least once.

We can do that either by writing all of them as do { } while.

Or by encoding NF in desc like the instruction does:

static inline uint32_t vext_nf(uint32_t desc)
{
    return FIELD_EX32(simd_data(desc), VDATA, NF) + 1;
}

which will let the compiler know that NF >= 1.

But that's minor, and we can look at these sorts of things later.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

