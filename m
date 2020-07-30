Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E29C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 21:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A346E2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 21:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojgbCtvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A346E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1G9n-0006WQ-VI
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 17:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1G8m-0005oY-DJ
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 17:31:04 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:55734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1G8j-0004LX-IH
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 17:31:04 -0400
Received: by mail-pj1-x1033.google.com with SMTP id k1so5351225pjt.5
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 14:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=npVek7O1dJZxOapEcvfnyjIKEMfhuh3rK53u6GcV0Ps=;
 b=ojgbCtvY7H7pIZf6blHwcf/aL1ny+eZyxxqmMUaOQon1HQoUeR3l1eQdF5eTDrmLH/
 UF0R6PfViJnLa0YaF4pdKgJT1T/DKPbULV2ElQAy1ROGx4rQ0DvWTGSw2yqDU/VP2pwV
 dt9CqJ7EUZfyaPXdBD0+67KkwcAqN7eLUOzPOfwdch2UlacRT8Ajioy/IfivNbkciVKW
 1v7sQiRhKY+v11TerSLtt9APwTtIJEEKjJkDA988j9ZScfC9R1uJCSUhD3z6VK6kDn+B
 YgpQKwgURFJ88rUPeN/LEzaTkPYDSDqaigBEtHm6erybkdk6Upsx1FeMrjECStMUCHWc
 TBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=npVek7O1dJZxOapEcvfnyjIKEMfhuh3rK53u6GcV0Ps=;
 b=VyU4UG0nyltsXdruKAwOO+mOfQt+Om1N06zSVGx2sBWcpgZY/YYregh6KRUa2Z9JPF
 Mu93EzPYuP+jDADG59bGBCFGFaBn/7e7rVIYS2zz9Rb1/XDp/dBWqQtMYP44HWNAdBFN
 ZzShBG2y/EoVGzMg6e7PWTF9LQ31w2LfdjBRws8HCyDDvefi0aePvojGscrnEgtsxsIc
 MwmQyUHJVGf/0aPTZRqjQz3+ESlyT6SWbO+qQOeMBXJA5YyJgUaFCvJn4sRoEU/OlU7m
 yAdyEK/pI8HbpTToQB+zRlg2O4dbAFwBUC9aaLLRtU67iDN4UA2SqVd2x+XO9LByfdt8
 jcig==
X-Gm-Message-State: AOAM532JhmRdGY7nDRpJDfPw2OurJAiHVCeRmEtATN+iGS3li514t6Ql
 XBaS1DL6xf8w1ZJ2N0MQwLCpqQ==
X-Google-Smtp-Source: ABdhPJy8pDk4kyrbyX4HX2SHtOdI66gCY7hNXk6ltpkwkKzSjowFKPEhLQdF1kLkg2vKODlMG6k0Fg==
X-Received: by 2002:a17:90b:4a44:: with SMTP id
 lb4mr1004244pjb.160.1596144659890; 
 Thu, 30 Jul 2020 14:30:59 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x136sm7038047pfc.28.2020.07.30.14.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 14:30:59 -0700 (PDT)
Subject: Re: [RFC v2 51/76] target/riscv: rvv-0.9: integer comparison
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-52-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ee0c662c-d627-70c5-187d-1eb08081e700@linaro.org>
Date: Thu, 30 Jul 2020 14:30:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-52-frank.chang@sifive.com>
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
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Sign-extend vmselu.vi and vmsgtu.vi immediate values.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c |  4 +-
>  target/riscv/vector_helper.c            | 86 +++++++++++++------------
>  2 files changed, 48 insertions(+), 42 deletions(-)

FWIW, not what spike does, but this time at least the manual *does* say the
immediate is sign-extended.

> +    if (vta == 1) {                                              \
> +        for (; i < vlmax; i++) {                                 \
> +            vext_set_elem_mask(vd, i, 1);                        \
> +        }                                                        \
> +    }                                                            \

This is wrong, but I guess we already talked about vta...


r~

