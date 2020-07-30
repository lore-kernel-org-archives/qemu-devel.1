Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B63C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 21:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901352083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 21:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mlVmSy16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901352083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1G3x-0004a4-QJ
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 17:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1G2m-0003w4-10
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 17:24:52 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:40375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1G2k-0003TM-92
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 17:24:51 -0400
Received: by mail-pj1-x1034.google.com with SMTP id t15so5753937pjq.5
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mahhTW79vy6eiZRLeA9Zm11KUu30a8WlXdatRqFwIQM=;
 b=mlVmSy16dihlambeJrsetB8y0mWmZtwAt1tw7XzMma4GzuYf4cj9vEXNusuprpvqC6
 ZPmBKILfac4GTMyi4QorT0gAZaYv357MtUJkG1shv/d89MTW5WgMtEmc5HnP7NzUygaA
 ON0nFNQxct/YRN7VjG/6TPc+AzCCyT3cZFXnMcuAHiN8oSILb42sGyXoRQruYz4Jfy2a
 D+V2nH/4kEGj0Vcx+Vt614vGV5E7jHNXt35s8FZuOW9xv0aD9l01pUHRCwM/k/WA6EpI
 03XRIYE2TSS44V+j1ZZNly0jdZgPCroqbviULKE51c/pk0TLi3xkRTvtFmxf8hpckMdg
 3vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mahhTW79vy6eiZRLeA9Zm11KUu30a8WlXdatRqFwIQM=;
 b=kiG4WfPZrdItvYbpy7bnb/3Dwi1gOZ2M1pdtKsuHORWPHcH9zQF1YmcnSHXf9tUr1d
 YleC6ONvB6v497ad6xZQpfSmbG+kawl6z0Mz6QIIRuhvAiFOYnGaorKpiCJBVTIQcgiv
 SgN/VkftYWVSJRejLLuUqbHDcBLPZ18uN3GVc09J5kKSNcLQqo29/itEsX+l4Xfxzq4x
 XAJwKsYke2yOYo+WNGAROFDKYqYUxuUdsP/7/KmCCAF9CU9G4+3MQiCJuZ6RY8sb21Rx
 O0XL61LQKxkJyoBsaq+SXKEj7R0y9DRDpfBZav2MDYLbvJHRHB6Iw1/hqL1bEzG/Pcg+
 l7rQ==
X-Gm-Message-State: AOAM532sA0FRoVPh01xlS3m7lRd+Pa+7WQptvkLS0sPWvPl45b3YkmsO
 xKhNNkIzd0i8Be2MGvCxfIOkfw==
X-Google-Smtp-Source: ABdhPJzeYZIa/uGxeXkEsTDx2R1UuSYdRnm/wfAAyw6fyr47vhHfo4Q0cvyG7e+Kj/RjwYiQD+ByjA==
X-Received: by 2002:a62:f905:: with SMTP id o5mr871254pfh.244.1596144288552;
 Thu, 30 Jul 2020 14:24:48 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm8431382pgg.72.2020.07.30.14.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 14:24:47 -0700 (PDT)
Subject: Re: [RFC v2 50/76] target/riscv: rvv-0.9: single-width saturating add
 and subtract instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-51-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a9b14055-1e84-e8da-6901-4e3e863e121d@linaro.org>
Date: Thu, 30 Jul 2020 14:24:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-51-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
> Sign-extend vsaddu.vi immediate value.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 956ee90745..3018489536 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2374,7 +2374,7 @@ GEN_OPIVX_TRANS(vsaddu_vx,  opivx_check)
>  GEN_OPIVX_TRANS(vsadd_vx,  opivx_check)
>  GEN_OPIVX_TRANS(vssubu_vx,  opivx_check)
>  GEN_OPIVX_TRANS(vssub_vx,  opivx_check)
> -GEN_OPIVI_TRANS(vsaddu_vi, IMM_ZX, vsaddu_vx, opivx_check)
> +GEN_OPIVI_TRANS(vsaddu_vi, IMM_SX, vsaddu_vx, opivx_check)
>  GEN_OPIVI_TRANS(vsadd_vi, IMM_SX, vsadd_vx, opivx_check)
>  
>  /* Vector Single-Width Averaging Add and Subtract */
> 

This isn't what spike does.

The manual could really stand to be more specific here...


r~

