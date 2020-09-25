Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E83C4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA5320878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkdOtJ7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA5320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLsSu-0000CE-Dd
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 14:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLsS1-00083g-Ad
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:28:09 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:43285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLsRy-0006gh-Ae
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:28:09 -0400
Received: by mail-pf1-x42f.google.com with SMTP id f18so3980997pfa.10
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tq0Mp12PiH2oU/B1omkMHXYny6gqJjRNnKz1baeJYJg=;
 b=LkdOtJ7h+wNwVVCEsZczordwyXpaYVkbpCFYwNeeuWjEOeW3LO5CmlLbXBeNbPUiFv
 QP3MN+VYg13hjXjIqNrEKELMNkCkJrUohexlA0pVwKeNKRRZogV/U5+ssotBqxFwjFe+
 +uG3QUh9jb9WkGsIky8yzGE7UfZSkC3teTdKV/k1xhSDCXFNv7ipccnwqaEDYMIARs+8
 3fP8Ye8Wkc4zQonm6vZdICjBZ3EnqUzztxt5Hy4MQustEBZl8c4x30f//PWygJ9M5O6h
 VK0k/tO+lttbT+RhZLyoY8ZX3qS7ENF9ZLUBGkJFeSVPVGkc7c2eGLujCCcNPImmEE/Y
 A7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tq0Mp12PiH2oU/B1omkMHXYny6gqJjRNnKz1baeJYJg=;
 b=Z54Eej1YdPzvALAxpsCpuTTxuI9CFoUC/sZ7nhMr3yb8zJ99lZvDuL/YRU8GzbaUFr
 88B8JrDaLvUwdvQozxIvqU9ZYCe8N4eAlPGPyfLCJukLI/PHjx/awMNslWE8OMUSCzV3
 mOwGvccIJfh2D7bz5so/GOq9TDrHqmu9CD9ugzCEkSvF1Ww71+WN6R2kj7oUI8jAoYqY
 NtgxDLyqcO/ybuUaMXQc5gObYgNYFfECRFf+y3bP9jH1yDYLdaOI24BwcyvimuBWddZB
 O2aTPxRW6Y3/ayvmoVyLfM2dd6VzhxFOdOnF1VgvNA+iGv6B1FYuyjW4RRLO8fac6rY4
 Pxiw==
X-Gm-Message-State: AOAM530pDeMEx2CstR5TELtIIkc25jaSYvpQ+ctBRmQerptm3Foj51bx
 Uiw602G+fy1DR0SuB/mDj+0BpQ==
X-Google-Smtp-Source: ABdhPJyt2fuBhrLxEj8j3QjT6H8QRR5it6QPaDkfx2PoPJ3zwsvQIuYY2CzG8qWy2KA3N/HrhQXjbA==
X-Received: by 2002:a63:774e:: with SMTP id s75mr217160pgc.37.1601058484637;
 Fri, 25 Sep 2020 11:28:04 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 203sm3360175pfz.131.2020.09.25.11.28.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 11:28:03 -0700 (PDT)
Subject: Re: [RFC v4 17/70] target/riscv: rvv-1.0: configure instructions
To: Frank Chang <frank.chang@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-18-frank.chang@sifive.com>
 <CAE_xrPj_fb1NER3a68O1dwzM70wvmb+8+NyDo_9z=POCjYTvQw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <faf5ad2f-5f00-e80d-761d-6d19b98ec238@linaro.org>
Date: Fri, 25 Sep 2020 11:28:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE_xrPj_fb1NER3a68O1dwzM70wvmb+8+NyDo_9z=POCjYTvQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
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

On 9/25/20 1:51 AM, Frank Chang wrote:
> trans_vsetvli() uses gen_goto_tb() to save the computation in the link to the
> next TB.
> I know there was a discussion about this back in RVV v0.7.1:
> https://patchew.org/QEMU/20200103033347.20909-1-zhiwei_liu@c-sky.com/20200103033347.20909-5-zhiwei_liu@c-sky.com/
> 
> However, we had encountered an issue that looked like it was caused by the
> linked TB.
> The code snippet which cause the issue is:
> 
> 00000000000104a8 <loop>: 104a8: 0122ffd7 vsetvli t6,t0,e32,m4,tu,mu,d1 104ac:
> 02036407 vle32.v v8,(t1) 104b0: 028a0a57 vadd.vv v20,v8,v20 104b4: 41f282b3 sub
> t0,t0,t6 104b8: 002f9893 slli a7,t6,0x2 104bc: 9346 add t1,t1,a7 104be:
> fe0295e3 bnez t0,104a8 <loop> 104c2: 012f7057 vsetvli zero,t5,e32,m4,tu,mu,d1
> .....
> 
> If $t0 is given with the value, e.g. 68.
> <loop> is expected to process 32 elements in each iteration.
> That's it, the env->vl after vsetvli at 0x104a8 in each iteration would be:
> 1st iteration: 32 (remaining elements to be processed: 68 - 32 = 36)
> 2nd iteration: 32 (remaining elements to be processed: 36 - 32 = 4)
> 3rd iteration: 4 (remaining elements to be processed: 4 - 4 = 0, will leave
> <loop> after 0x104be)
> 
> vadd.vv at 0x104b0 is implemented with gvec for acceleration:
> 
> if (a->vm && s->vl_eq_vlmax) {
>     gvec_fn(s->sew, vreg_ofs(s, a->rd),
>             vreg_ofs(s, a->rs2), vreg_ofs(s, a->rs1),
>             MAXSZ(s), MAXSZ(s));
> } else {
>     uint32_t data = 0;
> 
>     data = FIELD_DP32(data, VDATA, VM, a->vm);
>     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
>     tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
>                        vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
>                        cpu_env, 0, s->vlen / 8, data, fn);
> }
> 
> gvec function is used when a->vm and s->vl_eq_vlmax are both true.
> However, s->vl_eq_vlmax, for the above case, is only true in 1st and 2nd
> iterations.
> In third iteration, env->vl is 4 which is not equal to vlmax = 32.
> But as the TB where vadd.vv resides are already linked with vsetvli's TB,
> it won't be retranslated and still use the same gvec function in the third
> iteration.
> The total elemented being proceeded would be: 32 + 32 + 32 = 96, instead of 68.
> 
> I'm wondering under such conditions, is it still correct to use gen_goto_tb() here?
> Or we should use lookup_and_goto_ptr() as in trans_vsetvl() to not link the TBs.

You're correct -- because of vl_eq_vlmax we can't use goto_tb when using a
variable input.

It would be possible when using xN,x0 for VLMAX, or x0,x0 for reuse of the
current vl, but I doubt it's worth special-casing that.

I wonder if the goto_tb conversation happened before we introduced vl_eq_vlmax
and forgot to re-evaluate, or if I just missed that in the first place.
Anyway, thanks for finding this.


r~

