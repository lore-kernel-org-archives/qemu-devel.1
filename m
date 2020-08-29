Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289B2C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75C120774
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k6W3/pCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75C120774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC792-0008N0-4T
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 16:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC78M-0007sZ-9p
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:07:30 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:34236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC78J-0006K9-RP
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:07:29 -0400
Received: by mail-pf1-x429.google.com with SMTP id g207so2422363pfb.1
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3nmGwSqBhm6HCgLsxw54ultec1tWk10IPwUoHSfRS58=;
 b=k6W3/pCb4da32oYFo4R46oLpVqe0MIBVHkjAqVhcHtq/0Me5vw8xbrE+C4JVP26q3a
 l/3HdlWFn8pkpLTiJLXQk0xQowUGaGTWCRk6AWeIuSIEqMs3EkXEyrqmCkCgpTmeLOXE
 jtLEEI840hfb0P/k7Edczg4ZM5xVQ+oODF2tiQ0CuIy5j1WB71V+aXNGRHj539N639pW
 bom4h87xSEqRt5f2RwgR1Lf+95ulr3vWDXJBewBcgQs9B1Fk6FrdVL1PiWsxIA58hyzw
 O5DNXCjHoEcfJG9BRheG+BddiM4ddmTbm1pyORvEnGkIW6yulN2lTl1EQxva9Fy1nNnY
 0mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3nmGwSqBhm6HCgLsxw54ultec1tWk10IPwUoHSfRS58=;
 b=dCAqGKqnrkSA1nZTfVqu0yRMtuOBev56HVW6dqO6fVP/JennQI+Bmx5WycWW3oPKni
 HttG/U7x0sQJJuv39/x1LK4vt2bRBVgMimJI6D41EMWBjxGLDlzA3nouR1vB8Br71ucE
 BuL/DQV213+OPXNNnYX/rUm2J5d+cVE5Cm0XIgHp279eldfYDBFI4cJiCoL5lVtxeIi5
 zpothl0bDgCvZeLO8bzoqiYgguT84EpiC6B2bELePjcwhPMm1CEWgfDdtzmYFaaEIJ5Q
 B26Oy68BdCcKXICx8PJFcX3XgRDhOrkiZbwqqBhUuMhCGlZbIGnypP74UniwQX2zLJ1C
 fPSA==
X-Gm-Message-State: AOAM532LL+DbF6Sg4Xo2FVD5UecgKvubCO+4VNO6sCBLa1te9m9Tv6mW
 YLp/DE08+C8n/5KMiw0ClLpULw==
X-Google-Smtp-Source: ABdhPJxGSUPo2z8WteXNO69qJrEoEhpCug2ZGLgGaBdKK/wzI6usAj9NncdApXBZRsQjCLmFXLVbdw==
X-Received: by 2002:aa7:9a4c:: with SMTP id x12mr3999222pfj.307.1598731646141; 
 Sat, 29 Aug 2020 13:07:26 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id o23sm3348373pgm.18.2020.08.29.13.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 13:07:25 -0700 (PDT)
Subject: Re: [RFC v4 37/70] target/riscv: rvv-1.0: floating-point scalar move
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-38-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fa016ba8-faa0-2e34-5d5e-e655936707f2@linaro.org>
Date: Sat, 29 Aug 2020 13:07:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-38-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
> From: Frank Chang <frank.chang@sifive.com>
> 
> NaN-boxed the scalar floating-point register based on RVV 1.0's rules.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn32.decode              |  4 +--
>  target/riscv/insn_trans/trans_rvv.inc.c | 42 ++++++++++++++-----------
>  2 files changed, 25 insertions(+), 21 deletions(-)

Needs require_rvf(), as discussed vs the previous patch,

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

