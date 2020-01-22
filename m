Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75EFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835142253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghmlxeaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835142253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuBmN-0006T4-Oa
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 03:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuBla-00061w-Un
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:53:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuBlZ-0002e3-L8
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:53:38 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:34631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuBlZ-0002cf-EO
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:53:37 -0500
Received: by mail-pj1-x1043.google.com with SMTP id s94so1878455pjc.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 00:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fxvInQhLwgQsSRDv0TQJGl7JNZlCjysHEQDi1SvkAl8=;
 b=ghmlxeaFjR/bjygvzMNLkTQCeUOxP4tBHxX3FM9feKCiFtj6bueAL66Mmy5WOb+CC+
 KxIC7jirLib2ab8dopRDOt4kGeDcTDRAJ4Bd5Z0IYfV2O4i+uV9Hclwm/nM1LrooX0uF
 Oeg8N9mtwmTCUjsruKqgpaFU0cvLWrt8Z1AZeo+DF7zWCHNSpbnst7uZF44rqIA7tdvu
 ZKyQwnzAmfX709nE0/b2D0MRbNugr16G4l++8wCNHEXS0ROHwcNAndKJm8Vx07u/MsPQ
 TZ+uwsZfcYNTjA1mjjEOZ3YNQFrXgwZupCWBgwvrjnzYe5G/WDuWk/xc5uYSQAeoZLju
 D8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fxvInQhLwgQsSRDv0TQJGl7JNZlCjysHEQDi1SvkAl8=;
 b=CNTOrJgneRVAZSiwFgii7Nz8zc4hX1SDv20eAAn/IwlbeszlhgqVRKzPtF9RR11jBV
 L+WXDC1I+lVzGKM4zjaVecVewUbi0kXloXBqVIf7A5t7zgYF8xE0n92v3crsqyHsU+M+
 FEorPwrU9eKmjAChnVgkY4Pcbu7HBYOQK/5F0wiJX8lYbK8NBrqPPFze13sE9z2fNNXD
 jVRkz7GR9h/O/ONrlbmeiHPgZQUO+6GoxD+RyjLAjbBNgtezmGyg1p1iNS89iGCk8z8x
 7C8ft353tDf0Tn+ZqrUkADHumdf7rZ0CjPMTFOQ4tEQxsp7DB/H1KjfGs+q23Skpuf+t
 0cuw==
X-Gm-Message-State: APjAAAWeZe58bHaVN+EOaRUvwCmUshZdFdSVbk1Cn7VLNjuNe17E3dy3
 mNeI7UcVBft1FhOqOm7zvFIihw==
X-Google-Smtp-Source: APXvYqxR2cjcqVIjUPTyCkQiF6lchqOuqGUqcbF2J56lGRt32Dram4iKq1ptjdxVp9fmjsJbSbAXnQ==
X-Received: by 2002:a17:902:d205:: with SMTP id
 t5mr9838891ply.138.1579683212628; 
 Wed, 22 Jan 2020 00:53:32 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id y14sm45642908pfe.147.2020.01.22.00.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 00:53:31 -0800 (PST)
Subject: Re: [PATCH] riscv: Format Rd of FMV.W.X with NoN-boxing
To: Ian Jiang <ianjiang.ict@gmail.com>, qemu-devel@nongnu.org
References: <20200122072448.18510-1-ianjiang.ict@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b9084f13-0836-7f74-a870-608bf3f8f6a9@linaro.org>
Date: Tue, 21 Jan 2020 22:53:27 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122072448.18510-1-ianjiang.ict@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 9:24 PM, Ian Jiang wrote:
> For FMV.W.X that moves the lower 32 bits of an integer register to a
> floating-point register, Rd should encoded with NoN-boxing scheme.
> Note: This applies to RV64 only.
> 
> Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
> ---
>  target/riscv/insn_trans/trans_rvf.inc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
> index 172dbfa919..62b7a36567 100644
> --- a/target/riscv/insn_trans/trans_rvf.inc.c
> +++ b/target/riscv/insn_trans/trans_rvf.inc.c
> @@ -368,6 +368,7 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
>  
>  #if defined(TARGET_RISCV64)
>      tcg_gen_mov_i64(cpu_fpr[a->rd], t0);
> +    tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd], 0xffffffff00000000ULL);
>  #else
>      tcg_gen_extu_i32_i64(cpu_fpr[a->rd], t0);
>  #endif
> 

This doesn't look right.  There's nothing in the spec that says the nan-boxing
is restricted to rv64.  NaN-boxing is all about FLEN, not XLEN.


r~

