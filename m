Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FC4C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 03:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3CD2465B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 03:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cT1StKAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3CD2465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuSqR-00023x-LA
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 22:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuSpr-0001fV-Oa
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 22:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuSpq-0005U2-FU
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 22:07:11 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuSpq-0005Sy-8u
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 22:07:10 -0500
Received: by mail-pl1-x644.google.com with SMTP id c9so719792plo.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 19:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9pXsFS4Ya4k+c8jpbyjF+YY0UN1D2Eswqw1I8vAnjMc=;
 b=cT1StKARMSwP2lUa+wP2UbndBdtIkP4cW7PZwOSLcFD9DXbqPg0rA16LXauOKux1jH
 3XObBVqiA0UjLOuGGvwoYCuihzfFFI+u0AE1UGkdUxYyokTIJM/2VEgnu6KjY9WC3oGr
 oA6HPdDrR7FVn1Fhe24UeU9NG1Tvcsx/YQEhFVROkTzdqvhUZsNfECREt2OqMVE7XMld
 Lf9yToZ2ADO9svfyZ3jA/JbEnce2xQosmHaYECNJDSK6Jt7ixdtAiOnLZWwJvlpl7E0D
 Ehyjkhk7sahiqxTykWsLBGDMdEu+gdWOvDFhcxbBP5/VgLRTSYFTUZ6BZHPbnge4VzO9
 BF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9pXsFS4Ya4k+c8jpbyjF+YY0UN1D2Eswqw1I8vAnjMc=;
 b=qQNJ46bUa4v3Ny/eoZcD3vbtXZpGjVLTg/WHAX9oS9A1oFfL0I42/745bpdoi5MHZy
 +o8ZEa/QpkT0b5nCUrfx3NHTlKh+kfTIgVldkXs20RwBuxRtvNCVUpVrKAIKbAeStKc9
 tebBCN/sxRvC+LLIfrlDuvTHhFPzD/kUQnR4JaGhtp4rmvCWjdDOESeFsuhlSq9B7g/l
 Eg1z8/vGYgRQrMbNeg0qD93lv1fGUuAzvq+0PF3hVgu0FRWfa/XSXFY4nzj3Gad+SNF5
 4MLqxjwwXwH67adrhGuk9FHeyA0wlKq65EwyA2Aw2uqNP7UFGYIApUSvG3D8saeCmyFW
 zO0w==
X-Gm-Message-State: APjAAAWpASdCOJUqUx6EwIwICR2WHeierl/9JL/XQk+f7CDT7Qe0zRwV
 bkdg15G4b2qk8SdJuxnwpomQsg==
X-Google-Smtp-Source: APXvYqzQF15BF6eKo8aV2ewmICeRZfG2U3gvS5yf0yCvzSVXQjrmycw/va1qgD2tiTFIqRY1o/Hytg==
X-Received: by 2002:a17:902:7b92:: with SMTP id
 w18mr14006200pll.72.1579748828962; 
 Wed, 22 Jan 2020 19:07:08 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id i3sm309570pfg.94.2020.01.22.19.07.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 19:07:08 -0800 (PST)
Subject: Re: [PATCH] riscv: Format Rd of FMV.W.X with NoN-boxing
To: Ian Jiang <ianjiang.ict@gmail.com>
References: <20200122072448.18510-1-ianjiang.ict@gmail.com>
 <b9084f13-0836-7f74-a870-608bf3f8f6a9@linaro.org>
 <CAMAD20=RS=tt04db3NfiPfXJo2Cr5PfCF-39E8qeuehnVGMdKg@mail.gmail.com>
 <25fb635f-6d92-70d0-9bcd-7f5a5de1a97b@linaro.org>
 <CAMAD20mgs=wBbsXAa6KsPP7SjNu1xfcM3wnqsAVExps3oufrtw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a7b4ec6a-1f41-45c3-d7a6-0b69fef1f379@linaro.org>
Date: Wed, 22 Jan 2020 17:07:04 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMAD20mgs=wBbsXAa6KsPP7SjNu1xfcM3wnqsAVExps3oufrtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/22/20 2:48 PM, Ian Jiang wrote:
> Richard Henderson <richard.henderson@linaro.org> 于2020年1月23日周四 上午1:11写道：
>>
>> On 1/21/20 11:53 PM, Ian Jiang wrote:
>>> --
>>> Ian Jiang
>>>
>>> Richard Henderson <richard.henderson@linaro.org> 于2020年1月22日周三 下午4:53写道：
>>>>
>>>> On 1/21/20 9:24 PM, Ian Jiang wrote:
>>>>> For FMV.W.X that moves the lower 32 bits of an integer register to a
>>>>> floating-point register, Rd should encoded with NoN-boxing scheme.
>>>>> Note: This applies to RV64 only.
>>>>>
>>>>> Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
>>>>> ---
>>>>>  target/riscv/insn_trans/trans_rvf.inc.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
>>>>> index 172dbfa919..62b7a36567 100644
>>>>> --- a/target/riscv/insn_trans/trans_rvf.inc.c
>>>>> +++ b/target/riscv/insn_trans/trans_rvf.inc.c
>>>>> @@ -368,6 +368,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
>>>>>
>>>>>  #if defined(TARGET_RISCV64)
>>>>>      tcg_gen_mov_i64(cpu_fpr[a->rd], t0);
>>>>> +    tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd], 0xffffffff00000000ULL);
>>>>>  #else
>>>>>      tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
>>>>>  #endif
>>>>>
>>>>
>>>> This doesn't look right.  There's nothing in the spec that says the nan-boxing
>>>> is restricted to rv64.  NaN-boxing is all about FLEN, not XLEN.
>>>>
>>>
>>> Why the translation of FLW has a NaN-boxing?
>>>
>>> file ./target/riscv/insn_trans/trans_rvf.inc.c
>>>  26 static bool trans_flw(DisasContext *ctx, arg_flw *a)
>>>  27 {
>>> ...
>>>  34     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL);
>>>  35     /* RISC-V requires NaN-boxing of narrower width floating point values */
>>>  36     tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd], 0xffffffff00000000ULL);
>>> ...
>>>  41 }
>>
>> Eh?  Obviously because we're loading a 32-bit value into a FLEN=64 bit register.
> FMV.W.X is the same with FLW at this point that filling a 64 bits
> float register based on 32 bits value.
> Besides, the RISCV simulator Spike makes NaN-boxing for FLW, FMV.W.W,
> FADD.S, FSUB.S, and others.
> It might be better that they have a coincident behavior? I am not sure
> about this and just want a discussion.

So, I wonder if we're talking past one another.

In reply to the patch at the beginning of this thread, I was suggesting that
the correct solution is

 #if defined(TARGET_RISCV64)
     tcg_gen_mov_i64(cpu_fpr[a->rd], t0);
 #else
     tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
 #endif
+    tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
+                    0xffffffff00000000ULL);

However, after the previous follow-up I wonder if it might be better to split
out the nan-boxing to a helper:

/*
 * RISC-V requires NaN-boxing of narrower width floating
 * point values.  This applies when a 32-bit value is
 * assigned to a 64-bit FP register.  Thus this does not
 * apply when the RVD extension is not present.
 */
static void gen_nanbox_fpr(DisasContext *ctx, int regno)
{
    if (has_ext(ctx, RVD)) {
        tcg_gen_ori_i64(cpu_fpr[regno], cpu_fpr[regno],
                        MAKE_64BIT_MASK(32, 32));
    }
}

which could elide this when only RVF is enabled, and thus
the upper 32-bits of the register are inaccessible.

This helper would then be propagated to the existing uses within translate.c
and insn_trans/trans_rvf.inc.c.

As another cleanup, the ifdef above may be replaced with

    tcg_gen_extu_tl_i64(cpu_fpr[a->rd], t0);

which will handle both RISCV64 and RISCV32.


r~

