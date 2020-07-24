Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D847DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 21:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F969206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 21:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9W7W6Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F969206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz5Ye-00020J-Pz
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 17:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz5Xu-0001OD-FL
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 17:48:03 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz5Xq-0003cj-LS
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 17:48:02 -0400
Received: by mail-pg1-x541.google.com with SMTP id p3so6155727pgh.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 14:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wr4VGmL+brILUZZ6hS/vTStdypvVhVQSoCZ/djG3T8A=;
 b=S9W7W6VlCx69wn++W9DpblLl0OOPumvxK3afQXsQ+2sjWkU/H6gEPcvtiX4bAm1uaX
 Sy1msZFSUP0zA7Ydj+4rCFi1XvRoM+jfH0sG7K9MfwRGpreEu7I9ZZzoCafZUaoResxO
 xDR3DeFfqF+pxS+tt4FXiv/RN0W4MBA3d5QmwTtsXcQINNYMosWpds9Ushkg1ouBO965
 3Dl6Hjb72KhYLeWrlrXt189XX+xRuqFcZYTrWLqOf23SSF/92r9BCK/kh8xfK71nbP8T
 3+5LBicBK44q7wulXKfZHB+l5whw6+ELZL+6DziND8zyH8H2WBy0/4wHjuM1rTs0uRjI
 cz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wr4VGmL+brILUZZ6hS/vTStdypvVhVQSoCZ/djG3T8A=;
 b=YTkZrSm12MOUhzRSCS9jA2JtzIvEP9LENhy1X2IE/0AtZB+zwPfPgl30z+K0OisEbG
 Bhlm5LOZdLy+KxFxQn0GFR7F/zMbp5k0uE/BWdRAAndsbi4jMpVo1sQkEIFMWWQGi28T
 Y0e9HWt05QaOI43mnIc3sVzFm4K0I5zmqzVAleVZ06f/K9BXZBTnBLpCVlqbHb6OPJXf
 /YpxIl3iof/rTUY0M3LJXTrek+qZcqDFHUGDtG0EAkVGwDnTS/NvP6x0wH3Do+Oxnvtd
 eLO1xnRysGN8R6m04EryzPbryAEdPYis3azY4QJENshaU5WLmibnk0wI5wqObXLYJ8Ea
 Jtgw==
X-Gm-Message-State: AOAM531qjplLgzbmIdCKs37IAii29/ifrW/zt1m1fpI23uBD6+iOu/lU
 BV7kzWTRqLxdgV5QmJneC1eMOA==
X-Google-Smtp-Source: ABdhPJxHAyHhvrohnlaPUi+YboKdI4YEPnWzVvT4Cobzw97YDJ1RhsCEZEICTlhvZEzAw7HGTF9/bA==
X-Received: by 2002:a05:6a00:158b:: with SMTP id
 u11mr10569063pfk.92.1595627276665; 
 Fri, 24 Jul 2020 14:47:56 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 ml8sm6722160pjb.47.2020.07.24.14.47.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 14:47:55 -0700 (PDT)
Subject: Re: [PATCH for-5.1?] target/i386: Save cc_op before loop insns
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200720154028.477457-1-richard.henderson@linaro.org>
 <cc3e60e3-e150-4b62-cb8e-abc71920f897@linaro.org>
 <CABgObfZVXtspgcoG_b33j5NcCSJFiBCXntT+388GWFuJ0aTh2A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <72edd3a8-55df-221c-5b4a-8e8f4a80b07d@linaro.org>
Date: Fri, 24 Jul 2020 14:47:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABgObfZVXtspgcoG_b33j5NcCSJFiBCXntT+388GWFuJ0aTh2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, "Habkost, Eduardo" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 11:53 AM, Paolo Bonzini wrote:
> Looks good, will queue when I am back---or just send a pull request yourself if
> you prefer.

Ok, will do.  Thanks.


r~

> 
> Paolo
> 
> Il ven 24 lug 2020, 20:35 Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> ha scritto:
> 
>     Ping?
> 
>     On 7/20/20 8:40 AM, Richard Henderson wrote:
>     > We forgot to update cc_op before these branch insns,
>     > which lead to losing track of the current eflags.
>     >
>     > Buglink: https://bugs.launchpad.net/qemu/+bug/1888165
>     > Signed-off-by: Richard Henderson <richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>>
>     > ---
>     >  target/i386/translate.c | 1 +
>     >  1 file changed, 1 insertion(+)
>     >
>     > diff --git a/target/i386/translate.c b/target/i386/translate.c
>     > index a1d31f09c1..caea6f5fb1 100644
>     > --- a/target/i386/translate.c
>     > +++ b/target/i386/translate.c
>     > @@ -7148,6 +7148,7 @@ static target_ulong disas_insn(DisasContext *s,
>     CPUState *cpu)
>     >              l1 = gen_new_label();
>     >              l2 = gen_new_label();
>     >              l3 = gen_new_label();
>     > +            gen_update_cc_op(s);
>     >              b &= 3;
>     >              switch(b) {
>     >              case 0: /* loopnz */
>     >
> 


