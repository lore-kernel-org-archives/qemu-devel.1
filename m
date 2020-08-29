Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5BAC433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 19:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF9020776
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 19:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivg2HZg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF9020776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC6u4-0003VM-HM
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 15:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC6tV-0002zZ-Pa
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 15:52:09 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:38852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC6tT-0004b2-B2
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 15:52:09 -0400
Received: by mail-pj1-x1034.google.com with SMTP id ls14so1056711pjb.3
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gfwoJtnNjVz5NJWtSW9eqlRI5s2+XhYnp6L4ns5VtwY=;
 b=ivg2HZg2rNoPfRT3V7198VBu3im6w+tvZozJRyAxsiRFecSvlIlo1SJRdOZS9F3ik7
 HHYVByf44XAEZNxp94vDItpA1KAbrCa/1+BpOaGEfRBO2asTZZzaoVg4ESP9Knjd43CW
 x8PVnVBmcsMCnPuVVkKFV0T+k1Yb1AqCz4k/cGLFn3NCLL7Tk4X2rlY7n4n98huCKL0P
 o0jHblFjjepUL5z79JabC1meXeWg84MrzhEutM1WHGxr0f8YREUq3VCV/yNgng7qXYqK
 hY01tXOm51VVqd1k63LmhohNiWJhdF7hL0I7zFytEq+3Xnfhu8oOUhHPkk3H8i1aPZdA
 EAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gfwoJtnNjVz5NJWtSW9eqlRI5s2+XhYnp6L4ns5VtwY=;
 b=iOz8Pl/WMKecS2v+FN58WQcQuf88rdagyN2Zn59zbO7VJymUyxlVogSU155ViEaaNj
 RTVQlBA/U0mp1PUbY6jqKWnjMk4taiBuWAkQtwSis72AVHfSv2S06pe+yTsmbZrIIPPo
 zGxiRx15UTZ10YYjMlDh8iaJJ1rNUFkk+bQBbjwZMJg0jdh+aF5r5AOx2Xtt8L3o+rRI
 NJSTV83JrPNJE5RlzqXgI2PpZgHBEQKAHE4uOeB1XhqCtJZ+Z85//tRi0tKRoj3zp9Tj
 b8NYWczitp46Qj3gI8aP0QTwvfL5PpyBftFJX+vE1ezHBg2akKGCZ2GMnIBdQW5PJPyv
 f1bw==
X-Gm-Message-State: AOAM533aSz9siRz9YyZBYo31pbFfapOQV8vBlrRSI+NpkvCyzPySmQ4l
 tnux2NdoPdzPo+Wpv/D0/STxsg==
X-Google-Smtp-Source: ABdhPJxuUvX4i5vDDMb1fLPMQjAh3+XXsEp5XmTOX9xTtiWHsdMuqg34Uxa9zq8hsLqpMFPVVJI3aw==
X-Received: by 2002:a17:902:aa91:: with SMTP id
 d17mr3493068plr.27.1598730725674; 
 Sat, 29 Aug 2020 12:52:05 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l21sm3112579pgb.35.2020.08.29.12.52.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 12:52:04 -0700 (PDT)
Subject: Re: [RFC v4 34/70] target/riscv: rvv-1.0: register gather instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-35-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <01bb0e6e-b80a-0433-845a-78b93c7dd422@linaro.org>
Date: Sat, 29 Aug 2020 12:52:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-35-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> +static bool vrgatherei16_vv_check(DisasContext *s, arg_rmrr *a)
> +{
> +    int8_t emul = 4 - (s->sew + 3) + s->lmul;

Similarly for EEW elsewhere.  This should be

    int emul = MO_16 - s->sew + s->lmul;

> @@ -3339,7 +3353,8 @@ static bool trans_vrgather_vx(DisasContext *s, arg_rmrr *a)
>      }
>  
>      if (a->vm && s->vl_eq_vlmax) {
> -        int vlmax = s->vlen;
> +        int scale = s->lmul - (s->sew + 3);
> +        int vlmax = scale < 0 ? s->vlen >> -scale : s->vlen << scale;

Isn't this what s->vlen is already computed as?


> +#define GEN_VEXT_VRGATHER_VV(NAME, TS1, TS2, HS1, HS2)                    \
>  void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
>                    CPURISCVState *env, uint32_t desc)                      \
>  {                                                                         \
> -    uint32_t vlmax = vext_max_elems(desc, ctzl(sizeof(ETYPE)));           \
> +    uint32_t vlmax = vext_max_elems(desc, ctzl(sizeof(TS1)));             \

Surely you can't just use TS1?  For vrgatherei16_vv_[wd], the maximum number of
elements is still bound by TS2.


r~

