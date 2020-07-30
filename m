Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49708C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1193F2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNz6MCvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1193F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1FI3-0007wW-Cv
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 16:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1FHN-0007Ri-Ub
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:35:53 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:39515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1FHM-000555-BZ
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:35:53 -0400
Received: by mail-pl1-x636.google.com with SMTP id b9so15237251plx.6
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tdOF5l/+w6DNYPdIVSkYM+XGiTaa2xz0Lf8idG7aUTU=;
 b=UNz6MCvV9clgBJeQ36/nFmDUp/2/6qLFWfde8iQ9xqOPifG9mPphoSFNH0mtIfFcU1
 gLUl6Q3YYxq0CIj3hp4IZ/eDpEp30KxFwGSXApPSrVSEqQeD/cL31kvLZtqXReH45Fg5
 0IKqZ+Bm5NhBkOjFHVp119rG/dnwJtP39QzeLcfQx8UTcrbFd3ARnxELgASdQdmNCoV6
 hwkB6lKRD/qZ98PKdz4rw/cy4uwdBNFqOpSad3w8oUFsgSJDiibLekXKZjwMyz9iav+i
 Uq9cNofruQN7rwfxFZLg0RfadUG5dkowe0IiucknkuGbYMN2OvHiTdNS1xoaNqgfcLqV
 Ol8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tdOF5l/+w6DNYPdIVSkYM+XGiTaa2xz0Lf8idG7aUTU=;
 b=cfy72jqxI9QP/KQFgRKlrfcsXsBhxU63CcQgljcw6IfSF2fEU3Gv32H6EWW9PCxjTz
 Og8ioUag/UmTZRi950QlWcmzMh4PNzMOW7fo5j0qLtvp0bQbM0nHhsOtvxrSWrTU64vj
 6ZfXekwc4n8vsa93vV1d11QYDdawn2qLnVgNO1Zm7ND5PeMR6M9pAx59nehbLJF+KZLJ
 Iqrf6oaBC+xh+PDqM2BeLykiUbVYVImVX0cDeHvD/et83GFZnUq70bYU6SH5SqbbDPzb
 6XrcjgycD0Txfj+LWW5BEipcD1zU6+i9SwBfgfsUFiaq/kQuXHDheqjDMmhvEVziDPS6
 b2mA==
X-Gm-Message-State: AOAM530SdpKnaLW44NPaNxmKt1X1v+9t0/Ha2acOdXK6B4NdIYVB6B4p
 8ytyg5ajRFcVBHTOdVCHaRQ4Zw==
X-Google-Smtp-Source: ABdhPJztLqmPkLVMk3OoBPnS832fYtpaPUIE2c4FSVod/n7HuiyWJ7XJedmQyU1nIAAlk6aLtphqQQ==
X-Received: by 2002:a63:5a20:: with SMTP id o32mr635478pgb.15.1596141350461;
 Thu, 30 Jul 2020 13:35:50 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f89sm6938173pjg.5.2020.07.30.13.35.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 13:35:49 -0700 (PDT)
Subject: Re: [RFC v2 43/76] target/riscv: rvv-0.9: integer extension
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-44-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0b042afa-61e4-d6a4-7fbd-2c359026b8aa@linaro.org>
Date: Thu, 30 Jul 2020 13:35:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-44-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
> +    static gen_helper_gvec_3_ptr * const fns[6][4] = {
> +        {
> +            NULL, gen_helper_vzext_vf2_h,
> +            gen_helper_vzext_vf2_w, gen_helper_vzext_vf2_d
> +        },
> +        {
> +            NULL, NULL,
> +            gen_helper_vzext_vf4_w, gen_helper_vzext_vf4_d,
> +        },
> +        {
> +            NULL, NULL,
> +            NULL, gen_helper_vzext_vf8_d
> +        },
> +        {
> +            NULL, gen_helper_vsext_vf2_h,
> +            gen_helper_vsext_vf2_w, gen_helper_vsext_vf2_d
> +        },
> +        {
> +            NULL, NULL,
> +            gen_helper_vsext_vf4_w, gen_helper_vsext_vf4_d,
> +        },
> +        {
> +            NULL, NULL,
> +            NULL, gen_helper_vsext_vf8_d
> +        }
> +    };

I don't understand why there aren't more functions in this table.  As far as I
can see, the only NULLs should be at [*][0].


r~

