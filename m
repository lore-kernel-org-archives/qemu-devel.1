Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9104DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5722D20842
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/bflV0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5722D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18EJ-0002TW-La
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k18Cz-0000Ru-1I
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:02:53 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:40561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k18Cx-0002cY-2E
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:02:52 -0400
Received: by mail-pj1-x1030.google.com with SMTP id t15so4437660pjq.5
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 06:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=K4d2aOJKk6Ll04KZGZoQftP8vTqPy7vZDuRH8215P1w=;
 b=i/bflV0DeUv5K2ha248pJYpK/A8f154R+X1Bfc6NuG6zo2/IlxhXQB52ATwL0I9cpr
 QqVc0EUKo+piGhvD2hjjOpPkurCdzT0Iw1B90+XZdOBzTVQEExTg7HwDXUDcOiu3AK1U
 0g7QyZ/Lz/4Xbm0izPMifAh95v+M4LCz53Tu3EvGF06mAfnYwXZSRU8DRNkOw63ChQS3
 Xq0T8UHZTtzLZ1MAmHxYHzFrRUVLLmthmrGYGLGHjGf8sT4i9B1BwrdxItbfS/PurbOl
 AycKKRn/iSE3PIqpRIU6xeBTwIwR6DN/YWF/mOHqglJ2vqnXo2M4JcuhtZBnOtdLHMlx
 ksVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K4d2aOJKk6Ll04KZGZoQftP8vTqPy7vZDuRH8215P1w=;
 b=rcn39+e7/6yGKj6Gjcsv458aSJ0a4AUyesSu76CEjAyF1npuHnUIe2krQdsQTagJyV
 JxBWBPsDwki/qu3fmUca33tmSWCYiiNWEXs++cjH85LIxFp+pCAbfWU2zHrFj6bcODGc
 g8kgHjeeqoLKGjiYNolZjmXNFxzpZ41CXrnPS52tEiTMTrXPPJ2HdFZTZF8SjfKJlGmM
 zusj2RMTGM7bxkslsulhraXoEEmDD7Xy/J/UlLc9WwKQC/XUqzOlgd3ylyYmL96gmu8U
 9eqEVLb80zzCBv+K8+0GdD4LezkKCKueBDBS3q9O+oWOlrWjrNAfH1SfFTEsvfcdt9lc
 Tx/Q==
X-Gm-Message-State: AOAM533SnU9UfEbenU7pN6i3ovRnLaloQP2B1J9HlOtFo6TkaLPoxzis
 ApOJA1hUHAZLwk7yJKkCxKC1Lamuvtc=
X-Google-Smtp-Source: ABdhPJyMyncnBvCURuro4TA36QA1DN4rVZV83S5hYelXvqOKzhVmtCXuUhXrWw/2Oju7+02v05Bfmg==
X-Received: by 2002:aa7:9705:: with SMTP id a5mr3249895pfg.3.1596114169696;
 Thu, 30 Jul 2020 06:02:49 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id io3sm5480076pjb.22.2020.07.30.06.02.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 06:02:49 -0700 (PDT)
Subject: Re: [RFC v2 31/76] target/riscv: rvv-0.9: floating-point classify
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-32-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e1181608-41f2-4f00-4c1f-b8f2aad0e0c9@linaro.org>
Date: Thu, 30 Jul 2020 06:02:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-32-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn32.decode | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

