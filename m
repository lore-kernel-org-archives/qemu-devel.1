Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFFFC2BA1A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 00:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F902074F
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 00:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bu+/fQ1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F902074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS8eB-00059S-74
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 20:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS8dJ-0004OY-Bd
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 20:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS8dG-0007v2-RU
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 20:25:25 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jS8dG-0007pp-Bi
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 20:25:22 -0400
Received: by mail-pg1-x544.google.com with SMTP id j7so5413537pgj.13
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 17:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VIDUj/HEHDsL8OTEaiwHW8TG2vIswJFFkddCaDaTsn4=;
 b=bu+/fQ1c8wB/AlZUP/xIjWzbZfFj16xehezMmKqR4rnRN/zIu03zVZRhzU4wZTxX+x
 nfQa2+jxh8iy4oD0M6HJKXtwj3PIOGO6oR5fLSDwCP0srDhkKWs1bMHhPWlvVS1mFNn6
 ckinzoGOFdBTxYWzHkpRMd+tu0yZ8U/zvZlqtcK9blyUnjcLN1YSG0J96MvassObiw2A
 ltkH08WnJHZyv4eVMc/78gOm9ElKYMSc3qi1oCV6SkiYJpVIVucjnHKEjexNFolNPQ1t
 9xnLYSM5y16MOlfPp1mYQwo7wvTec/hxIy9GNQwbhCRBVgTMu6+WyPX/I6MrjCRehrnO
 zD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VIDUj/HEHDsL8OTEaiwHW8TG2vIswJFFkddCaDaTsn4=;
 b=qUeI+T5PowS5a30+I7iP/3EwjJyf1AS72PD04dlj8m1Zed8bP0dHSovbPyCeQ9Sdcp
 pZc/MuwUKSE+B6fsLW8F8He3QCZ/anuTwbUf+SpqUZpcEAykwR68MjBd2gpZVMiN09zo
 H3CATzjz/fSw4QS7Qw7QbHldWtBfJ4KMbePSITioOopVGxP5ypPRcmHuE2OGYA4xP9zB
 oD6Q6J3x+77WV+lsH75LfhkYh3FK1wJ4jrHeifJ6SwKSL4CyMJqsPnGZFHRfiM4lA0Rz
 lEdIdq7jSivBI2+5lBCFkpreY9YeONml9wCUXu7wRPq8DTT+cn97eiPGE4lKYCdBikXf
 qI+g==
X-Gm-Message-State: AGi0PubPh18tXh5FZSWZ2rh8lv2DD7ws4zhSWg2hVhIUSZLI7lGMxCBA
 4XdJatdZobQAHFKUKD/2RqeipA==
X-Google-Smtp-Source: APiQypI+MmMGGz+TYoGq8cXHaBERMTvqhSuM/sSEgMeXaJoqf3cQl02cmOTdikXOHdqMfDlBWOYS+A==
X-Received: by 2002:a63:1415:: with SMTP id u21mr11305746pgl.452.1587774320451; 
 Fri, 24 Apr 2020 17:25:20 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i13sm5686195pja.40.2020.04.24.17.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2020 17:25:19 -0700 (PDT)
Subject: Re: [PATCH RFC] target/arm: Implement SVE2 TBL, TBX
To: Stephen Long <steplong@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20200423164236.5181-1-steplong@quicinc.com>
 <c1dc0aa8-783b-c91e-058f-52e3183f9202@linaro.org>
 <MWHPR0201MB354724516113DC31C0CFCD50C7D00@MWHPR0201MB3547.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b41a6863-d319-c437-c2a6-05c1172b3fa9@linaro.org>
Date: Fri, 24 Apr 2020 17:25:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <MWHPR0201MB354724516113DC31C0CFCD50C7D00@MWHPR0201MB3547.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Ana Pazos <apazos@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 3:47 PM, Stephen Long wrote:
> Oh, maybe I misread the manual description for SVE2 TBL, but I thought Zm was the indexes register and the loop compares the index from Zm with the total number of elems, table_elems.

That's right.  You take the index from Zm just fine, but fail to apply that
index properly across Zn and Zn+1.


r~

> 
> -----Original Message-----
> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Friday, April 24, 2020 2:37 PM
> To: Stephen Long <steplong@quicinc.com>; qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org; Ana Pazos <apazos@quicinc.com>
> Subject: [EXT] Re: [PATCH RFC] target/arm: Implement SVE2 TBL, TBX
> 
> On 4/23/20 9:42 AM, Stephen Long wrote:
>> Signed-off-by: Stephen Long <steplong@quicinc.com>
>>
>> These insns don't show up under any SVE2 categories in the manual. But
>> if you lookup each insn, you'll find they have SVE2 variants.
>> ---
>>  target/arm/helper-sve.h    | 10 +++++++
>>  target/arm/sve.decode      |  5 ++++
>>  target/arm/sve_helper.c    | 53 ++++++++++++++++++++++++++++++++++++++
>>  target/arm/translate-sve.c | 20 ++++++++++++++
>>  4 files changed, 88 insertions(+)
>>
>> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h index
>> f6ae814021..54d20575e8 100644
>> --- a/target/arm/helper-sve.h
>> +++ b/target/arm/helper-sve.h
>> @@ -2687,3 +2687,13 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_s, TCG_CALL_NO_RWG,
>>                     void, ptr, ptr, ptr, ptr, i32)
>> DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_d, TCG_CALL_NO_RWG,
>>                     void, ptr, ptr, ptr, ptr, i32)
>> +
>> +DEF_HELPER_FLAGS_5(sve2_tbl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr,
>> +ptr, i32) DEF_HELPER_FLAGS_5(sve2_tbl_h, TCG_CALL_NO_RWG, void, ptr,
>> +ptr, ptr, ptr, i32) DEF_HELPER_FLAGS_5(sve2_tbl_s, TCG_CALL_NO_RWG,
>> +void, ptr, ptr, ptr, ptr, i32) DEF_HELPER_FLAGS_5(sve2_tbl_d,
>> +TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>> +
>> +DEF_HELPER_FLAGS_4(sve2_tbx_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr,
>> +i32) DEF_HELPER_FLAGS_4(sve2_tbx_h, TCG_CALL_NO_RWG, void, ptr, ptr,
>> +ptr, i32) DEF_HELPER_FLAGS_4(sve2_tbx_s, TCG_CALL_NO_RWG, void, ptr,
>> +ptr, ptr, i32) DEF_HELPER_FLAGS_4(sve2_tbx_d, TCG_CALL_NO_RWG, void,
>> +ptr, ptr, ptr, i32)
>> diff --git a/target/arm/sve.decode b/target/arm/sve.decode index
>> 3a2a4a7f1c..483fbf0dcc 100644
>> --- a/target/arm/sve.decode
>> +++ b/target/arm/sve.decode
>> @@ -1387,3 +1387,8 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
>>
>>  CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
>>  SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5
>> ra=%reg_movprfx
>> +
>> +### SVE2 Table Lookup (three sources)
>> +
>> +TBL_zzz         00000101 .. 1 ..... 00101 0 ..... .....  @rd_rn_rm
>> +TBX_zzz         00000101 .. 1 ..... 00101 1 ..... .....  @rd_rn_rm
>> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c index
>> 55e2c32f03..d1e91da02a 100644
>> --- a/target/arm/sve_helper.c
>> +++ b/target/arm/sve_helper.c
>> @@ -2968,6 +2968,59 @@ DO_TBL(sve_tbl_d, uint64_t, )
>>
>>  #undef TBL
>>
>> +#define DO_SVE2_TBL(NAME, TYPE, H) \
>> +void HELPER(NAME)(void *vd, void *vn1, void *vm, void *vn2, uint32_t desc)  \
>> +{                                                                           \
>> +    intptr_t i, opr_sz = simd_oprsz(desc);                                  \
>> +    uintptr_t elem = opr_sz / sizeof(TYPE);                                 \
>> +    TYPE *d = vd, *n1 = vn1, *n2 = vn2, *m = vm;                            \
>> +    ARMVectorReg tmp1, tmp2;                                                \
> 
> Only one temp needed.
> 
>> +    if (unlikely(vd == vn1)) {                                              \
>> +        n1 = memcpy(&tmp1, vn1, opr_sz);                                    \
>> +    }                                                                       \
>> +    if (unlikely(vd == vn2)) {                                              \
>> +        n2 = memcpy(&tmp2, vn2, opr_sz);                                    \
>> +    }
> 
> Better with else if here.
> Because vd cannot overlap both vn1 or vn2, only one of them.
>                                              \
>> +    for (i = 0; i < elem; i++) {                                            \
>> +        TYPE j = m[H(i)];                                                   \
>> +        d[H(i)] = j < (elem * 2) ? n1[H(j)] : 0;                            \
>> +                                                                            \
>> +        TYPE k = m[H(elem + i)];                                            \
>> +        d[H(elem + i)] = k < (elem * 2) ? n2[H(k)] : 0;                     \
>> +    }
> 
> First, the indexing is wrong.
> 
> Note that you're range checking vs elem * 2, but only indexing a single vector.
>  Thus you must be indexing into the next vector.
> 
> This should look more like
> 
>     TYPE j = m[H(i)];
>     TYPE r = 0;
> 
>     if (j < elem) {
>         r = n1[H(j)];
>     } else if (j < 2 * elem) {
>         r = n2[H(j - elem)];
>     }
>     d[H(i)] = r;
> 
> Second, this is one case where I'd prefer to share code with AArch64.  It would be worthwhile to rearrange both sve1 and advsimd to use a common set of helpers.
> 
>> +static bool trans_TBL_zzz(DisasContext *s, arg_rrr_esz *a)
> 
> _zzz is not helpful here.  The SVE1 insn also operates on 3 registers, and thus could logically be _zzz too.
> 
> Better might be _double, after double_table = TRUE, or maybe just _2 just in case SVE3 adds a variant with more table registers.
> 
> 
> r~
> 


