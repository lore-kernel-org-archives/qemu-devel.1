Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE0BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 21:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBB720829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 21:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0mAg1cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBB720829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1FyZ-0001xf-Ex
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 17:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1Fxd-0001TO-IJ
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 17:19:33 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:45759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1Fxb-0002sI-0M
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 17:19:33 -0400
Received: by mail-pl1-x62b.google.com with SMTP id bh1so2251472plb.12
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=23r4fX3J/weMbscRcBh61GGNv2dX/n/E8WdGFG//fyo=;
 b=Z0mAg1cc0bS+vq1NyJLhFRClQg4aS2YAeFsOXHZO1VDPj/iktToRr9DlLeacVmJ2m6
 n/lXX6wY+2kXIESo1UOkF8jf4lj/RSqgTgsW2qlAP82HcGeey0QlbYR9BpbakP+IupLw
 N8qmCUbeOeZ1/nNOYC5nMlNPrwv+uQ3mAYDnZbJNZB4CCOsVkLLLBSlC/uvHGdxUeL0q
 XlSlFYtUW4mYT7a+z1/kyQeu26LX3XSvHp746euoXwtT/KMBz7DyzJSvPxpYCJ+0GCJp
 H8SncEBjG8daifR+C9a205kxFi/7LjiNq+PSbZw0vftkcwT6O0gS+pAsb5utqbAf4B/j
 5+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=23r4fX3J/weMbscRcBh61GGNv2dX/n/E8WdGFG//fyo=;
 b=mfyc/CU2ilHa5cg6Ol+RUTEuzPvwEB54HB6QtlBjr++Q9U3zn290GKLf16jFY04LMz
 4RZ390SFSs4YsZfV1D2zUWTY4kWkTB32veKXB2Nz+ExEybtaDnIHX4pceMreuLY8VQ+p
 o9Lzepwm31Kr3rpOGQ3ioDUbTajdVqQki4t1LYFZ8vD3MPVZmYqUWciw5qByFJ4J746w
 Ms01IH6s20ybMGw/HEnXHeBkVSv76s9XGQbIEvEShXWUA21RNgOsX6WpkXoOAYbAY/iD
 aVZrjxIBpSrtXeIcBGvb45wMLx7oyEhdZdp+6sr5e7568QCdsdkaFuvaY4DLS+a4rqnK
 WN2g==
X-Gm-Message-State: AOAM5322NtilqGgoox4hKGjmfSM0uwN7hTmTevsJ4HoR2LSRLd81lvyU
 PUn/Nw8Vl32LP7Y4ms1CEsY+XQ==
X-Google-Smtp-Source: ABdhPJxebWj5DMiCcwbHsnGAH6daIdP1ryWv+AdO83cJw/TlNFcsYHMIJIQ6KdJic6EedoVjoB90OQ==
X-Received: by 2002:a17:90b:2350:: with SMTP id
 ms16mr994415pjb.127.1596143969277; 
 Thu, 30 Jul 2020 14:19:29 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id cv3sm6674307pjb.45.2020.07.30.14.19.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 14:19:28 -0700 (PDT)
Subject: Re: [RFC v2 49/76] target/riscv: rvv-0.9: quad-widening integer
 multiply-add instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-50-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3d2e0fb3-f616-7e4f-efd5-0f607644d5eb@linaro.org>
Date: Thu, 30 Jul 2020 14:19:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-50-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
> From: Frank Chang <frank.chang@sifive.com>
> 
> Add the following instructions:
> 
> * vqmaccu.vv
> * vqmaccu.vx
> * vqmacc.vv
> * vqmacc.vx
> * vqmaccsu.vv
> * vqmaccsu.vx
> * vqmaccus.vx
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/helper.h                   |  15 ++++
>  target/riscv/insn32.decode              |   7 ++
>  target/riscv/insn_trans/trans_rvv.inc.c | 101 ++++++++++++++++++++++++
>  target/riscv/vector_helper.c            |  40 ++++++++++
>  4 files changed, 163 insertions(+)

Looks ok.  I presume you'll add the Zvqmac test now that's in the draft?


r~

