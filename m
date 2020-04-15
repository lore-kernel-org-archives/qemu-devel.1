Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7774AC2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 02:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3849E20732
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 02:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DIPD1ZDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3849E20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOXRG-0007At-EC
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 22:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38118)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jOXQT-0006Y5-Af
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 22:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jOXQR-0001wn-I6
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 22:05:17 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jOXQR-0001vU-80
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 22:05:15 -0400
Received: by mail-pf1-x443.google.com with SMTP id y25so840140pfn.5
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 19:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=z5ZIqmLGd9afsenqOCO5DmjHB2R2FPUTCPEsoeiBXN8=;
 b=DIPD1ZDmOyVvuD+EGFr9PB46FukiEq0KqsdHOitSk8S4bJCFdVbvj1vkdpQOuVjhZ6
 xHc1iBOQY6vQXhQJPIoIXon36Xm+8Mz7bZpVN7A9JGnbq0DsDd9Qo1aaChJXU5FGViQk
 mWC5PpnmPvRUkKP348lu2TD/j+KyA+V6rs3cnVt8DoQ+P4PkwbJnZBSgUmSD+f0zBKwv
 a+B7+gyxrmDLR1TkMJqLh0azl5+9LsJEOstSIjR0kFe5wCL95jPCi0h+A3queoSv1l+2
 ItwU8H/cfboWPgh+kXOmQ8zJhfMIqsf/urPlf0pPBHIRr9Gr1/OxgBMHc+oe2Wj8U+B/
 1pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z5ZIqmLGd9afsenqOCO5DmjHB2R2FPUTCPEsoeiBXN8=;
 b=kENCooDplkQ4RKUk1mqPTFDK+0EdfFVdxUv9mnm/X2MH1Q2xokSGa68zs0JK6NHXV/
 pjyBLKt9kO7+BBOJg7GTph7tBvMlvhKbu9JjUiULFlyVLJCsY/N+uyV58+SSPJM6suYH
 kQZwmfOhYCmmHn7WOewFY4cLuX+e7cjp4yMqcZ1joS/pAaYP4NfCDBCp1m8oItUHihdP
 DjcvgE1xhvmr5IHiktRD8LKJgmoPH0PeZSoHhpPo5nj5SUbScjW8lUEuHS7GWWWjW5Gs
 uW246LUo29w7m+STV/GxraVgr31Yw6JJ31ySO8Imsb6S37Zxrl9kZZeOqFARZlD0VCxM
 ri2A==
X-Gm-Message-State: AGi0PuYEU9+TSc+wtU8G61NP/kZZ0dehyeBuIvh55rDuYxev5DI65A6J
 dHLCQCWZ1tL+KVJqAyVlQ7PeRA==
X-Google-Smtp-Source: APiQypJxBoBKp3meJMsLW9YhQ9HUYpfdNLnsjG7s/dPLJqGJchfXwlalF8w8VwFaYuC+wEs/Bw911w==
X-Received: by 2002:a62:7a88:: with SMTP id
 v130mr24809578pfc.129.1586916313101; 
 Tue, 14 Apr 2020 19:05:13 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j16sm10167646pgi.40.2020.04.14.19.05.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 19:05:12 -0700 (PDT)
Subject: Re: [PATCH RFC v2] target/arm: Implement SVE2 MATCH, NMATCH
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200414231610.8387-1-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e7fb7a8c-0dc9-45c3-a0f7-9952b4a60aeb@linaro.org>
Date: Tue, 14 Apr 2020 19:05:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414231610.8387-1-steplong@quicinc.com>
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 4:16 PM, Stephen Long wrote:
> Signed-off-by: Stephen Long <steplong@quicinc.com>
> ---
>  target/arm/helper-sve.h    | 10 ++++++++
>  target/arm/sve.decode      |  5 ++++
>  target/arm/sve_helper.c    | 51 ++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 22 ++++++++++++++++
>  4 files changed, 88 insertions(+)
> 
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 5dd880cf6d..bc4a463bc7 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -2516,6 +2516,16 @@ DEF_HELPER_FLAGS_3(sve2_uqrshrnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_3(sve2_uqrshrnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_3(sve2_uqrshrnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  
> +DEF_HELPER_FLAGS_5(sve2_match_ppzz_b, TCG_CALL_NO_RWG,
> +                   i32, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(sve2_match_ppzz_h, TCG_CALL_NO_RWG,
> +                   i32, ptr, ptr, ptr, ptr, i32)
> +
> +DEF_HELPER_FLAGS_5(sve2_nmatch_ppzz_b, TCG_CALL_NO_RWG,
> +                   i32, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(sve2_nmatch_ppzz_h, TCG_CALL_NO_RWG,
> +                   i32, ptr, ptr, ptr, ptr, i32)
> +
>  DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_h, TCG_CALL_NO_RWG,
>                     void, ptr, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_s, TCG_CALL_NO_RWG,
> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 374e47fb05..652668df02 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -1305,6 +1305,11 @@ UQSHRNT         01000101 .. 1 ..... 00 1101 ..... .....  @rd_rn_tszimm_shr
>  UQRSHRNB        01000101 .. 1 ..... 00 1110 ..... .....  @rd_rn_tszimm_shr
>  UQRSHRNT        01000101 .. 1 ..... 00 1111 ..... .....  @rd_rn_tszimm_shr
>  
> +### SVE2 Character Match
> +
> +MATCH           01000101 .. 1 ..... 100 ... ..... 0 .... @pd_pg_rn_rm
> +NMATCH          01000101 .. 1 ..... 100 ... ..... 1 .... @pd_pg_rn_rm
> +
>  ## SVE2 floating-point pairwise operations
>  
>  FADDP           01100100 .. 010 00 0 100 ... ..... ..... @rdn_pg_rm
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index b68f62cd7f..78abd8b62a 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -6890,3 +6890,54 @@ DO_ST1_ZPZ_D(dd_be, zd, MO_64)
>  
>  #undef DO_ST1_ZPZ_S
>  #undef DO_ST1_ZPZ_D
> +
> +#define DO_PPZZ_CHAR_MATCH(NAME, TYPE, OP, H, MASK, DEFAULT_VAL)              \
> +static inline bool NAME##_inner_loop(TYPE nn, void *segmentbase)              \
> +{                                                                             \
> +    intptr_t i = 128;                                                         \
> +    do {                                                                      \
> +        do {                                                                  \
> +            i -= sizeof(TYPE) * 8;                                            \
> +            TYPE mm = *(TYPE *)(segmentbase + H1(i));                         \
> +            if (nn OP mm) {                                                   \
> +                return !DEFAULT_VAL;                                          \
> +            }                                                                 \
> +        } while (i & 63);                                                     \
> +    } while (i > 0);                                                          \
> +    return DEFAULT_VAL;                                                       \
> +}                                                                             \

You seem to be mixing up bit and bytes here, with 128 bits and H1 as a byte index.

I note that we don't need to keep re-loading the Zm segment elements from
memory.  Perhaps something like

static inline bool do_match1(uint64_t n, uint64_t m, int esz)
{
    int i, bits = 8 << esz;
    n = extract64(n, 0, bits);
    for (i = 0; i < 64; i += bits) {
        if (n == extract64(m, i, bits)) {
            return true;
        }
    }
    return false;
}

static inline bool do_match2(uint64_t n, uint64_t m0,
                             uint64_t m1, int esz)
{
    return do_match1(n, m0, esz) || do_match1(n, m1, esz);
}


As an improvement, we can use

https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord

static inline bool do_match2(uint64_t n, uint64_t m0,
                             uint64_t m1, int esz)
{
    int bits = 8 << esz;
    uint64_t ones = dup_const(esz, 1);
    uint64_t signs = ones << (bits - 1);
    uint64_t cmp0, cmp1;

    cmp1 = dup_const(esz, n);
    cmp0 = cmp1 ^ m0;
    cmp1 = cmp1 ^ m1;
    cmp0 = (cmp0 - ones) & ~cmp0;
    cmp1 = (cmp1 - ones) & ~cmp1;
    return (cmp0 | cmp1) & signs;
}


> +uint32_t HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)  \
> +{                                                                             \
> +    intptr_t opr_sz = simd_oprsz(desc);                                       \
> +    uint32_t flags = PREDTEST_INIT;                                           \
> +    intptr_t i = opr_sz;                                                      \
> +    do {                                                                      \
> +        uint64_t out = 0;                                                     \
> +        uint64_t pg;                                                          \
> +        do {                                                                  \
> +            i -= sizeof(TYPE), out <<= sizeof(TYPE);                          \
> +            TYPE nn = *(TYPE *)(vn + H(i));                                   \
> +            out = (out & ~1ull) | DEFAULT_VAL;                                \
> +            out |= NAME##_inner_loop(nn, vm + (i & -16));                     \
> +        } while (i & 63);                                                     \
> +        pg = *(uint64_t *)(vg + (i >> 3)) & MASK;                             \
> +        out &= pg;                                                            \
> +        *(uint64_t *)(vd + (i >> 3)) = out;                                   \
> +        flags = iter_predtest_bwd(out, pg, flags);                            \
> +    } while (i > 0);                                                          \
> +    return 0;                                                                 \

static inline uint32_t do_match(void *vd, void *vn,
    void *vm, void *vg, uint32_t desc,
    int esz, bool nmatch)
{
    intptr_opr_sz = simd_oprsz(desc);
    uint32_t flags = PREDTEST_INIT;
    intptr_t i, j, k;

    for (i = 0; i < opr_sz; i += 16) {
        uint64_t m0 = *(uint64_t *)(vm + i);
        uint64_t m1 = *(uint64_t *)(vm + i + 8);
        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
        uint16_t out = 0;

        for (j = 0; j < 16; j += 8) {
            uint64_t n = *(uint64_t *)(vn + i + j);

            for (k = 0; k < 8; k += 1 << esz) {
                if (pg & (1 << (j + k))) {
                    bool o = do_match2(n >> (k * 8),
                                       m0, m1, esz);
                    out |= (o ^ nmatch) << (j + k);
                }
            }
        }
        *(uint16_t *)(vd + H1_2(i >> 3)) = out;
        flags = iter_predtest_fwd(out, pg, flags);
    }
    return flags;
}

#define DO_PPZZ_MATCH(NAME, ESZ, INV) \
uint32_t HELPER(NAME)(void *vd, void *vn, void *vm,   \
                      void *vg, uint32_t desc)        \
{                                                     \
    return do_match(vd, vn, vm, vg, desc, ESZ, INV);  \
}

DO_PPZZ_MATCH(sve2_match_ppzz_b, MO_8, false)
DO_PPZZ_MATCH(sve2_match_ppzz_h, MO_16, false)

DO_PPZZ_MATCH(sve2_nmatch_ppzz_b, MO_8, true)
DO_PPZZ_MATCH(sve2_nmatch_ppzz_h, MO_16, true)


r~

