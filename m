Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333D0C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBEAE208DB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIieqKW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEAE208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUYMc-0007NH-21
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 12:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUYIp-0005eb-OT
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUYIR-0002xJ-FE
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:14:15 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUYIR-0002wr-1u
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:13:51 -0400
Received: by mail-pf1-x443.google.com with SMTP id z1so1773872pfn.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JKXpnMhRsWCU37mbd0saCRVgrFFSwsREtPGyAIcikVA=;
 b=xIieqKW+DvUSAvOuxraO/Wsl3NsKijGSSB0Mp6fGTq+4C1Ma56o78POfEn8m0v4jsk
 bl3NbMgRdYd80AIiobCNQQT+LgK83oS7LBzpZDNIjFMuatY//WUfzJS0/9c58TzTAuLf
 sRu9vTEfYn5/ac8/4bPBk+TYZJ+6NvWLym0iM8Kt+EwzbtbqaZe7kV3n5+SdN2OId1hN
 hBuJY8FNK3GzFTlNGFyGhay8S2bsFkRqD5MVWCVkE5V5o/x3+YRZERVKjbCp1JwKtWYH
 r0D8C4kOgb5EAiEwQS4p1ToXSi67tdrTB2Uotn235IpbFB+Gc2jxLuvmfhAcKFvRhyqd
 wbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JKXpnMhRsWCU37mbd0saCRVgrFFSwsREtPGyAIcikVA=;
 b=Xr/y8dz+hez5b/EqE+4q95374IPQmHfebbeRnK89R+3bdAV3VKn7fppvZTEBL3ikba
 rK19DqHC0kEyAyHagWEIWZEgsF4ug1WIRAB7hrOtLTnthIWfYkxKfIUx0HqCNnLBd1R1
 n+M9zZNQUS4J0EbNLcwvL9SjABFCKCVoRiAXscDrJgj9z0BVee5uC56Q4lHE5EXOC6/3
 uIkATPcO64j42sQ7UAoICvryVNH0CMEBlzMT6qzFNeS7y4c4mf7bK0fvH78Vyh4wYR0H
 yGHNZNiSLTdB68bYV+F37xE9/Bv9n1Bu0Hm0fWvM5TmQ44vKA/v6sqVeeJrDjpAnUhae
 EdBg==
X-Gm-Message-State: AGi0PuYDTV4ZXl8FfOdf/L9NN7p1ugZgPLdzTpgDbPn8FxplUUtHqdU6
 ZQtgJ0KtG/W3Y5AL05ILhdK7E0NcHec=
X-Google-Smtp-Source: APiQypKIp7n0Nten2hE35YNoKNIPNaEELn0baOoW+fNYHEO2lH9LlhXb+LyVcGIWLgkfZRIFLleNMA==
X-Received: by 2002:a63:1f57:: with SMTP id q23mr1924492pgm.324.1588349629241; 
 Fri, 01 May 2020 09:13:49 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y2sm2645633pfq.16.2020.05.01.09.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 09:13:48 -0700 (PDT)
Subject: Re: [PATCH 23/36] target/arm: Convert Neon 64-bit element 3-reg-same
 insns
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-24-peter.maydell@linaro.org>
 <366a2e79-d963-bfdc-fcc6-2a63026fa1db@linaro.org>
 <CAFEAcA9kb2fpMcd-eLvdTD8dVjk=Ed9nKv2iHr_u_tpbBCa5HA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9b4cfbec-2fd3-3674-4622-1f0caccb43ed@linaro.org>
Date: Fri, 1 May 2020 09:13:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9kb2fpMcd-eLvdTD8dVjk=Ed9nKv2iHr_u_tpbBCa5HA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/1/20 8:54 AM, Peter Maydell wrote:
> On Thu, 30 Apr 2020 at 21:54, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 4/30/20 11:09 AM, Peter Maydell wrote:
>>> +
>>> +    rn = tcg_temp_new_i64();
>>> +    rm = tcg_temp_new_i64();
>>> +    rd = tcg_temp_new_i64();
>>> +
>>> +    for (pass = 0; pass < (a->q ? 2 : 1); pass++) {
>>> +        neon_load_reg64(rn, a->vn + pass);
>>> +        neon_load_reg64(rm, a->vm + pass);
>>> +        fn(rd, rm, rn);
>>> +        neon_store_reg64(rd, a->vd + pass);
>>> +    }
>>> +
>>> +    tcg_temp_free_i64(rn);
>>> +    tcg_temp_free_i64(rm);
>>> +    tcg_temp_free_i64(rd);
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +#define DO_3SAME_64(INSN, FUNC)                                         \
>>> +    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
>>> +    {                                                                   \
>>> +        return do_3same_64(s, a, FUNC);                                 \
>>> +    }
>>
>> You can morph this into the gvec interface like so:
>>
>> #define DO_3SAME_64(INSN, FUNC) \
>>     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,
>>                                 uint32_t rn_ofs, uint32_t rm_ofs,
>>                                 uint32_t oprsz, uint32_t maxsz)
>>     {
>>         static const GVecGen3 op = { .fni8 = FUNC };
>>         tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
>>                        oprsz, maxsz, &op);
>>     }
>>     DO_3SAME(INSN, gen_##INSN##_3s)
>>
>> The .fni8 function tells gvec that we have a helper that processes the
>> operation in 8 byte chunks.  It will handle the pass loop for you.
> 
> This doesn't quite work, because these are shift ops and
> so the operands are passed to the helper in the order
> rd, rm, rn. Reshuffling the order of arguments to
> tcg_gen_gvec_3() fixes this, though.
> 
> I guess I should call the macro DO_3SAME_SHIFT64, I hadn't
> noticed it was shift specific because the only thing we do
> with it is shifts.

See my reply to patch 26.  I think we should swap these operands during decode.


r~


