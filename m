Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30096CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABCC222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZO/d5Yct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABCC222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTL5-0003Hg-4x
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLTHN-0007on-80
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLTHL-0002Tt-Qo
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:30:56 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41420)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLTHK-0002RG-VC
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:30:55 -0400
Received: by mail-pg1-x541.google.com with SMTP id t3so3477693pga.8
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fU1NueAD/s8135/rW4pdQWedNLJY8vsK60SBCyhq5rA=;
 b=ZO/d5YctePpGmfSUHwohzPBgSO0wyT7wggiByGXsIgmrd4AFfMX8Mpo33Wov4Pv8e2
 WXyW6w4aD5/VDEW0UU+9NaV5oMtbPA9yjyyin3ivsHT4A6I6Vu250SIALK4+0Qj21ISE
 557MkMCmu3kZDyX1ql7wxGqhpTjfq21FXsjJprgmi0aym+R8Z6OjU7tmL5UNtgpfnaqS
 kP84KuusKybE1ej6XXfZO6BRr6doukbWWs2EU0QE9ouOgKqFOMQ2eTGl5rQFx3VeTuRf
 vgNTbHFfPyhuFHun8dCZ4NN7HXZCE7ph1cuIZkYRFh8gZktSvLAcF4OG9Phog+/ybnd+
 Oncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fU1NueAD/s8135/rW4pdQWedNLJY8vsK60SBCyhq5rA=;
 b=bYtTHRBcIMiVPmbnqCAPZefFwEXJcWcNFup7FlCXlkxNhxEOLxYYC7EkQSjxxxhg2E
 LFnFuV4TtCVIq1aXKpyVQ6GkuoJTbJfz/8f8kjvwWG1vkKuFnjAk6iZhdA7QHlC/NCHj
 WT4o2gNujhPYNaT2vc1//Bw3rI4OmWkLBRwhXtbEPO1iVt402+GLBh4az57+AR8jOuc/
 +fKkAP7A1OuOu6GoeH3ohmO+KpEcuZI0UfrZJYy9vynjgUHCujomsnK/hMXrNMoxazn0
 7XpqikG5u0jiePgq73Ie1N7b8gCxmF04O6XcisKso2LAcvQjDiSf2hsQY6WS3Pir6f/2
 styw==
X-Gm-Message-State: APjAAAUiyh2QdCvBP5ksJ8NAfW5ak8aPOcN2u+yE9e9gy30gytKM8DZR
 6jf+NZdp7OOX/gO9F5IaPT9Rjg==
X-Google-Smtp-Source: APXvYqwoYLPbj51Vx9GMd29PjPF1Eicodg1AAisXNDSpYIU0EIxAPlYEfFsFroABjoKcEuBJH72NFg==
X-Received: by 2002:a63:c1:: with SMTP id 184mr10515080pga.224.1571409053273; 
 Fri, 18 Oct 2019 07:30:53 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n23sm6180925pff.137.2019.10.18.07.30.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Oct 2019 07:30:52 -0700 (PDT)
Subject: Re: [PATCH v7 17/20] target/arm: Rebuild hflags at MSR writes
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191017185110.539-1-richard.henderson@linaro.org>
 <20191017185110.539-18-richard.henderson@linaro.org>
 <CAFEAcA8h9CN_qarQdfXRonE8KYO2=s+Jh_o+LFs9qk9M20pweA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <16af4176-3acd-14bf-5399-31e5bb882120@linaro.org>
Date: Fri, 18 Oct 2019 07:30:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8h9CN_qarQdfXRonE8KYO2=s+Jh_o+LFs9qk9M20pweA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 5:32 AM, Peter Maydell wrote:
> On Thu, 17 Oct 2019 at 19:51, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Continue setting, but not relying upon, env->hflags.
>>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate-a64.c | 13 +++++++++++--
>>  target/arm/translate.c     | 28 +++++++++++++++++++++++-----
>>  2 files changed, 34 insertions(+), 7 deletions(-)
>> @@ -7068,14 +7070,30 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
>>              }
>>          }
>>
>> -        if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
>> -            /* I/O operations must end the TB here (whether read or write) */
>> -            gen_lookup_tb(s);
>> -        } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
>> -            /* We default to ending the TB on a coprocessor register write,
>> +        /* I/O operations must end the TB here (whether read or write) */
>> +        need_exit_tb = ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) &&
>> +                        (ri->type & ARM_CP_IO));
>> +
>> +        if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
>> +            /*
>> +             * A write to any coprocessor regiser that ends a TB
> 
> (typo: "register")
> 
>> +             * must rebuild the hflags for the next TB.
>> +             */
>> +            TCGv_i32 tcg_el = tcg_const_i32(s->current_el);
>> +            if (arm_dc_feature(s, ARM_FEATURE_M)) {
>> +                gen_helper_rebuild_hflags_m32(cpu_env, tcg_el);
>> +            } else {
>> +                gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
>> +            }
>> +            tcg_temp_free_i32(tcg_el);
> 
> Why only rebuild hflags if !ARM_CP_SUPPRESS_TB_END ?
> For instance on the Xscale CPUs we set SUPPRESS_TB_END for the SCTLR,
> but some of the SCTLR bits are cached in hflags, right? Do we somehow
> arrange to rebuild the hflags when the TB does eventually end ?

No, we don't.  I assumed that all registers which change TB flags would in fact
end the TB.

Why did we suppress tb end for Xscale?


r~

