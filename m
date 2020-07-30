Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C048C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C82920829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/5hqQCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C82920829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ExC-0007eF-Lt
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 16:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1Ewd-0007BS-Up
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:14:27 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:35465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1Ewc-0002AJ-E0
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:14:27 -0400
Received: by mail-pl1-x62e.google.com with SMTP id r4so4549917pls.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hDP41EIXtqqk2Gxlv4DCWmmd/E8gCRG3jNgLR2rWKV4=;
 b=Y/5hqQCLQLD8KndQ6BcsMM3rnCGS6W3jvzgwO+OSeNnPzLn0HNGYZTI85DpAu2YdnU
 H0dTAs3SzIuCBUx6IB/RH9RtilXFhWt//tzV9w7R0uPdbgqah1LN/cXkbwkJrVZDXTQj
 Hz0aAe/gKJvS5gQ8G/wEcZIeXFvzwt1siah2TXfBS3DylBNG8R7Fzd4EARKPT++NeU7+
 bDADSAQxVCGHFCO7CIcolxkqADpH+ffjI9QMaNxbd4208zU5A6NMF5jBRj4RXzJnepFE
 CmQULi/sGj37vPU3qEWiwjhQzm0T8NwzzOCLOb2wtoxoavuxtuGEYhbuK15GpNhvoxOj
 kDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hDP41EIXtqqk2Gxlv4DCWmmd/E8gCRG3jNgLR2rWKV4=;
 b=tnYd402X9eBADxRcBW0tJvrjBmyhYiJTJh87pDtJ9txrJ0yr8S+W+Y2G8ZwkxCEwWa
 3l93FybJsxjWlkmLOBvxvB9fdmNJihVXWBx8jTCt1hNeI8Tf9Xgo76bDCVLU2i6C3me3
 4r5kjrvhFfG5hcgw3H1Cxb96AD8LrRfICfdjBllzqDjPCTQSSbXpc9UHhKisUEssknfy
 UaLuGCFRBogXzr21fNr4VHMUup+uX5hWBOZIQYejxtwqvE6Lu5BZCnQc00eDnmzg5gLO
 8jNxjrcN9bzPLuqoEKZpDTWxVHUl4VT5HGFWW/h4wOrbl9lTjwTPRoRdAFta9gDhpyYQ
 U+fw==
X-Gm-Message-State: AOAM531EhnRZmtvwnc/bdu7x/EzKdFo3VSNeRLVlvhyDOFPSPqn5izEy
 C+HuK5dwXv0PdgVW/B9XIHvBzQ==
X-Google-Smtp-Source: ABdhPJyZoIfUAuBjvBI2Nvw+oAMOMabwKKKdkp/ogzxdQeqFyQMVZ3N2bQlblBmLdoM+YssI5bHBhQ==
X-Received: by 2002:a62:18cd:: with SMTP id 196mr591397pfy.253.1596140063661; 
 Thu, 30 Jul 2020 13:14:23 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t63sm1264523pgt.50.2020.07.30.13.14.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 13:14:22 -0700 (PDT)
Subject: Re: [RFC v2 42/76] target/riscv: rvv-0.9: whole register move
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-43-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e4f4fa51-dd54-dc63-61e9-1a4fe7ea60c0@linaro.org>
Date: Thu, 30 Jul 2020 13:14:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-43-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
> +        ((a->rd & ((LEN) - 1)) == 0) &&                   \

QEMU_IS_ALIGNED(a->rd, LEN)

> +            tcg_gen_gvec_mov(8, vreg_ofs(s, a->rd + i),   \
> +                             vreg_ofs(s, a->rs2 + i),     \
> +                             s->vlen / 8, s->vlen / 8);   \

The first argument should be MO_8 (= 0) not 8.
You should have seen assertion failures with this.

There should be no reason to loop on this -- one move should be enough:

    tcg_gen_gvec_mov(MO_8, vreg_ofs(s, a->rd),
                     vreg_ofs(s, a->rs2),
                     s->vlen / 8 * LEN, s->vlen / 8 * LEN);

If *that* asserts, because the length is too long or something, then I'll make
changes to tcg/tcg-op-gvec.c to make it work.


r~

