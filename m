Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E411BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFB12078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQtb2tJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFB12078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GQ3-0006Wu-1A
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6GPT-00065v-EA
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:48:59 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:36055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6GPR-0003jF-Hu
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:48:59 -0400
Received: by mail-pj1-x1033.google.com with SMTP id ha11so3026433pjb.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 09:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cZH5skr6rOrtgBUCRon1f9+GRdMzgbI3iiSHDRP6K0U=;
 b=OQtb2tJ2sSNwizE546Kf7tcFrAckRi5IaJ32ZFuuoDqP51hmCARuxoypwk+IrY1FbG
 wFqJKL+4CoIbIiM4r9xWuc+VGf3sLOnDsBufB9yar2lukffm8CDaRtSme/KS3MngE4qW
 OLFvDyC46lc+JKau/tbpkp4KK8dZzGzhuS5leeEJb9oD+iX6/qzf/O9uCjgcWeIZ9u2m
 UASnI2sST7AcGDny7qzIrZoyDkcfMs5vvJUP7c2e5MGkjbv6k9aJ7+X7cydSjF7xljCr
 4zeaOacqHmct+MhAm8SuKy6WgcmUl8dt4kTRcqjj4FJrX0TcOaeI/QS3udHQXqZvVuEO
 rWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cZH5skr6rOrtgBUCRon1f9+GRdMzgbI3iiSHDRP6K0U=;
 b=XE3aNHgJuL8losCsjyyTRBq26PRgCSStybQyqFlsySzAGRtfioKdNVBoVc1r6vOGgZ
 L+MTD7hBtBs68Z57jZMUwpbStQKPBQ5/iPK5o5xhDNhldGLIGp85C4hocTZbVKG6DMoD
 L2GQ41QowssU/7AXcQGtdvT0I8ktOFDsoZGePtkrO35KzgHMAhO6jkL68/qaKkGnW27a
 1hCOmOasw7b3fTcIKO7z9d/6S/RMOCJnNePX2Q3O9pmlvs1cUBj4E8+rGIZarEv2SGL1
 CxfyagQdM6ntCvc1SgwwXh1bJJhhZ+/SFebEtscd3JjP+IdcmxmnH4bSrNud0iOIasm3
 V9ig==
X-Gm-Message-State: AOAM531Qpd1yLSaX6i8LpwvZLK1IjwKsKro6c///rlftMTsHWYzqdIsC
 1VpruEjlVdNW9xIeFf+nnXw25KZ3eMg=
X-Google-Smtp-Source: ABdhPJxwwso70CGj9w8hWOgPrAqL4exAIhfydFs/n79K4tT9DqEQ/6YhfuVEy3fbzgLt0g4kaPFAkg==
X-Received: by 2002:a17:90a:17ab:: with SMTP id
 q40mr6142204pja.28.1597337335496; 
 Thu, 13 Aug 2020 09:48:55 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a24sm6399784pfg.113.2020.08.13.09.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 09:48:54 -0700 (PDT)
Subject: Re: [PULL 05/20] target/riscv: Check nanboxed inputs in
 trans_rvf.inc.c
To: Alistair Francis <alistair23@gmail.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
References: <20200812223045.96803-1-alistair.francis@wdc.com>
 <20200812223045.96803-6-alistair.francis@wdc.com>
 <39d42765-01de-2439-093d-c0246d81a7ce@c-sky.com>
 <CAKmqyKMBpR0R4C+81GVjjcq39rHDJ9YHUTekopogxnsh1UYWhQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dca8e8bb-5f30-84e1-c2a1-02b281c24c79@linaro.org>
Date: Thu, 13 Aug 2020 09:48:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMBpR0R4C+81GVjjcq39rHDJ9YHUTekopogxnsh1UYWhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Chih-Min Chao <chihmin.chao@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 7:46 AM, Alistair Francis wrote:
>> Hi Alistair,
>>
>> As Chih-Min said, it's wrong here.  He has given the correct patch code
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg728540.html
>>
>> We can either  squash the code to this patch or add an separate patch
>> later. I prefer the former.
>> Thanks very much.
> 
> Richard are you ok if I squash this diff into the patch and send a PR v2?
> 
> diff --git a/target/riscv/insn_trans/trans_rvf.inc.c
> b/target/riscv/insn_trans/trans_rvf.inc.c
> index f9a9e0643a..76f281d275 100644
> --- a/target/riscv/insn_trans/trans_rvf.inc.c
> +++ b/target/riscv/insn_trans/trans_rvf.inc.c
> @@ -201,7 +201,8 @@ static bool trans_fsgnjn_s(DisasContext *ctx,
> arg_fsgnjn_s *a)
>           * This formulation retains the nanboxing of rs1.
>           */
>          mask = tcg_const_i64(~MAKE_64BIT_MASK(31, 1));
> -        tcg_gen_andc_i64(rs2, mask, rs2);
> +        tcg_gen_not_i64(rs2, rs2);         // forget to inverse rs2
> +        tcg_gen_andc_i64(rs2, rs2, mask);  //mask needs to be

Ah, well.  Yes, it's a bug.  However,

   ~rs2 & ~mask
= ~(rs2 | mask)

so a better fix could be

-    tcg_gen_andc_i64(rs2, mask, rs2);
+    tcg_gen_nor_i64(rs2, rs2, mask);


As an aside, I think perhaps I should have added a ppc-style rotate-and-insert
primitive to handle this sort of bitfield insert, since the best set of host
insns to perform this operation, when the start of the field is not bit 0, is
difficult to predict from the translator.


r~

