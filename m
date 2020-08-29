Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5B5C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 23:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7131D20825
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 23:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1pwgv+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7131D20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCAdl-0005iR-MX
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 19:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCAc7-0004JZ-DC
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 19:50:28 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:38245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCAc5-0003gt-Bt
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 19:50:27 -0400
Received: by mail-pg1-x52e.google.com with SMTP id l191so2272179pgd.5
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 16:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QOfMSXyS3q8pxkOv4O778P/4TaggW6qIpuGKPww5NUA=;
 b=C1pwgv+y+JZKeOiJoHO3FOJ2MRSkvmmpPs2f03Kuy6ZN9y8N35db+qQaX6Wo0yW2YM
 lnbZ1sKw2byXgs6U3hWV+YZRMizbexuis+8vahYt1qCSBRrlFSkRGdSrOC5hoidkCKbF
 LGBU8uhLgpc50IyTGehc2zj6trh2GHszzVdmMu7bfXPxt7Fod64mPn9BMAd5uCKc20LH
 burrhF6+Dac5oI3DKBgyEzaUxBnUzXM8XPL+7gMjIrTJJUU17lCoh5KuEk3/MwlLPsla
 IKzLumc0Te6A9MLhFZLbeHA2VmecBloOLTR4sw4AqAPZO0RhWspxukzb6fad/pfcZ6MR
 inpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QOfMSXyS3q8pxkOv4O778P/4TaggW6qIpuGKPww5NUA=;
 b=RaIsp1HQcq12oWtURwy5D30o2ESvg94wJrRBvJqMdcveisLkZZLsYVi+6M5satZz/b
 +y0BbWA96WbkH0/CrVGxClAc1tp3ELTgAxPAjhOiba8xASANeg6uPAE2wqLMwRAohIP5
 gArH3hdbL250FpjwotYgaiEQKsp/JA1Ev+TNNQOMFnH8Lfo5YBaHMpIJGoNcJuwNHEIP
 hmbXeG2QyX/ahHPCzblA9AvFaR7IS6UJQgrpcKO+3AZiM2gh03qYBTOixeAwmT6HIZrz
 ahRPXlF4PfJCZHmhMGRSyoNRXZEbKeEDQmlDwB6P2dH+XjAZ+VFC4dzY+sGHwkurlwCx
 teNg==
X-Gm-Message-State: AOAM530yGJf+DvweYcdr+rMVe3ZAhd20UWCMF6EqjQSXmYkapnjKIyUT
 D5pwANf9oQQn26i65TSvyRkpHQ==
X-Google-Smtp-Source: ABdhPJzmJBvVyDZZF9GUJUunJHeL5Dq1WgWcahRmDM0tT4HX3o490g3WuDrS3S/B5O3TbMRcZugYlg==
X-Received: by 2002:a65:6286:: with SMTP id f6mr3863358pgv.0.1598745023915;
 Sat, 29 Aug 2020 16:50:23 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d23sm3007445pjz.44.2020.08.29.16.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 16:50:23 -0700 (PDT)
Subject: Re: [RFC v4 56/70] target/riscv: rvv-1.0: widening floating-point
 reduction instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-57-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <98e9f405-8648-7e65-3703-32616fdbd609@linaro.org>
Date: Sat, 29 Aug 2020 16:50:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-57-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

