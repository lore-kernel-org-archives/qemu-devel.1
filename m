Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2EFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 17:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C49D2253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 17:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ctNK36Og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C49D2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuJXq-0003MK-PV
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 12:11:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuJWx-0002vz-45
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 12:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuJWv-0003k5-QJ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 12:11:02 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuJWv-0003js-J0
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 12:11:01 -0500
Received: by mail-pl1-x642.google.com with SMTP id t14so22068plr.8
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 09:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=p0dY6uwo0rYrQya3U6PT1mXiygQhovDrXowjg7G9TS0=;
 b=ctNK36OgKRXwvOEfsq7EZ6ZFYp55dNgyp/snSxAhbM2tI2GvkRrBNM9ct/xJj5g+OP
 yijv9wVLfCjVCcPRL+5txr6X4nEt68bh+0jB2IAg70WcgjiuJN1WZ5cuOM0XBr+DOfuG
 5C9gsuNeyxsCt4fP1epZi7fBKeNosmBcoqDspe4SXQfekf49dodBmgMNVgaDexuOrLwE
 Pg5Zdlhg9GMJjHo2XlmsuOV1SG7XbXR22AjHGGmp5Hw3pPV+vUIZiWSLn0ULF8q2uji6
 GqGAxZeKT38r14xIvWJVR4vCNgyps5ZB7hHCHaZ8avs9MaPq0DR8ZUMIk5drD3Fon3/t
 oJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p0dY6uwo0rYrQya3U6PT1mXiygQhovDrXowjg7G9TS0=;
 b=hpaCjkZGZBj6Rme7Qy94nBJXtDX0gwH9rIK0a3Egw+3X7x2MZnu93/FtiXs7WHONmy
 vd8u/Z2GYPDn1nP6kCj/QcQueQSSnu9Vik6heWaTj0j7sWUTsU11/h9jt+otvpury5rm
 qDRwkgv+mBoqGZJcoauX/Bjv+OD7SerDU2J97F/groQG/YnmDiL3rI8mZuYPjyH+1GJq
 QWe60n7ftCAgW3CO5lh3GQLji3SJ1Td8K4nnwWAPSzXInNr1ZRl6TliPHDRe+LuzRt7u
 Xg9kBbfiG+lpwZW7f6Ju3CNTJPUT6wEWdpRvXQORnoStJUOWpIJAfR4kVFNZCIWhSKpL
 WfRA==
X-Gm-Message-State: APjAAAV0wIGnwGeQ5U0JibflfWzjhc6K3Aq0qIsNXUZynSb0z2vDRGEc
 C7fhgfhvzlkRHe16bL4Xon71bw==
X-Google-Smtp-Source: APXvYqz0MBgFWy/XRzzKI3Hk06Iq9reh+0JQHCFf80VdgGI7l63Mca82qVTpXn3aSzdjUxfPADzt/g==
X-Received: by 2002:a17:90a:2e88:: with SMTP id
 r8mr4147753pjd.85.1579713060432; 
 Wed, 22 Jan 2020 09:11:00 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id g67sm49175156pfb.66.2020.01.22.09.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 09:10:59 -0800 (PST)
Subject: Re: [PATCH] riscv: Format Rd of FMV.W.X with NoN-boxing
To: Ian Jiang <ianjiang.ict@gmail.com>
References: <20200122072448.18510-1-ianjiang.ict@gmail.com>
 <b9084f13-0836-7f74-a870-608bf3f8f6a9@linaro.org>
 <CAMAD20=RS=tt04db3NfiPfXJo2Cr5PfCF-39E8qeuehnVGMdKg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <25fb635f-6d92-70d0-9bcd-7f5a5de1a97b@linaro.org>
Date: Wed, 22 Jan 2020 07:10:54 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMAD20=RS=tt04db3NfiPfXJo2Cr5PfCF-39E8qeuehnVGMdKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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

On 1/21/20 11:53 PM, Ian Jiang wrote:
> --
> Ian Jiang
> 
> Richard Henderson <richard.henderson@linaro.org> 于2020年1月22日周三 下午4:53写道：
>>
>> On 1/21/20 9:24 PM, Ian Jiang wrote:
>>> For FMV.W.X that moves the lower 32 bits of an integer register to a
>>> floating-point register, Rd should encoded with NoN-boxing scheme.
>>> Note: This applies to RV64 only.
>>>
>>> Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
>>> ---
>>>  target/riscv/insn_trans/trans_rvf.inc.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
>>> index 172dbfa919..62b7a36567 100644
>>> --- a/target/riscv/insn_trans/trans_rvf.inc.c
>>> +++ b/target/riscv/insn_trans/trans_rvf.inc.c
>>> @@ -368,6 +368,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
>>>
>>>  #if defined(TARGET_RISCV64)
>>>      tcg_gen_mov_i64(cpu_fpr[a->rd], t0);
>>> +    tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd], 0xffffffff00000000ULL);
>>>  #else
>>>      tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
>>>  #endif
>>>
>>
>> This doesn't look right.  There's nothing in the spec that says the nan-boxing
>> is restricted to rv64.  NaN-boxing is all about FLEN, not XLEN.
>>
> 
> Why the translation of FLW has a NaN-boxing?
> 
> file ./target/riscv/insn_trans/trans_rvf.inc.c
>  26 static bool trans_flw(DisasContext *ctx, arg_flw *a)
>  27 {
> ...
>  34     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL);
>  35     /* RISC-V requires NaN-boxing of narrower width floating point values */
>  36     tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd], 0xffffffff00000000ULL);
> ...
>  41 }

Eh?  Obviously because we're loading a 32-bit value into a FLEN=64 bit register.

(Except when we've selected a cpu without RVD, I suppose, but in that case this
nan-boxing is both harmless and invisible.)


r~

