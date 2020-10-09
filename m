Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB9FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3164522284
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rAeC2Fp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3164522284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQrib-0006cL-8N
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQrcA-0007eY-6s
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:35:14 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQrc6-00012u-PZ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:35:13 -0400
Received: by mail-ot1-x342.google.com with SMTP id i12so8852960ota.5
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 05:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=pvE/fIzmY8+yjBzmWb+mhNBdlD98xrY92H8dYNorfXk=;
 b=rAeC2Fp7p+VrLeCmj+5mdUU3kHHiKi8jqJLn4dUeMCBuAD6bSgoQNF6+EawOrZZoFd
 c74R2cMaToAtoszjr7JHXkjs4FJGHnuw6PD6TfkVYLCBir4O9BZglPHnqgOqs9r/515C
 ZJJpNYQB1J7huGf0v5h/cw88rXc8/5HF766R2f8rQcRVUphmz7mMcq3KuilL4ytfLkAm
 cCqtgxjsXAMeYYcJmQx7dxAieOPfLnXDrbzUWUCG3itEv+hvsrxeBnHXtRUCh6AAGCtT
 qvLwqG6Q5w9IlQNzegk8MM8G0kmIK7t7CBsQaKbimZi7ET21KzB4OpxXW/5agE+xKH6K
 nG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pvE/fIzmY8+yjBzmWb+mhNBdlD98xrY92H8dYNorfXk=;
 b=BQf6rBTdToC6QBe9hzFw+gzOnyv0eFXwVM1X1X9KiWHlQT2MmDU3pwEr1zmIkDEfpd
 9do16z5U7gWVY8F9FZmN9b83AMsTfzizJT6dgQZPxtTiM6M1OM6EOZSSXUrjz5f+swrf
 lVu9kIQ9rHzSIJB89gRVmL/BPsJdDikYHqfdZB/XrKdXOlIaHCrEbsJFin1zo7H7s10K
 9LqjjAt28Sr1AFkQnk6wrCcCxQISYdeutQ+B625bfSiU0ChVAAkE2F3tklSgAGv54apM
 IHnD84C5aX1lym0sbUa+8c4d9a//HI94eERYrQIFup7u6apuE6GOLWnuaXh22sUenKlB
 witw==
X-Gm-Message-State: AOAM531Y3dNtHyGuRKUS8SrEbtXS4Qb1pf7Xl5tcO1zTAZR00L/cNFqZ
 bsa/kEsAgMOb9wfwfoGjDLglhg==
X-Google-Smtp-Source: ABdhPJynfrnGJxopm7SpTGIpZqyG9E3ot9FSpjKJlwJbCVoUy4zkSvfvMBscS+OrozZzPKl7rmBGWg==
X-Received: by 2002:a05:6830:199:: with SMTP id
 q25mr8139503ota.263.1602246909244; 
 Fri, 09 Oct 2020 05:35:09 -0700 (PDT)
Received: from [172.24.51.127] (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id u68sm6295760otb.9.2020.10.09.05.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 05:35:08 -0700 (PDT)
Subject: Re: [PATCH v3 45/81] target/arm: Implement SVE2 HISTCNT, HISTSEG
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org,
 Stephen Long <steplong@quicinc.com>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
 <20200918183751.2787647-46-richard.henderson@linaro.org>
 <46ba7fd1-cffb-f9e2-e727-c487b0531a12@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7fbc8088-c7b7-4d4e-919b-1fcc9ec46284@linaro.org>
Date: Fri, 9 Oct 2020 07:35:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <46ba7fd1-cffb-f9e2-e727-c487b0531a12@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.208,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 1:13 AM, LIU Zhiwei wrote:
> 
> 
> On 2020/9/19 2:37, Richard Henderson wrote:
>> From: Stephen Long <steplong@quicinc.com>
>>
>> Signed-off-by: Stephen Long <steplong@quicinc.com>
>> Message-Id: <20200416173109.8856-1-steplong@quicinc.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v2: Fix overlap between output and input vectors.
>> ---
>>   target/arm/helper-sve.h    |   7 +++
>>   target/arm/sve.decode      |   6 ++
>>   target/arm/sve_helper.c    | 124 +++++++++++++++++++++++++++++++++++++
>>   target/arm/translate-sve.c |  19 ++++++
>>   4 files changed, 156 insertions(+)
>>
>> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
>> index 9e8641e1c0..34bbb767ef 100644
>> --- a/target/arm/helper-sve.h
>> +++ b/target/arm/helper-sve.h
>> @@ -2551,6 +2551,13 @@ DEF_HELPER_FLAGS_5(sve2_nmatch_ppzz_b, TCG_CALL_NO_RWG,
>>   DEF_HELPER_FLAGS_5(sve2_nmatch_ppzz_h, TCG_CALL_NO_RWG,
>>                      i32, ptr, ptr, ptr, ptr, i32)
>>   +DEF_HELPER_FLAGS_5(sve2_histcnt_s, TCG_CALL_NO_RWG,
>> +                   void, ptr, ptr, ptr, ptr, i32)
>> +DEF_HELPER_FLAGS_5(sve2_histcnt_d, TCG_CALL_NO_RWG,
>> +                   void, ptr, ptr, ptr, ptr, i32)
>> +
>> +DEF_HELPER_FLAGS_4(sve2_histseg, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>> +
>>   DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_h, TCG_CALL_NO_RWG,
>>                      void, ptr, ptr, ptr, ptr, ptr, i32)
>>   DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_s, TCG_CALL_NO_RWG,
>> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
>> index 3121eabbf8..0edb72d4fb 100644
>> --- a/target/arm/sve.decode
>> +++ b/target/arm/sve.decode
>> @@ -146,6 +146,7 @@
>>                   &rprrr_esz rn=%reg_movprfx
>>   @rdn_pg_rm_ra   ........ esz:2 . ra:5  ... pg:3 rm:5 rd:5 \
>>                   &rprrr_esz rn=%reg_movprfx
>> +@rd_pg_rn_rm   ........ esz:2 . rm:5 ... pg:3 rn:5 rd:5       &rprr_esz
>>     # One register operand, with governing predicate, vector element size
>>   @rd_pg_rn       ........ esz:2 ... ... ... pg:3 rn:5 rd:5       &rpr_esz
>> @@ -1336,6 +1337,11 @@ RSUBHNT         01000101 .. 1 ..... 011 111 .....
>> .....  @rd_rn_rm
>>   MATCH           01000101 .. 1 ..... 100 ... ..... 0 .... @pd_pg_rn_rm
>>   NMATCH          01000101 .. 1 ..... 100 ... ..... 1 .... @pd_pg_rn_rm
>>   +### SVE2 Histogram Computation
>> +
>> +HISTCNT         01000101 .. 1 ..... 110 ... ..... .....  @rd_pg_rn_rm
>> +HISTSEG         01000101 .. 1 ..... 101 000 ..... .....  @rd_rn_rm
>> +
>>   ## SVE2 floating-point pairwise operations
>>     FADDP           01100100 .. 010 00 0 100 ... ..... ..... @rdn_pg_rm
>> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
>> index 19fbf94189..fa4848bc5c 100644
>> --- a/target/arm/sve_helper.c
>> +++ b/target/arm/sve_helper.c
>> @@ -7095,3 +7095,127 @@ DO_PPZZ_MATCH(sve2_nmatch_ppzz_b, MO_8, true)
>>   DO_PPZZ_MATCH(sve2_nmatch_ppzz_h, MO_16, true)
>>     #undef DO_PPZZ_MATCH
>> +
>> +void HELPER(sve2_histcnt_s)(void *vd, void *vn, void *vm, void *vg,
>> +                            uint32_t desc)
>> +{
>> +    ARMVectorReg scratch;
>> +    intptr_t i, j;
>> +    intptr_t opr_sz = simd_oprsz(desc);
>> +    uint32_t *d = vd, *n = vn, *m = vm;
>> +    uint8_t *pg = vg;
>> +
>> +    if (d == n) {
>> +        n = memcpy(&scratch, n, opr_sz);
>> +        if (d == m) {
>> +            m = n;
>> +        }
>> +    } else if (d == m) {
>> +        m = memcpy(&scratch, m, opr_sz);
>> +    }
>> +
>> +    for (i = 0; i < opr_sz; i += 4) {
>> +        uint64_t count = 0;
>> +        uint8_t pred;
>> +
>> +        pred = pg[H1(i >> 3)] >> (i & 7);
>> +        if (pred & 1) {
>> +            uint32_t nn = n[H4(i >> 2)];
>> +
>> +            for (j = 0; j <= i; j += 4) {
>> +                pred = pg[H1(j >> 3)] >> (j & 7);
>> +                if ((pred & 1) && nn == m[H4(j >> 2)]) {
>> +                    ++count;
>> +                }
>> +            }
>> +        }
>> +        d[H4(i >> 2)] = count;
>> +    }
>> +}
>> +
>> +void HELPER(sve2_histcnt_d)(void *vd, void *vn, void *vm, void *vg,
>> +                            uint32_t desc)
>> +{
>> +    ARMVectorReg scratch;
>> +    intptr_t i, j;
>> +    intptr_t opr_sz = simd_oprsz(desc);
>> +    uint64_t *d = vd, *n = vn, *m = vm;
>> +    uint8_t *pg = vg;
>> +
>> +    if (d == n) {
>> +        n = memcpy(&scratch, n, opr_sz);
>> +        if (d == m) {
>> +            m = n;
>> +        }
>> +    } else if (d == m) {
>> +        m = memcpy(&scratch, m, opr_sz);
>> +    }
>> +
>> +    for (i = 0; i < opr_sz / 8; ++i) {
>> +        uint64_t count = 0;
>> +        if (pg[H1(i)] & 1) {
>> +            uint64_t nn = n[i];
>> +            for (j = 0; j <= i; ++j) {
>> +                if ((pg[H1(j)] & 1) && nn == m[j]) {
>> +                    ++count;
>> +                }
>> +            }
>> +        }
>> +        d[i] = count;
>> +    }
>> +}
>> +
>> +/*
>> + * Returns the number of bytes in m0 and m1 that match n.
>> + * See comment for do_match2().
>> + * */
>> +static inline uint64_t do_histseg_cnt(uint8_t n, uint64_t m0, uint64_t m1)
>> +{
>> +    int esz = MO_8;
>> +    int bits = 8 << esz;
>> +    uint64_t ones = dup_const(esz, 1);
>> +    uint64_t signs = ones << (bits - 1);
>> +    uint64_t cmp0, cmp1;
>> +
>> +    cmp1 = dup_const(esz, n);
>> +    cmp0 = cmp1 ^ m0;
>> +    cmp1 = cmp1 ^ m1;
>> +    cmp0 = (cmp0 - ones) & ~cmp0 & signs;
>> +    cmp1 = (cmp1 - ones) & ~cmp1 & signs;
>> +
> Hi Richard,
> 
> Although we can detect zero byte with this method, we can't use it to count the
> zero bytes.
> 
> For example,
> IF
>     cmp1 =  0x0100010001000100 , ones = 0x101010101010101, signs =
> 0x8080808080808080,
> THEN
>     cmp1 = (cmp1 - ones) & ~cmp1 & signs = 0x8080808080808080
> So
>     cmp1 will have 6 zeros by this method. In fact, cmp1 only have 4 zeros
> instead of 6 zeros.
> 
> I don't  find  a "bit twiddling" way,  if you find it, please let me know.

Thanks for noticing the error.  We already have a bit twiddling example in qemu
for this in target/alpha:

uint64_t helper_cmpbe0(uint64_t a)
{
    uint64_t m = 0x7f7f7f7f7f7f7f7fULL;
    uint64_t c = ~(((a & m) + m) | a | m);
    ...

which produces the exact results that we need here.


r~

